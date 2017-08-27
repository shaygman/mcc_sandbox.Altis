class at : rifleman
{
	name    = "Anti-Tank";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\AT.paa");
	minPlayersForKit = 2;
	maxKitsInGroup = 2;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 1;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		class secondary
		{
			class CUP_launch_M136
			{
				unlockLevel = 0;
				cfgname = "CUP_launch_M136";
				magazines[]= {"CUP_M136_M",3};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_Mk153Mod0
			{
				unlockLevel = 15;
				cfgname = "CUP_launch_Mk153Mod0";
				magazines[]= {"CUP_SMAW_HEAA_M",2,"CUP_SMAW_Spotting",2};
				attachments1[]= {{0,""},{3,"CUP_optic_SMAW_Scope"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_FIM92Stinger
			{
				unlockLevel = 25;
				cfgname = "CUP_launch_FIM92Stinger";
				magazines[]= {"CUP_Stinger_M",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};

	class east : east
	{
		class secondary
		{
			class CUP_launch_RPG18
			{
				unlockLevel = 0;
				cfgname = "CUP_launch_RPG18";
				magazines[]= {"CUP_RPG18_M",3};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_RPG7V
			{
				unlockLevel = 15;
				cfgname = "CUP_launch_RPG7V";
				magazines[]= {"CUP_PG7V_M",2,"CUP_PG7VL_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_PGO7V"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_9K32Strela
			{
				unlockLevel = 25;
				cfgname = "CUP_launch_9K32Strela";
				magazines[]= {"CUP_Strela_2_M",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};

	class guer : guer
	{
		class secondary
		{
			class CUP_launch_RPG18
			{
				unlockLevel = 0;
				cfgname = "CUP_launch_RPG18";
				magazines[]= {"CUP_RPG18_M",3};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_RPG7V
			{
				unlockLevel = 15;
				cfgname = "CUP_launch_RPG7V";
				magazines[]= {"CUP_PG7V_M",2,"CUP_PG7VL_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_PGO7V"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_launch_9K32Strela
			{
				unlockLevel = 25;
				cfgname = "CUP_launch_9K32Strela";
				magazines[]= {"CUP_Strela_2_M",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};
};