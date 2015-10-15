if (isnil "MCC_convoyVehicles") exitWith {systemchat "You must spawn a convoy first"};
if !mcc_isloading then
{
	if (mcc_missionmaker == (name player)) then
	{
	deletemarkerlocal "marker1";
	deletemarkerlocal "marker2";
	deletemarkerlocal "marker3";
	deletemarkerlocal "marker4";
	deletemarkerlocal "marker5";

	hint  "Left click on the map to put start position for the convy";

	onMapSingleClick "point1 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp1 = createMarkerLocal ["marker1",point1];
	_convoy_wp1 setMarkerTypeLocal "mil_dot";
	_convoy_wp1 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp1 setMarkertextLocal "1";

	_convoy_wp1 setMarkerColorLocal "ColorRed";
	_point1 =getmarkerpos "marker1";
	sleep 0.5;

	hint  "Left click on the map to put first convoy point";

	onMapSingleClick "point2 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp2 = createMarkerLocal ["marker2",point2];
	_convoy_wp2 setMarkerTypeLocal "mil_dot";
	_convoy_wp2 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp2 setMarkertextLocal "2";

	_convoy_wp2 setMarkerColorLocal "ColorRed";
	_point2 =getmarkerpos "marker2";
	sleep 0.5;

	hint  "Left click on the map to put second convoy point";

	onMapSingleClick "point3 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp3 = createMarkerLocal ["marker3",point3];
	_convoy_wp3 setMarkerTypeLocal "mil_dot";
	_convoy_wp3 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp3 setMarkertextLocal "3";

	_convoy_wp3 setMarkerColorLocal "ColorRed";
	_point3 =getmarkerpos "marker3";
	sleep 0.5;

	hint  "Left click on the map to put third convoy point";

	onMapSingleClick "point4 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp4 = createMarkerLocal ["marker4",point4];
	_convoy_wp4 setMarkerTypeLocal "mil_dot";
	_convoy_wp4 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp4 setMarkertextLocal "4";

	_convoy_wp4 setMarkerColorLocal "ColorRed";
	_point4 =getmarkerpos "marker4";
	sleep 0.5;

	hint  "Left click on the map to put the last convoy point";

	onMapSingleClick "point5 = _pos;
	click = true;
	onMapSingleClick """";" ;

	waitUntil {(click)};
	click = false;
	_convoy_wp5 = createMarkerLocal ["marker5",point5];
	_convoy_wp5 setMarkerTypeLocal "mil_dot";
	_convoy_wp5 setMarkerSizeLocal [0.5, 0.5];
	_convoy_wp5 setMarkertextLocal "End";

	_convoy_wp5 setMarkerColorLocal "ColorRed";
	_point5 =getmarkerpos "marker5";
	sleep 0.5;

	}
	else { player globalchat "Access Denied"};
};