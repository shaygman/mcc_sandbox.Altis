//==================================================================MCC_fnc_addILSChildrenACE====================================================================================
// Add ILS childs to ACE Menu
// Example:_ctrl  call MCC_fnc_addILSChildrenACE;
// <IN>
//	_ctrl:					Control
//
// <OUT>
//		Action
//===========================================================================================================================================================================
private ["_player","_vehicle","_params","_actions","_airports","_counter","_searchArray","_sides","_airportName","_airportVars"];
_vehicle = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_player = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_params = [_this, 2, [], [[]]] call BIS_fnc_param;


//Search airports
_airports = [];
_counter = 0;
_searchArray = if (MCC_isMode) then {allMissionObjects "mcc_sandbox_moduleILS"} else {allMissionObjects "logic"};

{
	_sides = _x getVariable ["MCC_runwaySide",-1];
	_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]};

	if (((_x getVariable ["MCC_runwayDis",0])>0) && (playerside in _sides)) then
	{
		_airports set [_counter,[_x,(_x getVariable ["MCC_runwayName","Runway"]),(_x getVariable ["MCC_runwayDis",0]),(_x getVariable ["MCC_runwayAG",objNull]),(_x getVariable ["MCC_runwayCircles",true])]];
		_counter = _counter +1;
	};
} foreach _searchArray;

//No other way to move object name that will work in SP thanks BIS for picking non-logical names from objects as ALPHA B: 1-20
player setVariable ["interactWith",_airports];

//Add actions
_actions = [];
{
    _airportName = _x select 1;
    _airportVars = _x;

    _actions pushBack
        [
            [
                str (_x select 0),
                _airportName,
                "",
                compile format ["%1 spawn MCC_fnc_ilsChilds",_foreachIndex],
                {true}
            ] call ace_interact_menu_fnc_createAction,
            [],
            _unit
        ];
} forEach _airports;

_actions
