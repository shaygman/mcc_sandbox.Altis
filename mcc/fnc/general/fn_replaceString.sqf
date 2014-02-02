//======================================================MCC_fnc_replaceString=========================================================================================================
// Filter a string and removes certain string ( _filter) and replace them with the new string
// Example:[_string,_filter, _new] call MCC_fnc_replaceString; 
// Return - string
//========================================================================================================================================================================================
private ["_text","_filter","_textArray","_filterArray","_new","_match","_replace","_break"];
_text  	= _this select 0;
_filter = _this select 1;
_new	= _this select 2;

_textArray 		= toarray _text;
_filterArray 	= toarray _filter;
_replace 		= toArray _new;
_break			= false;

while {!_break} do
{
	{
		if (_x == _filterArray select 0) then
		{
			_match = true; 
			for [{_i=0},{_i< count _filterArray},{_i=_i+1}] do 
			{
				if (_textArray select (_foreachindex+_i) != _filterArray select _i) then {_match = false}; 
			};
			
			if (_match) then 
			{
				for [{_i=0},{_i< count _filterArray},{_i=_i+1}] do 
				{
					_textArray set [(_foreachindex+_i),-1]; 
				};
				_textArray = [_textArray, _replace, _foreachindex] call BIS_fnc_arrayInsert;
			};
		};
		if (_foreachindex == (count _textArray)-1) then {_break = true}; 
	} foreach _textArray;
};

_textArray = _textArray - [-1];

tostring _textArray

				
		
