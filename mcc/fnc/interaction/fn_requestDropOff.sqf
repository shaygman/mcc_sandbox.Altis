//==================================================================MCC_fnc_requestDropOff===============================================================================================
// Request player or AI to drop off a cargo group in a specific place - shold run localy on the requestor
// Example:[] call MCC_fnc_requestDropOff
//=================================================================================================================================================================================
private ["_prePos","_command","_vehicPlayer"];
 openMap true;
 cutText ["Mark your drop-off point", "PLAIN DOWN",1,true];
 MCC_mapClick 	= nil; 
 _vehicPlayer 	= vehicle player;
 _prePos 		= getpos _vehicPlayer; 

 ["MCC_requestDropOffEH", "onMapSingleClick", {
	MCC_mapClick = _pos; 
}] call BIS_fnc_addStackedEventHandler;

//send WP
waituntil {!isnil "MCC_mapClick"};
openMap false;
cutText ["", "PLAIN DOWN",1,true];

_command = compile format ['titleText ["%1 Request Drop-off at X-ray: %2 Yankee: %3","PLAIN DOWN"]; titleFadeOut 60;',name player, floor (MCC_mapClick select 0), floor (MCC_mapClick select 1)];
[[_command], "BIS_fnc_spawn", driver _vehicPlayer, false] spawn BIS_fnc_MP;

[[1,MCC_mapClick,[9,"NO CHANGE","NO CHANGE","FULL","UNCHANGED","", {},0],[group driver _vehicPlayer]],"MCC_fnc_manageWp",  driver _vehicPlayer, false] spawn BIS_fnc_MP;

if (_vehicPlayer isKindof "air") then
{
	[[0,MCC_mapClick,[17,"NO CHANGE","NO CHANGE","FULL","UNCHANGED","", {},0],[group driver _vehicPlayer]],"MCC_fnc_manageWp",  driver _vehicPlayer, false] spawn BIS_fnc_MP;
	[[0,_prePos,[0,"NO CHANGE","NO CHANGE","FULL","UNCHANGED","", {},0],[group driver _vehicPlayer]],"MCC_fnc_manageWp",  driver _vehicPlayer, false] spawn BIS_fnc_MP;
	[[0,_prePos,[17,"NO CHANGE","NO CHANGE","FULL","UNCHANGED","", {},0],[group driver _vehicPlayer]],"MCC_fnc_manageWp",  driver _vehicPlayer, false] spawn BIS_fnc_MP;
};

//Clean up
MCC_mapClick = nil;
["MCC_requestDropOffEH", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;