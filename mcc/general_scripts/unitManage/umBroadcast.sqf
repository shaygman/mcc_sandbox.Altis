private ["_target","_source","_mode"];
_target		= _this select 0;
_mode		= _this select 1;

if (!MCC_isBroadcasting) then	{
	MCC_isBroadcasting = true; 
	_source = "Sign_Sphere10cm_F" createvehicle [0,0,0];
	waitUntil {_source != ObjNull};

	[[[netid _source,_source], "_this hideObjectGlobal true"], "MCC_fnc_setVehicleInit", false, false] spawn BIS_fnc_MP;
	
	_source attachTo [vehicle (_target),[5,5,5]]; 
	 
	[_source,vehicle _target,player,_mode] call BIS_fnc_liveFeed;

	sleep 25;

	[] call BIS_fnc_liveFeedTerminate;

	deletevehicle _source;
	MCC_isBroadcasting = false; 
};
