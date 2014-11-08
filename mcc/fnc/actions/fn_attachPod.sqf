//==================================================================MCC_fnc_attachPod===============================================================================================
//Attach a pod to Taru helicopter
// Example: [_object] call MCC_fnc_attachPod;
//===========================================================================================================================================================================	
private ["_vehicle","_pod","_attachPos"];
_vehicle 	= _this;
_pod 		= (ropeAttachedObjects _vehicle) select 0;
_podMass	= getMass _pod;
_ropes 		= ropes _vehicle;

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
{ropeUnwind [ _x, 3, 0]} foreach _ropes; 
waituntil {({ropeLength _x < 1} count _ropes) > 0};

{_pod ropeDetach _x} foreach _ropes; 
_vehicle setMass [(getMass _vehicle)+ _podMass,0.5];
_pod attachto [_vehicle,_attachPos];
{ropeDestroy  _x} foreach _ropes; 

_vehicle setVariable ["MCC_attachedPod",_pod,true];
_vehicle setVariable ["MCC_attachedPodMass",_podMass,true];

_vehicle enableRopeAttach false;
[_pod,_vehicle] spawn {
	private ["_pod","_vehicle"];
	_pod 		= _this select 0;
	_vehicle 	= _this select 1;
	while {!(isNull attachedTo _pod) && alive _pod} do 
	{
		if !(alive _vehicle) then 
		{
			_pod setDammage 1;
			detach _pod;
			_vehicle setMass [(getMass _vehicle)- (_vehicle getVariable ["MCC_attachedPodMass",0]),0.5];
		};
		
		sleep 0.5;
	};
};