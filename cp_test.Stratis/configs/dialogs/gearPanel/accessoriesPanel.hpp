////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by shay_gman, v1.062, #Tojyde)
////////////////////////////////////////////////////////

class CP_respawnPanelButton: RscButton
{
	idc = 1600;
	text = "Respawn"; //--- ToDo: Localize;
	x = 0.270833 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_squadPanelButton: RscButton
{
	idc = 1601;
	text = "Squad"; //--- ToDo: Localize;
	x = 0.373958 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_gearPanelButton: RscButton
{
	idc = 1602;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.477083 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelBackButton: RscButton
{
	idc = 1603;
	text = "Back"; //--- ToDo: Localize;
	x = 0.631771 * safezoneW + safezoneX;
	y = 0.247099 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
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
class CP_accessoriesPanelWeapon: RscShortcutButton
{
	idc = 1700;
	text = "Primary Weapon"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0989614 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
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
class CP_accessoriesPanelOptics: RscShortcutButton
{
	idc = 1701;
	text = "Optics"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelOpticsForward: RscButton
{
	idc = 1607;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelOpticsBack: RscButton
{
	idc = 1608;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelBarrelBack: RscButton
{
	idc = 1609;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.510996 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelBarrel: RscShortcutButton
{
	idc = 1702;
	text = "Barrel"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.510996 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelBarrelForward: RscButton
{
	idc = 1610;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.510996 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelAttachmentForward: RscButton
{
	idc = 1616;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelAttachmentBack: RscButton
{
	idc = 1606;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_accessoriesPanelAttachment: RscShortcutButton
{
	idc = 1703;
	text = "Attachment"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0879657 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
