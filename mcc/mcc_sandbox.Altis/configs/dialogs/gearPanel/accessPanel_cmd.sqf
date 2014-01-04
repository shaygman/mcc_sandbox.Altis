private ["_cmd","_comboBox","_role","_html","_class"];
disableSerialization;

#define CP_GEARPANEL_IDD (uiNamespace getVariable "CP_GEARPANEL_IDD")
#define CP_accessoriesPanelOptics (uiNamespace getVariable "CP_accessoriesPanelOptics")
#define CP_accessoriesPanelBarrel (uiNamespace getVariable "CP_accessoriesPanelBarrel")
#define CP_accessoriesPanelAttachment (uiNamespace getVariable "CP_accessoriesPanelAttachment")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

_cmd = _this select 0;
if !(ctrlCommitted CP_InfoText) exitWith {}; 

switch (_cmd) do
	{
		case 0:				//LBL change on Optics
		{ 
			CP_opticsIndex = lbCurSel CP_accessoriesPanelOptics;
			_class = CP_accessoriesPanelOptics lbdata CP_opticsIndex;
			CP_weaponAttachments set [0,_class]; 
			_html = "<t color='#818960' size='2' shadow='1' align='left' underline='true'>" + gettext (configfile >> "CfgWeapons" >> _class >> "displayname") + "</t><br/><br/>";
			_html = _html + gettext (configfile >> "CfgWeapons" >> _class >> "descriptionShort");
			CP_InfoText ctrlSetStructuredText parseText _html;
		};
		
		case 1:				//LBL change on Barrels
		{ 
			CP_barrelIndex = lbCurSel CP_accessoriesPanelBarrel;
			_class = CP_accessoriesPanelBarrel lbdata CP_barrelIndex;
			CP_weaponAttachments set [1,_class]; 
			_html = "<t color='#818960' size='2' shadow='1' align='left' underline='true'>" + gettext (configfile >> "CfgWeapons" >> _class >> "displayname") + "</t><br/><br/>";
			_html = _html + gettext (configfile >> "CfgWeapons" >> _class >> "descriptionShort");
			CP_InfoText ctrlSetStructuredText parseText _html;			
		};
		
		case 2:				//LBL change on Attachments
		{ 
			CP_attachsIndex = lbCurSel CP_accessoriesPanelAttachment;
			_class = CP_accessoriesPanelAttachment lbdata CP_attachsIndex;
			CP_weaponAttachments set [2,_class]; 
			_html = "<t color='#818960' size='2' shadow='1' align='left' underline='true'>" + gettext (configfile >> "CfgWeapons" >> _class >> "displayname") + "</t><br/><br/>";
			_html = _html + gettext (configfile >> "CfgWeapons" >> _class >> "descriptionShort");
			CP_InfoText ctrlSetStructuredText parseText _html;
		};

	};
[CP_classesIndex,0] call CP_fnc_setGear; 