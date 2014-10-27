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
	switch (_action) do
	{
		case 4 : {MCC_interactionKey_down = true; MCC_interactionKey_up = false; if (missionNameSpace getVariable ["MCC_interaction",true]) then {[] spawn MCC_fnc_interaction}};	//Interaction
	};
};

true; 