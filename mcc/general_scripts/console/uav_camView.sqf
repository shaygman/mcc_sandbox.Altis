#define MCC_CONSOLE_VISION_TEXT 9111
private ["_effectParams"];
MCC_ConsoleUAVCameraMod = _this select 1;
playSound "nvSound";
switch (MCC_ConsoleUAVCameraMod) do {
	// Normal
	case 0: {
		_effectParams = [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
		MCC_ConsoleUAVvision = "VIDEO";
	};

	// Night vision
	case 1: {
		_effectParams = [1];
		MCC_ConsoleUAVvision = "N/V";
	};

	// Thermal imaging
	case 2: {
		_effectParams = [2, 1,0.5, 1, 0, [0,0,0,0], [1.1,0.7,1.1,1.1], [1.0,0.7,1.0,1.1]];
		MCC_ConsoleUAVvision = "WHOT";
	};
};

// Set effect
"rendertarget9" setPiPEffect _effectParams;
ctrlSetText [MCC_CONSOLE_VISION_TEXT, MCC_ConsoleUAVvision];