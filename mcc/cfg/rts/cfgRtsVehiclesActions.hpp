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
	condition = "((_obj getVariable ['MCC_rtsObject',false]) && (_obj emptyPositions 'Driver' > 0 || _obj emptyPositions 'Gunner' > 0))";
	dontShowDisabled = 1;
	requiredBuildings[] = {{"barracks",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsPopulateVehicle";
	resources[] = {{"food",100}};
};

class MCC_rts_orderMove
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\back.paa";
	#else
	picture = "data\rts\back.paa";
	#endif

	displayName = "Move";
	descriptionShort = "Move the selected units";
	condition = "alive _obj";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsOrderMove";
	resources[] = {};
};