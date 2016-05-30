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
	class RSSquadJoin {description = "Handles player joining a squad";};
	class RSSquadCreate {description = "Create a new sqaud";};
	class RSSquadLock {description = "Lock sqaud";};
	class RSSquadRename {description = "Rename sqaud";};
	class RSunitSelected {description = "Selecting a unit from squadMenu";};
	class RSunitSelectedClicked {description = "Executing selected unit";};
	class RSTakeCommander {description = "Become a commander";};
	class roleClicked {description = "Handle clicking on a role";};
	class RSgearButtonClicked {};
	class handleKilled {description = "Kill messeges";};
	class gearAI {description = "Gear AI with gear acording to its role";};
};