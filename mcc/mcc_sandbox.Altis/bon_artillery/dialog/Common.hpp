//by Bon_Inf*
// version 1.091 - always replace my Common.hpp with the latest version, if no version specified, consider it as version 1.0
//                 however, never include two Common.hpp at the same time in the Description.ext

// Control types
#define MCCCT_STATIC 0
#define MCCCT_BUTTON 1
#define MCCCT_EDIT 2
#define MCCCT_SLIDER 3
#define MCCCT_COMBO 4
#define MCCCT_LISTBOX 5
#define MCCCT_TOOLBOX 6
#define MCCCT_CHECKBOXES 7
#define MCCCT_PROGRESS 8
#define MCCCT_HTML 9
#define MCCCT_STATIC_SKEW 10
#define MCCCT_ACTIVETEXT 11
#define MCCCT_TREE 12
#define MCCCT_STRUCTURED_TEXT 13
#define MCCCT_CONTEXT_MENU 14
#define MCCCT_CONTROLS_GROUP 15
#define MCCCT_XKEYDESC 40
#define MCCCT_XBUTTON 41
#define MCCCT_XLISTBOX 42
#define MCCCT_XSLIDER 43
#define MCCCT_XCOMBO 44
#define MCCCT_ANIMATED_TEXTURE 45
#define MCCCT_OBJECT 80
#define MCCCT_OBJECT_ZOOM 81
#define MCCCT_OBJECT_CONTAINER 82
#define MCCCT_OBJECT_CONT_ANIM 83
#define MCCCT_LINEBREAK 98
#define MCCCT_USER 99
#define MCCCT_MAP 100
#define MCCCT_MAP_MAIN 101 // Static styles
#define MCCST_POS 0x0F
#define MCCST_HPOS 0x03
#define MCCST_VPOS 0x0C
#define MCCST_LEFT 0x00
#define MCCST_RIGHT 0x01
#define MCCST_CENTER 0x02
#define MCCST_DOWN 0x04
#define MCCST_UP 0x08
#define MCCST_VCENTER 0x0c
#define MCCST_TYPE 0xF0
#define MCCST_SINGLE 0
#define MCCST_MULTI 16
#define MCCST_TITLE_BAR 32
#define MCCST_PICTURE 48
#define MCCST_FRAME 64
#define MCCST_BACKGROUND 80
#define MCCST_GROUP_BOX 96

#define MCCST_GROUP_BOX2 112
#define MCCST_HUD_BACKGROUND 128
#define MCCST_TILE_PICTURE 144
#define MCCST_WITH_RECT 160
#define MCCST_LINE 176
#define MCCFontM "Zeppelin32"
#define Size_Main_Small 0.027
#define Size_Main_Normal 0.04
#define Size_Text_Default Size_Main_Normal
#define Size_Text_Small Size_Main_Small
#define Color_White {1, 1, 1, 1}
#define Color_Main_Foreground1 Color_White
#define Color_Text_Default Color_Main_Foreground1

#define LB_TEXTURES 0x10
#define LB_MULTI 0x20 

#define SL_DIR 0x400
#define SL_VERT 0
#define SL_HORZ 0x400

#define true 1
#define false 0


class HW_RscText {
	idc = -1;
	type = MCCCT_STATIC;
	style = MCCST_CENTER;
	text = "";
	font = MCCFontM;
	sizeEx = 0.023;
	colorBackground[] = { 1, 1, 1, 0.3 };
	colorText[] = { 0, 0, 0, 1 };
	x = 0.8;
	y = 0.1;
	w = 0.2;
	h = 0.05;
};

class HW_RscStructuredText {
	idc = -1;
	type = MCCCT_STRUCTURED_TEXT;
	style = MCCST_LEFT;
	colorBackground[] = { 1, 1, 1, 1 };
	x = 0.1; y = 0.1;
	w = 0.3; h = 0.1;	
	size = 0.018;
	text = "";
	class Attributes {
		font = MCCFontM;
		color = "#FFFFFF";
		align = "left";
		valign = "middle";
		shadow = true;
		shadowColor = "#000000";
		size = "2.25";
	};
};

class HW_RscButton {
	idc = -1;
	type = MCCCT_BUTTON;
	style = MCCST_CENTER;
	default = false;
	font = MCCFontM;
	sizeEx = 0.05;
	colorText[] = { 0, 0, 0, 1 };
	colorFocused[] = { 0.2, 0.5, 1, 1 }; // border color for focused state
	colorDisabled[] = { 1, 0, 0, 0.7 }; // text color for disabled state
	colorBackground[] = { 0.8, 0.8, 0.8, 0.8 };
	colorBackgroundDisabled[] = { 1, 1, 1, 0.5 }; // background color for disabled state
	colorBackgroundActive[] = { 0.9, 0.9, 0.9, 1 }; // background color for active state
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0, 0, 0, 1 };
	borderSize = 0;
	soundEnter[] = { "", 0, 1 }; // no sound
	soundPush[] = { "buttonpushed.ogg", 0.1, 1 };
	soundClick[] = { "", 0, 1 }; // no sound
	soundEscape[] = { "", 0, 1 }; // no sound 
	x = 0.4;
	y = 0.475;
	w = 0.2;
	h = 0.05;
	text = "Empty";
	action = "";
};


class HW_RscBackground {
	idc = -1; 
	type = MCCCT_STATIC; 
	style = MCCST_LEFT;
	colorBackground[] = { 0, 0, 0, 0.9 };
	colorText[] = { 0, 0, 0, 1 };
	font = MCCFontM;
	sizeEx = 0.023;
	x = -1; y = -1;
	w = 3; h = 3;
	text = "";
}; 


class HW_RscPicture {
	idc = -1; 
	type = MCCCT_STATIC;
	style = MCCST_PICTURE;
	colorBackground[] = { };
	colorText[] = { };
	font = MCCFontM;
	sizeEx = 0.023;
	x = 0.0; y = 0.2;
	w = 0.2; h = 0.2;
	text = "";
}; 


class HW_RscSlider {
	type = MCCCT_SLIDER;
	style = 1024;
	w = 0.24;
	h = 0.03;
	color[] = Color_White;
	//colorActive[] = Color_White;
};


class HW_RscListBox {
	type = 5;
	style = 0 + 0x10;
	font = "Zeppelin32";
	sizeEx = 0.03921;
	color[] = {1, 1, 1, 1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorSelect2[] = {0.023529, 0, 0.0313725, 1};
	colorSelectBackground[] = {0.58, 0.1147, 0.1108, 1};
	colorSelectBackground2[] = {0.58, 0.1147, 0.1108, 1};
	period = 1;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};


class HW_RscGUIListBox : HW_RscListBox {
	color[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.839, 0.47, 0.3};
	colorSelectBackground2[] = {0.6, 0.839, 0.47, 1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	sizeEx = 0.035;
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\igui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\igui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\igui_arrow_top_ca.paa";
		border = "\ca\ui\data\igui_border_scroll_ca.paa";
	};
};


class HW_RscComboBox : HW_RscText {
		type = MCCCT_COMBO;
		style = MCCST_LEFT;
		rowHeight = 0.028;
		wholeHeight = 13 * 0.028;
		color[] = {1,1,1,1};
		colorSelect[] = {0.70, 0.99, 0.65, 1};
		colorBackground[] = {0.28, 0.36, 0.26, 1};
		colorSelectBackground[] = {0.36, 0.46, 0.36, 1};
		soundSelect[] = {"", 0.0, 1};
		soundExpand[] = {"", 0.0, 1};
		soundCollapse[] = {"", 0.0, 1};
		arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
		maxHistoryDelay = 1;
		class ScrollBar
		{
			color[] = {1, 1, 1, 0.6};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
		};
	};


class HW_RscShortcutButton {
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	w = 0.183825;
	h = 0.104575;
	color[] = {0.95, 0.95, 0.95, 1};
	color2[] = {1, 1, 1, 0.4};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = {1, 1, 1, 0.25};
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	
	class ShortcutPos {
		left = 0.004;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.01.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	textureNoShortcut = "";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03521;
	sizeEx = 0.03521;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
	};
};

class HW_RscGUIShortcutButton : HW_RscShortcutButton {
	w = 0.183825;
	h = 0.0522876;
	style = 2;
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 0.85};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.85};
	colorDisabled[] = {1, 1, 1, 0.4};
	
	class HitZone {
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.016;
	};
	
	class ShortcutPos {
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.02;
		top = 0.0;
		right = 0.002;
		bottom = 0.016;
	};
	animTextureNormal = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\igui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\igui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\igui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\igui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureNoShortcut = "\ca\ui\data\igui_button_normal_ca.paa";
	
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
};

