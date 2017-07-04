//=================================================================MCC_fnc_baseActionClicked===========================================================================
//	What happened when clicking on a base's building action
//  Parameter(s):
//     _ctrl: CONTROL
//     _ctrlText: STRING
//========================================================================================================================================================================
#define	MCC_RTSANCHOR "CamoNet_BLUFOR_big_Curator_F"


private ["_ctrl","_ctrlText","_cfgName"];
disableSerialization;
_ctrl 		= _this select 0;
_ctrlText 	= _this select 1;

if (_ctrlText == "") exitWith {};

_cfgName = missionNamespace getVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],""];
if (isnull MCC_CONST_PLACEHOLDER) then {
	MCC_CONST_PLACEHOLDER =  MCC_RTSANCHOR createVehicleLocal [0,0,100];
};
MCC_CONST_PLACEHOLDER setVariable ["MCC_baseBuildingToBuild",_cfgName];