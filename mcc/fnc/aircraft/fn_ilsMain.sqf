//==================================================================MCC_fnc_ilsMain===============================================================================================
// ILS for aircrafts based on ILS Pro II 1.0 (by TiGGa)
//Call from an ILS logic
//===========================================================================================================================================================================	
private ["_unit","_airports","_null","_string","_actionsIndex","_counter","_searchArray"]; 
waituntil {alive player}; 
_unit 		= _this select 0;

//Find all allegeable airports
_airports = []; 
_counter = 0;
_searchArray = if (MCC_isMode) then {allMissionObjects "mcc_sandbox_moduleILS"} else {allMissionObjects "logic"}; 

{
	_sides = _x getVariable ["MCC_runwaySide",-1];
	_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]}; 
	if (((_x getVariable ["MCC_runwayDis",0])>0) && (playerside in _sides))then
	{
		_airports set [_counter,[_x,(_x getVariable ["MCC_runwayName","Runway"]),(_x getVariable ["MCC_runwayDis",0]),(_x getVariable ["MCC_runwayAG",false]),(_x getVariable ["MCC_runwayCircles",true])]]; 
		_counter = _counter +1;
	};
} foreach _searchArray;

//Add action to each runway
_actionsIndex = []; 
// && !(isTouchingGround vehicle _this)
_string = "(vehicle _this isKindOf 'Plane') && (_this == Driver vehicle _this)";
{
	_null = _unit addaction ["<t color=""#01ffcc"">"+ format ["Land %1",_x select 1] +"</t>",{_this call MCC_fnc_ilsChilds},[_x select 0, _x select 1, _x select 2, _x select 3, _x select 4],-1,false,true,"teamSwitch",_string];
	_actionsIndex set [count _actionsIndex, _null];
} foreach _airports;

// Add close action
_null = _unit addaction ["<t color=""#006651"">Close ILS</t>", {{player removeAction _x} foreach (player getVariable ["MCC_ilsActionsIndex",[]])},[],-1,false,true,"teamSwitch",_string];
_actionsIndex set [count _actionsIndex, _null];

_unit setVariable ["MCC_ilsActionsIndex",_actionsIndex];