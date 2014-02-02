//======================================================MCC_fnc_countDownLine=========================================================================================================
// BIS AdvHints function.  Create a filling waiting bar - made by BIS all credits to them
// Example: _footer = [_min,_max] call MCC_fnc_countDownLine; 
// _min = integer, minimum value.
// _max = integer, maximum value.
//========================================================================================================================================================================================
private ["_elapsed","_max","_line","_char","_i","_segments","_segmentsElapsed","_segmentsRemaining"];

_elapsed = _this select 0;

if (count(_this) > 1) then {
	_max = _this select 1;
};	
if isNil("_max") then {
	_max = 10;
};

//number of countdown segments
_segments = 20;

_segmentsElapsed = round(_elapsed/_max * _segments);
_segmentsRemaining = _segments - _segmentsElapsed;

if (_segmentsElapsed > _segments) then {
	_segmentsElapsed = _segments;
	_segmentsRemaining = 0;
};

_char = "|";

_line = "<t color='#818960'>";

for "_i" from 1 to _segmentsElapsed do 
{
	_line = _line + _char;
};
_line = _line + "</t>";

if (_segmentsRemaining > 0) then {
	_line = _line + "<t color='#000000'>";
	for "_i" from 1 to _segmentsRemaining do 
	{
		_line = _line + _char;
	};
	_line = _line + "</t>";
};
_line
