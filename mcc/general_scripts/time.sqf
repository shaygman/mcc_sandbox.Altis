private ["_weather","_type","_month","_day","_year","_hour","_minute"];
_type 		= _this select 0;

switch (_type) do
{
	case 0:	//Set weather
	{
		_weather 	= if ((count _this) == 2) then {_this select 1};
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
		_month = _this select 1;
		_day = _this select 2;
		_year = _this select 3;
		_hour = _this select 4;
		_minute = _this select 5;

		MCC_date=[_year, _month, _day, _hour, _minute];
		publicVariable "MCC_date";
		[[MCC_date],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
	};
};



