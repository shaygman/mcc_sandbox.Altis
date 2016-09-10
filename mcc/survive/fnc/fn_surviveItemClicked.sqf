/*=================================================================MCC_fnc_surviveItemClicked===============================================================================
	Handles clicking on item in the inventory and calling the function
*/
//if no server get out
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

disableSerialization;

private ["_ctrl","_index","_itemClass"];

_itemClass = _this select 1;
_ctrl = (_this select 0) select 0;
_index = (_this select 0) select 1;

call compile format ["_itemClass = '%1'; _ctrlIDC = %3; %2",_itemClass,(_ctrl lbData _index),ctrlIDC _ctrl];
_ctrl ctrlShow false;

sleep 1;
_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 1;
_ctrl progressSetPosition ((player getVariable ["MCC_calories",4000])/4000);

_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 2;
_ctrl progressSetPosition ((player getVariable ["MCC_water",200])/200);