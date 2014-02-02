#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007
#define MCCWEATHER 1008
#define MCCFOG 1009
#define TSMONTH 1010
#define TSDAY 1011
#define TSHOUR 1012
#define TSMINUTE 1013

private ["_weather","_type", "_grass","_fogLevel","_d","_nul"];
_type = _this select 0;

if (mcc_missionmaker == (name player)) then {
	if (_type==0) then	{
		_fogLevel = (MCC_fog_array select (lbCurSel MCCFOG)) select 1;		//Set fog
		MCC_fog_index=lbCurSel MCCFOG;
		_weather = (MCC_weather_array select (lbCurSel MCCWEATHER)) select 1;	//Set weather
		_weather set [5, _fogLevel];
		MCC_weather_index=lbCurSel MCCWEATHER;
		_nul=[_type, _weather] execVM MCC_path +"mcc\general_scripts\time.sqf";
	};

	if (_type==3) then	{
		month = (MCC_months_array select (lbCurSel TSMONTH)) select 1;			//Set time
		day = (MCC_days_array select (lbCurSel TSDAY));
		hour = (MCC_hours_array select (lbCurSel TSHOUR)) select 1;
		minute = (MCC_minutes_array select (lbCurSel TSMINUTE));
		MCC_months_index=lbCurSel TSMONTH;
		MCC_day_index=lbCurSel TSDAY;
		MCC_hours_index=lbCurSel TSHOUR;
		MCC_minutes_index=lbCurSel TSMINUTE;
		_nul=[_type] execVM MCC_path +"mcc\general_scripts\time.sqf";
	};
	
	if (_type==4) then	{													//Spectator script
		[player] execVM MCC_path + "spectator\specta.sqf";
	};
};
		
switch (_type) do
	{		
		case 1:	//Set grass (CS)
		{
			if (MCC_GUI1initDone) then
			{
				_grass = (MCC_grass_array select (lbCurSel MCCGRASSDENSITY)) select 1;
				setTerrainGrid _grass; 
				MCC_grass_index = (lbCurSel MCCGRASSDENSITY);
			}
		};
	
	    case 2:	//Set viewdistance (CS)
		{
		setViewDistance (MCC_view_array select (lbCurSel MCCVIEWDISTANCE));
		};
	 };
		