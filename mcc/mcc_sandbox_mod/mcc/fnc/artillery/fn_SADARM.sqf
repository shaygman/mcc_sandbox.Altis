//==================================================================MCC_fnc_SADARM===============================================================================================
// drop a bomb that explode to some skeets that will search and destroy near by armor
// Example: [_planepos, _pilot] spawn MCC_fnc_SADARM;
// _planepos = position,  plane position
// _pilot = unit, plane's pilot
//===========================================================================================================================================================================
private ["_pos","_pilot","_para","_bomb","_split", "_targets", "_targetpos", "_x"];
_pos = _this select 0;
_pilot = _this select 1;

_para = "ParachuteC" createVehicle [_pos select 0,_pos select 1,3000];		//Make the bomb and the parachute
_para setpos [_pos select 0,_pos select 1,(_pos select 2) -10];
_bomb = "CruiseMissile1" createvehicle [_pos select 0,_pos select 1,3000]; 
for [{_x = 1},{_x <= 3},{_x = _x+1}] do 
	{
		_bomb attachTo [_para, [0,0,0]];
		_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
		sleep 0.02;
	};
	
WaitUntil{(getpos _bomb select 2) < 150};
_targets = nearestObjects [getpos _bomb ,["Car","Tank"],200];	//Find targets: cars or tanks
_targetpos = [];
{_targetpos = _targetpos + [getPos _x]} forEach _targets;
while{count _targetpos <= 6} do 								//If no targets make random pos
	{
		_targetpos = _targetpos + [[(getpos _bomb select 0)+100-(random 200), (getpos _bomb select 1)+100-(random 200), 0]];
	};

WaitUntil{(getpos _bomb select 2) < 100};						//Make the Skeets
_split = "HelicopterExploSmall" createvehicle getpos _bomb;	
deletevehicle _bomb;
deletevehicle _para;
for [{_x = 0},{_x <= 6},{_x = _x+1}] do 
	{
	_bomb = "ARTY_SADARM_PROJO" createvehicle (_targetpos select _x);
	sleep 0.2;
	};
