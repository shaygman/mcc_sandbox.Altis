//==================================================================MCC_fnc_addRating============================================================================================
// Adds rating to a specific player
// Example:[UID, rating ,messege] call MCC_fnc_addRating;
// UID	 	String,
// rating  	Integer
// messege	String
//===============================================================================================================================================================================
private ["_uid","_rating","_mesg","_string"];
_uid 		=_this select 0;
_rating 	=_this select 1;
_mesg 		=_this select 2;

if (isDedicated) exitWith {};
if (!isDedicated && !hasInterface) exitWith {};
if (_uid != getplayerUID player) exitWith {};

player addrating _rating;

if (_mesg != "") then {
	_string = format ["<t font='puristaMedium' size='0.5' color='#FFFFFF '>+%1 Exp %2</t>",_rating,_mesg];
	[_string,0,1,2,1,0,4] spawn BIS_fnc_dynamicText;
};
