private ["_cmd","_comboBox","_role"];
disableSerialization;

#define CP_WEAPONSPANEL_IDD (uiNamespace getVariable "CP_WEAPONSPANEL_IDD")
#define CP_weaponsPanelPrimary (uiNamespace getVariable "CP_weaponsPanelPrimary")
#define CP_weaponsPanelSecondary (uiNamespace getVariable "CP_weaponsPanelSecondary")
#define CP_weaponsPanelHandgun (uiNamespace getVariable "CP_weaponsPanelHandgun")
#define CP_weaponsPanelItem1 (uiNamespace getVariable "CP_weaponsPanelItem1")
#define CP_weaponsPanelItem2 (uiNamespace getVariable "CP_weaponsPanelItem2")
#define CP_weaponsPanelItem3 (uiNamespace getVariable "CP_weaponsPanelItem3")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

_cmd = _this select 0;
_role = CP_classes select CP_classesIndex;

switch (_cmd) do
	{
		case 0:				//LBL change on Primary weapon
		{ 
			CP_currentWeaponIndex = lbCurSel CP_weaponsPanelPrimary;
			missionNamespace setVariable [format ["CP_player%1Weapon_%2_%3",_role, getplayerUID player,side player], CP_currentWeaponArray select CP_currentWeaponIndex];
		};
		
		case 1:				//LBL change on Secondary weapon
		{ 
			CP_currentSecWeaponIndex = lbCurSel CP_weaponsPanelSecondary;
			missionNamespace setVariable [format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponSecArray select CP_currentSecWeaponIndex];
		};
		case 2:				//LBL change on Handguns
		{ 
			CP_currentHandgunsIndex = lbCurSel CP_weaponsPanelHandgun;
			missionNamespace setVariable [format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player], CP_handguns select CP_currentHandgunsIndex];
		};
		case 3:				//LBL change on Items1
		{ 
			CP_currentItems1Index = lbCurSel CP_weaponsPanelItem1;
			missionNamespace setVariable [format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player], CP_officerItmes1 select CP_currentItems1Index];
		};
	};
	
[CP_classesIndex,0] call CP_fnc_setGear; 