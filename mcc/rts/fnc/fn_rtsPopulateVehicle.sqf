/*=================================================================MCC_fnc_rtsPopulateVehicle==============================================================================
//	Populate vehicle
//  Parameter(s):
//     _ctrl: CONTROL
//=======================================================================================================================================================================*/

private ["_ctrl","_cfgName","_obj","_units","_res","_side","_emptyPos","_startPos","_buildings","_unitsSpace"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;
if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

_startPos = call compile format ["MCC_START_%1",_side];
_buildings = _startPos nearObjects ["UserTexture10m_F", 300];
_unitsSpace = 4;

//Find buildings
{
	if ((_x getVariable ["mcc_constructionItemType",""]) == "house" && !(isNull attachedTo _x)) then {
		_unitsSpace = _unitsSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*4);
	};
} foreach _buildings;

_units = {side _x == _side && (isPlayer _x || _x getVariable ["MCC_isRTSunit",false])} count allUnits;
_emptyPos = 0;
_emptyPos = (_obj emptyPositions "driver") + (_obj emptyPositions "Commander") + (_obj emptyPositions "Gunner");

//Not enough houses
if ((_units + _emptyPos)> _unitsSpace) exitWith {
	[9989,"Not Enough Manpower. Build More Barracks",5,true] call MCC_fnc_setIDCText;
};

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;


createVehicleCrew _obj;

(group _obj) setVariable ["MCC_canbecontrolled",true,true];
{_x addCuratorEditableObjects [[_obj],true]} forEach allCurators;

_ehID = _obj addMPEventHandler ["mpkilled", {
												_unit = getText (configfile >> "CfgVehicles" >> typeof (_this select 0) >> "displayName");
												_killer = name (_this select 1);
												[["MCCNotificationBad",["Unit Down",format ["%1 was killed by %2",_unit,_killer],""]], "bis_fnc_showNotification", _sidePlayer, false] spawn BIS_fnc_MP;
											  }];

{
	_x setVariable ["MCC_isRTSunit",true,true];
} forEach crew _obj;
_obj allowCrewInImmobile true;
MCC_ConsoleGroupSelected = [];
