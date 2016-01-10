//Made by Shay_Gman (c) 09.11
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

private ["_string", "_resistanceHostile", "_AiSkill","_value","_t2t","_code"];
disableSerialization;

if !mcc_isloading then
{
	//Reistance relations
	_string = "";
	_resistanceHostile = lbCurSel RESISTANCE_HOSTILE;
	missionNamespace setVariable ["RESISTANCE_HOSTILE_index",lbCurSel RESISTANCE_HOSTILE];
	publicvariable "RESISTANCE_HOSTILE_index";

	//Teleport2Team param
	_t2t = lbCurSel T2T_AD;
	missionNamespace setVariable ["MCC_t2tIndex",lbCurSel T2T_AD];
	publicVariable "MCC_t2tIndex";
	if (_t2t == 0) then {_string = _string + "MCC_teleportToTeam = false;";MCC_teleportToTeam = false; publicvariable "MCC_teleportToTeam";};

	switch (_resistanceHostile) do
	{
		case 0:
		{
		_string = _string + "
					resistance setfriend [east, 0];
					resistance setfriend [west, 0];
					east setfriend [resistance, 0];
					west setFriend [resistance, 0];
					";
		};

		case 1:
		{
		_string = _string + "
					resistance setfriend [east, 0];
					resistance setfriend [west, 0.7];
					east setfriend [resistance, 0];
					west setFriend [resistance, 0.7];
					";
		};

		case 2:
		{
		_string = _string + "
				resistance setfriend [east, 0.7];
				resistance setfriend [west, 0];
				east setfriend [resistance, 0.7];
				west setFriend  [resistance, 0];
				";
		};
	};

	if (_string != "") then {[[2,compile _string], "MCC_fnc_globalExecute", true, true] spawn BIS_fnc_MP};

	//AI Skill
	_AiSkill = (((lbCurSel AI_SKILL)+1)/10);
	missionNamespace setVariable ["MCC_aiSkillIndex",lbCurSel AI_SKILL];
	publicvariable "MCC_aiSkillIndex";
	MCC_AI_Skill = _AiSkill;
	publicvariable "MCC_AI_Skill";

	//AI_AIM
	_AiSkill = (((lbCurSel AI_AIM)+1)/10);
	missionNamespace setVariable ["MCC_aiAimIndex",lbCurSel AI_AIM];
	publicvariable "MCC_aiAimIndex";
	MCC_AI_Aim = _AiSkill;
	publicvariable "MCC_AI_Aim";

	//AI Spot
	_AiSkill = (((lbCurSel AI_SPOT)+1)/10);
	missionNamespace setVariable ["MCC_aiSpotIndex",lbCurSel AI_SPOT];
	publicvariable "MCC_aiSpotIndex";
	MCC_AI_Spot = _AiSkill;
	publicvariable "MCC_AI_Spot";

	//AI_COMMAND
	_AiSkill = (((lbCurSel AI_COMMAND)+1)/10);
	missionNamespace setVariable ["MCC_aiCommandIndex",lbCurSel AI_COMMAND];
	publicvariable "MCC_aiCommandIndex";
	MCC_AI_Command = _AiSkill;
	publicvariable "MCC_AI_Command";

	//CONSOLE
	MCC_ConsoleOnlyShowUnitsWithGPS = lbCurSel MCC_MSCONSOLEGPS == 1;
	publicvariable "MCC_ConsoleOnlyShowUnitsWithGPS";

	//CONSOLE
	MCC_ConsoleDrawWP = lbCurSel MCC_MSCONSOLESHOWFRIENDS == 0;
	MCC_ConsolePlayersCanSeeWPonMap = lbCurSel MCC_MSCONSOLESHOWFRIENDS == 0;
	publicvariable "MCC_ConsoleDrawWP";
	publicvariable "MCC_ConsolePlayersCanSeeWPonMap";

	//CONSOLE
	MCC_ConsoleCanCommandAI = lbCurSel MCC_MSCONSOLECOMMANDAI == 0;
	publicvariable "MCC_ConsoleCanCommandAI";

	//NameTags
	missionNamespace setVariable ["MCC_nameTagsIndex",lbCurSel MCC_IDCNAMETAGS];
	publicvariable "MCC_nameTagsIndex";
	MCC_nameTags = (lbCurSel MCC_IDCNAMETAGS) == 0;
	publicvariable "MCC_nameTags";

	//Save gear EH
	missionNamespace setVariable ["MCC_saveGearIndex",lbCurSel mcc_saveGearComboIDC];
	publicvariable "MCC_saveGearIndex";
	MCC_saveGear = if ((lbCurSel mcc_saveGearComboIDC) == 0) then {false} else {true};
	publicvariable "MCC_saveGear";

	//Group Markers
	MCC_groupMarkers = if ((lbCurSel mcc_showGRPMarkerComboIDC) == 0) then {false} else {true};
	publicvariable "MCC_groupMarkers";

	//Group Markers
	missionNamespace setVariable ["MCC_MessagesIndex",lbCurSel mcc_showMessagesComboIDC];
	publicvariable "MCC_MessagesIndex";
	MCC_Chat = if ((lbCurSel mcc_showMessagesComboIDC) == 0) then {false} else {true};
	publicvariable "MCC_Chat";

	//Artillery computer
	missionNamespace setVariable ["MCC_artilleryComputerIndex",lbCurSel mcc_artilleryTitleIDC];
	publicvariable "MCC_artilleryComputerIndex";
	if ((lbCurSel mcc_artilleryTitleIDC) == 0) then
	{
		[[2,compile format ["enableEngineArtillery false"]], "MCC_fnc_globalExecute", true, true] spawn BIS_fnc_MP;
	}
	else
	{
		[[2,compile format ["enableEngineArtillery true"]], "MCC_fnc_globalExecute", true, true] spawn BIS_fnc_MP;
	};

	//Time Excel
	missionNamespace setVariable ["MCC_timeExcelIndex",lbCurSel MCC_timeExcelIDC];
	publicvariable "MCC_timeExcelIndex";
	if (MCC_timeExcelIndex > 0) then
	{
		[compile format ["setTimeMultiplier %1",(MCC_timeExcelIndex+1)], "BIS_fnc_spawn", false, false] spawn BIS_fnc_MP;
	};

	//AI Smoke
	missionNamespace setVariable ["MCC_AISmokeIndex",lbCurSel MCC_AISmokeIDC];
	publicvariable "MCC_AISmokeIndex";
	MCC_GAIA_AMBIANT = if (MCC_AISmokeIndex == 0) then {false} else {true};
	publicvariable "MCC_GAIA_AMBIANT";

	//AI Smoke Chance
	missionNamespace setVariable ["MCC_AISmokeChanceIndex",lbCurSel MCC_AISmokeChanceIDC];
	publicvariable "MCC_AISmokeChanceIndex";
	MCC_GAIA_AMBIANT_CHANCE = (MCC_AISmokeChanceIndex+1)*20;
	publicvariable "MCC_GAIA_AMBIANT_CHANCE";

	//GAIA Cache
	GAIA_CACHE_STAGE_1 = ((lbCurSel MCC_GAIACacheDistanceIDC)+1)*500;
	publicvariable "GAIA_CACHE_STAGE_1";

	//GAIA control
	missionNamespace setVariable ["MCC_GAIAControllIndex",lbCurSel MCC_GAIAControllIDC];
	publicvariable "MCC_GAIAControllIndex";
	MCC_GAIA_ATTACKS_FOR_NONGAIA = if (MCC_GAIAControllIndex == 0) then {false} else {true};
	publicvariable "MCC_GAIA_ATTACKS_FOR_NONGAIA";

	//GAIA Artillery
	missionNamespace setVariable ["MCC_GAIAArtilleryDelayIndex",lbCurSel MCC_GAIAArtilleryDelayIDC];
	publicvariable "MCC_GAIAArtilleryDelayIndex";
	MCC_GAIA_MORTAR_TIMEOUT = (MCC_GAIAArtilleryDelayIndex+1)*60;
	publicvariable "MCC_GAIA_MORTAR_TIMEOUT";

	//Delete players body
	missionNamespace setVariable ["mcc_deletePlayerBodyIndex",lbCurSel mcc_deletePlayerBodyIDC];
	publicvariable "mcc_deletePlayerBodyIndex";
	MCC_deletePlayersBody = if ((lbCurSel mcc_deletePlayerBodyIDC) == 0) then {false} else {true};
	publicvariable "MCC_deletePlayersBody";

	private ["_tempArray","_var"];
	_tempArray = ["MCC_interaction","MCC_surviveMod","MCC_cover","MCC_coverUI","MCC_showActionKey","MCC_coverVault","MCC_quickWeaponChange","MCC_ingameUI","MCC_allowRTS"];

	for "_i" from 8427 to 8435 do {
		_var = _tempArray select (_i-8427);
		missionNameSpace setVariable [_var, if ((lbCurSel _i)==0) then {false} else {true}];
		publicVariable _var;
	};

	//fire local EH
	if (missionNamespace getVariable ["MCC_surviveMod",false]) then {
		[] spawn MCC_fnc_surviveInit;
	};

	Hint "Mission Settings Saved";
    closedialog 0;
};