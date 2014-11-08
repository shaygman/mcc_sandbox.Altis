#define AI_SKILL 8403 
#define AI_AIM 8404 
#define AI_SPOT 8405 
#define AI_COMMAND 8406
#define MCC_AISmokeIDC 8420
#define MCC_AISmokeChanceIDC 8421
#define MCC_GAIACacheDistanceIDC 8422
#define MCC_GAIAControllIDC 8423
#define MCC_GAIAArtilleryDelayIDC 8424

class rscGAIASettings: MCC_RscControlsGroupNoScrollbars
{
	idc = -1;
	x = 0.133906 * safezoneW + safezoneX;
	y = 0.368 * safezoneH + safezoneY;
	w = 0.665156 * safezoneW;
	h = 0.176 * safezoneH;
	
	class controls
	{
		class AISkillTittle: MCC_RscText
		{
			idc = -1;

			text = "AI General Skill:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AISkillSlider: MCC_RscCombo
		{
			idc = AI_SKILL;

			x = 0.118594 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AIAimTittle: MCC_RscText
		{
			idc = -1;

			text = "AI Aiming Skill:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AIAimSlider: MCC_RscCombo
		{
			idc = AI_AIM;

			x = 0.118594 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AISpotTittle: MCC_RscText
		{
			idc = -1;

			text = "AI Spotting Skill:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AISpotSlider: MCC_RscCombo
		{
			idc = AI_SPOT;

			x = 0.118594 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AICommandTittle: MCC_RscText
		{
			idc = -1;

			text = "AI Commanding Skill:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AICommandSlider: MCC_RscCombo
		{
			idc = AI_COMMAND;

			x = 0.118594 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class missionSettingsGAIATittle: MCC_RscText
		{
			idc = -1;

			text = "GAIA and AI:"; //--- ToDo: Localize;
			x = 0.293906 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.133125 * safezoneW;
			h = 0.0299633 * safezoneH;
			colorText[] = {0,1,1,1};
			colorBackground[] = {1,1,1,0};
		};
		class AISmokeTittle: MCC_RscText
		{
			idc = -1;

			text = "AI use smoke/flare:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AISmokeCombo: MCC_RscCombo
		{
			idc = MCC_AISmokeIDC;

			x = 0.309375 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Determine if the AI use smoke or flares"; //--- ToDo: Localize;
		};
		class GAIACacheTittle: MCC_RscText
		{
			idc = -1;

			text = "GAIA Cache distance:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class GAIACacheCombo: MCC_RscCombo
		{
			idc = MCC_GAIACacheDistanceIDC;

			x = 0.309375 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "How far a player must be from a GAIA controlled unit before it will be cahced"; //--- ToDo: Localize;
		};
		class AISmokeChanceTittle: MCC_RscText
		{
			idc = -1;

			text = "AI Smoke chance:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class AISmokeChanceCombo: MCC_RscCombo
		{
			idc = MCC_AISmokeChanceIDC;

			x = 0.309375 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Determine how often the AI will use smoke or flares"; //--- ToDo: Localize;
		};
		class GAIAControllsTittle: MCC_RscText
		{
			idc = -1;

			text = "GAIA Controlls:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class GAIAControllsCombo: MCC_RscCombo
		{
			idc = MCC_GAIAControllIDC;

			x = 0.309375 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "If enabled GAIA will control all units presents even if they have not given to GAIA"; //--- ToDo: Localize;
		};
		class GAIAArtilleryDelayTittle: MCC_RscText
		{
			idc = -1;

			text = "Artillery Delay:"; //--- ToDo: Localize;
			x = 0.386719 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class GAIAArtilleryDelayCombo: MCC_RscCombo
		{
			idc = MCC_GAIAArtilleryDelayIDC;

			x = 0.500156 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "How long before an artillery can be called again by the AI"; //--- ToDo: Localize;
		};
	};
};