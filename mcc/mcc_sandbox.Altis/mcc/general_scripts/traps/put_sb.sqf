//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_trapvolume", "_IEDExplosionType", "_IEDDisarmTime", "_IEDJammable", "_IEDTriggerType", "_group",
 "_trapdistance", "_iedside", "_iedMarkerName", "_sb", "_eib_marker", "_sound", "_targ", "_sbspeed", "_check", "_close" , "_closeunit", "_count", "_enemy", "_IedExplosion"]; 

_sound=1; //choose 0 for no sounds
_targ = ["Car","Tank","Man"];
_sbspeed = ["LIMITED","NORMAL","FULL"];

_pos = _this select 0; 
_trapkind = _this select 1; 
_trapvolume = _this select 2; 
_IEDExplosionType = _this select 3; 
_IEDDisarmTime = 10; 
_IEDJammable = false;
_IEDTriggerType = 1;
_trapdistance = 20;
_iedside = _this select 4;
_iedMarkerName = _this select 5;

_eib_marker = createMarkerlocal ["traps",_pos];
_pos= getMarkerPos "traps";
//hint format ["%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11", _pos, _trapkind, _trapvolume, _IEDExplosionType, _IEDDisarmTime, _IEDJammable, _IEDTriggerType, _IEDAmbushGroup,_trapdistance, _iedside, _iedMarkerName];

_group = creategroup civilian;
_trapkind createunit [_pos, _group,"removeallweapons this;",1];
_sb = leader _group;
_sb setposatl _pos;
_sb setdir (random 360);
_sb setvariable ["iedTrigered", false, true];

[_sb, _iedMarkerName] spawn
	{
		private ["_fakeIedS","_iedMarkerNameS"];
		_fakeIedS = _this select 0;
		_iedMarkerNameS = _this select 1;
		waituntil {!alive _fakeIedS};
		[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerNameS]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
		_fakeIedS setvariable ["iedTrigered", true, true]; 
	};


_check=true;
sleep 0.01;
deletemarker "traps";

while {alive _sb && _check} do 
	{  
	sleep 1;
	_close = (getPos _sb) nearObjects 100;
	if(_iedside countSide _close > 0) then 
		{
			while {(alive _sb) && (_check)} do
			{
				sleep 1;
				_closeunit = [];
				{if(side _x == _iedside) then {_closeunit = _closeunit + [_x]}} forEach _close;
				_count=count _closeunit;
				for [{_x=0},{_x<_count},{_x=_x+1}] do
					{
					_enemy = _closeunit select _x;
					{if(_enemy isKindOf _x && _check) then
						{
						_sb setSpeedMode (_sbspeed select (round (random 3)));
						_sb setskill 1;
						_sb setskill ["courage",1];
						_sb domove (getpos _enemy);
						sleep 5 + random 10;
						if ((_sb distance _enemy) < 40) then {
								_sb setspeedmode "FULLSPEED";
								_sb setBehaviour "CARELESS";
								_sb setunitpos "UP";
								_sb disableAI "TARGET";
								_sb disableAI "AUTOTARGET";
								(group _sb) setCombatMode "BLUE";
								(group _sb) allowFleeing 0;
								while {alive _sb} do{
									sleep 1;
									_sb setskill 1;
									_sb setskill ["courage",1];
									_sb domove (getpos _enemy);
									_sb domove (getpos _enemy);
									if (_sound == 1) then {[[[netid _sb,_sb], "suicide"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;_sound = 0};
									if ((_sb distance _enemy) <=15) exitwith { _check= false;};
									};
								};
						}
					} forEach _targ;
				};
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
if (true) exitWith {};
	
