class curator
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\cfg\curator\fnc";
	#else
	file = "mcc\cfg\curator\fnc";
	#endif

	class addToZeus {description = "add units to zeus";};
	class curatorAmbientCivilians {description = "handles the add ambient civilians module";};
	class curatorMCCCAS {description = "MCC CAS in Zeus";};
	class curatorSetEvac {description = "Mark Vehicle as Evac Vehicle";};
	class curatorSetIED {description = "Make item/object/unit an IED";};
	class curatorSetArmedCivilian {description = "Make unit armed civilian";};
	class curatornightEffects {description = "Manage night effects";};
	class curatorDoorLock {description = "Manage doors status";};
	class curatorAtmoshphere {description = "Manage atmosphere";};
	class curatorWarZone {description = "Create war zone effect";};
	class curatorGarrisonUnits {description = "Garrison units in the selected buildings";};
	class curatorDamagePart {description = "Damage part of object/Unit";};
	class curatorVehicleSpawner {description = "Create a vhicles kiosk";};
	class curatorCampaignInit {description = "Starts MCC Campaign";};
	class setResources {description = "Sets resources for each side";};
	class curatorunderCover {description = "Sets player as undercover unit";};
	class curatorModuleCapturePoint {};
	class ambientDenied {};
};