//==================================================================MCC_fnc_GAIASettings===============================================================================================
// module
// Example: [] call MCC_fnc_GAIASettings;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_logic","_var","_name","_string","_desc","_action","_preTask","_pos","_side"];

_logic	= _this select 0;

//AI skill - gen
MCC_AI_Skill = _logic getvariable ["aiSkillGen",0.5];

//AI skill - aim
MCC_AI_Aim = _logic getvariable ["aiSkillAim",0.5];

//AI skill - spot
MCC_AI_Spot = _logic getvariable ["aiSkillSpot",0.5];

//AI skill - command
MCC_AI_Command = _logic getvariable ["aiSkillCommand",0.5];

//AI smoke
MCC_GAIA_AMBIANT = _logic getvariable ["aiSmoke",true];

//AI Smoke Chance
_var 	= _logic getvariable ["aiSmokeChance",1];
missionNamespace setVariable ["MCC_AISmokeChanceIndex",_var];
MCC_GAIA_AMBIANT_CHANCE = (_var+1)*20;

//GAIA Cache
GAIA_CACHE_STAGE_1 = (_logic getvariable ["cacheDistance",3000]);
	
//GAIA control
MCC_GAIA_ATTACKS_FOR_NONGAIA = _logic getvariable ["gaiacontrol",true];