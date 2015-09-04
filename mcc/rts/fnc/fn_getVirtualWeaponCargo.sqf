//=================================================================MCC_fnc_getVirtualWeaponCargo===============================================================================
//  Parameter(s):
//     0: OBJECT - objct to which items will be added
//     1: STRING or ARRAY of STRINGs - item class(es) to be added
//==============================================================================================================================================================================
private ["_object","_classes","_type","_cargo","_cargoArray"];
_object     = [_this,0,missionnamespace,[missionnamespace,objnull]] call bis_fnc_param;
_classes    = [_this,1,[],["",true,[]]] call bis_fnc_param;
disableSerialization;
[_object,_classes,0,1] call MCC_fnc_addVirtualItemCargo;