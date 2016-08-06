//======================================================MCC_fnc_campaignInitMap=========================================================================================================
// init the campaign map and create hostile markers
// Example:[_side,_size._alpha] call MCC_fnc_campaignInitMap;
// _side: SIDE the default side holding the island
// _size: INTEGER, the island will be divided to many boxes this is the default box size.
// _alpha: INTEGER, defual box alpha marker
//========================================================================================================================================================================================
private ["_mapSize","_markersArray","_size","_marker","_tempArray","_fnc_isWater","_markerName","_side","_markerColor","_alpha","_xCounter","_yCounter"];
_side = param [0,sideLogic,[west]];
_size = param [1,250,[0]];;
_alpha = param [2,0.3,[0]];

_mapSize = getnumber (( configfile >> "cfgworlds" >> worldname) >> "mapSize");
if (_mapSize == 0) then {_mapSize = 10000};
_markersArray = [];
_tempArray = [];
_xCounter = 0;
_yCounter = 0;

_markerColor = switch (_side) do
				{
					case west: {"ColorWEST"};
					case resistance: {"ColorGUER"};
					default	{"ColorEAST"};
				};
//create boxes
for "_y" from 0 to _mapSize step _size*2 do {
	for "_x" from 0 to _mapSize step _size*2 do {
		if (!surfaceIsWater [_x,_y] ||
		    !surfaceIsWater [_x+_size,_y] ||
			!surfaceIsWater [_x,_y +_size] ||
			!surfaceIsWater [_x+_size,_y+_size]) then {

			_markerName = format ["MCCCampaignMarker_%1_%2", _xCounter,_yCounter];
			_marker = createMarker [_markerName, [_x,_y,0]];
			_marker setMarkerShape "RECTANGLE";
			_marker setMarkerBrush "SolidFull";
			_marker setMarkerSize [_size,_size];
			_marker setMarkerColor _markerColor;
			_marker setMarkerAlpha _alpha;
			_tempArray pushBack _markerName;
			sleep 0.001;
		} else {
			_tempArray pushBack "";
		};

		_xCounter = _xCounter + 1;
	};

	//found some land cache it
	if (count _tempArray > 0) then {
		_markersArray pushBack _tempArray;
		_tempArray = [];
	};

	_yCounter = _yCounter + 1;
};

missionNamespace setVariable ["mcc_markersZonesExc",_markersArray];
