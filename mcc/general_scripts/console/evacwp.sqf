// By: Shay_gman
// Version: 1.1 (May 2012)
#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104

disableSerialization;
private ["_type","_flyInHight","_landing","_point1","_convoy_wp1","_convoy_wp2","_point2","_convoy_wp3","_point3","_evac","_evacVehicles"];
_type = _this select 0;
_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerside],[]];

if (count _evacVehicles == 0) exitwith {hint "No Evac is under your command"};
_evac = _evacVehicles select (lbCurSel MCC_ConsoleEvacTypeText_IDD);
if (_evac iskindof "helicopter") then	{							//Incase we moving helicopter
		_flyInHight =  MCC_evacFlyInHight_array select (lbCurSel MCC_ConsoleEvacFlyHightComboBox_IDD) select 1;
		MCC_evacFlyInHight_index = lbCurSel MCC_ConsoleEvacFlyHightComboBox_IDD;
		} else {_flyInHight= 5000};

deletemarkerlocal "evac_marker1";
deletemarkerlocal "evac_marker2";
deletemarkerlocal "evac_marker3";

_landing = lbCurSel MCC_ConsoleEvacApproachComboBox_IDD;

hint  "Left click on the map to add one WP";

click = false;
onMapSingleClick "point1 = _pos;
click = true;
onMapSingleClick """";" ;

waitUntil {(click)};
click = false;
_convoy_wp1 = createMarkerLocal ["evac_marker1",point1];
_convoy_wp1 setMarkerTypeLocal "mil_Dot";
_convoy_wp1 setMarkerSizeLocal [0.5, 0.5];
_convoy_wp1 setMarkertextLocal "1";

_convoy_wp1 setMarkerColorLocal "ColorBlue";
_point1 =getmarkerpos "evac_marker1";

if (_type == 0) then {														// 1 WP
	//hint "Markers placed";
	[[[_point1], _flyInHight, _landing, [netid _evac,_evac]], "MCC_fnc_evacMove", _evac, false] call BIS_fnc_MP;
	} else {																// 3 WP
		hint  "Left click on the map to put 2nd WP";

		onMapSingleClick "point2 = _pos;
		click = true;
		onMapSingleClick """";" ;

		waitUntil {(click)};
		click = false;
		_convoy_wp2 = createMarkerLocal ["evac_marker2",point2];
		_convoy_wp2 setMarkerTypeLocal "mil_Dot";
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
		_convoy_wp3 setMarkerTypeLocal "mil_Dot";
		_convoy_wp3 setMarkerSizeLocal [0.5, 0.5];
		_convoy_wp3 setMarkertextLocal "3";

		_convoy_wp3 setMarkerColorLocal "ColorBlue";
		_point3 =getmarkerpos "evac_marker3";
		sleep 0.5;

		hint "Markers placed";
		[[[_point1, _point2, _point3], _flyInHight, _landing, [netid _evac,_evac]], "MCC_fnc_evacMove", _evac, false] call BIS_fnc_MP;
		};

