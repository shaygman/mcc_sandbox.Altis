//==================================================================MCC_fnc_ilsChilds===========================================================================================
// ILS for aircrafts based on ILS Pro II 1.0 (by TiGGa)
//Call from an ILS logic
//===========================================================================================================================================================================
private ["_counter","_glideslope","_loc","_arrestingear","_runwayname","_vectorglide","_rwydirection","_angle","_numberofcircles","_landPos","_distanceofcircles","_ringarray","_rwydirection2","_devhor","_ycord","_xcord","_zcord","_horizontal","_vertical","_circlepos","_ring","_helpers"];

//If we came here from ACE get the airport
if (typeName _this == typeName 0) then {
	_this = ((player getVariable ["interactWith",[]]) select _this);
};

_loc 			=  param [0,objNull,[objNull]];
_rwydirection 	= getdir _loc;
_runwayname 	= param [1,"",[""]];
_landPos		= param [2,100,[0,objNull]];
_arrestingear 	= param [3,objNull,[objNull]];
_helpers 		= param [4,false,[false]];

 if (!isNull _arrestingear) then {
	_glideslope 	= "Land_HelipadEmpty_F" createVehicleLocal (getPosASL _arrestingear);
	_glideslope setPosASL (getPosASL _arrestingear);
} else {
	_glideslope 	= "Land_HelipadEmpty_F" createVehicleLocal ([_loc, _landPos, _rwydirection] call BIS_fnc_relPos);
};

_glideslope setdir (if (_rwydirection > 180) then {_rwydirection-180} else {_rwydirection+180});

_vectorglide = vectordir _glideslope;

_angle = 3; //approach angle
_numberofcircles = 30;
_distanceofcircles = 200;
_ringarray=[];


_rwydirection = direction _loc;
_rwydirection2 = 0;
_devhor=0;

if ((_rwydirection >= 0) and (_rwydirection <= 45)) then
{
	_rwydirection2 = _rwydirection;
};
if ((_rwydirection > 45) and (_rwydirection <= 135)) then
{
	_rwydirection2 = _rwydirection - 90;
};
if ((_rwydirection > 135) and (_rwydirection <= 225)) then
{
	_rwydirection2 = _rwydirection - 180;
};
if ((_rwydirection > 225) and (_rwydirection <= 315)) then
{
	_rwydirection2 = _rwydirection - 270;
};
if ((_rwydirection > 315) and (_rwydirection <= 360)) then
{
	_rwydirection2 = _rwydirection - 360;
};
_ycord = (getpos _loc) select 1;
_xcord = (getpos _loc) select 0;
_zcord = (getposASL _loc) select 2;

//Remove abort
player setVariable ["MCC_ILSAbort",false];

//Start ILS
cuttext ["NavCom activated","PLAIN",0.1,false];
_horizontal = "-----o-----";
_vertical = "| \n| \n| \n| \n| \no \n| \n| \n| \n| \n|";

//Add helpers
if (_helpers) then
{
	for [{_i=1},{_i<=_numberofcircles},{_i=_i+1}] do
	{
	  _circlepos=[(getposasl _glideslope select 0) + (_vectorglide select 0) *_distanceofcircles*_i, (getposasl _glideslope select 1) + (_vectorglide select 1) *_distanceofcircles*_i,((getposasl _glideslope select 2)+(tan _angle)*_distanceofcircles*_i)-12];
	  _ring="Sign_Circle_F" createVehiclelocal _circlepos;
	  _ring setposasl _circlepos;
	  _ring setdir getdir _glideslope;
	  _ringarray set [_i-1, _ring];
	};
};

//Add WP
_circlepos=[(getposasl _glideslope select 0) + (_vectorglide select 0) *_distanceofcircles*_numberofcircles, (getposasl _glideslope select 1) + (_vectorglide select 1) *_distanceofcircles*_numberofcircles,((getposasl _glideslope select 2)+(tan _angle)*_distanceofcircles*_numberofcircles)-12];
[1,_circlepos,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", "",0],[group player],true] call MCC_fnc_manageWp;

[0,getpos _glideslope,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", "",0],[group player],true] call MCC_fnc_manageWp;

for [{_loop=0}, {(((getPos player) select 2) > 20) and (player == driver player) and !(player getVariable ["MCC_ILSAbort",false])}, {_loop=_loop}] do
{
	_xplane = (getPos player) select 0;
	_yplane = (getPos player) select 1;
	_zplane = (getPosASL player) select 2;
	_aslheight=((getposASL player) select 2) - _zcord;
	_locdistance = (getPosASL _loc) distance [_xplane,_yplane,_zcord];
	_glideslopedistance = (getPosASL _glideslope) distance [_xplane,_yplane,_zcord];
	if (((_rwydirection > 315) and (_rwydirection <= 360)) or ((_rwydirection >= 0) and (_rwydirection <= 45))) then
	{
		_devhor = asin ((_xplane-_xcord)/_locdistance) + _rwydirection2;
	};
	if ((_rwydirection > 45) and (_rwydirection <= 135)) then
	{
		_devhor = asin ((-(_yplane-_ycord))/_locdistance) + _rwydirection2;
	};
	if ((_rwydirection > 135) and (_rwydirection <= 225)) then
	{
		_devhor = asin ((-(_xplane-_xcord))/_locdistance) + _rwydirection2;
	};
	if ((_rwydirection > 225) and (_rwydirection <= 315)) then
	{
		_devhor = asin ((_yplane-_ycord)/_locdistance) + _rwydirection2;
	};
	_devver = atan (_aslheight/_glideslopedistance) - _angle;
	_abshor = sin (_devhor) * _locdistance;
	_absver = _glideslopedistance * tan _devver;

	if (_devhor < -2.5) then
	{
		_horizontal="-----o----|";
	}
	else
	{
		if ((_devhor >= -2.5) and (_devhor < -2)) then
		{
			_horizontal="-----o---|-";
		}
		else
		{
			if ((_devhor >= -2) and (_devhor < -1.5)) then
			{
				_horizontal="-----x--|--";
			}
			else
			{
				if ((_devhor >= -1.5) and (_devhor < -1)) then
				{
					_horizontal="-----o-|---";
				}
				else
				{
					if ((_devhor >= -1) and (_devhor < -0.5)) then
					{
						_horizontal="-----o|----";
					}
					else
					{
						if ((_devhor >= -0.5) and (_devhor <= 0.5)) then
						{
							_horizontal="-----x-----";
						}
						else
						{
							if ((_devhor > 0.5) and (_devhor <= 1)) then
							{
								_horizontal="----|o-----";
							}
							else
							{
								if ((_devhor > 1) and (_devhor <= 1.5)) then
								{
									_horizontal="---|-o-----";
								}
								else
								{
									if ((_devhor > 1.5) and (_devhor <= 2)) then
									{
										_horizontal="--|--o-----";
									}
									else
									{
										if ((_devhor > 2) and (_devhor <= 2.5)) then
										{
											_horizontal="-|---o-----";
										}
										else
										{
											_horizontal="|----o-----";
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};

	if (_devver < -0.7) then
	{
		_vertical = "-- \n| \n| \n| \n| \no \n| \n| \n| \n| \n|";
	}
	else
	{
		if ((_devver >= -0.7) and (_devver < -0.56)) then
		{
			_vertical = "| \n-- \n| \n| \n| \no \n| \n| \n| \n| \n|";
		}
		else
		{
			if ((_devver >= -0.56) and (_devver < -0.42)) then
			{
				_vertical = "| \n| \n-- \n| \n| \no \n| \n| \n| \n| \n|";
			}
			else
			{
				if ((_devver >= -0.42) and (_devver < -0.28)) then
				{
					_vertical = "| \n| \n| \n-- \n| \no \n| \n| \n| \n| \n|";
				}
				else
				{
					if ((_devver >= -0.28) and (_devver < -0.14)) then
					{
						_vertical = "| \n| \n| \n| \n-- \no \n| \n| \n| \n| \n|";
					}
					else
					{
						if ((_devver >= -0.14) and (_devver <= 0.14)) then
						{
							_vertical = "| \n| \n| \n| \n| \nx \n| \n| \n| \n| \n|";
						}
						else
						{
							if ((_devver > 0.14) and (_devver <= 0.28)) then
							{
								_vertical = "| \n| \n| \n| \n| \no \n-- \n| \n| \n| \n|";
							}
							else
							{
								if ((_devver > 0.28) and (_devver <= 0.42)) then
								{
									_vertical = "| \n| \n| \n| \n| \no \n| \n-- \n| \n| \n|";
								}
								else
								{
									if ((_devver > 0.42) and (_devver <= 0.56)) then
									{
										_vertical = "| \n| \n| \n| \n| \no \n| \n| \n-- \n| \n|";
									}
									else
									{
										if ((_devver > 0.56) and (_devver <= 0.7)) then
										{
											_vertical = "| \n| \n| \n| \n| \no \n| \n| \n| \n-- \n|";
										}
										else
										{
											_vertical = "| \n| \n| \n| \n| \no \n| \n| \n| \n| \n--";
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};

	cuttext [format ["\n%1 \n \n%2 \n \n%3 \n \nDeviation in m \nHorizontal: %4 \nVertical: %5 \n \nDistance: %6 \nHeight: %7",_runwayname,_horizontal,_vertical,_abshor,_absver,_glideslopedistance,_aslheight],"PLAIN",0.1,false];
	sleep 0.5;
};
player setVariable ["MCC_ILSAbort",true];
{deletevehicle _x} foreach _ringarray;
deletevehicle _glideslope;
_ringarray=[];

//Clear up
[2,getpos _loc,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", "",0],[group player]] call MCC_fnc_manageWp;