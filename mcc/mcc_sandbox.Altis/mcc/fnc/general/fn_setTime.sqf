//==================================================================MCC_fnc_setTime======================================================================================
// Setstime on all clients
// Example: [[year, month, day, hour, minute],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
//	year: number, YYYY
//	month: number, MM
//	day: number, DD
//	hour: number, HH
// 	minute: number, mm
//==============================================================================================================================================================================	

private ["_time"];

_time = _this select 0;
setDate _time;
