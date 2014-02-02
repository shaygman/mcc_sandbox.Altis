#define MCC_SANDBOX2_IDD 2000
#define MCC_EVAC_TYPE 2020
#define MCC_EVAC_CLASS 2021
#define MCC_EVAC_SELECTED 2022
#define MCC_EVAC_INSERTION 2023
#define MCC_EVAC_FLIGHTHIGHT 2024

private ["_point1","_convoy_wp1","_flyInHight","_landing","_evac"];

if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{	
	deletemarkerlocal "evac_marker1";
	deletemarkerlocal "evac_marker2";
	deletemarkerlocal "evac_marker3";
	
	hint  "Left click on the map to add one WP";
	click = false; 
	onMapSingleClick "point1 = _pos;
	click = true;
	onMapSingleClick """";" ;
		
	waitUntil {(click)};
	click = false;
	_convoy_wp1 = createMarkerLocal ["evac_marker1",point1];
	_convoy_wp1 setMarkerTypeLocal "mil_dot";
	_convoy_wp1 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp1 setMarkertextLocal "1";

	_convoy_wp1 setMarkerColorLocal "ColorBlue";
	_point1 =getmarkerpos "evac_marker1";
	
	hint "Markers placed";
	if ((lbCurSel MCC_EVAC_SELECTED) == -1) exitWith {}; 
	_evac = MCC_evacVehicles select (lbCurSel MCC_EVAC_SELECTED);
	if (_evac iskindof "helicopter") then	{							//Incase we moving helicopter
		_flyInHight =  MCC_evacFlyInHight_array select (lbCurSel MCC_EVAC_FLIGHTHIGHT) select 1; 
		MCC_evacFlyInHight_index = lbCurSel MCC_EVAC_FLIGHTHIGHT;
		} else {_flyInHight= 5000}; 
	_landing = lbCurSel MCC_EVAC_INSERTION; 
	
	if (MCC_capture_state) then
		{
		MCC_capture_var = MCC_capture_var + FORMAT ['
							[[[%1], %2, %3,MCC_evacVehicles select %4],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;'
							,_point1
							,_flyInHight
							,_landing
							,(lbCurSel MCC_EVAC_SELECTED)
							];
		} else
			{
			[[[_point1], _flyInHight, _landing, _evac],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;
			};
	}	
		else { player globalchat "Access Denied"};
	};
