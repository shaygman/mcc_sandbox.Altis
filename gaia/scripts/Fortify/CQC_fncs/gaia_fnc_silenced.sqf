_firer = _this select 0;
_weapon = _this select 1;
_ammo = gettext (configfile >> "cfgmagazines" >> (currentmagazine _firer) >> "ammo");
_loudness = getnumber (configfile >> "cfgammo" >> _ammo >> "audiblefire");
if (_loudness < 1) then {_loudness = (_loudness * 20)};

_accessories = _firer weaponAccessories _weapon;

_silencer = if (format ["%1",_accessories select 0] != "") then
{
	true;
}
else
{
	false;
};

if (_silencer) then
{
	_loudness = _loudness/10;
};

_loudness