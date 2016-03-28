#define MCC_CONVOY_CAR1 50
#define MCC_CONVOY_CAR2 51
#define MCC_CONVOY_CAR3 52
#define MCC_CONVOY_CAR4 53
#define MCC_CONVOY_CAR5 54
#define MCC_CONVOY_HVT 55
#define MCC_CONVOY_HVTCAR 56
private ["_convoy_wp1","_point1","_convoy_wp2","_point2","_convoy_wp3","_point3","_convoy_wp4","_point4","_convoy_wp5","_point5"];
if !mcc_isloading then {
	if (mcc_missionmaker == (name player)) then {
		deletemarkerlocal "marker1";	//delete precious markers
		deletemarkerlocal "marker2";
		deletemarkerlocal "marker3";
		deletemarkerlocal "marker4";
		deletemarkerlocal "marker5";

		convoy_car1 = [(U_GEN_CAR select (lbCurSel MCC_CONVOY_CAR1)) select 1];	//first lets read the cars
		convoy_car2 = [(U_GEN_CAR select (lbCurSel MCC_CONVOY_CAR2)) select 1];
		convoy_car3 = [(U_GEN_CAR select (lbCurSel MCC_CONVOY_CAR3)) select 1];
		convoy_car4 = [(U_GEN_CAR select (lbCurSel MCC_CONVOY_CAR4)) select 1];
		convoy_car5 = [(U_GEN_CAR select (lbCurSel MCC_CONVOY_CAR5)) select 1];
		vip = [(MCC_convoyHVT select (lbCurSel MCC_CONVOY_HVT)) select 1];
		vipCar = [(MCC_convoyHVTcar select (lbCurSel MCC_CONVOY_HVTCAR)) select 1];

		MCC_convoyCar1Index = lbCurSel MCC_CONVOY_CAR1;					//Save the indexes
		MCC_convoyCar2Index = lbCurSel MCC_CONVOY_CAR2;
		MCC_convoyCar3Index = lbCurSel MCC_CONVOY_CAR3;
		MCC_convoyCar4Index = lbCurSel MCC_CONVOY_CAR4;
		MCC_convoyCar5Index = lbCurSel MCC_CONVOY_CAR5;
		MCC_convoyHVTIndex = lbCurSel MCC_CONVOY_HVT;
		MCC_convoyHVTCarIndex = lbCurSel MCC_CONVOY_HVTCAR;


		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>Left click on the map to set start position for the convoy</t><br/>
					<t color='#33CC00'>Waypoints done: 0</t><br/>
					<t color='#FF0000'>Waypoints to go: 5</t><br/>--------------------------<br/>"];

		//hint  "Left click on the map to put start position for the convy";
		click = false;
		onMapSingleClick "point1 = _pos;
		click = true;
		onMapSingleClick """";" ;

		waitUntil {(click)};
		click = false;
		_convoy_wp1 = createMarkerLocal ["marker1",point1];
		_convoy_wp1 setMarkerTypeLocal "mil_dot";
		_convoy_wp1 setMarkerSizeLocal [0.5, 0.5];
		_convoy_wp1 setMarkertextLocal "Start";

		_convoy_wp1 setMarkerColorLocal "ColorRed";
		_point1 =getmarkerpos "marker1";
		sleep 0.5;

		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>Left click on the map to set the 1st waypoint for the convoy</t><br/>
					<t color='#33CC00'>Waypoints done: 1</t><br/>
					<t color='#FF0000'>Waypoints to go: 4</t><br/>--------------------------<br/>"];

		//hint  "Left click on the map to put first convoy point";

		onMapSingleClick "point2 = _pos;
		click = true;
		onMapSingleClick """";" ;

		waitUntil {(click)};
		click = false;
		_convoy_wp2 = createMarkerLocal ["marker2",point2];
		_convoy_wp2 setMarkerTypeLocal "mil_dot";
		_convoy_wp2 setMarkerSizeLocal [0.5, 0.5];
		_convoy_wp2 setMarkertextLocal "1";

		_convoy_wp2 setMarkerColorLocal "ColorRed";
		_point2 =getmarkerpos "marker2";
		sleep 0.5;

		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>Left click on the map to set the 2nd waypoint for the convoy</t><br/>
					<t color='#33CC00'>Waypoints done: 2</t><br/>
					<t color='#FF0000'>Waypoints to go: 3</t><br/>--------------------------<br/>"];

		//hint  "Left click on the map to put second convoy point";

		onMapSingleClick "point3 = _pos;
		click = true;
		onMapSingleClick """";" ;

		waitUntil {(click)};
		click = false;
		_convoy_wp3 = createMarkerLocal ["marker3",point3];
		_convoy_wp3 setMarkerTypeLocal "mil_dot";
		_convoy_wp3 setMarkerSizeLocal [0.5, 0.5];
		_convoy_wp3 setMarkertextLocal "2";

		_convoy_wp3 setMarkerColorLocal "ColorRed";
		_point3 =getmarkerpos "marker3";
		sleep 0.5;

		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>Left click on the map to set the 3rd waypoint for the convoy</t><br/>
					<t color='#33CC00'>Waypoints done: 3</t><br/>
					<t color='#FF0000'>Waypoints to go: 2</t><br/>--------------------------<br/>"];

		//hint  "Left click on the map to put third convoy point";

		onMapSingleClick "point4 = _pos;
		click = true;
		onMapSingleClick """";" ;

		waitUntil {(click)};
		click = false;
		_convoy_wp4 = createMarkerLocal ["marker4",point4];
		_convoy_wp4 setMarkerTypeLocal "mil_dot";
		_convoy_wp4 setMarkerSizeLocal [0.5, 0.5];
		_convoy_wp4 setMarkertextLocal "3";

		_convoy_wp4 setMarkerColorLocal "ColorRed";
		_point4 =getmarkerpos "marker4";
		sleep 0.5;

		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>Left click on the map to set the last waypoint for the convoy</t><br/>
					<t color='#33CC00'>Waypoints done: 4</t><br/>
					<t color='#FF0000'>Waypoints to go: 1</t><br/>--------------------------<br/>"];

		//hint  "Left click on the map to put the last convoy point";

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

		hint parseText format["Add waypoints for convoy:<br/>--------------------------<br/>
					<t color='#00CCFF'>All waypoint for the convoy have been set</t><br/>
					<t color='#33CC00'>Waypoints done: 5</t><br/>
					<t color='#FF0000'>Waypoints to go: 0</t><br/>--------------------------<br/>"];

		if (MCC_capture_state) then {
			hint "Convoy captured";
			MCC_capture_var = MCC_capture_var + FORMAT ["
									point2 =%7;
									point3 =%8;
									point4 =%9;
									point5 =%10;
									vip = %12;
									[[%1 select 0, %2 select 0, %3 select 0, %4 select 0, %5 select 0,%6, %7, %11 select 0,%12 select 0, %13 select 0],""MCC_fnc_placeConvoy"",false,false] spawn BIS_fnc_MP;
								    "
								  , convoy_car1
								  , convoy_car2
								  , convoy_car3
								  , convoy_car4
								  , convoy_car5
								  , _point1
								  , _point2
								  , _point3
								  , _point4
								  , _point5
								  , [mcc_sidename]
								  , vip
								  , vipCar
								  ];
		} else {
			hint "Convoy placed";
			[[convoy_car1 select 0, convoy_car2 select 0, convoy_car3 select 0, convoy_car4 select 0, convoy_car5 select 0,_point1, _point2,[mcc_sidename] select 0, vip select 0, vipCar select 0],"MCC_fnc_placeConvoy",false,false] spawn BIS_fnc_MP;
			mcc_safe = mcc_safe + FORMAT ["
									point2 =%7;
									point3 =%8;
									point4 =%9;
									point5 =%10;
									vip = %12;
									[[%1 select 0, %2 select 0, %3 select 0, %4 select 0, %5 select 0,%6, %7, %11 select 0,%12 select 0, %13 select 0],""MCC_fnc_placeConvoy"",false,false] spawn BIS_fnc_MP;
								    sleep 1;
								  "
								  , convoy_car1
								  , convoy_car2
								  , convoy_car3
								  , convoy_car4
								  , convoy_car5
								  , _point1
								  , _point2
								  , _point3
								  , _point4
								  , _point5
								  , [mcc_sidename]
								  , vip
								  , vipCar
								  ];
		};
	} else { player globalchat "Access Denied"};
};