#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_BEHAVIOR 3030
#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GGListBoxIDC 3013
#define MCC_GGADDIDC 3014
#define MCC_GGCLEARIDC 3015
#define MCC_GGUNIT_EMPTY 3016
#define MCC_GGUNIT_EMPTYTITLE 3017
#define mcc_groupGen_CurrentgroupNameTittle_IDC 3018
#define mcc_groupGen_CurrentgroupNameText_IDC 3019
#define MCC_GGSAVE_GROUPIDC 3020

class MCC_spawnDialogControls:MCC_RscControlsGroup
{
	idc = 506;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.095 * safezoneH + safezoneY;
	w = 0.360938 * safezoneW;
	h = 0.30788 * safezoneH;

	class Controls
	{
			
		class MCC_spawnDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.360938 * safezoneW;
			h = 0.30788 * safezoneH;
		};

		class mcc_groupGen_SpawnTittle: MCC_RscText
		{
			idc = -1;

			text = "Spawn:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.373958 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class mcc_groupGen_typeTittle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_typeComboBox: MCC_RscCombo
		{
			idc = MCC_GGUNIT_TYPE;
			onLBSelChanged = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_BranchTittle: MCC_RscText
		{
			idc = -1;

			text = "Branch:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_branchComboBox: MCC_RscCombo
		{
			idc = UNIT_TYPE;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_classTittle: MCC_RscText
		{
			idc = -1;

			text = "Class:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_classComboBox: MCC_RscCombo
		{
			idc = UNIT_CLASS;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_BehaviorTittle: MCC_RscText
		{
			idc = -1;

			text = "Behavior:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_BehaviorComboBox: MCC_RscCombo
		{
			idc = MCC_GGUNIT_BEHAVIOR;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_EmptyTittle: MCC_RscText
		{
			idc = MCC_GGUNIT_EMPTYTITLE;

			text = "Empty:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_EmptyComboBox: MCC_RscCombo
		{
			idc = MCC_GGUNIT_EMPTY;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_CurrentgroupListBox: MCC_RscListbox
		{
			idc = MCC_GroupGenCurrentGroup_IDD;
			colorBorder[] = {1,1,1,1};

			x = 0.528646 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.109957 * safezoneH;
		};
		class mcc_groupGen_CurrentgroupNameTittle: MCC_RscText
		{
			idc = mcc_groupGen_CurrentgroupNameTittle_IDC;

			text = "Name:"; //--- ToDo: Localize;
			x = 0.528646 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class mcc_groupGen_CurrentgroupNameText: MCC_RscText
		{
			idc = mcc_groupGen_CurrentgroupNameText_IDC;
			type = 2;

			x = 0.563021 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class mcc_groupGen_classAddButton: MCC_RscButton
		{
			idc = MCC_GGADDIDC;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

			text = "Add"; //--- ToDo: Localize;
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.035 * safezoneH;
			tooltip = "Add the selected unit to the list"; //--- ToDo: Localize;
		};
		class mcc_groupGen_groupListBoxClearButton: MCC_RscButton
		{
			idc = MCC_GGCLEARIDC;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

			text = "Clear"; //--- ToDo: Localize;
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.035 * safezoneH;
			tooltip = "Remove all units from the list"; //--- ToDo: Localize;
		};
		class mcc_groupGen_groupListSaveButton: MCC_RscButton
		{
			idc = MCC_GGSAVE_GROUPIDC;
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

			text = "Save as Custom"; //--- ToDo: Localize;
			x = 0.563021 * safezoneW + safezoneX;
			y = 0.434026 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.035 * safezoneH;
			tooltip = "Save the group as a custom group"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class mcc_groupGen_groupListBoxCreaterButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");

			text = "Create"; //--- ToDo: Localize;
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.390043 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.035 * safezoneH;
			tooltip = "Mouse click on the map to create the group - AI behavior will be ignored"; //--- ToDo: Localize;
		};
		class mcc_groupGen_groupListBoxAddToZoneButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");

			text = "Add to zone"; //--- ToDo: Localize;
			x = 0.454167 * safezoneW + safezoneX;
			y = 0.434026 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.035 * safezoneH;
			tooltip = "Create the group in the selected zone"; //--- ToDo: Localize;
		};
		class MCC_zoneLocTittle: MCC_RscText
		{
			idc = -1;

			text = "Location:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_zoneLoc: MCC_RscCombo
		{
			idc = 0;
			onLBSelChanged = "mcc_hc = (MCC_ZoneLocation select (lbCurSel (_this select 0))) select 1;";

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.445021 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};

		class mcc_groupGen_spawnCloseButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Close"; //--- ToDo: Localize;
			
			x = 0.436979 * safezoneW + safezoneX;
			y = 0.489004 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};