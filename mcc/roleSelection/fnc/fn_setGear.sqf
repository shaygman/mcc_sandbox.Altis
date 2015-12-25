//==================================================================MCC_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "MCC_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform
//==============================================================================================================================================================================
private ["_role","_select","_mag","_magazines","_muzzles","_ok","_wepItems","_image","_cfg","_side","_array","_cfgWeapon","_cfgName"];
disableSerialization;
_role 	= _this select 0;
_select	= _this select 1;

if (CP_classesIndex != _role) then {CP_playerUniforms =  nil; CP_weaponAttachments = []};
CP_classesIndex = _role;

_role = switch (_role) do {
			case 0: {"Officer"};
			case 1: {"AR"};
			case 2: {"Rifleman"};
			case 3: {"AT"};
			case 4: {"Corpsman"};
			case 5: {"Marksman"};
			case 6: {"Specialist"};
			case 7: {"Crew"};
			case 8: {"Pilot"};
			default {"Rifleman"};
		};
_side = tolower str side player;

if !(_side in ["east","west","guer"]) exitWith {systemChat "Player is not in any side"};

//get correct weapons Arrays
_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" >> toLower _role)) then {(missionconfigFile >> "MCC_loadouts" >> toLower _role)} else {(configFile >> "MCC_loadouts" >> toLower _role)};

//Primary weapon
CP_currentWeaponArray = [];
_array = [];
for "_i" from 0 to (count(_cfg >> _side >> "primary")-1) do {
	_cfgWeapon = ((_cfg >> _side >> "primary") select _i);
	if (isClass (_cfgWeapon)) then {
		_cfgName = configName _cfgWeapon;
		_array = [getNumber(_cfg >> _side >> "primary" >> _cfgName >> "unlockLevel"),
		          getText(_cfg >> _side >> "primary" >> _cfgName >> "cfgname"),
		          getArray(_cfg >> _side >> "primary" >> _cfgName >> "magazines")
		         ];

		CP_currentWeaponArray pushBack _array;
	};
};

//Secondary Weapon
CP_currentWeaponSecArray = [];
_array = [];
for "_i" from 0 to (count(_cfg >> _side >> "secondary")-1) do {
	_cfgWeapon = ((_cfg >> _side >> "secondary") select _i);
	if (isClass (_cfgWeapon)) then {
		_cfgName = configName _cfgWeapon;
		_array = [getNumber(_cfg >> _side >> "secondary" >> _cfgName >> "unlockLevel"),
		          getText(_cfg >> _side >> "secondary" >> _cfgName >> "cfgname"),
		          getArray(_cfg >> _side >> "secondary" >> _cfgName >> "magazines")
		         ];

		CP_currentWeaponSecArray pushBack _array;
	};
};

//Items
{
	_cfgWeapon = (_cfg >> _side >> format["items%1",_foreachindex+1]);
	missionNamespace setVariable [format["CP_currentItmes%1",_foreachindex+1],getArray(_cfgWeapon)];
} forEach [1,2,3];

//General Items
CP_currentGeneralItmes = getArray(_cfg >> _side >> "generalItems");

//Uniforms
CP_currentUniforms = [];
{
	_array = [];
	_cfgWeapon = (_cfg >> _side >> _x);
	CP_currentUniforms pushBack (getArray(_cfgWeapon));
} forEach ["nightVision","headgear","googles","vests","backpacks","uniforms"];


//Set playr level
CP_currentLevel = officerLevel select 0;

//Set player role
_image = CP_classesPic select (CP_classes find _role);

//Set Primary weapon
CP_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentWeapon") then {
	missionNamespace setVariable [format["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponArray select 0];
	CP_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player];
	CP_currentWeaponIndex = 0;
};

//Set Secondary weapon
CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentSecWeapon") then {
	missionNamespace setVariable [format["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponSecArray select 0];
	CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player];
	CP_currentSecWeaponIndex = 0;
};

//Set handgun
CP_currentHandguns = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentHandguns") then {
	missionNamespace setVariable [format["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player], CP_handguns select 0];
	CP_currentHandguns = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player];
	CP_currentHandgunsIndex = 0;
};

//Set Items1
CP_currentItems1 = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems1") then {
	missionNamespace setVariable [format["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player], CP_currentItmes1 select 0];
	CP_currentItems1 = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems1Index = 0;
};

//Set Items2
CP_currentItems2 = missionNamespace getVariable format ["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems2") then {
	missionNamespace setVariable [format["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player], CP_currentItmes2 select 0];
	CP_currentItems2 = missionNamespace getVariable format ["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems2Index = 0;
};

//Set Items3
CP_currentItems3 = missionNamespace getVariable format ["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems3") then {
	missionNamespace setVariable [format["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player], CP_currentItmes3 select 0];
	CP_currentItems3 = missionNamespace getVariable format ["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems3Index = 0;
};

//Set General Items
CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentGeneralItems") then {
	missionNamespace setVariable [format["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player], CP_currentGeneralItmes];
	CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player];
	CP_currentGeneralItems = 0;
};

player setvariable ["CP_role", _role, true];
player setvariable ["CP_roleImage", _image, true];
player setvariable ["CP_roleLevel", call compile format ["%1Level select 0",_role], true];

//Open subMenu if needed
if (_select == 1) then {[4] execVM MCC_path+"mcc\roleSelection\scripts\switchDialog.sqf"};			//open weapon menu
if (_select == 2) then {[5] execVM MCC_path+"mcc\roleSelection\scripts\switchDialog.sqf"};			//open uniform menu

if (isnil "CP_playerUniforms") then {
	CP_playerUniforms = [	((CP_currentUniforms select 0) select 0) select 1,
							((CP_currentUniforms select 1) select 0) select 1,
							((CP_currentUniforms select 2) select 0) select 1,
							((CP_currentUniforms select 3) select 0) select 1,
							((CP_currentUniforms select 4) select 0) select 1,
							((CP_currentUniforms select 5) select 0) select 1
						];
	};
[CP_classes select CP_classesIndex] call MCC_fnc_assignGear;

private ["_disp"];
_disp = uiNamespace getVariable "CP_GEARPANEL_IDD";
if (isnil "_disp") exitWith {};

if ((str (_disp displayCtrl 200) != "no control")) then {
	//Gear stats
	[_disp] call MCC_fnc_playerStats;
};
