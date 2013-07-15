private ["_cmd","_comboBox","_role"];
disableSerialization;

#define CP_GEARPANEL_IDD (uiNamespace getVariable "CP_GEARPANEL_IDD")
#define CP_accessoriesPanelOptics (uiNamespace getVariable "CP_accessoriesPanelOptics")
#define CP_accessoriesPanelBarrel (uiNamespace getVariable "CP_accessoriesPanelBarrel")
#define CP_accessoriesPanelAttachment (uiNamespace getVariable "CP_accessoriesPanelAttachment")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

_cmd = _this select 0;

switch (_cmd) do
	{
		case 0:				//LBL change on Optics
		{ 
			CP_opticsIndex = lbCurSel CP_accessoriesPanelOptics;
			CP_weaponAttachments set [0,CP_accessoriesPanelOptics lbdata CP_opticsIndex]; 
		};
		
		case 1:				//LBL change on Barrels
		{ 
			CP_barrelIndex = lbCurSel CP_accessoriesPanelBarrel;
			CP_weaponAttachments set [1,CP_accessoriesPanelBarrel lbdata CP_barrelIndex]; 
		};
		
		case 2:				//LBL change on Attachments
		{ 
			CP_attachsIndex = lbCurSel CP_accessoriesPanelAttachment;
			CP_weaponAttachments set [2,CP_accessoriesPanelAttachment lbdata CP_attachsIndex]; 
		};

	};
	
[CP_classesIndex,0] call CP_fnc_setGear; 