class MCC_rtsGroup_Transport
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\transport.paa";

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
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\fireTeam.paa";

	displayName = "Fire Team";
	descriptionShort = "A basic combat group";
	condition = "";
	requiredBuildings[] = {{"barracks",1}};
	unitsEast[] = {"CUP_O_RU_Soldier_TL_EMR","CUP_O_RU_Soldier_AR_EMR","CUP_O_RU_Soldier_AT_EMR","CUP_O_RU_Soldier_EMR"};
	unitsWest[] = {"CUP_B_BAF_Soldier_TL_MTP","CUP_B_BAF_Soldier_GL_MTP","CUP_B_BAF_Soldier_AR_MTP","CUP_B_BAF_Soldier_Marksman_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_GL"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",300},{"food",200},{"time",15}};
};

class MCC_rtsGroup_MG
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\ar.paa";

	displayName = "Machinegun Team";
	descriptionShort = "A heavy MG team";
	condition = "";
	requiredBuildings[] = {{"barracks",1}};
	unitsEast[] = {"CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_EMR"};
	unitsWest[] = {"CUP_B_BAF_Soldier_MG_MTP","CUP_B_BAF_Soldier_AMG_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_MG","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",400},{"food",100},{"time",15}};
};

class MCC_rtsGroup_AT
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\at.paa";

	displayName = "Anti-tank Team";
	descriptionShort = "A heavy Anti-tank team";
	condition = "";
	requiredBuildings[] = {{"barracks",2}};
	unitsEast[] = {"CUP_O_RU_Soldier_HAT_EMR","CUP_O_RU_Soldier_LAT_EMR"};
	unitsWest[] = {"CUP_B_BAF_Soldier_AT_MTP","CUP_B_BAF_Soldier_AAT_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AT","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",500},{"food",100},{"time",15}};
};

class MCC_rtsGroup_AA
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\aa.paa";

	displayName = "Anti-air Team";
	descriptionShort = "A heavy Anti-air team";
	condition = "";
	requiredBuildings[] = {{"barracks",2}};
	unitsEast[] = {"CUP_O_RU_Soldier_AA_EMR","CUP_O_RU_Soldier_AA_EMR"};
	unitsWest[] = {"CUP_B_BAF_Soldier_AA_MTP","CUP_B_BAF_Soldier_AAA_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AA","CUP_I_GUE_Ammobearer"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",600},{"food",100},{"time",15}};
};

class MCC_rtsGroup_platoon
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\platoon.paa";

	displayName = "Platoon";
	descriptionShort = "A full platoon";
	condition = "";
	requiredBuildings[] = {{"barracks",3}};
	unitsEast[] = {"CUP_O_RU_Soldier_SL_EMR","CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_AT_EMR","CUP_O_RU_Soldier_LAT_EMR","CUP_O_RU_Soldier_EMR","CUP_O_RU_Soldier_Marksman_EMR","CUP_O_RU_Medic_EMR"};
	unitsWest[] = {"CUP_B_BAF_Soldier_SL_MTP","CUP_B_BAF_Soldier_TL_MTP","CUP_B_BAF_Soldier_GL_MTP","CUP_B_BAF_Soldier_AR_MTP","CUP_B_BAF_Soldier_Marksman_MTP","CUP_B_BAF_Soldier_GL_MTP","CUP_B_BAF_Soldier_AR_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_GL","CUP_I_GUE_Medic","CUP_I_GUE_Ammobearer","CUP_I_GUE_Soldier_AT"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",700},{"food",350},{"time",15}};
};

class MCC_rtsGroup_sniper
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\sniper.paa";

	displayName = "Sniper Team";
	descriptionShort = "A sniper team";
	condition = "";
	requiredBuildings[] = {{"barracks",3}};
	unitsEast[] = {"CUP_O_RU_Sniper_EMR","CUP_O_RU_Spotter_EMR"};
	unitsWest[] = {"CUP_B_BAF_Sniper_MTP","CUP_B_BAF_Spotter_MTP"};
	unitsGuer[] = {"CUP_I_GUE_Sniper","CUP_I_GUE_Soldier_Scout"};
	needelectricity = 0;
	actions[] = {"MCC_rts_orderStop","","MCC_rts_orderStanceUp","MCC_rts_orderStanceDown","MCC_rts_orderPlaceSatchel","","MCC_rts_orderStealth","MCC_rts_orderAware","","","MCC_rts_takeControl","MCC_rts_respawnUnits"};
	actionFNC = "MCC_fnc_rtsCreateGroup";
	resources[] = {{"ammo",800},{"food",100},{"time",15}};
};

class MCC_rts_rtsBuildUIContainerBack
{
	picture = "\mcc_sandbox_mod\mcc\rts\data\back.paa";

	displayName = "Exit";
	descriptionShort = "Exit Fortifications Menu";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsBuildUIContainerBack";
	resources[] = {};
};