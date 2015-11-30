/************************************************************
Author:	Shay_gman

Parameters: [trigger <TRIGGER>,  waitTime<INTEGER>,insideZone <Boolean>,aircarft <boolean>]

Sets effects for a player enters/or leaving a resrict zone/fighting area

Example: [trigger,10,true,false] call PRA3_fnc_RestrictZoneEffect

************************************************************/
/*
{[[_x, [west,east],10,false,false, false], "MCC_fnc_createRestrictedZones", false, false] spawn BIS_fnc_MP;} foreach ["r1","r2","r3","r4"]
*/
#define var(x) private #x; x

var(_trigger)  = _this select 0;	//Trigger that call this fnc
var(_waitTime) = _this select 1;	//How long should we wait before we kill the player
var(_inside)   = _this select 2;	//Should the player be killed for being inside or outside the trigger
var(_aircarft) = _this select 3;	//Do we allow aircraft?

if (_aircarft && {vehicle player isKindOf "air"} && {getPosATL vehicle player select 2 > 20}) exitWith {}; // Break script if aircraft allowed and playe is inside an aircraft

if (!isNil "MCC_restZonePP") exitWith {};  //if the script allready runing it will prevent the trigger from starting the script all over agian.
MCC_restZonePP = ppEffectCreate ["RadialBlur", 100];

//Create effects
var(_ppColor) = ppEffectCreate  ["ColorCorrections", 1999];
_ppColor ppEffectAdjust [0.5, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0.0], [1, 1, 1, 1.0]];
_ppColor ppEffectCommit 0;
var(_ppgrain) = ppEffectCreate ["filmGrain", 2005];
_ppgrain ppEffectAdjust [0.02, 1, 1, 0, 1];
_ppgrain ppEffectCommit 0;

_ppColor ppEffectEnable true;
_ppgrain ppEffectEnable true;
MCC_restZonePP ppEffectEnable true;
player setFatigue 1;

var(_i)    = 0;
var(_exit) = false;

while {_i <= _waitTime && !_exit} do {
	if _inside then {
		//Check if the player should be inside or outside the zone
		if (vehicle player in (list _trigger)) then {_exit = true}; //Break loop if player got out of the zone
	} else {
		if !(vehicle player in (list _trigger)) then {_exit = true}; //Break loop if player got inside the zone
	};

	["MCC_restrictWarning"] call BIS_fnc_rscLayer cutText [format ["GET BACK TO THE FIGHT! %1s",_waitTime - _i], "PLAIN DOWN", 1];
	if (_i mod 5 == 0) then {((player getVariable ["CP_side", playerside]) call bis_fnc_moduleHQ) sideradio "SentGenLeavingAO"};
	_i = _i + 1;
	sleep 1;
};

["MCC_restrictWarning"] call BIS_fnc_rscLayer cutText ["", "PLAIN DOWN"];

//If we come this far lets check if the player was smart enought to get out the zone
 player setFatigue 0;
if !_exit then {player setdamage 1};

ppEffectDestroy _ppColor;
ppEffectDestroy _ppgrain;
ppEffectDestroy MCC_restZonePP;
MCC_restZonePP = nil;
