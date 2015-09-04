//MCC_fnc_loginDialog
//(c) 03.13 shay gman

private ["_ar", "_mccdialog", "_login","_null","_isServer","_t","_missionMaker"];

//update request number
mcc_request= (missionNamespace getVariable ["mcc_request",0])+1;

_isServer = if (serverCommandAvailable "#logout" || isServer) then {true} else {false};
_ar = [
	player
	, name (player)
	, mcc_request
	, _isServer
	];

// Send data over the network, or when on server, execute directly
if (isServer) then {
	[_ar,"mcc_fnc_login",false,false] spawn BIS_fnc_MP;
} else {
	[_ar,"mcc_fnc_login",true,false] spawn BIS_fnc_MP;
};

//Close dialog
_t = time + 5;
_missionMaker = missionNamespace getVariable ["mcc_missionmaker",""];

while {dialog} do {closeDialog 0; sleep 0.1};

waitUntil {(missionNamespace getVariable ["mcc_missionmaker",""]) != _missionMaker || time >_t};
sleep 0.5;
_null = [nil,nil,nil,nil,0] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";



