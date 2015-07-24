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