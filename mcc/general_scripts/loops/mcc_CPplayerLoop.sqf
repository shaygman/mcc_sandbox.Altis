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
};

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","_this call MCC_fnc_mapDrawPlayersWPConsole"];

sleep 10; 
//Loop 
private ["_wpArray","_rating","_exp","_level","_role"]; 
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
			[] call CP_fnc_allowedDrivers;
			
			if (CP_saveGear) then
			{
				//Manage XP
				_rating = rating player;
				
				if (_rating != 0) then
				{
					if (CP_debug) then {player sidechat format ["rating add: %1", _rating]};
					
					while {isnil "_role"} do {_role = player getvariable "CP_role";}; 
					
					_exp = call compile format  ["%1Level select 1",_role]; 
								
					if (!isnil "_exp") then 
					{
						if (_exp < 0) then {_exp = 0};
						if (CP_debug) then {player sidechat format ["rating: %1", _exp]};
						_exp = (_exp + _rating);
						 
						_level =[floor(_exp/2000)+1 ,_exp];
						if (CP_debug) then {player sidechat format ["level: %1",_level]};
						
						missionNameSpace setVariable [format ["%1Level",_role], _level]; 
						[[format ["%1Level",_role], player, _level, "ARRAY"], "CP_fnc_setVariable", false, false] spawn BIS_fnc_MP;
					};
					
					if (_rating > 0) then 
					{
						player addRating (-1 * _rating);
					}
					else
					{
						player addRating _rating;
					};
				};
			};
		}; 
	};
	sleep 10;
};
