//===============================================================MCC_fnc_CBAKeybinds===================================================================================
// Handle CBA keybinds
//=====================================================================================================================================================================
//MCC
["MCC", "openMCC", ["Open MCC", "Open MCC main console"], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[nil,nil,nil,nil,0] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];true}}, {}, [211, [false,true,false]],false] call cba_fnc_addKeybind;

//Commander console
["MCC", "commanderConsole", ["Commander Console", "Player must be its side's commander"], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[nil,nil,nil,nil,1] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];true}}, {}, [207, [false,true,false]],false] call cba_fnc_addKeybind;

//T2T
["MCC", "t2t", ["Teleport to Team", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[objNull] execVM format["%1mcc\general_scripts\mcc_SpawnToPosition.sqf",MCC_path];true}}, {}, [20, [false,false,true]],false] call cba_fnc_addKeybind;

//Squad dialog
["MCC", "squadDialog", ["Squad Management", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[nil,nil,nil,nil,2] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];true}}, {}, [25, [false,false,false]],false] call cba_fnc_addKeybind;

//SQL PDA
["MCC", "sqlPDA", ["Squad Leader PDA", "Player must be team leader"], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[nil,nil,nil,nil,3] execVM format ["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];true}}, {}, [209, [false,true,false]],false] call cba_fnc_addKeybind;

//Interaction
["MCC", "interactionKey", ["Interaction", "Interact with objects/units in MCC"], {if (missionNameSpace getVariable ["MCC_interaction",false] && (isnull curatorcamera)) then {[false] call MCC_fnc_CBAInteractionKeybind}}, {[true] call MCC_fnc_CBAInteractionKeybind}, [219, [false,false,false]],false] call cba_fnc_addKeybind;

//Self Interaction
["MCC", "selfInteraction", ["Interaction Self", ""], {if ((missionNameSpace getVariable ["MCC_interaction",false]) && (player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (isnull curatorcamera)) then {[player] spawn MCC_fnc_interactSelf;true}}, {(uiNamespace getVariable ["MCC_INTERACTION_MENU",displayNull]) closeDisplay 1;MCC_interactionKey_down = false;true}, [219, [false,true,false]],false] call cba_fnc_addKeybind;

//Vault
["MCC", "vaultOver", ["Climb Over", "Climb over obstacles"], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (missionNameSpace getVariable ["MCC_coverVault",true]) && !(player getVariable ["MCC_vaultOver",false]) && (player getVariable ["MCC_wallAhead",""]) != "" && (isnull curatorcamera)) then {[] spawn MCC_fnc_vault;true}}, {}, [47, [false,false,true]],false] call cba_fnc_addKeybind;

//Switch weapon 1 - Primary/handgun
["MCC", "switchWeapon1", ["Switch Weapons 1: Primary/handgun", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (missionNamespace getvariable ["MCC_quickWeaponChange",false])) then {[2] spawn MCC_fnc_weaponSelect;true}}, {}, [2, [true,false,false]],false] call cba_fnc_addKeybind;

//Switch weapon 2 - Launcher
["MCC", "switchWeapon2", ["Switch Weapons 2: Launcher", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (missionNamespace getvariable ["MCC_quickWeaponChange",false])) then {[3] spawn MCC_fnc_weaponSelect;true}}, {}, [3, [true,false,false]],false] call cba_fnc_addKeybind;

//Switch weapon 3 - Grenade
["MCC", "switchWeapon3", ["Switch Weapons 3: Grenades", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (missionNamespace getvariable ["MCC_quickWeaponChange",false])) then {[4] spawn MCC_fnc_weaponSelect;true}}, {}, [4, [true,false,false]],false] call cba_fnc_addKeybind;

//Switch weapon 4 - Primary/handgun
["MCC", "switchWeapon4", ["Switch Weapons 4: Utility", ""], {if ((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]) && (missionNamespace getvariable ["MCC_quickWeaponChange",false])) then {[5] spawn MCC_fnc_weaponSelect;true}}, {}, [5, [true,false,false]],false] call cba_fnc_addKeybind;
