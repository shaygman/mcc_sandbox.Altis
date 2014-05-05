private ["_unit","_plane","_positions","_dir","_isHalo","_jumpReady","_unitPosition","_dropPos","_isCargo","_y","_x","_pos","_vehicle","_init","_time","_light"];
_plane 		= _this select 0;												//where from
_unit 		= _this select 1;												//Who is jumping
_unitNumber	= _this select 2;												//what is his jumper number
_dropPos	= _this select 3;												//where is the LZ
_isCargo	= false; 

_positions 	= [[-0.5,-2.5,-2.23],[0.5,-2.5,-2.23],[-0.5,-1,-2.23],[0.5,-1,-2.23],[-0.5,0.5,-2.23],[0.5,0.5,-2.23],
				[-0.5,2,-2.23],[0.5,2,-2.23],[-0.5,3.5,-2.23],[0.5,3.5,-2.23],[-0.5,4.5,-2.23],[0.5,4.5,-2.23]];

_dir			= 180;														//set the units looking the ramp
_unitPosition 	= _positions select _unitNumber;
_isHalo			= _plane getvariable ["MCCisHALO",false]; 
_jumpReady		= _plane getvariable "MCCjumpReady"; 

sleep .1;

if (isNull _unit) exitwith {};

if (!local _unit) exitwith {};

titleText ["","BLACK FADED",5];	
while {!_isCargo && (alive _plane)} do
{
		if (vehicle _unit != _unit) then {unassignVehicle _unit}; 
		_unit assignAsCargo _plane;
		_unit MoveInCargo [_plane,_unitNumber];
		sleep 0.5;
		if (vehicle _unit == _plane) then {_isCargo = true};
};

sleep 2;

//Make some lights will you?
_light = "#lightpoint" createVehicleLocal [1,1,1];
_light lightAttachObject [_plane, [0,4.2,-1]];
_light setLightBrightness 0.01;
_light setLightAmbient[.8, 0, 0];
_light setLightColor[.9, 0, 0];

titleText ["","BLACK IN",5];	

if (!alive _unit || !alive _plane) exitWith {};

while {!_jumpReady} do {sleep 1;_jumpReady = _plane getvariable "MCCjumpReady"}; 	//let them sit for a while
titleText ["Get Ready To Jump","BLACK FADED",2];												//Make them stand on the ramp		
_unit allowdamage false; 		
_unit enablesimulation false;
_unit action ["getout",vehicle _unit];
unassignVehicle _unit;
//waituntil {vehicle _unit == _unit};
_unit setPos [(getPos _unit)select 0,(getPos _unit)select 1,1000];

_unit switchMove "";
sleep 1; 
_unit disableCollisionWith _plane;
_plane disableCollisionWith _unit;

_unit attachto [_plane,_unitPosition];
_unit setDir _dir;
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
};

sleep 1;
_unit enablesimulation true;
sleep 2;

titleText ["","BLACK IN",2];

////start the jump, Turn the light green
_light setLightColor [0,1,0];					
_light setLightAmbient [0,0.8,0]; 

_time = time + 40; 
waituntil {(_plane getVariable "MCCJumperNumber") == _unitNumber || time > _time}; //wait for your turn

//Start the run
_unit setdir _dir;
while {(animationState _unit) != "AmovPercMevaSrasWrflDf"} do {_unit playmoveNow "AmovPercMevaSrasWrflDf"};
_y = _unitPosition select 1;
_x = _unitPosition select 0;		
while {(_y > -7)} do 
{												
	if ((animationState _unit) != "AmovPercMevaSrasWrflDf") then	
	{
		_unit setdir _dir;
		while {(animationState _unit) != "AmovPercMevaSrasWrflDf"} do {_unit playmoveNow "AmovPercMevaSrasWrflDf"};
	};
					
	if ((animationState _unit) == "AmovPercMevaSrasWrflDf") then	
	{
		_y = _y - 0.1;
	};
	
	//Lets not bang our head with the helicopter doorway
	if (_y > -3) then
	{
		_unit attachto [_plane,[_x, _y, -2.23]];
	}
	else
	{
		_unit attachto [_plane,[_x, _y, -3]];
	};
	_unit setDir _dir;
					
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
	_unit MoveInDriver _vehicle;
};			

_unit allowdamage true; 

