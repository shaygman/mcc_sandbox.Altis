/*======================================================MCC_fnc_campaignGetBorders=====================================================================================================
 find the borders or a selected zone by his tiles
 Example:[_pos/object/side,_natural] call MCC_fnc_campaignGetBorders;
 0: ARRAY|OBJECT position or object to search around
 1: BOOLEAN (optional) will retrun borders that are not next to different faction border such as next to sea
 <RETURN>
 	ARRAY
 	0: ARRAY - borders tiles
========================================================================================================================================================================================*/
private ["_pos","_natural","_centerTile","_centerTileName","_centerTileSide","_allTiles","_yTiles","_markerColor","_notAcceptedColors","_yBorder","_xBorder","_bordersArray"];
_pos = param [0,objNull,[objNull,[],sideLogic]];
_natural = param [1,false,[false]];

switch (typeName _pos) do {
	case (typeName sideLogic):
	{
		_centerTileName = "";
		_centerTileSide = _pos;
	};

	default {
		//Lets find all the markers around
		_centerTile = [_pos,1000] call MCC_fnc_campaignGetNearestTile;

		_centerTileName = _centerTile select 0;
		_centerTileSide = _centerTile select 1;
	};
};


_markerColor = switch (_centerTileSide) do
					{
						case west: {"ColorWEST"};
						case resistance: {"ColorGUER"};
						case east: {"ColorEAST"};
						default	{""};
					};

//find natural
_notAcceptedColors = if (_natural) then {[_markerColor]} else {["",_markerColor]};

//Lets find all the borders tiles on the map first
_allTiles = missionNamespace getVariable ["mcc_markersZonesExc",[]];
_bordersArray = [];

//create boxes
_yBorder = (count _allTiles)-1;

for "_y" from 0 to _yBorder step 1 do {
	_yTiles = _allTiles select _y;
	_xBorder = (count _yTiles)-1;

	for "_x" from 0 to (count _yTiles)-1 step 1 do {
		_selectedTile = _yTiles select _x;

		//is the tile from the selected side?
		if (getMarkerColor _selectedTile == _markerColor) then {

			//do we have border
			if (!((getMarkerColor ((_allTiles select (_y-1 max 0)) select (_x -1 max 0))) in _notAcceptedColors) ||
			     !((getMarkerColor ((_allTiles select (_y-1 max 0)) select _x) in _notAcceptedColors)) ||
			     !((getMarkerColor ((_allTiles select (_y-1 max 0)) select (_x+1 min _xBorder))) in _notAcceptedColors) ||
			     //down
			     !((getMarkerColor ((_allTiles select (_y+1 min _yBorder)) select (_x -1 max 0))) in _notAcceptedColors) ||
			     !((getMarkerColor ((_allTiles select (_y+1 min _yBorder)) select _x) in _notAcceptedColors)) ||
			     !((getMarkerColor ((_allTiles select (_y+1 min _yBorder)) select (_x+1 min _xBorder))) in _notAcceptedColors) ||
			     //sides
			     !((getMarkerColor (_yTiles select (_x-1 max 0))) in _notAcceptedColors) ||
			     !((getMarkerColor (_yTiles select (_x+1 min _xBorder))) in _notAcceptedColors)
			    ) then {
					_bordersArray pushBack _selectedTile;
			};
		};
	};
};

_bordersArray
