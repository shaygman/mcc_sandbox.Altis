
//******************************************************************************************
//==========================================================================================
//=		 						 Shay-Gman 
//=					                             24.12.2011
//==========================================================================================
//******************************************************************************************
private ["_logic","_namesList","_synced"];


// Exit when no player system
if !(hasInterface) exitWith {}; 

_logic 		= _this select 0;
_namesList 	= call compile (_logic getvariable ["names","[]"]); 

_logic setpos [1000,10,0];
waituntil {isplayer player && alive player && MCC_initDone};

_synced = synchronizedobjects _logic;									//Who synced with the module

if (((getPlayerUID player) in _namesList) || (player in _synced)) then 
{
	player setvariable ["MCC_allowed",true,true];
} 
else
{
	player setvariable ["MCC_allowed",false,true];
};
