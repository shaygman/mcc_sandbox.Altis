//===============================================================MCC_fnc_CBAInteractionKeybind===================================================================================
// Handle CBA keybinds for interactions
//===============================================================================================================================================================================
private ["_up"];
_up = _this select 0;

if (_up) then {
	(uiNamespace getVariable ["MCC_INTERACTION_MENU",displayNull]) closeDisplay 1;
	MCC_interactionKey_down = false;
	MCC_interactionKey_up = true;
	MCC_interactionKey_holding = false;
} else {
	MCC_interactionKey_down = true;
	MCC_interactionKey_up = false;

	0 spawn {

		//Are we holding the button or just flipping it
		sleep 0.2;
		MCC_interactionKey_holding = MCC_interactionKey_down;

		_null = [MCC_interactionKey_holding] spawn MCC_fnc_interaction
	};
};

true
