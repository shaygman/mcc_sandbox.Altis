class ambient {
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\ambient\fnc";
	#else
	file = "mcc\ambient\fnc";
	#endif

	class ambientInit {description = "init ambient civilians";};
	class findCivHouse {description = "find nearest civilian house";};
	class ambientDeleteCiv {description = "Delete civilians when not in range and not seen by players";};
	class ambientSpawnCiv {description = "Spawn civilians around the player";};
	class ambientDeleteCar {description = "Delete cars when not in range and not seen by players";};
	class ambientSpawnCar {description = "Spawn cars around the player";};
	class ambientSpawnCarParked  {description = "Spawn parked cars on street shulders";};
	class ambientDeleteCarParked {description = "Delete parked cars when not in range and not seen by players";};
	class ambientBirdsSpawn {description = "Spawn a flock of birds from a nearby tree or bush";};
	class ambientBirdsSpawnInit {description = "Init birds spawn on server";};
	class ambientFirePropagation {description = "Propagat fire from tree to tree";};
	class ambientFireStart {description = "Starts fire at the given position";};
	class ambientFireClientSide {description = "Client side: Light and sounds effects";};
	class ambientFireInit {description = "Init ambient fire";};
	class ambientFirePlayerFiredEH {description = "Init EH on each client to have a small chance projectiles will start fire";};
};