class LHD
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\lhd\fnc";
	#else
	file = "mcc\lhd\fnc";
	#endif

	class LHDspawn {description = "Spawn CUP LHD at a given position and set it as a MCC's start location";};
	class arrestingGear {description = "Spawn CUP LHD at a given position and set it as a MCC's start location";};
	class LHDspawnVehicle {description = "Handles spawn vehicles on LHD requests";};
	class LHDspawnMenuInit {description = "Opens the CUP LHD spawn menu";};
};