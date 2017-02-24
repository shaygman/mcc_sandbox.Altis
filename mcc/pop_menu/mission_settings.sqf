#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

private ["_weather","_type", "_grass","_fogLevel","_d","_nul","_rain","_overcast","_month","_day","_year","_hour","_minute","_wind","_Waves","_time","_initDone","_html"];
_type = param [0,-1,[0]];
_initDone = missionNamespace getVariable ["MCC_GUI1initDone",false];

switch (_type) do
{
	//Weather
	case 0:
	{
		_fogLevel 	= sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10);		//Set fog
		_overcast 	=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12);	//Set overcast
		_rain 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11);	//Set rain
		_wind 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 14);	//Set wind
		_Waves 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 13);	//Set wind
		_time		= (sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11225))*600;	//Set over time

		_weather	= [_overcast, _wind, _Waves, _rain, _overcast, _fogLevel,_time];
		_nul=[_type, _weather] execVM MCC_path +"mcc\general_scripts\time.sqf";
	};

	//Set grass (CS)
	case 1:
	{
		if ( _initDone) then {
			_grass = (MCC_grass_array select (lbCurSel MCCGRASSDENSITY)) select 1;
			setTerrainGrid _grass;
			MCC_terrainPref set [0,(lbCurSel MCCGRASSDENSITY)];
			profileNamespace setVariable ["MCC_terrainPref", MCC_terrainPref];
		}
	};

	//Set viewdistance (CS)
	case 2:
	{
		if ( _initDone) then {
			setViewDistance (MCC_view_array select (lbCurSel MCCVIEWDISTANCE));
			MCC_terrainPref set [1,(lbCurSel MCCVIEWDISTANCE)];
		};
	};

	//Set time
	case 3:
	{
		_month 	= (MCC_months_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 15))) select 1;
		_day 	= (MCC_days_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 16)));
		_year	= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 17)) + 1990;
		_hour 	= MCC_hours_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 18));
		_minute = (MCC_minutes_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 19)));

		_nul=[_type,_month,_day,_year,_hour,_minute] execVM MCC_path +"mcc\general_scripts\time.sqf";
	};

	//Spectator script
	case 4:
	{
		//[] call BIS_fnc_camera;
		while {dialog} do {closeDialog 0; sleep 0.2};
		[] execVM MCC_path + "spectator\specta.sqf";
	};

	//Sunset Sunrise times
	case 5:
	{
		private ["_suriseTime","_sunsetTime","_date"];
		_month 	= (MCC_months_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 15))) select 1;
		_day 	= (MCC_days_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 16)));
		_year	= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 17)) + 1990;
		_hour 	= MCC_hours_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 18));
		_minute = (MCC_minutes_array select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 19)));

		_date = [_year,_month,_day,_hour,_minute];

		_suriseTime = (_date call BIS_fnc_sunriseSunsetTime) select 0;
		_sunsetTime = (_date call BIS_fnc_sunriseSunsetTime) select 1;

		_html = "<t color='#b0e0e6' size='1' shadow='1' align='left' underline='true'> Sunrise: </t>" +
				"<t color='#ffffff' size='0.9' shadow='1' align='left' underline='false'> " +
		        ([_suriseTime,"HH:MM"]  call BIS_fnc_timeToString) +
		        "<t color='#b0e0e6' size='1' shadow='1' align='right' underline='true'>  Sunset: </t>" +
		        "<t color='#ffffff' size='0.9' shadow='1' align='right' underline='false'> " +
		        ([_sunsetTime,"HH:MM"]  call BIS_fnc_timeToString) +
		        "</t>";

		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 20) ctrlSetStructuredText parseText _html;
	};
};
BIS_fnc_timeToString