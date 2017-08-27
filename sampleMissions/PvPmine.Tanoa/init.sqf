//Radio
if ((paramsArray select 2) ==1) then {
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

if (isServer || isDedicated) then {
	0 spawn {

		_side2 = east;

		//time multuplayer
		setTimeMultiplier (paramsArray select 1);

	};
};


if (!isDedicated && hasInterface) then {
	waituntil {!(IsNull (findDisplay 46))};
	cutText ["","BLACK OUT",0.1];
	sleep 1;

	//Disable inventory
	if ((paramsArray select 0) ==0) then {
		player addEventHandler ["InventoryOpened", {true}];
	};

	//Tutorials
	waituntil {player getVariable ["cpReady",false]};

	if (profileNamespace getVariable ["MCC_PRtutorialPR",true]) then {
		_answer = ["<img size='10' img image='PRmap.paa' align='center'/>
					<br/>This is Advance and Secure (AAS) mission where two sides are fighting to capture the island.
					<br/>Each side will have a commander and limited resources to help him capture the island.
					<br/>The capture points can only be captured in a specific order and the mission will end once all one side tickets reached zero or the mission time runs out.
					<br />Squad commanders can build FOB and other players can use the trucks utilize logistics to build the FOB or other battlefield emplacements
					<br/>You can assign yourself as a side commander or a squad leader by pressing on the <t color='#FF6A32'>Squad Dialog</t> button.
					<br/><br/>Do you want to disable this message in the future?","Mission","Yes","No"] call BIS_fnc_guiMessage;

		waituntil {!isnil "_answer"};
	};
};