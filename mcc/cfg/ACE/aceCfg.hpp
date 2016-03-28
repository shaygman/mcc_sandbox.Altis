#define MACRO_MCCACTIONS \
        class requestDropOff {\
		displayName = "Request<br/>Dropoff";\
		condition = "((_player in (assignedCargo  (vehicle _player))) && (_player == leader _player) && !isnull driver (vehicle _player)  && locked (vehicle _player) <2)";\
		statement = "[_target] spawn MCC_fnc_requestDropOff;";\
		icon = "\a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa";\
	    };\
	    class logistics {\
			displayName = "Logistics";\
			condition = " ((typeof (vehicle _player) in MCC_supplyTracks || ((vehicle _player) isKindOf 'helicopter' && ((getpos (vehicle _player)) select 2) > 15)) && (_player == driver (vehicle _player)) && (speed (vehicle _player) < 10) && (missionNamespace getVariable ['MCC_allowlogistics',true]))";\
			statement = "[_player] spawn MCC_fnc_loadTruckUI;";\
			icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa";\
	    };\
	    class artilleryComputer {\
			displayName = "Artillery<br/>Computer";\
			condition = "(getNumber (configfile >> 'CfgVehicles' >> typeof (vehicle _player) >> 'artilleryScanner') == 1)";\
			statement = "[(vehicle _player)] spawn MCC_fnc_openArtillery;";\
			icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa";\
	    };

class LandVehicle;
class Car: LandVehicle {
	class ACE_SelfActions {
			MACRO_MCCACTIONS
		};
  };
class Tank: LandVehicle {
	class ACE_SelfActions {
			MACRO_MCCACTIONS
		};
  };
class StaticWeapon: LandVehicle {
   class ACE_SelfActions {
			MACRO_MCCACTIONS
		};
  };

class Air;
class Helicopter: Air {
   class ACE_SelfActions {
			MACRO_MCCACTIONS
			class TAUReelPod {
				displayName = "Reel<br/>In";
				condition = "([_player] call MCC_fnc_canAttachPod)";
				statement = "(vehicle _player) spawn MCC_fnc_attachPod;";
				icon = "\A3\Ui_f\data\IGUI\Cfg\VehicleToggles\slingloadropeiconon_ca.paa";
		    };
		    class TAUReleasePod {
				displayName = "Drop<br/>Pod";
				condition = "(((vehicle _player) isKindOf 'O_Heli_Transport_04_F') && (_player == Driver (vehicle _player)) && !isnull((vehicle _player) getVariable ['MCC_attachedPod',objnull]))";
				statement = "(vehicle _player) spawn MCC_fnc_releasePod;";
				icon = "\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa";
		    };
		};
  };
class Plane: Air {
   class ACE_SelfActions {
			MACRO_MCCACTIONS
			class ILSStart {
				displayName = "ILS";
				condition = "(((vehicle _player) isKindOf 'Plane') && (_player == Driver (vehicle _player)))";
				statement = "";
				insertChildren = "(_this call MCC_fnc_addILSChildrenACE)";
				icon = "\a3\ui_f\data\IGUI\Cfg\Actions\landingautopilot_on_ca.paa";
			 };
			class ILSCancel {
						displayName = "Abort<br/>ILS";
						condition = "!(_player getVariable ['MCC_ILSAbort',true])";
						statement = "_player setVariable ['MCC_ILSAbort',true];";
						icon = "\a3\ui_f\data\IGUI\Cfg\Actions\landingautopilot_off_ca.paa";
			 };
		};
};

class Ship;
class Ship_F: Ship {
   class ACE_SelfActions {
			MACRO_MCCACTIONS
		};
	};

class thingX;
class ReammoBox_F: thingX {
	class ACE_Actions {
	  class ACE_MainActions {
	    class ACE_MCC_mainBox {
                displayName = "Open<br/>Vault";
                distance = 5;
                condition = "(_target isKindof 'Box_FIA_Support_F') && (!(_target getVariable ['mcc_mainBoxUsed', false])) && !(isNull attachedTo _target) && (missionNamespace getVariable ['MCC_surviveMod',false])";
                statement =  "[_target] spawn MCC_fnc_mainBoxOpen";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
                showDisabled = 0;
                priority = 1.2;
            };

        class ACE_MCC_changeKit {
                displayName = "Change<br/>Kit";
                distance = 5;
                condition = "(_target isKindof 'Box_FIA_Support_F') && (!(_target getVariable ['mcc_mainBoxUsed', false])) && !(isNull attachedTo _target) && (missionNamespace getVariable ['CP_activated',false]) && !(missionNamespace getVariable ['MCC_surviveMod',false])";
                statement =  "createDialog 'CP_GEARPANEL'";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
                showDisabled = 0;
                priority = 1.2;
            };

        class ACE_MCC_supplyBoxFOB {
                displayName = "Resupply";
                distance = 5;
               condition = "(_target isKindof 'Box_FIA_Support_F') && !(isNull attachedTo _target)";
                statement =  "[_target,true] call MCC_fnc_resupply;";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
                showDisabled = 0;
        };

        class ACE_MCC_supplyBox {
                displayName = "Resupply";
                distance = 5;
                condition = "(typeof _target in ['MCC_ammoBox','MCC_crateAmmo','MCC_crateAmmoBigWest','MCC_crateAmmoBigEast','Box_NATO_AmmoVeh_F','B_Slingload_01_Ammo_F','Land_Pod_Heli_Transport_04_ammo_F'])";
                statement =  "[_target] call MCC_fnc_resupply;";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
                showDisabled = 0;
                priority = 1.2;
            };

        class ACE_MCC_supplyBoxBreakDown {
                displayName = "Breakdown<br/>Box";
                distance = 5;
                condition = "(typeof _target in ['MCC_crateAmmo','MCC_crateSupply','MCC_crateFuel'])";
                statement =  "[_target] call MCC_fnc_breakdown;";
                icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
                showDisabled = 0;
                priority = 1.2;
            };
	  };
	};
	class ACE_SelfActions {};
};



class Man;
class CAManBase: Man {
    class ACE_Actions {
    	class ACE_MainActions {
            class ACE_MCC_haltAI {
                displayName = "Halt";
                distance = 15;
                condition = "([_target] call MCC_fnc_canHaltAI)";
                statement =  "[_target] spawn MCC_fnc_doHaltAI";
                exceptions[] = {};
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa";
                showDisabled = 0;
                priority = 1.2;
            };
         };
    };
	class ACE_SelfActions {
		class ACE_MCC_CommanderTab {
			condition = "((MCC_server getVariable [format ['CP_commander%1',playerside],'']) == getPlayerUID _player) && (missionNamespace getVariable ['MCC_allowConsole',true])";
			displayName = "Commander<br/>Tab";
			icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
			statement = "_null = [nil,nil,nil,nil,1] execVM '\mcc_sandbox_mod\mcc\dialogs\mcc_PopupMenu.sqf';";
			showDisabled = 0;
		};

		class ACE_MCC_DropAmmobox {
			condition = "('MCC_ammoBoxMag' in items _player)";
			displayName = "Drop<br/>Ammobox";
			icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
			statement = "['MCC_ammoBoxMag','MCC_ammoBox'] spawn MCC_fnc_ACEdropAmmobox;";
			showDisabled = 0;
		};

		class ACE_MCC_doorinteraction {
			condition = "([cursorTarget] call MCC_fnc_isDoor) != ''";
			displayName = "Door<br/>Interaction";
			icon = "\a3\ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa";
			showDisabled = 0;

			class ACE_MCC_door_breach {
				displayName = "Breaching<br/>Charge";
				condition = "'ClaymoreDirectionalMine_Remote_Mag' in magazines _player";
				icon = "\A3\Weapons_F\Data\UI\gear_mine_AP_miniclaymore_CA.paa";
				statement = "[cursorTarget] spawn MCC_fnc_doorBreach;";
			};

			class ACE_MCC_door_check {
				displayName = "Check<br/>Door";
				icon = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";
				statement = "[cursorTarget] spawn MCC_fnc_checkDoor;";
			};

			class ACE_MCC_door_unlock {
				displayName = "Pick<br/>Lock";
				condition = "(({_x in items _player} count ['ACE_DefusalKit','ACE_key_lockpick','MCC_multiTool'])!=0) && (([cursorTarget] call MCC_fnc_isDoorLocked)==1)";
				icon = "\z\ace\addons\vehiclelock\ui\lockpick.paa";
				statement = "[cursorTarget] spawn MCC_fnc_doorUnlock;";
			};

			class ACE_MCC_door_lock {
				displayName = "Wedge<br/>Door";
				condition = "(({_x in items _player} count ['ACE_DefusalKit','ACE_key_lockpick','MCC_multiTool'])!=0) && (([cursorTarget] call MCC_fnc_isDoorLocked)==2)";
				icon = "\A3\ui_f\data\map\groupicons\waypoint.paa";
				statement = "[cursorTarget] spawn MCC_fnc_doorLock;";
			};

			class ACE_MCC_door_mirror {
				displayName = "Mirror<br/>Under";
				condition = "(({_x in items _player} count ['MineDetector','MCC_videoProbe'])!=0)";
				icon = "\a3\ui_f\data\IGUI\Cfg\Actions\ladderdown_ca.paa";
				statement = "[cursorTarget] spawn MCC_fnc_doorCamera;";
			};
		};

		class ACE_MCC_survivalInteraction {
			displayName = "Search";
			condition = "[] call MCC_fnc_isSurvivalObject";
			icon = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";
			showDisabled = 0;
			statement = "[] spawn MCC_fnc_searchSurvivalObject;";
		};

		class ACE_MCC_miniGameDefuse {
            displayName = "Bomb Defuse";
            condition ="((cursorTarget getVariable ['realIed',objnull]) getVariable ['MCC_isIEDMiniGame',false]) && ((cursorTarget getVariable ['realIed',objnull]) getVariable ['armed',false]) && (_player distance cursorTarget < 8)";
            statement = "[cursorTarget] spawn MCC_fnc_bdStart";
            showDisabled = 0;
            icon = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";
        };

		class ACE_MCC_SQLMenu {
			condition = "(leader _player == _player && count units _player > 1 && (missionNameSpace getvariable ['MCC_allowsqlPDA',true]))";
			displayName = "SQL<br/>Menu";
			icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
			showDisabled = 0;

			class ACE_MCC_openSQLPDA {
				displayName = "Oped<br/>PDA";
				icon = "\A3\Ui_f\data\IGUI\Cfg\VehicleToggles\wheelbreakiconon_ca.paa";
				statement = "_null = [nil,nil,nil,nil,3] execVM '\mcc_sandbox_mod\mcc\dialogs\mcc_PopupMenu.sqf';";
			};

			class ACE_MCC_spotEnemy {
				displayName = "Spot<br/>Enemy";
				icon = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

				class ACE_MCC_infantry {
					displayName = "Infantry";
					icon = "\A3\ui_f\data\map\markers\nato\o_inf.paa";
					statement = "uinamespace setVariable ['MCC_interactionMenu1Data', 'inf']";
					runOnHover = 2;
					class fire_team {
						displayName = "Fire Team";
						icon = "\A3\ui_f\data\map\markers\nato\group_0.paa";
						statement = "['Fire Team'] call MCC_fnc_spotEnemy";
					};
					class Squad {
						displayName = "Squad";
						icon = "\A3\ui_f\data\map\markers\nato\group_1.paa";
						statement = "['Squad'] call MCC_fnc_spotEnemy";
					};
					class Section {
						displayName = "Section";
						icon = "\A3\ui_f\data\map\markers\nato\group_2.paa";
						statement = "['Section'] call MCC_fnc_spotEnemy";
					};
					class Platoon {
						displayName = "Platoon";
						icon = "\A3\ui_f\data\map\markers\nato\group_3.paa";
						statement = "['Platoon'] call MCC_fnc_spotEnemy";
					};
				};
				class ACE_MCC_motorized {
					displayName = "Motorized";
					icon = "\A3\ui_f\data\map\markers\nato\o_motor_inf.paa";
					statement = "['motorized'] call MCC_fnc_spotEnemy";
				};
				class ACE_MCC_armor {
					displayName = "Armor";
					icon = "\A3\ui_f\data\map\markers\nato\o_armor.paa";
					statement = "['armor'] call MCC_fnc_spotEnemy";
				};
				class ACE_MCC_air {
					displayName = "Air";
					icon = "\A3\ui_f\data\map\markers\nato\o_air.paa";
					statement = "['air'] call MCC_fnc_spotEnemy";
				};
				class ACE_MCC_naval {
					displayName = "Naval";
					icon = "\A3\ui_f\data\map\markers\nato\o_naval.paa";
					statement = "['naval'] call MCC_fnc_spotEnemy";
				};
				class ACE_MCC_art {
					displayName = "Artillery";
					icon = "\A3\ui_f\data\map\markers\nato\o_art.paa";
					statement = "['art'] call MCC_fnc_spotEnemy";
				};
				class ACE_MCC_Mine {
					displayName = "Minefield";
					icon = "\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa";
					statement = "['minefield'] call MCC_fnc_spotEnemy";
				};
			};
			class ACE_MCC_callSupport {
				displayName = "Call<br/>Support";
				icon = "\a3\ui_f\data\gui\cfg\CommunicationMenu\call_ca.paa";

				class ACE_MCC_CAS {
					displayName = "CAS";
					icon = "\a3\ui_f\data\gui\cfg\CommunicationMenu\cas_ca.paa";
					statement = "['cas'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_transport {
					displayName = "Transport";
					icon = "\A3\ui_f\data\map\markers\military\pickup_CA.paa";
					statement = "['transport'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_areaAttack {
					displayName = "Area<br/>Attack";
					icon = "\a3\ui_f\data\gui\cfg\CommunicationMenu\artillery_ca.paa";
					statement = "['areaAttack'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_Support {
					displayName = "Support";
					icon = "\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa";
					statement = "['support'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_medic {
					displayName = "Medic";
					icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
					statement = "['medic'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_ammo {
					displayName = "Ammo";
					icon = "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa";
					statement = "['ammo'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_repair {
					displayName = "Repairs";
					icon = "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
					statement = "['repair'] call MCC_fnc_callSupport";
				};
				class ACE_MCC_fuel {
					displayName = "Fuel";
					icon = "\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa";
					statement = "['fuel'] call MCC_fnc_callSupport";
				};
			};
			class ACE_MCC_callConstruct {
				condition = "(missionNameSpace getvariable ['MCC_allowlogistics',true])";
				displayName = "Construct";
				icon = "\a3\ui_f\data\IGUI\Cfg\Actions\getincommander_ca.paa";

				class ACE_MCC_FOB {
					displayName = "F.O.B";
					icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
					statement = "['fob'] call MCC_fnc_callConstruct";
				};
				class ACE_MCC_Bunker {
					displayName = "Bunker";
					icon = "\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa";
					statement = "['bunker'] call MCC_fnc_callConstruct";
				};

				class ACE_MCC_wall {
					displayName = "Beg Fence";
					icon = "\A3\ui_f\data\map\mapcontrol\Stack_CA.paa";
					statement = "['wall'] call MCC_fnc_callConstruct";
				};

				class ACE_MCC_HMG {
					displayName = "HMG";
					icon = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_MG_CA.paa";
					statement = "['hmg'] call MCC_fnc_callConstruct";
				};
				class ACE_MCC_GMG {
					displayName = "GMG";
					icon = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
					statement = "['gmg'] call MCC_fnc_callConstruct";
				};
				class ACE_MCC_AT {
					displayName = "AT";
					icon = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_AT_CA.paa";
					statement = "['at'] call MCC_fnc_callConstruct";
				};
				class ACE_MCC_AA {
					displayName = "AA";
					icon = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_AA_CA.paa";
					statement = "['aa'] call MCC_fnc_callConstruct";
				};
				class ACE_MCC_mortar {
					displayName = "Mortar";
					icon = "\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa";
					statement = "['mortar'] call MCC_fnc_callConstruct";
				};
			};
		};
	};
};