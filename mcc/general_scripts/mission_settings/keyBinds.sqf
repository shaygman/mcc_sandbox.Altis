//Made by Shay_Gman (c) 05.14
#define missionSettings_IDD 2997
#define MCC_LoginDIalog_IDD 2990

#define MCC_keyBindsOpenMCCButtonIDC 8415
#define MCC_keyBindsOpenConsoleButtonIDC 8416
#define MCC_keyBindsT2TButtonIDC 8417
#define MCC_keyBindsGroupsButtonIDC 8418
#define MCC_keyBindsMCCinteractionIDC 8419

private ["_type","_keyDown","_ctrl","_display"];
disableSerialization;

_type = _this select 1;

if (_type ==7) exitWith {MCC_cover = false; ctrlEnable [8499,false]};
MCC_functionName_keyDown =
{
    private ["_text","_textKey", "_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt","_keyVarable","_ctrlType","_array"];
	_keyVarable  = _this select 0;
	_ctrlType	 = _this select 1;

    _ctrl = _keyVarable select 0;
    _dikCode = _keyVarable select 1;
    _shift = _keyVarable select 2;
    _ctrlKey = _keyVarable select 3;
    _alt = _keyVarable select 4;

	_text = "";
	if (_shift) then {_text = "Shift + "};
	if (_ctrlKey) then {_text = _text + "Ctrl + "};
	if (_alt) then {_text = _text + "Alt + "};

	_textKey = 	keyName _dikCode;
	if !(_dikCode in [42,54,56,184,29,157]) then
	{
		_ctrl ctrlsetText _text + _textKey;
		_array = [_shift,_ctrlKey,_alt,_dikCode];
		MCC_keyBinds = profileNamespace getVariable ["MCC_keyBinds", [[],[]]];
		MCC_keyBinds set [_ctrlType, _array];
		profileNamespace setVariable ["MCC_keyBinds", MCC_keyBinds];
		_ctrl ctrlRemoveAllEventHandlers "KeyUp";
	};
};

_display = ctrlParent ((_this select 0) select 0);
hint "Press any key or key combination with Alt, Shift or Ctrl to bind";

_ctrl = _display displayCtrl (8415 + _type);
_keyDown = _ctrl ctrlAddEventHandler ["KeyUp",  format ["[_this,%1] call MCC_functionName_keyDown",_type]];