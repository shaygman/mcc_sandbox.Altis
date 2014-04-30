//==================================================================MCC_fnc_CreateAmmoDrop===============================================================================================
// drop an object from a plane and attach paracute to it, thanks to BIS
// Example:[_planepos, _spawnkind, _pilot] spawn MCC_fnc_CreateAmmoDrop;
// _planepos = position,  plane position
// _spawnkind = string, vehiclecClass to drop
// _pilot = plane's pilot
//==================================================================================================================================================================================
private ["_pos","_spawnkind","_pilot","_para", "_drop","_dir","_time","_smoke","_class","_paras"];
_pos = _this select 0;
_spawnkind = _this select 1;
_pilot = _this select 2;
_class = format ["%1_parachute_02_F",  toString [(toArray faction _pilot) select 0]];
 
 _drop = createVehicle [_spawnkind,  [_pos select 0,_pos select 1,(_pos select 2) -50], [], 0, 'NONE'];
 _drop setPos [_pos select 0,_pos select 1,(_pos select 2) -50];

_para = createVehicle [_class, getpos _drop,[],0,"none"];
_drop attachto [_para,[0,0,(abs ((boundingbox _drop select 1) select 2))]];

_para setDir getDir _drop;
_paras =  [_para];

//Thanks to KKid for this part
if ((_drop isKindOf "Car") || (_drop isKindOf "Tank") || (_drop isKindOf "Ship"))
then 
{
	{
		_p = createVehicle [_class, getpos _para,[],0,"none"];
		_paras set [count _paras, _p];
		_p attachTo [_para, [0,0,0]];
		_p setVectorUp _x;
	} count [[0.5,0.4,0.6],[-0.5,0.4,0.6],[0.5,-0.4,0.6],[-0.5,-0.4,0.6]];
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


