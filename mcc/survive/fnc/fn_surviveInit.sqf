/*=================================================================MCC_fnc_surviveInit==================================================================================
  initilize survival mode on clients
*/
//waitUntil {missionNamespace getVariable ["MCC_initDone",false]};

//============= Start items dialog ===========================

0 spawn {

	if (missionNamespace getVariable ["MCC_surviveModinitialized",false]) exitWith {};
	missionNamespace setVariable ["MCC_surviveModinitialized",true];

	while {!(missionNamespace getVariable ["MCC_surviveMod",false])} do {sleep 1};

	//Spawn crates in houses
	if (isServer) then {
		0 spawn {
			private ["_player","_tempArray"];

			//Set resources once start
			{
				_tempArray = [format ["%1_SERVER_SURVIVAL",worldname], "SURVIVAL", format ["%1_resources",_x], "read",[1500,500,200,200,200],format ["%1_SERVER_SURVIVAL",worldname]] call MCC_fnc_handleDB;

				missionNameSpace setVariable [format ["MCC_res%1",_x],_tempArray,true];
			} forEach [west,east,resistance];


			while {true} do {
				sleep 5;
				{
					_player = _x;
					//Position
					[format ["%1_playerPos",worldname], _player,position _player, "ARRAY"] call MCC_fnc_setVariable;

					//Gear
					_tempArray = [goggles _player,
								  headgear _player,
								  uniform _player,
								  vest _player,
								  backpack _player,
								  backpackItems _player,
								  primaryWeaponMagazine _player,
								  secondaryWeaponMagazine _player,
								  handgunMagazine _player,
								  assignedItems _player,
								  uniformItems _player,
								  vestItems _player,
								  primaryWeapon _player,
								  secondaryWeapon _player,
								  handgunWeapon _player,
								  primaryWeaponItems _player,
								  secondaryWeaponItems _player,
								  handgunItems _player];

					[format ["%1_playerGear",worldname], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

					//health and stats
					_tempArray = [damage _player,
								  _player getVariable ["MCC_valorPoints",50],
								  _player getVariable ["MCC_calories",4000],
								  _player getVariable ["MCC_water",200],
								  _player getVariable ["MCC_surviveIsSick",false]
								 ];

					[format ["%1_playerStats",worldname], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

				} forEach (if (isMultiplayer) then {playableUnits} else {[player]});

				//save resources
				{
					_tempArray = missionNameSpace getVariable [format ["MCC_res%1",_x],[1500,500,200,200,200]];
					[format ["%1_SERVER_SURVIVAL",worldname], "SURVIVAL", format ["%1_resources",_x], "write",_tempArray,true] call MCC_fnc_handleDB;
				} forEach [west,east,resistance];
			};
		};
	};


	//if no server get out
	if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

	//Food water consumption
	0 spawn MCC_fnc_foodWaterConsumption;

	//Progress bar UI
	0 spawn MCC_fnc_survivalProgressBars;

	0 spawn {
		private ["_varName","_var"];
		waituntil {alive player &&
					time > 0 &&
					!dialog &&
					!(IsNull (findDisplay 46)) &&
					((missionNameSpace getvariable ["playerDeploy",false]) || !(missionNameSpace getvariable ["CP_activated",false]))
				  };

		//Get player location
		_varName = format ["%1_playerPos",worldname];
		[_varName, player,position player, "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
		waitUntil {!isNil _varName};
		player setpos (missionNameSpace getVariable [_varName,position player]);

		//Set Gear
		_varName = format ["%1_playerGear",worldname];
		[_varName, player,[   goggles player,
							  headgear player,
							  uniform player,
							  vest player,
							  backpack player,
							  backpackItems player,
							  primaryWeaponMagazine player,
							  secondaryWeaponMagazine player,
							  handgunMagazine player,
							  assignedItems player,
							  uniformItems player,
							  vestItems player,
							  primaryWeapon player,
							  secondaryWeapon player,
							  handgunWeapon player,
							  primaryWeaponItems player,
							  secondaryWeaponItems player,
							  handgunItems player], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
		waitUntil {!isNil _varName};
		(missionNameSpace getVariable [_varName,[]]) call MCC_fnc_loadGear;

		//Set player stats
		_varName = format ["%1_playerStats",worldname];
		[_varName, player,[], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
		waitUntil {!isNil _varName};
		_var = missionNameSpace getVariable [_varName,[]];

		player setDamage (_var param [0,0]);
		player setVariable ["MCC_valorPoints",(_var param [1,50]),true];
		player setVariable ["MCC_calories",(_var param [2,4000]),true];
		player setVariable ["MCC_water",(_var param [3,200]),true];
		player setVariable ["MCC_surviveIsSick",(_var param [4,false]),true];
	};
};