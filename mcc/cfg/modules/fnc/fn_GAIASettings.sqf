//==================================================================MCC_fnc_GAIASettings===============================================================================================
// module
// Example: [] call MCC_fnc_GAIASettings;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_logic","_var","_name","_string","_desc","_action","_preTask","_pos","_side"];

_logic	= _this select 0;

//AI skill - gen
MCC_AI_Skill = 0.1 * (_logic getvariable ["aiSkillGen",5]);

//AI skill - aim
MCC_AI_Aim = 0.1 * (_logic getvariable ["aiSkillAim",5]);

//AI skill - spot
MCC_AI_Spot = 0.1 * (_logic getvariable ["aiSkillSpot",5]);

//AI skill - command
MCC_AI_Command = 0.1 * (_logic getvariable ["aiSkillCommand",5]);

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
