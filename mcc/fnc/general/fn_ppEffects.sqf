//==================================================================MCC_fnc_ppEffects===============================================================================================
// Create effects to all players
//Example:[[_effect, _jip],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
//	<IN>
// 		_effect =  effectType, String: "sandstorm", "bf"
// 		_jip=	Boolean, is it a JIP player or not (JIP player will not change weather as sync function already does that)
//==================================================================================================================================================================================
private ["_effect","_effects","_handle","_colorParams","_grainParams","_parray","_jip","_dust","_ash","_news"];
_effect = _this select 0;
_jip	= _this select 1;

if (isServer) then
{
	missionNameSpace setVariable ["MCC_ppEffect",_effect];
	publicVariable "MCC_ppEffect";
};

switch (tolower _effect) do
{
	case "sandstorm":
	{
		_dust	= true;
		_ash	= true;
		_news	= true;
		_colorParams 	=  [[1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]]];
		_grainParams 	=  [[.8, 15, 6, 0.5, 0.5,true]];
		_parray = [
					["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
					"",
					"Billboard",
					1,
					4,
					[0,0,0],
					[0,0,0],
					1,
					0.000001,
					0,
					1.4,
					[0.05,0.05],
					[[0.255,0.255,0,1]],
					[0,1],
					0.2,
					1.2,
					"",
					"",
					vehicle player
				];

		//extra
		player setVariable ["MCC_ppEffectRuning",_effect];

		if !(_jip) then
		{
			setWind [10, 10, true];
			0 setWindStr 1;
			[[ 0.5, 1, 1, 0, 1,0.7]]  call MCC_fnc_setWeather;
		};
	};

	case "storm":
	{
		_dust	= true;
		_ash	= true;
		_news	= false;
		_colorParams 	=  [];
		_grainParams 	=  [];
		_parray = [
					["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
					"",
					"Billboard",
					0.1,
					4,
					[0,0,0],
					[0,0,0],
					1,
					0.00002,
					0,
					0.08,
					[0.1,0.1],
					[[1,1,1,1]],
					[0,1],
					0.2,
					1.2,
					"",
					"",
					vehicle player,
					0,
					true,
					0.2
				];

		//extra
		if !(_jip) then
		{
			setWind [10, 10, true];
			0 setWindStr 1;
			[[ 1, 1, 1, 0.4, 1,0.7]]  call MCC_fnc_setWeather;
		};
		player setVariable ["MCC_ppEffectRuning",_effect];
	};

	case "heatwave":
	{
		_dust	= true;
		_ash	= false;
		_news	= false;
		_colorParams 	=  [[1, 0.5, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]],[1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]]];
		_grainParams 	=  [];

		_parray = [
					["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
					"",
					"Billboard",
					1,
					4,
					[0,0,0],
					[0,0,0],
					1,
					0.000001,
					0,
					1.4,
					[0.05,0.05],
					[[0.255,0.255,0,1]],
					[0,1],
					0.2,
					1.2,
					"",
					"",
					vehicle player
				];

		if !(_jip) then
		{
			setWind [10, 10, true];
			0 setWindStr 0;
			[[ 0, 0, 0, 0, 0,0]]  call MCC_fnc_setWeather;
		};

		player setVariable ["MCC_ppEffectRuning",_effect];
	};

	case "bf":
	{
		_dust	= true;
		_ash	= false;
		_news	= true;
		_colorParams 	=  [];
		_grainParams 	=  [];
		player setVariable ["MCC_ppEffectRuning",_effect];

		_parray = [
					["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
					"",
					"Billboard",
					1,
					4,
					[0,0,0],
					[0,0,0],
					1,
					0.000001,
					0,
					1.4,
					[0.05,0.05],
					[[0.1,0.1,0.1,1]],
					[0,1],
					0.2,
					1.2,
					"",
					"",
					vehicle player
				];
	};

	case "clear":
	{
		_colorParams 	=  [];
		_grainParams 	=  [];
		player setVariable ["MCC_ppEffectRuning",_effect];
	};
};

_effects = player getVariable ["MCC_ppEffect",[]];
ppEffectDestroy _effects;

if (_effect in ["clear"]) exitWith {};
_effects = [];
{
	_handle = ppEffectCreate ["colorCorrections", 1500 + _foreachIndex];
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _x;
	_handle ppEffectCommit 0;
	_effects set [count _effects, _handle];
} foreach _colorParams;


{
	_handle = ppEffectCreate ["FilmGrain", 1510 + _foreachIndex];
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _x;
	_handle ppEffectCommit 0;
	_effects set [count _effects, _handle];
} foreach _grainParams;

player setVariable ["MCC_ppEffect",_effects];

//Dust
if (_dust) then
{
	[_effect] spawn
	{
		waituntil {isplayer player};
		while {(player getVariable ["MCC_ppEffectRuning",""]) == (_this select 0)} do
		{
			_obj = vehicle player;
			_pos = position _obj;

			if ((_this select 0) in ["storm", "sandstorm"]) then {playsound format ["MCC_wind%1",floor random 4]} else {playsound format ["wind%1",ceil random 5]};

			//--- Dust
			_duration = 2;
			_velocity = [0,7,0];
			_relPos = [-((_velocity select 1) * (_duration / 2)), 0, -6];
			_color = [1.0, 0.9, 0.8];
			_alpha = 0.02;
			_ps = "#particlesource" createVehicleLocal _pos;
			_ps setParticleParams [["A3\data_f\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, _duration, _relPos, _velocity, 1, 1.275, 1, 0, [5], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
			//_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
			_ps setParticleRandom [3, [10, 10, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.05], 0, 0];
			_ps setParticleCircle [0.1, [0, 0, 0]];
			_ps setDropInterval 0.02;

			_delay = 10 + random 20;
			sleep _delay;

			deletevehicle _ps;
		};
	};
};

if (_ash) then
{
	//--- Ash
	[_effect,_parray] spawn
	{
		_effect = _this select 0;
		_parray = _this select 1;

		waituntil {isplayer player};
		_pos = position player;

		_snow = "#particlesource" createVehicleLocal _pos;
		_snow setParticleParams _parray;
		_snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
		_snow setParticleCircle [0.0, [0, 0, 0]];
		if (_effect == "storm") then {_snow setDropInterval 0.001} else {_snow setDropInterval 0.01};


		_oldPlayer = vehicle player;
		while {(player getVariable ["MCC_ppEffectRuning","sandstorm"]) == _effect} do
		{
			waituntil {vehicle player != _oldPlayer || ((player getVariable ["MCC_ppEffectRuning","sandstorm"]) != _effect)};
			_parray set [18,vehicle player];
			_snow setParticleParams _parray;
			_oldPlayer = vehicle player;
		};
		deleteVehicle _snow;
	};
};

if (_news) then
{
	//--- Newspapers
	[_effect] spawn
	{
		_effect = _this select 0;
		_duration = 2;
		_velocity = [0,7,0];
		_relPos = [-((_velocity select 1) * (_duration / 2)), 0, -6];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02;
		_pos = getpos player;
		_newsParams = [["A3\Structures_F_EPB\Items\Documents\Leaflet_01_F.p3d", 1, 0, 1], "", "SpaceObject", 1, 5, [0, 0, 1], _velocity, 1, 1.25, 1, 0.2, [0,1,1,1,0], [[1,1,1,1]], [0.7], 1, 0, "", "", player];
		_newsRandom = [0, [30, 30, 0], [5, 5, 0], 2, 0.3, [0, 0, 0, 0], 10, 0];
		_newsCircle = [0.1, [1, 1, 0]];
		_newsInterval = 1;

		_times = "#particlesource" createVehicleLocal _pos;
		_times setParticleParams _newsParams;
		_times setParticleRandom _newsRandom;
		_times setParticleCircle _newsCircle;
		_times setDropInterval _newsInterval;

		_newsParams set [0,["A3\Structures_F_EPB\Items\Documents\Leaflet_02_F.p3d", 1, 0, 1]];
		_herald = "#particlesource" createVehicleLocal _pos;
		_herald setParticleParams _newsParams;
		_herald setParticleRandom _newsRandom;
		_herald setParticleCircle _newsCircle;
		_herald setDropInterval _newsInterval;

		_newsParams set [0,["A3\Structures_F_EPB\Items\Documents\Leaflet_03_F.p3d", 1, 0, 1]];
		_tribune = "#particlesource" createVehicleLocal _pos;
		_tribune setParticleParams _newsParams;
		_tribune setParticleRandom _newsRandom;
		_tribune setParticleCircle _newsCircle;
		_tribune setDropInterval _newsInterval;

		while {(player getVariable ["MCC_ppEffectRuning","clear"]) == _effect} do {sleep 1};
		deleteVehicle _times;
		deleteVehicle _herald;
		deleteVehicle _tribune;
	};
};
