//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_currentWeapon","_mag","_magazines","_muzzles"];
_role = _this select 0;

_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2",_role, getplayerUID player];

removeAllWeapons player;
removeAllItems player;

_magazines = (_currentWeapon select 2); 
for [{_i = 0},{_i < count _magazines},{_i = _i+2}] do 
	{
		_mag = _magazines select _i; 
		for [{_x = 0},{_x < (_magazines select (_i+1))},{_x = _x+1}] do 
			{
				if (isClass (configFile >> "CfgMagazines" >> _mag)) then {player addmagazine _mag};
				if (isClass (configFile >> "CfgWeapons" >> _mag)) then {player additem _mag};
				if (isClass (configFile >> "CfgGlasses" >> _mag)) then {player additem _mag};
			};
	};

player addWeapon (_currentWeapon select 1); 	
player selectWeapon (_currentWeapon select 1);
_muzzles = getArray(configFile>>"cfgWeapons" >> (_currentWeapon select 1) >> "muzzles");
player selectWeapon (_muzzles select 0);