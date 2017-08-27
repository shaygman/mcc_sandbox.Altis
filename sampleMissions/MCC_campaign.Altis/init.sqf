#define	SIDE1	"BLU_F"
#define	SIDE2	"OPF_F"
#define	SIDECIV	"CIV_F"
#define	SIDECIVCAR	"CIV_F"

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
HW_arti_types = [["HE Laser-guided","Bo_GBU12_LGB",3,50],["HE 82mm","Sh_82mm_AMOS",1,75]];

if (isServer || isDedicated) then {
	0 spawn {
		waitUntil {time > 0};
		//==*******************************  Enter player UID that allowed to handle MCC **************================--------------
		missionNameSpace setVariable ["MCC_allowedPlayers", []];
		publicVariable "MCC_allowedPlayers";

		//Time Multiplier
		setTimeMultiplier (paramsArray select 3);

		private ["_difficulty","_missionMax","_factionCiv","_factionPlayer","_sidePlayer","_factionEnemy","_sideEnemy","_sidePlayer2","_tickets","_isCiv","_isCar","_isParkedCar","_isLocked","_civSpawnDistance","_maxCivSpawn","_factionCiv","_factionCivCar","_missionRotation"];
		_sidePlayer = west;
		_factionPlayer = SIDE1;
		_sideEnemy = east;
		_factionEnemy = SIDE2;
		_factionCiv = SIDECIV;
		_missionMax = (paramsArray select 6);
		_difficulty = (paramsArray select 5);
		_sidePlayer2 = sideLogic;
		_tickets = 100;
		_missionRotation = 3;

		//Start campaign
		[_sidePlayer,_factionPlayer,_sideEnemy,_factionEnemy,_factionCiv,_missionMax,_difficulty,_sidePlayer2,_tickets,_missionRotation,400] spawn MCC_fnc_campaignInit;

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
			_factionCiv	= SIDECIV;
			_factionCivCar = SIDECIVCAR;

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