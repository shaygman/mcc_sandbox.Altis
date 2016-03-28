//===================================================================MCC_fnc_iedSync======================================================================================
//Note to be used outside MCC
//==============================================================================================================================================================================
//Made by Shay_Gman (c) 09.10
private ["_pointA", "_pointB", "_nearObjectsA", "_nearObjectsB","_triggerA","_triggerB","_loop","_syncedPos","_savedObject","_triggerAPos","_triggerBPos"];

_pointA 		= _this select 0;
_pointB 		= _this select 1;
_loop 			= true;

if (mcc_isloading) then {waitUntil {! mcc_isloading}};

_nearObjectsA 	= _pointA nearObjects [MCC_dummy,50];
_nearObjectsB 	= _pointB nearObjects [MCC_dummy,50];
_nearObjectsA	= [_nearObjectsA, [], { _pointA distance _x }, "ASCEND"] call BIS_fnc_sortBy;
_nearObjectsB	= [_nearObjectsB, [], { _pointB distance _x }, "ASCEND"] call BIS_fnc_sortBy;
_triggerA	 	= _nearObjectsA select 0;
_triggerB	 	= _nearObjectsB select 0;

if (count _nearObjectsA > 0 && count _nearObjectsB > 0) then {
	_triggerAPos = getpos _triggerA;
	_triggerBPos = getpos _triggerB;

	_triggerA setvariable ["syncedObject", _triggerBPos, true];
	//_triggerB setvariable ["syncedObject", _triggerAPos, true];

	_syncedPos 	= _triggerA getVariable ["syncedObject", [0,0,0]];

	if (str _syncedPos != "[0,0,0]") then {
		_savedObject = if (_triggerA in (curatorEditableObjects MCC_curator)) then {_triggerA} else {attachedTo _triggerA};
		if (!isnil "_savedObject") then {_savedObject setvariable ["syncedObject", _syncedPos, true]};
	};


	while {_loop} do {
		//Incase we moved the synced object
		if (str _triggerBPos != str (getpos _triggerB)) then {
			_savedObject setvariable ["syncedObject", getpos _triggerB, true];
			_triggerBPos = getpos _triggerB;
		};

		if ((_triggerA getvariable ["iedTrigered",false]) || (_triggerB getvariable ["iedTrigered",false])) then {
			//blow the IED
			sleep random 3;
			_triggerA setvariable ["iedTrigered", true, true];
			_triggerB setvariable ["iedTrigered", true, true];
		};
		sleep 1;
	};
};