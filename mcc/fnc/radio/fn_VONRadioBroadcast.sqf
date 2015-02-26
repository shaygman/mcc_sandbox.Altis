//===============================================================MCC_fnc_VONRadioBroadcas========================================================================================
//==============================================================================================================================================================================
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

		//((1 -(_speaker distance player)/_radioRange) max 0)
		_staticChance =  if (_allowed && (_speaker distance player < _radioRange)) then {0} else {1};
		_helper = "logic" createVehiclelocal [0,0,0];
		_helper attachto [player,[0,0,0],"head"];

		_t = time + 10;
		while {(player getVariable ["MCC_radioIncommingBroadcast",true]) && time <_t} do
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
			sleep 0.1;
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