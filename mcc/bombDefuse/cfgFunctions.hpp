class bombDefuse {
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\bombDefuse\fnc";
	#else
	file = "mcc\bombDefuse\fnc";
	#endif

	class initBombDefuse {};
	class bdWireModule {};
	class bdButtonsModule {};
	class bdNumpadModule {};
	class bdWatch {};
	class bdStart {};
	class bdCreateManual {postinit = 1;};
};