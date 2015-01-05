//===============================================================MCC_fnc_VONRadioPressed=====================================================================================
//==============================================================================================================================================================================
private ["_channelID","_allowed"];
missionNameSpace setVariable ["MCC_radioBroadcastingChannel",_this];
_channelID = (missionNameSpace getVariable ["MCC_radioBroadcastingChannel",""]) call MCC_fnc_VONRadiofindChannel;
[([netId player] + _channelID), "MCC_fnc_VONRadioBroadcast", side player, false] spawn BIS_fnc_MP;

switch (_channelID select 1) do
{
	case 0 : //Global
	{
		_allowed	= if (serverCommandAvailable "#logout" || isServer) then {true} else {false};
	};
	case 1 : //Side
	{
		_allowed	= if (player == leader player && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
	};
	case 2 : //Commander
	{
		_allowed	= if (getPlayerUID  player == (MCC_server getVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],""]) && !(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
	};
	case 3 : //Group
	{
		_allowed	= if (!(player getVariable ["MCC_medicUnconscious",false])) then {true} else {false};
	};
	default
	{
		_allowed = true;
	};
};

_allowed spawn
{
	private ["_allowed","_c"];
	_allowed = _this;
	_c = 0;

	while {player getVariable ["MCC_radioBroadcasting",true] && alive player} do
	{
		sleep 0.1;
		if (missionNameSpace getVariable ["MCC_vonRadioKickIdle",true]) then
		{
			if (!_allowed) then
				{
					["<t font='puristaMedium' size='1' align='center'>You are not allowed to use this channel</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
					_c = _c +0.5;
				};
			if (_c > ((missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",10])/2)) then
			{
				if (_allowed) then
				{
					["<t font='puristaMedium' size='1' align='center'>Hot Mic !!!</t>",0,0.5,0.5,0,0,4] spawn BIS_fnc_dynamicText;
				};
				if (_c > (missionNameSpace getVariable ["MCC_vonRadioKickIdleTime",10])) exitWith
				{
					systemchat "You have been killed for abusing the radio";
					sleep 2;
					player setDamage 1;
					///[[[name player],{serverCommand format["#kick %1",_this select 0]}], "BIS_fnc_spawn", false, false] spawn BIS_fnc_MP;
				};
			};

			_c = _c + 0.1;
		};
	};

	//cleanup
	[[netId player,"",-1], "MCC_fnc_VONRadioBroadcast", side player, false] spawn BIS_fnc_MP;
	player setVariable ["MCC_radioBroadcasting",false];
};