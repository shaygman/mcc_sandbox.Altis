class Logic;
class Module_F: Logic
{
	class ArgumentsBaseUnits
	{
		class Units;
	};
	class ModuleDescription
	{
		class AnyPlayer;
		class AnyBrain;
		class EmptyDetector;
	};
};

#include "modules\cfgVehicles.hpp"
#include "curator\cfgVehicles.hpp"

class Box_NATO_Ammo_F;
#include "ammoBox\medicBox.hpp"
#include "ammoBox\tacticalItemsBox.hpp"
#include "ammoBox\miscItemsBox.hpp"

#include "ACE\aceCfg.hpp"

class Box_NATO_AmmoVeh_F;

class MCC_ammoBox : Box_NATO_AmmoVeh_F
{
	ammo = 200;
	model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	author = "MCC-Team";
};

class MCC_crateAmmo : Box_NATO_AmmoVeh_F
{
	displayName = "(MCC)Ammo Crate";
	maximumLoad = 600;
	transportAmmo = 12000;
	author = "MCC-Team";
};

class MCC_crateSupply : Box_NATO_AmmoVeh_F
{
	displayName = "(MCC)Supply Crate";
	maximumLoad = 600;
	transportAmmo = 0;
	transportRepair = 90000;
	model = "\A3\Supplies_F_Heli\CargoNets\CargoNet_01_box_F.p3d";
	author = "MCC-Team";
};

class MCC_crateFuel : Box_NATO_AmmoVeh_F
{
	displayName = "(MCC)Fuel Crate";
	maximumLoad = 600;
	transportAmmo = 0;
	transportFuel = 500;
	model = "\A3\Supplies_F_Heli\CargoNets\CargoNet_01_barrels_F.p3d";
	author = "MCC-Team";
};

//Big Crates
//West
class B_Slingload_01_Ammo_F;
class MCC_crateAmmoBigWest : B_Slingload_01_Ammo_F
{
	displayName = "(MCC)Ammo Container";
	maximumLoad = 600*4;
	transportAmmo = 12000*4;
	author = "MCC-Team";
};

class B_Slingload_01_Repair_F;
class MCC_crateSupplyBigWest : B_Slingload_01_Repair_F
{
	displayName = "(MCC)Supply Container";
	maximumLoad = 600*4;
	transportAmmo = 0;
	transportRepair = 90000*4;
	author = "MCC-Team";
};

class B_Slingload_01_Fuel_F;
class MCC_crateFuelBigWest : B_Slingload_01_Fuel_F
{
	displayName = "(MCC)Fuel Container";
	maximumLoad = 600*4;
	transportAmmo = 0;
	transportFuel = 500*4;
	author = "MCC-Team";
};

//East
class Land_Pod_Heli_Transport_04_ammo_F;
class MCC_crateAmmoBigEast : Land_Pod_Heli_Transport_04_ammo_F
{
	displayName = "(MCC)Ammo Pod";
	maximumLoad = 600*4;
	transportAmmo = 12000*4;
	author = "MCC-Team";
};

class Land_Pod_Heli_Transport_04_repair_F;
class MCC_crateSupplyBigEast : Land_Pod_Heli_Transport_04_repair_F
{
	displayName = "(MCC)Supply Pod";
	maximumLoad = 600*4;
	transportAmmo = 0;
	transportRepair = 90000*4;
	author = "MCC-Team";
};

class Land_Pod_Heli_Transport_04_fuel_F;
class MCC_crateFuelBigEast : Land_Pod_Heli_Transport_04_fuel_F
{
	displayName = "(MCC)Fuel Pod";
	maximumLoad = 600*4;
	transportAmmo = 0;
	transportFuel = 500*4;
	author = "MCC-Team";
};
