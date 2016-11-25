/*==================================================================MCC_fnc_RSgearButtonClicked================================================================================
//Handles clicking on a gear button - call only from MCC RS dialog
	<IN>
		_this select 0:			STRING button type

	<OUT>
==============================================================================================================================================================================*/
private ["_type","_groups","_availableObjects","_alloweObjects","_playerLevel","_hight","_selectedWeapon","_role","_cfg","_levelFactor","_idc","_side","_xPos"];
disableSerialization;
playSound "click";

_type = param [0,"",["",[]]];
_availableObjects = [];
_playerLevel = missionNamespace getVariable ["CP_currentLevel",1];
_disp = ctrlParent (_this select 1);
_hight = 0.03* safezoneH;
_levelFactor = 0;
_selectedWeapon = "";
_role = "";
_weapon = "";

if (typeName _type == typeName []) then {
	_selectedWeapon = _type select 1;
	_type = _type select 0;
	_role = player getVariable ["CP_role",""];
	_side = str (player getVariable ["CP_side",playerSide]);

	if (_role == "" || _type == "" || _selectedWeapon == "") exitWith {};

	missionNamespace setVariable ["MCC_RSselectedWeapon",_selectedWeapon];
	_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" >> _role >> _side >> _selectedWeapon )) then {(missionconfigFile >> "MCC_loadouts" >> _role >> _side >>_selectedWeapon )} else {(configFile >> "MCC_loadouts" >> _role >> _side >> _selectedWeapon )};

	_weapon = switch (_selectedWeapon) do {
		    case "primary": {primaryWeapon player};
		    case "secondary": {secondaryWeapon player};
		    case "handgun": {handgunWeapon player};
		};

	//Attachment unlock level are relative to the weapon unlock level
	_levelFactor = getNumber (_cfg >> _weapon >> "unlockLevel");
};

if (_type == "") exitWith {};

switch (_type) do {
    case "primary": {
    	_availableObjects = CP_currentWeaponArray;
    };

    case "secondary": {
    	_availableObjects = CP_currentWeaponSecArray;
    };

    case "handgun": {
    	_availableObjects = CP_handguns;
    };

    case "items1": {
    	_availableObjects = CP_items1;
    };

    case "items2": {
    	_availableObjects = CP_items2;
    };

    case "items3": {
    	_availableObjects = CP_items3;
    };

    case "nightVision": {
    	_availableObjects = CP_currentUniforms select 0;
    };

    case "headgear": {
    	_availableObjects = CP_currentUniforms select 1;
    };

    case "googles": {
    	_availableObjects = CP_currentUniforms select 2;
    };

    case "vests": {
    	_availableObjects = CP_currentUniforms select 3;
    };

    case "backpacks": {
    	_availableObjects = CP_currentUniforms select 4;
    };

    case "uniforms": {
    	_availableObjects = CP_currentUniforms select 5;
    };

    case "scope": {
    	_availableObjects = getArray (_cfg >> _weapon >> "attachments1");
    };

    case "side": {
    	_availableObjects = getArray (_cfg >> _weapon >> "attachments3");
    };

    case "muzzle": {
    	_availableObjects = getArray (_cfg >> _weapon >> "attachments2");
    };

    case "bipod": {
    	_availableObjects = getArray (_cfg >> _weapon >> "attachments4");
    };

    case "insigna": {
		_availableObjects = CP_currentInsignas;
    };
};

_alloweObjects = [];
{
	if (_playerLevel >= (_x select 0)+_levelFactor || (missionNamespace getVariable ["MCC_rsAllWeapons",false])) then {
		_alloweObjects pushBack (_x select 1);
	};
} forEach _availableObjects;

//We are dealing with attachment
if (_weapon != "") then {
	if !(isNull (_disp displayCtrl 14000)) then {
		ctrlDelete (_disp displayCtrl 14000);
	};

	_idc = 14000;
	_xPos = 0.355 * safezoneW + safezoneX;
} else {
	//Delete old ctrl
	{
		if !(isNull (_disp displayCtrl _x)) then {
			ctrlDelete (_disp displayCtrl _x);
		};
	} forEach [12000,13000,14000];

	_idc = 12000;
	_xPos = 0.187 * safezoneW + safezoneX;
};

_ctrl = _disp ctrlCreate ["RscListbox",_idc];
_ctrl ctrlAddEventHandler ["LBSelChanged",format ["['%1',_this select 0, _this select 1] spawn MCC_fnc_RSItemSelected",_type]];
_ctrl ctrlSetPosition [_xPos, 0.17 * safezoneH + safezoneY, 0.13 * safezoneW, _hight* (count _alloweObjects)*2];
_ctrl ctrlCommit 0;
_ctrl = (_disp displayCtrl _idc);

ctrlSetFocus _ctrl;
lbClear _ctrl;

{
	_cfg = switch true do {
			    case (isclass(configfile >> "CfgMagazines" >> _x)): {
			    	(configfile >> "CfgMagazines" >> _x);
			    };

			    case (isclass(configfile >> "CfgWeapons" >> _x)): {
			    	(configfile >> "CfgWeapons" >> _x);
			    };

			    case (isclass(configfile >> "CfgGlasses" >> _x)): {
			    	(configfile >> "CfgGlasses" >> _x);
			    };

			    case (isclass(configfile >> "CfgVehicles" >> _x)): {
			    	(configfile >> "CfgVehicles" >> _x);
			    };

			    case (isclass(missionconfigfile >> "CfgUnitInsignia" >> _x)): {
			    	(missionconfigfile >> "CfgUnitInsignia" >> _x);
			    };

			    case (isclass(configfile >> "CfgUnitInsignia" >> _x)): {
			    	(configfile >> "CfgUnitInsignia" >> _x);
			    };

			    default {(configfile >> "CfgWeapons">> "")};
			};

	_displayname = getText(_cfg >> "displayName");
	if (_displayname == "") then {_displayname = "- None"};

	_pic = getText(_cfg >> "picture");

	//For insignas
	if (_pic == "") then {_pic =  getText(_cfg >> "texture")};

	_toolTip = (getText(_cfg >> "descriptionShort"));
	_toolTip = _toolTip splitstring "<>";

	//Get read of the <br/> thing
	for "_i" from 0 to (count _toolTip -1) do {if (_toolTip select _i == "br /") then {_toolTip set [_i," "]}};
	_index 	= _ctrl lbAdd _displayname;

	_ctrl lbSetTooltip [_index, _toolTip joinString ""];
	_ctrl lbSetPicture [_index, _pic];
	_ctrl lbSetData [_index, _x];
} forEach _alloweObjects;


MCC_fnc_RSWeaponAttachmentSelected = {
	private ["_array"];
	disableSerialization;

	params ["_type","_ctrl"];

	//Create buttons
	_array = [
				[["scope",_type],"Sights",format ["%1mcc\roleSelection\data\ui\itemoptic_ca.paa",MCC_path]],
				[["side",_type],"Rail",format ["%1mcc\roleSelection\data\ui\itemacc_ca.paa",MCC_path]],
				[["muzzle",_type],"Muzzle",format ["%1mcc\roleSelection\data\ui\itemmuzzle_ca.paa",MCC_path]],
				[["bipod",_type],"Bipod",format ["%1mcc\roleSelection\data\ui\itembipod_ca.paa",MCC_path]]
			 ];

	[_ctrl, 13000, ctrlIDC _ctrl, _array] call MCC_fnc_RSbuildGearButtons;

};

MCC_fnc_RSItemSelected = {
	private ["_array","_outfits"];
	disableSerialization;
	params ["_type","_ctrl","_index"];
	_outfits = ["nightVision","headgear","googles","vests","backpacks","uniforms","_data","_attachments","_role"];
	_attachments = ["scope","side","muzzle","bipod"];

	if (_index < 0) exitWith {};

	_data = _ctrl lbData _index;
	_role = player getVariable ["CP_role",""];

	if (!(isNull ((ctrlParent _ctrl) displayCtrl 14000)) && !(_type in _attachments)) then {
		ctrlDelete ((ctrlParent _ctrl) displayCtrl 14000);
		missionNamespace setVariable [format ["CP_%1weaponAttachments", (missionNamespace getVariable ["MCC_RSselectedWeapon",""])],["","","",""]];
	};

	//New insignia selected
	if (_type == "insigna") exitWith {
		 missionNamespace setVariable [format["CP_player%1Insigna_%2_%3",_role, getplayerUID player, side player],_data];
		[player,_data] call BIS_fnc_setUnitInsignia;
	};

	if (_type in _outfits) then {
		_uniforms = missionNamespace getVariable [format ["CP_player%1_Uniforms_%2_%3",_role,getplayerUID player,side player],[	((CP_currentUniforms select 0) select 0) select 1,((CP_currentUniforms select 1) select 0) select 1,((CP_currentUniforms select 2) select 0) select 1,((CP_currentUniforms select 3) select 0) select 1,((CP_currentUniforms select 4) select 0) select 1,((CP_currentUniforms select 5) select 0) select 1]];
		_uniforms set [_outfits find _type,_data];
		missionNamespace setVariable [format ["CP_player%1_Uniforms_%2_%3",_role,getplayerUID player,side player],_uniforms];
	} else {
		if (_type in _attachments) then {
			_arrayName = format["CP_player%1_%4_attachments_%2_%3",_role, getplayerUID player, side player,(missionNamespace getVariable ["MCC_RSselectedWeapon",""])];
			_array	= missionNamespace getVariable [_arrayName,["","","",""]];
			_array set [_attachments find _type, _data];
			 missionNamespace setVariable [format["CP_player%1_%4_attachments_%2_%3",_role, getplayerUID player, side player,(missionNamespace getVariable ["MCC_RSselectedWeapon",""])], _array];
		} else {

				switch (_type) do {
					case "primary":	{
						_array = CP_currentWeaponArray;
						 missionNamespace setVariable [format["CP_player%1_primary_attachments_%2_%3",_role, getplayerUID player, side player], ["","","",""]];
					};
					case "secondary":	{
						_array = CP_currentWeaponSecArray;
						 missionNamespace setVariable [format["CP_player%1_secondary_attachments_%2_%3",_role, getplayerUID player, side player], ["","","",""]];
					};
					case "handgun":	{
						_array = CP_handguns;
						 missionNamespace setVariable [format["CP_player%1_handgun_attachments_%2_%3",_role, getplayerUID player, side player], ["","","",""]];
					};
					case "items1":	{_array = CP_items1};
					case "items2":	{_array = CP_items2};
					case "items3":	{_array = CP_items3};
					default {[]};
				};

			missionNamespace setVariable [format ["CP_player%1_%4_%2_%3",_role, getplayerUID player,side player,_type], _array select _index];

			//Add weapon's attachments
			if (_type in ["primary","secondary","handgun"]) then {
				_null = [_type,_ctrl] spawn  MCC_fnc_RSWeaponAttachmentSelected;
			};
		};
	};

	_null = [_role,0] call MCC_fnc_setGear;

	//select weapon again
	switch (true) do {
	    case (_type == "secondary"): {
	    	if ((secondaryWeapon player != "") && (animationState player !="amovpercmstpsraswlnrdnon")) then {
	    		player playActionNow "SecondaryWeapon";
	    		player selectweapon secondaryWeapon player;
	    	};
	    };

	    case (_type == "handgun"): {
	    	if ((handgunWeapon player != "") && (animationState player !="amovpercmstpsraswpstdnon")) then {
	    		player playActionNow "HandGunOn";
	    		player selectweapon handgunWeapon player;
	    	};
	    };

	    case (_type == "primary"): {
	     	if (primaryWeapon player != "") then {
	     		player playActionNow "PrimaryWeapon";
	    		player selectweapon primaryWeapon player;
	    	};
	    };

	    case (_type in _outfits || _type in ["items1","items2","items3"]): {
	     	player switchmove "AidlPercMstpSlowWrflDnon_G03";
	    };
	};
};