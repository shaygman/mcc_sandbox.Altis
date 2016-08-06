//======================================================MCC_fnc_campaignPaintMarkers=======================================================================================================
// change all tiles in the given radius to show under the specific side control
// Example:[_centerPos,_radius,_side,_intense] call MCC_fnc_campaignPaintMarkers;
// _centerPos: POSITION where to start the change
// _radius: INTEGER, radius to change
// _intense: ARRAY or INTEGER, tile alpha either by number 0-1 or by array [min,max] example [0.1,0.5]
//_ignoreSide: SIDE optional if the zones are controled by this side don't do anything
//========================================================================================================================================================================================
private ["_centerPos","_radius","_side","_intense","_markers","_alpha","_markerColor","_marker","_closetMarkerPos","_closetDistance","_ignoreSide","_ignoreSideColors"];
_centerPos = param [0, [0,0,0], [[]]];
_radius = param [1, 200, [0]];
_side = param [2,sideLogic,[west]];
_intense = param [3,0.2,[0,[]]];
_ignoreSide =  param [4,[],[[]]];

_markerColor = switch (_side) do
					{
						case west: {"ColorWEST"};
						case resistance: {"ColorGUER"};
						default	{"ColorEAST"};
					};

//what side do we ignore
_ignoreSideColors = [];

{
	switch (_x) do
	{
		case west: {_ignoreSideColors pushBack "ColorWEST"};
		case resistance: {_ignoreSideColors pushBack "ColorGUER"};
		case east: {_ignoreSideColors pushBack "ColorEAST"};
	};
} forEach _ignoreSide;

//Lets find all the markers around
_markers = [_centerPos,_radius,"MCCCampaignMarker_"] call MCC_fnc_findMarkers;

if (count _markers <= 0) exitWith {diag_log "MCC_fnc_campaignPaintMarkers: Error - no markers found in the area"};

_markers = _markers apply { [markerpos _x distance2D _centerPos, _x] };
_markers sort true;

//The cente position should be the middle marker
_centerPos = markerpos ((_markers select 0) select 1);

for "_i" from 0 to (count _markers)-1 step 1 do	{
	_marker = (_markers select _i) select 1;

	//if we shouldn't ignore the marker
	if !(markerColor _marker in _ignoreSideColors) then {

		//inensity increase?
		_alpha = if (typeName _intense == typeName 0) then {_intense} else {(((1-(_centerPos distance2D markerpos _marker)/_radius)) min (_intense select 1)) max (_intense select 0)};
		_marker setMarkerColor _markerColor;
		_marker setMarkerAlpha _alpha;
	};
};
