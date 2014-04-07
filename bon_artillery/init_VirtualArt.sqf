private ["_arti","_type","_dummypos"];

_type = _this select 0; 

if (!isserver) exitWith {}; 

//Artillery Init
if (_type==0) then 
{			
	_arti = _this select 1; 
	_arti addeventhandler["fired", {[4,_this select 0, _this select 4] spawn MCC_fnc_amb_Art}]; //Delete the projectile.
	_dummypos = [getpos _arti, 50, getdir _arti] call BIS_fnc_relPos;
	sleep 1; 
	(gunner _arti) lookAt [_dummypos select 0, _dummypos select 1,(_dummypos select 2)+100];
	_arti disableAI "AUTOTARGET";
	_arti disableAI "TARGET";
	MCC_virtualArtilleryPieces = MCC_virtualArtilleryPieces + [_arti]; 
	publicvariable "MCC_virtualArtilleryPieces"; 
};