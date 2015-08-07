class MCC_rts_mountGuns
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\workshop2.paa";
	#else
	picture = "data\rts\workshop2.paa";
	#endif

	displayName = "Mount HMG";
	descriptionShort = "Upgrade the vehicle with HMG";
	condition = "";
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsMountGuns";
	resources[] = {{"repair",200},{"time",10}};
};

class MCC_rts_startElectricity
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\elec1.paa";
	#else
	picture = "data\rts\elec1.paa";
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
	picture = "\mcc_sandbox_mod\mcc\dialogs\sqlPDA\data\power.paa";
	#else
	picture = "mcc\dialogs\sqlPDA\data\power.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\hq.paa";
	#else
	picture = "data\rts\hq.paa";
	#endif

	displayName = "Basic Mission Scan";
	descriptionShort = "Order HQ to look for basic resources missions";
	condition = "!(missionNamespace getVariable [format ['MCC_rtsMissionOn_%1', playerSide],false]) && (missionNamespace getVariable ['MCC_isCampaignRuning',false]);";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsScanResourcesBasic";
	resources[] = {};
};

class MCC_rts_scanResourcesAdvanced
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\satcom.paa";
	#else
	picture = "data\rts\satcom.paa";
	#endif

	displayName = "Advanced Mission Scan";
	descriptionShort = "Order HQ to look for advanced resources missions";
	condition = "!(missionNamespace getVariable [format ['MCC_rtsMissionOn_%1', playerSide],false]) && (missionNamespace getVariable ['MCC_isCampaignRuning',false]);";
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsScanResourcesAdvanced";
	resources[] = {};
};

class MCC_rts_scanResourcesCancel
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\dialogs\sqlPDA\data\power.paa";
	#else
	picture = "mcc\dialogs\sqlPDA\data\power.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\addTickets.paa";
	#else
	picture = "data\rts\addTickets.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\meds.paa";
	#else
	picture = "data\rts\meds.paa";
	#endif

	displayName = "Create Meds";
	descriptionShort = "Convert food and fuel into meds";
	condition = "";
	requiredBuildings[] = {{"triage",1}};
	needelectricity = 1;
	actionFNC = "MCC_fnc_rtsCreateMeds";
	resources[] = {{"food",100},{"fuel",50}};
};

class MCC_rts_destroyLogic
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\destroy.paa";
	#else
	picture = "data\rts\destroy.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\rook.paa";
	#else
	picture = "data\rts\rook.paa";
	#endif

	displayName = "Fortifications";
	descriptionShort = "Build Fortifications";
	condition = "";
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsFortUIContainer";
	resources[] = {};
};

class MCC_rts_rtsBuildUIContainer
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\hammer.paa";
	#else
	picture = "data\rts\hammer.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\back.paa";
	#else
	picture = "data\rts\back.paa";
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
	picture = "\mcc_sandbox_mod\data\rts\buyVehicle.paa";
	#else
	picture = "data\rts\buyVehicle.paa";
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
