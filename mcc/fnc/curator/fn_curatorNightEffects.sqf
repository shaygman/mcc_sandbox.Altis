//============================================================MCC_fnc_curatorNightEffects========================================================================================
// Manage night effects
//===========================================================================================================================================================================
private ["_pos","_module","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

_resualt = ["Set Night Effects",[
 						["Radius",500],
 						["Destroy Lights",true],
 						["Remove Night Vision",true],
 						["Add Flashlights",true],
 						["Ignore Player's Units",false]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

private ["_radius","_ignorePlayers"];
_radius = _resualt select 0;
_ignorePlayers = _resualt select 4;
{
	if (_resualt select (_foreachIndex+1)) then {
		[[_pos, _radius, _x,_ignorePlayers], "MCC_fnc_deleteBrush", false, false] call BIS_fnc_MP;
	}
} forEach [9,18,19];


deleteVehicle _module;