// init popup menu functions to fill up the menu
mcc_make_array_grps 		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_grps.sqf",MCC_path];
mcc_make_array_comp 		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_comp.sqf",MCC_path];
mcc_factions                = compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_factions.sqf",MCC_path];
mcc_fnc_faction_choice		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_faction_choice.sqf",MCC_path];
mcc_make_array_units		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_units.sqf",MCC_path];

private "_nul";
_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_markers.sqf";
_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_obj.sqf";
_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_weaponsNoneAce.sqf";

dummy =[] call mcc_factions;

// Load the different units into the arrays above
U_GEN_SHIP 			= [];
U_GEN_AIRPLANE		= [];
U_GEN_HELICOPTER 	= [];
U_GEN_TANK 			= [];
U_GEN_MOTORCYCLE	= [];
U_GEN_CAR			= [];
U_GEN_SOLDIER    	= [];

mcc_sidename =(U_FACTIONS select 0) select 1;
mcc_faction = (U_FACTIONS select 0) select 2;
[] call mcc_fnc_faction_choice;
waituntil {(MCC_unit_array_ready)};

if (true) exitWith {};

