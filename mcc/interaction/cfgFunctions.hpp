class interaction
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\interaction\fnc";
	#else
	file = "mcc\interaction\fnc";
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
	class isDoor	{description = "is the player facing a door";};
	class isDoorLocked {description = "is the player facing a door";};
	class checkDoor {description = "Give infor if the door is locked";};
	class doorBreach {description = "Place a breaching charge on the door";};
	class doorLock {description = "lock door";};
	class doorUnlock {description = "unlock door";};
	class doorCamera {description = "Mirror under the door";};
	class isSurvivalObject {description = "check if an object is a survival object";};
	class searchSurvivalObject {description = "Search a survival object";};
	class initConstract {description = "Init Construction";};
	class interactionsBuildInteractionUI {description = "build interaction rose menu";};
	class attachItemUniform {description = "attach item to uniform";};
	class interactionMarkerCreate {description = "create a marker on the player cursor";};
	class attachItemWeapons {description = "Attach items to weapon";};
	class ACE_addGrenadesChildren {description = "Build ACE childrens for grenades";};
	class interactDoorGrenadeThrow {description = "Throw a grenade into a house";};
};