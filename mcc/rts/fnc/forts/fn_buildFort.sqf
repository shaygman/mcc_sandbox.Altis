//=================================================================MCC_fnc_buildFort==============================================================================
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_side","_class","_res"];
_side = _this select 0;
_cfgName = _this select 1;
_res = _this select 2;

MCC_CONST_PLACEHOLDER = _cfgName createVehicleLocal [0,0,100];
MCC_CONST_PLACEHOLDER setdir (missionNamespace getVariable ["MCC_rtsFortDir",0]);
MCC_CONST_PLACEHOLDER setVariable ["MCC_baseBuildingToBuild",_cfgName];
MCC_CONST_PLACEHOLDER setVariable ["MCC_baseBuildingIsFort",true];
MCC_CONST_PLACEHOLDER setVariable ["MCC_baseBuildingRes",_res];