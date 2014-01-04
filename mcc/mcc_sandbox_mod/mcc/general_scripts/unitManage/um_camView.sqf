private ["_effectParams"];
MCC_UMPIPView = _this select 1;
_effectParams = switch (MCC_UMPIPView) do {
	// Normal
	case 0: {
		[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]
	};
	
	// Night vision
	case 1: {
		[1]
	};
	
	// Thermal imaging
	case 2: {
		[2]
	};
};

// Set effect
"rendertarget10" setPiPEffect _effectParams;