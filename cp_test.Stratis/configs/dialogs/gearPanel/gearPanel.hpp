////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by shay_gman, v1.062, #Pujijy)
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
class CP_gearPanelDeployButton: RscButton
{
	idc = 1603;
	text = "Deploy"; //--- ToDo: Localize;
	x = 0.631771 * safezoneW + safezoneX;
	y = 0.73091 * safezoneH + safezoneY;
	w = 0.0973958 * safezoneW;
	h = 0.0439828 * safezoneH;
	tooltip = "Press Deploy to get into the action"; //--- ToDo: Localize;
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
class CP_gearPanelCommander: RscShortcutButton
{
	idc = 1700;
	text = "Commander"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.280086 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelAR: RscShortcutButton
{
	idc = 1701;
	text = "Automatic Rifleman"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelRifleman: RscShortcutButton
{
	idc = 1702;
	text = "Rifleman"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class RscShortcutButton_1703: RscShortcutButton
{
	idc = 1703;
	text = "Anti-Tank"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCorpsman: RscShortcutButton
{
	idc = 1704;
	text = "Corpsman"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelMarksman: RscShortcutButton
{
	idc = 1705;
	text = "Marksman"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.554979 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelSpecialist: RscShortcutButton
{
	idc = 1706;
	text = "Specialist"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCrewman: RscShortcutButton
{
	idc = 1707;
	text = "Crewman"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelPilot: RscShortcutButton
{
	idc = 1708;
	text = "Pilot"; //--- ToDo: Localize;
	x = 0.276563 * safezoneW + safezoneX;
	y = 0.719914 * safezoneH + safezoneY;
	w = 0.131771 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCommanderGear: RscButton
{
	idc = 1605;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.280086 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCommanderUni: RscButton
{
	idc = 1614;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.280086 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelARGear: RscButton
{
	idc = 1606;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelRiflemanGear: RscButton
{
	idc = 1607;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class RscButton_1608: RscButton
{
	idc = 1608;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCorpsmanGear: RscButton
{
	idc = 1609;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelMarksmanGear: RscButton
{
	idc = 1610;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.554979 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelSpecialistGear: RscButton
{
	idc = 1611;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCrewmanGear: RscButton
{
	idc = 1612;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelPilotGear: RscButton
{
	idc = 1613;
	text = "Gear"; //--- ToDo: Localize;
	x = 0.414063 * safezoneW + safezoneX;
	y = 0.719914 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelARUni: RscButton
{
	idc = 1615;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelRiflemanUni: RscButton
{
	idc = 1616;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.390043 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class RscButton_1617: RscButton
{
	idc = 1617;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCorpsmanUni: RscButton
{
	idc = 1618;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelMarksmanUni: RscButton
{
	idc = 1619;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.554979 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelSpecialistUni: RscButton
{
	idc = 1620;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelCrewmanUni: RscButton
{
	idc = 1621;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.664936 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
class CP_gearPanelPilotUni: RscButton
{
	idc = 1622;
	text = "Uniforms"; //--- ToDo: Localize;
	x = 0.471354 * safezoneW + safezoneX;
	y = 0.719914 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.0439828 * safezoneH;
	colorBackground[] = {1,0,0,0.3};
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
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
