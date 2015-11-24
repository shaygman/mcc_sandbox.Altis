//==================================================================MCC_fnc_isSurvivalObject=====================================================================================
// is an object is a survival object
// Example:[]  call MCC_fnc_isSurvivalObject;
// <IN>
//	none
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private ["_positionStart","_positionEnd","_pointIntersect","_selected","_resault","_objArray"];
if (!(missionNamespace getVariable ["MCC_surviveMod",false])  && !(missionNamespace getVariable ["MCC_iniDBenabled",false])) exitWith {};
if !(missionNamespace getVariable ["MCC_surviveMod",false]) exitWith {false};

//Get what object spawn loot
{
	if (isNil _x) then {
		if (isClass (missionconfigFile >> "CfgMCCspawnObjects" >> _x)) then {
			missionNamespace setVariable [_x,getArray (missionconfigFile >> "CfgMCCspawnObjects" >> _x >> "itemClasses")];
		} else {
			missionNamespace setVariable [_x,getArray (configFile >> "CfgMCCspawnObjects" >> _x >> "itemClasses")];
		};
	};
} forEach ["MCC_barrels","MCC_grave","MCC_containers","MCC_food","MCC_fuel","MCC_plantsFruit","MCC_misc","MCC_garbage","MCC_wreck","MCC_wreckMil","MCC_wreckSub","MCC_ammoBox"];

//Not MCC object
_positionStart 	= eyePos player;
_positionEnd 	= ATLtoASL screenToWorld [0.5,0.5];
_pointIntersect = lineIntersectsWith [_positionStart, _positionEnd, player, objNull, true];
_resault = false;
if (count _pointIntersect > 0) then {
	_selected = _pointIntersect select ((count _pointIntersect)-1);

	if (player distance _selected < 5) then {
		_objArray = MCC_barrels + MCC_grave + MCC_containers + MCC_food + MCC_fuel + MCC_misc + MCC_plantsFruit + MCC_garbage + MCC_wreck + MCC_wreckMil + MCC_wreckSub + MCC_ammoBox;

		if ((({[_x , str _selected] call BIS_fnc_inString} count _objArray)>0) && (isNull attachedTo _selected)) then {
			_resault = true;
			//_null= [_selected] execvm "mcc\fnc\interaction\fn_interactObject.sqf";
			//[_selected] call MCC_fnc_interactObject;
		};
	};
};

_resault