private ["_truck","_caller","_index","_vars","_startPos"];
_caller 	= _this select 0;
_truck 		= vehicle _caller;
_index 		= _this select 2; 
_vars 		= _this select 3; 

_startPos = call compile format ["MCC_START_%1",playerside];
if (isnil "_startPos") then {_startPos = [0,0,0]};

if (_truck distance _startPos < 50) then
{
	player setVariable ["mcc_logTruck_screenStart", true];
}
else
{
	player setVariable ["mcc_logTruck_screenStart", false];
}; 

createDialog "MCC_LOGISTICS_LOAD_TRUCK";
 waituntil {!dialog};

 

