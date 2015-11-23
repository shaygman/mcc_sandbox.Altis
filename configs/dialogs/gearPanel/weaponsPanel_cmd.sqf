private ["_cmd","_comboBox","_role","_html","_displayName","_disc","_item"];
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

if !(ctrlCommitted CP_InfoText) exitWith {};
_itemName = "";

switch (_cmd) do {
	//LBL change on Primary weapon
	case 0:	{
		if (CP_currentWeaponIndex != lbCurSel CP_weaponsPanelPrimary) then {
			CP_weaponAttachments =[];
			CP_opticsIndex = 0;
			CP_barrelIndex = 0;
			CP_attachsIndex = 0;
		};
		CP_currentWeaponIndex = lbCurSel CP_weaponsPanelPrimary;
		missionNamespace setVariable [format ["CP_player%1Weapon_%2_%3",_role, getplayerUID player,side player], CP_currentWeaponArray select CP_currentWeaponIndex];
		_itemName = (CP_currentWeaponArray select CP_currentWeaponIndex) select 1;
	};

	//LBL change on Secondary weapon
	case 1:	{
		CP_currentSecWeaponIndex = lbCurSel CP_weaponsPanelSecondary;
		missionNamespace setVariable [format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponSecArray select CP_currentSecWeaponIndex];
		_itemName = (CP_currentWeaponSecArray select CP_currentSecWeaponIndex) select 1;
	};

	//LBL change on Handguns
	case 2:	{
		CP_currentHandgunsIndex = lbCurSel CP_weaponsPanelHandgun;
		missionNamespace setVariable [format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player], CP_handguns select CP_currentHandgunsIndex];
		_itemName = (CP_handguns select CP_currentHandgunsIndex) select 1;
	};

	//LBL change on Items1
	case 3:	{
		CP_currentItems1Index = lbCurSel CP_weaponsPanelItem1;
		missionNamespace setVariable [format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player], CP_currentItmes1 select CP_currentItems1Index];
		_itemName = (CP_currentItmes1 select CP_currentItems1Index) select 1;
	};

	//LBL change on Items2
	case 4:	{
		CP_currentItems2Index = lbCurSel CP_weaponsPanelItem2;
		missionNamespace setVariable [format ["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player], CP_currentItmes2 select CP_currentItems2Index];
		_itemName = (CP_currentItmes2 select CP_currentItems2Index) select 1;
	};

	//LBL change on Items3
	case 5: {
		CP_currentItems3Index = lbCurSel CP_weaponsPanelItem3;
		missionNamespace setVariable [format ["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player], CP_currentItmes3 select CP_currentItems3Index];
		_itemName = (CP_currentItmes3 select CP_currentItems3Index) select 1;
	};
};

if (isClass (configfile >> "CfgWeapons" >> _itemName)) then {
	_displayName = gettext (configfile >> "CfgWeapons" >> _itemName >> "displayName");
	_disc = gettext (configfile >> "CfgWeapons" >> _itemName >> "descriptionShort");
} else {
	_displayName = gettext (configfile >> "CfgMagazines" >> _itemName >> "displayName");
	_disc = gettext (configfile >> "CfgMagazines" >> _itemName >> "descriptionShort");
};

_html = "<t color='#818960' size='2' shadow='1' align='left' underline='true'>" + _displayName + "</t><br/><br/>";
_html = _html + _disc;
CP_InfoText ctrlSetStructuredText parseText _html;

[CP_classesIndex,0] call MCC_fnc_setGear;
[CP_WEAPONSPANEL_IDD] call MCC_fnc_playerStats;