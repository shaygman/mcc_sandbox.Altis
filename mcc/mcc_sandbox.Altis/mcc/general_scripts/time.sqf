private ["_weather","_type"];
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
			  
			MCC_Overcast	= (_weather select 0);
			MCC_WindForce 	= (_weather select 1);
			MCC_Waves 		= (_weather select 2);
			MCC_Rain 		= (_weather select 3);
			MCC_Lightnings	= (_weather select 4);
			publicVariable "MCC_Overcast";
			publicVariable "MCC_WindForce";
			publicVariable "MCC_Waves";
			publicVariable "MCC_Rain";
			publicVariable "MCC_Lightnings";
			
			if ((count _weather) > 5) then {MCC_Fog =(_weather select 5);publicVariable "MCC_Fog"};
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
			MCC_date=date;
			MCC_date=[MCC_date select 0, month, day, hour, minute];
			publicVariable "MCC_date";
			[[MCC_date],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
		};
	};



