private ["_unit","_plane","_positions","_dir","_isHalo","_jumpReady","_unitPosition","_isCargo","_y","_x","_pos","_vehicle","_init","_time","_light"];
_plane 		= _this select 0;												//where from
_unit 		= _this select 1;												//Who is jumping
_unitNumber	= _this select 2;												//what is his jumper number
_isCargo	= false; 

_positions 	= [[-0.5,-2.5,-2.23],[0.5,-2.5,-2.23],[-0.5,-1,-2.23],[0.5,-1,-2.23],[-0.5,0.5,-2.23],[0.5,0.5,-2.23],
				[-0.5,2,-2.23],[0.5,2,-2.23],[-0.5,3.5,-2.23],[0.5,3.5,-2.23],[-0.5,4.5,-2.23],[0.5,4.5,-2.23]];

_dir			= 180;														//set the units looking the ramp
_unitPosition 	= _positions select _unitNumber;
_isHalo			= _plane getvariable ["MCCisHALO",false]; 
_jumpReady		= _plane getvariable "MCCjumpReady"; 

sleep .1;

if (isNull _unit) exitwith {};

if (!local _unit || !alive _plane) exitwith {};

if (isplayer _unit) then
{
	titleText ["","BLACK FADED",5];	
};

if ((vehicle _unit != _unit) && (vehicle _unit != _plane)) then {unassignVehicle _unit; sleep 0.5;}; 
_unit assignAsCargo _plane;
_unit moveInCargo _plane;
		
/*		
while {!_isCargo && (alive _plane)} do
{
	if ((vehicle _unit != _unit) && (vehicle _unit != _plane)) then {unassignVehicle _unit; sleep 0.5;}; 
	_unit assignAsCargo _plane;
	_unit MoveInCargo _plane;
	sleep 1;
	if (vehicle _unit == _plane) then {_isCargo = true};
};
*/

sleep 5;

if (isplayer _unit) then
{

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
	titleText ["","BLACK IN",2];
	
	sleep 2; 
		
	for [{_x=0},{_x < 30},{_x=_x+1}] do 
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
	_camera camcommit 3;
	sleep 3;
	_camera cameraEffect ["TERMINATE", "BACK"];
	camdestroy _camera;
	_camera = nil;
};
				
while {!_jumpReady} do {sleep 1;_jumpReady = _plane getvariable "MCCjumpReady"}; 	//let them sit for a while

//Make them stand on the ramp		
if (isplayer _unit) then
{
	titleText ["Get Ready To Jump","BLACK FADED",2];											
};

_unit allowdamage false; 		
_unit enablesimulation false;

while {vehicle _unit != _unit} do 
{
	unassignVehicle _unit;
	_unit action ["EJECT",vehicle _unit];	
	/*				
	[_unit] orderGetIn false;
	_unit leaveVehicle vehicle _unit;
	sleep 0.2;
	unassignVehicle _unit;
	sleep 0.2;
	_unit action ["getout",vehicle _unit];
	*/
	sleep 0.2;
};

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

_time = time + 40; 
waituntil {(_plane getVariable "MCCJumperNumber") == _unitNumber || time > _time}; //wait for your turn

//Start the run
_unit setdir _dir;
	

_y = _unitPosition select 1;
_x = _unitPosition select 0;
_unit attachto [_plane,[_x,_y, -2.23]];
while {(animationState _unit) != "AmovPercMrunSlowWrflDf"} do {_unit playmoveNow "AmovPercMrunSlowWrflDf"};
while {(_y > -5)} do 
{												
	_y = _y - 0.18;
	
	//Lets not bang our head with the helicopter doorway
	if (_y > -3) then
	{
		_unit attachto [_plane,[_x, _y, -2.23]];
	}
	else
	{
		_unit attachto [_plane,[_x, _y, -2.7]];
	};
	sleep 0.01;
};

_plane setVariable ["MCCJumperNumber",_unitNumber + 1,true];
//_unit playmoveNow "";
_pos = getpos _unit;
sleep 0.05;
detach _unit;
sleep 0.05;

_dir = getdir _unit;
//Open Chute
if (!isPlayer _unit) then	
{
	_unit enableAI "MOVE"; 
	_unit enableAI "FSM"; 
	_unit playmoveNow "HaloFreeFall_non";
};

sleep 4; 

if (_isHalo) then 
{
	_unit addBackpack "B_Parachute";
}
else
{
	_vehicle = createVehicle ["Steerable_Parachute_F", position _unit, [], ((_dir)-3+(random 6)), 'NONE'];

	waituntil {!isNil "_vehicle"};
	_pos = getpos _unit;
	_vehicle setPos _pos;
	_vehicle setDir getdir _unit;
	_unit MoveInDriver _vehicle;
};			

if (!isnil "_light" && isPlayer _unit) then {deleteVehicle _light}; 
_unit allowdamage true; 