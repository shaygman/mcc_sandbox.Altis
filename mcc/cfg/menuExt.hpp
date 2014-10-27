class MCC_RscShortcutButtonMenu : RscShortcutButton
{
	text = "MCC keys";
	x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "11 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	action = "while {dialog} do {closeDialog 0};createDialog 'mcc_rscKeyBinds'";
};

class RscStandardDisplay {
  class controls;
};

class RscDisplayMPInterrupt: RscStandardDisplay 
{
	class controls: controls 
	{
		class MCC_keyBinds : MCC_RscShortcutButtonMenu {};
	};
};
class RscDisplayInterrupt: RscStandardDisplay 
{
	class controls: controls 
	{
		class MCC_keyBinds : MCC_RscShortcutButtonMenu {};
	};
};

class RscDisplayInterruptEditorPreview: RscStandardDisplay 
{
	class controls: controls 
	{
		class MCC_keyBinds : MCC_RscShortcutButtonMenu {};
	};
};