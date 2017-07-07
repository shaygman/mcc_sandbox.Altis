class MCC_rts_mountGuns
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\workshop2.paa";
	#else
	picture = "mcc\rts\data\workshop2.paa";
	#endif

	displayName = "Mount HMG";
	descriptionShort = "Upgrade the vehicle with HMG";
	condition = "typeOf _target in ['B_G_Offroad_01_F','C_Offroad_01_F','O_G_Offroad_01_F'] && alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {{"workshop",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsMountGuns";
	resources[] = {{"ammo",200},{"time",10}};
};

class MCC_rts_LoadResources
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\transportLoad.paa";
	#else
	picture = "mcc\rts\data\groups\transportLoad.paa";
	#endif

	displayName = "Logistics Load";
	descriptionShort = "Load Logistics crates";
	condition = "typeOf _target in (missionNameSpace getVariable ['MCC_supplyTracks',[]]) && alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsLoadResources";
	resources[] = {};
};
class MCC_rts_LoadResourcesWithdrawAmmo
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\RTS_trucLoadAmmo.paa";
	#else
	picture = "mcc\rts\data\groups\RTS_trucLoadAmmo.paa";
	#endif

	displayName = "Withdraw Ammo";
	descriptionShort = "Withdraw Ammo crate from HQ";
	condition = "typeOf _target in (missionNameSpace getVariable ['MCC_supplyTracks',[]]) && alive _target";
	dontShowDisabled = 0;
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsLoadResourcesAmmo";
	resources[] = {};
};

class MCC_rts_LoadResourcesWithdrawSupply
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\RTS_trucLoadRepair.paa";
	#else
	picture = "mcc\rts\data\groups\RTS_trucLoadRepair.paa";
	#endif

	displayName = "Withdraw Supply";
	descriptionShort = "Withdraw Supply crate from HQ";
	condition = "typeOf _target in (missionNameSpace getVariable ['MCC_supplyTracks',[]]) && alive _target";
	dontShowDisabled = 0;
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsLoadResourcesSupply";
	resources[] = {};
};

class MCC_rts_LoadResourcesWithdrawFuel
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\RTS_trucLoadfuel.paa";
	#else
	picture = "mcc\rts\data\groups\RTS_trucLoadfuel.paa";
	#endif

	displayName = "Withdraw Fuel";
	descriptionShort = "Withdraw Fuel crate from HQ";
	condition = "typeOf _target in (missionNameSpace getVariable ['MCC_supplyTracks',[]]) && alive _target";
	dontShowDisabled = 0;
	requiredBuildings[] = {{"hq",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsLoadResourcesFuel";
	resources[] = {};
};

class MCC_rts_respawnUnits
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\addTickets.paa";
	#else
	picture = "mcc\rts\data\addTickets.paa";
	#endif

	displayName = "Replenish";
	descriptionShort = "Replenish dead units. Needs to be near a barracks.";
	condition = "group _target call MCC_fnc_rtsIsRespawnUnits";
	dontShowDisabled = 0;
	requiredBuildings[] = {{"barracks",1}};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsrespawnUnits";
	resources[] = {{"food",40}};
};

class MCC_rts_UnLoadResources
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\transportUnLoad.paa";
	#else
	picture = "mcc\rts\data\groups\transportUnLoad.paa";
	#endif

	displayName = "Logistics Unload";
	descriptionShort = "Unload Logistics crates";
	condition = "typeOf _target in (missionNameSpace getVariable ['MCC_supplyTracks',[]]) && alive _target";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsUnloadResources";
	resources[] = {};
};
class MCC_rts_destroyObject
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\destroy.paa";
	#else
	picture = "mcc\rts\data\destroy.paa";
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
	picture = "\mcc_sandbox_mod\mcc\rts\data\addTickets.paa";
	#else
	picture = "mcc\rts\data\addTickets.paa";
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
	picture = "\mcc_sandbox_mod\mcc\rts\data\stop.paa";
	#else
	picture = "mcc\rts\data\stop.paa";
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
	picture = "\mcc_sandbox_mod\mcc\rts\data\out.paa";
	#else
	picture = "mcc\rts\data\out.paa";
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
	picture = "\mcc_sandbox_mod\mcc\rts\data\land.paa";
	#else
	picture = "mcc\rts\data\land.paa";
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

class MCC_rts_orderStanceUp
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\stand.paa";
	#else
	picture = "mcc\rts\data\groups\stand.paa";
	#endif

	displayName = "Stand Up";
	descriptionShort = "Order group units to stand";
	condition = "alive _target && stance _target == 'PRONE';";
	dontShowDisabled = 0;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "{if (count (missionNameSpace getVariable ['MCC_ConsoleGroupSelected',[]]) <=0) exitWith {}; {_x setUnitPos 'AUTO'} foreach units (MCC_ConsoleGroupSelected select 0); 0 spawn {sleep 1; [] call MCC_fnc_rtsBuildUIContainerBack}}";
	resources[] = {};
};

class MCC_rts_orderStanceDown
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\prone.paa";
	#else
	picture = "mcc\rts\data\groups\prone.paa";
	#endif

	displayName = "Prone";
	descriptionShort = "Order group units to prone";
	condition = "alive _target && stance _target != 'PRONE';";
	dontShowDisabled = 0;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "{if (count (missionNameSpace getVariable ['MCC_ConsoleGroupSelected',[]]) <=0) exitWith {}; {_x setUnitPos 'DOWN'} foreach units (MCC_ConsoleGroupSelected select 0); 0 spawn {sleep 1; [] call MCC_fnc_rtsBuildUIContainerBack}}";
	resources[] = {};
};

class MCC_rts_orderStealth
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\holdfire.paa";
	#else
	picture = "mcc\rts\data\groups\holdfire.paa";
	#endif

	displayName = "Stealth";
	descriptionShort = "Order group units to switch to stealth behavior";
	condition =  "alive _target && behaviour _target != 'STEALTH';";
	dontShowDisabled = 0;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "{if (count (missionNameSpace getVariable ['MCC_ConsoleGroupSelected',[]]) <=0) exitWith {}; (leader (MCC_ConsoleGroupSelected select 0)) setBehaviour 'STEALTH'; 0 spawn {sleep 1; [] call MCC_fnc_rtsBuildUIContainerBack}}";
	resources[] = {};
};

class MCC_rts_orderAware
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\fireTeam.paa";
	#else
	picture = "mcc\rts\data\groups\fireTeam.paa";
	#endif

	displayName = "Aware";
	descriptionShort = "Order group units to switch to aware behavior";
	condition = "alive _target && behaviour _target == 'STEALTH';";
	dontShowDisabled = 0;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "{if (count (missionNameSpace getVariable ['MCC_ConsoleGroupSelected',[]]) <=0) exitWith {}; (leader (MCC_ConsoleGroupSelected select 0)) setBehaviour 'AWARE'; 0 spawn {sleep 1; [] call MCC_fnc_rtsBuildUIContainerBack}}";
	resources[] = {};
};

class MCC_rts_orderPlaceSatchel
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\groups\satchel.paa";
	#else
	picture = "mcc\rts\data\groups\satchel.paa";
	#endif

	displayName = "Explosive Satchel";
	descriptionShort = "Place an explosive satchel that will detonate in 60 seconds.";
	condition = "alive _target;";
	dontShowDisabled = 0;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsOrderPlaceSatchel";
	resources[] = {{"ammo",50}};
};

class MCC_rts_takeControl
{
	#ifdef MCCMODE
	picture = "\mcc_sandbox_mod\mcc\rts\data\remoteControl.paa";
	#else
	picture = "mcc\rts\data\remoteControl.paa";
	#endif

	displayName = "Remote Control";
	descriptionShort = "Remote control the selected unit";
	condition = "alive _target && !(isplayer leader _target);";
	dontShowDisabled = 1;
	requiredBuildings[] = {};
	needelectricity = 0;
	actionFNC = "MCC_fnc_rtsTakeControl";
	resources[] = {};
};
