//==================================================================MCC_fnc_vonRadio=============================================================================================
// Example:[]  spawn  MCC_fnc_vonRadio;
//===============================================================================================================================================================================
private ["_text","_channelID","_fncKeyDown","_fncKeyUp","_ctrlText"];

if (isDedicated) exitWith {};
if !(missionNameSpace getVariable ["MCC_VonRadio",false]) exitWith {};
_text = "";
_channelID = -1;

_fncKeyDown =
{
	if (!(player getVariable ["MCC_radioBroadcasting",false])) then	{
		if (!isNull findDisplay 55 && !isNull findDisplay 63) then {
			player setVariable ["MCC_radioBroadcasting",true];
			(ctrlText (findDisplay 63 displayCtrl 101)) call MCC_fnc_VONRadioPressed;

			findDisplay 55 displayAddEventHandler ["Unload", {player setVariable ["MCC_radioBroadcasting",false];"" call MCC_fnc_VONRadioPressed;}];
		};
	};
	false
};

_fncKeyUp =
{
	if (player getVariable ["MCC_radioBroadcasting",false]) then {
		_ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
		if ((missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) != _ctrlText) then {
			_ctrlText call MCC_fnc_VONRadioPressed;
		};
	};
	false
};

waitUntil {!isNull findDisplay 46};
findDisplay 46 displayAddEventHandler ["KeyDown", _fncKeyDown];
findDisplay 46 displayAddEventHandler ["KeyUp", _fncKeyUp];
findDisplay 46 displayAddEventHandler ["MouseButtonDown", _fncKeyDown];
findDisplay 46 displayAddEventHandler ["MouseButtonUp", _fncKeyUp];
findDisplay 46 displayAddEventHandler ["JoystickButton", _fncKeyDown];

