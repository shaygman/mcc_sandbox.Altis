private ["_unit","_plane","_positions","_dir","_isHalo","_jumpReady","_unitPosition","_isCargo","_y","_x","_pos","_vehicle","_init","_time","_light","_pod"];
_plane 		= _this select 0;												//where from
_unit 		= _this select 1;												//Who is jumping
_unitNumber	= _this select 2;												//what is his jumper number
_isCargo	= false;

_positions 	= [[-0.5,-2.5,-2.23],[0.5,-2.5,-2.23],[-0.5,-1,-2.23],[0.5,-1,-2.23],[-0.5,0.5,-2.23],[0.5,0.5,-2.23],
				[-0.5,2,-2.23],[0.5,2,-2.23],[-0.5,3.5,-2.23],[0.5,3.5,-2.23],[-0.5,4.5,-2.23],[0.5,4.5,-2.23]];

//set the units looking the ramp
_dir			= 180;
_unitPosition 	= _positions select _unitNumber;

//correct hight for the new airplane
if (typeOf _plane == "B_T_VTOL_01_infantry_F") then {
	_unitPosition set [2,-5.7];
};

_isHalo			= _plane getvariable ["MCCisHALO",0];
_jumpReady		= _plane getvariable "MCCjumpReady";

sleep .1;

if (isNull _unit) exitwith {};

if (!local _unit || !alive _plane) exitwith {};

if (isplayer _unit) then {
	titleText ["","BLACK FADED",5];
};

//Pod or plane
_pod = if (_isHalo ==1) then {_plane getVariable ["MCC_attachedPod",objnull]} else {_plane};

//put the unit in the vehicle
while {vehicle _unit != _pod &&
	   alive _pod &&
	   alive _unit &&
	   _pod emptyPositions "cargo" > 0
	  } do {
	if (vehicle _unit != _unit) then {unassignVehicle _unit};
	_unit assignAsCargo _pod ;
	_unit moveInCargo _pod ;
	sleep 1;
};


sleep 5;
[position _unit,["", _unit],_isHalo==2,(position _unit) select 2,0,false,true,false] spawn MCC_fnc_paradrop;

if (isplayer _unit) then {

	//Make some lights will you? testLight
	_light = "#lightpoint" createVehicleLocal [1,1,1];
	_light lightAttachObject [_plane, [0,4,-1]];
	_light setLightBrightness 0.05;
	_light setLightAmbient[.1, 0, 0];
	_light setLightColor[.3, 0, 0];

	//Cinametic
	if (!alive _unit || !alive _plane) exitWith {};
	private ["_camera","_relPos","_relDir"];
	_camera = "Camera" camcreate getpos _unit;
	_camera cameraeffect ["internal","back"];
	_camera camPrepareFOV 0.900;
	_camera camsetTarget vehicle _unit;
	cameraEffectEnableHUD false;
	showCinemaBorder true;

	_relPos = [getpos _plane,150,getdir _plane] call BIS_fnc_relpos;
	_relPos set [2, (getpos _plane select 2)+2];
	_camera camsetpos _relPos;
	_camera camcommit 0;
	titleText ["","BLACK IN",1];

	sleep 2;

	for [{_x=0},{_x < 20},{_x=_x+1}] do
	{
		_relDir = if (getdir _plane > 270) then {360 - (getdir _plane) + 90} else {(getdir _plane) + 90};
		_relPos = [getpos _plane,20,_relDir] call BIS_fnc_relpos;
		_relPos set [2, (getpos _plane select 2)+2];
		_camera camsetpos _relPos;
		_camera camcommit 0.5;
		sleep 0.5;
		if (_x == 10) then {[] call MCC_fnc_camp_showOSD};
	};

	//_camera attachTo [_plane , [20,5,-1]];
	_relDir = if (getdir _plane > 270) then {360 - (getdir _plane) + 90} else {(getdir _plane) + 90};
	_relPos = [getpos _plane,10,_relDir] call BIS_fnc_relpos;
	_camera camsetTarget _unit;
	_camera camsetpos _relPos;
	_camera camsetFOV 0.01;
	_camera camcommit 2;
	sleep 2;
	_camera cameraEffect ["TERMINATE", "BACK"];
	camdestroy _camera;
	_camera = nil;
};

//Drop pods? exit
if (_isHalo ==1) exitWith {};

//let them sit for a while
while {!_jumpReady} do {
	sleep 1;
	_jumpReady = _plane getvariable "MCCjumpReady";
};

/*
//Make them stand on the ramp
if (isplayer _unit) then {
	titleText ["Get Ready To Jump","BLACK FADED",2];
};

while {vehicle _unit != _unit} do {
	unassignVehicle _unit;
	 moveout _unit;
	_unit action ["EJECT",vehicle _unit];
	sleep 0.2;
};


//Broken for some reason will fix it someday
_unit allowdamage false;
_unit enablesimulation false;

_unit setPos [(getPos _unit)select 0,(getPos _unit)select 1,1000];

_unit switchMove "";
sleep 1;
_unit disableCollisionWith _plane;
_plane disableCollisionWith _unit;

_unit attachto [_plane,_unitPosition];
_unit setDir _dir;

if ((primaryWeapon _unit) != "") then
{
	if ((currentWeapon _unit) == (primaryWeapon _unit)) then
	{
		_unit playmoveNow "amovpercmstpslowwrfldnon";
	};
};

if (!isPlayer _unit) then
{
	_unit disableAI "MOVE";
	_unit disableAI "FSM";
};

sleep 1;
_unit enablesimulation true;
sleep 2;

if (isplayer _unit) then
{
	titleText ["","BLACK IN",2];
};

sleep 4;

////start the jump, Turn the light green
if (isplayer _unit) then
{
	_light setLightColor [0,0.3,0];
	_light setLightAmbient [0,0.1,0];
};
*/
_time = time + 10;
waituntil {(_plane getVariable "MCCJumperNumber") == _unitNumber || time > _time}; //wait for your turn

/*

if (isplayer _unit) then {
	titleText ["Jump Jump Jump !!!","BLACK FADED",1];
	sleep 1;
	titleText ["","BLACK IN",1];
};

//Start the run
_unit setdir _dir;


_y = _unitPosition select 1;
_x = _unitPosition select 0;
_unit attachto [_plane,[_x,_y, (_unitPosition select 2)]];
while {(animationState _unit) != "AmovPercMrunSlowWrflDf"} do {_unit playmoveNow "AmovPercMrunSlowWrflDf"};
while {(_y > -5)} do {
	_y = _y - 0.18;

	//Lets not bang our head with the helicopter doorway
	if (_y > -3) then {
		_unit attachto [_plane,[_x, _y, (_unitPosition select 2)]];
	} else {
		_unit attachto [_plane,[_x, _y, (_unitPosition select 2)]];
	};
	sleep 0.01;
};
*/

while {vehicle _unit != _unit} do {
	unassignVehicle _unit;
	 moveout _unit;
	_unit action ["EJECT",vehicle _unit];

	waituntil {vehicle _unit == _unit};

	if (!isPlayer _unit) then {
		_unit enableAI "MOVE";
		_unit enableAI "FSM";
	};
};

sleep 1;
_plane setVariable ["MCCJumperNumber",_unitNumber + 1,true];

/*
//_unit playmoveNow "";
_pos = getpos _unit;
sleep 0.05;
detach _unit;
sleep 0.05;

_dir = getdir _unit;
//Open Chute
if (!isPlayer _unit) then {
	_unit enableAI "MOVE";
	_unit enableAI "FSM";
	_unit playmoveNow "HaloFreeFall_non";
};

sleep 4;


if (_isHalo == 2) then {
	waituntil  {isPlayer _unit || ((position _unit) select 2) < 200};
	_unit addBackpack "B_Parachute";
} else {
	_vehicle = createVehicle ["Steerable_Parachute_F", position _unit, [], ((_dir)-3+(random 6)), 'NONE'];

	waituntil {!isNil "_vehicle"};
	_pos = getpos _unit;
	_vehicle setPos _pos;
	_vehicle setDir getdir _unit;
	_unit MoveInDriver _vehicle;
};

*/

if (!isnil "_light" && isPlayer _unit) then {deleteVehicle _light};
_unit allowdamage true;