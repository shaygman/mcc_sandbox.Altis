//MCC_fnc_loginDialog
//(c) 03.13 shay gman

private ["_ar", "_mccdialog", "_login","_null","_isAdmin","_t","_missionMaker"];

//update request number
mcc_request= (missionNamespace getVariable ["mcc_request",0])+1;

_isAdmin = if (serverCommandAvailable "#logout" || isServer) then {true} else {false};
_ar = [
	player
	, name (player)
	, mcc_request
	, _isAdmin
	];

// Send data over the network, or when on server, execute directly
_null = [_ar,"mcc_fnc_login",false,false] call BIS_fnc_MP;

//Close dialog
_t = time + 5;
_missionMaker = missionNamespace getVariable ["mcc_missionmaker",""];

while {dialog} do {closeDialog 0; sleep 0.1};

while {(missionNamespace getVariable ["mcc_missionmaker",""]) == _missionMaker && time < _t} do {sleep 0.1};
_null = [nil,nil,nil,nil,0] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";



