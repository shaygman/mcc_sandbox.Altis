//==================================================================MCC_fnc_helpersInit=================================================================================
//init help tutorials
//=====================================================================================================================================================================
private ["_answer"];

if (player == player && !( isDedicated) && !(missionNamespace getVariable ["MCC_isLocalHC",false])) then {
	0 spawn {
		waituntil {!(IsNull (findDisplay 46))};

		sleep 10;

		//============ interaction key  ========================
		0 spawn {

			//If ACE is on no need to set MCC key
			if (missionNamespace getVariable ["MCC_isACE",false]) exitWith {};

			private ["_key"];
			if (missionNamespace getVariable ["MCC_isCBA",false]) then {
				_key = ["MCC","interactionKey"] call CBA_fnc_getKeybind;
				while {(count _key <=0)} do {
					["Assing MCC Interaction Key !!!",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;
					sleep 5;
				 };
			} else {
				while {(isNil "MCC_keyBinds")} do {
					["Assing MCC Interaction Key !!!",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;
					sleep 5;
				};
			};
		};

		//============ engineer data ========================
		0 spawn {
			private ["_answer"];

			//Check if is engineer
			if ((getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines") == 1)&& (profileNamespace getVariable ["MCC_tutorialEOD",true])) then {

				waitUntil {!dialog && cameraOn == vehicle player};

				_answer = ["<t font='TahomaB'>You have just been assigned as Engineer/EOD</t>
					<br/><img size='8' img image='\a3\missions_f\data\img\mp_coop_m01_overview_ca.paa' />
					<br/>You can disarm mines and improvised explosive devices (IED).
					<br/>To make sure the IED isn't Radio Controlled IED (RCIED), scan for enemy's spotters that can trigger the IED and neutralize them first.
					<br/>Approach the IED carefully (no faster then a slow crawl), once you get close to it you either have the option to disarm it. Or you can place a demo charge to set off a controlled explosion.
					<br/>You can use Electronic Countermeasure Vehicles (ECM) to block RCIEDs.
					<br/><br/>Do you want to show this message in the future?","MCC Engineer/EOD","No","Yes"] call BIS_fnc_guiMessage;

					waituntil {!isnil "_answer"};

					profileNamespace setVariable ["MCC_tutorialEOD",!_answer];
			};
		};

		//Commander
		0 spawn {
			waituntil {(((missionNamespace getVariable ["MCC_server",objNull]) getVariable [format ["CP_commander%1",side player],""]) == getPlayerUID player) && !dialog && cameraOn == vehicle player};
			if (profileNamespace getVariable ["MCC_FCtutorialCommander",true]) then {
				_answer = ["<img size='10' img image=" + format ["'%1mcc\helpers\data\commanderRTS.paa'", MCC_path] + " align='center'/>
							<br/>As the commander you can order the <t color='#FF6A32'>construction of new buildings, recruit AI and even build vehicles</t>.
							<br/>Open the commander console using your <t color='#FF6A32'>self interaction keys</t> or use the shortcut buttons as defined in the settings.
							<br/>From the console you can <t color='#FF6A32'>order players and AI group</t> by selecting them and double clicking on the map.
							<br/>You can call <t color='#FF6A32'>EVAC CAS and Supply drops</t> using the <t color='#FF6A32'> F2 and F3 buttons</t>.
							<br/>Order <t color='#FF6A32'>artillery</t> using the <t color='#FF6A32'>F4</t> button.
							<br/>Open the <t color='#FF6A32'>RTS</t> to expend your base using the <t color='#FF6A32'>F5</t> button.
							<br/><br/>Do you want to show this message in the future?","Commander Role","No","Yes"] call BIS_fnc_guiMessage;

				waituntil {!isnil "_answer" && !dialog};

				profileNamespace setVariable ["MCC_FCtutorialCommander",!_answer];
			};
		};

		//Squad Leader
		0 spawn {
			waituntil {leader player == player && count units group player > 1 && !dialog && cameraOn == vehicle player};
			if (profileNamespace getVariable ["MCC_FCtutorialSQL",true]) then {
				_answer = ["<img size='10' img image=" + format ["'%1mcc\helpers\data\sqlPic.paa'", MCC_path] + "align='center'/>
							<br/>As the Squad Leader you will have more option in the <t color='#FF6A32'>self interaction menu</t>.
							<br/>You'll be able to place <t color='#FF6A32'>support markers</t> or <t color='#FF6A32'>spot enemies</t> by marking them on the map for 5 minutes.
							<br/>The <t color='#FF6A32'>Squad Leader PDA</t> can be used to constantly show friendly player on the HUD and increase battlefield awarness.
							<br/>You can also order the <t color='#FF6A32'>construction of battlefield emplacements</t> such as F.O.B which serves as spawn points.
							<br/><br/>Do you want to show this message in the future?","Squad Leader Role","No","Yes"] call BIS_fnc_guiMessage;

				waituntil {!isnil "_answer" && !dialog};

				profileNamespace setVariable ["MCC_FCtutorialSQL",!_answer];
			};
		};

		//Logistics Trucks
		0 spawn {
			if (profileNamespace getVariable ["MCC_FCtutorialLogistics",true]) then {
				waituntil {typeof vehicle player in (missionNamespace getvariable ["MCC_supplyTracks",[]]) && !dialog && cameraOn == vehicle player};
				_answer = ["<img size='9' img image=" + format ["'%1mcc\helpers\data\PRlogistics.paa'", MCC_path] + " align='center'/>
							<br />While inside this vehicle and within 50 meters from HQ you can load logistics crates from the HQ and delieve them to the front.
							<br/><br/><t color='#FF6A32'>Ammo crates</t> will resupply units and vehicles.
							<br/><t color='#FF6A32'>Supply crates</t> will repair damaged vehicles and will be used to build FOB and battle emplacements.
							<br/><t color='#FF6A32'>Fuel crates</t> will refuel vehicles.
							<br/><br/>Press <t color='#FF6A32'>Interact</t> button to open the logistics dialog while in the driving seat and stopping next to the HQ.
							<br/><br/>Do you want to show this message in the future?","Logistics","No","Yes"] call BIS_fnc_guiMessage;

				waituntil {!isnil "_answer" && !dialog};

				profileNamespace setVariable ["MCC_FCtutorialLogistics",!_answer];
			};
		};

		//Logistics Helicopters
		0 spawn {
			if (profileNamespace getVariable ["MCC_FCtutorialLogisticsHeli",true]) then {
				waituntil {(vehicle player isKindOf "helicopter") && !dialog && cameraOn == vehicle player};
				_answer = ["<img size='9' img image=" + format ["'%1mcc\helpers\data\logisticsHeli.paa'", MCC_path] + " align='center'/>
							<br />While inside this vehicle and within 50 meters from HQ and flying higher then 15 meters you can <t color='#FF6A32'>slingload logistics crates</t> from the HQ and delieve them to the front.
							<br/><br/><t color='#FF6A32'>Ammo crates</t> will resupply units and vehicles.
							<br/><t color='#FF6A32'>Supply crates</t> will repair damaged vehicles and will be used to build FOB and battle emplacements.
							<br/><t color='#FF6A32'>Fuel crates</t> will refuel vehicles.
							<br/><br/>Press <t color='#FF6A32'>Interact</t> button to open the logistics dialog while autohovering over the HQ.
							<br/><br/>Do you want to show this message in the future?","Logistics Helicopters","No","Yes"] call BIS_fnc_guiMessage;

				waituntil {!isnil "_answer" && !dialog};

				profileNamespace setVariable ["MCC_FCtutorialLogisticsHeli",!_answer];
			};
		};
	};
};
