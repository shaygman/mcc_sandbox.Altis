//==================================================================MCC_fnc_pipOpen===============================================================================================
// Do the transmitting feed animation
// Example: [_control] call MCC_fnc_pipOpen; 
// _control = control name
//==================================================================================================================================================================================
disableSerialization;
private ["_control"];
_control	= _this select 0;

_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_12_ca.paa";
uiSleep 0.03;
_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_11_ca.paa";
uiSleep 0.03;
_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_10_ca.paa";
uiSleep 0.03;

// Display images
for "_i" from 9 to 0 step - 1 do {
	_control ctrlsettext format["a3\ui_f\data\igui\rsctitles\static\feedstatic_0%1_ca.paa",_i];
	_control ctrlCommit 0;
	
	// 30 FPS
	uiSleep 0.03;
};
