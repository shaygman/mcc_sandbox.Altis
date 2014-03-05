class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] = 
	{
	};


	//---------------------------------------------
	objects[] = 
	{ 
	};

	class controls 
	{
		//===========================       Mission Wizard   ============================================================
	class MCC_factioTittle: MCC_RscText	
	{	
		idc = -1;
		text = "Faction:";
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.445021 * safezoneH + safezoneY;
		w = 0.06799 * safezoneW;
		h = 0.0340016 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class MCC_factionCombo: MCC_RscCombo 
	{	
		idc = FACTIONCOMBO;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
	};
	class MCC_MWTittle: MCC_RscText
	{
		idc = -1;

		text = "Missions Wizard"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.0329871 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class MCC_MWPlayersTittle: MCC_RscText
	{
		idc = -1;

		text = "# Players:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRoadBlockTittle: MCC_RscText
	{
		idc = -1;

		text = "Roadblocks:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWStealthTittle: MCC_RscText
	{
		idc = -1;

		text = "Stealth:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWPlayersCombo: MCC_RscCombo
	{
		idc = MCC_MWPlayersIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRivalFactionTittle: MCC_RscText
	{
		idc = -1;

		text = "Rival Faction:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWRoadBlockCombo: MCC_RscCombo
	{
		idc = MCC_MWRoadBlocksIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWStealthCombo: MCC_RscCombo
	{
		idc = MCC_MWStealthIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWObjective1Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 1:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective2Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 2:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective3Tittle: MCC_RscText
	{
		idc = -1;

		text = "Objective 3:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWVehiclesTittle: MCC_RscText
	{
		idc = -1;

		text = "Vehicles:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDifficultyTittle: MCC_RscText
	{
		idc = -1;

		text = "Difficulty:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWDifficultyCombo: MCC_RscCombo
	{
		idc = MCC_MWDifficultyIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective1Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective1IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective2Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective2IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWObjective3Combo: MCC_RscCombo
	{
		idc = MCC_MWObjective3IDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWVehiclesCombo: MCC_RscCombo
	{
		idc = MCC_MWVehiclesIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArmorTittle: MCC_RscText
	{
		idc = -1;

		text = "Armor:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArmorCombo: MCC_RscCombo
	{
		idc = MCC_MWArmorIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWReinforcementTittle: MCC_RscText
	{
		idc = -1;

		text = "Reinforcement:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWReinforcementCombo: MCC_RscCombo
	{
		idc = MCC_MWReinforcementIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArtilleryTittle: MCC_RscText
	{
		idc = -1;

		text = "Artillery:"; //--- ToDo: Localize;
		x = 0.368229 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWArtilleryCombo: MCC_RscCombo
	{
		idc = MCC_MWArtilleryIDC;
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWPreciseMarkersText: MCC_RscText
	{
		idc = -1;

		text = "Precise Locations:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	};
	
	class MCC_MWPreciseMarkersCombo: MCC_RscCombo
	{
		idc = MCC_MWPreciseMarkersComboIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY; //0.412034
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDebugText: MCC_RscText
	{
		idc = -1;

		text = "Show Markers:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWDebugCombo: MCC_RscCombo
	{
		idc = MCC_MWDebugComboIDC;

		x = 0.259375 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWIEDTittle: MCC_RscText
	{
		idc = -1;

		text = "IEDs:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWATMinesTittle: MCC_RscText
	{
		idc = -1;

		text = "AT Mines:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAPMinesTittle: MCC_RscText
	{
		idc = -1;

		text = "AP Mines:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWSBTittle: MCC_RscText
	{
		idc = -1;

		text = "Suicide Bombers:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
	};
	class MCC_MWArmedCiviliansTittle: MCC_RscText
	{
		idc = -1;

		text = "Armed Civilians:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
	};
	class MCC_MWCQBTittle: MCC_RscText
	{
		idc = -1;

		text = "CQB:"; //--- ToDo: Localize;
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWIEDCombo: MCC_RscCombo
	{
		idc = MCC_MWIEDIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWATMinesCombo: MCC_RscCombo
	{
		idc = MCC_MWATMinesIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAPMinesCombo: MCC_RscCombo
	{
		idc = MCC_MWAPMinesIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWSBCombo: MCC_RscCombo
	{
		idc = MCC_MWSBIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWArmedCiviliansCombo: MCC_RscCombo
	{
		idc = MCC_MWArmedCiviliansIDC;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWCQBCombo: MCC_RscCombo
	{
		idc = MCC_MWCQBIDC;
		x = 0.259375 * safezoneW + safezoneX;
		y = 0.313073 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWWeatherText: MCC_RscText
	{
		idc = -1;

		text = "Time/Weather:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWWeatherCombo: MCC_RscCombo
	{
		idc = MCC_MWWeatherComboIDC;

		x = 0.626042 * safezoneW + safezoneX;
		y = 0.34606 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_MWAreaText: MCC_RscText
	{
		idc = -1;

		text = "Area:"; //--- ToDo: Localize;
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_MWAreaCombo: MCC_RscCombo
	{
		idc = MCC_MCC_MWAreaComboIDC;

		x = 0.626042 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};

	class MCC_MWGenerate: MCC_RscButton
	{
		idc = -1;
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\missionWizard\missionWizardInit.sqf'");

		text = "Generate Mission"; //--- ToDo: Localize;
		x = 0.717708 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0340016 * safezoneH;
		tooltip = "Generate a mission "; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	};
	};
};