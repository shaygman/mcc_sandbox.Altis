//======================================================MCC_fnc_dayCycle=================================================================================================
//Control day and night cycle gain tickets and change weather every day
//=======================================================================================================================================================================
private ["_dayCounter","_hourCounter","_goingUp","_overcast","_WindForce","_Waves","_Rain","_Lightnings","_fog","_time","_sidePlayer","_evac","_sideRep","_sidePlayer2","_CompleteText","_ticketsGain","_resources","_buildings","_startPos","_side","_cargoSpace","_unitsSpace","_resVar","_resArray","_resourceDecreasing","_units","_tickets","_elecUnits","_isElecOn","_buildingLevel","_sides","_value","_showText"];
waitUntil {time >0};

_sidePlayer = [_this, 0, west] call BIS_fnc_param;
_sidePlayer2 = [_this, 1, sideLogic] call BIS_fnc_param;
_sides = if (_sidePlayer2 in [west,east,resistance]) then {[_sidePlayer,_sidePlayer2]} else {[_sidePlayer]};

_dayCounter = dateToNumber date;
_hourCounter = dateToNumber date;
_sideRep = 0;

while {true} do {

	if ((dateToNumber date - _hourCounter) > (0.00273973/24)) then {
		_hourCounter = dateToNumber date;

		_CompleteText =         "<t align='center' size='1.8' color='#FFCF11'> Warning </t><br/>"
									+"____________________<br/>";

		{
			//resources
			_side = _x;
			_resources = missionNamespace getvariable [format ["MCC_res%1",_side],[500,500,200,200,100]];

			_startPos = call compile format ["MCC_START_%1",_side];
			_buildings = _startPos nearEntities [["logic"], 300];
			_cargoSpace = 500;
			_unitsSpace = 4;
			_elecUnits= [];
			_showText = false;

			//Find buildings
			{
				if ((_x getVariable ["mcc_constructionItemType",""]) == "storage" && !(isNull attachedTo _x)) then {
					_cargoSpace = _cargoSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*500);
				};

				if ((_x getVariable ["mcc_constructionItemType",""]) == "barracks" && !(isNull attachedTo _x)) then {
					_unitsSpace = _unitsSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*4);
				};

				if ((_x getVariable ["mcc_constructionItemType",""]) == "elecPower" && !(isNull attachedTo _x)) then {
					_elecUnits pushBack _x;
				};

			} foreach _buildings;

			//get resources
			_resVar = format ["MCC_res%1", _side];
			_resArray = missionNamespace getvariable [_resVar,[]];

			//Electricity
			_elecVar = format ["MCC_rtsElecOn_%1", _side];
			_isElecOn = missionNamespace getvariable [_elecVar,false];
			if (_isElecOn) then {
				{
					_buildingLevel = _x getVariable ["mcc_constructionItemTypeLevel",1];
					if (_buildingLevel <3) then {
						_resArray set [2,((_resArray select 2) - (_buildingLevel*3)) max 0];

						//No fuel no electricity
						if (_resArray select 2 <=0) then {
							missionNamespace setvariable [_elecVar,false];
							publicVariable _elecVar;
							_CompleteText = _CompleteText + format ["<img image='%1data\IconFuel.paa'/> The Diesel Generator is out of fuel<br/><br/>", MCC_path];
							_showText = true;
						};
					};
				} forEach _elecUnits;
			};

			//reduce resources
			_resourceDecreasing = false;
			{
				if (_x > _cargoSpace) then {
					_resArray set [_foreachindex, _x *0.9];
					_resourceDecreasing = true;
				};
			} foreach _resArray;

			if (_resourceDecreasing) then {
				_CompleteText = _CompleteText + format ["<img image='%1data\IconRepair.paa'/> We are loosing resources. Build more Storage Areas<br/><br/>", MCC_path];
				_showText = true;
			} else {
				_CompleteText = _CompleteText + format ["<img image='%1data\IconRepair.paa'/> We have enough Storage Areas<br/><br/>", MCC_path];
			};

			//Broadcast resources
			missionNamespace setVariable [_resVar,_resArray];
			publicVariable _resVar;

			//Send hint
			if (_showText) then {
				[[_CompleteText,true],"MCC_fnc_globalHint",_side,false] spawn BIS_fnc_MP;
			};
		} forEach _sides;
	};

	//A day passed
	if ((dateToNumber date - _dayCounter) > 0.00273973) then {
		_dayCounter = dateToNumber date;

		_CompleteText =         "<t align='center' size='1.8' color='#FFCF11'> Day End</t><br/>"
									+"____________________<br/><br/>";

		//Turn food and meds into tickets
		{
			_side = _x;
			_startPos = call compile format ["MCC_START_%1",_side];
			_buildings = _startPos nearEntities [["logic"], 300];
			_buildingLevel = 1;
			_resources = missionNamespace getvariable [format ["MCC_res%1",_side],[500,500,200,200,100]];

			_ticketsGain = floor ((_resources select 3)/50 + (_resources select 4)/10);


			//Find buildings
			{
				if ((_x getVariable ["mcc_constructionItemType",""]) == "storage" && !(isNull attachedTo _x)) then {
					_buildingLevel = (_x getVariable ["mcc_constructionItemTypeLevel",1]) max _buildingLevel;
				};

				if ((_x getVariable ["mcc_constructionItemType",""]) == "barracks" && !(isNull attachedTo _x)) then {
					_unitsSpace = _unitsSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*4);
				};
			} foreach _buildings;

			//get resources
			_resVar = format ["MCC_res%1", _side];
			_resArray = missionNamespace getvariable [_resVar,[]];

			//units
			_CompleteText = _CompleteText + format ["<t align='center' size='1.2' color='#FFCF11'><img image='%1data\IconMen.paa'/> Morale <br/></t>", MCC_path];

			_units = {side _x == _side && (isPlayer _x || _x getVariable ["MCC_isRTSunit",false])} count allUnits;

			if (_units > _unitsSpace) then {
				_tickets = [_side, (_units - _unitsSpace)*-1] call BIS_fnc_respawnTickets;
				_CompleteText = _CompleteText + format ["<t color='#FF0000'>Not Enough Sleeping Bunks - %1 tickets decreased<br/></t>",(_units - _unitsSpace)];
			} else {
				_CompleteText = _CompleteText + "We Have Enough sleeping bunks<br/>";
			};

			_CompleteText = _CompleteText + "<br/>";

			//Food
			_CompleteText = _CompleteText + format ["<t align='center' size='1.2' color='#FFCF11'><img image='%1data\IconFood.paa'/> Food <br/></t>", MCC_path];

			_CompleteText = _CompleteText + format ["Food Consumption - %1 units<br/>", floor _units];
			_value = ((_resArray select 3) - (_units)) max 0;
			_resArray set [3,_value];

			if ((_resArray select 3)<=0) then {
				_CompleteText = _CompleteText + "<t color='#FF0000'>Out of Food - 5 tickets decreased<br/></t>";
				_tickets = [_side,-5] call BIS_fnc_respawnTickets;
			};

			//Spoil Chance
			if (random 10 > (6+_buildingLevel)) then {
				_value = floor (_resArray select 3)*0.4;
				_CompleteText = _CompleteText + format ["<t color='#FF0000'>Food Spoilage - %1 food lost<br/></t>", floor _value];
				_resArray set [3,(_resArray select 3) - _value];
			};

			_CompleteText = _CompleteText + "<br/>";

			//Broadcast resources
			missionNamespace setVariable [_resVar,_resArray];
			publicVariable _resVar;

			//Respawn EVAC
			private ["_varName","_evacVehicles"];
			_varName = format ["MCC_campaignEvac_%1", _x];
			_evacVehicles = missionNamespace getVariable [_varName,[]];

			if (count _evacVehicles > 0) then {
				{
					_evac = _x select 0;

					if (!(alive _evac) || !(alive driver _evac) || isNull _evac) then {
						[_x select 1, _x select 2, true] spawn MCC_fnc_evacSpawn;
						_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> EVAC</t><br/>"
														+ "HQ Sends you some new evac vehicles try to keep it safe this time<br/>"
														+ "____________________<br/><br/>";
					};
				} forEach _evacVehicles;
			};

			//War effort
			if !(_x in [sideLogic,_sidePlayer2]) then {
				_sideRep = (missionNamespace getvariable [format ["campaignRep_%1",_x],0])*0.9; //rep decrease by 10% every day
				_sideRep = (_sideRep + _ticketsGain*2) min 90;

				if (random 100 < _sideRep) then {
					MCC_GAIA_AC = true;
					_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> Infamous Level</t><br/>"
														+ "Warning, Your actions did not go unnoticed, enemy forces are now actively hunting your forces. <br/>"
														+ "____________________<br/><br/>";
				} else {
					MCC_GAIA_AC = false;
					_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> Infamous Level</t><br/>"
														+ "Enemy forces are not searching for your forces<br/>"
														+ "____________________<br/><br/>";

				};
				missionNamespace setvariable [format ["campaignRep_%1",_x],_sideRep];
				publicVariable format ["campaignRep_%1",_x];
				publicVariable "MCC_GAIA_AC";

				//Change weather
				_goingUp =  if ((date select 1) in [11,12,1,2,3,4]) then {random 1 > 0.3} else {random 1 > 0.7};

				_time = 60;
				if (_goingUp) then {
					_overcast = (overcast +0.2) min 1;
					_WindForce = (windStr +0.2) min 1;
					_Waves = (Waves +0.2) min 1;
					_Rain = (Rain +0.2) min 1;
					_Lightnings = (Lightnings +0.2) min 1;
					_fog = (fog +0.2) min 0.6;
				} else {
					_overcast = (overcast -0.2) max 0;
					_WindForce = (windStr -0.2) max 0;
					_Waves = (Waves -0.2) max 0;
					_Rain = (Rain -0.2) max 0;
					_Lightnings = (Lightnings -0.2) max 0;
					_fog = (fog -0.2) max 0;
				};
				[[[_overcast, _WindForce, _Waves, _Rain, _Lightnings,_fog,_time]],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;


				_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> Weather</t><br/>"
													+ format ["It seems like today weather is goint to get %1<br/>", if (_goingUp) then {"worse"} else {"better"}]
													+ "____________________<br/><br/>";
			};


			//Send hint
			[[_CompleteText,true],"MCC_fnc_globalHint",_x,false] spawn BIS_fnc_MP;

		} forEach _sides;
	};
	sleep 1;
};