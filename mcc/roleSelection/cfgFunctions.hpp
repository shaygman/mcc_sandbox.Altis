class roleSelection {
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\roleSelection\fnc";
	#else
	file = "mcc\roleSelection\fnc";
	#endif

	class unlock	{description = "Check for gear unlocks and notify the player.";};
	class gainXPfromRoles	{description = "gain XP from specific roles.";};
	class createRespawnTent	{description = "Creates a respawn tent";};
	class getVariable		{description = "Global execute a command on server only  - SERVER ONLY";};
	class setValue			{description = "Sets variable with custom value on a specific player";};
	class buildSpawnPoint	{description = "Create a spawn point to the given side - SERVER ONLY";};
	class setGroupID		{description = "Set group ID - SERVER ONLY";};
	class getGroupID		{description = "get group ID";};
	class setGear			{description = "Sets gear to role";};
	class assignGear		{description = " Sets gear to role";};
	class addWeapon			{description = " Sets gear to role";};
	class addItem {};
	class setVariable{};
	class allowedDrivers{};
	class allowedWeapons{};
	class handleRating 		{description = "Add xp for players when rating added";};
	class createCameraOnPlayer {description = "Create a camera object on player";};
};