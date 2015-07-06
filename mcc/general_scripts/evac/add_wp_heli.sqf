#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

private ["_point1","_convoy_wp1","_flyInHight","_landing","_evac","_evacVehicles"];
_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerside],[]];
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

		_evac = _evacVehicles select (lbCurSel MCC_EVAC_SELECTED);

		//Incase we moving helicopter
		if (_evac iskindof "helicopter") then
		{
			_flyInHight =  MCC_evacFlyInHight_array select (lbCurSel MCC_EVAC_FLIGHTHIGHT) select 1;
			MCC_evacFlyInHight_index = lbCurSel MCC_EVAC_FLIGHTHIGHT;
		}
		else
		{
			_flyInHight= 5000;
		};

		_landing = lbCurSel MCC_EVAC_INSERTION;

		if (MCC_capture_state) then
		{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[[%1], %2, %3,[%4, %5]],"MCC_fnc_evacMove",false,false] spawn BIS_fnc_MP;'
								,_point1
								,_flyInHight
								,_landing
								,netid (_evacVehicles  select (lbCurSel MCC_EVAC_SELECTED))
								,_evacVehicles  select (lbCurSel MCC_EVAC_SELECTED)
								];
		}
		else
		{
			[[[_point1], _flyInHight, _landing, [netid _evac,_evac]],"MCC_fnc_evacMove",_evac,false] spawn BIS_fnc_MP;
		};
	}
	else
	{
		player globalchat "Access Denied";
	};
};
