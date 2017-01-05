//==================================================================MCC_fnc_createRestrictedZones=================================================================
/************************************************************
Author:	Shay_gman

Parameters: [ _sides<Array>,_time <Integer>,_air <boolean>,createMarker<boolean>]

_logic:	if called by a function always leave objNull
_sides: array containg the sides that will be punished.
_time: time need to ellapsed before punishment
_air: Should air unis be punished
_createMarker: Should we delete the marker after placment if not then the trigger will move with the marker if the marker is moved
Create a restriction zone on a marker defined in mission sqf init.sqf

Example:[[_logic, [east,west,resistance,civilian],10,false,false,false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;

************************************************************/
private ["_logic","_markerShape","_sides","_trg","_time","_air","_createMarker","_pos","_trgs","_location","_mName"];

_logic	= _this select 0;

//Did we got here by  a function call or by module
if (isNull _logic) then {
	_sides     	 	= _this select 1;
	_time       	= _this select 2;
	_air        	= _this select 3;
	_createMarker   = _this select 4;
} else {
	_sides 	= _logic getvariable ["sides",-1];
	_time 	= _logic getvariable ["time",10];
	_air 	= _logic getvariable ["air",true];
	_createMarker = _logic getvariable ["createMarker",true];

	_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]};
};

_trgs = [];
_markers = [];

if (isServer) then {
	//Get all triggers
	{
		if (typeOf _x == "LocationArea_F") then {
			_location = _x;
			{
				if (_x iskindof "EmptyDetector") then {
					_x setTriggerActivation["ANY","PRESENT",true];
					//Should we create markers for the trigger
					if (_createMarker) then {
						_mName = createMarker [str _x, getpos _x];
						_mName setMarkerColor "colorRed";
						_mName setMarkerShape (if ((triggerArea _x) select 3) then {"RECTANGLE"} else {"ELLIPSE"});
						_mName setMarkerSize [(triggerArea _x) select 0,(triggerArea _x) select 1];
						_mName setMarkerDir ((triggerArea _x) select 2);
						_mName setMarkerBrush "DIAGGRID";
						_markers pushBack _mName;
					};
					_trgs pushBack _x;
				}
			} forEach synchronizedObjects _location;
		};
	} forEach synchronizedObjects _logic;

	sleep 1;
	_logic setVariable ["triggers", _trgs, true];
};


if (!isdedicated) then {
	sleep 10;
	while {isNil {_logic getVariable "triggers"}} do {sleep 0.5};
	//waituntil {!(isNil {_logic getVariable "triggers"})};

	_trgs = _logic getVariable "triggers";

	//set Activation for all
	{
		_x setTriggerActivation ["ANY","PRESENT",true];
		sleep 0.1;
	} foreach _trgs;


	//Main loop
	while {!isnull _logic} do {
		{
			_myList = list _x;
			if ((vehicle player in _myList) && (((player getVariable ["CP_side", playerside])) in _sides)) then {[_x,_time,false,_air] spawn MCC_fnc_RestrictZoneEffect};
		} foreach _trgs;
		sleep 1;
	};
};

//if the logic have beeen deleted delete triggers
if (isServer) exitWith {
	waituntil {isnull _logic};
	{
		deleteVehicle _x;
	} foreach _trgs;

	{
		deleteMarker _x;
	} forEach _markers;
};