class Logic;
class Module_F: Logic
{
	class ArgumentsBaseUnits
	{
		class Units;
	};
	class ModuleDescription
	{
		class AnyBrain;
		class EmptyDetector; 
	};
};

#include "modules\access.hpp"
#include "modules\sf.hpp"
#include "modules\RestrictedZone.hpp"
#include "modules\ILS.hpp"
#include "modules\StartLocations.hpp"
#include "modules\MissionSettings.hpp"
#include "modules\GAIASettings.hpp"
#include "modules\cover.hpp"
#include "modules\radio.hpp"

class Land_Ammobox_rounds_F;
class MCC_ammoBox : Land_Ammobox_rounds_F 
{
	ammo = 100;
};
	
class Box_NATO_AmmoVeh_F;
class MCC_crateAmmo : Box_NATO_AmmoVeh_F
{
	displayName = "Ammo Crate";
	maximumLoad = 600;
	transportAmmo = 12000;
};

class MCC_crateSupply : Box_NATO_AmmoVeh_F
{
	displayName = "Supply Crate";
	maximumLoad = 600;
	transportAmmo = 0;
	transportRepair = 90000;
	model = "\A3\Structures_F_EPA\Mil\Scrapyard\PaperBox_closed_F.p3d";
};

class MCC_crateFuel : Box_NATO_AmmoVeh_F
{
	displayName = "Fuel Barrel";
	maximumLoad = 600;
	transportAmmo = 0;
	transportFuel = 500;
	model = "\A3\Structures_F\Items\Vessels\WaterBarrel_F.p3d";
};