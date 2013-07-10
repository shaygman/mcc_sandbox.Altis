// By: Shay_gman
// Version: 1.1 (September 2011)
#define missionSettings_IDD 2997

#define RESISTANCE_HOSTILE 8401 
#define T2T_AD 8402
#define AI_SKILL 8403 
#define AI_AIM 8404 
#define AI_SPOT 8405 
#define AI_COMMAND 8406
 

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class missionSettings {
  idd = missionSettings_IDD;
  movingEnable = true;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_missionSettings_init.sqf'"); 
  
  controlsBackground[] = 
  {
  RscPicture_1200
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
	missionSettingsTittle,
	resistanceHostileTittle,
	resistanceHostileCombo,
	t2tTittle,
	t2tCombo,
	AISkillTittle,
	AISkillSlider,
	AIAimTittle,
	AIAimSlider,
	AISpotTittle,
	AISpotSlider,
	AICommandTittle,
	AICommandSlider,
	confirmButton,
	CancelButton
  };
  
//========================================= Background========================================
	class RscPicture_1200: MCC_RscText {idc = -1;moving = true;x = 0.28125 * safezoneW + safezoneX;	y = 0.272481 * safezoneH + safezoneY;	w = 0.39375 * safezoneW; h = 0.455038 * safezoneH; text = "";colorBackground[] = { 0, 0, 0, 0.6 };};
//Tittle
	class missionSettingsTittle: MCC_RscText {idc = -1;text = "Mission Settings:";style = MCCST_LEFT;colorBackground[] = {1,1,1,0};colorText[] = {0,1,1,1};x = 0.41 * safezoneW + safezoneX;y = 0.289982 * safezoneH + safezoneY;w = 0.133125 * safezoneW;h = 0.0299633 * safezoneH;sizeEx =0.04;};
	/*
//Artillery
	class artilleryPerHourTittle: MCC_RscText {idc = -1;text = "Artillery rounds per hour:";style = MCCST_LEFT;colorBackground[] = { 1, 1, 1, 0 };colorText[] = { 1, 1, 1, 1 };x = 0.303125 * safezoneW + safezoneX;y = 0.324985 * safezoneH + safezoneY;w = 0.195625 * safezoneW;h = 0.0739125 * safezoneH;};
	class artilleryPerHourCombo: MCC_RscCombo {idc = ARTILLERY_PH ;x = 0.5875 * safezoneW + safezoneX;y = 0.359988 * safezoneH + safezoneY;w = 0.0687499 * safezoneW;h = 0.0211735 * safezoneH;};
//UnderCover
	class underCoverDetectedTittle: artilleryPerHourTittle {idc = -1;text = "Undercover Agents Detected By:";x = 0.303125 * safezoneW + safezoneX;y = 0.359988 * safezoneH + safezoneY;w = 0.25 * safezoneW;h = 0.0709826 * safezoneH;};
	class underCoverDetectedCombo: MCC_RscCombo {idc = UNDERCOVER_DETECT;x = 0.5875 * safezoneW + safezoneX;y = 0.394991 * safezoneH + safezoneY;w = 0.0687499 * safezoneW;h = 0.0211735 * safezoneH;};
	*/
//Resistance
	class resistanceHostileTittle: MCC_RscText {idc = -1;colorText[] = { 1, 1, 1, 1 };text = "Resistance Hostile To:";x = 0.303125 * safezoneW + safezoneX;y = 0.324985 * safezoneH + safezoneY;w = 0.195625 * safezoneW;h = 0.0739125 * safezoneH;};
	class resistanceHostileCombo: MCC_RscCombo{idc = RESISTANCE_HOSTILE;x = 0.5875 * safezoneW + safezoneX;y = 0.359988 * safezoneH + safezoneY;w = 0.0687499 * safezoneW;h = 0.0211735 * safezoneH;};
//Teleport 2 Team
	class t2tTittle: resistanceHostileTittle {idc = -1;text = "Teleport To Team:";x = 0.303125 * safezoneW + safezoneX;y = 0.359988 * safezoneH + safezoneY;w = 0.25 * safezoneW;h = 0.0709826 * safezoneH;};
	class t2tCombo: MCC_RscCombo {idc = T2T_AD;x = 0.5875 * safezoneW + safezoneX;y = 0.394991 * safezoneH + safezoneY;w = 0.0687499 * safezoneW;h = 0.0211735 * safezoneH;};
	
//AI Skill
	class AISkillTittle: resistanceHostileTittle {idc = -1;text = "AI General Skill:";x = 0.303125 * safezoneW + safezoneX;y = 0.435 * safezoneH + safezoneY;w = 0.12 * safezoneW;h = 0.0641461 * safezoneH;};
	class AISkillSlider: MCC_RscCombo {idc = AI_SKILL;x = 0.489062 * safezoneW + safezoneX;y = 0.46 * safezoneH + safezoneY;w = 0.079375 * safezoneW;h = 0.0182437 * safezoneH;};

//AI Aim
	class AIAimTittle: resistanceHostileTittle {idc = -1;text = "AI Aiming Skill:";x = 0.303125 * safezoneW + safezoneX;y = 0.465 * safezoneH + safezoneY;w = 0.12 * safezoneW;h = 0.0641461 * safezoneH;};
	class AIAimSlider: MCC_RscCombo {idc = AI_AIM;x = 0.489062 * safezoneW + safezoneX;y = 0.49 * safezoneH + safezoneY;w = 0.079375 * safezoneW;h = 0.0182437 * safezoneH;};
	
//AI Spot
	class AISpotTittle: resistanceHostileTittle {idc = -1;text = "AI Spotting Skill:";x = 0.303125 * safezoneW + safezoneX;y = 0.495 * safezoneH + safezoneY;w = 0.12 * safezoneW;h = 0.0641461 * safezoneH;};
	class AISpotSlider: MCC_RscCombo {idc = AI_SPOT;x = 0.489062 * safezoneW + safezoneX;y = 0.52 * safezoneH + safezoneY;w = 0.079375 * safezoneW;h = 0.0182437 * safezoneH;};
	
//AI Command
	class AICommandTittle: resistanceHostileTittle {idc = -1;text = "AI Commanding Skill:";x = 0.303125 * safezoneW + safezoneX;y = 0.525 * safezoneH + safezoneY;w = 0.14 * safezoneW;h = 0.0641461 * safezoneH;};
	class AICommandSlider: MCC_RscCombo {idc = AI_COMMAND;x = 0.489062 * safezoneW + safezoneX;y = 0.55 * safezoneH + safezoneY;w = 0.079375 * safezoneW;h = 0.0182437 * safezoneH;};
	
//Buttons	
	class confirmButton: MCC_RscButton {idc = -1;text = "Confirm";x = 0.346875 * safezoneW + safezoneX;y = 0.657513 * safezoneH + safezoneY;w = 0.120312 * safezoneW;h = 0.0525044 * safezoneH;action =  __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");};
	class CancelButton: MCC_RscButton {idc = -1;text = "Cancel";x = 0.5 * safezoneW + safezoneX;y = 0.657513 * safezoneH + safezoneY;w = 0.120312 * safezoneW;h = 0.0525044 * safezoneH;action = "closeDialog 0";};
 };
