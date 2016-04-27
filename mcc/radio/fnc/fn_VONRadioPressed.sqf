//===============================================================MCC_fnc_VONRadioPressed===============================================================================
//========================================================================================================================================================================
private ["_channelID","_allowed","_spectrum"];
missionNameSpace setVariable ["MCC_radioBroadcastingChannel",_this];
_channelID = (missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) call MCC_fnc_VONRadiofindChannel;

//[([netId player] + _channelID), "MCC_fnc_VONRadioBroadcast", side player, false] spawn BIS_fnc_MP;

switch (_channelID select 1) do {
	//Global
	case 0 :{
		_allowed	= if (serverCommandAvailable "#logout" || isServer) then {true} else {false};
		_spectrum = 0;
	};

	//Side
	case 1 : {
		_allowed	= if (getPlayerUID  player == (MCC_server getVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],""]) && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
		_spectrum = side player;
	};

	//Commander
	case 2 : {
		_allowed	= if (player == leader player && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
		_spectrum = side player;
	};

	//Group
	case 3 : {
		_allowed	= if (!(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
		_spectrum = group player;
	};

	default	{
		_allowed = true;
		_spectrum = side player;
	};
};

([netId player] + _channelID) remoteExec ["MCC_fnc_VONRadioBroadcast", _spectrum, false];

[_allowed,(_channelID select 1),_spectrum] spawn {
	private ["_allowed","_c","_channelID","_spectrum"];
	_allowed = param [0,false,[false]];
	_channelID =  param [1,0,[0]];
	_spectrum = _this select 2;

	_c = 0;

	while {player getVariable ["MCC_radioBroadcasting",true] && alive player} do {
		sleep 0.1;
		if (missionNameSpace getVariable ["MCC_vonRadioKickIdle",true]) then {
			if (_allowed) then {
				_c = _c + 0.1;
			} else {
				["<t font='puristaMedium' size='1' align='center'>You are not allowed to use this channel</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
				_c = _c + 0.5;
			};

			if (_c > ((missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",10])/2)) then {
				if (_allowed) then {
					["<t font='puristaMedium' size='1' align='center'>Hot Mic !!!</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
				};

				if (_c > (missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",10])) exitWith {
					["KickRadio", false, 0, false, true ] spawn BIS_fnc_endMission;
				};
			};
		};
	};

	//cleanup
	[netId player,"",-1] remoteExec ["MCC_fnc_VONRadioBroadcast", _spectrum, false];
	//[netId player,"",-1], "MCC_fnc_VONRadioBroadcast", side player, false] spawn BIS_fnc_MP;
	player setVariable ["MCC_radioBroadcasting",false];
};