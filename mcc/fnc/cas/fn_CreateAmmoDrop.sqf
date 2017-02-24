//==================================================================MCC_fnc_CreateAmmoDrop===============================================================================================
// drop an object from a plane and attach paracute to it, thanks to BIS
// Example:[_planepos, _spawnkind, _pilot] spawn MCC_fnc_CreateAmmoDrop;
// _planepos = position,  plane position
// _spawnkind = string, vehiclecClass to drop
// _pilot = plane's pilot
//==================================================================================================================================================================================
private ["_pos","_spawnkind","_pilot","_para", "_drop","_dir","_time","_smoke","_class","_paras","_objectData","_velocity","_spawnCrew"];
_pos = _this select 0;
_spawnkind = _this select 1;
_pilot = param [2,objNull,[missionNamespace,objNull]];
_spawnCrew = param [3,false,[false]];

_class = if (!isnull _pilot) then {format ["%1_parachute_02_F",  toString [(toArray faction _pilot) select 0]]} else {"I_parachute_02_F"};
_paras = [];

if (!isnull _pilot) then {while {(_pos distance vehicle _pilot) < 20} do {sleep 0.2}};

 _drop = createVehicle [_spawnkind, _pos, [], 0, "CAN_COLLIDE"];
{_x addCuratorEditableObjects [[_drop],false]} forEach allCurators;

_objectData = (_drop call bis_fnc_objectType) select 1;

_para = createVehicle [_class, getpos _drop,[],0,"CAN_COLLIDE"];
_para attachTo [_drop, [0,0,0]];
_velocity = if (!isnull _pilot) then {velocity (vehicle _pilot)} else {[0, 0, 0]};
detach _para;

_para setVelocity _velocity;

if (_objectData in ["Ship","Submarine","TrackedAPC","Tank","WheeledAPC","Car"]) then {
	_drop attachto [_para,[0,0,-(abs ((boundingbox _drop select 0) select 2))]];

	{
		_p = createVehicle [_class, getpos _para,[],0,"CAN_COLLIDE"];
		_paras set [count _paras, _p];
		_p attachTo [_para, [0,0,0]];
		_p setVectorUp _x;
	} count [[0.5,0.4,0.6],[-0.5,0.4,0.6],[0.5,-0.4,0.6],[-0.5,-0.4,0.6]];
} else {
	_drop attachto [_para,[0,0,1]];
	_paras =  [_para];
};

_para setvelocity [0,0,-1];

//spaw crew
if (_spawnCrew || isAutonomous _drop) then {
	createVehicleCrew _drop;
};

0 = [_drop, _paras] spawn
{
	private ["_veh"];
	_veh = _this select 0;
	waitUntil {getPos _veh select 2 < 4};
	_vel = velocity _veh;
	detach _veh;
	_veh setVelocity _vel;

	 playSound3D ["a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",_veh];

	{
		detach _x;
		_x disableCollisionWith _veh;
	} count (_this select 1);

	_smoke = "SmokeShellBlue" createVehicle (getpos _veh);			//Mark the drop with smoke

	_time = time + 5;
	waitUntil {time > _time};
	{
		if (!isNull _x) then {deleteVehicle _x};
	} count (_this select 1);
};


