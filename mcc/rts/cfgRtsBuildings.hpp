class MCC_rts_hq1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\hq.paa";
	#else
	picture = "mcc\rts\data\hq.paa";
	#endif

	displayName = "HQ";
	descriptionShort = "Basic short range radio H.Q allows scan for basic missions nearby";
	anchorType = "Land_TBox_F";
	requiredBuildings[] = {};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_hq2"};
	buildings[] = {"MCC_rts_barracks1","MCC_rts_house1","MCC_rts_workshop1","MCC_rts_triage1","MCC_rts_tradePost1"};
	actions[] = {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsFortUIContainer","MCC_rts_addArtilleryAmmo","","MCC_rts_scanResourcesBasic","","MCC_rts_scanResourcesCancel",""};
	fortifications[] = {"MCC_rts_fortSandbagLong","MCC_rts_fortSandbagRound","MCC_rts_fortRazorwire"};
	constType = "hq";
	level = 1;
	resources[] = {};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] = {{"Land_PowerGenerator_F", {-2.6,0,-1},{{0,1,0},{0,0,1}}},{"Land_cargo_addon01_V1_F", {3.36,0.5,-1.5},{{-1,0,0},{0,0,1}}},{"CamoNet_INDP_open_Curator_F", {0,0,0},{{0,1,0},{0,0,1}}},{"Land_TableDesk_F", {2.2,0.5,-1.5},{{1,0,0},{0,0,1}}},{"Land_Camping_Light_F", {2.2,1,-1},{{1,0,0},{0,0,1}}},{"Land_ChairWood_F", {2.8,0.5,-1.8},{{1,0,0},{0,0,1}}},{"Land_Map_altis_F", {2.2,0.5,-1.08},{{1,0,0},{0,0,1}}},{"Box_FIA_Support_F",{0,-3,-0.4},{{0,1,0},{0,0,1}}}};
};

class MCC_rts_hq2 : MCC_rts_hq1
{
	displayName = "Radio Post";
	descriptionShort = "Long range radio post allows scan for more advanced missions and access to supply drops requests.";
	anchorType = "Land_Slum_House03_F";
	requiredBuildings[] = {{"workshop",2},{"barracks",1},{"elecPower",1}};
	needelectricity = 1;
	upgradeTo[] = {"MCC_rts_hq3"};
	actions[] = {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsFortUIContainer","MCC_rts_addArtilleryAmmo","","MCC_rts_scanResourcesBasic","MCC_rts_scanResourcesAdvanced","","MCC_rts_scanResourcesCancel"};
	level = 2;
	resources[] = {{"ammo",200},{"repair",500},{"food",300},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] = {{"Land_PowerGenerator_F", {5,0,-0.3},{{0,1,0},{0,0,1}}},{"Land_TTowerSmall_1_F", {5,2,6},{{0,1,0},{0,0,1}}},{"Land_TableDesk_F", {4,2,-0.8},{{-1,0,0},{0,0,1}}},{"Land_Camping_Light_F", {4,2.5,-0.3},{{1,0,0},{0,0,1}}},{"Land_Metal_rack_F", {1,2.8,-0.2},{{0,1,0},{0,0,1}}},{"Land_ChairWood_F", {3.5,2,-1.15}, {{-1,0,0},{0,0,1}}},{"Land_Laptop_unfolded_F", {4,2,-0.23},{{-1,0,0},{0,0,1}}},{"Land_Map_altis_F", {4.3,0,1},{{0,-1,0},{-1,0,0}}},{"Land_WaterCooler_01_old_F", {4,0.8,-0.4},{{1,0,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {0,2,-1.05},{{-1,0,0},{0,0,1}}},{"Land_LuggageHeap_01_F", {-2.2,2.6,-0.65},{{1,0,0},{0,0,1}}},{"Land_WaterCooler_01_old_F", {4,0.8,-0.4},{{1,0,0},{0,0,1}}},{"CamoNet_BLUFOR_open_Curator_F", {0,0,1},{{0,1,0},{0,0,1}}},{"Box_FIA_Support_F",{0,-3,0},{{0,1,0},{0,0,1}}}};
};

class MCC_rts_hq3 : MCC_rts_hq2
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\satcom.paa";
	#else
	picture = "mcc\rts\data\satcom.paa";
	#endif

	displayName = "Sat-Comms";
	descriptionShort = "Sat-Comms allows scan for more advanced missions and access to supply drops and CAS requests.";
	anchorType = "Land_Cargo_HQ_V1_F";
	requiredBuildings[] = {{"workshop",3},{"barracks",2},{"elecPower",2}};
	needelectricity = 1;
	upgradeTo[] = {};
	level = 3;
	resources[] = {{"ammo",400},{"repair",700},{"food",500},{"time",0}};
	objectsArray[] = {{"Land_TableDesk_F", {-1,-6,-2.8},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F", {-0.5,-6,-2.27},{{1,0,0},{0,0,1}}},{"Land_Rack_F", {-3,-6,-2.35},{{-1,0,0},{0,0,1}}},{"Land_WaterCooler_01_new_F", {0.5,-6,-2.4},{{0,-1,0},{0,0,1}}},{"Land_Laptop_unfolded_F", {-1,-6,-2.23},{{0,1,0},{0,0,1}}},{"Land_Map_altis_F", {-1,-6.5,-1.5},{{-1,0,0},{0,1,0}}},{"Land_PaperBox_open_full_F", {6,2,-2.8},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {3,0,-2.8},{{0,1,0},{0,0,1}}},{"Land_CampingChair_V2_F", {-1,-5.6,-2.8},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_folded_F", {0,3,-3.2},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {-1,2,-3.25},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {-3,2,-3.25},{{0,1,0},{0,0,1}}},{"Land_Communication_F", {3,-6,12.5},{{1,1,0},{0,0,1}}},{"Box_FIA_Support_F",{-7,0,-3},{{0,1,0},{0,0,1}}}};
};

//storage
class MCC_rts_storage1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\storage.paa";
	#else
	picture = "mcc\rts\data\storage.paa";
	#endif

	displayName = "Storage Area";
	descriptionShort = "Increase storage capacity for all key resources by 500 (Food, Medicine, Building Materials, Ammunition and Fuel).";
	anchorType = "Land_cargo_addon02_V2_F";
	actions[] = {"","","","","","","","","","","","MCC_rts_destroyLogic"};
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_storage2"};
	constType = "storage";
	level = 1;
	resources[] = {{"repair",200},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] = {{"Land_PaperBox_open_full_F", {2,1,0},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {0,1,-0.1},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {-2,1,-0.1},{{0,1,0},{0,0,1}}},{"Land_WaterBarrel_F", {1,-1,0},{{0,1,0},{0,0,1}}},{"Land_Sacks_heap_F", {-1,-1,-0.2},{{0,1,0},{0,0,1}}}};
};

class MCC_rts_storage2 : MCC_rts_storage1
{
	displayName = "Advanced Storage Area";
	descriptionShort = "Increase storage capacity for all key resources by 1,000 and reduces food spoilage chance.";
	anchorType = "Land_u_Addon_01_V1_F";
	requiredBuildings[] = {{"workshop",2}};
	needelectricity = 1;
	upgradeTo[] = {"MCC_rts_storage3"};
	constType = "storage";
	level = 2;
	resources[] = {{"repair",300},{"time",0}};
	objectsArray[] = {{"Land_WaterTank_F", {3.5,2,0.6},{{1,0,0},{0,0,1}}},{"Land_WaterTank_F", {5,2,0.6},{{1,0,0},{0,0,1}}},{"Land_PaperBox_open_full_F", {2,3,0.5},{{1,0,0},{0,0,1}}},{"Land_PaperBox_open_full_F", {0,3,0.5},{{1,0,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {0,1.5,0.4},{{1,0,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {2,1.5,0.4},{{1,0,0},{0,0,1}}}};
};

class MCC_rts_storage3 : MCC_rts_storage1
{
	displayName = "Greater Storage Area";
	descriptionShort = "Increase storage capacity for all key resources by 1,500 and dramatically reduces food spoilage chance.";
	anchorType = "CamoNet_BLUFOR_Curator_F";
	requiredBuildings[] = {{"workshop",2}};
	needelectricity = 1;
	upgradeTo[] = {};
	constType = "storage";
	level = 3;
	resources[] = {{"repair",400},{"time",0}};
	objectsArray[] = {{"Land_PaperBox_open_full_F", {3,0,-0.7},{{0,1,0},{0,0,1}}},{"Land_PaperBox_open_full_F", {5,0,-0.7},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {1,0,-0.9},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {1,-2,-0.9},{{0,1,0},{0,0,1}}},{"Land_Pallet_MilBoxes_F", {4,-2,-0.9},{{0,1,0},{0,0,1}}},{"Land_PaperBox_open_full_F", {-2,-2,-0.7},{{0,1,0},{0,0,1}}},{"Land_Sacks_heap_F", {-1,0,-0.8},{{0,1,0},{0,0,1}}},{"Land_Sacks_heap_F", {-4,-1,-0.8},{{1,0,0},{0,0,1}}},{"Land_Tank_rust_F", {8.5,0,0},{{1,0,0},{0,0,1}}}};
};

//--------------- Barracks --------------------
class MCC_rts_barracks1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\RTS_iconBarracks1.paa";
	#else
	picture = "mcc\rts\data\RTS_iconBarracks1.paa";
	#endif

	displayName = "Shooting Range - Basic";
	descriptionShort = "A basic shooting range enable training troops";
	fortifications[] = {"MCC_rts_target3","MCC_rts_target2","MCC_rts_target1","MCC_rts_targetHostage"};
	groups[] = {"MCC_rtsGroup_Transport","MCC_rtsGroup_FT","MCC_rtsGroup_MG"};
	actions[] = {"MCC_rts_rtsUnitsUIContainer","MCC_rts_rtsFortUIContainer","","","","","","","","","","MCC_rts_destroyLogic"};
	anchorType = "CamoNet_INDP_open_Curator_F";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_barracks2"};
	constType = "barracks";
	level = 1;
	resources[] = {{"repair",100},{"food",200},{"med",100},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"ShootingPos_F", {3,0,-1},{{0,0,0},{0,0,0}}},{"ShootingPos_F", {0,0,-1}, {{0,0,0},{0,0,0}}},{"ShootingPos_F", {-3,0,-1},{{0,0,0},{0,0,0}}},{"Land_Pallet_MilBoxes_F", {-5,-3,-0.7},{{0,0,0},{0,0,0}}},{"Land_Ammobox_rounds_F", {-1.5,3,-1.05},{{0,0,1},{0,-1,0}}}};
};

class MCC_rts_barracks2 : MCC_rts_barracks1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\RTS_iconBarracks2.paa";
	#else
	picture = "mcc\rts\data\RTS_iconBarracks2.paa";
	#endif

	displayName = "Shooting Range - Advanced";
	descriptionShort = "Shack have 8 beds and allows units to rest, remove tiredness and fatigue effects.";
	groups[] = {"MCC_rtsGroup_Transport","MCC_rtsGroup_FT","MCC_rtsGroup_MG","MCC_rtsGroup_AT","MCC_rtsGroup_AA"};
	anchorType = "CamoNet_INDP_open_Curator_F";
	requiredBuildings[] = {{"hq",2}};
	needelectricity = 1;
	upgradeTo[] = {"MCC_rts_barracks3"};
	constType = "barracks";
	level = 2;
	resources[] = {{"repair",200},{"food",300},{"med",100},{"time",0}};
	objectsArray[] =  {{"ShootingPos_F", {4,0,-1},{{0,0,0},{0,0,0}}},{"ShootingPos_F", {0,0,-1}, {{0,0,0},{0,0,0}}},{"ShootingPos_F", {-4,0,-1},{{0,0,0},{0,0,0}}},{"Land_Pallet_MilBoxes_F", {-5,-3,-0.7},{{0,0,0},{0,0,0}}},{"Land_Ammobox_rounds_F", {-1.5,3,-1.05},{{0,0,1},{0,-1,0}}},{"Land_BagFence_Long_F", {6,2,-0.7},{{1,0,0},{0,0,1}}},
		{"Land_BagFence_Long_F", {2,2,-0.7},{{1,0,0},{0,0,1}}},{"Land_BagFence_Long_F", {-2,2,-0.7},{{1,0,0},{0,0,1}}},{"Land_BagFence_Long_F", {-6,2,-0.7},{{1,0,0},{0,0,1}}},{"Land_BagFence_Round_F", {0,4,-0.7},{{0,-1,0},{0,0,1}}}};
};

class MCC_rts_barracks3 : MCC_rts_barracks1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\RTS_iconBarracks3.paa";
	#else
	picture = "mcc\rts\data\RTS_iconBarracks3.paa";
	#endif

	displayName = "Barracks";
	descriptionShort = "Barracks have 12 beds and allows units to rest, remove tiredness and fatigue effects.";
	groups[] = {"MCC_rtsGroup_Transport","MCC_rtsGroup_FT","MCC_rtsGroup_MG","MCC_rtsGroup_AT","MCC_rtsGroup_AA","MCC_rtsGroup_platoon","MCC_rtsGroup_sniper"};
	anchorType = "ShootingPos_F";
	requiredBuildings[] = {{"hq",3}};
	needelectricity = 1;
	upgradeTo[] = {};
	constType = "barracks";
	level = 3;
	resources[] = {{"repair",300},{"food",400},{"med",100},{"time",0}};
	objectsArray[] =  {{"ShootingPos_F", {3,0,0},{{0,0,0},{0,0,0}}},{"ShootingPos_F", {-3,0,0},{{0,0,0},{0,0,0}}},{"Land_HBarrierWall6_F", {7,3,1},{{-1,0,0},{0,0,1}}},{"Land_HBarrierWall6_F", {-7,3,1},{{1,0,0},{0,0,1}}},{"Land_HBarrierWall6_F", {7,11,1},{{-1,0,0},{0,0,1}}},{"Land_HBarrierWall6_F", {-7,11,1},{{1,0,0},{0,0,1}}}};
};

//--------------- houses --------------------
class MCC_rts_house1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\barracks.paa";
	#else
	picture = "mcc\rts\data\barracks.paa";
	#endif

	displayName = "Sleeping Area";
	descriptionShort = "Sleeping area have 4 beds and allows units to rest, remove tiredness and fatigue effects.";
	groups[] = {};
	actions[] = {"","","","","","","","","","","","MCC_rts_destroyLogic"};
	anchorType = "CamoNet_BLUFOR_open_Curator_F";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_house2"};
	constType = "house";
	level = 1;
	resources[] = {{"repair",100},{"food",200},{"med",100},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"Land_TablePlastic_01_F", {5,0,-0.6},{{1,0,0},{0,0,1}}},{"Land_BakedBeans_F", {4.9,0.4,-0.1}, {{1,-1,0},{0,0,1}}},{"Land_GasCooker_F", {4.7,0,-0.06},{{1,-1,0},{0,0,1}}},{"Land_BottlePlastic_V2_F", {5,0.3,-0.05},{{1,-1,0},{0,0,1}}},{"Land_CerealsBox_F", {5,-0.5,0},{{1,-1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {-3,3,-1.1},{{-1,0,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {-3,2,-1.1},{{-1,0,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {-3,1,-1.1},{{-1,0,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {-3,0,-1.1},{{-1,0,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {-3,-1,-1.1},{{-1,0,0},{0,0,1}}},{"Land_ClutterCutter_large_F", {0,0,0},{{0,1,0},{0,0,1}}},{"Land_LuggageHeap_02_F", {-4,-3,-0.8},{{-1,0,0},{0,0,1}}},{"FirePlace_burning_F", {0,0,-1.05},{{0,1,0},{0,0,1}}}};
};

class MCC_rts_house2 : MCC_rts_house1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\barracks2.paa";
	#else
	picture = "mcc\rts\data\barracks2.paa";
	#endif

	displayName = "Sleeping Shack";
	descriptionShort = "Shack have 8 beds and allows units to rest, remove tiredness and fatigue effects.";
	anchorType = "Land_Slum_House02_F";
	requiredBuildings[] = {{"hq",2}};
	needelectricity = 1;
	upgradeTo[] = {"MCC_rts_house3"};
	constType = "house";
	level = 2;
	resources[] = {{"repair",200},{"food",300},{"med",100},{"time",0}};
	objectsArray[] =  {{"Land_TablePlastic_01_F", {4.5,0,-0.6},{{1,0,0},{0,0,1}}},{"Land_BakedBeans_F", {4.7,0.4,-0.1}, {{1,-1,0},{0,0,1}}},{"Land_GasCooker_F", {4.6,0,-0.06},{{1,-1,0},{0,0,1}}},{"Land_BottlePlastic_V2_F", {4.3,0.3,-0.05},{{1,-1,0},{0,0,1}}},{"Land_CerealsBox_F", {4.8,-0.5,0},{{-1,-1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {2,3.3,-0.9},{{1,0,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {2,-0.7,-0.9},{{1,0,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {2,2.3,-0.9},{{1,0,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {2,1.3,-0.9},{{1,0,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {2,0.3,-0.9},{{1,0,0},{0,0,1}}},{"Land_ClutterCutter_large_F", {0,0,0},{{0,1,0},{0,0,1}}},{"Land_LuggageHeap_02_F", {0,1.3,-0.6},{{1,0,0},{0,0,1}}},{"Land_cargo_addon01_V2_F", {5,0,0},{{-1,0,0},{0,0,1}}},{"Land_Camping_Light_F", {0.5,1,1.75},{{1,-1,0},{0,0,1}}},{"Land_ChairPlastic_F", {6,1,-0.6},{{1,-1,0},{0,0,1}}}};
};

class MCC_rts_house3 : MCC_rts_house1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\barracks3.paa";
	#else
	picture = "mcc\rts\data\barracks3.paa";
	#endif

	displayName = "Cargo House";
	descriptionShort = "Cargo House have 12 beds and allows units to rest, remove tiredness and fatigue effects.";
	anchorType = "Land_Cargo_House_V1_F";
	requiredBuildings[] = {{"hq",3}};
	needelectricity = 1;
	upgradeTo[] = {};
	constType = "house";
	level = 3;
	resources[] = {{"repair",300},{"food",400},{"med",100},{"time",0}};
	objectsArray[] = {{"Land_Sleeping_bag_blue_F", {2,3.1,0.08},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {1,3.1,0.08},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_brown_F", {-2,3.1,0.08},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {-1,3.1,0.08},{{0,1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_F", {0,3.1,0.08},{{0,1,0},{0,0,1}}},{"Land_LuggageHeap_02_F", {2,1,0.2},{{0,1,0},{0,0,1}}},{"Land_Sink_F", {-1.5,-1,-0.1},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F", {0,-0.5,0},{{1,-1,0},{0,0,1}}},{"Land_Sleeping_bag_blue_folded_F", {-2,1,0},{{1,1,0},{0,0,1}}},{"Land_Sleeping_bag_brown_folded_F", {-2.5,1,0},{{1,1,0},{0,0,1}}},{"Land_Ground_sheet_folded_khaki_F", {-2,1.5,0},{{-1,1,0},{0,0,1}}}};
};

// --------------- Trade ----------------------
class MCC_rts_tradepost1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\tradePost.paa";
	#else
	picture = "mcc\rts\data\tradePost.paa";
	#endif

	displayName = "Trade Post";
	descriptionShort = "Trade resources for food";
	buildings[] = {};
	actions[] = {"MCC_rts_ammo2Food","MCC_rts_fuel2Food","MCC_rts_repair2Food","","","","","","","","","MCC_rts_destroyLogic"};
	fortifications[] = {};
	anchorType = "Land_MarketShelter_F";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	upgradeTo[] = {};
	constType = "tradePost";
	level = 1;
	resources[] = {{"ammo",300},{"repair",300},{"fuel",300},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"Land_Cages_F", {-5,-1,-1},{{0,1,0},{0,0,1}}},{"Land_WoodenCart_F", {5,-3,-1},{{0,1,0},{0,0,1}}},{"Land_CratesShabby_F",{2,-1,-1},{{0,1,0},{0,0,1}}},{"Land_CratesWooden_F", {-2,1,-1},{{0,1,0},{0,0,1}}},{"Land_Sacks_goods_F", {0,-1,-1},{{0,1,0},{0,0,1}}},{"Land_Sacks_heap_F", {3,1,-1.2},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F", {-2.5,1.2,-0.18},{{0,1,0},{0,0,1}}}};
};

//--------------- workshop --------------------
class MCC_rts_workshop1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop.paa";
	#else
	picture = "mcc\rts\data\workshop.paa";
	#endif

	displayName = "Workshop";
	descriptionShort = "Outfit machine guns on unarmed offroads and repairs some vehicles damage.";
	buildings[] = {"MCC_rts_storage1","MCC_rts_elecPower1"};
	actions[] = {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsFortUIContainer","","","","","","","","","","MCC_rts_destroyLogic"};
	fortifications[] = {"MCC_rts_fortSandbagLong","MCC_rts_fortSandbagRound","MCC_rts_fortRazorwire","MCC_rts_fortHBarrierSmall","MCC_rts_fortHBarrierLong","MCC_rts_fortSandbagTower"};
	anchorType = "Land_cargo_addon02_V1_F";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_workshop2"};
	constType = "workshop";
	level = 1;
	resources[] = {{"ammo",100},{"repair",300},{"fuel",100},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"Land_ScrapHeap_1_F", {-4,0,0},{{0,1,0},{0,0,1}}},{"Land_WorkStand_F", {0,-1.5,-0.7},{{0,1,0},{0,0,1}}},{"Land_CampingTable_F", {2.5,0,-0.3},{{1,0,0},{0,0,1}}},{"Land_DrillAku_F", {2.5,-0.5,0.15},{{-1,1,0},{0,1,0}}},{"Land_ExtensionCord_F", {1,-1.5,0.2},{{0,1,0},{0,0,1}}},{"Land_Gloves_F", {2.3,0.2,0.12},{{1,-1,0},{0,0,1}}},{"Land_Grinder_F", {1.7,-1.5,0.23},{{0,1,0},{0,0,1}}},{"Land_Portable_generator_F", {2.5,1.5,-0.3},{{0,1,0},{0,0,1}}},{"Land_Meter3m_F", {2.7,0.5,0.15},{{0,1,0},{0,0,1}}},{"Land_PortableLight_double_F", {-3,-2.5,0.4},{{-1,-1,0},{0,0,1}}},{"Land_ClutterCutter_large_F", {0,0,0},{{-1,1,0},{0,0,1}}}};
};

class MCC_rts_workshop2 : MCC_rts_workshop1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop2.paa";
	#else
	picture = "mcc\rts\data\workshop2.paa";
	#endif

	displayName = "Advanced Workshop";
	descriptionShort = "Outfit machine guns to unarmed offroads, build some light vehicles and repairs all vehicles damage.";
	buildings[] = {"MCC_rts_storage1","MCC_rts_elecPower1","MCC_rts_workshop3"};
	actions[]= {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsFortUIContainer","MCC_rts_rtsbuyVehicle","","","","","","","","","MCC_rts_destroyLogic"};
	fortifications[] = {"MCC_rts_fortHBarrierSmall","MCC_rts_fortHBarrierLong","MCC_rts_fortSandbagTower","MCC_rts_forthBarrierCatwalk","MCC_rts_forthBarrierCorner","MCC_rts_forthBarrierCorridor","MCC_rts_forthBarrierTower"};
	requiredBuildings[] = {{"storage",1}};
	needelectricity = 1;
	upgradeTo[] = {};
	level = 2;
	resources[] = {{"ammo",200},{"repair",300},{"fuel",200},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"Land_Scrap_MRAP_01_F", {-4.5,0,0.5},{{0,-1,0},{0,0,1}}},{"Land_WorkStand_F", {0,-1.5,-0.7},{{0,1,0},{0,0,1}}},{"Land_CampingTable_F", {2.5,0,-0.3},{{1,0,0},{0,0,1}}},{"Land_DrillAku_F", {2.5,-0.5,0.15},{{-1,1,0},{0,1,0}}},{"Land_ExtensionCord_F", {1,-1.5,0.2},{{0,1,0},{0,0,1}}},{"Land_Gloves_F", {2.3,0.2,0.12},{{1,-1,0},{0,0,1}}},{"Land_Grinder_F", {1.7,-1.5,0.23},{{0,1,0},{0,0,1}}},{"Land_Portable_generator_F", {2.5,1.5,-0.3},{{0,1,0},{0,0,1}}},{"Land_Meter3m_F", {2.7,0.5,0.15},{{0,1,0},{0,0,1}}},{"Land_PortableLight_double_F", {-3,-2.5,0.4},{{-1,-1,0},{0,0,1}}}};
};

class MCC_rts_workshop3 : MCC_rts_workshop2
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop3.paa";
	#else
	picture = "mcc\rts\data\workshop3.paa";
	#endif

	displayName = "Mechanic Workshop";
	descriptionShort = "Builds vehicles and armor and repairs all vehicles damage.";
	buildings[] = {"MCC_rts_storage1","MCC_rts_elecPower1","MCC_rts_workshop4","MCC_rts_workshop5"};
	actions[]={"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsFortUIContainer","MCC_rts_rtsbuyVehicle","","","","","","","","","MCC_rts_destroyLogic"};
	fortifications[] = {"MCC_rts_fortAA","MCC_rts_fortAT","MCC_rts_fortgmg","MCC_rts_fortgmgHigh","MCC_rts_fortmg","MCC_rts_fortmgHigh","MCC_rts_fortMortar"};
	requiredBuildings[] = {{"hq",2}};
	needelectricity = 1;
	upgradeTo[] = {};
	level = 3;
	resources[] = {{"ammo",400},{"repair",400},{"fuel",400},{"time",0}};
	objectsArray[] = {{"Land_EngineCrane_01_F",{3,-1,0.2},{{-1,1,0},{0,0,1}}},{"Land_WeldingTrolley_01_F",{-3,0,0},{{1,1,0},{0,0,1}}},{"Land_Workbench_01_F",{0,-1,-0.2},{{0,1,0},{0,0,1}}},{"Land_Wreck_HMMWV_F",{5,0,0.2},{{0,1,0},{0,0,1}}},{"Land_Wreck_CarDismantled_F",{-5,-1,0.2},{{0,1,0},{0,0,1}}},{"Oil_Spill_F",{0,-2,-0.2},{{0,1,0},{0,0,1}}},{"CargoNet_01_barrels_F",{3,5,0.3},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F",{-1,-1,0.23},{{1,-1,0},{0,0,1}}},{"Land_CarService_F",{0,5,1},{{0,1,0},{0,0,1}}},{"Land_Wreck_BMP2_F",{-3.3,8,0.8},{{0,1,0},{0,0,1}}}};
};

class MCC_rts_workshop4 : MCC_rts_workshop2
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop4.paa";
	#else
	picture = "mcc\rts\data\workshop4.paa";
	#endif

	displayName = "Aerial Workshop";
	descriptionShort = "Builds some air vehicles and repairs all air vehicles damage.";
	buildings[] = {"MCC_rts_storage1","MCC_rts_elecPower1"};
	actions[] = {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsbuyVehicle","","","","","","","","","","MCC_rts_destroyLogic"};
	requiredBuildings[] = {{"hq",3}};
	needelectricity = 1;
	upgradeTo[] = {};
	level = 4;
	resources[] = {{"ammo",800},{"repair",500},{"fuel",800},{"time",0}};
	objectsArray[] = {{"Land_EngineCrane_01_F",{3,-3,0.2},{{0,1,0},{0,0,1}}},{"Land_WeldingTrolley_01_F",{-3,0,0},{{1,1,0},{0,0,1}}},{"Land_Workbench_01_F",{0,-1,-0.2},{{0,1,0},{0,0,1}}},{"Oil_Spill_F",{0,-2,-0.2},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F",{-1,-1,0.23},{{-1,-1,0},{0,0,1}}},{"Land_Cargo_House_V3_F",{0,3,0},{{0,1,0},{0,0,1}}},{"Land_MobileLandingPlatform_01_F",{-5,-1,-0.5},{{1,0,0},{0,0,1}}},{"ContainmentArea_02_sand_F",{7,-1,-0.44},{{1,0,0},{0,0,1}}},{"StorageBladder_02_water_sand_F",{7,-1,-0.2},{{1,0,0},{0,0,1}}},{"PortableHelipadLight_01_blue_F",{7,4,-0.6},{{1,0,0},{0,0,1}}},{"PortableHelipadLight_01_blue_F",{14,4,-0.6},{{1,0,0},{0,0,1}}},{"PortableHelipadLight_01_blue_F",{14,14,-0.6},{{1,0,0},{0,0,1}}},{"PortableHelipadLight_01_blue_F",{7,14,-0.6},{{1,0,0},{0,0,1}}}};
};

class MCC_rts_workshop5 : MCC_rts_workshop2
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop5.paa";
	#else
	picture = "mcc\rts\data\workshop5.paa";
	#endif

	displayName = "Jet Workshop";
	descriptionShort = "Builds fixed wing air vehicles and repairs all air vehicles damage";
	buildings[] = {"MCC_rts_storage1","MCC_rts_elecPower1"};
	actions[] = {"MCC_rts_rtsBuildUIContainer","MCC_rts_rtsbuyVehicle","","","","","","","","","","MCC_rts_destroyLogic"};
	requiredBuildings[] = {{"hq",3}};
	needelectricity = 1;
	upgradeTo[] = {};
	level = 5;
	resources[] = {{"ammo",1000},{"repair",600},{"fuel",1000},{"time",0}};
	objectsArray[] = {{"Land_EngineCrane_01_F",{3,-3,0.2},{{0,1,0},{0,0,1}}},{"Land_WeldingTrolley_01_F",{-3,0,0},{{1,1,0},{0,0,1}}},{"Land_Workbench_01_F",{0,-1,-0.2},{{0,1,0},{0,0,1}}},{"Oil_Spill_F",{0,-2,-0.2},{{0,1,0},{0,0,1}}},{"Land_Camping_Light_F",{-1,-1,0.23},{{-1,-1,0},{0,0,1}}},{"Land_MobileLandingPlatform_01_F",{-5,-1,-0.5},{{1,0,0},{0,0,1}}}};
};

//--------------- power --------------------
class MCC_rts_elecPower1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\elec1.paa";
	#else
	picture = "mcc\rts\data\elec1.paa";
	#endif

	displayName = "Diesel Generator";
	descriptionShort = "Generate small electric energy, requires fuel to run.";
	buildings[] = {};
	actions[] = {"MCC_rts_startElectricity","MCC_rts_stopElectricity","","","","","","","","","","MCC_rts_destroyLogic"};
	anchorType = "Land_dp_transformer_F";
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_elecPower2"};
	constType = "elecPower";
	level = 1;
	resources[] = {{"repair",300},{"fuel",200},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {{"Land_Camping_Light_F",{0,4,0.6},{{0,1,0},{0,0,1}}},{"WaterPump_01_forest_F",{0,3.5,-0.5},{{0,-1,0},{0,0,1}}},{"Land_WaterTank_F",{0,6.55,-0.5},{{1,0,0},{0,0,1}}}};
};

class MCC_rts_elecPower2 : MCC_rts_elecPower1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\elec2.paa";
	#else
	picture = "mcc\rts\data\elec2.paa";
	#endif

	displayName = "Advanced Diesel Generator";
	descriptionShort = "Generate greater electric energy, requires fuel to run.";
	buildings[] = {};
	anchorType = "Land_dp_transformer_F";
	requiredBuildings[] = {{"workshop",3}};
	needelectricity = 0;
	upgradeTo[] = {"MCC_rts_elecPower3"};
	constType = "elecPower";
	level = 2;
	resources[] = {{"repair",400},{"fuel",300},{"time",0}};
	objectsArray[] =  {{"Land_Camping_Light_F",{0,4,0.75},{{0,1,0},{0,0,1}}},{"Land_JetEngineStarter_01_F",{0,4,-0.4},{{0,-1,0},{0,0,1}}}};
};

class MCC_rts_elecPower3 : MCC_rts_elecPower1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\elec3.paa";
	#else
	picture = "mcc\rts\data\elec3.paa";
	#endif

	displayName = "Solar Generator";
	descriptionShort = "Generate greater electric energy, does not requires fuel to run.";
	buildings[] = {};
	anchorType = "Land_dp_transformer_F";
	requiredBuildings[] = {{"hq",3}};
	needelectricity = 0;
	upgradeTo[] = {};
	constType = "elecPower";
	level = 3;
	resources[] = {{"repair",800},{"fuel",200},{"time",0}};
	objectsArray[] =  {{"Land_Camping_Light_F",{0,4,0.75},{{0,1,0},{0,0,1}}},{"Land_JetEngineStarter_01_F",{0,4,-0.4},{{0,-1,0},{0,0,1}}},{"Land_SolarPanel_2_F",{-2,4,0},{{-1,0,0},{0,0,1}}},{"Land_SolarPanel_2_F",{2,4,0},{{1,0,0},{0,0,1}}},{"Land_spp_Mirror_F",{5,9,0},{{0,1,0},{0,0,1}}},{"Land_spp_Mirror_F",{2,9,0},{{0,1,0},{0,0,1}}},{"Land_spp_Mirror_F",{-1,9,0},{{0,1,0},{0,0,1}}},{"Land_spp_Mirror_F",{-4,9,0},{{0,1,0},{0,0,1}}}};
};

//--------------- Medical --------------------
class MCC_rts_triage1
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\triage1.paa";
	#else
	picture = "mcc\rts\data\triage1.paa";
	#endif

	displayName = "Infirmary";
	descriptionShort = "Increases the chance of recovery from injuries and illness.";
	actions[] = {"MCC_rts_buyTickets","","","","","","","","","","","MCC_rts_destroyLogic"};
	anchorType = "Land_Research_house_V1_F";
	requiredBuildings[] = {{"barracks",1}};
	needelectricity = 1;
	upgradeTo[] = {"MCC_rts_triage2"};
	constType = "triage";
	level = 1;
	resources[] = {{"repair",300},{"food",100},{"med",300},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {};
};

class MCC_rts_triage2
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\triage2.paa";
	#else
	picture = "mcc\rts\data\triage2.paa";
	#endif

	displayName = "Medical Lab";
	descriptionShort = "Increases the chance of recovery from injuries and illness plus the ability to create medical supplies.";
	actions[] = {"MCC_rts_buyTickets","MCC_rts_createMeds","","","","","","","","","","MCC_rts_destroyLogic"};
	anchorType = "Land_Research_HQ_F";
	requiredBuildings[] = {{"hq",2}};
	needelectricity = 1;
	upgradeTo[] = {};
	constType = "triage";
	level = 2;
	resources[] = {{"repair",600},{"food",200},{"med",600},{"time",0}};
	actionFNC = "MCC_fnc_baseActionClicked";
	objectsArray[] =  {};
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