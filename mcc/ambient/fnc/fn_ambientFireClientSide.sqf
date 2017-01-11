/*============================================================MCC_fnc_ambientFireClientSide=======================================================================
Client side: Light and sounds effects

 In:
	0:	OBJECT The fire effect
	1:	INTEGER the light and sound radius

	EXAMPLE:
	[_effect,_radius] call MCC_fnc_ambientFireSClientSide;

	<OUT>
		Nothing
==============================================================================================================================================================*/
params [
	["_effect",objNull,[objNull]],
	["_radius",10,[0]]
];

private ["_light"];
if (!alive _effect || !hasInterface) exitWith {};

_light = "#lightpoint" createVehicleLocal (getPos _effect);
_light lightAttachObject [_effect, [0,0,0]];

_light setLightAmbient [1,0.1,0];
_light setLightColor [1,0,0];
_light setLightUseFlare true;
_light setLightDayLight true;

//Sound loop
[_effect, _radius] spawn {
	params [
		["_effect",objNull,[objNull]],
		["_radius",10,[0]]
	];

	while {alive _effect} do {
		_effect say3d [format ["burning_car_loop%1", (ceil random 2)],_radius];
		sleep 3;
	};
};

//Light loop
while {alive _effect} do {
	_light setLightBrightness (_radius/10)+ random ((_radius/10)*0.1);
	sleep 0.1;
};

deletevehicle _light;