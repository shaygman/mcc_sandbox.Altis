private ["_hostage","_init"];
_hostage = _this; 

removeallweapons _hostage; 
dostop _hostage; 
_hostage allowFleeing 0;
_hostage disableAI "MOVE";
_init = "_this setcaptive true; _this switchmove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';_this addAction [""Secure Hostage"", """+MCC_path+"mcc\general_scripts\hostages\hostage.sqf"",0,6,false,true]";
[[netID _hostage, _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;


