private ["_unit","_Cargocount","_sucess"];
if (count _this == 0) exitWith {};
_unit 	=  _this select 0;

_sucess = false;

if (missionNamespace getVariable ["MCC_teleportToTeam",false]) then {

	//spawn to a specific unit?
	if (isNull _unit) then {
		_unit = if (player == (leader player) && count units player > 1) then {(((units player) - [player]) select 0)} else {leader player};
	};

	if (!alive _unit) exitWith {};

	//The unit is inside vehicle
	if (vehicle _unit != _unit) then
	{
		_Cargocount = (vehicle _unit) emptyPositions "Cargo";
		if (_Cargocount > 0) then {
			player assignAsCargo (vehicle _unit);
			player moveInCargo (vehicle _unit);
			_sucess = true;
		} else {
			systemchat "Unable to teleport - target unit in vehicle with no empty spaces";
		};
	} else {

		player setPos (getPos _unit);
		_sucess = true;
	};

	if (_sucess) then {
		hint "Teleporting";
		if (MCC_t2tIndex !=3) then // 3 = always allow teleport
		{
			MCC_teleportToTeam = false;
		};
	};

} else {hint "Telpeport is N/A"};
