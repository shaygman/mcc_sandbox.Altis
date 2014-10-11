#define MCCPATH ""
#define MCCVersion "0.1"

//--------------------------Dialogs----------------------------------------------------
#include "mcc\dialogs\mcc_dialogs.hpp"

#include "mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "mcc\dialogs\mcc_3d_dialog.hpp"
#include "mcc\Dialogs\mcc_boxGen.hpp"
#include "mcc\Dialogs\mcc_groupsGen.hpp"
#include "mcc\Dialogs\mcc_loginDialog.hpp"
#include "mcc\Dialogs\mcc_MWMainDialog.hpp"

//----Console-----------------
#include "mcc\Dialogs\mcc_playerConsole.hpp"
#include "mcc\Dialogs\MCC_playerConsole2.hpp"
#include "mcc\Dialogs\MCC_playerConsole3.hpp"
#include "mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "mcc\Dialogs\mcc_missionSettings.hpp"

//----PDA-----------------
#include "mcc\Dialogs\mcc_SQLPDA.hpp"

//----Mission Wizard-----------------
#include "mcc\Dialogs\MCCMW_briefingMap.hpp"

//----Curator-----------------
#include "mcc\Dialogs\mcc_curatorInitDefines.hpp"
#include "mcc\Dialogs\mcc_curatorInit.hpp"

//----Logistics-----------------
#include "mcc\Dialogs\mcc_logisticsLoadTruck.hpp"
#include "mcc\Dialogs\mcc_logisticsBaseBuild.hpp"

//---- test I should delete it at the end
#include "mcc\dialogs\test.hpp"
//--------------------------------CP------------------------------------------------

#define CPPATH ""
#define CPVersion "0.1"

#include "configs\dialogs\cp_dialogs.hpp"
#include "configs\dialogs\gearPanel\respawnPanel.hpp"
#include "configs\dialogs\gearPanel\squadsPanel.hpp"
#include "configs\dialogs\gearPanel\gearPanel.hpp"
#include "configs\dialogs\gearPanel\weaponsPanel.hpp"
#include "configs\dialogs\gearPanel\accessoriesPanel.hpp"
#include "configs\dialogs\gearPanel\uniformPanel.hpp"

// F3 - Menu components

// Menu components for the JIP Menu
#include "f\JIP\f_JIP_kitpicker.h"
#include "f\JIP\f_JIP_grppicker.h"

// Menu components for the Spectator Script
#include "f\spect\config.hpp"

//--------------------------Others----------------------------------------------------
#include "bon_artillery\dialog\Artillery.hpp"
#include "VAS\menu.hpp"
#include "spectator\spectating.hpp"

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#include "gaia\cfgFunctions.hpp"
	#include "f\cfgFunctions.hpp"
	#include "VAS\cfgfunctions.hpp"
	#include "ais_injury\cfgFunctionsAIS.hpp"		//Mission only
	#include "mcc\cfg\cfgFunctions.hpp"
};

class CfgObjectCompositions
{
	#include "mcc\cfg\CfgObjectCompositions.hpp"
};

class CfgMusic
{
	#include "mcc\cfg\CfgMusic.hpp"
};

class CfgSounds
{
	#include "mcc\cfg\CfgSounds.hpp"
};

class CfgNotifications
{
	#include "mcc\cfg\CfgNotifications.hpp"
};

class RscTitles
{
	titles[]={"img"};

	class img
	{
		idd=-1;
		movingEnable=0;
		duration=5;
		fadein=2;
        fadeout = 1;
		name="img";
		controls[]={"GR"};

		class GR : MCC_RscPicture
		{
			style=48;
			text= "title.jpg";
			sizeEx = 0.4;
			x=0.25;
            y=0.3;
            w=0.5;
            h=0.4;
        };
	};

	#include "mcc\dialogs\compass.hpp"
	#include "ais_injury\dialogs\rscTitlesAIS.hpp"	//A3 wounding system
};
