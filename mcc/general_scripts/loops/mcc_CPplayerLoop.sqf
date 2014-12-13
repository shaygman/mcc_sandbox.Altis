//Draw WP
MCC_fnc_mapDrawPlayersWPConsole =
{
	_map = _this select 0;
	if (MCC_ConsolePlayersCanSeeWPonMap && ("ItemGPS" in (assignedItems player) || "B_UavTerminal" in (assignedItems player) || "MCC_Console" in (assignedItems player))) then
	{
		_wpArray = waypoints (group player);
		if (count _wpArray > 0)then
		{
			private ["_wp","_wPos","_wType","_lastPos"];
			_lastPos = nil;
			_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");
			for [{_i= currentWaypoint (group player)},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
			{
				_wp = (_wpArray select _i);
				_wPos  = waypointPosition _wp;
				if ((_wPos  distance [0,0,0]) > 50) then
				{
					_wType = waypointType _wp;

					_map drawIcon [
						_texture,
						[0,0,1,1],
						_wPos,
						24,
						24,
						0,
						_wType,
						0,
						0.04,
						"PuristaBold",
						"center"
					];

					if (isnil "_lastPos") then {_lastPos = [(getpos player) select 0,(getpos player) select 1]};

					_map drawLine [
						_lastPos,
						_wPos,
						[0,0,1,1]
					];

					_lastPos = _wPos;
				};
			};
		};
	};

	//Custom Group Markers
	if (MCC_groupMarkers) then
	{
		private ["_groups","_texture"];
		_groups	 = switch (side player) do
				{
					case west:			{CP_westGroups};
					case east:			{CP_eastGroups};
					case resistance:	{CP_guarGroups};
					case civilian:		{CP_guarGroups};
					default				{CP_guarGroups};
				};

		_texture = gettext (configfile >> "CfgMarkers" >> "b_hq" >> "icon");

		{
			_map drawIcon [
						_texture,
						[0,0,1,1],
						getPos leader (_x select 0),
						28,
						28,
						0,
						(_x select 1),
						0,
						0.06,
						"PuristaBold"
					];
		} foreach _groups;
	};
};

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","_this call MCC_fnc_mapDrawPlayersWPConsole"];

sleep 10;
//Loop
private ["_wpArray","_rating","_exp","_level","_role","_oldLevel","_newLevel","_nextCheck","_time"];
_nextCheck = time + 300;

while {true} do
{
	if (alive player) then
	{
		MCC_save_Backpack = backPackItems player;
		MCC_save_primaryWeaponItems = primaryWeaponItems player;
		MCC_save_secondaryWeaponItems = secondaryWeaponItems player;
		MCC_save_handgunitems = handgunItems player;

		if (CP_activated) then
		{
			//Check if in vehicle
			[] call MCC_fnc_allowedDrivers;

			//Check if allowed weapons
			[] call MCC_fnc_allowedWeapons;

			//Manage XP
			if (CP_gainXP) then
			{
				//Gain XP from roles check every 10 minutes
				if (time > _nextCheck) then
				{
					[] call MCC_fnc_gainXPfromRoles;
					_nextCheck = time + 300;
				};

				//No more then 500 exp per sec
				_rating = rating player min 500;

				if (_rating > 0) then
				{
					if (CP_debug) then {systemchat format ["rating add: %1", _rating]};

					_role = player getvariable "CP_role";
					while {isnil "_role"} do {_role = player getvariable "CP_role";};

					_exp 	 = call compile format  ["%1Level select 1",_role];


					if (!isnil "_exp") then
					{
						if (_exp < 0) then {_exp = 0};
						if (CP_debug) then {systemchat format ["rating: %1", _exp]};

						_oldLevel = call compile format  ["%1Level select 0",_role];

						_exp = (_exp + _rating);
						_level =[floor(_exp/(CP_XPperLevel + _oldLevel*100))+1 ,_exp];

						_newLevel = _level select 0;

						 if (_oldLevel < _newLevel) then
						 {
							[_newLevel] call MCC_fnc_unlock;
							_oldLevel = _newLevel;
						 };

						if (CP_debug) then {systemchat format ["level: %1",_level]};

						missionNameSpace setVariable [format ["%1Level",_role], _level];
						[[format ["%1Level",_role], player, _level, "ARRAY"], "MCC_fnc_setVariable", false, false] spawn BIS_fnc_MP;
					};
				};

				//Mark it zero again
				player addRating (-1 * (rating player));
			};
		};

		//Delete Markers
		if (!isnil "MCC_PDAMarkers") then
		{
			_time = time;
			{
				if (time > (_x +300)) then
				{
					deletemarkerlocal (MCC_PDAMarkers select _foreachindex);
					MCC_PDAMarkers set [_foreachindex, -1];
					MCC_PDAMarkersTime set [_foreachindex, -1];
				};
			} foreach MCC_PDAMarkersTime;

			MCC_PDAMarkers = MCC_PDAMarkers - [-1];
			MCC_PDAMarkersTime = MCC_PDAMarkersTime - [-1];
		};

		//Medic effects
		if (missionNamespace getvariable ["MCC_medicSystemEnabled",false]) then
		{
			[] call MCC_fnc_medicEffects;
		};
	};
	sleep 2;
};
