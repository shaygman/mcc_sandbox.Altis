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
	actions[] = {"MCC_rts_orderStop","MCC_rts_OrderGetout","MCC_rts_LoadResources","MCC_rts_UnLoadResources","MCC_rts_LoadResourcesWithdrawAmmo","MCC_rts_LoadResourcesWithdrawSupply","MCC_rts_LoadResourcesWithdrawFuel", "MCC_rts_takeControl"};
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
	unitsEast[] = {"O_Soldier_TL_F","O_soldier_AR_F","O_Soldier_GL_F","O_soldier_LAT_F"};
	unitsWest[] = {"B_Soldier_TL_F","B_soldier_AR_F","B_Soldier_GL_F","B_soldier_LAT_F"};
	unitsGuer[] = {"I_Soldier_TL_F","I_soldier_AR_F","I_Soldier_GL_F","I_soldier_LAT_F"};
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
	unitsEast[] = {"O_HeavyGunner_F","O_Soldier_A_F"};
	unitsWest[] = {"B_HeavyGunner_F","B_Soldier_A_F"};
	unitsGuer[] = {"I_soldier_AR_F","I_Soldier_A_F"};
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
	unitsEast[] = {"O_Soldier_AT_F","O_Soldier_AAT_F"};
	unitsWest[] = {"B_Soldier_AT_F","B_Soldier_AAT_F"};
	unitsGuer[] = {"I_Soldier_AT_F","I_Soldier_AAT_F"};
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
	unitsEast[] = {"O_Soldier_AA_F","O_Soldier_AAA_F"};
	unitsWest[] = {"B_Soldier_AA_F","B_Soldier_AAA_F"};
	unitsGuer[] = {"I_Soldier_AA_F","I_Soldier_AAA_F"};
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
	unitsEast[] = {"O_Soldier_SL_F","O_soldier_AR_F","O_Soldier_GL_F","O_soldier_AT_F","O_soldier_AAT_F","O_Soldier_A_F","O_medic_F"};
	unitsWest[] = {"B_Soldier_SL_F","B_soldier_AR_F","B_Soldier_GL_F","B_soldier_AT_F","B_soldier_AAT_F","B_Soldier_A_F","B_medic_F"};
	unitsGuer[] = {"I_Soldier_SL_F","I_soldier_AR_F","I_Soldier_GL_F","I_soldier_AT_F","I_soldier_AAT_F","I_Soldier_A_F","I_medic_F"};
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
	unitsEast[] = {"O_sniper_F","O_spotter_F"};
	unitsWest[] = {"B_sniper_F","B_spotter_F"};
	unitsGuer[] = {"I_sniper_F","I_spotter_F"};
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