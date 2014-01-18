class BTC_r_shortcutButton 
{
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1, 1, 1, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
	colorBackground2[] = {1, 1, 1, 1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\scCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class TextPos {
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\onover", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\new1", 0.0, 0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape", 0.09, 1};
	action = "";
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};
class BTC_r_button_menu : BTC_r_shortcutButton 
{
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.15;//0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0, 0, 0, 0.8};
	colorBackground2[] = {1, 1, 1, 0.5};
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	
	class TextPos {
		left = "0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	
	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class ShortcutPos {
		left = "(6.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};
class BTC_r_combo 
{
	style = 16;
	type = 4;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelect[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorScrollbar[] = {1,0,0,1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {1,1,1,1};
	colorActive[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	font = "PuristaMedium";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	class ScrollBar
		{
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			autoScrollDelay = 5;
			autoScrollEnabled = 0;
			autoScrollRewind = 0;
			autoScrollSpeed = -1;
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			color[] = {1,1,1,0.6};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.3};
			height = 0;
			scrollSpeed = 0.06;
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			width = 0;
		};
		
	class ComboScrollBar
		{
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			autoScrollDelay = 5;
			autoScrollEnabled = 0;
			autoScrollRewind = 0;
			autoScrollSpeed = -1;
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			color[] = {1,1,1,0.6};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.3};
			height = 0;
			scrollSpeed = 0.06;
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			width = 0;
		};
	soundSelect[] = { "", 0, 1 };
	soundExpand[] = { "", 0, 1 };
	soundCollapse[] = { "", 0, 1 };
	maxHistoryDelay = 0;
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
		class respawn_button : BTC_r_button_menu 
		{
			idc = 9;
			text = "Respawn"; 
			action = "BTC_respawn_cond = true;closeDialog 0;if (BTC_r_new_system == 0) then {_respawn = [] spawn BTC_player_respawn;} else {player setDamage 1;};";
			x = 0.7;
			y = 0.6;
			default = true;
		};
	};
};
class BTC_move_to_mobile_dialog
{
	idd = -1;
	movingEnable = 1;
	onLoad = "";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class BTC_r_Apply : BTC_r_button_menu 
		{
			idc = -1;
			text = "Apply"; 
			action = "_spawn = [] spawn BTC_r_apply";
			x = 0.54;
			y = 0.25;
			default = true;
		};
		class BTC_r_Close : BTC_r_button_menu 
		{
			idc = -1;
			text = "Close"; 
			action = "_spawn = [] spawn BTC_r_close";
			x = 0.34;
			y = 0.25;
			default = true;
		};
		class BTC_r_spawn_points : BTC_r_combo 
		{
			idc = 119;
			onLBSelChanged = "_spawn = [] spawn BTC_r_change_target";
			x = 0.34; 
			y = 0.1;
			w = 0.4; 
			h = 0.055;
		};
	};
};
class BTC_spectating_dialog
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""BTC_r_spectating"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class BTC_r_name_units : BTC_r_combo 
		{
			idc = 120;
			onLBSelChanged = "_spawn = [] spawn BTC_r_s_change_target";
			x = 0; 
			y = -0.2;
			w = 0.4; 
			h = 0.035;
		};
		class BTC_r_spect_view : BTC_r_combo 
		{
			idc = 121;
			onLBSelChanged = "_spawn = [] spawn BTC_r_s_change_view";
			x = 0.5; 
			y = -0.2;
			w = 0.2; 
			h = 0.035;
		};
		class respawn_button : BTC_r_button_menu 
		{
			idc = 122;
			text = "Respawn"; 
			action = "BTC_respawn_cond = true;closeDialog 0;if (BTC_r_new_system == 0) then {_respawn = [] spawn BTC_player_respawn;} else {player setDamage 1;};";
			x = 0.7;
			y = -0.2;
			default = true;
		};
	};
};
class BTC_state_dialog
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""BTC_r_dialog"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class BTC_r_bleed : BTC_r_button_menu 
		{
			idc = 91;
			text = "Bandage"; 
			action = "_spawn = [] spawn BTC_r_apply_bandage";
			x = 0.7;
			y = 0.2;
			default = true;
		};
		class BTC_r_mor : BTC_r_button_menu 
		{
			idc = 92;
			text = "Morphine"; 
			action = "_spawn = [] spawn BTC_r_apply_mor";
			x = 0.7;
			y = 0.3;
			default = true;
		};
		class BTC_r_epi : BTC_r_button_menu 
		{
			idc = 93;
			text = "Epi"; 
			action = "_spawn = [] spawn BTC_r_apply_epi";
			x = 0.7;
			y = 0.35;
			default = true;
		};
		class BTC_r_cpr : BTC_r_button_menu 
		{
			idc = 94;
			text = "CPR"; 
			action = "_spawn = [] spawn BTC_r_apply_cpr";
			x = 0.7;
			y = 0.4;
			default = true;
		};
		class BTC_r_med : BTC_r_button_menu 
		{
			idc = 95;
			text = "Medikit"; 
			action = "_spawn = [] spawn BTC_r_apply_med";
			x = 0.7;
			y = 0.45;
			default = true;
		};
		class BTC_r_tra : BTC_r_button_menu 
		{
			idc = 96;
			text = "Transf."; 
			action = "_spawn = [] spawn BTC_r_apply_tra";
			x = 0.7;
			y = 0.25;
			default = true;
		};
	};
};