//==================================================================MCC_fnc_manageAC=====================================================================================
// Create a an armed civilian at the given position
// Example: [_suspect,_side,_rad] spawn MCC_fnc_manageAC;
// <in>: 	_suspect = unit, the suspect.
// 		_side = side, which side trigger the armed civilian
//		_rad = integer, how far the armed civilian will look for threats
// <out>	<nothing>
//====================================================================================================================================================================
private ["_suspect","_side","_rad","_targ","_count","_pos","_tim","_weapon","_mag","_weaponList","_randWeapon","_dummy","_grp"];
_suspect 		= param [0,objNull];
_side 			= param [1,sideEnemy];
_rad  			= param [2,25];

if (typeName _side == "STRING") then {
	_side = switch (tolower _side) do
				{
				   case "west":	{[west]};
				   case "east":	{[east]};
				   case "guer":	{[resistance]};
				   case "civ":	{[civilian]};
				   default {[west]};
				};
};

if (typeName _side == typeName sideLogic) then {_side = [_side]};

_weaponList = [
                ["hgun_P07_F", "16Rnd_9x21_Mag"],
				["hgun_Rook40_F", "16Rnd_9x21_Mag"],
				["hgun_ACPC2_F", "9Rnd_45ACP_Mag"],
				["hgun_Pistol_heavy_01_F", "11Rnd_45ACP_Mag"],
				["hgun_Pistol_heavy_02_F", "6Rnd_45ACP_Cylinder"],
				["SMG_01_F", "30Rnd_45ACP_Mag_SMG_01"],
				["SMG_02_F", "30Rnd_9x21_Mag"],
				["hgun_PDW2000_F", "30Rnd_9x21_Mag"]
			  ];

_randWeapon = floor random (count _weaponList);
_weapon = (_weaponList select _randWeapon) select 0;
_mag = (_weaponList select _randWeapon) select 1;

removeallweapons _suspect;
_suspect setbehaviour "CARELESS";
_suspect allowfleeing 0;

_dummy = MCC_dummy createVehicle (getpos _suspect);
_dummy setVariable ["fakeIed",_suspect];
_dummy hideobjectGlobal true;
_dummy attachto [_suspect,[0,0,0]];

[_suspect, _dummy] spawn {
	private ["_suspect"];
	_suspect 	= _this select 0;
	_dummy 		= _this select 1;
	waituntil {!alive _suspect || isnull _suspect};
	sleep 1;
	deletevehicle _dummy;
};

_dummy setvariable ["armed", true, true];
_dummy setvariable ["iedMarkerName", "Armed Civilian", true];

//Make him move around
if !(_suspect getVariable ["static",false]) then {[group _suspect, getPos _suspect, 350] call bis_fnc_taskPatrol};

_targ = ["Car","Man"];

// =============================Chase script by Shay_Gman=================
 _check=true;

while {alive _suspect && _check} do {
	sleep 1;
	_check = _suspect getvariable ["armed",true];
	_close = (getPos _suspect) nearObjects _rad;

	if(({side _x in _side} count _close > 0) || {isPlayer _x} count _close > 0) then {
		_t=600;

		while {(alive _suspect) && (_check) && (_t > 0)} do {
			sleep 1;
			_check = _suspect getvariable ["armed",true];
			_closeunit = [];
			{
				if (side _x in _side || isPlayer _x) then {_closeunit = _closeunit + [_x]}
			} forEach _close;

			_count=count _closeunit;

			for [{_x=0},{_x<_count},{_x=_x+1}] do {
				_enemy = _closeunit select _x;

				{
					if(_enemy isKindOf _x && _check) then {

						while {alive _suspect && _check} do {
							sleep 2;
							_check = _suspect getvariable ["armed",true];
							_rand = random 100;

							if (((_suspect distance _enemy ) <=_rad) &&  (alive _enemy) && (_rand < 15)) then {

								_suspect setbehaviour "COMBAT";
								if (alive _suspect) then {

									if (!(_suspect hasweapon _weapon)) then {

										switch (side _enemy) do {
											case west: {_grp = createGroup east};
											case east: {_grp = createGroup west};
											case resistance:
											{if ((west getFriend resistance)>0.5)then {_grp = createGroup east} else {_grp = createGroup west}};
											case civilian: {if ((west getFriend civilian)>0.5) then {_grp = createGroup east} else {_grp = createGroup west}};
											default {_grp = createGroup east};
										};

										[_suspect] joinSilent grpNull;
										sleep 1;
										[_suspect] joinsilent _grp;
										sleep 1;
										{_suspect addmagazine _mag} foreach [1,2,3,4,5];
										_suspect addweapon _weapon;
										_suspect selectweapon _weapon;
										[[[netid _suspect,_suspect], "pig"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
									};


									_suspect dotarget  _enemy;
									_suspect addrating -1;

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

if (!alive _suspect) then {
	{deleteVehicle _x} forEach attachedObjects _suspect;
};

if (true) exitWith {};