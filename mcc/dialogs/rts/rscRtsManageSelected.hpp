class interactionControlsGroup: MCC_RscControlsGroupNoScrollbars
{
	idc = -1;
	x = 0.654688 * safezoneW + safezoneX;
	y = 0.786 * safezoneH + safezoneY;
	w = 0.340312 * safezoneW;
	h = 0.209 * safezoneH;
	class controls
	{
		class status1Text: MCC_RscText
		{
			idc = 950;

			text = "offline"; //--- ToDo: Localize;
			x = 0.283594 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.05 * safezoneW;
			h = 0.022 * safezoneH;
		};
		/*
		class status2Text: MCC_RscText
		{
			idc = 951;

			text = "offline"; //--- ToDo: Localize;
			x = 0.309375 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.020625 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class constructionTab: MCC_RscButton
		{
			idc = 952;

			text = "Build"; //--- ToDo: Localize;
			x = 0.190781 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.020625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class unitsTab: MCC_RscButton
		{
			idc = 953;

			text = "Units"; //--- ToDo: Localize;
			x = 0.216563 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.020625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		*/
		class action1: MCC_RscActivePicture
		{
			idc = 9101;

			x = 0.190781 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action2: MCC_RscActivePicture
		{
			idc = 9102;

			x = 0.226875 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action3: MCC_RscActivePicture
		{
			idc = 9103;

			x = 0.262969 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action4: MCC_RscActivePicture
		{
			idc = 9104;

			x = 0.299063 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action5: MCC_RscActivePicture
		{
			idc = 9105;

			x = 0.190782 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action6: MCC_RscActivePicture
		{
			idc = 9106;

			x = 0.226875 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action7: MCC_RscActivePicture
		{
			idc = 9107;

			x = 0.262969 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action8: MCC_RscActivePicture
		{
			idc = 9108;

			x = 0.299063 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action9: MCC_RscActivePicture
		{
			idc = 9109;

			x = 0.190781 * safezoneW;
			y = 0.154 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action10: MCC_RscActivePicture
		{
			idc = 9110;

			x = 0.226875 * safezoneW;
			y = 0.154 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action11: MCC_RscActivePicture
		{
			idc = 9111;

			x = 0.262969 * safezoneW;
			y = 0.154 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class action12: MCC_RscActivePicture
		{
			idc = 9112;

			x = 0.299062 * safezoneW;
			y = 0.154 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class respic1: MCC_RscPicture
		{
			idc = 120;

			x = 0.0464065 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class resText1: MCC_RscText
		{
			idc = 121;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.0618752 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class respic2: MCC_RscPicture
		{
			idc = 122;

			x = 0.0825002 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class resText2: MCC_RscText
		{
			idc = 123;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.097969 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class respic3: MCC_RscPicture
		{
			idc = 124;

			x = 0.118594 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class resText3: MCC_RscText
		{
			idc = 125;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.134063 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class respic4: MCC_RscPicture
		{
			idc = 126;

			x = 0.154688 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class resText4: MCC_RscText
		{
			idc = 127;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.170156 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class desc: MCC_RscStructuredText
		{
			idc = 150;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.0464067 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.139219 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class sep1: MCC_RscFrame
		{
			idc = -1;

			x = 0.190781 * safezoneW;
			y = 0.033 * safezoneH;
			w = 0.139219 * safezoneW;
			h = 0.0055 * safezoneH;
		};
		class sep2: MCC_RscFrame
		{
			idc = -1;

			x = 0.0464063 * safezoneW;
			y = 1.02445e-008 * safezoneH;
			w = 0.28875 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class sep3: MCC_RscFrame
		{
			idc = -1;

			x = 0.00515625 * safezoneW;
			y = 0.022 * safezoneH;
			w = 0.04125 * safezoneW;
			h = 0.176 * safezoneH;
		};


		class upgrade1: MCC_RscActivePicture
		{
			idc = 9160;

			x = 0.0103127 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class upgrade2: MCC_RscActivePicture
		{
			idc = 9161;

			x = 0.0103125 * safezoneW;
			y = 0.099 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class upgrade3: MCC_RscActivePicture
		{
			idc = 9162;

			x = 0.0103122 * safezoneW;
			y = 0.154 * safezoneH;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};