//======================================================MCC_fnc_campaignInitMap=========================================================================================================
// init the campaign map and create hostile markers
// Example:[_side,_size._alpha] call MCC_fnc_campaignInitMap;
// _side: SIDE the default side holding the island
// _size: INTEGER, the island will be divided to many boxes this is the default box size.
// _alpha: INTEGER, defual box alpha marker
// _locations : ARRAY of locations to mark the area around them as hot ex [[_pos1,"name1"],[_pos2,"name2"]]
// _hotAlpha : INTGER Alpha intensity of the hot area marker
//========================================================================================================================================================================================
private ["_mapSize","_markersArray","_size","_marker","_tempArray","_fnc_isWater","_markerName","_side","_markerColor","_alpha","_xCounter","_yCounter","_locations","_markerPos","_hotAlpha","_hotDistance","_markerSelected","_markerCenter"];
_side = param [0,sideLogic,[west]];
_size = param [1,250,[0]];;
_alpha = param [2,0.3,[0]];
_locations = param [3,[],[[]]];
_hotDistance = param [4,500,[0]];;
_hotAlpha = param [5,0.5,[0]];

_tempArray = [];
_markersArray = [];

//Check if we have stored info first
_allTiles = [format ["MCC_campaign_%1_%2",worldname,missionName], "CAMPAIGN_MARKERS", "row_0", "read",[],true] call MCC_fnc_handleDB;
if (count _allTiles > 0) then {

	//create markers
	for "_y" from 0 to 100 step 1 do {

		_allTiles = [format ["MCC_campaign_%1_%2",worldname,missionName], "CAMPAIGN_MARKERS", format ["row_%1", _y], "read",[],true] call MCC_fnc_handleDB;

		for "_x" from 0 to (count _allTiles)-1 step 1 do {
			_markerSelected = _allTiles select _x;

			if (count _markerSelected > 0) then {
				_markerName = format ["MCCCampaignMarker_%1_%2", _x,_y];
				_marker = createMarker [_markerName, (_markerSelected select 0)];
				_marker setMarkerShape "RECTANGLE";
				_marker setMarkerBrush "SolidFull";
				_marker setMarkerSize (_markerSelected select 1);
				_marker setMarkerColor (_markerSelected select 2);
				_marker setMarkerAlpha (_markerSelected select 3);

				_tempArray pushBack _markerName;
				sleep 0.001;
			} else {
				_tempArray pushBack "";
			};
		};

		//found some land cache it
		if (count _tempArray > 0) then {
			_markersArray pushBack _tempArray;
			_tempArray = [];
		};
	};
} else {

	_mapSize = getnumber (( configfile >> "cfgworlds" >> worldname) >> "mapSize");
	if (_mapSize == 0) then {_mapSize = 15000};
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

				_markerPos = [_x,_y,0];
				_markerName = format ["MCCCampaignMarker_%1_%2", _xCounter,_yCounter];
				_marker = createMarker [_markerName, _markerPos];
				_marker setMarkerShape "RECTANGLE";
				_marker setMarkerBrush "SolidFull";
				_marker setMarkerSize [_size,_size];
				_marker setMarkerColor _markerColor;

				//If near location mark it
				//|| (_x select 0) inArea _marker
				_markerCenter = [(_markerPos select 0) + _size, (_markerPos select 1) + _size,0];
				if ({(_x select 0) distance _markerCenter < _hotDistance || (_x select 0) inArea _marker} count _locations > 0) then {
					_marker setMarkerAlpha _hotAlpha;
				} else {
					_marker setMarkerAlpha _alpha;
				};

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
};

missionNamespace setVariable ["mcc_markersZonesExc",_markersArray];