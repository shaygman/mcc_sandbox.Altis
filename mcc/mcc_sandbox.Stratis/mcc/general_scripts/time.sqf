private ["_weather","_d","_type"];
_type 		= _this select 0;	
_weather 	= if ((count _this) == 2) then {_this select 1};					

switch (_type) do
	{		
		case 0:	//Set weather
		{
			mcc_safe=mcc_safe + FORMAT ["													
			  script_handler = [%1, %2] execVM '%3mcc\general_scripts\time.sqf';
		      waitUntil {scriptDone script_handler};
			  "								 
			  , _type
			  , _weather
			  , MCC_path
			  ];
			  
			[[_weather],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;
		};
	
	    case 3:	//Set time
		{
			mcc_safe=mcc_safe + FORMAT ["													
				  month=%1;
				  day=%2;
				  hour=%3;
				  minute=%4;
				  script_handler = [%5] execVM '%6mcc\general_scripts\time.sqf';
				  waitUntil {scriptDone script_handler};
				  "	
				  , month
				  , day
				  , hour
				  , minute
				  , _type
				  , MCC_path
				  ];
			_d=date;
			_d=[_d select 0, month, day, hour, minute];

			[[_d],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
		};
	};



