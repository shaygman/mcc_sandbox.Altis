//==================================================================MCC_fnc_setWeather======================================================================================
// Sets weather  on all clients  - skip time by one hour to make the weather change
// Example: [[[ Overcast, WindForce, Waves, Rain, Lightnings,fog]],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;
// Params:
//	Overcast: number, 0-1
//	WindForce: number, 0-1
//	Waves: number, 0-1
//	Rain: number, 0-1
//	Lightnings: number, 0-1
//	Fog: array, [fogValue, fogDecay, fogBase]
//	Time: integer, how long till effect
//==============================================================================================================================================================================
private ["_weather","_time"];

_weather = _this select 0;
_time = [_weather, 6, 0, [0]] call BIS_fnc_param;

/*
skipTime -24;
86400 setOvercast (_weather select 0);
skipTime 24;
*/
if (MCC_isACE) then {
	(_weather select 0) call bis_fnc_setovercast
} else {
	_time setOvercast (_weather select 0);
};

sleep 2;
if ((count _weather) > 1) then {
	setWind [(_weather select 1)*20, (_weather select 1)*20, true];
	_time setWindStr (_weather select 1);
	_time setGusts (_weather select 1);
};
if ((count _weather) > 2) then {_time setWaves (_weather select 2)};
if ((count _weather) > 3) then {_time setRain (_weather select 3)};
if ((count _weather) > 4) then {_time setLightnings	(_weather select 4)};
if ((count _weather) > 5) then {_time setfog [(_weather select 5), 0.03,5]};

forceweatherchange;

0 = [] spawn
{
	sleep 0.1;
	simulWeatherSync;
};
