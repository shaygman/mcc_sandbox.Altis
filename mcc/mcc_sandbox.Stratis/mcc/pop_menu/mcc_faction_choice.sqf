MCC_faction_choice=true; 

// Load all possible groups from the config into the menu array format in arrays above
GEN_MECHANIZED 		= [mcc_sidename,mcc_faction,"Mechanized","LAND"] call mcc_make_array_grps;
GEN_MOTORIZED  		= [mcc_sidename,mcc_faction,"Motorized","LAND"]  call mcc_make_array_grps;
GEN_AIR        		= [mcc_sidename,mcc_faction,"Air","AIR"]         call mcc_make_array_grps;
GEN_ARMOR      		= [mcc_sidename,mcc_faction,"Armored","LAND"]    call mcc_make_array_grps;
GEN_INFANTRY   		= [mcc_sidename,mcc_faction,"Infantry","LAND"]   call mcc_make_array_grps;
GEN_SPECOPS   		= [mcc_sidename,mcc_faction,"SpecOps","WATER"]   call mcc_make_array_grps;
GEN_SUPPORT  		= [mcc_sidename,mcc_faction,"Support","LAND"]   call mcc_make_array_grps;

// Create the units
// Load the different units into the arrays above
U_GEN_SHIP 			= [];
U_GEN_AIRPLANE		= [];
U_GEN_HELICOPTER 	= [];
U_GEN_TANK 			= [];
U_GEN_MOTORCYCLE	= [];
U_GEN_CAR			= [];
U_GEN_SOLDIER    	= [];

call mcc_make_array_units;
//nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_units.sqf";

// Load DOC -> Dynamic Object Compositions

GEN_DOC1 = [];
GEN_DOC1 = [mcc_faction,0]  call mcc_make_array_comp;

if (!mcc_firstTime) then 
	{
	closeDialog 0;
	nul=[] execVM MCC_path + "mcc\Dialogs\mcc_PopupMenu.sqf";
	}
	else {mcc_firstTime=false}; //If it's not first time refresh the menu
