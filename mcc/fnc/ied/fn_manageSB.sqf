//==================================================================MCC_fnc_manageSB==============================================================================
// Handle suicide bomber behavior
// Example: [_sb, _iedside, _trapvolume, _IEDExplosionType] spawn MCC_fnc_manageSB;
// <in>: 	_sb 			= position, center of the explosion.
//		_iedside 			= side, which side trigger the armed civilian
//		_trapvolume 		= String "small", "medium", "large"
//		_IEDExplosionType	= Integer, 0- deadly 	1- Disabling	2- Fake
// <out>	NOTHING
//==================================================================================================================================================================
#define	MCC_MANAGESB_IED "DemoCharge_Remote_Ammo"

private ["_sb","_iedside","_trapvolume","_IEDExplosionType","_check","_close","_dummy","_init","_closeunit","_enemy","_sound","_targ","_sbspeed","_IedExplosion"];
_sb					= param [0,objNull];
_iedside			= param [1,west];
_trapvolume			= param [2,"medium"];
_IEDExplosionType	= param [3,1];

if (typeName _iedside == "STRING") then {
	_iedside = switch (tolower _iedside) do
				{
				   case "west":	{[west]};
				   case "east":	{[east]};
				   case "guer":	{[resistance]};
				   case "civ":	{[civilian]};
				   default {[west]};
				};
};

if (typeName _iedside == typeName sideLogic) then {_iedside = [_iedside]};


_sound		=1; //choose 0 for no sounds
_targ 		= ["Car","Tank","Man"];
_sbspeed 	= ["LIMITED","NORMAL","FULL"];

removeallweapons _sb;

_dummy = MCC_dummy createVehicle (getpos _sb);
_init = '_this hideobject true;';
[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

_dummy attachto [_sb,[0,0,0]];

_dummy setvariable ["armed", true, true];
_dummy setvariable ["iedMarkerName", "Suicide Bomber", true];

//Make him move around
if !(_sb getVariable ["static",false]) then {[group _sb, getPos _sb, 350] call bis_fnc_taskPatrol};

_check = true;

while {alive _sb && _check} do {
	sleep 1;
	_close = (getPos _sb) nearObjects 100;

	if({side _x in _iedside} count _close > 0) then {

		while {(alive _sb) && (_check)} do {
			sleep 1;
			_closeunit = [];
			{if(side _x in _iedside) then {_closeunit = _closeunit + [_x]}} forEach _close;

			{
				_enemy = _x;

				{
					if(_enemy isKindOf _x && ({alive _x} count (crew _enemy) > 0) && _check) then {

						//Revel demo charges
						private ["_exp"];
						{
							_exp = MCC_MANAGESB_IED createVehicle position _sb;
							_exp attachTo [_sb, (_x select 0), "Pelvis"];
							_exp setVectorDirAndUp (_x select 1);
						} forEach [ [[-0.1, 0.1, 0.15],[ [0.5, 0.5, 0], [-0.5, 0.5, 0] ]],
									[[0, 0.15, 0.15],[ [1, 0, 0], [0, 1, 0] ]],
									[[0.1, 0.1, 0.15],[ [0.5, -0.5, 0], [0.5, 0.5, 0] ]]
								  ];

						_sb setSpeedMode (_sbspeed select (round (random 3)));
						_sb setskill 1;
						_sb setskill ["courage",1];
						_sb domove (getpos _enemy);
						sleep 5 + random 10;
						if ((_sb distance _enemy) < 40) then
						{
							_sb setspeedmode "FULLSPEED";
							_sb forceSpeed 10;
							_sb setBehaviour "CARELESS";
							_sb setunitpos "UP";
							_sb disableAI "TARGET";
							_sb disableAI "AUTOTARGET";
							(group _sb) setCombatMode "BLUE";
							(group _sb) allowFleeing 0;
							while {alive _sb} do
							{
								sleep 1;
								_sb setskill 1;
								_sb setskill ["courage",1];
								_sb domove (getpos _enemy);
								_sb domove (getpos _enemy);
								if (_sound == 1) then
								{
									[[[netid _sb,_sb], format ["suicide%1", (floor random 4)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
									_sound = 0
								};
								if ((_sb distance _enemy) <=15) exitwith { _check= false;};
							};
						};
					}
				} forEach _targ;
			} foreach _closeunit;
		};
	};
};

switch (_IEDExplosionType) do
		{
		   case 0:
			{
				_IedExplosion = MCC_fnc_IedDeadlyExplosion;
			};

			case 1:
			{
			   _IedExplosion = MCC_fnc_IedDisablingExplosion;
			};

			case 2:
			{
			   _IedExplosion = MCC_fnc_IedFakeExplosion;
			};
		};

[getpos _sb,_trapvolume] spawn _IedExplosion;

_sb setdamage 1;

deleteVehicle _dummy;

//Delete ieds
{
	deleteVehicle _x
} forEach attachedObjects _sb;