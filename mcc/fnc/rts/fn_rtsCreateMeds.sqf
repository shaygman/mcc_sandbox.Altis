//=================================================================MCC_fnc_rtsCreateMeds==============================================================================
//	Create Meds
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_res","_side","_varName"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

private ["_resVar","_res"];
_resVar = format ["MCC_res%1", _side];
_resArray = missionNamespace getvariable [_resVar,[]];
[9989,"50 Meds Added",5,true] call MCC_fnc_setIDCText;
_resArray set [4,(_resArray select 4)+50];