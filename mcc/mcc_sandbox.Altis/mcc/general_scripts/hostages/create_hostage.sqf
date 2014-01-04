private ["_hostage","_init"];
_hostage = _this; 

removeallweapons _hostage; 
dostop _hostage; 
_hostage allowFleeing 0;
_hostage disableAI "MOVE"; 
_hostage addAction ["Secure Hostage", format ["%1mcc\general_scripts\hostages\hostage.sqf",MCC_path],[0],6,false,true];
_init = "removeallweapons _this; _this setcaptive true; _this switchmove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';";
[[[netID _hostage,_hostage], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;


