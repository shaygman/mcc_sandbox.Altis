//==================================================================MCC_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select] call MCC_fnc_setGear;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform
// _unit: OBJECT the unit on which it will be effected - must be local
//================================================================================================================================================================
private ["_role","_select","_mag","_magazines","_muzzles","_ok","_wepItems","_image","_cfg","_side","_array","_cfgWeapon","_cfgName","_unit"];
disableSerialization;
_role 	= param [0,2,[0,""]];
_select	= param [1,0,[0]];
_unit = param [2,player];

if (typeName _role == typeName 0) then {
	//Set player role
	_image = [	MCC_path +"mcc\roleSelection\data\Officer.paa",
				MCC_path +"mcc\roleSelection\data\AR.paa",
				MCC_path +"mcc\roleSelection\data\Rifleman.paa",
				MCC_path +"mcc\roleSelection\data\AT.paa",
				MCC_path +"mcc\roleSelection\data\Corpsman.paa",
				MCC_path +"mcc\roleSelection\data\Marksman.paa",
				MCC_path +"mcc\roleSelection\data\Specialist.paa",
				MCC_path +"mcc\roleSelection\data\Crew.paa",
				MCC_path +"mcc\roleSelection\data\Pilot.paa"
			] select _role;

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
} else {
	_image = if (isClass (missionconfigFile >> "MCC_loadouts" >> _role)) then {getText(missionconfigFile >> "MCC_loadouts" >> _role >> "picture")} else {getText(configFile >> "MCC_loadouts" >> _role >> "picture")};
};

if (toLower (_unit getvariable ["CP_role","n/a"]) != toLower _role) then {CP_playerUniforms =  nil; CP_weaponAttachments = []};

_side = tolower str side _unit;

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

//Handguns
CP_handguns = [];
_array = [];
for "_i" from 0 to (count(_cfg >> _side >> "handgun")-1) do {
	_cfgWeapon = ((_cfg >> _side >> "handgun") select _i);
	if (isClass (_cfgWeapon)) then {
		_cfgName = configName _cfgWeapon;
		_array = [getNumber(_cfg >> _side >> "handgun" >> _cfgName >> "unlockLevel"),
		          getText(_cfg >> _side >> "handgun" >> _cfgName >> "cfgname"),
		          getArray(_cfg >> _side >> "handgun" >> _cfgName >> "magazines")
		         ];

		CP_handguns pushBack _array;
	};
};

//Items
{
	_cfgWeapon = (_cfg >> _side >> format["items%1",_foreachindex+1]);
	missionNamespace setVariable [format["CP_items%1",_foreachindex+1],getArray(_cfgWeapon)];
} forEach [1,2,3];

//General Items
CP_GeneralItems = getArray(_cfg >> _side >> "generalItems");

//Uniforms
CP_currentUniforms = [];
{
	_array = [];
	_cfgWeapon = (_cfg >> _side >> _x);
	CP_currentUniforms pushBack (getArray(_cfgWeapon));
} forEach ["nightVision","headgear","googles","vests","backpacks","uniforms"];

//Insignas
CP_currentInsignas =  getArray(_cfg >> _side >> "insigna");

//Set playr level
CP_currentLevel = call compile format ["%1Level select 0",_role];

//Set Primary weapon
CP_currentWeapon = missionNamespace getVariable format ["CP_player%1_primary_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentWeapon") then {
	missionNamespace setVariable [format["CP_player%1_primary_%2_%3",_role,getplayerUID _unit,side _unit], CP_currentWeaponArray select 0];
	CP_currentWeapon = missionNamespace getVariable format ["CP_player%1_primary_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set Secondary weapon
CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1_secondary_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentSecWeapon") then {
	missionNamespace setVariable [format["CP_player%1_secondary_%2_%3",_role,getplayerUID _unit,side _unit], CP_currentWeaponSecArray select 0];
	CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1_secondary_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set handgun
CP_currentHandguns = missionNamespace getVariable format ["CP_player%1_handgun_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentHandguns") then {
	missionNamespace setVariable [format["CP_player%1_handgun_%2_%3",_role,getplayerUID _unit,side _unit], CP_handguns select 0];
	CP_currentHandguns = missionNamespace getVariable format ["CP_player%1_handgun_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set Items1
CP_currentItems1 = missionNamespace getVariable format ["CP_player%1_items1_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentItems1") then {
	missionNamespace setVariable [format["CP_player%1_items1_%2_%3",_role,getplayerUID _unit,side _unit], CP_items1 select 0];
	CP_currentItems1 = missionNamespace getVariable format ["CP_player%1_items1_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set Items2
CP_currentItems2 = missionNamespace getVariable format ["CP_player%1_items2_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentItems2") then {
	missionNamespace setVariable [format["CP_player%1_items2_%2_%3",_role,getplayerUID _unit,side _unit], CP_items2 select 0];
	CP_currentItems2 = missionNamespace getVariable format ["CP_player%1_items2_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set Items3
CP_currentItems3 = missionNamespace getVariable format ["CP_player%1_items3_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentItems3") then {
	missionNamespace setVariable [format["CP_player%1_items3_%2_%3",_role,getplayerUID _unit,side _unit], CP_items3 select 0];
	CP_currentItems3 = missionNamespace getVariable format ["CP_player%1_items3_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set General Items
CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentGeneralItems") then {
	missionNamespace setVariable [format["CP_player%1GeneralItems_%2_%3",_role,getplayerUID _unit,side _unit], CP_GeneralItems];
	CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID _unit,side _unit];
};

//Set Inigna
CP_currentInsigna = missionNamespace getVariable format ["CP_player%1Insigna_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_currentInsigna") then {
	missionNamespace setVariable [format["CP_player%1Insigna_%2_%3",_role,getplayerUID _unit,side _unit], (CP_currentInsignas select 0) select 1];
	CP_currentInsigna = missionNamespace getVariable format ["CP_player%1Insigna_%2_%3",_role,getplayerUID _unit,side _unit];
};


_unit setvariable ["CP_role", _role, true];
_unit setvariable ["CP_roleImage", _image, true];
_unit setvariable ["CP_roleLevel", call compile format ["%1Level select 0",_role], true];

//Open subMenu if needed
if (_select == 1) then {[4] execVM MCC_path+"mcc\roleSelection\scripts\switchDialog.sqf"};			//open weapon menu
if (_select == 2) then {[5] execVM MCC_path+"mcc\roleSelection\scripts\switchDialog.sqf"};			//open uniform menu

CP_playerUniforms = missionNamespace getVariable format ["CP_player%1_Uniforms_%2_%3",_role,getplayerUID _unit,side _unit];
if (isnil "CP_playerUniforms") then {
	CP_playerUniforms = [	((CP_currentUniforms select 0) select 0) select 1,
							((CP_currentUniforms select 1) select 0) select 1,
							((CP_currentUniforms select 2) select 0) select 1,
							((CP_currentUniforms select 3) select 0) select 1,
							((CP_currentUniforms select 4) select 0) select 1,
							((CP_currentUniforms select 5) select 0) select 1
						];
	};
[_role] call MCC_fnc_assignGear;

private ["_disp","_magTypes","_cfg","_displayname","_pic","_index","_ctrl","_mag"];
_disp = uiNamespace getVariable "CP_GEARPANEL_IDD";
if (isnil "_disp") exitWith {};
[_disp] call MCC_fnc_playerStats;

/* -- We had it for some reason now i'm not sure why*/
//Magazines and cargo UI
if !(isNull (_disp displayCtrl 9874444)) then {
	_ctrl = (_disp displayCtrl 9874444);
	_magTypes = [];

	{
		if !(_x in _magTypes) then {_magTypes pushBack _x};
	} forEach (weapons _unit + items _unit + magazines _unit);

	lbClear _ctrl;
	{
		_mag = _x;

		_cfg = switch true do {
			    case (isclass(configfile >> "CfgMagazines" >> _mag)): {
			    	(configfile >> "CfgMagazines" >> _mag);
			    };

			    case (isclass(configfile >> "CfgWeapons" >> _mag)): {
			    	(configfile >> "CfgWeapons" >> _mag);
			    };

			    case (isclass(configfile >> "CfgGlasses" >> _mag)): {
			    	(configfile >> "CfgGlasses" >> _mag);
			    };

			    case (isclass(configfile >> "CfgVehicles" >> _mag)): {
			    	(configfile >> "CfgVehicles" >> _mag);
			    };

			    case (isclass(missionconfigfile >> "CfgUnitInsignia" >> _mag)): {
			    	(missionconfigfile >> "CfgUnitInsignia" >> _mag);
			    };

			    default {(configfile >> "CfgWeapons">> "")};
			};

		_displayname = getText(_cfg >> "displayName");
		_displayname = str({_x == _mag} count (weapons _unit + items _unit + magazines _unit))  + " X " + _displayname;

		_pic = getText(_cfg >> "picture");

		//For insignas
		if (_pic == "") then {_pic =  getText(_cfg >> "texture")};
		_index = _ctrl lbAdd _displayname;
		_ctrl lbSetPicture [_index, _pic];
	} forEach _magTypes;
};
