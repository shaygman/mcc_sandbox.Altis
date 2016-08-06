/*======================================================MCC_fnc_campaignGetNearestTile=====================================================================================================
 find the nearest tile and return the [tile,side that holding]
 Example:[_pos/object,_radius] call MCC_fnc_campaignGetNearestTile;
 0: ARRAY|OBJECT position or object to search around
 1: INTEGER: (optional) radius to search around
 <RETURN>
 	ARRAY
 	0: STRING marker name - return empty string for none
 	1: SIDE side	- return sidelogic for none
========================================================================================================================================================================================*/
private ["_pos","_radius","_markers","_marker","_tempArray","_fnc_isWater","_markerName","_side","_markerColor","_alpha"];
_pos = param [0,objNull,[objNull,[]]];
_radius = param [1,1000,[0]];;

if (typeName _pos == typeName objNull) then {_pos = position _pos};


//Lets find all the markers around
_markers = [_pos,_radius,"MCCCampaignMarker_"] call MCC_fnc_findMarkers;

if (count _markers <= 0) exitWith {["",sideLogic]};

_markers = _markers apply { [markerpos _x distance2D _pos, _x] };
_markers sort true;

_closestMarker = (_markers select 0) select 1;

_sideMarker =switch (tolower (markerColor _closestMarker)) do
			{
				case "colorwest": {west};
				case "colorguer": {resistance};
				case "coloreast": {east};
				default	{sideUnknown};
			};

[_closestMarker,_sideMarker]