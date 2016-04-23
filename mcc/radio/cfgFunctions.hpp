class radio
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\radio\fnc";
	#else
	file = "mcc\radio\fnc";
	#endif

	class vonRadio		{description = "simulate real radio comms on ArmA VON";};
	class settingsRadio	{description = "Real radio comms settings";};
	class VONRadioBroadcast {};
	class VONRadiofindChannel {};
	class VONRadioPressed {};
	class assignChannelServer{};
};