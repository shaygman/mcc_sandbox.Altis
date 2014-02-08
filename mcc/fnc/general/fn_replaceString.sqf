//======================================================MCC_fnc_replaceString=========================================================================================================
// Filter a string and removes certain string ( _filter) and replace them with the new string
// Example:[_string,_filter, _new] call MCC_fnc_replaceString; 
// Return - string
//========================================================================================================================================================================================
private ["_text","_filter","_textArray","_filterArray","_new","_match","_replace","_break","_time","_i","_x","_currentCharacter"];
_text  	= _this select 0;
_filter = _this select 1;
_new	= _this select 2;

_textArray 		= toarray _text;
_filterArray 	= toarray _filter;
_replace 		= toArray _new;
_break			= false;
_time 			= time + 5;

for [{_x=0},{_x< (count _textArray)},{_x=_x+1}] do 
{
	_currentCharacter = _textArray select _x;
	if (_currentCharacter == _filterArray select 0) then
	{
		_match = true; 
		for [{_i=0},{_i< count _filterArray},{_i=_i+1}] do 
		{
			if (_textArray select (_x+_i) != _filterArray select _i) then {_match = false}; 
		};
		
		if (_match) then 
		{
			for [{_i=0},{_i< count _filterArray},{_i=_i+1}] do 
			{
				_textArray set [(_x+_i),-1]; 
			};
			_textArray = [_textArray, _replace, _x] call BIS_fnc_arrayInsert;
		};
	};
};

_textArray = _textArray - [-1];

tostring _textArray

				
		
