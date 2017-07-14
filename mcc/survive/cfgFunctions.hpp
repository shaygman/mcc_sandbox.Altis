class survive {
	#ifdef MCCMODE
	file = "\mcc_sandbox_mod\mcc\survive\fnc";
	#else
	file = "mcc\survive\fnc";
	#endif

	class surviveInit {postinit = 1;};
	class surviveUseAntibiotics {};
	class surviveUseFood {};
	class surviveOpenCan {};
	class surviveIsCarWithFuel {};
	class surviveRefuel {};
	class surviveWaterTreatment {};
	class surviveUseItemHeadTorch {};
	class surviveBuild {};
	class getSurvivalPlaceHolders {};
	class loadGear {};
	class surviveItemClicked {};
	class handleInventoryClick {};
	class foodWaterConsumption {};
	class survivalProgressBars {};
	class spawnCratesInHouses {};
	class spawnCratesInHousesInit {description = "Spawn survival spawn crates in houses";};
};