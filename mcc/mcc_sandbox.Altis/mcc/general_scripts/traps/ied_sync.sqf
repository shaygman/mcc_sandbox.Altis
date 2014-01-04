//Made by Shay_Gman (c) 09.10
private ["_pointA", "_pointB", "_IEDLineName", "_nearObjectsA", "_nearObjectsB","_triggerA","_triggerB","_loop"]; 

_pointA 		= _this select 0; 
_pointB 		= _this select 1; 
_IEDLineName 	= _this select 2; 
_loop 			= true; 

if (mcc_isloading) then {waitUntil {! mcc_isloading}};

_nearObjectsA 	= _pointA nearObjects ["bomb",50];
_nearObjectsB 	= _pointB nearObjects ["bomb",50];
_triggerA	 	= _nearObjectsA select 0;
_triggerB	 	= _nearObjectsB select 0;

if (count _nearObjectsA > 0 && count _nearObjectsB > 0) then	{
	while {_loop} do {
		if (_triggerA getvariable "iedTrigered") then {
			_triggerB setvariable ["iedTrigered", true, true];	//blow the IED
			_loop = false;
		};

		if (_triggerB getvariable "iedTrigered") then {
			_triggerA setvariable ["iedTrigered", true, true];	//blow the IED
			_loop = false;
		};
		sleep 0.3;
	};
	
	if (_IEDLineName != 9999) exitWith 
	{
		[[2,compile format ["deletemarkerlocal 'line_%1';",_IEDLineName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
	};
};