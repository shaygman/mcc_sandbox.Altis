//==================================================================MCC_fnc_globalHint======================================================================================
// Broadcast a meesege on all clients
// Example: [[_hint],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
// Params: 
//	_hint: string, messege to broadcast
//==============================================================================================================================================================================	
private ["_string"];

_string = _this select 0;
hint _string; 
