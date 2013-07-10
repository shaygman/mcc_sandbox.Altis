class Button 
{
	idc = -1;
	type = 16;
	style = 0;
	text = "";
	action = "";
	x = 0.0; 
	y = 0.0;
	w = 0.2;
	h = 0.08;
	shadow = 2;
	size = 0.03921;
	sizeEx = 0.03921;
	color[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {1,1,1,1};
	colorBackground2[] = {1,1,1,1};
	periodFocus = 1.2;
	periodOver = 0.8;
	default = false;
	class HitZone 
	{
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	class ShortcutPos 
	{
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos 
	{
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	/*animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";*/
	period = 0.4;
	font = "PuristaMedium";
	soundEnter[] = {"", 0.09, 1};
	soundPush[] = {"", 0.09, 1};
	soundClick[] = {"", 0.07, 1};
	soundEscape[] = {"", 0.09, 1};
	//soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	//soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	//soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	//soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	class Attributes 
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage 
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
};

class BTC_respawn_button_dialog
{
	idd = -1;
	movingEnable = 1;
	onLoad = "";//"uiNamespace setVariable [""BTC_respawn_dialog"", _this select 0];[] spawn BTC_check_kit;if (getNumber (configFile >> ""cfgVehicles"" >> typeof player >> ""attendant"") == 1) then {[] spawn BTC_ctrlShow;};_spawn = [] spawn BTC_check_sniper;";
	objects[] = {};
	class controlsBackground 
	{
	};
	class controls 
	{
		class respawn_button : Button 
		{
			idc = 9;
			text = "Respawn"; 
			action = "closeDialog 0;_respawn = [] spawn BTC_player_respawn;";
			x = 0.7;
			y = 0.6;
			default = true;
		};
	};
};