class missionWizard
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\missionWizard\fnc";
	#else
	file = "mcc\missionWizard\fnc";
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
	class populateObjective		{description = "Populate a zone with enemies.";};
	class createConfigs			{description = "Create configs class for the MW";};
	class campaignInit			{description = "Init campaign";};
	class missionDone			{description = "Mission Done and allocate resources";};
	class dayCycle				{description = "Control day and night cycle gain tickets and change weather every day";};
	class campaignInitMap 		{description = "init the campaign map and create hostile markers";};
	class findMarkers			{description = "bring all markers names around a sepcific position with the given radius";};
	class campaignPaintMarkers 	{description = "change all tiles in the given radius to show under the specific side control";};
	class campaignGetNearestTile {description = "find the nearest tile and return the [tile,side that holding";};
	class campaignGetBorders  {description = "find the borders or a selected zone by his tiles";};
	class playBriefings {};
	class movieMaker {};
	class campaignSpawnAIInit {description = "Spawn selected units around the player";};
	class MWattackBase {description = "Spawn random AI to attack the base";};
};