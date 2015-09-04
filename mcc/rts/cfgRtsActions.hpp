class MCC_rts_startElectricity
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\elec1.paa";
	#else
	picture = "mcc\rts\data\elec1.paa";
	#endif

	displayName = "Generator On";
	descriptionShort = "";
	condition = "!(missionNamespace getVariable [format ['MCC_rtsElecOn_%1', playerSide],false])";
	requiredBuildings[] = {{"elecPower",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsStartElectricity";
	resources[] = {{"fuel",50}};
};

class MCC_rts_stopElectricity
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\power.paa";
	#else
	picture = "mcc\rts\data\power.paa";
	#endif

	displayName = "Generator Off";
	descriptionShort = "";
	condition = "(missionNamespace getVariable [format ['MCC_rtsElecOn_%1', playerSide],false])";
	requiredBuildings[] = {{"elecPower",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsStartElectricity";
	resources[] = {};
};

class MCC_rts_scanResourcesBasic
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\hq.paa";
	#else
	picture = "mcc\rts\data\hq.paa";
	#endif

	displayName = "Basic Mission Scan";
	descriptionShort = "Order HQ to look for basic resources missions";
	condition = "!(missionNamespace getVariable [format ['MCC_rtsMissionOn_%1', playerSide],false]) && (missionNamespace getVariable ['MCC_isCampaignRuning',false]);";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsScanResourcesBasic";
	resources[] = {{"time",60}};
};

class MCC_rts_scanResourcesAdvanced
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\satcom.paa";
	#else
	picture = "mcc\rts\data\satcom.paa";
	#endif

	displayName = "Advanced Mission Scan";
	descriptionShort = "Order HQ to look for advanced resources missions";
	condition = "!(missionNamespace getVariable [format ['MCC_rtsMissionOn_%1', playerSide],false]) && (missionNamespace getVariable ['MCC_isCampaignRuning',false]);";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsScanResourcesAdvanced";
	resources[] = {{"time",60}};
};

class MCC_rts_scanResourcesCancel
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\power.paa";
	#else
	picture = "mcc\rts\data\power.paa";
	#endif

	displayName = "Abort Mission";
	descriptionShort = "Abort the mission and delete all units and crates";
	condition = "(missionNamespace getVariable [format ['MCC_rtsMissionOn_%1', playerSide],false]) && (missionNamespace getVariable ['MCC_isCampaignRuning',false]);";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsScanResourcesCancel";
	resources[] = {};
};

class MCC_rts_buyTickets
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\addTickets.paa";
	#else
	picture = "mcc\rts\data\addTickets.paa";
	#endif

	displayName = "Redeem Tickets";
	descriptionShort = "Add 5 tickets";
	condition = "";
	requiredBuildings[] = {{"triage",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsBuyTickets";
	resources[] = {{"med",50}};
};

class MCC_rts_createMeds
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\meds.paa";
	#else
	picture = "mcc\rts\data\meds.paa";
	#endif

	displayName = "Create Meds";
	descriptionShort = "Convert food and fuel into meds";
	condition = "";
	requiredBuildings[] = {{"triage",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsCreateMeds";
	resources[] = {{"food",100},{"fuel",50}};
};

class MCC_rts_ammo2Food
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\ammo2Food.paa";
	#else
	picture = "mcc\rts\data\ammo2Food.paa";
	#endif

	displayName = "Trade Ammo";
	descriptionShort = "Trade ammo with the locals for food";
	condition = "";
	requiredBuildings[] = {{"tradePost",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsTradeforFood";
	resources[] = {{"ammo",200},{"time",5}};
};

class MCC_rts_fuel2Food
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\fuel2Food.paa";
	#else
	picture = "mcc\rts\data\fuel2Food.paa";
	#endif

	displayName = "Trade Fuel";
	descriptionShort = "Trade fuel with the locals for food";
	condition = "";
	requiredBuildings[] = {{"tradePost",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsTradeforFood";
	resources[] = {{"fuel",200},{"time",5}};
};

class MCC_rts_repair2Food
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\repair2Food.paa";
	#else
	picture = "mcc\rts\data\repair2Food.paa";
	#endif

	displayName = "Trade Supplies";
	descriptionShort = "Trade supplies with the locals for food";
	condition = "";
	requiredBuildings[] = {{"tradePost",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsTradeforFood";
	resources[] = {{"repair",200},{"time",5}};
};

class MCC_rts_destroyLogic
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\destroy.paa";
	#else
	picture = "mcc\rts\data\destroy.paa";
	#endif

	displayName = "Destroy Facility";
	descriptionShort = "Destroy the current selected facility";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsDestroyLogic";
	resources[] = {};
};

class MCC_rts_rtsFortUIContainer
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\rook.paa";
	#else
	picture = "mcc\rts\data\rook.paa";
	#endif

	displayName = "Fortifications";
	descriptionShort = "Build Fortifications";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsFortUIContainer";
	resources[] = {};
};

class MCC_rts_rtsUnitsUIContainer
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\addTickets.paa";
	#else
	picture = "mcc\rts\data\addTickets.paa";
	#endif

	displayName = "Units";
	descriptionShort = "Recruit Units";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsUnitsUIContainer";
	resources[] = {};
};

class MCC_rts_rtsBuildUIContainer
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\hammer.paa";
	#else
	picture = "mcc\rts\data\hammer.paa";
	#endif

	displayName = "Build";
	descriptionShort = "Build Menu";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsBuildUIContainer";
	resources[] = {};
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

class MCC_rts_rtsbuyVehicle
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\buyVehicle.paa";
	#else
	picture = "mcc\rts\data\buyVehicle.paa";
	#endif

	displayName = "Buy Vehicles";
	descriptionShort = "Buy Vehicles";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsbuyVehicle";
	resources[] = {};
};
#include "forts\forts.hpp"
