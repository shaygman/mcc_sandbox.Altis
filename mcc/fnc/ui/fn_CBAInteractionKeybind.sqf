//===============================================================MCC_fnc_CBAInteractionKeybind===================================================================================
// Handle CBA keybinds for interactions
//===============================================================================================================================================================================
private ["_up"];
_up = _this select 0;

if (_up) then {
	MCC_interactionKey_down = false;
	MCC_interactionKey_up = true;
	MCC_interactionKey_holding = false
} else {
	MCC_interactionKey_down = true;
	MCC_interactionKey_up = false;
	[] spawn MCC_fnc_interaction
};

true
