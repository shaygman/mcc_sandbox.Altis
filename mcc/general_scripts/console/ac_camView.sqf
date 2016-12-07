#define MCC_CONSOLE_AC_VISION_TEXT 5013
private ["_effectParams"];
playSound "nvSound";
MCC_ConsoleACCameraMod = _this select 1;
switch (MCC_ConsoleACCameraMod) do {
	// Normal
	case 0: {
		_effectParams = [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
		MCC_ConsoleACvision = "VIDEO";
	};

	// Night vision
	case 1: {
		_effectParams = [1];
		MCC_ConsoleACvision = "N/V";
	};

	// Thermal imaging
	case 2: {
		_effectParams = [2];
		MCC_ConsoleACvision = "WHOT";
	};
};

// Set effect
"rendertarget8" setPiPEffect _effectParams;
ctrlSetText [MCC_CONSOLE_AC_VISION_TEXT, MCC_ConsoleACvision];