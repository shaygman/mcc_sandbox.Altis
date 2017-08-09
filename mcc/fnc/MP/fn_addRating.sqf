//==================================================================MCC_fnc_addRating============================================================================================
// Adds rating to a specific player
// Example:[UID, rating ,messege] call MCC_fnc_addRating;
// UID	 	String,
// rating  	Integer
// messege	String
//===============================================================================================================================================================================
private ["_uid","_rating","_mesg","_string","_ctrlGroup","_ctrl","_ratingPrev"];
_uid 		=_this select 0;
_rating 	=_this select 1;
_mesg 		=_this select 2;

if (isDedicated) exitWith {};
if (!isDedicated && !hasInterface) exitWith {};
if (_uid != getplayerUID player) exitWith {};

//If we manually added rating we want to disable the automatic rating
_ratingPrev = ((rating player)-(player getVariable ["MCC_playerRating",0])) max 0;
player addrating (_ratingPrev * -1);


player addrating _rating;

if (_mesg != "") then {
	disableSerialization;

	_string = format ["<t font='TahomaB' size='0.8' color='#FFFFFF' align ='center' >+%1 Exp %2</t>",_rating,_mesg];

	waitUntil {isnull ((findDisplay 46) displayCtrl 854579)};
	_ctrlGroup = (findDisplay 46) ctrlCreate ["RscControlsGroupNoScrollbars", 854579];
	_ctrlGroup ctrlSetPosition [0.02 * safezoneW + safezoneX, 0.7 * safezoneH + safezoneY,0,0.06 * safezoneH];
	_ctrlGroup ctrlCommit 0;

	_ctrl = (findDisplay 46) ctrlCreate ["RscText", -1,_ctrlGroup];
	_ctrl ctrlSetBackgroundColor [0.1,0.1,0.1,0.8];
	_ctrl ctrlSetPosition [0 * safezoneW, 0 * safezoneH,0.4 * safezoneW,0.06 * safezoneH];
	_ctrl ctrlCommit 0;

	_ctrl = (findDisplay 46) ctrlCreate ["RscStructuredText", -1,_ctrlGroup];
	_ctrl ctrlSetStructuredText (parseText _string);
	_ctrl ctrlSetPosition [0 * safezoneW, 0.02 * safezoneH,0.4 * safezoneW,0.08 * safezoneH];
	_ctrl ctrlCommit 0;


	_ctrlGroup ctrlSetPosition [0.02 * safezoneW + safezoneX, 0.7 * safezoneH + safezoneY,0.4 * safezoneW,0.06 * safezoneH];
	_ctrlGroup ctrlCommit 0.4;
	playSound "MCC_pop";
	sleep 4;
	_ctrlGroup ctrlSetPosition [0.02 * safezoneW + safezoneX, 0.7 * safezoneH + safezoneY,0,0.06 * safezoneH];
	_ctrlGroup ctrlCommit 0.4;
	sleep 0.4;
	ctrlDelete _ctrlGroup;
	//[_string,0,1,2,1,0,4] spawn BIS_fnc_dynamicText;
};
