//======================================================MCC_fnc_dayCycle=================================================================================================
//Control day and night cycle gain tickets and change weather every day
//=======================================================================================================================================================================
private ["_dayCounter","_hourCounter","_goingUp","_overcast","_WindForce","_Waves","_Rain","_Lightnings","_fog","_time","_evac","_sideRep","_sidePlayer2","_CompleteText","_ticketsGain","_side","_resVar","_resArray","_resourceDecreasing","_units","_tickets","_elecUnits","_isElecOn","_buildingLevel","_sides","_value","_showText","_factionEnemy","_elecVar","_enemySides"];
waitUntil {time >0};

_sidePlayer = param [0, west, [sideLogic]];
_sidePlayer2 = param[1, sideLogic, [sideLogic]];
_factionEnemy = param [2,"",[""]];

_sides = if (_sidePlayer2 in [west,east,resistance]) then {[_sidePlayer,_sidePlayer2]} else {[_sidePlayer]};

//Check if the functin already running
if (missionNamespace getVariable ["MCC_fnc_dayCycle_isRunning",false] || !isServer) exitWith {};
missionNamespace setVariable ["MCC_fnc_dayCycle_isRunning",true];
publicVariable "MCC_fnc_dayCycle_isRunning";


_dayCounter = dateToNumber date;
_hourCounter = dateToNumber date;
_sideRep = 0;

while {true} do {

	//find enemy faction
	if (_factionEnemy isEqualTo "") then {
		_enemySides = ([_sidePlayer] call BIS_fnc_enemySides);

		{
			if (side _x in _enemySides && (tolower (getText(configfile >> "CfgVehicles" >>typeOf _x >> "simulation")) isEqualTo "soldier")) exitWith {
				_factionEnemy = faction _x;
			};
		} forEach allunits;
	};

	//Every hour
	if ((dateToNumber date - _hourCounter) > (0.00273973/24)) then {
		_hourCounter = dateToNumber date;

		_CompleteText =         "<t align='center' size='1.8' color='#FFCF11'> Warning </t><br/>"
									+"____________________<br/>";

		{
			//resources
			_side = _x;

			_showText = false;

			//get number of storage
			([["resources","units","electricity"],playerSide] call MCC_fnc_rtsCalculateResourceTreshold) params [
									["_cargoSpace",0,[0]],
									["_unitsSpace",0,[0]],
									["_fuelForElectricity",0,[0]]
								   ];


			//get resources
			_resVar = format ["MCC_res%1", _side];
			_resArray = missionNamespace getvariable [_resVar,[]];

			//Electricity
			_elecVar = format ["MCC_rtsElecOn_%1", _side];
			_isElecOn = missionNamespace getvariable [_elecVar,false];
			if (_isElecOn) then {
				_resArray set [2,((_resArray select 2) - _fuelForElectricity) max 0];

				//No fuel no electricity
				if (_resArray select 2 <=0) then {
					missionNamespace setvariable [_elecVar,false];
					publicVariable _elecVar;
					_CompleteText = _CompleteText + format ["<img image='%1data\IconFuel.paa'/> The Diesel Generator is out of fuel<br/><br/>", MCC_path];
					_showText = true;
				};
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

			([["units"],playerSide,true] call MCC_fnc_rtsCalculateResourceTreshold) params [
									["_unitsSpace",0,[0]],
									["_buildings",[],[[]]]
								   ];

			//get resources
			_resVar = format ["MCC_res%1", _side];
			_resArray = missionNamespace getvariable [_resVar,[500,500,200,200,100]];

			//units
			_CompleteText = _CompleteText + format ["<t align='center' size='1.2' color='#FFCF11'><img image='%1data\IconMen.paa'/> Morale <br/></t>", MCC_path];

			_units = {side _x == _side && (isPlayer _x || group _x getVariable ["MCC_canbecontrolled",false])} count allUnits;

			if (_units > _unitsSpace) then {
				_tickets = [_side, (_units - _unitsSpace)*-1] call BIS_fnc_respawnTickets;
				_CompleteText = _CompleteText + format ["<t color='#FF0000'>Missing %1 Sleeping Bunks - %1 tickets decreased<br/></t>",(_units - _unitsSpace)];
			} else {
				_CompleteText = _CompleteText + "We Have Enough sleeping bunks<br/>";
			};

			_CompleteText = _CompleteText + "<br/>";

			//Food
			_CompleteText = _CompleteText + format ["<t align='center' size='1.2' color='#FFCF11'><img image='%1data\IconFood.paa'/> Food <br/></t>", MCC_path];

			_CompleteText = _CompleteText + format ["Food Consumption - %1 food for %2 units<br/>", floor _units*2,floor _units];
			_value = ((_resArray select 3) - (_units*2)) max 0;
			_resArray set [3,_value];

			if ((_resArray select 3)<=0) then {
				_CompleteText = _CompleteText + "<t color='#FF0000'>Out of Food - 5 tickets decreased<br/></t>";
				_tickets = [_side,-5] call BIS_fnc_respawnTickets;
			};

			_buildingLevel = 1;
			{
				_buildingLevel = _buildingLevel max (_x getVariable ["mcc_constructionItemTypeLevel",1]);
			} forEach (_buildings select 0);

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
														+ "HQ Sends you some new evac vehicles try to keep it safe this time<br/>";
					};
				} forEach _evacVehicles;
			};

			//War effort
			if !(_x in [sideLogic,_sidePlayer2]) then {
				_sideRep = (missionNamespace getvariable [format ["campaignRep_%1",_x],(10 + (floor random 20))])*1.2; //rep increase by 20% every day

				_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> Infamous Level</t><br/>"
												+	str floor ((_sideRep) min 100) + "%<br/>";
				//we really pissed them off lets start a war
				if (_sideRep >= 90) then {
					_sideRep = 10 + (floor random 20);

					_CompleteText = _CompleteText 	+ "<t color='#FF0000'>Warning, enemy forces are moving to attack your base. <br/></t>";

					//Attack base
					[_x,_factionEnemy] spawn MCC_fnc_MWattackBase
				} else {
					if (random 100 < _sideRep) then {
						_CompleteText = _CompleteText 	+ "<t color='#FF0000'>Your actions did not go unnoticed, enemy forces are more likely to attck. <br/></t>";
						_sideRep = _sideRep *2;
					} else {
						_CompleteText = _CompleteText 	+ "Enemy forces are not searching for your forces<br/>";
					};
				};

				missionNamespace setvariable [format ["campaignRep_%1",_x],_sideRep];
				publicVariable format ["campaignRep_%1",_x];

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
													+ format ["It seems like today weather is goint to get %1<br/>", if (_goingUp) then {"worse"} else {"better"}];
			};


			//Send hint
			[_CompleteText,true] remoteExec ["MCC_fnc_globalHint",_x];
		} forEach _sides;
	};
	sleep 1;
};