//==================================================================MCC_fnc_vonRadio===============================================================================================
// Example:[]  spawn  MCC_fnc_vonRadio;
//==================================================================================================================================================================================
if (isDedicated) exitWith {};
if !(missionNameSpace getVariable ["MCC_VonRadio",true]) exitWith {};

MCC_fnc_VONRadioBroadcast =
{
	private ["_speaker","_channel","_channelIndex","_radioRange","_staticChance","_beep","_allowed"];

	_speaker 		= objectFromNetID (_this select 0);
	_channelName 	= _this select 1;
	_channelIndex 	= _this select 2;
	_allowed		= true;
	_beep 			= "beep";

	switch _channelIndex do
	{
		case 0 : //Global
		{
			_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceGlobal",60000];
			_allowed	= if (serverCommandAvailable "#logout" || isServer) then {true} else {false};
		};
		case 1 : //Side
		{
			_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceSide",10000];
			_allowed	= if (player == leader player && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};

		};
		case 2 : //Commander
		{
			_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceCommander",30000];
			_allowed	= if (getPlayerUID  player == (MCC_server getVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],""]) && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
		};
		case 3 : //Group
		{
			_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceGroup",500];
			_allowed	= if (!(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
			_beep = "radioStaticBreak_0";
		};
		default
		{
			_radioRange = 2000;
			_beep = "radioStaticBreak_0";
		};
	};

	//Direct
	if (_channelIndex == 5) exitWith {};

	if (_channelIndex >= 0) then
	{
		player setVariable ["MCC_radioIncommingBroadcast",true];
		playSound [_beep,true];
		sleep 0.2;

		[_speaker,_radioRange,_allowed] spawn
		{
			private ["_speaker","_radioRange","_helper","_t","_c","_allowed"];
			_speaker 	= _this select 0;
			_radioRange = _this select 1;
			_allowed	= _this select 2;

			_staticChance =  if (_allowed) then {((1 -(_speaker distance player)/_radioRange) max 0)} else {1};
			_helper = "logic" createVehiclelocal [0,0,0];
			_helper attachto [player,[0,0,0],"head"];
			_c = 0;

			while {player getVariable ["MCC_radioIncommingBroadcast",true]} do
			{
				if (_speaker != player) then
				{
					if (random 1 > _staticChance) then
					{
						_helper say [format ["radioHardStatic_%1",floor random 3],10];
					}
					else
					{
						_helper say [format ["radioNormalStatic_%1",floor random 3],5];
					};
				};

				_t = time +5;
				while {player getVariable ["MCC_radioIncommingBroadcast",true] && time < _t} do
				{
					sleep 0.1;
					if (missionNameSpace getVariable ["MCC_vonRadioKickIdle",true]) then
					{
						if (!_allowed) then
							{
								["<t font='puristaMedium' size='1' align='center'>You are not allowed to use this channel</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
								_c = _c +1;
							};
						if (_c > ((missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",4])/2)) then
						{
							if (_allowed) then
							{
								["<t font='puristaMedium' size='1' align='center'>Hot Mic !!!</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
							};
							if (_c > (missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",10])) exitWith
							{
								systemchat "You have been kicked for abusing the radio";
								sleep 2;
								[[[getPlayerUID player],{serverCommand format["#kick %1",_this select 0]}], "BIS_fnc_spawn", false, false] spawn BIS_fnc_MP;
							};
						};

						_c = _c + 0.1;
					};
				};
			};

			deleteVehicle _helper;
			playSound ["radioStaticBreak_1",true];
		};
		//0 fadeRadio ((1 -(_speaker distance player)/_radioRange) max 0);
	}
	else
	{
		//0 fadeRadio 1;
		player setVariable ["MCC_radioIncommingBroadcast",false];
	};
};

MCC_fnc_VONRadiofindChannel =
{
	switch _this do
	{
		case localize "str_channel_global" : {["str_channel_global",0]};
		case localize "str_channel_side" : {["str_channel_side",1]};
		case localize "str_channel_command" : {["str_channel_command",2]};
		case localize "str_channel_group" : {["str_channel_group",3]};
		case localize "str_channel_vehicle" : {["str_channel_vehicle",4]};
		case localize "str_channel_direct" : {["str_channel_direct",5]};
		default {["",-1]};
	}
};

MCC_fnc_VONRadioPressed =
{
	missionNameSpace setVariable ["MCC_radioBroadcastingChannel",_this];
	_channelID = (missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) call MCC_fnc_VONRadiofindChannel;
	[([netId player] + _channelID), "MCC_fnc_VONRadioBroadcast", side player, false] spawn BIS_fnc_MP;
};

private ["_text","_channelID","_fncKeyDown","_fncKeyUp","_ctrlText"];
_text = "";
_channelID = -1;

//Remove channels
/*
{
	_x radioChannelRemove [player];
} foreach [0,1,2];
*/
_fncKeyDown =
{
	if (!(player getVariable ["MCC_radioBroadcasting",false])) then
	{
		if (!isNull findDisplay 55 && !isNull findDisplay 63) then
		{
			//VoN_isOn = true;
			player setVariable ["MCC_radioBroadcasting",true];
			(ctrlText (findDisplay 63 displayCtrl 101)) call MCC_fnc_VONRadioPressed;

			findDisplay 55 displayAddEventHandler ["Unload", {player setVariable ["MCC_radioBroadcasting",false];"" call MCC_fnc_VONRadioPressed;}];
		};
	};
	false
};

_fncKeyUp =
{
	if (player getVariable ["MCC_radioBroadcasting",false]) then
	{
		_ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
		if ((missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) != _ctrlText) then
		{
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

