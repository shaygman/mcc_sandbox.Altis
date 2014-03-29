#define FontHTML "Bitstream"
// Constants to standardize and help simplify positioning and sizing
#define MCCDlg_ROWS 36 // determines default text and control height
#define MCCDlg_COLS 90 // guide for positioning controls

// (Calculate proportion, then /100 to represent as percentage)
#define MCCDlg_CONTROLHGT ((100/MCCDlg_ROWS)/100)
#define MCCDlg_COLWIDTH ((100/MCCDlg_COLS)/100)

// modifiers
#define MCCMCCDlg_TEXTHGT_MOD 0.9
#define MCCDlg_ROWSPACING_MOD 1.3

#define MCCDlg_ROWHGT (MCCDlg_CONTROLHGT*MCCDlg_ROWSPACING_MOD)
#define MCCDlg_TEXTHGT (MCCDlg_CONTROLHGT*MCCMCCDlg_TEXTHGT_MOD)

//-----------------------------------------------------------------------------
// Fonts
#define MCCFontM "PuristaMedium"
#define MCCFontHTML "TahomaB"
//"CourierNewB64" "TahomaB" "Bitstream" "Zeppelin32"

//-----------------------------------------------------------------------------
// Control Types 
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
#define MCCCT_MAP_MAIN 101 

#define MCCCT_SL_DIR 0x400
#define MCCCT_SL_VERT 0
#define MCCCT_SL_HORZ 0x400 

//-----------------------------------------------------------------------------
// Static styles 
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
#define MCCLB_MULTI 0x20 
#define MCCSL_VERT 0

//-----------------------------------------------------------------------------
// standard base dialog control class definitions
//-----------------------------------------------------------------------------
class MCC_RscText 
{
  access = 0;
  type = 0;
  style = 0;
  colorBackground[] = {0,0,0,0};
  colorDisabled[] = {0,0,0,0.5};
  colorShadow[] = {0,0,0,0.5};
  colorText[] = {1,1,1,1};
  autocomplete = "";
  colorSelection[] = {1,0,0,1};
  fixedWidth = 0;
  font = MCCFontM;
  h = 0.037;
  linespacing = 1;
  shadow = 1;
  SizeEx = "(((((safezoneW/safezoneH) min 1.2) / 1.2) / 25) * 1)";
  text = "";
  w = 0.3;
  x = 0.0;
  y = 0.0;
};
//----------------------------------------------------------
class MCC_RscControlsGroupNoScrollbars 
{ 
	h = 1;
	idc = -1;
	shadow = 0;
	style = 16;
	type = 15;
	w = 1;
	x = 0;
	y = 0;
	
	class Controls;
	class HScrollbar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
	
	class VScrollbar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
};

class MCC_RscControlsGroup
{ 
	h = 1;
	idc = -1;
	shadow = 0;
	style = 16;
	type = 15;
	w = 1;
	x = 0;
	y = 0;
	
	class Controls;
	class HScrollbar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
	
	class VScrollbar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
	
	class ScrollBar
	{
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
};

class MCC_RscButton 
{
  access = 0;
  borderSize = 0;
  colorBackground[] = {0.350,0.350,0.350,1};
  colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
  colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
  colorBorder[] = {0,0,0,1};
  colorDisabled[] = {0.4,0.4,0.4,1};
  colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
  colorBackgroundFocused[] = {1,1,1,1};
  colorShadow[] = {0,0,0,1};
  colorText[] = {1,1,1,1};
  font = "PuristaMedium";
  h = 0.039216;
  offsetPressedX = 0.002;
  offsetPressedY = 0.002;
  offsetX = 0.003;
  offsetY = 0.003;
  shadow = 2;
  sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.07,1};
  soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
  style = 2;
  text = "";
  type = 1;
  w = 0.095589;
  x = 0;
  y = 0;
};

class MCC_RscCheckBox 
{
	checked = 0;
	color[] = {1,1,1,0.7};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorDisabled[] = {1,1,1,0.2};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	h = "0.04 * safezoneH";
	idc = -1;
	soundClick[] = {"",0.1,1};
	soundEnter[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	style = 0;
	textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	type = 77;
	w = "0.025 * safezoneW";
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
};
class MCC_RscButtonMenu : MCC_RscButton
{
  action = "";
  animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
  animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
  color2[] = {1,1,1,1};
  color[] = {1,1,1,1};
  colorBackground2[] = {1,1,1,0.5};
  colorBackground[] = {0.450,0.450,0.450,1};
  colorDisabled[] = {1,1,1,0.25};
  colorText[] = {1,1,1,1};
  default = 0;
  font = "PuristaMedium";
  h = 0.039216;
  period = 1.2;
  periodFocus = 1.2;
  periodOver = 1.2;
  shadow = 0;
  shortcuts[] = {};
  size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
  soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\new1",0,0};
  style = "0x02 + 0xC0";
  text = "";
  textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
  type = 16;
  w = 0.095589;
  x = 0;
  y = 0;
  class Attributes
	{
		align = "left";
		color = "#E5E5E5";
		font = "PuristaLight";
		shadow = "false";
	};
  class AttributesImage
	{
		align = "left";
		color = "#E5E5E5";
		font = "PuristaMedium";
	};
   class HitZone
	{
		bottom = 0;
		left = 0;
		right = 0;
		top = 0;
	};
   class ShortcutPos
	{
		h = 0.03;
		left = "(6.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
	};
   class TextPos
	{
		bottom = 0;
		left = "0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		right = 0.005;
		top = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
	};
};

class MCC_RscListbox 
	{
	access = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	autoScrollSpeed = -1;
	color[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.3};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect2[] = {0,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorShadow[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	font = "PuristaMedium";
	h = 0.4;
	maxHistoryDelay = 1;
	period = 1.2;
	rowHeight = 0;
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundSelect[] = {"",0.1,1};
	style = 16;
	type = 5;
	w = 0.4;

	class ListScrollBar
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
	};


class MCC_RscTree 
{
	access = 0;
	borderSize = 0;
	colorArrow[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	colorDisabled[] = {1,1,1,0.25};
	colorMarked[] = {0.2,0.3,0.7,1};
	colorMarkedSelected[] = {0,0.5,0.5,1};
	colorMarkedText[] = {0,0,0,1};
	colorSelect[] = {1,1,1,0.7};
	colorSelectBackground[] = {0,0,0,0.5};
	colorSelectText[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	expandOnDoubleclick = 1;
	font = "PuristaMedium";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	maxHistoryDelay = 1;
	multiselectEnabled = 0;
	rowHeight = 0.0439091;
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	style = 0;
	type = 12;
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
};	
class MCC_RscCombo 
	{
	access = 0;
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	color[] = {1,1,1,1};
	colorActive[] = {1,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorText[] = {0.95,0.95,0.95,1};
	font = "PuristaMedium";
	h = 0.035;
	maxHistoryDelay = 1;
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundCollapse[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundSelect[] = {"",0.1,1};
	style = 16;
	type = 4;
	w = 0.12;
	wholeHeight = 0.45;
	x = 0;
	y = 0;
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
	};
	
class MCC_RscStructuredText 
	{
		access = 0;
		idc = -1;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0};
		h = 0.035;
		shadow = 1;
		size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		style = 0;
		text = "";
		type = 13;
		w = 0.1;
		x = 0;
		y = 0;
		class Attributes
			{
				align = "left";
				color = "#ffffff";
				font = "PuristaMedium";
				shadow = 1;
			};
	};
	
class MCC_RscMapControl 
	{
	access = 0;
	alphaFadeEndScale = 0.4;
	alphaFadeStartScale = 0.35;
	colorBackground[] = {0.969,0.957,0.949,1};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0,0,0,0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorInactive[] = {1,1,1,0.5};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorMainRoads[] = {0.9,0.5,0.3,1};
	colorMainRoadsFill[] = {1,0.6,0.4,1};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorOutside[] = {0,0,0,1};
	colorPowerLines[] = {0.1,0.1,0.1,1};
	colorRailWay[] = {0.8,0.2,0,1};
	colorRoads[] = {0.7,0.7,0.7,1};
	colorRoadsFill[] = {1,1,1,1};
	colorRocks[] = {0,0,0,0.3};
	colorRocksBorder[] = {0,0,0,0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorText[] = {0,0,0,1};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1};
	font = "TahomaB";
	fontGrid = "TahomaB";
	fontInfo = "PuristaMedium";
	fontLabel = "PuristaMedium";
	fontLevel = "TahomaB";
	fontNames = "PuristaMedium";
	fontUnits = "TahomaB";
	h = "SafeZoneH - 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	maxSatelliteAlpha = 0.45;
	moveOnEdges = 1;
	ptsPerSquareCLn = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareObj = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 3;
	scaleDefault = 0.16;
	scaleMax = 1;
	scaleMin = 0.001;
	shadow = 0;
	showCountourInterval = 0;
	sizeEx = 0.04;
	sizeExGrid = 0.02;
	sizeExInfo = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	sizeExLabel = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	sizeExLevel = 0.02;
	sizeExNames = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	sizeExUnits = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	stickX[] = {0.2,["Gamma",1,1.5]};
	stickY[] = {0.2,["Gamma",1,1.5]};
	style = 48;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	type = 101;
	w = "SafeZoneWAbs";
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class ActiveMarker
		{
		color[] = {0.3,0.1,0.9,1};
		size = 50;
		};
	class Bunker
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "1.5 * 14 * 0.05";
		size = 14;
		};
	class Bush
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.2 * 14 * 0.05 * 0.05";
		size = "14/2";
		};
	class BusStop
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		importance = 1;
		size = 24;
		};
	class Chapel
		{
		coefMax = 4;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		importance = 1;
		size = 24;
		};
	class Church
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		importance = 1;
		size = 24;
		};
	class Command
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance =1;
		size = 18;
		};
	class Cross
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		importance = 1;
		size = 24;
		};
	class CustomMark
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		importance = 1;
		size = 24;
		};
	class Fortress
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 16;
		};
	class Fountain
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		importance = "1 * 12 * 0.05";
		size = 11;
		};
	class Fuelstation
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		importance = 1;
		size = 24;
		};
	class Hospital
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		importance = 1;
		size = 24;
		};
	class Legend
		{
		color[] = {0,0,0,1};
		colorBackground[] = {1,1,1,0.5};
		font = "PuristaMedium";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	class Lighthouse
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		importance = 1;
		size = 24;
		};
	class power
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		importance = 1;
		size = 24;
		};
	class powersolar
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		importance = 1;
		size = 24;
		};
	class powerwind
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		importance = 1;
		size = 24;
		};
	class powerwave
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		importance = 1;
		size = 24;
		};
	class Quay
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		importance = 1;
		size = 24;
		};
	class Rock
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.1,0.1,0.1,0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		importance = "0.5 * 12 * 0.05";
		size = 12;
		};
	class Ruin
		{
		coefMax = 4;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		importance = "1.2 * 16 * 0.05";
		size = 16;
		};
	class shipwreck
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		importance = 1;
		size = 24;
		};
	class SmallTree
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.6 * 12 * 0.05";
		size = 12;
		};
	class Stack
		{
		coefMax = 4;
		coefMin = 0.9;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 20;
		};
	class Task
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorCreated[] = {1,1,1,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		importance = 1;
		size = 27;
		};
	class Tourism
		{
		coefMax = 4;
		coefMin = 0.7;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		importance = "1 * 16 * 0.05";
		size = 16;
		};
	class Transmitter
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		importance = 1;
		size = 24;
		};
	class Tree
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.9 * 16 * 0.05";
		size = 12;
		};
	class ViewTower
		{
		coefMax = 4;
		coefMin = 0.5;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		importance = "2.5 * 16 * 0.05";
		size = 16;
		};
	class Watertower
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		importance = 1;
		size = 24;
		};
	class Waypoint
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance = 1;
		size = 24;
		};
	class WaypointCompleted
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		importance = 1;
		size = 24;
		};
	
	};

class MCC_RscSlider 
	{
		access = 0;
		color[] = {1,1,1,0.8};
		colorActive[] = {1,1,1,1};
		h = 0.025;
		shadow = 0;
		style = MCCCT_SL_HORZ;
		type = 3;
		w = 0.3;
	};
	
class MCC_RscPicture
	{
		access = 0;
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		fixedWidth = 0;
		font = "TahomaB";
		h = 0.15;
		lineSpacing = 0;
		shadow = 0;
		sizeEx = 0;
		style = 48;
		text = "";
		type = 0;
		w = 0.2;
		x = 0;
		y = 0;
	};
	
class MCC_RscFrame
	{
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		font = "PuristaMedium";
		shadow = 2;
		sizeEx = 0.02;
		style = 64;
		text = "";
		type = 0;
	};
	
class MCC_RscToolbox {
	  type = MCCCT_TOOLBOX;  //defined constant (6)
	  style = MCCST_LEFT; //defined constant (2)
	  x = 0.1;
	  y = 0.2;
	  w = 0.2;
	  h = 0.15;
	  colorText[] = {1, 0, 0, 1};
	  color[] = {0, 1, 0, 1};  //seems nothing to change, but define to avaoid errors
	  colorTextSelect[] = {0, 0.8, 0, 1};
	  colorSelect[] = {0, 0, 0, 1};
	  colorTextDisable[] = {0.4, 0.4, 0.4, 1};
	  colorDisable[] = {0.4, 0.4, 0.4, 1};
	  colorSelectedBg[] = {0.450,0.450,0.450,1};
	  font = "PuristaMedium";
	  sizeEx = 0.0208333;
};
