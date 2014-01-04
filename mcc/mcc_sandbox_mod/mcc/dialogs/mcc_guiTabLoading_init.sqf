private ["_disp"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_SANDBOXLOADING_IDD", _disp];
uiNamespace setVariable ["MCC_BACKGROUND", _disp displayCtrl 0];

#define MCC_SANDBOXLOADING_IDD (uiNamespace getVariable "MCC_SANDBOXLOADING_IDD")
#define MCC_BACKGROUND (uiNamespace getVariable "MCC_BACKGROUND")

disableSerialization;

MCC_BACKGROUND ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_12_ca.paa";
uiSleep 0.03;
MCC_BACKGROUND ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_11_ca.paa";
uiSleep 0.03;
MCC_BACKGROUND ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_10_ca.paa";
uiSleep 0.03;

// Display images
for "_i" from 9 to 0 step - 1 do {
	MCC_BACKGROUND ctrlsettext format["a3\ui_f\data\igui\rsctitles\static\feedstatic_0%1_ca.paa",_i];
	MCC_BACKGROUND ctrlCommit 0;
	
	// 30 FPS
	uiSleep 0.02;
};

closedialog 0;
