//(c) 03.13 shay gman

private ["_ar", "_mccdialog", "_login","_null","_isServer"];

//update request number
mcc_request=mcc_request+1;

_isServer = if (serverCommandAvailable "#logout" || isServer) then {true} else {false}; 
_ar = [
	player
	, name (player)
	, mcc_request
	, _isServer
	];

// Send data over the network, or when on server, execute directly
if (isServer) then 
{
	[_ar,"mcc_fnc_login",false,false] spawn BIS_fnc_MP;
} 
else 
{
	[_ar,"mcc_fnc_login",true,false] spawn BIS_fnc_MP;
};

//Close dialog 
sleep 0.5; 
closeDialog 0;
_null = [] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";



