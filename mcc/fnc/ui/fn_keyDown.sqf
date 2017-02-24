//================================================================MCC_fnc_keyDown===============================================================================================
// Handle keydown/keyUp EH
// Example: ['keyup',_this] call MCC_fnc_keyDown;
// "keyUp" 		string: "keyUp" or "KeyDown"
// _this 			ctrl varable
//==============================================================================================================================================================================
private ["_keyVarable","_ehType","_ctrl","_dikCode","_shift","_ctrlKey","_alt","_arrayToCheck","_action","_null","_lastKeyStroke"];
disableSerialization;

_ehType	 	= _this select 0;
_keyVarable = _this select 1;

_ctrl 		= _keyVarable select 0;
_dikCode 	= _keyVarable select 1;
_shift 		= _keyVarable select 2;
_ctrlKey 	= _keyVarable select 3;
_alt 		= _keyVarable select 4;

//Disable keybinds id uncconcious or role selection or in Zeus
if (!(player getVariable ["cpReady",true]) ||
    (player getvariable ["MCC_medicUnconscious",false]) ||
    !(isnull curatorcamera)
   ) exitWith {};

//IF CBA do not use the keybinds
if !(MCC_isCBA) then {
	_arrayToCheck = str [_shift,_ctrlKey,_alt,_dikCode];

	_action = -1;
	{
		if (_arrayToCheck == str _x) exitWith {_action = _forEachIndex};
	} foreach MCC_keyBinds;
};

_lastKeyStroke = missionNamespace getvariable ["MCC_lastKeyStroke",[]];
if (count _lastKeyStroke > 3) then {
	_lastKeyStroke = [];
};
_lastKeyStroke pushBack (str _this);
missionNamespace setvariable ["MCC_lastKeyStroke",_lastKeyStroke];

if (tolower _ehType == "keyup") exitWith {

	//ACE ui position
	if (_dikCode == 219 && _ctrlKey && !(isnil "MCC_ACEKeyPos")) then {0 spawn {sleep 1; MCC_ACEKeyPos = nil}};

	//No need to go further if CBA
	if (MCC_isCBA) exitWith {};

	//Vault
	if (missionNameSpace getVariable ["MCC_coverVault",true]) then {
		if ((_dikCode in actionKeys "GetOver") && !(player getVariable ["MCC_vaultOver",false]) && (player getVariable ["MCC_wallAhead",""]) != "") exitWith {[] spawn MCC_fnc_vault};
	};

	//Change weapons
	if (missionNameSpace getVariable ["MCC_quickWeaponChange",false]) then {
		if (_dikCode in [2,3,4,5,6,7]) exitWith {
			//_null= [_dikCode] execVM "mcc\fnc\actions\fn_weaponSelect.sqf";
			[_dikCode] spawn MCC_fnc_weaponSelect;
		};
	};

	//Disable key holding
	MCC_interactionKey_holding = false;

	//keybinds
	switch (_action) do {
		case 0 : {_null = [nil,nil,nil,nil,0] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//MCC
		case 1 : {_null = [nil,nil,nil,nil,1] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//Console
		case 2 : {_null = [objNull] execVM format["%1mcc\general_scripts\mcc_SpawnToPosition.sqf",MCC_path]};	//t2t
		case 3 : {_null = [nil,nil,nil,nil,2] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//Squad Dialog
		case 4 : {
			(uiNamespace getVariable ["MCC_INTERACTION_MENU",displayNull]) closeDisplay 1;
			MCC_interactionKey_down = false;
			MCC_interactionKey_up = true;
			(missionNamespace setVariable ["MCC_interactionOn",false])
		};	//Interaction
		case 5 : {_null = [nil,nil,nil,nil,3] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path]};	//Console
		case 6 : {(uiNamespace getVariable ["MCC_INTERACTION_MENU",displayNull]) closeDisplay 1; MCC_interactionKey_down = false; MCC_interactionKey_up = true;};	//Self Interaction
	};
};

if (tolower _ehType == "keydown") exitWith {
	//ACE ui position
	if (MCC_isACE) then {
		if (_dikCode == (((["ACE3 Common","ace_interact_menu_SelfInteractKey"] call CBA_fnc_getKeybind) select 5) select 0) && isnil "MCC_ACEKeyPos") then {

			_ins = lineIntersectsSurfaces [
					AGLToASL positionCameraToWorld [0,0,0],
					AGLToASL positionCameraToWorld [0,0,3000],
					player,
					objNull,
					true,
					1,
					"GEOM",
					"NONE"
				];
			MCC_ACEKeyPos = if (count _ins == 0) then {screenToWorld [0.5,0.5]} else {ASLToATL (_ins select 0 select 0)};
		};
	};

	//No need to go further if CBA
	if (MCC_isCBA) exitWith {};

	if (!(missionNamespace getVariable ["MCC_interactionKey_holding",false]) && ({_x == str _this} count _lastKeyStroke >= 3)) then {
		MCC_interactionKey_holding = true;
	};

	//keybinds
	switch (_action) do {
		case 4 :{

			//Interaction
			MCC_interactionKey_up = false;
			if ((missionNameSpace getVariable ["MCC_interaction",false]) && !(missionNamespace getVariable ["MCC_interactionOn",false]) )then {
				//No rapid fire
				missionNamespace setVariable ["MCC_interactionOn",true];

				0 spawn {
					sleep 0.2;
					MCC_interactionKey_holding = missionNamespace getVariable ["MCC_interactionOn",false];

					_null = [MCC_interactionKey_holding] spawn MCC_fnc_interaction
				};
			};
		};

		case 6:	{
			//Self
			if (missionNameSpace getVariable ["MCC_interaction",false]) then {
				MCC_interactionKey_up = false;

				[player] spawn MCC_fnc_interactSelf;
			};
		};
	};
};

true;