private ["_pos", "_dir", "_weapons", "_magazines", "_box", "_count","_items","_rucks"];
_pos 		= _this select 0;
_dir 		= _this select 1;
_weapons 	= _this select 2;
_magazines 	= _this select 3;
_items		= _this select 4;
_rucks		= _this select 5;

_box = "B_supplyCrate_F" createvehicle _pos;
_box setpos _pos;
_box setpos _pos;
_box setdir _dir;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

sleep 2;
_count = 0;						//Add weapons
{
	_box addWeaponCargoGlobal [_x,(_weapons select 1) select _count];
	_count = _count+ 1;
} foreach (_weapons select 0);

_count = 0;						//Add Mags
{
	_box addMagazineCargoGlobal [_x,(_magazines select 1) select _count];
	_count = _count+ 1;
} foreach (_magazines select 0);

_count = 0;						//Add Items
{
	_box addItemCargoGlobal [_x,(_items select 1) select _count];
	_count = _count+ 1;
} foreach (_items select 0);

_count = 0;						//Add Items
{
	_box addBackpackCargoGlobal [_x,(_rucks select 1) select _count];
	_count = _count+ 1;
} foreach (_rucks select 0);