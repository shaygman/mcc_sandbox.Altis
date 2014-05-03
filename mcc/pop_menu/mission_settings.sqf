#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

private ["_weather","_type", "_grass","_fogLevel","_d","_nul","_rain","_overcast","_month","_day","_year","_hour","_minute","_wind","_Waves"];
_type = _this select 0;


if (_type==0) exitWith	
{
	diag_log format ["MCC - weather change"];
	
	_weather = (MCC_weather_array select (lbCurSel 10)) select 1;	//Set weather
	MCC_weather_index=lbCurSel 10;

	MCC_fog_index=lbCurSel 11;
	if !(MCC_fog_index == 0 ) then 
	{
		_fogLevel = (MCC_fog_array select (lbCurSel 11)) select 1;		//Set fog		
		_mccFog = [];
		_mccFog = [_fogLevel select 0, _fogLevel select 1, _fogLevel select 2];
		_weather set [5, _mccFog];
	};
	
	MCC_wind_index = lbCurSel 12;		//Set wind
	if !( MCC_wind_index == 0 ) then
	{
		_mccWind = (MCC_wind_array select (lbCurSel 12)) select 1;
		_weather set [1, _mccWind];
	};
	
	MCC_waves_index=lbCurSel 13;	//Set waves
	if !( MCC_waves_index == 0 ) then
	{
		_mccWaves = (MCC_waves_array select (lbCurSel 13)) select 1;
		_weather set [2, _mccWaves];
	};
	
	_weatherChangeTime = (MCC_ChangeWeather_array select (lbCurSel 14)) select 1;		//Set time delay for weatherchange
	MCC_ChangeWeather_index=lbCurSel 14;
	_weather set [6, _weatherChangeTime];
	
	_nul=[_type, _weather] execVM MCC_path +"mcc\general_scripts\time.sqf";
	
	if ( _weatherChangeTime == 0 ) then 
	{
		//disable button for 5 seconds to wait for instant weather change sync
		ctrlEnable [8,false];
		sleep 5;
		ctrlEnable [8,true];			
	};
};

if (_type==3) exitWith	
{
	_month 	= (MCC_months_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 15))) select 1;			//Set time
	_day 	= (MCC_days_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 16)));
	_year	= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 17)) + 1990;
	_hour 	= MCC_hours_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 18));
	_minute = (MCC_minutes_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 19)));

	_nul=[_type,_month,_day,_year,_hour,_minute] execVM MCC_path +"mcc\general_scripts\time.sqf";
};

if (_type==4) exitWith	
{													//Spectator script
	while {dialog} do {closeDialog 0; sleep 0.2};
	[] execVM MCC_path + "spectator\specta.sqf";
};

if (MCC_GUI1initDone) then
{
	switch (_type) do
	{		
		case 1:	//Set grass (CS)
		{
			if (MCC_GUI1initDone) exitWith
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
}; 		