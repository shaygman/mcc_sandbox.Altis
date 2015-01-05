class CP_GEARPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\gearPanel_init.sqf'");

	  controlsBackground[] =
	  {
	  	bckg,
		CP_respawnPanelBckg,
		CP_tittle,
		CP_sglogo
	  };


	  //---------------------------------------------
	  objects[] =
	  {
	  };

	  controls[] =
	  {
		CP_exitButton,
		CP_respawnPanelButton,
		CP_squadPanelButton,
		CP_gearPanelButton,
		CP_gearPanelCommander,
		CP_gearPanelAR,
		CP_gearPanelRifleman,
		CP_gearPanelAntitank,
		CP_gearPanelCorpsman,
		CP_gearPanelMarksman,
		CP_gearPanelSpecialist,
		CP_gearPanelCrewman,
		CP_gearPanelPilot,
		CP_gearPanelCommanderGear,
		CP_gearPanelCommanderUni,
		CP_gearPanelARGear,
		CP_gearPanelRiflemanGear,
		CP_gearPanelAntitankGear,
		CP_gearPanelCorpsmanGear,
		CP_gearPanelMarksmanGear,
		CP_gearPanelSpecialistGear,
		CP_gearPanelCrewmanGear,
		CP_gearPanelPilotGear,
		CP_gearPanelARUni,
		CP_gearPanelRiflemanUni,
		CP_gearPanelAntitankUni,
		CP_gearPanelCorpsmanUni,
		CP_gearPanelMarksmanUni,
		CP_gearPanelSpecialistUni,
		CP_gearPanelCrewmanUni,
		CP_gearPanelPilotUni,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText,
		MCC_ResourcesControlsGroup,
		CP_ItemsLoad,
		timeLeft
	  };

	 #include "RscControlsGroupItemsLoad.hpp"
    class bckg: CP_RscText
	{
		idc = 999;
		x = -0.00531252 * safezoneW + safezoneX;
		y = -0.00599999 * safezoneH + safezoneY;
		w = 1.01063 * safezoneW;
		h = 1.012 * safezoneH;
		colorBackground[] = {0,0,0,1};
	};

	class timeLeft: CP_RscText
	{
		idc = 1919;
		x = 0.463906 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
	};

	class CP_exitButton: CP_RscButtonMenu
	{
		idc = -1;

		text = "Exit Game"; //--- ToDo: Localize;
		x = 0.872396 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = "endMission 'END1' ";
	};
	class CP_respawnPanelButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Respawn"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
	};
	class CP_squadPanelButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Squad"; //--- ToDo: Localize;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
	};
	class CP_gearPanelButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.3625 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_respawnPanelBckg: CP_RscText
	{
		idc = -1;
		x = 0 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 1 * safezoneW;
		h = 0.6 * safezoneH;
		colorBackground[] = {1,1,1,0.2};
	};
	class CP_gearPanelCommander: CP_RscButton
	{
		idc = 10;
		text = "Officer"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[0,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelAR: CP_RscButton
	{
		idc = 11;
		text = "Automatic Rifleman"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.335064 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[1,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelRifleman: CP_RscButton
	{
		idc = 12;
		text = "Rifleman"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[2,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelAntitank: CP_RscButton
	{
		idc = 13;
		text = "Anti-Tank"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[3,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelCorpsman: CP_RscButton
	{
		idc = 14;
		text = "Corpsman"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[4,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelMarksman: CP_RscButton
	{
		idc = 15;
		text = "Marksman"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[5,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelSpecialist: CP_RscButton
	{
		idc = 16;
		text = "Specialist"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[6,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelCrewman: CP_RscButton
	{
		idc = 17;
		text = "Crewman"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[7,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelPilot: CP_RscButton
	{
		idc = 18;
		text = "Pilot"; //--- ToDo: Localize;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[8,0] call MCC_fnc_setGear");
	};
	class CP_gearPanelCommanderGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[0,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelCommanderUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[0,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelARGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.335064 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[1,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelRiflemanGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[2,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelAntitankGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[3,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelCorpsmanGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[4,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelMarksmanGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[5,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelSpecialistGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[6,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelCrewmanGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[7,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelPilotGear: CP_RscButtonMenu
	{
		idc = -1;
		text = "Gear"; //--- ToDo: Localize;
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[8,1] call MCC_fnc_setGear");
	};
	class CP_gearPanelARUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.335064 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[1,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelRiflemanUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[2,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelAntitankUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[3,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelCorpsmanUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[4,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelMarksmanUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[5,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelSpecialistUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[6,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelCrewmanUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[7,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelPilotUni: CP_RscButtonMenu
	{
		idc = -1;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.511458 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.0439828 * safezoneH;
		colorBackground[] = {1,0,0,0.3};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[8,2] call MCC_fnc_setGear");
	};
	class CP_gearPanelPiP: CP_RscPicture
	{
		idc = 19;
		text = "#(argb,512,512,1)r2t(rendertarget7,1.0);";
		x = 0.614583 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.273281 * safezoneW;
		h = 0.418 * safezoneH;
	};
	class CP_gearPanelPiPFake: CP_RscListBox
	{
		idc = -1;
		x = 0.614583 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.273281 * safezoneW;
		h = 0.418 * safezoneH;
		onMouseZChanged = __EVAL("['MouseZChanged',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		onMouseMoving = __EVAL("['mousemoving',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		onMouseButtonDown = __EVAL("['MouseButtonDown',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		onMouseButtonUp = __EVAL("['MouseButtonUp',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
	};
	class CP_InfoText: CP_RscText
	{
		idc = 20;
		x = 0.15625 * safezoneW + safezoneX;
		y = 0.19212 * safezoneH + safezoneY;
		w = 0.200521 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
	};
	class CP_tittle: CP_RscPicture
	{
		idc = -1;
		x = 0.22804 * safezoneW + safezoneX;
		y = 0.0409789 * safezoneH + safezoneY;
		w = 0.492927 * safezoneW;
		h = 0.153007 * safezoneH;
		text = __EVAL(CPPATH+"configs\data\chockpoints.paa");
	};
	class CP_sglogo: CP_RscPicture
	{
		idc = -1;
		x = 0.01 * safezoneW + safezoneX;
		y = 0.65 * safezoneH + safezoneY;
		w = 0.114583 * safezoneW;
		h = 0.142944 * safezoneH;
		text = __EVAL(CPPATH+"configs\data\sgLogo.paa");
		colorText[] = {1,1,1,1.8};
	};

	class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
	{
		idc = 80;
		x = 0.02 * safezoneW + safezoneX;
		y = 0.22 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.231 * safezoneH;
		class controls
		{
			class MCC_AmmoText: MCC_RscText
			{
				idc = 81;

				x = 0.0257812 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.04125 * safezoneW;
				h = 0.033 * safezoneH;
			};

			class MCC_RepairText: MCC_RscText
			{
				idc = 82;

				x = 0.0257812 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.04125 * safezoneW;
				h = 0.033 * safezoneH;
			};

			class MCC_FuelText: MCC_RscText
			{
				idc = 83;

				x = 0.0257812 * safezoneW;
				y = 0.099 * safezoneH;
				w = 0.04125 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_FoodText: MCC_RscText
			{
				idc = 84;

				x = 0.0257812 * safezoneW;
				y = 0.143 * safezoneH;
				w = 0.04125 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_MedText: MCC_RscText
			{
				idc = 85;

				x = 0.0257812 * safezoneW;
				y = 0.187 * safezoneH;
				w = 0.04125 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Ammo: MCC_RscPicture
			{
				idc = -1;

				text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
				x = 0.00515625 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.0154688 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Repair: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconRepair.paa");
				x = 0.00515625 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.0154688 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Fuel: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconFuel.paa");
				x = 0.00515625 * safezoneW;
				y = 0.099 * safezoneH;
				w = 0.0154688 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_FoodPic: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconFood.paa");
				x = 0.00515625 * safezoneW;
				y = 0.143 * safezoneH;
				w = 0.0154688 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_MedPic: MCC_RscPicture
			{
				idc = -1;

				text = __EVAL(MCCPATH +"data\IconMed.paa");
				x = 0.00515625 * safezoneW;
				y = 0.187 * safezoneH;
				w = 0.0154688 * safezoneW;
				h = 0.033 * safezoneH;
			};
		};
	};
};