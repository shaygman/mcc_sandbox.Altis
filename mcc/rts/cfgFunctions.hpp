class rts
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\rts\fnc";
	#else
	file = "mcc\rts\fnc";
	#endif

	class boxMakeWeaponsArray {};
	class addVirtualItemCargo {};
	class addVirtualWeaponCargo {};
	class addVirtualMagazineCargo {};
	class getVirtualItemCargo {};
	class getVirtualWeaponCargo {};
	class getVirtualMagazineCargo {};
	class removeVirtualItemCargo {};
	class removeVirtualWeaponCargo {};
	class removeVirtualMagazineCargo {};
	class baseResourceReduce {};
	class baseSelected {};
	class rtsClearBuilding {};
	class baseActionClicked {};
	class baseActionEntered {};
	class baseActionExit {};
	class baseOpenConstMenu {};
	class baseBuildBorders {};
	class CheckRes {};
	class CheckBuildings {};
	class mainBoxOpen {};
	class vehicleSpawnerInit {};
	class vehicleSpawner {};
	class makeObjectVirtualBox {};
	class rtsMountGuns {description = "Mount turrets on civilian vehicles";};
	class initWorkshop {description = "Init workshop class building";};
	class rtsStartElectricity {description = "Start electricity production";};
	class rtsScanResourcesBasic {description = "Start basic resources mission";};
	class rtsScanResourcesAdvanced {description = "Start advanced resources mission";};
	class rtsScanResourcesCancel {description = "Cancel resources mission";};
	class rtsScanResources {description = "Generate resources mission";};
	class rtsBuyTickets {description = "Adds Tickets";};
	class rtsCreateMeds {description = "Create Meds";};
	class rtsUpgrade {description = "Upgrad building";};
	class rtsDestroyLogic {description = "Destroy the selected logic";};
	class rtsDestroyObject {description = "Destroy the selected object";};
	class rtsPopulateVehicle {description = "Populate vehicle";};
	class vehicleSpawnerInitDialog {description = "Open vehicle spawner Dialog";};
	class rtsBuildUIContainer {description = "create a UI container";};
	class rtsFortUIContainer {description = "create a UI container";};
	class rtsBuildUIContainerBack {description = "back from UI container";};
	class rtsUnitsUIContainer {description = "create a UI container";};
	class rtsbuyVehicle {description = "open vehicle spawner dialog for the commander";};
	class rtsOrderStop {description = "Stop WP";};
	class rtsOrderGetout {description = "Disembark units from vehicle";};
	class rtsOrderLand {description = "Order land";};
	class rtsTradeforFood {description = "Trade resources for food";};
	class rtsCreateGroup {description = "Spawn group";};
	class rtsLoadResources {description = "Load logistics crates";};
	class rtsLoadResourcesAmmo {description = "Withdraw supply crates";};
	class rtsLoadResourcesSupply {description = "Withdraw supply crates";};
	class rtsLoadResourcesFuel {description = "Withdraw supply crates";};
	class rtsUnloadResources {description = "Unload logistics crates";};
	class rtsBuildingProgress {description = "manage building progress";};
	class rtsIsRespawnUnits{description = "checks if we can respawn units";};
	class rtsRespawnUnits {description = "Respawn dead units in a group";};
	class rtsOrderPlaceSatchel {description = "Place satchel";};
	class rtsTakeControl {description = "Remote control the selected unit";};
	class mainBoxInit {};
	class saveCargoBox {description = "save or load the cargo box items from the server using iniDB";};
	class rtsaddArtilleryAmmo {description = "Buy 10 artillery shells";};
	class rtsCalculateResourceTreshold {description = "calculate resources tresholds";};
};

class forts
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\rts\fnc\forts";
	#else
	file = "mcc\rts\fnc\forts";
	#endif

	class buildFort {};
	class fortAA {};
	class fortAT {};
	class fortGmg {};
	class fortGMGHigh {};
	class fortMG {};
	class fortMGHigh {};
	class fortMortar {};
};
