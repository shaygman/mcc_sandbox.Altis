/*
	Author: Jiri Wainar (Warka)

	Description:
	Sorts an array according to given algorithm.

	Parameter(s):
	_this select 0: any unsorted array (Array)
		- array can contain any types (object/numbers/strings ..)

	_this select 1: input parameters (Array)
		- used in the eval algorithm (object/numbers/strings ..)
		- input params are referenced in the sorting algorithm by _input0, _input1 .. _input9
		- max. number of 10 input params is supported (0-9)

	_this select 2: sorted algorithm (Code) [optional: default {_x}]
		- code needs to return a scalar
		- variable _x refers to array item

	_this select 3: sort direction (String) [optional: default "ASCEND"]
		"ASCEND": sorts array in ascending direction (from lowest value to highest)
		"DESCEND": sorts array in descending direction

	_this select 4: filter (Code) [optional: default {true}]
		- code that needs to evaluate true for the array item to be sorted, otherwise item is removed

	Returns:
	Array

	Examples:

	//sort numbers from lowest to highest
	_sortedNumbers = [[1,-80,0,480,15,-40],[],{_x},"ASCEND"] call BIS_fnc_sortBy;

	//sort helicopters by distance from player
	_closestHelicopters = [[_heli1,_heli2,_heli3],[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy;

	//sort enemy by distance from friendly unit (referenced by local variable), the furtherest first
	_furtherstEnemy = [[_enemy1,_enemy2,_enemy3],[_friendly],{_input0 distance _x},"DESCEND",{canMove _x}] call BIS_fnc_sortBy;
*/

private ["_unsortedArray","_inputParams","_algorithm","_sortDirection","_filter","_removeElement","_values","_sortedArray","_sortedValues","_fnc_sort","_initValue","_sortCode"];

_unsortedArray 	= [_this, 0, [], [[]]] call BIS_fnc_param;
_inputParams	= [_this, 1, [], [[]]] call BIS_fnc_param;
_algorithm 		= [_this, 2, {_x}, [{}]] call BIS_fnc_param;
_sortDirection	= [_this, 3, "ASCEND", [""]] call BIS_fnc_param;
_filter			= [_this, 4, {true}, [{}]] call BIS_fnc_param;

_removeElement = "BIS_fnc_sortBy_RemoveMe";

if (count _unsortedArray == 0) exitWith {[]};

//create the input params
private["_input0","_input1","_input2","_input3","_input4","_input5","_input6","_input7","_input8","_input9"];

//--- ToDo: Pass arguments in _this instead of pre-defining limited number of input variables as below
_this = _inputParams;

_input0 = [_inputParams, 0, objNull] call BIS_fnc_param;
_input1 = [_inputParams, 1, objNull] call BIS_fnc_param;
_input2 = [_inputParams, 2, objNull] call BIS_fnc_param;
_input3 = [_inputParams, 3, objNull] call BIS_fnc_param;
_input4 = [_inputParams, 4, objNull] call BIS_fnc_param;
_input5 = [_inputParams, 5, objNull] call BIS_fnc_param;
_input6 = [_inputParams, 6, objNull] call BIS_fnc_param;
_input7 = [_inputParams, 7, objNull] call BIS_fnc_param;
_input8 = [_inputParams, 8, objNull] call BIS_fnc_param;
_input9 = [_inputParams, 9, objNull] call BIS_fnc_param;

//check the filter
{
	if !(call _filter) then
	{
		_unsortedArray set [_forEachIndex,_removeElement];
	};
}
forEach _unsortedArray;

//remove filtered-out items
_unsortedArray = _unsortedArray - [_removeElement];

//get the sort values
_values = [];

{
	private ["_algorithmTemp"];
	_algorithmTemp = _algorithm;

	//--- Wipe out all existing variables to prevent accidental overwriting (except of _values)
	private ["_unsortedArray","_inputParams","_algorithm","_sortDirection","_filter","_removeElement","_sortedArray","_sortedValues","_fnc_sort","_initValue","_sortCode"];

	//--- Evaluate the algorithm
	_values set [count _values,call _algorithmTemp];
}
forEach _unsortedArray;

//init sorted arrays
_sortedArray = [];
_sortedValues = [];

//handle ASCENDing vs. DESCENDing sorting
if (_sortDirection == "ASCEND") then
{
	_initValue = 1e9;
	_sortCode  = {_x < _selectedValue};
}
else
{
	_initValue = -1e9;
	_sortCode  = {_x > _selectedValue};
};

if (count _values > 0) then {
	while {count _values > 0} do {
		private["_selectedValue","_selectedItem","_selectedIndex"];

		_selectedValue = _initValue;

		{
			if (call _sortCode) then
			{
				_selectedValue = _x;
				_selectedItem = _unsortedArray select _forEachIndex;
				_selectedIndex = _forEachIndex;
			};
		}
		forEach _values;

		//store selected
		_sortedArray set [count _sortedArray,_selectedItem];
		_sortedValues set [count _sortedValues,_selectedValue];

		//remove stored from source pool
		_unsortedArray set [_selectedIndex,_removeElement];
		_unsortedArray = _unsortedArray - [_removeElement];
		_values set [_selectedIndex,_removeElement];
		_values = _values - [_removeElement];
	};
};

//return sorted array
_sortedArray