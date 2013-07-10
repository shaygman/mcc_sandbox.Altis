////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by shay_gman, v1.062, #Paryfo)
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
class CP_uniformPanelNV: RscShortcutButton
{
	idc = 1700;
	text = "NV"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelNVBack: RscButton
{
	idc = 1605;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
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
class CP_uniformPanelNVForward: RscButton
{
	idc = 1604;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.291081 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelHead: RscShortcutButton
{
	idc = 1701;
	text = "Head Gear"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.368051 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelHeadForward: RscButton
{
	idc = 1607;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.368051 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelHeadBack: RscButton
{
	idc = 1608;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.368051 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelGogglesBack: RscButton
{
	idc = 1609;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelGoggles: RscShortcutButton
{
	idc = 1702;
	text = "Goggles"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelGogglesForward: RscButton
{
	idc = 1610;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelVest: RscShortcutButton
{
	idc = 1703;
	text = "Vest"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.521991 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelVestBack: RscButton
{
	idc = 1611;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.521991 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelVestForward: RscButton
{
	idc = 1612;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.521991 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelBackpack: RscShortcutButton
{
	idc = 1704;
	text = "Backpack"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.598961 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelUniforms: RscShortcutButton
{
	idc = 1705;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.675931 * safezoneH + safezoneY;
	w = 0.200521 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelBackpackBack: RscButton
{
	idc = 1613;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.598961 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelUniformsBack: RscButton
{
	idc = 1614;
	text = "<"; //--- ToDo: Localize;
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.675931 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelBackpackForward: RscButton
{
	idc = 1615;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.598961 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
class CP_uniformPanelUniformsForward: RscButton
{
	idc = 1616;
	text = ">"; //--- ToDo: Localize;
	x = 0.494271 * safezoneW + safezoneX;
	y = 0.675931 * safezoneH + safezoneY;
	w = 0.0114583 * safezoneW;
	h = 0.0659743 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
