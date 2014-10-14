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

_type = _this select 0;

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
	
	
	_textKey = 	[_dikCode] call MCC_fnc_keyToName;
	
	if (_textKey !="") then
	{
		_ctrl ctrlsetText _text + _textKey;
		_array = [_shift,_ctrlKey,_alt,_dikCode];
		MCC_keyBinds = profileNamespace getVariable ["MCC_keyBinds", [[],[]]];
		MCC_keyBinds set [_ctrlType, _array];
		profileNamespace setVariable ["MCC_keyBinds", MCC_keyBinds];
	};
};

_display = if (tolower str(findDisplay missionSettings_IDD) == "no display") then {MCC_LoginDIalog_IDD} else {missionSettings_IDD}; 
hint "Press any key or key combination with Alt, Shift or Ctrl to bind";

switch (_type) do	
{
	case 0:	//Open MCC
	{
		_ctrl = (findDisplay _display) displayCtrl MCC_keyBindsOpenMCCButtonIDC;
		_keyDown = _ctrl ctrlSetEventHandler ["KeyDown",  "[_this,0] call MCC_functionName_keyDown"];
	};
	
	case 1:	
	{
		_ctrl = (findDisplay _display) displayCtrl MCC_keyBindsOpenConsoleButtonIDC;
		_keyDown = _ctrl ctrlSetEventHandler ["KeyDown",  "[_this,1] call MCC_functionName_keyDown"];
	};
	
	case 2:	
	{
		_ctrl = (findDisplay _display) displayCtrl MCC_keyBindsT2TButtonIDC;
		_keyDown = _ctrl ctrlSetEventHandler ["KeyDown",  "[_this,2] call MCC_functionName_keyDown"];
	};
	
	case 3:	
	{
		_ctrl = (findDisplay _display) displayCtrl MCC_keyBindsGroupsButtonIDC;
		_keyDown = _ctrl ctrlSetEventHandler ["KeyDown",  "[_this,3] call MCC_functionName_keyDown"];
	};
	
	case 4:	
	{
		_ctrl = (findDisplay _display) displayCtrl MCC_keyBindsMCCinteractionIDC;
		_keyDown = _ctrl ctrlSetEventHandler ["KeyDown",  "[_this,4] call MCC_functionName_keyDown"];
	};
};
	
