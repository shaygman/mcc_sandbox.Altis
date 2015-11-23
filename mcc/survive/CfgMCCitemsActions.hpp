class CfgMCCitemsActions
{
	class MCC_antibiotics
	{
		class take
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass, true] spawn MCC_fnc_surviveUseAntibiotics;";
			displayName = "Take Antibiotics";
		};
	};

	class MCC_painkillers
	{
		class take
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass, false] spawn MCC_fnc_surviveUseAntibiotics;";
			displayName = "Take Painkillers";
		};
	};

	class MCC_vitamine
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,100,-20] spawn MCC_fnc_surviveUseFood;";
			displayName = "Take Vitamins";
		};
	};

	class MCC_foodcontainer
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,1000,-50] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Food";
		};
	};

	class MCC_cerealbox
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,300,-20] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Cereals";
		};
	};

	class MCC_bacon_open
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,800,30] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Bacon";
		};
	};

	class MCC_bakedBeans_open
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,500,30] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Backed Beans";
		};
	};

	class MCC_rice
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,600,-80] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Rice";
		};
	};

	class MCC_powderedMilk
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,100,-10] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Powdered Milk";
		};
	};

	class MCC_franta
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,40,40,'MCC_can_dented',false] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Franta";
		};
	};

	class MCC_RedGull
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,40,40,'MCC_can_dented',false] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink RedGull";
		};
	};

	class MCC_Spirit
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,40,40,'MCC_can_dented',false] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Spirit";
		};
	};

	class MCC_fruit1
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,random 30,random 50,'',true,10] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Strange Fruit";
		};
	};

	class MCC_fruit2
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,random 50,random 30,'',true,10] spawn MCC_fnc_surviveUseFood;";
			displayName = "Eat Strange Fruit";
		};
	};

	class MCC_bakedBeans
	{
		class Open
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "('MCC_canOpener' in (items player) || 'MCC_screwdriver' in (items player))";
			function = "[_itemClass,'MCC_bakedBeans_open'] spawn MCC_fnc_surviveOpenCan;";
			displayName = "Open Can";
		};
	};

	class MCC_bacon
	{
		class Open
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "('MCC_canOpener' in (items player) || 'MCC_screwdriver' in (items player))";
			function = "[_itemClass,'MCC_bacon_open'] spawn MCC_fnc_surviveOpenCan;";
			displayName = "Open Can";
		};
	};

	class MCC_bottle_water
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,0,100,'MCC_bottle_empty',false] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Water";
		};
	};

	class MCC_bottle_empty
	{
		class fillWater
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "surfaceIsWater position player";
			function = "[_itemClass,'MCC_bottle_murky','','Filling'] spawn MCC_fnc_surviveWaterTreatment;";
			displayName = "Fill Water";
		};

		class takeFuel
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "[true] call MCC_fnc_surviveIsCarWithFuel";
			function = "[_itemClass,'MCC_fuelbot',0.1,true] spawn MCC_fnc_surviveRefuel;";
			displayName = "Take Fuel";
		};
	};

	class MCC_bottle_murky
	{
		class pureWater
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "'MCC_waterpure' in (items player)";
			function = "[_itemClass,'MCC_bottle_water','MCC_waterpure','Purificatting Water'] spawn MCC_fnc_surviveWaterTreatment;";
			displayName = "Purificat Water";
		};

		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,0,100,'MCC_bottle_empty',true,100] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Murky Waters";
		};
	};

	class MCC_fuelbot
	{
		class fillFuel
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "[false] call MCC_fnc_surviveIsCarWithFuel";
			function = "[_itemClass,'MCC_bottle_empty',0.1,false] spawn MCC_fnc_surviveRefuel;";
			displayName = "Refuel";
		};
	};

	class MCC_fuelCan_empty
	{
		class takeFuel
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "[true] call MCC_fnc_surviveIsCarWithFuel";
			function = "[_itemClass,'MCC_fuelCan',0.3,true] spawn MCC_fnc_surviveRefuel;";
			displayName = "Take Fuel";
		};
	};

	class MCC_fuelCan
	{
		class fillFuel
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "[false] call MCC_fnc_surviveIsCarWithFuel";
			function = "[_itemClass,'MCC_fuelCan_empty',0.3,false] spawn MCC_fnc_surviveRefuel;";
			displayName = "Refuel";
		};
	};

	class MCC_canteenWater
	{
		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,0,80,'MCC_canteen',false] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Water";
		};
	};

	class MCC_canteen
	{
		class fillWater
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "surfaceIsWater position player";
			function = "[_itemClass,'MCC_canteenMurky','','Filling'] spawn MCC_fnc_surviveWaterTreatment;";
			displayName = "Fill Water";
		};
	};

	class MCC_canteenMurky
	{
		class pureWater
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "'MCC_waterpure' in (items player)";
			function = "[_itemClass,'MCC_canteenWater','MCC_waterpure','Purificatting Water'] spawn MCC_fnc_surviveWaterTreatment;";
			displayName = "Purificat Water";
		};

		class Eat
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "";
			function = "[_itemClass,0,80,'MCC_canteen',true,100] spawn MCC_fnc_surviveUseFood;";
			displayName = "Drink Murky Waters";
		};
	};

	class MCC_headTorch
	{
		class turnOn
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "(player getVariable ['MCC_headTorchBattery',100])>0 && isnull(player getVariable ['MCC_headTorch',objnull])";
			function = "[_itemClass,0] spawn MCC_fnc_surviveUseItemHeadTorch;";
			displayName = "Turn On";
		};

		class turnOff
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "!isnull(player getVariable ['MCC_headTorch',objnull])";
			function = "[_itemClass,1] spawn MCC_fnc_surviveUseItemHeadTorch;";
			displayName = "Turn Off";
		};

		class switchBattery
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "'MCC_battery' in items player";
			function = "[_itemClass,2] spawn MCC_fnc_surviveUseItemHeadTorch;";
			displayName = "Load Battery";
		};
	};

	class MCC_matches
	{
		class campFire
		{
			#ifdef MCCMODE
			icon = "";
			#else
			icon = "";
			#endif

			condition = "'MCC_wood' in items player";
			function = "[_itemClass,'Land_Campfire_F','MCC_wood',true] spawn MCC_fnc_surviveBuild;";
			displayName = "Create Camp Fire";
		};
	};
};