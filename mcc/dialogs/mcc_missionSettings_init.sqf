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
#define mcc_saveGearComboIDC 8412
#define mcc_showGRPMarkerComboIDC 8413
#define mcc_showMessagesComboIDC 8414

#define MCC_timeExcelIDC 8419
#define MCC_AISmokeIDC 8420
#define MCC_AISmokeChanceIDC 8421
#define MCC_GAIACacheDistanceIDC 8422
#define MCC_GAIAControllIDC 8423
#define MCC_GAIAArtilleryDelayIDC 8424

#define mcc_deletePlayerBodyIDC 8425


MCC_aiSkillIndex		= (MCC_AI_Skill*10)-1;
MCC_aiAimIndex			= (MCC_AI_Aim*10)-1;
MCC_aiSpotIndex			= (MCC_AI_Spot*10)-1;
MCC_aiCommandIndex		= (MCC_AI_Command*10)-1;
private ["_mccdialog","_comboBox","_displayname"];
disableSerialization;
_mccdialog = findDisplay missionSettings_IDD;

//Resistance Hostile To
_comboBox = _mccdialog displayCtrl RESISTANCE_HOSTILE;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["All","East","West"];
_comboBox lbSetCurSel (missionNamespace getVariable ["RESISTANCE_HOSTILE_index",0]);

//Teleport To Team
_comboBox = _mccdialog displayCtrl T2T_AD;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","JIP Only","After Respawn","Always"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_t2tIndex",1]);

//AI Skill
_comboBox = _mccdialog displayCtrl AI_SKILL;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_aiSkillIndex",(MCC_AI_Skill*10)-1]);

//AI Aim
_comboBox = _mccdialog displayCtrl AI_AIM;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_aiAimIndex",(MCC_AI_Aim*10)-1]);

//AI Spot
_comboBox = _mccdialog displayCtrl AI_SPOT;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_aiSpotIndex",(MCC_AI_Spot*10)-1]);

//AI Command
_comboBox = _mccdialog displayCtrl AI_COMMAND;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Rookie","20","30","40","50","60","70","80","90","Veteran"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_aiCommandIndex",(MCC_AI_Command*10)-1]);

//Console GPS
_comboBox = _mccdialog displayCtrl MCC_MSCONSOLEGPS;
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["Enabled","Disabled"];
_comboBox lbSetCurSel (if (missionNamespace getVariable ["MCC_ConsoleOnlyShowUnitsWithGPS",false]) then {1} else {0});

//Console Show Friendly
_comboBox = _mccdialog displayCtrl MCC_MSCONSOLESHOWFRIENDS;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Enabled","Disabled"];
_comboBox lbSetCurSel (if (missionNamespace getVariable ["MCC_ConsoleDrawWP",false]) then {0} else {1});

//Console Command AI
_comboBox = _mccdialog displayCtrl MCC_MSCONSOLECOMMANDAI;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Enabled","Disabled"];
_comboBox lbSetCurSel (if (missionNamespace getVariable ["MCC_ConsoleCanCommandAI",false]) then {0} else {1});

//Show name tags
_comboBox = _mccdialog displayCtrl MCC_IDCNAMETAGS;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Enabled","Disabled"];
_comboBox lbSetCurSel (if (missionNamespace getVariable ["MCC_nameTags",false]) then {0} else {1});

//Artillery Computer
_comboBox = _mccdialog displayCtrl mcc_artilleryTitleIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_artilleryComputerIndex",1]);

//Save Gear
_comboBox = _mccdialog displayCtrl mcc_saveGearComboIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_saveGearIndex",0]);

//Group Markers
_comboBox = _mccdialog displayCtrl mcc_showGRPMarkerComboIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel ( if (missionNamespace getVariable ["MCC_groupMarkers",true]) then {1} else {0});

//Messages
_comboBox = _mccdialog displayCtrl mcc_showMessagesComboIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_MessagesIndex",1]);

//Time Excel
_comboBox = _mccdialog displayCtrl MCC_timeExcelIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Normal","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_timeExcelIndex",0]);

//AI use Smoke
_comboBox = _mccdialog displayCtrl MCC_AISmokeIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_AISmokeIndex",1]);

//AI use Smoke Chance
_comboBox = _mccdialog displayCtrl MCC_AISmokeChanceIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Low","Normal","High"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_AISmokeChanceIndex",1]);

//GAIA Cache distance
_comboBox = _mccdialog displayCtrl MCC_GAIACacheDistanceIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["500","1,000","1,500","2,000","2,500","3,000","3,500","4,000","5,000"];
_comboBox lbSetCurSel floor ((missionNamespace getVariable ["GAIA_CACHE_STAGE_1",500])/500)-1;

//GAIA controlls
_comboBox = _mccdialog displayCtrl MCC_GAIAControllIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Only GAIA units","Everyone"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_GAIAControllIndex",0]);

//GAIA Artillery
_comboBox = _mccdialog displayCtrl MCC_GAIAArtilleryDelayIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["1min","2min","3min","4min","5min","6min","7min","8min","9min","10min"];
_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_GAIAArtilleryDelayIndex",4]);

//Delete Players body
_comboBox = _mccdialog displayCtrl mcc_deletePlayerBodyIDC;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
_comboBox lbSetCurSel (missionNamespace getVariable ["mcc_deletePlayerBodyIndex",0]);

_tempArray = [];
{
	_tempArray pushBack (missionNameSpace getVariable [_x,false]);
} foreach ["MCC_interaction","MCC_surviveMod","MCC_cover","MCC_coverUI","MCC_showActionKey","MCC_coverVault","MCC_quickWeaponChange","MCC_ingameUI","MCC_allowRTS"];

for "_i" from 8427 to 8435 do
{
	_comboBox = _mccdialog displayCtrl _i;
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Disabled","Enabled"];
	_comboBox lbSetCurSel (if (_tempArray select (_i - 8427)) then {1} else {0});
};