//General
missionNameSpace setVariable ["MCC_syncOn",true];
missionNameSpace setVariable ["MCC_teleportToTeam",false];
missionNameSpace setVariable ["MCC_saveGear",false];
missionNameSpace setVariable ["MCC_Chat",false];
missionNameSpace setVariable ["MCC_deletePlayersBody",false];
missionNameSpace setVariable ["MCC_allowlogistics",true];
missionNameSpace setVariable ["MCC_allowRTS",true];

//Role selection
missionNameSpace setVariable ["CP_activated",true];
missionNameSpace setVariable ["MCC_allowChangingKits",true];

//Mechanics
missionNameSpace setVariable ["MCC_cover",true];
missionNameSpace setVariable ["MCC_changeRecoil",true];
missionNameSpace setVariable ["MCC_coverUI",true];
missionNameSpace setVariable ["MCC_coverVault",true];
missionNameSpace setVariable ["MCC_interaction",true];
missionNameSpace setVariable ["MCC_ingameUI",true];
missionNameSpace setVariable ["MCC_quickWeaponChange",false];
missionNameSpace setVariable ["MCC_surviveMod",false];
missionNameSpace setVariable ["MCC_showActionKey",false];
missionNamespace setVariable ["MCC_allowSQLRallyPoint",true];

//Medical
missionNameSpace setVariable ["MCC_medicXPmesseges",true];
missionNameSpace setVariable ["MCC_medicPunishTK",true];

//Radio
if ((paramsArray select 4) ==1) then {
	missionNameSpace setVariable ["MCC_VonRadio",true];
	missionNameSpace setVariable ["MCC_vonRadioDistanceGlobal",200000];
	missionNameSpace setVariable ["MCC_vonRadioDistanceSide",10000];
	missionNameSpace setVariable ["MCC_vonRadioDistanceCommander",10000];
	missionNameSpace setVariable ["MCC_vonRadioDistanceGroup",1000];
	missionNameSpace setVariable ["MCC_vonRadioKickIdle",true];
	missionNameSpace setVariable ["MCC_vonRadioKickIdleTime",15];
} else {
	missionNameSpace setVariable ["MCC_VonRadio",false];
};

//artillery
enableEngineArtillery false;
HW_arti_types = [["HE Laser-guided","Bo_GBU12_LGB",3,50],["HE 82mm","Sh_82mm_AMOS",1,75]];

//Spawn UI
_null = [1,true,true,true,true,true,true] spawn MCC_fnc_inGameUI;

if (isServer || isDedicated) then {
	0 spawn {
		waitUntil {time > 0};
		//==*******************************  Enter player UID that allowed to handle MCC **************================--------------
		missionNameSpace setVariable ["MCC_allowedPlayers", []];
		publicVariable "MCC_allowedPlayers";

		//Resources
		missionNamespace setVariable ["MCC_resWest",[1000,1000,1000,200,200]];
		publicVariable "MCC_resWest";

		//Random Weather
		private ["_weather"];
		_weather = (["Random","clear","cloudy","rain","storm","sandStorm","snow"]) select (["param_weather", 0] call BIS_fnc_getParamValue);

		if (_weather == "Random") then {
			_weather = [["clear","cloudy","rain","storm"],[0.55,0.15,0.15,0.15]] call bis_fnc_selectRandomWeighted;
		};

		switch (_weather) do {
		    case "clear": {
		    	[[(random 0.2), (random 0.2), (random 0.2), 0, 0,(random 0.1),0]] spawn MCC_fnc_setWeather;
		    };

		    case "cloudy": {
		    	[[0.4 + (random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2),0 +(random 0.2),0]] spawn MCC_fnc_setWeather;
		    };

		    case "rain": {
		    	[[0.6 + (random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2),0.1 +(random 0.2),0]] spawn MCC_fnc_setWeather;
		    };

		    case "storm": {
		    	[[0.8 + (random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2),0.3 +(random 0.2),0]] spawn MCC_fnc_setWeather;
		    };
		};

		//Random Time
		private ["_time"];
		_time = ([-1,6,12,18,0]) select (["param_daytime", 0] call BIS_fnc_getParamValue);

		if (_time < 0) then {
			_time = [[6,12,18,0],[0.25,0.25,0.25,0.25]] call bis_fnc_selectRandomWeighted;
		};
		_time spawn BIS_fnc_paramDaytime;


		//Time Multiplier
		setTimeMultiplier (paramsArray select 3);


		private ["_difficulty","_missionMax","_factionCiv","_factionPlayer","_sidePlayer","_factionEnemy","_sideEnemy","_sidePlayer2","_tickets","_isCiv","_isCar","_isParkedCar","_isLocked","_civSpawnDistance","_maxCivSpawn","_factionCiv","_factionCivCar","_missionRotation"];
		_sidePlayer = east;
		_factionPlayer = "OPF_T_F";
		_sideEnemy = west;
		_factionEnemy = "BLU_T_F";
		_factionCiv = "CIV_F";
		_missionMax = (paramsArray select 6);
		_difficulty = (paramsArray select 5);
		_sidePlayer2 = sideLogic;
		_tickets = 100;
		_missionRotation = 3;

		//Start campaign
		[_sidePlayer,_factionPlayer,_sideEnemy,_factionEnemy,_factionCiv,_missionMax,_difficulty,_sidePlayer2,_tickets,_missionRotation,300] spawn MCC_fnc_campaignInit;

		//Start day/night cycle
		[_sidePlayer,_sidePlayer2,_factionEnemy] spawn MCC_fnc_dayCycle;

		//Start civilians
		if ((paramsArray select 0) ==1) then {
			_isCiv =  true;
			_isCar = true;
			_isParkedCar = true;
			_isLocked  = false;
			_civSpawnDistance = 700;
			_maxCivSpawn = 10;
			_factionCiv	= "CIV_F";
			_factionCivCar = "CIV_F";

			[_isCiv,_isCar,_isParkedCar,_isLocked,_civSpawnDistance,_maxCivSpawn,_factionCiv,_factionCivCar] spawn MCC_fnc_ambientInit;

			//civ standings
			missionNamespace setvariable [format ["MCC_civRelations_%1",_sidePlayer],(paramsArray select 1)/10];
			publicVariable format ["MCC_civRelations_%1",_sidePlayer];
		};
	};
};


if (!isDedicated && hasInterface) then {
	waituntil {!(IsNull (findDisplay 46))};
	cutText ["","BLACK OUT",0.1];
	sleep 1;

	//Disable inventory
	if ((paramsArray select 2) ==0) then {
		player addEventHandler ["InventoryOpened", {true}];
	};

	//Tutorials
	waituntil {(player getVariable ["cpReady",false]) && !dialog};

	sleep 10;

	//General
	if (profileNamespace getVariable ["MCC_FCtutorialPR",true]) then {
		_answer = ["<img size='10' img image='\mcc_sandbox_mod\mcc\helpers\data\PRmap.paa' align='center'/>
					<br/>This is Capture The Island (CTI) Where you start with almost zero resources and you have to fight your way to capture the island.
					<br/>Each time there will be a <t color='#FF6A32'>main mission</t> and the commander can assign <t color='#FF6A32'>secondary mission</t> from time to time.
					<br/>Completing this missions will award your side <t color='#FF6A32'>resources and personal valor</t> but also draw the attention of the oposite faction.
					<br/>Resources can be used by the commander to <t color='#FF6A32'>build new structures or purchase new vehicles</t>.
					<br/>Personal valor can be used to <t color='#FF6A32'>purchase vehicles from workshops</t>.
					<br/>The mission have a <t color='#FF6A32'>persistent data base</t> so your earned XP will follow you even when you leave.
					<br />Squad commanders can build FOB and other players can use the trucks utilize logistics to build the FOB or other battlefield emplacements
					<br/>You can assign yourself as a side commander or a squad leader by pressing on the <t color='#FF6A32'>Squad Dialog</t> button.
					<br/><br/>Do you want to show this message in the future?","Mission","No","Yes"] call BIS_fnc_guiMessage;

		waituntil {!isnil "_answer" && !dialog};

		profileNamespace setVariable ["MCC_FCtutorialPR",!_answer];
	};

	//Keys layout
	if (profileNamespace getVariable ["MCC_FCtutorialPRKeys",true]) then {

		_answer = ["<img size='8.7' img image='\mcc_sandbox_mod\mcc\helpers\data\PRkeyboardLayout.paa' />
					<br/>Press <t color='#FF6A32'>Interact</t> button to interact with objects or units (medic other, changing kits, vehicles options, logistics exc).
					<br/><br/>Press <t color='#FF6A32'>Interact Self</t> button to interact with yourself (spot enemy, medic self, construct fortifications exc).
					<br/><br/>Press <t color='#FF6A32'>Squad Dialog</t> button to open the Squad Dialog.
					<br/><br/>Do you want to show this message in the future?","Keyboard Layout","No","Yes"] call BIS_fnc_guiMessage;

		waituntil {!isnil "_answer" && !dialog};

		profileNamespace setVariable ["MCC_FCtutorialPRKeys",!_answer];
	};
};