//==================================================================MCC_fnc_callConstruct===========================================================================
// Call support from ACE menu
// Example:[_type]  call MCC_fnc_callConstruct;
// <IN>
//	_type:					string - type of enemy to spot
//
// <OUT>
//		<Nothing>
//===========================================================================================================================================================================
private ["_conType","_available","_pos"];
_conType = param [0, "", [""]];
_pos = player modelToWorld [0,4,0];

[_conType,_pos] spawn MCC_fnc_initConstract;
