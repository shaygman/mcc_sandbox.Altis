//
// Spectating Script for Armed Assault
// by Kegetys <kegetys [ät] dnainternet.net>
//

//#include "common.hpp"

#define ReadAndWrite		0
#define ReadAndCreate		1
#define ReadOnly		2
#define ReadOnlyVerified		3

#define true	1
#define false	0

#define BORDERSIZE	0.06
#define BORDERXSIZE	0.015
#define CMENUWIDTH	0.19	// Camera menu width
#define TMENUWIDTH	0.200 // Target menu width
#define MENUHEIGHT	0.30
#define MAPWIDTH		0.3
#define MAPHEIGHT		0.30
#define MAPTXTSIZE	0.02
#define ELOGWIDTH		0.900
//#define ELOGHEIGHT	0.1525
#define ELOGHEIGHT	0.0

#define IDC_MAIN			55001
#define IDC_CAMERA		55002
#define IDC_TARGET		55003
#define IDC_NAME			55004
#define IDC_MENUCAM		55005
#define IDC_MENUTGT		55006
#define IDC_MENUCAMB	55007
#define IDC_MENUTGTB	55008
#define IDC_BG1				55009
#define IDC_BG2				55010
#define IDC_TITLE			55011
#define IDC_HELP			55012
#define IDC_MAP				55013
#define IDC_MAPFULL		55014
#define IDC_MAPFULLBG	55015
#define IDC_EVENTLOG	50016
#define IDC_DEBUG			55100

#define COL_ORANGE		{1, 0.5, 0, 1}
#define COL_GRAY			{0.2, 0.2, 0.2, 1}


class KEGsRscText 
{

	access = ReadAndWrite;
	type = 0;
	idc = -1;
	style = 0;
	w = 0.1;
	h = 0.05;
	font = "TahomaB";
	sizeEx = 0.04;
	colorBackground[] = {0, 0, 0, 0};
	colorDisabled[] = {0,0,0,0.5};
	colorShadow[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	colorSelection[] = {1,0,0,1};
	text = "";
};


class KEGsRscListBox 
{

	access = ReadAndWrite;
	type = 5;
	style = 0;
	w = 0.4;
	h = 0.4;
	font = "TahomaB";
	sizeEx = 0.04;
	rowHeight = 0;
	colorText[] = {1, 1, 1, 1};
	colorScrollbar[] = {1, 1, 1, 1};
	colorSelect[] = {0, 0, 0, 1};
	colorSelect2[] = {1, 0.5, 0, 1};
	colorSelectBackground[] = {0.6, 0.6, 0.6, 1};
	colorSelectBackground2[] = {0.2, 0.2, 0.2, 1};
	colorBackground[] = {0, 0, 0, 1};
	soundSelect[] = {"", 0.1, 1};
	period = 1;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0.5};
	color[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	maxHistoryDelay = 1;	
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class ScrollBar 
	{
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
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


class KEGsRscActiveText {
	access = ReadAndWrite;
	type = 11;
	style = 2;
	h = 0.05;
	w = 0.15;
	font = "TahomaB";
	sizeEx = 0.04;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 0.5, 0, 1};
	soundEnter[] = {"", 0.1, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0.1, 1};
	soundEscape[] = {"", 0.1, 1};
	text = "";
	default = 0;
};


class KEGsRscMapControl {
	access = ReadAndWrite;
	type = 101;
	idc = 51;
	style = 48;
	colorBackground[] = {1, 1, 1, 1};
	colorOutside[] = {0, 0, 0, 1};
	colorText[] = {0, 0, 0, 1};
	font = "TahomaB";
	sizeEx = 0.04;
	colorSea[] = {0.56, 0.8, 0.98, 0.5};
	colorForest[] = {0.6, 0.8, 0.2, 0.5};
	colorRocks[] = {0.5, 0.5, 0.5, 0.5};
	colorCountlines[] = {0.65, 0.45, 0.27, 0.5};
	colorMainCountlines[] = {0.65, 0.45, 0.27, 1};
	colorCountlinesWater[] = {0, 0.53, 1, 0.5};
	colorMainCountlinesWater[] = {0, 0.53, 1, 1};
	colorForestBorder[] = {0.4, 0.8, 0, 1};
	colorRocksBorder[] = {0.5, 0.5, 0.5, 1};

	colorPowerLines[] = {0, 0, 0, 1};
	colorNames[] = {0, 0, 0, 1};
	colorInactive[] = {1, 1, 1, 0.5};
	colorLevels[] = {0, 0, 0, 1};
	fontLabel = "PuristaMedium";
	sizeExLabel = 0.027;
	fontGrid = "PuristaMedium";
	sizeExGrid = 0.027;
	fontUnits = "PuristaMedium";
	sizeExUnits = 0.027;
	fontNames = "PuristaMedium";
	sizeExNames = 0.027;
	fontInfo = "PuristaMedium";
	sizeExInfo = 0.027;
	fontLevel = "PuristaMedium";
	sizeExLevel = 0.027;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	
	colorTracks[] = {0.84, 0.76, 0.65, 0.15};
	colorRoads[] = {0.7, 0.7, 0.7, 1};
	colorMainRoads[] = {0.9, 0.5, 0.3, 1};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoadsFill[] = {1, 1, 1, 1};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};

	stickX[] = {0.2, {"Gamma", 1, 1.5}};
	stickY[] = {0.2, {"Gamma", 1, 1.5}};

	ptsPerSquareSea = 6;
	ptsPerSquareTxt = 8;
	ptsPerSquareCLn = 8;
	ptsPerSquareExp = 8;
	ptsPerSquareCost = 8;
	ptsPerSquareFor = "4.0f";
	ptsPerSquareForEdge = "10.0f";
	ptsPerSquareRoad = 2;
	ptsPerSquareObj = 10;
	 class Legend {
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class ActiveMarker {
		color[] = {0.3, 0.1, 0.9, 1};
		size = 50;
	};
	class Command {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Task {
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Tree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bush {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Chapel {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Cross {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Rock {
		color[] = {0.1, 0.1, 0.1, 0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
	};
	class Lighthouse {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Quay {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Fuelstation {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Hospital {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class BusStop {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Transmitter {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Stack {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class Ruin {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class Tourism {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
	};
	class Watertower {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Waypoint {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
	};
	class WaypointCompleted {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
	};
	
	moveOnEdges = 1;
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "SafeZoneWAbs";
	h = "SafeZoneH - 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	shadow = 0;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 0.35;
	alphaFadeEndScale = 0.4;
	
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
};


class KEGsRscControlsGroup {
	type = 15;
	idc = -1;
	style = 0;
	x = SafeZoneX;
	y = SafeZoneY;
	w = SafeZoneW;
	h = SafeZoneH;
	
	class VScrollbar {
		color[] = {1, 1, 1, 1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;	
	};
	
	class HScrollbar {
		color[] = {1, 1, 1, 1};
		height = 0.028;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;	
	};
	
	class Controls {};
};


class KEGsRscSpectate {
	idd = IDC_MAIN;
	movingEnable = false;

	class controls {
		class mouseHandler: KEGsRscControlsGroup {
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\A3\ui_f\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\A3\ui_f\data\ui_arrow_top_ca.paa";
				border = "\A3\ui_f\data\ui_border_scroll_ca.paa";
			
			};
			onMouseMoving = "[""MouseMoving"",_this] call KEGs_fnc_spectateEvents";
			onMouseButtonDown = "[""MouseButtonDown"",_this] call KEGs_fnc_spectateEvents";
			onMouseButtonUp = "[""MouseButtonUp"",_this] call KEGs_fnc_spectateEvents";
			onMouseZChanged = "[""MouseZChanged"",_this] call KEGs_fnc_spectateEvents";
			onMapClick ="[""MapClick"",_this] call KEGs_fnc_spectateEvents";
			idc = 123;
			x = SafeZoneX; y = SafeZoneY;
			w = SafeZoneW; h = SafeZoneH;
			colorBackground[] = {0.2, 0.0, 0.0, 0.0};
		};
		// Borders and title text
		class BackgroundTop: KEGsRscText {
			idc = IDC_BG1;
			x = SafeZoneX; y = SafeZoneY;
			w = SafeZoneW; h = BORDERSIZE;
			colorBackground[] = {0.0, 0.0, 0.0, 1.0};
		};
		class BackgroundBottom: BackgroundTop {
			idc = IDC_BG2;
			y = SafeZoneY + SafeZoneH-BORDERSIZE;
		};
		class title : BackgroundTop {
			idc = IDC_TITLE;
			colorBackground[] = {0.0, 0.0, 0.0, 0.0};
			//text = "SPECTATING";
			text = "";
			style = 2;
			sizeEx = 0.035;
			colorText[] = {1.0, 0.0, 0.0, 1.0};
			shadow = true;
			y = SafeZoneY;
			h = BORDERSIZE;
			font = "PuristaMedium";
		};

		// Camera menu
		class menuCameras : KEGsRscText {
			idc = IDC_MENUCAMB;
			style = 0; //ST_HUD_BACKGROUND;
			x = SafeZoneX + BORDERXSIZE;	y = SafeZoneY + BORDERSIZE;
			w = CMENUWIDTH;		h = MENUHEIGHT;
			text = "";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class menuCamerasLB : KEGsRscListBox {
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_MENUCAM;
			x = SafeZoneX + BORDERXSIZE;	y = SafeZoneY + BORDERSIZE;
			w = CMENUWIDTH;		h = MENUHEIGHT;
			colorSelect[] = COL_ORANGE;
			colorSelect2[] = COL_ORANGE;
			colorSelectBackground[] = COL_GRAY;
			colorSelectBackground2[] = COL_GRAY;
			sizeEx = 0.025;
			onMouseButtonUp  = "['*Dialog*'] spawn KEGs_fnc_cameraMenuHandler;";
		};

		// Targets menu
		class menuTargets : KEGsRscText {
			idc = IDC_MENUTGTB;
			style = 0; //ST_HUD_BACKGROUND;
			x = SafeZoneX + SafeZoneW-BORDERXSIZE-TMENUWIDTH;
			y = SafeZoneY + BORDERSIZE;
			w = TMENUWIDTH;	h = MENUHEIGHT;
			text = "";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class menuTargetsLB : KEGsRscListBox {
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_MENUTGT;
			x = SafeZoneX + SafeZoneW-BORDERXSIZE-TMENUWIDTH;
			y = SafeZoneY + BORDERSIZE;
			w = TMENUWIDTH;	h = MENUHEIGHT;
			colorSelect[] = COL_ORANGE;
			colorSelect2[] = COL_ORANGE;
			colorSelectBackground[] = COL_GRAY;
			colorSelectBackground2[] = COL_GRAY;
			colorScrollbar[] = COL_ORANGE;
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.025;
			period = 0;
			onMouseButtonUp  = "[true] spawn KEGs_fnc_playerMenuHandler;";
		};

		// Top texts
		class tCamera : KEGsRscActiveText {
			idc = IDC_CAMERA;
			x = SafeZoneX + BORDERXSIZE; y = SafeZoneY;	w = SafeZoneW-(2*BORDERXSIZE); h = BORDERSIZE;
			text = "Camera";
			style = 0;
			sizeEx = 0.025;
			color[] = {1.0, 1.0, 1.0, 0.9};
			shadow = true;
			font = "PuristaMedium";
			onMouseButtonUp = "[""ToggleCameraMenu"",0] call KEGs_fnc_spectateEvents";
		};
		class tTarget : tCamera {
			idc = IDC_TARGET;
			text = "Target";
			style = 1;
			onMouseButtonUp = "[""ToggleTargetMenu"",0] call KEGs_fnc_spectateEvents";
		};

		// Bottom texts
		class tName : KEGsRscText {
			idc = IDC_NAME;
			x = SafeZoneX + BORDERXSIZE;y = SafeZoneY + SafeZoneH-BORDERSIZE; w = SafeZoneW-(BORDERXSIZE); h = BORDERSIZE;
			text = "Unknown";
			style = 0;
			sizeEx = 0.025; //0.030
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			font = "PuristaMedium";
		};

		// Help text
		class tHelp : KEGsRscText {
			type = 13;
			idc = IDC_HELP;
			x = SafeZoneX + BORDERXSIZE*3;y=SafeZoneY + BORDERSIZE*3; w = SafeZoneW-(2*BORDERXSIZE*3); h = SafeZoneH-(2*BORDERSIZE*2);
			text = "Kegetys Spectating Script for ArmA 3<br/><br/>Click at the camera/target text at the top to open camera/target menus.<br/>Units on the map can be clicked to set the camera focus to them<br/><br/>Keyboard controls:<br/><br/>A/D - Previous/Next target<br/>1-4 - Direct camera change<br/>N - NV view: Toggle night vision/FLIR on/off<br/>N - Full map: Toggle marker text off/names/types<br/>T - Toggle unit tags on/off<br/>Y - Toggle unit combat awareness tags on/off<br/>F - Toggle AI menu filter on/off<br/>H - Toggle Map Markers Updates on/off<br/>M - Toggle map: minimap/full/off<br/>Numpad plus/minus - Increase/decrease full map marker size<br/>W,S,A,D,Q,Z keys - free camera movement<br/>Alt + W,S,A,D,Q,Z keys - increase speed free camera movement<br/>Ctrl + W,S,A,D keys - turbo speed free camera movement<br/>V - toggle Viewdistance 4x<br/>Alt + V - toggle Viewdistance up to 12km<br/>Ctrl + V - increase Viewdistance to 20km<br/>Tab - Toggle UI on/off<br/>Esc - Exit Spectator mode<br/><br/>Mouse controls:<br/><br/>Mousewheel - zoom in/out of units or map<br/>Alt + Mousewheel - increase speed free camera movement<br/>Ctrl + Mousewheel - turbo speed free camera movement<br/>Right button - Rotate camera (lock-on and free camera mode)<br/>Left button - Move camera<br/>Alt + Left and right button - change FOV<br/>Ctrl + Alt + Left and right button - reset FOV<br/><br/>Improvement modifications by Dwarden, ViperMaul, ShayGman, and Ollem</br>";			
			style = 2;
			sizeEx = 0.025;
			size = 0.025;
			colorText[] = {1.0, 1.0, 1.0, 1.0};
			color[] = {0.0, 0.0, 0.0, 1.0};
			font = "LucidaConsoleB";
			class Attributes{
				color = "#99FF00";
				align = "left";
				shadow = false;
			};
		};

		// Debug text
		class tDebug : tCamera {
			idc = IDC_DEBUG;
			text = "";
			style = 2;
			x = SafeZoneX; y = SafeZoneY;
			w = SafeZoneW; h = SafeZoneH;
			action ="";
		};

		// Map
		class map : KEGsRscMapControl {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			class Task : Task
			{
				icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
				size = 20;
				color[] = {0,0.9,0,1};
				importance = "1.2 * 16 * 0.05";
				coefMin = 0.9;
				coefMax = 4;
			};
			class CustomMark : CustomMark
			{
				icon = "\A3\ui_f\data\igui\cfg\cursors\customMark_ca.paa";
				color[] = {0,0,1,1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			idc = IDC_MAP;
			x = SafeZoneX + SafeZoneW-MAPWIDTH; y = SafeZoneY + SafeZoneH-MAPHEIGHT;
			w = MAPWIDTH; h = MAPHEIGHT;
			colorBackground[] = {0.7, 0.7, 0.7, 0.75};
			//sizeEx = 0.02;
			sizeExLabel = MAPTXTSIZE;
			sizeExGrid = MAPTXTSIZE;
			sizeExUnits = MAPTXTSIZE;
			sizeExNames = MAPTXTSIZE;
			sizeExInfo = MAPTXTSIZE;
			sizeExLevel = MAPTXTSIZE;
			showCountourInterval = "false";

			onMouseZChanged = "[""MouseZChangedminimap"",_this] call KEGs_fnc_spectateEvents";

			class Command : Command {
				icon = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {0, 0, 0, 1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};

			class ActiveMarker : ActiveMarker {
				color[] = {0.3, 0.1, 0.9, 1};
				size = 50;
			};
		};

		// Fullscreen map
		class mapFullBG : BackgroundTop {
			idc = IDC_MAPFULLBG;
			x = SafeZoneX;y=SafeZoneY;
			w = SafeZoneW;h=SafeZoneH;
			colorBackground[] = {0.0, 0.0, 0.0, 1.0};
		};
		class mapFull : map {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			showCountourInterval = "true";
			idc = IDC_MAPFULL;
			x = SafeZoneX;y=SafeZoneY + BORDERSIZE;
			w = SafeZoneW;h=SafeZoneH-(BORDERSIZE*2);
			colorBackground[] = {0.85, 0.85, 0.85, 1.0};
		};

		// Fullscreen event log
		class mapFullEventLog : KEGsRscListBox {
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				shadow = 0;
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_EVENTLOG;
			x = SafeZoneX; y = SafeZoneY + SafeZoneH-ELOGHEIGHT;
			w = ELOGWIDTH;		h = ELOGHEIGHT;
			colorText[] = {1, 1, 1, 0};
			colorSelect[] = {1, 1, 1, 0};
			colorSelect2[] = {1, 1, 1, 0};
			colorSelectBackground[] = {1, 1, 1, 0};
			colorSelectBackground2[] = {1, 1, 1, 0};
			colorBackground[] = {0, 0, 0, 0.5};
			colorScrollbar[] = {1, 1, 1, 0};
			sizeEx = 0.021;
		};

		// Dummy element for retrieving mouse events
	};
};
