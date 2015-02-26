class MCC
{
	tag = "MCC";

	class general
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\general";
		class pre_init
		{
			preInit = 1;
			description = "Pre init mod only";
		};
		#else
		file = "mcc\fnc\general";
		#endif

		class activateAddons {preInit = 1; description = "Pre init addon";};
		class mobileRespawn	{description = "will move the respawn marker to the current position of the unit while the unit is alive, if the unit dead will move the marker to the prvious location.";};
		class buildingPosCount	{description = "return the ammount of indexed positions in a building.";};
		class makeUnitsArray	{description = "returns a unit array consist of all the units from the given function and simulation in format [_cfgclass,_vehicleDisplayName].";};
		class countGroup	{description = "Count the number of infantry, vehicles, tank, air, ships in a group.";};
		class PiPOpen	{description = "Do the transmitting feed animation.";};
		class time2String	{description = "convert time to string.";};
		class time	{description = "convert time to hh:mm:ss.";};
		class setVehicleInit	{description = "Sets vehicle init.";};
		class setVehicleName	{description = "Sets vehicle name.";};
		class setTime	{description = "Setstime on all clients.";};
		class setWeather	{description = "Sets weather  on all clients  - skip time by one hour to make the weather change.";};
		class globalSay3D	{description = "Say sound on 3d on all clients.";};
		class globalHint	{description = "Broadcast a meesege on all clients.";};
		class globalExecute	{description = "Global execute a command on selected clients or server.";};
		class groupChat	{description = "Send chat across MP.";};
		class moveToPos		{description = "move an object to a new location.";};
		class pickItem	{description = "Make a vehicle class item pickable and add variable to it.";};
		class broadcast	{description = "Create a virtual camera and broadcast a short PiP video to all clients for 15 seconds.";};
		class paradrop	{description = "Create a HALO or regular parachute jump for the given unit.";};
		class realParadrop	{description = "Create a HALO or regular parachute jump for the given units with simulation of runing out of an airplane.";};
		class realParadropPlayer	{description = "Handle the paradrop from the unit side.";};
		class countGroupHC	{description = "Count the number of infantry, vehicles, tank, air, ships in a group expand.";};
		class manageWp	{description = "Create and control AI WP on map.";};
		class sync	{description = "Sync the player with the server.";};
		class objectMapper	{description = "Takes an array of data about a dynamic object template and creates the objects.";};
		class findRoadsLeadingZone	{description = "Find Road segments leading to an area.";};
		class nearestRoad	{description = "Return a Road segments array near positions";};
		class garrison	{description = "Populate soldiers inside empty houses";};
		class saveToSQM	{description = "Save MCC's placments in SQM file format and copy it to clipboard";};
		class saveToMCC	{description = "prepare the mcc_output variable";};
		class loadFromMCC	{description = "Load the mcc_output variable";};
		class saveToComp	{description = "Save MCC's 3D editor placments in composition format";};
		class replaceString	{description = "Filter a string and removes certain characters ( _filter)";};
		class dirToString	{description = "Get direction integer and return it as a strin North, east exc";};
		class startLocations	{description = "Teleport the player when start location has been found";};
		class spawnGroup	{description = "MCC Custom group spawning";};
		class createTask	{description = "create a simple task with trigger assigned to a specific object";};
		class keyToName		{description = "get idkKey and return string with his name";};
		class makeBriefing	{description = "Server Only - create a Logic based briefing";};
		class handleAddaction	{description = "Handle addactions after respawn - init";};
		class ppEffects	{description = "Create effects to all players";};
		class gear	{preInit = 1; description = "Assign gear by roles";};
	};

	class ui
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\ui";
		#else
		file = "mcc\fnc\ui";
		#endif

		class countDownLine	{description = "Create a filling waiting bar - made by BIS all credits to them.";};
		class drawLine	{description = " Draw an arrow on the map localy between two points.";};
		class drawArrow	{description = " Expand:Draw a line on the map localy between two points.";};
		class drawBox	{description = "Draw a box on the map localy between two points.";};
		class trackUnits	{description = "Track units on the given map display";};
		class camp_showOSD	{description = "Show player OSD";};
		class curatorInitLine	{description = "Handle MCC's curator init line";};
		class initDispaly		{description = "Handle MCC's displays init";};
		class makeMarker		{description = "Create a marker";};
		class createMCCZones	{description = "Create MCC zones localy";};
		class initCuratorAttribute	{description = "Init MCC's curato Attribute";};
		class interactProgress	{description = "Create a progress bar and anim for the player";};
		class loadTruckUI		{description = "Open logistic truck UI";};
		class keyDown			{description = "Handle keydown/keyUp EH";};
		class help				{description = "Display tooltip";};
		class playerStats		{description = "Show player stats in RS";};
	};

	class ied
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\ied";
		#else
		file = "mcc\fnc\ied";
		#endif

		class IedFakeExplosion	{description = "Create a fake explosion.";};
		class IedDeadlyExplosion	{description = "Create a deadly explosion.";};
		class IedDisablingExplosion	{description = "Create a disabling explosion.";};
		class ACSingle	{description = "Create an armed civilian at the given position.";};
		class trapSingle	{description = "Create an IED at the given position.";};
		class iedHit		{description = "Determine what will happened when an IED got hit.";};
		class ambushSingle	{description = "Create an ambush group.";};
		class createIED		{description = "Create the IED mechanic.";};
		class manageAmbush	{description = "Manage ambush behavior in a group.";};
		class manageAC		{description = "Manage armed civilian behavior.";};
		class SBSingle		{description = "Place suicide bomber.";};
		class manageSB		{description = "Manage SB bomber behavior.";};
	};

	class cas
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\cas";
		#else
		file = "mcc\fnc\cas";
		#endif

		class CreateAmmoDrop	{description = "drop an object from a plane and attach paracute to it, thanks to BIS.";};
		class createPlane		{description = "create a flying plane from the given type and return the plane , pilot and group.";};
		class deletePlane		{description = "set a plane to move to a location and delete it once it come closer then 800 meters.";};

	};

	class artillery
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\artillery";
		#else
		file = "mcc\fnc\artillery";
		#endif

		class CBU	{description = "drop a bomb that explode to some skeets with paracute the explode to some kind of CBU.";};
		class SADARM	{description = "drop a bomb that explode to some skeets that will search and destroy near by armor.";};
		class artyBomb	{description = "Create artillery strike with sounds on given spot.";};
		class artyFlare	{description = "Create a flare.";};
		class artyDPICM	{description = "Create DPICM artillery barage.";};
		class amb_Art	{description = "Create ambient artillery barage.";};
		class calcSolution	{description = "calculate artillery solution high or low";};
		class artyGetSolution	{description = "Broadcast artillery solution high or low";};
		class consoleFireArtillery	{description = "Broadcast artillery to artillery units";};
	};

	class groupGen
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\groupGen";
		#else
		file = "mcc\fnc\groupGen";
		#endif

		class groupGenRefresh	{description = "Refresh the group gen markers";};
		class groupSpawn		{description = "Create a group on the server";};
		class groupGenUMRefresh	{description = "Refresh the group gen units lists";};
	};

	class console
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\console";
		#else
		file = "mcc\fnc\console";
		#endif

		class consoleClickGroupIcon	{description = "Define icon behaviot when clicked on the MCC Console";};
	};

	class missionWizard
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\missionWizard";
		#else
		file = "mcc\fnc\missionWizard";
		#endif

		class MWFindMissionCenter	{description = "Find the mission Wizard's center";};
		class MWbuildLocations		{description = "If the map have locations system it will build the locations";};
		class MWCreateTask			{description = "Create Task";};
		class MWFindbuildingPos		{description = "Scan for buildings and building's pos";};
		class MWfindObjectivePos	{description = "Create objective position";};
		class MWObjectiveHVT		{description = "Create an HVT objective";};
		class MWObjectiveDestroy	{description = "Create a Destroy objective";};
		class MWObjectiveIntel		{description = "Create a pick intel objective";};
		class MWObjectiveClear		{description = "Create a clear area objective";};
		class MWObjectiveDisable	{description = "Create a disable IED area objective";};
		class MWCreateUnitsArray	{description = "Create units array by type";};
		class MWUpdateZone			{description = "Create or update a new zone";};
		class MWSpawnInZone			{description = "Spawn units or groups in a zone";};
		class MWSpawnInfantry		{description = "Spawn infantry groups in the zone.";};
		class MWSpawnVehicles		{description = "Spawn vehicles in the zone.";};
		class buildRoadblock		{description = "Create a road block in the given position and direction.";};
		class MWopenBriefing		{description = "Create The breifings.";};
		class MWMapTooltip			{description = "Create The tooltips on breifings.";};
		class MWreinforcement		{description = "Create a reinforcment type.";};
		class MWSpawnStatic			{description = "Spawn static weapons in the zone.";};
		class customTasks			{description = "Manage custom tasks.";};
		class MWspawnAnimals		{description = "spawn animals in the area.";};
		class MWinitMission			{description = "Init generated mission.";};
	};

	class ai
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\ai";
		#else
		file = "mcc\fnc\ai";
		#endif

		class garrisonBehavior	{description = "Contorol units under garrison behavior.";};
		class paratroops		{description = "Contorol the paratroop reinforcement spawn.";};
		class reinforcement		{description = "Contorol the motorized reinforcement spawn.";};
		class setUnitPos		{description = "Sets units pos.";};
		class populateVehicle	{description = "Populate a not empty vehicle with antoher group contains units acording to its faction and cargo space.";};
		class disarmUnit		{description = "Disarm a unit and create a weapon holder";};
		class setUnitAnim		{description = "Sets units Animation - and return it to default after a while";};
		class stunBehav			{description = "Play unit stun behavior";};
	};

	class mp
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\mp";
		#else
		file = "mcc\fnc\mp";
		#endif

		class vote	{description = "Start a voting process.";};
		class getActiveSides	{description = "Return an array of the active sides in a role selection game.";};
		class PDAcreatemarker	{description = "Creates markers on mp per side and delete them after a period of time";};
		class construction		{description = "Constract a tactical building on the server side";};
		class construct_base	{description = "Constract a building in base";};
		class addRating			{description = "Adds rating to a specific player";};
		class radioSupport		{description = "Broadcast radio support to all elements not including the broadcaster group";};
		class inidbGet	{};
		class inidbSet 	{};
	};

	class MCCmodules
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\MCCmodules";
		#else
		file = "mcc\fnc\MCCmodules";
		#endif

		class moduleSector	{description = "Handles Sectors built on BIS Sector by  Karel Moricky.";};
		class accessRights	{description = "Handles access rights to MCC.";};
		class SF			{description = "Defines units as SF.";};
		class moduleObjectiveSectorMCC	{ext = ".fsm";};
		class createRestrictedZones		{description = "create restriction zone around a marker.";};
		class RestrictZoneEffect		{description = "Effect while inside a restricted zone.";};
		class missionSettings {description = "Mission settings";};
		class GAIASettings {description = "GAIA settings";};
		class settingsCover {description = "Cover settings";};
		class settingsMedical {description = "Medical system settings";};
	};

	class actions
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\actions";
		#else
		file = "mcc\fnc\actions";
		#endif

		class ilsChilds		{description = "Handles ILS childs";};
		class dragObject	{description = "Start a dragging animation must be run local on the dragging unit";};
		class releaseObject	{description = "stop a dragging animation must be run local on the dragging unit";};
		class releasePod	{description = "Release a pod from Taru helicopter";};
		class attachPod		{description = "Attach a pod to Taru helicopter";};
		class vault			{description = "Vault over an obstacle";};
		class cover			{description = "Manage cover mechanics";};
		class weaponSelect	{description = "Change weapons and throw utility";};
		class utilityUse	{description = "use utility";};
		class grenadeThrow	{description = "Throw grenades";};
		class pickKit		{description = "pick up dead unit kit";};
	};

	class roleSelection
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\roleSelection";
		#else
		file = "mcc\fnc\roleSelection";
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
	};

	class interaction
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\interaction";
		#else
		file = "mcc\fnc\interaction";
		#endif

		class interaction	{description = "Interaction perent";};
		class interactMan	{description = "Interaction with man type";};
		class interactManClicked	{};
		class interactIED	{description = "Interaction with IED type";};
		class interactDoor	{description = "Interaction with door type";};
		class DOOR_CAM_Handler	{};
		class DoorMenuClicked	{};
		class interactObject	{description = "Interaction with containers object";};
		class interactUtility	{description = "Interaction with utility object";};
		class interactSelf	{description = "Interaction with self";};
		class interactSelfClicked	{};
		class requestDropOff	{description = "Request player or AI to drop off a cargo group in a specific place - shold run localy on the requestor";};
	};

	class radio
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\radio";
		#else
		file = "mcc\fnc\radio";
		#endif

		class vonRadio		{description = "simulate real radio comms on ArmA VON";};
		class settingsRadio	{description = "Real radio comms settings";};
		class VONRadioBroadcast {};
		class VONRadiofindChannel {};
		class VONRadioPressed {};
	};

	class medic
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\medic";
		#else
		file = "mcc\fnc\medic";
		#endif

		class initMedic		{description = "Init Medic System";};
		class handleDamage	{description = "Handle damage on players and AI";};
		class unconscious	{description = "Handle unconscious behavior";};
		class medicEffects	{description = "Handle clients medic effects";};
		class medicProgressBar	{description = "Handle medic progress";};
		class medicUseItem	{description = "Handle medic uses item";};
		class medicDragCarry {description = "Handle drag and carry units";};
		class loadWounded 	{description = "Unload wounded from a vehicle";};
		class medicArea		{description = "create a building as a medic area";};
	};

	class helpers
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\helpers";
		#else
		file = "mcc\fnc\helpers";
		#endif

		class createHelper		{description = "Create ingame UI helper for interacted objects";};
		class deleteHelper		{description = "Delete ingame UI helper for interacted objects";};
	};

	class rts
	{
		#ifdef MCCMODE
		file = "\mcc_sandbox_mod\mcc\fnc\rts";
		#else
		file = "mcc\fnc\rts";
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
	};
};