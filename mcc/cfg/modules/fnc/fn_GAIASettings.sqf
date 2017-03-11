//==================================================================MCC_fnc_GAIASettings===============================================================================================
// module
// Example: [] call MCC_fnc_GAIASettings;
// _group1 = group, the group name
//===========================================================================================================================================================================
private ["_module","_var","_name","_string","_desc","_action","_preTask","_pos","_side"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};


if (typeName (_module getVariable ["aiSkillGen",true]) == typeName 0) exitWith {

	//AI skill - gen
	MCC_AI_Skill = 0.1 * (_module getvariable ["aiSkillGen",5]);

	//AI skill - aim
	MCC_AI_Aim = 0.1 * (_module getvariable ["aiSkillAim",5]);

	//AI skill - spot
	MCC_AI_Spot = 0.1 * (_module getvariable ["aiSkillSpot",5]);

	//AI skill - command
	MCC_AI_Command = 0.1 * (_module getvariable ["aiSkillCommand",5]);

	//AI smoke
	MCC_GAIA_AMBIANT = _module getvariable ["aiSmoke",true];

	//AI Smoke Chance
	_var 	= _module getvariable ["aiSmokeChance",1];
	missionNamespace setVariable ["MCC_AISmokeChanceIndex",_var];
	MCC_GAIA_AMBIANT_CHANCE = (_var+1)*20;

	//GAIA Cache
	GAIA_CACHE_STAGE_1 = (_module getvariable ["cacheDistance",3000]);

	//GAIA control
	MCC_GAIA_ATTACKS_FOR_NONGAIA = _module getvariable ["gaiacontrol",true];
};

//Not curator exit
if !(local _module) exitWith {};

_resualt = ["Settings GAIA",[
 						["AI skill",10],
 						["AI Aimming",10],
 						["AI Spotting",10],
 						["AI Commanding",10],
 						["AI Use Smoke Grenades",["Never","Rarely","Sometimes","Often"]],
 						["Cache Distance",10000],
 						["GAIA controlls all units",false]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

//AI skills
{
	missionNamespace setVariable [_x,((_resualt select _foreachindex)*0.1) max 1];
	publicvariable _x;
} forEach ["MCC_AI_Skill",
           "MCC_AI_Aim",
           "MCC_AI_Spot",
           "MCC_AI_Command"];

//AI smoke
MCC_GAIA_AMBIANT = (_resualt select 4) != 0;
publicvariable "MCC_GAIA_AMBIANT";

//AI Smoke Chance
MCC_GAIA_AMBIANT_CHANCE = (_resualt select 4)*20;
publicvariable "MCC_GAIA_AMBIANT_CHANCE";

//GAIA Cache
GAIA_CACHE_STAGE_1 = (_resualt select 4) max 500;
publicvariable "GAIA_CACHE_STAGE_1";

//GAIA control
MCC_GAIA_ATTACKS_FOR_NONGAIA = (_resualt select 5);
publicvariable "MCC_GAIA_ATTACKS_FOR_NONGAIA";

deleteVehicle _module;
