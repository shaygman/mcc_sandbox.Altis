class undercover
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\undercover\fnc";
	#else
	file = "mcc\undercover\fnc";
	#endif

	class undercoverHandleGun {};
	class undercoverInit {};
	class undercoverNearTargets {};
};