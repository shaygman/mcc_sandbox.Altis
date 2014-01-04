//==================================================================MCC_fnc_CreateAmmoDrop===============================================================================================
// drop an object from a plane and attach paracute to it, thanks to BIS
// Example:[_planepos, _spawnkind, _pilot] spawn MCC_fnc_CreateAmmoDrop;
// _planepos = position,  plane position
// _spawnkind = string, vehiclecClass to drop
// _pilot = plane's pilot
//==================================================================================================================================================================================
private ["_pos","_spawnkind","_pilot","_para", "_drop","_dir","_sleep","_smoke"];
_pos = _this select 0;
_spawnkind = _this select 1;
_pilot = _this select 2;
_para = "B_Parachute_02_F" createVehicle [_pos select 0,_pos select 1,3000];
_para setpos [_pos select 0,_pos select 1,(_pos select 2) -40];
_drop = _spawnkind createVehicle [_pos select 0,_pos select 1,3000];
_drop setdir random 360; 
_para setdir random 360; 
sleep 0.03;

_drop attachTo [_para, [0,0,1]];
_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
sleep 0.03;

// For some reason, this command is not always performing as it suppose to, therefore, we repeat it to make sure. (network lag?)
_drop attachTo [_para, [0,0,1]];
_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
sleep 0.03;

_drop attachTo [_para, [0,0,1]];
_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
sleep (0.05 + random 0.2);

// If the Drop hits the ground, recreate it over ground
_sleep = 0;
while {((getpos _drop select 2) > 0.02) && _sleep < 180} do {sleep 0.5; _sleep = _sleep +1};	//Failsafe if stuck in the air
_pos = position _drop;
_dir = direction _para;
detach _drop;
deletevehicle _drop;
_drop = _spawnkind createVehicle _pos;
_drop setdir _dir;
_drop setPos [_pos select 0, _pos select 1,0];
_smoke = "SmokeShellBlue" createVehicle (getpos _drop);			//Mark the drop with smoke
