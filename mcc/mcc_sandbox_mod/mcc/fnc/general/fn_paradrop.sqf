//===================================================================MCC_fnc_paradrop======================================================================================
// Create a HALO or regular parachute jump for the given unit
//Example:[[pos,[_unit, unitID],halo,hight,jumperNumber],"MCC_fnc_paradrop",true,false] call BIS_fnc_MP;
// Params: 
// 	pos: array, position.
//	,[_unit, unitID]: object and number, unit ID for the jump
//	halo:  boolean ,true - halo, false - parajump
//	hight:  number,jump hight
//    jumperNumber: number, jumper number if more then one is jumping inorder to spread them around
//==============================================================================================================================================================================	
[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)] execVM MCC_path + "mcc\general_scripts\unitManage\parachute3.sqf";