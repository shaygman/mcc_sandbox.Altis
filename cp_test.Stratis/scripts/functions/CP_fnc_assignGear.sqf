//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_muzzles"];
_role = _this select 0;

removeAllWeapons player;
removeAllItems player;

//Primary Weapon
_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role, getplayerUID player, side player];
[_currentWeapon] call CP_fnc_addWeapon;

//Secondary weapon
_currentWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role, getplayerUID player, side player];
[_currentWeapon] call CP_fnc_addWeapon;

//Handguns
_currentWeapon = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role, getplayerUID player, side player];
[_currentWeapon] call CP_fnc_addWeapon;

//Items1
_currentWeapon = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role, getplayerUID player, side player];
[_currentWeapon] call CP_fnc_addWeapon;
	
//Select Primary weapon
player selectweapon primaryweapon player;