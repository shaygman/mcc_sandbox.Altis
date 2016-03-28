class login
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\login\fnc";
	#else
	file = "mcc\login\fnc";
	#endif

	class loginDialog {};
	class assignCurator {};
};