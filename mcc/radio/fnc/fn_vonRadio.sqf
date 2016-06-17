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
	//Unconscious
	if (player getVariable ["MCC_medicUnconscious",false]) then {
			{_x enableChannel false} forEach [0,1,2,3,4,5];
	} else {
		//enable chat on group/vehicle/direct
		{_x enableChannel true} forEach [3,4,5];

		//enable Global
		if (serverCommandAvailable "#logout" || isServer) then {
			0 enableChannel true;
		} else {
			if (currentChannel ==0) then {setCurrentChannel 5};
			0 enableChannel false;
		};

		//enable Side
		if (getPlayerUID  player == (MCC_server getVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],""])) then {
			1 enableChannel true;
		} else {
			if (currentChannel ==1 || currentChannel == 6) then {setCurrentChannel 5};
			1 enableChannel false;
		};

		//enable Commander
		if (player == leader player) then {
			2 enableChannel true;
		} else {
			if (currentChannel ==2) then {setCurrentChannel 5};
			2 enableChannel false;
		};
	};

	if (player getVariable ["MCC_radioBroadcasting",false]) then {
		_ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
		if ((missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) != _ctrlText) then {
			_ctrlText call MCC_fnc_VONRadioPressed;
		};
	};
};

waitUntil {!isNull findDisplay 46};
findDisplay 46 displayAddEventHandler ["KeyDown", _fncKeyDown];
findDisplay 46 displayAddEventHandler ["KeyUp", _fncKeyUp];
findDisplay 46 displayAddEventHandler ["MouseButtonDown", _fncKeyDown];
findDisplay 46 displayAddEventHandler ["MouseButtonUp", _fncKeyUp];
findDisplay 46 displayAddEventHandler ["JoystickButton", _fncKeyDown];

