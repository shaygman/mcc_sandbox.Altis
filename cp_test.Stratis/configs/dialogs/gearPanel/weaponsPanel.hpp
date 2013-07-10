////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by shay_gman, v1.062, #Venupi)
////////////////////////////////////////////////////////

class CP_respawnPanelButton: RscButton
{
	idc = 1600;
	text = "Respawn"; //--- ToDo: Localize;
	x = 0.270833 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_squadPanelButton: RscButton
{
	idc = 1601;
	text = "Squad"; //--- ToDo: Localize;
	x = 0.373958 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelButton: RscButton
{
	idc = 1602;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.477083 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelBackButton: RscButton
{
	idc = 1603;
	text = "Back"; //--- ToDo: Localize;
	x = 0.631771 * safezoneW + safezoneX;
	y = 0.247099 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_respawnPanelBckg: RscText
{
	idc = 1003;
	x = 0.270833 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.458333 * safezoneW;
	h = 0.549786 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
};
class CP_weaponsPanelPrimary: RscShortcutButton
{
	idc = 1700;
	text = "Primary"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelPrimaryBack: RscButton
{
	idc = 1605;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelPiP: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.528645 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.373854 * safezoneH;
};
class CP_weaponsPanelPrimaryForward: RscButton
{
	idc = 1604;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelPrimaryAccessories: RscButton
{
	idc = 1606;
	text = "Accessories"; //--- ToDo: Localize;
	x = 0.351042 * safezoneW + safezoneX;
	y = 0.357056 * safezoneH + safezoneY;
	w = 0.143229 * safezoneW;
	h = 0.0219914 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelSecondary: RscShortcutButton
{
	idc = 1701;
	text = "Secondary"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelSecondaryForward: RscButton
{
	idc = 1607;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelSecondaryBack: RscButton
{
	idc = 1608;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelHandgunBack: RscButton
{
	idc = 1609;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.467013 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelHandgun: RscShortcutButton
{
	idc = 1702;
	text = "Handgun"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.467013 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelHandgunForward: RscButton
{
	idc = 1610;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.467013 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem1: RscShortcutButton
{
	idc = 1703;
	text = "Item1"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem1Back: RscButton
{
	idc = 1611;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem1Forward: RscButton
{
	idc = 1612;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem2: RscShortcutButton
{
	idc = 1704;
	text = "Item2"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem3: RscShortcutButton
{
	idc = 1705;
	text = "Item3"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem2Back: RscButton
{
	idc = 1613;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem3Back: RscButton
{
	idc = 1614;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem2Forward: RscButton
{
	idc = 1615;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.620953 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_weaponsPanelItem3Forward: RscButton
{
	idc = 1616;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.697923 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
