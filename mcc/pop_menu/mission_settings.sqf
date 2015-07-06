#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

private ["_weather","_type", "_grass","_fogLevel","_d","_nul","_rain","_overcast","_month","_day","_year","_hour","_minute","_wind","_Waves","_time"];
_type = _this select 0;


if (_type==0) exitWith {

	_fogLevel 	= sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10);		//Set fog
	_overcast 	=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12);	//Set overcast
	_rain 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11);	//Set rain
	_wind 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 14);	//Set wind
	_Waves 		=  sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 13);	//Set wind
	_time		= (sliderPosition ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11225))*600;	//Set over time

	_weather	= [_overcast, _wind, _Waves, _rain, _overcast, _fogLevel,_time];
	_nul=[_type, _weather] execVM MCC_path +"mcc\general_scripts\time.sqf";
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
	//[] call BIS_fnc_camera;
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
				MCC_terrainPref set [0,(lbCurSel MCCGRASSDENSITY)];
				profileNamespace setVariable ["MCC_terrainPref", MCC_terrainPref];
			}
		};

		case 2:	//Set viewdistance (CS)
		{
		setViewDistance (MCC_view_array select (lbCurSel MCCVIEWDISTANCE));
		MCC_terrainPref set [1,(lbCurSel MCCVIEWDISTANCE)];
		};
	 };
};