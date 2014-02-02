//===================================================================MCC_fnc_dirToString=========================================================================================
// Get direction integer and return it as a strin North, east exc
// Example: [_dir] call MCC_fnc_dirToString
// <IN>
//	_dir: Integer - number from 0 - 360
//<OUT>
//	String as North/East exc
//==============================================================================================================================================================================	
private "_dir";
_dir = _this select 0; 

_strDir = "";
switch (true) do	
{
	case (_dir < 20): {_strDir = "North"};
	case (_dir >= 20 && _dir < 65): {_strDir = "North-East"};
	case (_dir >= 65 && _dir < 110): {_strDir = "East"};
	case (_dir >= 110 && _dir < 160): {_strDir = "South-East"};
	case (_dir >= 160 && _dir < 200): {_strDir = "South"};
	case (_dir >= 200 && _dir < 250): {_strDir = "South-West"};
	case (_dir >= 250 && _dir < 290): {_strDir = "West"};
	case (_dir >= 290 && _dir < 319): {_strDir = "North-West"};
	case (_dir >= 320): {"North"};
};
_strDir