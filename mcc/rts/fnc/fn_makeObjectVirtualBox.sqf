//=================================================================MCC_fnc_makeObjectVirtualBox==================================================================================
//  Make an object to act as a virtuall shared box for the given side - run where the box is local
// example [west, _object] call MCC_fnc_makeObjectVirtualBox
//  Parameter(s):
//     0: _side - SIDE side for whom the object will serve as a shared box
//     1: _object - OBJECT vehicle that will serve as the actuall box
//==============================================================================================================================================================================
private ["_side","_boxName","_box","_boxArray","_object"];
_side = [_this, 0, west] call BIS_fnc_param;
_object = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

if (isNull _object) exitWith {};

_boxName = format ["MCC_rtsMainBox%1",_side];
_box = missionNamespace getVariable [_boxName,objNull];

//Get the box gear
if !(isNull _box) then {
    _boxArray = _box getvariable ["MCC_virtual_cargo",[[],[],[],[]]];
} else {
    _boxArray = [[],[],[],[]];
};

clearItemCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearBackpackCargoGlobal _object;
_object setVariable ["MCC_virtual_cargo",_boxArray,true];
[[_object,"Hold %1 to open"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;