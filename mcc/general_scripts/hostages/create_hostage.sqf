private ["_hostage","_init"];
_hostage = _this; 

removeallweapons _hostage; 
dostop _hostage; 
_hostage allowFleeing 0;
_hostage disableAI "MOVE"; 
_hostage setVariable ["MCC_disarmed",true,true];
removeallweapons _hostage;
_hostage setcaptive true;
_init = "_this switchmove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';";
[[[netID _hostage,_hostage], _init, false], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
[_hostage, "Hold %1 to interact"] spawn MCC_fnc_createHelper;


