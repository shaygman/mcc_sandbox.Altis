//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_select","_currentWeapon","_mag","_magazines","_muzzles"];
_role 	= _this select 0;			
_select	= _this select 1; 
CP_classesIndex = _role;
switch (_role) do
	{
		case 0:	//Officer
		{ 
			if (side player == west) then {_currentWeapon = CP_officerWeaponWest};
			if (side player == east) then {_currentWeapon = CP_officerWeaponEast};
			if (side player == west) then {_currentWeapon = CP_officerWeaponGuer};
			
			CP_currentWeapon = missionNamespace getVariable format ["CP_playerOfficerWeapon_%1",getplayerUID player];
			if (isnil "CP_currentWeapon") then {														
				missionNamespace setVariable [format ["CP_playerOfficerWeapon_%1",getplayerUID player], _currentWeapon select 0];
				CP_currentWeapon = missionNamespace getVariable format ["CP_playerOfficerWeapon_%1",getplayerUID player];
				};
		};
	};

if (_select == 1) then {};	//open gear menu	
if (_select == 2) then {};	//open uniform menu	
removeAllWeapons player;
removeAllItems player;

player addWeapon (CP_currentWeapon select 1); 
