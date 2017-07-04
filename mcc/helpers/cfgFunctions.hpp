class helpers
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\helpers\fnc";
	#else
	file = "mcc\helpers\fnc";
	#endif

	class helpersInit		{description = "init help tutorials";};
	class createHelper		{description = "Create ingame UI helper for interacted objects";};
	class deleteHelper		{description = "Delete ingame UI helper for interacted objects";};
};