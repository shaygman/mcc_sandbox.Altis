//==================================================================MCC_fnc_assignChannelServer==================================================================================
// Example:[]  spawn  MCC_fnc_assignChannelServer;
//===============================================================================================================================================================================
private["_unit","_channel","_add"];
_unit = param [0,ObjNull,[ObjNull]];
_add = param [1,false,[false]];
_channel = param [2,-1,[0]];

if(isNull _unit || _channel == -1 || !isServer) exitWith {};

if(_add) then {
	_channel radioChannelAdd [_unit];
} else {
	_channel radioChannelRemove [_unit];
};