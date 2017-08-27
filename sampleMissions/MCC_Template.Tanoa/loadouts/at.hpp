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
			class launch_NLAW_F
			{
				unlockLevel = 0;
				cfgname = "launch_NLAW_F";
				magazines[]= {"NLAW_F",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_F
			{
				unlockLevel = 15;
				cfgname = "launch_B_Titan_F";
				magazines[]= {"Titan_AA",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_short_F
			{
				unlockLevel = 25;
				cfgname = "launch_B_Titan_short_F";
				magazines[]= {"Titan_AT",2};
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
			class launch_RPG32_F
			{
				unlockLevel = 0;
				cfgname = "launch_RPG32_F";
				magazines[]= {"RPG32_F",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_F
			{
				unlockLevel = 15;
				cfgname = "launch_B_Titan_F";
				magazines[]= {"Titan_AA",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_short_F
			{
				unlockLevel = 25;
				cfgname = "launch_B_Titan_short_F";
				magazines[]= {"Titan_AT",2};
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
			class launch_RPG7_F
			{
				unlockLevel = 0;
				cfgname = "launch_RPG7_F";
				magazines[]= {"RPG7_F",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_F
			{
				unlockLevel = 15;
				cfgname = "launch_B_Titan_F";
				magazines[]= {"Titan_AA",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class launch_B_Titan_short_F
			{
				unlockLevel = 25;
				cfgname = "launch_B_Titan_short_F";
				magazines[]= {"Titan_AT",2};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};
};