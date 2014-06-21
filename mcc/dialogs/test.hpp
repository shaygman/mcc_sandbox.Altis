class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] = 
	{
	};


	//---------------------------------------------
	objects[] = 
	{ 	//(0.671875 * safezoneW + safezoneX) / safezoneW -X
	};	//(0.478009 * safezoneH + safezoneY) / safezoneH - Y

	class Controls
	{
		class nameBox : MCC_RscText 
		{
			idc = MCC_NAMEBOX;
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			colorSelection[] = {1,1,1,1};
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = true;
			
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.181124 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = 0.028;text = "";
		};
			
		class initBox : MCC_RscText
		{
			idc = MCC_INITBOX;
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			colorSelection[] = {1,1,1,1};
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = true;
			
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0549786 * safezoneH;
			sizeEx = 0.028;
			text = "";
		};
			
		class presetsCombo : MCC_RscCombo 
		{
			idc=MCC_PRESETS;
			colorBackground[] = {0,0,0,1};
			sizeEx=0.028;
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class unitNameTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.181124 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Name:";
		};
		
		class initTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0401042 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Init:";
		};
		
		class presetsTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Presets:";
		};
		
		class addPresetButton : MCC_RscButton 
		{
			idc=-1; colorDisabled[]={1,0.4,0.3,0.8};
			x = 0.150521 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0286458 * safezoneW;
			h = 0.0219914 * safezoneH;
			
			size=0.02; 
			sizeEx=0.02; 
			text="Add"; 
			onButtonClick=__EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
		};
	};
};