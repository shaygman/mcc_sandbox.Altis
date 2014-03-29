//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_muzzles","_wepItems","_currentWeapon"];
_role = _this select 0;

//Remove weapons/items/goggles
removeAllWeapons player;
removeAllItems player;
removeGoggles player;
removeAllAssignedItems player;

// Remove NVGs
if("NVGoggles" in (assignedItems player)) then
{
player unassignItem "NVGoggles";
player removeItem "NVGoggles";
};

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Add NVG
if ((CP_playerUniforms select 0) != "") then {
	player additem (CP_playerUniforms select 0);
	player assignItem (CP_playerUniforms select 0);
	};
	
//Add headgear
if ((Headgear player) != "") then {removeHeadgear player};
if ((CP_playerUniforms select 1) != "") then {player addHeadgear (CP_playerUniforms select 1)};

//add goggles
if ((Goggles player) != "") then {removeGoggles player};
if ((CP_playerUniforms select 2) != "") then {player addGoggles (CP_playerUniforms select 2)};

//add vest
if ((vest player) != "") then {removeVest player};
if ((CP_playerUniforms select 3) != "") then {player addVest (CP_playerUniforms select 3)};

//add backpack
removeBackpack player;
if ((CP_playerUniforms select 4) != "") then {player addBackpack (CP_playerUniforms select 4)};

//add uniforms
if ((Uniform player) != "") then {removeUniform player};
if ((CP_playerUniforms select 5) != "") then {player addUniform (CP_playerUniforms select 5)};
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Primary Weapon
_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then {[_currentWeapon] call CP_fnc_addWeapon};

//Secondary weapon
_currentWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then {[_currentWeapon] call CP_fnc_addWeapon};

//Handguns
_currentWeapon = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then {[_currentWeapon] call CP_fnc_addWeapon};

//Items1
_currentWeapon = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then {[_currentWeapon] call CP_fnc_addWeapon};

//Items2
_currentWeapon = missionNamespace getVariable format ["CP_player%1Items2_%2_%3",_role, getplayerUID player, side player];
if(!isnil "_currentWeapon")then {[_currentWeapon] call CP_fnc_addItem};

//Items3
_currentWeapon = missionNamespace getVariable format ["CP_player%1Items3_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then {[_currentWeapon] call CP_fnc_addItem};


//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Add attachments
_wepItems = primaryWeaponItems player;
{
	if (_x != "") then {
		player removePrimaryWeaponItem _x;
		player removeItem _x;
		};
} foreach _wepItems;

{
	if (!isnil "_x") then
	{
		if (_x != "") then {player addPrimaryWeaponItem _x};
	};
} foreach CP_weaponAttachments;

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Add generic items
_currentWeapon = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role, getplayerUID player, side player];
if (!isnil "_currentWeapon") then 
{
	{
		[_x] call CP_fnc_addItem;
	} foreach _currentWeapon;
};

//Select Primary weapon
player selectweapon primaryweapon player;
player switchmove "AidlPercMstpSlowWrflDnon_G03";