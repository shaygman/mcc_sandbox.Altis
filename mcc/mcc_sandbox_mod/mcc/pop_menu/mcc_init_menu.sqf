// init popup menu functions to fill up the menu
mcc_make_array_grps 		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_grps.sqf",MCC_path];
mcc_make_array_comp 		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_comp.sqf",MCC_path];
mcc_factions                = compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_factions.sqf",MCC_path];
mcc_fnc_faction_choice		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_faction_choice.sqf",MCC_path];
mcc_make_array_units		= compile preProcessFileLineNumbers format ["%1mcc\pop_menu\mcc_make_array_units.sqf",MCC_path];
nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_markers.sqf";

dummy =[] call mcc_factions;

// Load the different units into the arrays above
U_GEN_SHIP 			= [];
U_GEN_AIRPLANE		= [];
U_GEN_HELICOPTER 	= [];
U_GEN_TANK 			= [];
U_GEN_MOTORCYCLE	= [];
U_GEN_CAR			= [];
U_GEN_SOLDIER    	= [];

/* NOT USED AT ALL ????????????????
// Load DOC -> Dynamic Object Compositions
USMC_DOC1	     		= ["USMC",0] call mcc_make_array_comp;
USMC_DOC2	     		= ["USMC",20] call mcc_make_array_comp;
USMC_DOC3	     		= ["USMC",40] call mcc_make_array_comp;
USMC_DOC4	     		= ["USMC",60] call mcc_make_array_comp;
USMC_DOC5	     		= ["USMC",80] call mcc_make_array_comp;
USMC_DOC6	     		= ["USMC",100] call mcc_make_array_comp;
RU_DOC  	     		= ["RU",0]   call mcc_make_array_comp;
INS_DOC	     	     	= ["ins",0]  call mcc_make_array_comp;
CDF_DOC	     	     	= ["CDF",0]  call mcc_make_array_comp;
GUE_DOC	     	     	= ["gue",0]  call mcc_make_array_comp;
BIS_US	     	     	= ["BIS_US",0]  call mcc_make_array_comp;
BIS_TK	     	     	= ["BIS_TK",0]  call mcc_make_array_comp;
BIS_CZ	     	     	= ["BIS_CZ",0]  call mcc_make_array_comp;
BIS_TK_GUE	     	    = ["BIS_TK_GUE",0]  call mcc_make_array_comp;
BIS_TK_INS	     	    = ["BIS_TK_INS",0]  call mcc_make_array_comp;
*/

MCCFirstOpenUI = false; 
mcc_sidename =(U_FACTIONS select 0) select 1;
mcc_faction = (U_FACTIONS select 0) select 2;
[] call mcc_fnc_faction_choice;
waituntil {(MCC_unit_array_ready)};

