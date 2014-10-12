//--------------------------Dialogs----------------------------------------------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_dialogs.hpp"
#else
	#include "mcc\dialogs\mcc_dialogs.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_saveLoadScreen.hpp"
#else
	#include "mcc\dialogs\mcc_saveLoadScreen.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3d_dialog.hpp"
#else
	#include "mcc\dialogs\mcc_3d_dialog.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_boxGen.hpp"
#else
	#include "mcc\Dialogs\mcc_boxGen.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_groupsGen.hpp"
#else
	#include "mcc\Dialogs\mcc_groupsGen.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_loginDialog.hpp"
#else
	#include "mcc\Dialogs\mcc_loginDialog.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_MWMainDialog.hpp"
#else
	#include "mcc\Dialogs\mcc_MWMainDialog.hpp"
#endif

//----Console-----------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsole.hpp"
#else
	#include "mcc\Dialogs\mcc_playerConsole.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole2.hpp"
#else
	#include "mcc\Dialogs\MCC_playerConsole2.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole3.hpp"
#else
	#include "mcc\Dialogs\MCC_playerConsole3.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#else
	#include "mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_missionSettings.hpp"
#else
	#include "mcc\Dialogs\mcc_missionSettings.hpp"
#endif

//----PDA-----------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_SQLPDA.hpp"
#else
	#include "mcc\Dialogs\mcc_SQLPDA.hpp"
#endif

//----Mission Wizard-----------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\MCCMW_briefingMap.hpp"
#else
	#include "mcc\Dialogs\MCCMW_briefingMap.hpp"
#endif

//----Curator-----------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInitDefines.hpp"
#else
	#include "mcc\Dialogs\mcc_curatorInitDefines.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInit.hpp"
#else
	#include "mcc\Dialogs\mcc_curatorInit.hpp"
#endif

//----Logistics-----------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsLoadTruck.hpp"
#else
	#include "mcc\Dialogs\mcc_logisticsLoadTruck.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsBaseBuild.hpp"
#else
	#include "mcc\Dialogs\mcc_logisticsBaseBuild.hpp"
#endif

//---- test I should delete it at the end
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\mcc\dialogs\test.hpp"
#else
	#include "mcc\dialogs\test.hpp"
#endif

//--------------------------------CP------------------------------------------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\cp_dialogs.hpp"
#else
	#include "configs\dialogs\cp_dialogs.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\respawnPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\respawnPanel.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\squadsPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\squadsPanel.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\gearPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\gearPanel.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\weaponsPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\weaponsPanel.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\accessoriesPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\accessoriesPanel.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\uniformPanel.hpp"
#else
	#include "configs\dialogs\gearPanel\uniformPanel.hpp"
#endif

//--------------------------Others----------------------------------------------------
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\bon_artillery\dialog\Artillery.hpp"
#else
	#include "bon_artillery\dialog\Artillery.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\VAS\menu.hpp"
#else
	#include "VAS\menu.hpp"
#endif
#ifdef MCCMODE
	#include "\mcc_sandbox_mod\spectator\spectating.hpp"
#else
	#include "spectator\spectating.hpp"
#endif

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\gaia\cfgFunctions.hpp"
	#else
		#include "gaia\cfgFunctions.hpp"
	#endif
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\cfg\cfgFunctions.hpp"
	#else
		#include "mcc\cfg\cfgFunctions.hpp"
	#endif
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\VAS\cfgFunctions.hpp"
	#else
		#include "VAS\cfgFunctions.hpp"
	#endif
	#ifndef MCCMODE
		#include "ais_injury\cfgFunctionsAIS.hpp"
	#endif
};

class CfgObjectCompositions
{
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\cfg\CfgObjectCompositions.hpp"
	#else
		#include "mcc\cfg\CfgObjectCompositions.hpp"
	#endif
};

class CfgMusic
{
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\cfg\CfgMusic.hpp"
	#else
		#include "mcc\cfg\CfgMusic.hpp"
	#endif
};

class CfgSounds
{
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\cfg\CfgSounds.hpp"
	#else
		#include "mcc\cfg\CfgSounds.hpp"
	#endif
};

class CfgNotifications
{
	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\cfg\CfgNotifications.hpp"
	#else
		#include "mcc\cfg\CfgNotifications.hpp"
	#endif
};

class RscTitles
{
	#ifndef MCCMODE
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
	#endif

	#ifdef MCCMODE
		#include "\mcc_sandbox_mod\mcc\dialogs\compass.hpp"
	#else
		#include "mcc\dialogs\compass.hpp"
	#endif
	#ifndef MCCMODE
		#include "ais_injury\dialogs\rscTitlesAIS.hpp"
	#endif
};
