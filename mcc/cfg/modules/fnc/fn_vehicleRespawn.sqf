/*-================================================ MCC_fnc_vehicleRespawn =============================================================================-
	Author: shay_gman

	Description:
		- respawn empty vehicles
		- runs on the server

	<IN>
		_object -			OBJECT vehicle
		_abondanDistance	INTEGER how far in meters must one be to respawn
		_waitTime - 		INTEGER time waited before respawn
		_tickets - 			INTEGER how many times can the vehicle respawn, leave -1 for always
		_destroyEffect 		BOOLEAN true for explodion effects, false for none
		_respawnDisabled 	BOOLEAN true for to respawn disabled vehicles
		_code				STRING code to execute once the vehicle respawned
	<OUT>
		- nothing

	EXAMPLE:
	[this,100,360,10,false,"hint 'dead'"] spawn MCC_fnc_vehicleRespawn
*/

private ["_object","_abondanDistance","_waitTime","_tickets","_destroyEffect","_code","_vehName","_vehDir","_vehPos","_vehtype","_abandoned","_respawnDisabled"];
if (!isServer) exitWith {};

_object = param [0,objNull,[objNull]];

//did we get here from the module or from call?
if (typeName (_object getVariable ["abondanDistance",true]) == typeName 0) exitWith {
	private ["_vehicles"];
	_abondanDistance = _object getVariable ["abondanDistance",-1];
	_waitTime = _object getVariable ["waitTime",5];
	_tickets = _object getVariable ["tickets",-1];
	_destroyEffect = _object getVariable ["destroyEffect",false];
	_respawnDisabled = _object getVariable ["respawnDisabled",false];
	_code = _object getVariable ["code",""];

	_vehicles = synchronizedObjects _object;

	{
		[_x,_abondanDistance,_waitTime,_tickets,_destroyEffect,_respawnDisabled,_code] spawn MCC_fnc_vehicleRespawn;
	} forEach _vehicles;
};

_abondanDistance = param [1,-1,[1]];
_waitTime = param [2,3,[1]];
_tickets = param [3,-1,[1]];
_destroyEffect = param [4,false,[false]];
_respawnDisabled = param [5,false,[false]];
_code = param [6,"",["",missionNamespace]];


//store vehicle data
_vehName = vehicleVarName _object;
_vehDir = getDir _object;
_vehPos = getPos _object;
_vehtype = typeOf _object;

// START LOOP TO MONITOR THE VEHICLE
while { true } Do {
	//No trickets quit
	if (_tickets ==0) exitWith {};

	//No crew lets see if we abonadand the vehicle
	_abandoned = if (count (crew _object) == 0 && _abondanDistance > 0) then {count ((position _object) nearEntities [["Man"], _abondanDistance])<=0} else {false};

	//see if we have been damaged or disabled
	if (((_abandoned && _object distance _vehPos > 50) || !(alive _object) || (!(canMove _object) && _respawnDisabled))) then {

		_tickets = _tickets -1;
		if (_destroyEffect) then {[position _object,"medium"] spawn MCC_fnc_IedDeadlyExplosion};
		deleteVehicle _object;
		sleep _waitTime;

		//Spawn vehicle
		_object = createVehicle [_vehtype, _vehPos, [], 0, "CAN_COLLIDE"];
		_object setPos _vehPos;
		_object setDir _vehDir;
		_object call compile _code;

		if (_vehName != "") then {
			missionNamespace setVariable [_vehName, _object];
			publicVariable _vehName;
		};
	};

	sleep 1;
};