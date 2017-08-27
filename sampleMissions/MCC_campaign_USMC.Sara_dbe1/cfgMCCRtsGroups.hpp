class MCC_rtsGroup_Transport
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\transport.paa";
	#else
	picture = "mcc\rts\data\groups\transport.paa";
	#endif

	displayName = "Resources Transport";
	descriptionShort = "A basic truck to mobilize resources";
	condition = "";
	requiredBuildings[] = {{"barracks",1}};
	unitsEast[] = {"O_Truck_03_transport_F"};
	unitsWest[] = {"B_Truck_01_transport_F"};
	unitsGuer[] = {"I_Truck_02_transport_F"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","MCC_rts_OrderGetout","MCC_rts_LoadResources","MCC_rts_UnLoadResources","","","","",""};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",30},{"repair",30},{"fuel",15},{"food",100},{"time",15}};
};

class MCC_rtsGroup_FT
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\fireTeam.paa";
	#else
	picture = "mcc\rts\data\groups\fireTeam.paa";
	#endif

	displayName = "Fire Team";
	descriptionShort = "A basic combat group";
	condition = "";
	requiredBuildings[] = {{"barracks",1}};
	unitsEast[] = {"CUP_O_RU_Soldier_TL_EMR","CUP_O_RU_Soldier_AR_EMR","CUP_O_RU_Soldier_AT_EMR","CUP_O_RU_Soldier_EMR"};
	unitsWest[] = {"CUP_B_USMC_Soldier_TL","CUP_B_USMC_Soldier_AR","CUP_B_USMC_Soldier_AT","CUP_B_USMC_Soldier_LAT"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_GL"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",300},{"food",200},{"time",15}};
};

class MCC_rtsGroup_MG
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\ar.paa";
	#else
	picture = "mcc\rts\data\groups\ar.paa";
	#endif

	displayName = "Machinegun Team";
	descriptionShort = "A heavy MG team";
	condition = "";
	requiredBuildings[] = {{"barracks",1}};
	unitsEast[] = {"CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_EMR"};
	unitsWest[] = {"CUP_B_USMC_Soldier_AR","CUP_B_USMC_Soldier_AR"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_MG","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",400},{"food",100},{"time",15}};
};

class MCC_rtsGroup_AT
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\at.paa";
	#else
	picture = "mcc\rts\data\groups\at.paa";
	#endif

	displayName = "Anti-tank Team";
	descriptionShort = "A heavy Anti-tank team";
	condition = "";
	requiredBuildings[] = {{"barracks",2}};
	unitsEast[] = {"CUP_O_RU_Soldier_HAT_EMR","CUP_O_RU_Soldier_LAT_EMR"};
	unitsWest[] = {"CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_AT"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AT","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",500},{"food",100},{"time",15}};
};

class MCC_rtsGroup_AA
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\aa.paa";
	#else
	picture = "mcc\rts\data\groups\aa.paa";
	#endif

	displayName = "Anti-air Team";
	descriptionShort = "A heavy Anti-air team";
	condition = "";
	requiredBuildings[] = {{"barracks",2}};
	unitsEast[] = {"CUP_O_RU_Soldier_AA_EMR","CUP_O_RU_Soldier_AA_EMR"};
	unitsWest[] = {"CUP_B_USMC_Soldier_AA","CUP_B_USMC_Soldier_AA"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AA","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",600},{"food",100},{"time",15}};
};

class MCC_rtsGroup_platoon
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\platoon.paa";
	#else
	picture = "mcc\rts\data\groups\platoon.paa";
	#endif

	displayName = "Platoon";
	descriptionShort = "A full platoon";
	condition = "";
	requiredBuildings[] = {{"barracks",3}};
	unitsEast[] = {"CUP_O_RU_Soldier_SL_EMR","CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_AT_EMR","CUP_O_RU_Soldier_LAT_EMR","CUP_O_RU_Soldier_EMR","CUP_O_RU_Soldier_Marksman_EMR","CUP_O_RU_Medic_EMR"};
	unitsWest[] = {"CUP_B_USMC_Soldier_TL","CUP_B_USMC_Soldier_AR","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_Soldier","CUP_B_USMC_SpecOps","CUP_B_USMC_Soldier_Marksman","CUP_B_USMC_Medic"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_GL","CUP_I_GUE_Medic","CUP_I_GUE_Ammobearer","CUP_I_GUE_Soldier_AT"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",700},{"food",350},{"time",15}};
};

class MCC_rtsGroup_sniper
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\sniper.paa";
	#else
	picture = "mcc\rts\data\groups\sniper.paa";
	#endif

	displayName = "Sniper Team";
	descriptionShort = "A sniper team";
	condition = "";
	requiredBuildings[] = {{"barracks",3}};
	unitsEast[] = {"CUP_O_RU_Sniper_EMR","CUP_O_RU_Spotter_EMR"};
	unitsWest[] = {"CUP_B_USMC_Sniper_M107","CUP_B_USMC_Spotter"};
	unitsGuer[] = {"CUP_I_GUE_Sniper","CUP_I_GUE_Soldier_Scout"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",800},{"food",100},{"time",15}};
};

class MCC_rts_rtsBuildUIContainerBack
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\back.paa";
	#else
	picture = "mcc\rts\data\back.paa";
	#endif

	displayName = "Exit";
	descriptionShort = "Exit Fortifications Menu";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsBuildUIContainerBack";
	resources[] = {};
};