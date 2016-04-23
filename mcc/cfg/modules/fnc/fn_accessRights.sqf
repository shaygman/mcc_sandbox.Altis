
//********************************************MCC_fnc_accessRights**********************************************
//==========================================================================================
//=		 						 Shay-Gman
//=					                             24.12.2011
//==========================================================================================
//******************************************************************************************
private ["_logic","_namesList","_synced"];


// Exit if player or HC
if !(hasInterface || isServer) exitWith {};

_logic 		= _this select 0;
_namesList 	= call compile (_logic getvariable ["names","[]"]);
_namesList = _namesList + (missionNameSpace getVariable ["MCC_allowedPlayers",[]]);
missionNamespace setVariable ["MCC_allowAdmin",_logic getvariable ["allowAdmin",true]];

_logic setpos [1000,10,0];
waituntil {isplayer player && alive player && MCC_initDone};

_synced = synchronizedobjects _logic;									//Who synced with the module

{
	if (getPlayerUID _x != "") then {_namesList pushBack (getPlayerUID _x )}
} forEach _synced;

missionNameSpace setVariable ["MCC_allowedPlayers", _namesList];
publicVariable "MCC_allowedPlayers";
/*
if (((getPlayerUID player) in _namesList) || (player in _synced)) then
{
	player setvariable ["MCC_allowed",true,true];
}
else
{
	player setvariable ["MCC_allowed",false,true];
};
