#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

private ["_point1", "_point2", "_point3","_convoy_wp1","_convoy_wp2","_convoy_wp3","_flyInHight","_landing","_evac","_evacVehicles"];

if !mcc_isloading then	{

	deletemarkerlocal "evac_marker1";
	deletemarkerlocal "evac_marker2";
	deletemarkerlocal "evac_marker3";

	hint  "Left click on the map to put 1st WP";
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
	sleep 0.5;

	hint  "Left click on the map to put 2nd WP";

	onMapSingleClick "point2 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp2 = createMarkerLocal ["evac_marker2",point2];
	_convoy_wp2 setMarkerTypeLocal "mil_dot";
	_convoy_wp2 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp2 setMarkertextLocal "2";

	_convoy_wp2 setMarkerColorLocal "ColorBlue";
	_point2 =getmarkerpos "evac_marker2";
	sleep 0.5;

	hint  "Left click on the map to put 3rd WP";

	onMapSingleClick "point3 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp3 = createMarkerLocal ["evac_marker3",point3];
	_convoy_wp3 setMarkerTypeLocal "mil_dot";
	_convoy_wp3 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp3 setMarkertextLocal "3";

	_convoy_wp3 setMarkerColorLocal "ColorBlue";
	_point3 =getmarkerpos "evac_marker3";
	sleep 0.5;

	hint "Markers placed";
	if ((lbCurSel MCC_EVAC_SELECTED) == -1) exitWith {};

	_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerside],[]];
	_evac = _evacVehicles select (lbCurSel MCC_EVAC_SELECTED);
	if (_evac iskindof "helicopter") then	{							//Incase we moving helicopter
		_flyInHight =  MCC_evacFlyInHight_array select (lbCurSel MCC_EVAC_FLIGHTHIGHT) select 1;
		MCC_evacFlyInHight_index = lbCurSel MCC_EVAC_FLIGHTHIGHT;
		} else {_flyInHight= 5000};
	_landing = lbCurSel MCC_EVAC_INSERTION;

	if (MCC_capture_state) then
		{
		MCC_capture_var = MCC_capture_var + FORMAT ['
							[ [%1, %2, %3, [netid %4,%4]],"MCC_fnc_evacMove",false,false] spawn BIS_fnc_MP;
							'
							,[_point1, _point2, _point3]
							,_flyInHight
							,_landing
							,_evac
							];
		} else
			{
			[[[_point1, _point2, _point3], _flyInHight, _landing,[netid _evac,_evac]],"MCC_fnc_evacMove",_evac,false] spawn BIS_fnc_MP;
			};
};
