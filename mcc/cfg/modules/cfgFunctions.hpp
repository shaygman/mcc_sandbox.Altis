class MCCmodules
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\cfg\modules\fnc";
	#else
	file = "mcc\cfg\modules\fnc";
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
	class moduleCapturePoint {description = "Sets a capture point";};
	class vehicleRespawn {description = "respawn empty vehicles";};
	class inGameUI {description = "Manage inGameUI";};
};