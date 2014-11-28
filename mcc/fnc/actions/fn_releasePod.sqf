//==================================================================MCC_fnc_releasePod===============================================================================================
//Release a pod from Taru helicopter
// Example: [_object] call MCC_fnc_releasePod;
//===========================================================================================================================================================================	
private ["_vehicle","_pod","_attachPos"];
_vehicle 	= _this;
_pod 		= _vehicle getVariable ["MCC_attachedPod",objnull];

_attachPos = switch (typeof _pod) do
	{
		case "Land_Pod_Heli_Transport_04_ammo_F" : {[0,-1,-1.2]};
		case "Land_Pod_Heli_Transport_04_covered_F" : {[0,-1.1,-0.85]};
		case "Land_Pod_Heli_Transport_04_bench_F" : {[0,0,-1.2]};
		case "Land_Pod_Heli_Transport_04_box_F" : {[0,-1.1,-1.1]};
		case "Land_Pod_Heli_Transport_04_fuel_F" : {[0,-0.5,-1.3]};
		case "Land_Pod_Heli_Transport_04_medevac_F" : {[0,-1,-1.05]};
		case "Land_Pod_Heli_Transport_04_repair_F" : {[0,-1.2,-1.05]};
		default {[0,-1,-1.2]};
	};

while {(alive _pod) && ((_pod distance _vehicle) < 3 )} do 
{
	_attachPos set [2,(_attachPos select 2) - 0.7];
	_pod attachTo [_vehicle, _attachPos];
	sleep 0.01;
};

detach _pod;
[[[netid _pod,_pod], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
_pod setVelocity [0, 0, -10];

_vehicle setVariable ["MCC_attachedPod",objnull,true];
_vehicle setMass [(getMass _vehicle)- (_vehicle getVariable ["MCC_attachedPodMass",0]),0.5];
sleep 2; 
_vehicle enableRopeAttach true;
[_pod, driver _vehicle, velocity _vehicle] spawn 
{
	private ["_pod","_class","_pilot","_para","_velocity","_vel"];
	_pod 		= _this select 0;
	_pilot		= _this select 1;
	_velocity	= _this select 2;
	
	waituntil {(!alive _pod || ((getpos _pod) select 2) < 300)};
	if (!alive _pod) exitWith {};
	sleep 0.2;
	_class = format ["%1_parachute_02_F",  toString [(toArray faction _pilot) select 0]];
	_para = createVehicle [_class, getpos _pod,[],0,"CAN_COLLIDE"];
	_para attachTo [_pod, [0,0,0]];
	detach _para;
	_para setVelocity _velocity;
	_pod attachto [_para,[0,0,1.5]];
	
	waitUntil {getPos _pod select 2 < 4};
	_vel = velocity _pod;
	detach _pod;
	_pod setVelocity _vel;
};