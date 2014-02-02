private ["_suspect","_side","_rad","_targ","_count","_pos","_tim","_weapon","_mag"];
_suspect  = _this select 0;
_side = _this select 1;
_rad  = _this select 2;
_weapon = _this select 3;
_mag  = _this select 4;
_suspect setvariable ["armed",true,true];

_targ = ["Car","Man"];

// =============================Chase script by Shay_Gman=================
 _check=true;
while {alive _suspect && _check} do 
	{  
	sleep 1;
	_close = (getPos _suspect) nearObjects 50;
	if(_side countSide _close > 0) then	{
		_t=600;
		while {(alive _suspect) && (_check) && (_t > 0)} do	{
			sleep 1;
			_closeunit = [];
			{if(side _x == _side) then {_closeunit = _closeunit + [_x]}} forEach _close;
			_count=count _closeunit;
			for [{_x=0},{_x<_count},{_x=_x+1}] do	{
				_enemy = _closeunit select _x;
				{
					if(_enemy isKindOf _x && _check) then	{
						while {alive _suspect && _check} do	{
							sleep 2;
							_rand = random 100;

							if (((_suspect distance _enemy ) <=_rad) &&  (alive _enemy) && (_rand < 5)) then	{
								_cap = _suspect getvariable "armed";
								_suspect setbehaviour "COMBAT"; 
								if (_cap && alive _suspect) then	{
									if (!(_suspect hasweapon _weapon)) then {
										{_suspect addmagazine _mag} foreach [1,2,3,4,5];
										_suspect addweapon _weapon;
										_suspect selectweapon _weapon;
										[[[netid _suspect,_suspect], "pig"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
									};
									waitUntil{unitReady _suspect};
									sleep 1;
									_suspect dotarget  _enemy;
									_suspect addrating -2500;
									waitUntil{unitReady _suspect};
									_suspect dofire  _enemy;
									_check =false;
								};
							};
						}
					};
				} forEach _targ;
			};
			_t=_t-1;
			};
		};

	};
if (!alive _suspect) then {_suspect removeaction 0;};

if (true) exitWith {};