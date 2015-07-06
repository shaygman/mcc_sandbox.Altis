//==================================================================MCC_fnc_globalHint======================================================================================
// Broadcast a meesege on all clients
// Example: [[_hint],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
// Params:
//	_hint: string, messege to broadcast
//==============================================================================================================================================================================
private ["_string","_richText"];
_string = [_this, 0, "", [""]] call BIS_fnc_param;
_richText = [_this, 1, false, [false]] call BIS_fnc_param;

if (_richText) then {
	hint parseText _string;
} else {
	hint _string;
};