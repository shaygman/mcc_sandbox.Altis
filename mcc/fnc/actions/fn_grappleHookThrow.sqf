//==================================================================MCC_fnc_grappleHookThrow===============================================================================================
//Throw a grapple hook
// Example: [_ammo] call MCC_fnc_grappleHookThrow;
//===========================================================================================================================================================================	
private ["_ammo","_impactPos","_unit","_startPos","_rope","_ammoType","_endpos"];
_unit 		= _this select 0;
_ammoType 	= _this select 5;
_ammo 		= _this select 6;

if (_ammoType == "B_IR_Grenade") then 
{
	_ammo hideObjectglobal true;
	_impactPos = getPosATL _ammo;
	//GroundWeaponHolder
	_startPos = "B_UAV_01_F" createVehiclelocal position _unit;
	_startPos hideObject true; 
	_startPos attachto [_ammo,[0,0,0]];
	//_startPos setpos (_unit modeltoWorld [1,0,0]);
	//_rope = ropeCreate [_startPos,[0,0,0],_ammo,[0,0,0], 30,[10]];
	myrope = ropeCreate [_startPos,[0,0,0],20,[10],[10], true];
	while {str _impactPos != str (getPosATL _ammo)} do
	{
		_impactPos = getPosATL _ammo;
		systemchat str ((getpos _ammo) select 2); 
		sleep 0.1;
	};
};

//[player,[0,0,0],[0,0,-1]] ropeAttachTo myRope;
//s1= "B_UAV_01_F" createVehiclelocal position player;
// myRope = (player nearObjects ["rope",2]) select 0;
//ropeUnwind [myRope, 5, 1, true]