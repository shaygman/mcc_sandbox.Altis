//==================================================================MCC_fnc_keyDown===============================================================================================
//Handle keydown/keyUp EH
// Example: ['keyup',_this] call MCC_fnc_createMCCZones;
// "keyUp" 		string: "keyUp" or "KeyDown"
//_this 			ctrl varable
//==================================================================================================================================================================================
private ["_keyVarable","_ehType","_ctrl","_dikCode","_shift","_ctrlKey","_alt","_arrayToCheck","_action","_null"];
disableSerialization;

_ehType	 	= _this select 0;
_keyVarable = _this select 1;

_ctrl 		= _keyVarable select 0;
_dikCode 	= _keyVarable select 1;
_shift 		= _keyVarable select 2;
_ctrlKey 	= _keyVarable select 3;
_alt 		= _keyVarable select 4;

_arrayToCheck = str [_shift,_ctrlKey,_alt,_dikCode];

_action = -1;
{
	if (_arrayToCheck == str _x) exitWith {_action = _forEachIndex};
} foreach MCC_keyBinds;

if (tolower _ehType == "keyup") exitWith
{
	//Vault
	if (missionNameSpace getVariable ["MCC_coverVault",true]) then
	{
		if ((_dikCode in actionKeys "GetOver") && !(player getVariable ["MCC_vaultOver",false]) && (player getVariable ["MCC_wallAhead",""]) != "") exitWith {[] spawn MCC_fnc_vault};
	};

	//Change weapons
	if (missionNameSpace getVariable ["MCC_quickWeaponChange",false]) then
	{
		if (_dikCode in [2,3,4,5,6,7] && _shift) exitWith
		{
			//_null= [_dikCode] execVM "mcc\fnc\actions\fn_weaponSelect.sqf";
			[_dikCode] spawn MCC_fnc_weaponSelect;
		};
	};

	//keybinds
	switch (_action) do
	{
		case 0 : {_null = [nil,nil,nil,nil,0] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//MCC
		case 1 : {_null = [nil,nil,nil,nil,1] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//Console
		case 2 : {_null = [objNull] execVM format["%1mcc\general_scripts\mcc_SpawnToPosition.sqf",MCC_path]};	//Console
		case 3 : { if (player getVariable ["cpReady",true]) then {_null = [nil,nil,nil,nil,2] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]}};	//Squad Dialog
		case 4 : {MCC_interactionKey_down = false; MCC_interactionKey_up = true; MCC_interactionKey_holding = false};	//Interaction
		case 5 : {_null = [nil,nil,nil,nil,3] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//Console
	};
};

if (tolower _ehType == "keydown") exitWith
{
	//keybinds
	switch (_action) do
	{
		case 4 :
		{
			MCC_interactionKey_down = true;
			MCC_interactionKey_up = false;
			if (missionNameSpace getVariable ["MCC_interaction",true]) then
			{
				//_null = [] execVM format["%1mcc\fnc\interaction\fn_interaction.sqf",MCC_path];
				[] spawn MCC_fnc_interaction
			};	//Interaction
		};

		case 6:
		{
			//Self
			[player] spawn MCC_fnc_interactSelf;
			//_null = [player] execVM format["%1mcc\fnc\interaction\fn_interactSelf.sqf",MCC_path];
		};
	};
};

true;