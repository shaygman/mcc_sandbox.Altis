private ["_cmd","_comboBox","_role"];
disableSerialization;

#define CP_UNIFORMSPANEL_IDD (uiNamespace getVariable "CP_UNIFORMSPANEL_IDD")
#define CP_uniformPanelNV (uiNamespace getVariable "CP_uniformPanelNV")
#define CP_uniformPanelHead (uiNamespace getVariable "CP_uniformPanelHead")
#define CP_uniformPanelGoggles (uiNamespace getVariable "CP_uniformPanelGoggles")
#define CP_uniformPanelVest (uiNamespace getVariable "CP_uniformPanelVest")
#define CP_uniformPanelBackpack (uiNamespace getVariable "CP_uniformPanelBackpack")
#define CP_uniformPanelUniforms (uiNamespace getVariable "CP_uniformPanelUniforms")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

_cmd = _this select 0;
_role = CP_classes select CP_classesIndex;

switch (_cmd) do
	{
		case 0:				//LBL change on NV
		{ 
			CP_NVIndex = lbCurSel CP_uniformPanelNV;
			CP_playerUniforms set [_cmd,CP_uniformPanelNV lbdata CP_NVIndex]; 
		};
		
		case 1:				//LBL change on Head Gear
		{ 
			CP_headgearIndex = lbCurSel CP_uniformPanelHead;
			CP_playerUniforms set [_cmd,CP_uniformPanelHead lbdata CP_headgearIndex]; 
		};
		case 2:				//LBL change on Goggles
		{ 
			CP_gogglesIndex = lbCurSel CP_uniformPanelGoggles;
			CP_playerUniforms set [_cmd,CP_uniformPanelGoggles lbdata CP_gogglesIndex]; 
		};
		case 3:				//LBL change on Vest
		{ 
			CP_vestIndex = lbCurSel CP_uniformPanelVest;
			CP_playerUniforms set [_cmd,CP_uniformPanelVest lbdata CP_vestIndex]; 
		};
		case 4:				//LBL change on Backpack
		{ 
			CP_backpackIndex = lbCurSel CP_uniformPanelBackpack;
			CP_playerUniforms set [_cmd,CP_uniformPanelBackpack lbdata CP_backpackIndex]; 
		};
		case 5:				//LBL change on Uniforms
		{ 
			CP_uniformsIndex = lbCurSel CP_uniformPanelUniforms;
			CP_playerUniforms set [_cmd,CP_uniformPanelUniforms lbdata CP_uniformsIndex]; 
		};
		
	};
	
[CP_classesIndex,0] call CP_fnc_setGear; 