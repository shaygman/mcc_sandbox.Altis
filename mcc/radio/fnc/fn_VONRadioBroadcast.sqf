//===============================================================MCC_fnc_VONRadioBroadcas========================================================================================
//==============================================================================================================================================================================
private ["_speaker","_channel","_channelIndex","_radioRange","_beep"];

_speaker 		= objectFromNetID (_this select 0);
_channelName 	= _this select 1;
_channelIndex 	= _this select 2;
_beep 			= "beep";

switch _channelIndex do {
	//Global
	case 0 : {
		_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceGlobal",60000];
	};

	//Side
	case 1 : {
		_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceSide",10000];
	};

	//Commander
	case 2 : {
		_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceCommander",30000];
	};

	//Group
	case 3 : {
		_radioRange = missionNameSpace getVariable ["MCC_vonRadioDistanceGroup",500];
		_beep = "radioStaticBreak_0";
	};

	default {
		_radioRange = 2000;
		_beep = "radioStaticBreak_0";
	};
};

//Direct
if (_channelIndex > 3) exitWith {};

if (_channelIndex >= 0) then {
	player setVariable ["MCC_radioIncommingBroadcast",true];
	playSound [_beep,true];
	sleep 0.2;

	[_speaker,_radioRange] spawn {
		private ["_speaker","_radioRange","_helper","_t","_c","_static"];
		_speaker 	= _this select 0;
		_radioRange = _this select 1;

		_static =  (_speaker distance player > _radioRange);
		_helper = "logic" createVehiclelocal [0,0,0];
		_helper attachto [player,[0,0,0],"head"];

		_t = time + 10;
		while {(player getVariable ["MCC_radioIncommingBroadcast",true]) && time <_t} do {
			if (_speaker != player) then {
				if (_static) then {
					_helper say [format ["radioHardStatic_%1",floor random 3],10];
				} else {
					_helper say [format ["radioNormalStatic_%1",floor random 3],5];
				};
			};
			sleep 0.1;
		};

		deleteVehicle _helper;
		playSound ["radioStaticBreak_1",true];
	};
} else {
	player setVariable ["MCC_radioIncommingBroadcast",false];
};