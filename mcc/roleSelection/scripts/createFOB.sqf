private ["_item","_caller","_index","_pos","_dir","_side","_finished"];
// Who activated the action?
_item = _this select 0;
_caller = _this select 1;
_index = _this select 2; 

_pos 	= getpos _item;
_dir 	= getdir _item;
_side	= str (side _caller);
{
	 [compile format ["unassignVehicle objectFromNetID '%1'; objectFromNetID '%1' action ['eject', vehicle objectFromNetID '%1'];", netID _x], "BIS_fnc_spawn", _x, false] call BIS_fnc_MP;
	 sleep 0.1;
} foreach crew _item;

deleteVehicle _item;
waituntil {isnull _item};

[[_pos,_dir, _side, "FOB" ,true, true], "MCC_fnc_buildSpawnPoint", false, false] call BIS_fnc_MP;  