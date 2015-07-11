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

#define MCC_barrels ["garbagebarrel","garbagebin","toiletbox","garbagecontainer","fieldtoilet","tabledesk","cashdesk"]
#define MCC_grave ["grave_forest","grave_dirt","grave_rocks"]
#define MCC_containers ["barreltrash","metalbarrel_f","cratesplastic","cargo20","cargo40","crates"]
#define MCC_food ["icebox","rack","shelves","sacks_goods","basket","sack_f"]
//#define MCC_water ["water_source"]
#define MCC_fuel ["watertank","waterbarrel","barrelwater","stallwater"]
#define MCC_plantsFruit ["neriumo","ficusc"]
#define MCC_misc ["fishinggear","crabcages","rowboat","calvary","pipes_small","woodpile","pallets_stack","wheelcart"]
#define MCC_garbage ["garbagebags","junkpile","garbagepallet","tyres","garbagewashingmachine","scrapheap"]
#define MCC_wreck ["wreck_car","wreck_truck","wreck_offroad","wreck_van"]
#define MCC_wreckMil ["wreck_ural","wreck_uaz","wreck_hmmwv","wreck_heli","wreck_hunter","wreck_brdm","wreck_bmp","wreck_t72_hull","wreck_slammer"]
#define MCC_wreckSub ["uwreck"]
#define MCC_ammoBox ["woodenbox","luggageheap","pallet_milboxes_f"]

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