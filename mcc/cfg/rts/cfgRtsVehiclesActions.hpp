class MCC_rts_mountGuns
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\workshop2.paa";
	#else
	picture = "data\rts\workshop2.paa";
	#endif

	displayName = "Mount HMG";
	descriptionShort = "Upgrade the vehicle with HMG";
	condition = "typeOf _target in ['B_G_Offroad_01_F','C_Offroad_01_F'] && alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsMountGuns";
	resources[] = {{"repair",200},{"time",10}};
};

class MCC_rts_destroyObject
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\destroy.paa";
	#else
	picture = "data\rts\destroy.paa";
	#endif

	displayName = "Destroy Object";
	descriptionShort = "Destroy the current selected Object";
	condition = "(_target getVariable ['MCC_rtsObject',false])";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsDestroyObject";
	resources[] = {};
};

class MCC_rts_populateVehicle
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\addTickets.paa";
	#else
	picture = "data\rts\addTickets.paa";
	#endif

	displayName = "Spawn Crew";
	descriptionShort = "Spawn Crew to the selected vehicle/weapon";
	condition = "((_target getVariable ['MCC_rtsObject',false]) && (_target emptyPositions 'Driver' > 0 || _target emptyPositions 'Gunner' > 0))";
	dontShowDisabled = 1;
	requiredBuildings[] = {{"barracks",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsPopulateVehicle";
	resources[] = {{"food",100}};
};

class MCC_rts_orderStop
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\stop.paa";
	#else
	picture = "data\rts\stop.paa";
	#endif

	displayName = "Stop";
	descriptionShort = "Stop Current Actions";
	condition = "alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsOrderStop";
	resources[] = {};
};

class MCC_rts_OrderGetout
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\out.paa";
	#else
	picture = "data\rts\out.paa";
	#endif

	displayName = "Disembark";
	descriptionShort = "Disembark cargo units";
	condition = "alive _target && {count assignedCargo vehicle _x > 0} count (units _target) > 0";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsOrderGetout";
	resources[] = {};
};

class MCC_rts_OrderLand
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\land.paa";
	#else
	picture = "data\rts\land.paa";
	#endif

	displayName = "Land";
	descriptionShort = "Order the helicopter to land";
	condition = "alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsOrderLand";
	resources[] = {};
};
