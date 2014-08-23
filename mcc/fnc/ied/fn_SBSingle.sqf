//==================================================================MCC_fnc_SBSingle===============================================================================================
// Place suicide bomber
// Example: [_pos, _trapkind, _trapvolume, _IEDExplosionType, _iedside] spawn MCC_fnc_SBSingle; 
// <in>: 	_pos 			= position, center of the explosion.
// 		_trapkind 		= string, unit's vehicle class
//		_trapvolume 		= String "small", "medium", "large"
//		_IEDExplosionType	= Integer, 1- deadly 	2- Disabling	3- Fake
//		_iedside 			= side, which side trigger the armed civilian
// <out>	unit, object
//=================================================================================================================================================================================

//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_trapvolume", "_IEDExplosionType", "_group", "_iedside","_sb"]; 

 if (!isServer) exitWith {}; 
 
_pos 				= _this select 0; 
_trapkind 			= _this select 1; 
_trapvolume 		= _this select 2; 
_IEDExplosionType 	= _this select 3; 
_iedside 			= _this select 4;

_group = creategroup civilian;
_sb	= _group createunit [_trapkind, _pos, [], 0, "NONE"];

_init = FORMAT [";[_this, %1,'%2',%3] spawn MCC_fnc_manageSB;"
				, _iedside
				, _trapvolume
				, _IEDExplosionType
				];
				
[[[netid _sb,_sb], _init], "MCC_fnc_setVehicleInit", false, false] spawn BIS_fnc_MP;

MCC_curator addCuratorEditableObjects [[_sb],false];

_sb;