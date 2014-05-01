private ["_object", "_weapons", "_magazines", "_box", "_count","_items","_rucks"];
_object		= _this select 0;
_weapons 	= _this select 1;
_magazines 	= _this select 2;
_items		= _this select 3;
_rucks		= _this select 4;

if !(_object iskindof "Tank" || _object iskindof "Air" ||  _object iskindof "car" || _object iskindof "ReammoBox" || _object iskindof "ReammoBox_F" || _object iskindof "ship") exitWith {};

_count = 0;						//Add weapons
{
	_object addWeaponCargoGlobal [_x,(_weapons select 1) select _count];
	_count = _count+ 1;
} foreach (_weapons select 0);

_count = 0;						//Add Mags
{
	_object addMagazineCargoGlobal [_x,(_magazines select 1) select _count];
	_count = _count+ 1;
} foreach (_magazines select 0);

_count = 0;						//Add Items
{
	_object addItemCargoGlobal [_x,(_items select 1) select _count];
	_count = _count+ 1;
} foreach (_items select 0);

_count = 0;						//Add Items
{
	_object addBackpackCargoGlobal [_x,(_rucks select 1) select _count];
	_count = _count+ 1;
} foreach (_rucks select 0);