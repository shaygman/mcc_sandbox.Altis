class helicopters
{
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\helicopters\fnc";
	#else
	file = "mcc\helicopters\fnc";
	#endif

	class heliOpenCloseDoor		{description = "Animate closing or opening helicopters doors";};
	class heliPreciseLanding	{description = "Uses velocity to land an helicopter to a precise location";};
};