private ["_plane", "_pos", "_target", "_cas_name"];

_plane = _this select 0;
_pos = _this select 1;
_cas_name = _this select 2;
_target = _this select 3;

while {(_plane distance _pos < 1300) && (damage _target < 0.8)} do 
{	
	[playerSide,'HQ'] sidechat format ["%1 Engaging target", _cas_name];
	(group _plane) setBehaviour "COMBAT";
	_plane enableAI "TARGET";
	(group _plane) reveal [_target, 3.5];
	(group _plane) doTarget _target;
	sleep 0.1;
	(group _plane) doFire _target;
	waitUntil { sleep 0.6; ( damage _target > 0.8 )};
};
