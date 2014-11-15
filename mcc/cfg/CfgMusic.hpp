class ac130
{
	name = "ac130";
	titles[] = {};
	
	#ifdef MCCMODE
	sound[] = {"\mcc_sandbox_mod\mcc\sounds\ac130.ogg", 1, 1};
	#else
	sound[] = {"mcc\sounds\ac130.ogg", 1, 1};
	#endif
	
};

class mcc_wind
{
	name = "mcc_wind";
	titles[] = {};
	
	#ifdef MCCMODE
	sound[] = {"\mcc_sandbox_mod\mcc\sounds\wind.ogg", 1, 1};
	#else
	sound[] = {"mcc\sounds\wind.ogg", 1, 1};
	#endif
};

