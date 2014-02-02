#define missionSettings_IDD 2997

#define RESISTANCE_HOSTILE 8401 
#define T2T_AD 8402
#define AI_SKILL 8403 
#define AI_AIM 8404 
#define AI_SPOT 8405 
#define AI_COMMAND 8406
#define MCC_MSCONSOLEGPS 8407
#define MCC_MSCONSOLESHOWFRIENDS 8408
#define MCC_MSCONSOLECOMMANDAI 8409
#define MCC_IDCNAMETAGS 8410
#define mcc_artilleryTitleIDC 8411

private ["_mccdialog","_comboBox","_displayname"];
disableSerialization;
_mccdialog = findDisplay missionSettings_IDD;

_comboBox = _mccdialog displayCtrl RESISTANCE_HOSTILE; //Resistance Hostile To
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["All","East","West"];
_comboBox lbSetCurSel MCC_resistanceHostileIndex;

_comboBox = _mccdialog displayCtrl T2T_AD; //Teleport To Team
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","JIP Only","After Respawn"];
_comboBox lbSetCurSel MCC_t2tIndex;

_comboBox = _mccdialog displayCtrl AI_SKILL; //AI Skill
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel MCC_aiSkillIndex;

_comboBox = _mccdialog displayCtrl AI_AIM; //AI Aim
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel MCC_aiAimIndex;

_comboBox = _mccdialog displayCtrl AI_SPOT; //AI Spot
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel MCC_aiSpotIndex;

_comboBox = _mccdialog displayCtrl AI_COMMAND; //AI Command
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel MCC_aiCommandIndex;

_comboBox = _mccdialog displayCtrl MCC_MSCONSOLEGPS; //Console GPS
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["True","False"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MSCONSOLESHOWFRIENDS; //Console Show Friendly
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["True","False"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MSCONSOLECOMMANDAI; //Console Command AI
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["True","False"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_IDCNAMETAGS; //Show name tags
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl mcc_artilleryTitleIDC; //Artillery Computer
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel 1;
