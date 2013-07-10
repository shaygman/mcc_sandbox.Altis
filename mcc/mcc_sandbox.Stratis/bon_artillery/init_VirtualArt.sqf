private ["_arti","_type","_dummypos"];

_type = _this select 0; 

if (!isserver) exitWith {}; 

//Waits until UPSMON is init
waitUntil {!isNil("KRON_UPS_INIT")};
waitUntil {KRON_UPS_INIT==1};

if (_type==0) then {			//Artillery Init
	_arti = _this select 1; 
	_arti addeventhandler["fired", {_null =[4,_this select 0, _this select 4] execVM MCC_path + "mcc\general_scripts\ambient\amb_art.sqf"}]; //Delete the projectile.
	_dummypos = [getpos _arti, 50, getdir _arti] call R_relPos3D;
	sleep 1; 
	(gunner _arti) lookAt [_dummypos select 0, _dummypos select 1,(_dummypos select 2)+100];
	_arti disableAI "AUTOTARGET";
	_arti disableAI "TARGET";
	MCC_virtualArtilleryPieces = MCC_virtualArtilleryPieces + [_arti]; 
	publicvariable "MCC_virtualArtilleryPieces"; 
	};