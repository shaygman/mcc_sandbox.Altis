/*===================================================================MCC_fnc_arrestingGear================================================================================
	Simulate LHD arresting gear - stopping flying planes and halting them.
 	Used by the MCC's LHD - Based on Tuskenrighter Arrestinggear script

 		<IN>
		0:	OBJECT - ropes location
		1:	OBJECT - player entering the trigger.

		<OUT>
		None
==================================================================================================================================================================*/
params [
	["_cables", objNull, [objNull,[]]],
	["_unit", objNull, [objNull]]
];

private ["_cablesPosASL","_cablelenght","_activationdist","_cablewidth","_brakeforce","_elasticity","_glidepathxdev","_glidepathydev","_cablepos1","_angle1","_plane","_planeposx","_planeposy","_glidepath1y","_landing","_planepos","_planepostempxA","_planepostempyA","_planepostempxB","_planepostempyB","_hooked","_planeposdiffx","_planeposdiffy","_planeposdifftot","_vel","_velx","_vely","_velz","_nrofbrakes","_brakeingdist","_backspeed","_velxfinal","_velyfinal","_stopping","_veltotal"];

//Params
_cablelenght=122;
_activationdist=50;
_cablewidth=9;
_retardation=1;
_brakeforce=1.02;
_elasticity=4;

//Calculated params
_cablesPosASL= (getPosASL _cables) select 2;
_cablepos1=getpos _cables;
_angle1=getDir _cables;

_glidepathxdev=(((_cablelenght)+_activationdist)*(sin _angle1));
_glidepathydev=(((_cablelenght)+_activationdist)*(cos _angle1));

_glidepath1x=(_cablepos1 select 0)-_glidepathxdev;
_glidepath1y=(_cablepos1 select 1)-_glidepathydev;

_plane = vehicle _unit;
_planeposx = getPos _plane select 0;
_planeposy = getPos _plane select 1;


if (((abs (_glidepath1x-_planeposx)<=30) && (abs (_glidepath1y-_planeposy)<=30))
	&& (driver _plane == _unit)
	&& (_plane iskindof "Plane")
	&& !(_plane getVariable ["MCC_isArrestingGear",false])) then {

	_plane setVariable ["MCC_isArrestingGear",true,true];

	// Setting required starting variables. And play sound.
	_landing=true;
	_planepos=getPos _plane;
	_planepostempxA=abs (_planepos select 0);
	_planepostempyA=abs (_planepos select 1);
	_planepostempxB=_planepostempxA+100;
	_planepostempyB=_planepostempyA+100;
	_hooked=false;
	[_plane,"MCC_Landing"] remoteExec ["say3D", -2, false];

	while {_landing} do {
		_planeposdiffx=_planepostempxB-_planepostempxA;
		_planeposdiffy=_planepostempyB-_planepostempyA;
		_planeposdifftot=sqrt ((_planeposdiffx*_planeposdiffx)+(_planeposdiffy*_planeposdiffy));

		if (_planeposdifftot>=_retardation) then {
			_vel=velocity _plane;
			_velx=(_vel select 0);
			_vely=(_vel select 1);
			_velz=(_vel select 2);
			_nrofbrakes=_nrofbrakes+1;
			_brakeingdist=_nrofbrakes*_retardation;
			_backspeed=_brakeingdist/_elasticity;
			if ((abs (_velx))>_backspeed) then {_velxfinal=(_vel select 0);};
			if ((abs (_vely))>_backspeed) then {_velyfinal=(_vel select 1);};
			_plane setVelocity [(_velx/_brakeforce),(_vely/_brakeforce),_velz];
			_planepos=getPos _plane;
			_planepostempxB=abs (_planepos select 0);
			_planepostempyB=abs (_planepos select 1);
		};

		_vel=velocity _plane;
		_velx=(_vel select 0);
		_vely=(_vel select 1);
		_velz=(_vel select 2);
		_planepos=getPos _plane;
		_planepostempxA=abs (_planepos select 0);
		_planepostempyA=abs (_planepos select 1);
		if (((abs _velx)<3) && ((abs _vely)<3)) then {_landing=false; _stopping=true;};
	};

	//Speed is slow enough now lets halt it fully.

	while {_stopping} do {
	_plane setVelocity [(_velx/_brakeforce),(_vely/_brakeforce),_velz];
	sleep 0.01;
	_velx=(_vel select 0);
	_vely=(_vel select 1);
	2_velz=(_vel select 2);
	if (((abs _velx)<0.3) && ((abs _vely)<0.3)) then {
		_plane setVelocity [0,0,0];
		sleep 0.01;
		_stopping=false;
		};
	};

	// The plane has slowed down to almost no speed. Calculate and do a small elastic bounceback.
	_veltotal=(abs _velxfinal)+(abs _velyfinal);
	_velxquota=_velxfinal/_veltotal;
	_velyquota=_velyfinal/_veltotal;
	_plane setVelocity [- (_velxquota*_backspeed*(1/10)),- (_velyquota*_backspeed*(1/10)),0];
	sleep 0.01;
	_plane setVelocity [- (_velxquota*_backspeed*(1/5)),- (_velyquota*_backspeed*(1/5)),0];
	sleep 0.01;
	_plane setVelocity [- (_velxquota*_backspeed*(1/1)),- (_velyquota*_backspeed*(1/1)),0];
	_inbound=false;

	_plane setVariable ["MCC_isArrestingGear",false,true];
};