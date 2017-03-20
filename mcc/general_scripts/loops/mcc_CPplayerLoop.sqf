//Draw WP
MCC_fnc_mapDrawPlayersWPConsole =
{
	_map = _this select 0;
	if (MCC_ConsolePlayersCanSeeWPonMap && ("ItemGPS" in (assignedItems player) || "B_UavTerminal" in (assignedItems player) || "MCC_Console" in (assignedItems player))) then
	{
		_wpArray = waypoints (group player);
		if (count _wpArray > 0)then {
			private ["_wp","_wPos","_wType","_lastPos"];
			_lastPos = nil;
			_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");

			//Draw the current WP
			for [{_i= currentWaypoint (group player)},{_i < count _wpArray},{_i=_i+1}] do {
				_wp = (_wpArray select _i);
				_wPos  = waypointPosition _wp;
				if ((_wPos  distance [0,0,0]) > 50) then {
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
	if (missionNamespace getVariable ["MCC_groupMarkers",true]) then {
		private ["_groups","_texture","_blackList","_units","_iconSize","_iconText","_group","_textSize"];
		_groups	 = switch (side player) do
				{
					case west:			{CP_westGroups};
					case east:			{CP_eastGroups};
					default				{CP_guarGroups};
				};


		_blackList = [];
		{
			_group = _x;
			_units =if ((missionNamespace getVariable ["MCC_indevidualMarkers",false]) && (_group select 0) == group player) then {units (_group select 0)} else {[leader (_group select 0)]};
			_color = if (group player == (_group select 0)) then {[0,1,0,0.8]} else {[0,0,1,0.8]};

			{
				if !(vehicle _x in _blackList) then {

					if (_x == leader _x) then {
						_iconSize = 30;
						_iconText = _group select 1;
						_textSize = 0.06;
						_texture = if (vehicle _x == _x) then {gettext (configfile >> "CfgMarkers" >> "b_hq" >> "icon")} else {gettext (configfile >> "CfgVehicles" >> typeof vehicle _x >> "icon")};
					} else {
						_iconSize =18;
						_iconText = [name _x,0,8] call BIS_fnc_trimString;
						_textSize = 0.03;
						_texture = gettext (configfile >> "CfgVehicles" >> typeof vehicle _x >> "icon");
					};

					//In vehicle
					if (vehicle _x != _x) then {
						_blackList pushBack vehicle _x;
					};

					_map drawIcon [
						_texture,
						_color,
						position _x,
						_iconSize,
						_iconSize,
						direction _x,
						_iconText,
						0,
						_textSize,
						"PuristaBold",
						"Right"
					];
				};
			} forEach _units;
		} foreach _groups;
	};

	//Draw icons for UAV
	{
		if (vehicle _x == _x || _x == driver vehicle _x) then {
			_texture = gettext (configfile >> "CfgVehicles" >> typeof vehicle _x >> "icon");
			_color = (getNumber (configfile >> "CfgVehicles" >> typeof vehicle _x >> "side")) call BIS_fnc_sideColor;
			_map drawIcon [
							_texture,
							_color,
							position _x,
							18,
							18,
							direction _x,
							"",
							0,
							0.03,
							"PuristaBold",
							"Right"
						];
		};
	} forEach (missionNamespace getVariable [(format ["MCC_uavSpotted_%1", playerSide]),[]]) + allUnitsUAV;
};

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","_this call MCC_fnc_mapDrawPlayersWPConsole"];

//3D tag system 3DSpotting
0 spawn MCC_fnc_tagSystem;

sleep 10;
//Loop
private ["_wpArray","_rating","_exp","_level","_role","_oldLevel","_newLevel","_nextCheck","_time","_fnc_supplyBox","_vehicle"];
_nextCheck = time + 300;

_fnc_supplyBox = {
	private ["_crateClass","_type","_nearItems","_value","_text"];
	_crateClass = _this select 0;
	_type = _this select 1;
	_text = _this select 2;

	_nearItems = getPos player nearObjects [_crateClass, 15];
	if (count _nearItems == 0) exitWith {false};

	_box = _nearItems select 0;

	if !(isNull attachedTo _box) exitWith {false};

	_value = _box getVariable [_type,500];
	titleText [_text,"PLAIN DOWN"];
	titleFadeOut 1;
	_value = _value - 25;
	if (_value <= 0) then {deleteVehicle _box} else {_box setVariable [_type,_value,true]};
	true
};

while {true} do {
	if (alive player) then {
		missionNamespace setVariable ["MCC_save_Backpack",backPackItems player];
		missionNamespace setVariable ["MCC_save_primaryWeaponItems",primaryWeaponItems player];
		missionNamespace setVariable ["MCC_save_secondaryWeaponItems",secondaryWeaponItems player];
		missionNamespace setVariable ["MCC_save_handgunitems",handgunItems player];

		missionNamespace setVariable ["MCC_save_primaryWeapon",primaryWeapon player];
		missionNamespace setVariable ["MCC_save_secondaryWeapon",secondaryWeapon player];
		missionNamespace setVariable ["MCC_save_handgunWeapon",handgunWeapon player];
		missionNamespace setVariable ["MCC_save_magazines",magazines player];

		missionNamespace setVariable ["MCC_save_primaryWeaponMagazine",primaryWeaponMagazine player];
		missionNamespace setVariable ["MCC_save_secondaryWeaponMagazine",secondaryWeaponMagazine player];
		missionNamespace setVariable ["MCC_save_handgunMagazine",handgunMagazine player];

		//Repair/refuel from boxed all this ifs are to reduce unnecessary nearObjects - efficiency
		if (!MCC_isMode && vehicle player != player) then {
			_vehicle = vehicle player;
			if (speed _vehicle < 10 && player == leader _vehicle) then {

				if (fuel _vehicle <= 0.95) then {
					if (["CargoNet_01_barrels_F","fuelLeft","Refuling"] call _fnc_supplyBox) then {_vehicle setFuel ((fuel _vehicle + 0.05) min 1)};
				};
				if (getDammage _vehicle > 0) then {
					if (["CargoNet_01_box_F","supplyLeft","Repairing"] call _fnc_supplyBox) then {_vehicle setDamage ((getDammage _vehicle - 0.05) max 0)};
				};
			};
		};

		if (missionNamespace getVariable ["CP_activated",false]) then {
			//Add XP/Fame
			_null = [] spawn MCC_fnc_handleRating;

			//Check if allowed weapons
			if (missionNamespace getVariable ["MCC_rsEnableRoleWeapons",true]) then {
				[] call MCC_fnc_allowedWeapons
			};

			//Manage XP
			if (missionNamespace getvariable ["CP_gainXP",true]) then {
				//Gain XP from roles check every 10 minutes
				if (time > _nextCheck) then	{
					[] call MCC_fnc_gainXPfromRoles;
					_nextCheck = time + 300;
				};
			};
		};

		//Medic effects
		if (missionNamespace getvariable ["MCC_medicSystemEnabled",false]) then {
			[] call MCC_fnc_medicEffects;
		};
	};
	sleep 4;
};
