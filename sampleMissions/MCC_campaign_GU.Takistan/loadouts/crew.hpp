class crew : rifleman
{
	name    = "Crewman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Crew.paa");
	minPlayersForKit = 0;
	maxKitsInGroup = 99;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 1;

	class west : west
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		backpacks[]= {};
	};

	class east : east
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		backpacks[]= {};
	};

	class guer : guer
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		backpacks[]= {};
	};
};