private ["_weather","_d"];
_weather = _this select 0;					
													//Set time
mcc_safe=mcc_safe + FORMAT ["													
			  month=%1;
			  day=%2;
			  hour=%3;
			  minute=%4;
			  script_handler = [%6] execVM '%5mcc\general_scripts\time.sqf';
		      waitUntil {scriptDone script_handler};
			  "								 
			  , month
			  , day
			  , hour
			  , minute
			  , MCC_path
			  , _weather
			  ];
_d=date;
_d=[_d select 0, month, day, hour, minute];

[[_d],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
[[_weather],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;