//==================================================================MCC_fnc_time===============================================================================================
// convert time to hh:mm:ss
//==============================================================================================================================================================================	
private ["_secTotal","_h","_m","_s","_string"];

_secTotal = _this select 0;

_s = [floor(_secTotal MOD 60)]call MCC_fnc_time2string;
_m = [floor((_secTotal/60) MOD 60)]call MCC_fnc_time2string;
_h = [floor((_secTotal/60/60) MOD 24)]call MCC_fnc_time2string;

_string = format["%1:%2:%3", _h, _m, _s];

_string;
