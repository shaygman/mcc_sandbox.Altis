class MCC_rts_mountGuns
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\data\rts\hq.paa";
	#else
	picture = "data\rts\hq.paa";
	#endif

	displayName = "Mount HMG";
	descriptionShort = "Upgrade the vehicle with HMG";
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsFncMountGuns";
	resources[] = {{"repair",200},{"time",1}};
};