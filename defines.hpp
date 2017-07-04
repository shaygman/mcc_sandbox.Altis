#define MCCPATH ""
#define MCCVersion "(r23)"


//--------------------------Dialogs----------------------------------------------------
#include "mcc\dialogs\mcc_dialogs.hpp"

#include "mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "mcc\dialogs\mcc_3d_dialog.hpp"
#include "mcc\Dialogs\mcc_boxGen.hpp"
#include "mcc\Dialogs\mcc_groupsGen.hpp"
#include "mcc\Dialogs\mcc_MWMainDialog.hpp"

//----Console-----------------
#include "mcc\Dialogs\mcc_playerConsole.hpp"
#include "mcc\Dialogs\MCC_playerConsole2.hpp"
#include "mcc\Dialogs\MCC_playerConsole3.hpp"
#include "mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "mcc\Dialogs\mcc_missionSettings.hpp"

//----PDA-----------------
#include "mcc\Dialogs\sqlPDA\mcc_SQLPDA.hpp"

//----Mission Wizard-----------------
#include "mcc\Dialogs\MCCMW_briefingMap.hpp"

//----Curator-----------------
#include "mcc\Dialogs\mcc_curatorInitDefines.hpp"
#include "mcc\Dialogs\mcc_curatorInit.hpp"

//----Logistics-----------------
#include "mcc\Dialogs\mcc_logisticsLoadTruck.hpp"

//----Key Settings-----------------
#include "mcc\Dialogs\mcc_rscKeyBinds.hpp"

//---- test I should delete it at the end
#include "mcc\dialogs\test.hpp"
//--------------------------------CP------------------------------------------------

#define CPPATH ""
#define CPVersion "0.1"

#include "mcc\roleSelection\cfg.hpp"

//--------------------------Campaign----------------------------------------------------
#include "mcc\Dialogs\campaign\mcc_vehicleSpawner.hpp"

//--------------------------Dynamic dialog--------------------------
#include "mcc\Dialogs\dynamicDialog\dynamicDialogUI.hpp"

//--------------------------Others----------------------------------------------------
#include "bon_artillery\dialog\Artillery.hpp"
#include "VAS\menu.hpp"
#include "spectator\spectating.hpp"

//--------------------------features----------------------------------------------------
#include "mcc\login\cfg.hpp"
#include "mcc\rts\cfg.hpp"
#include "mcc\bombDefuse\cfg.hpp"
#include "mcc\survive\cfg.hpp"
#include "mcc\interaction\cfg.hpp"
#include "mcc\LHD\cfg.hpp"

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#include "gaia\cfgFunctions.hpp"
	#include "VAS\cfgFunctions.hpp"

	class MCC
	{
		tag = "MCC";
		#include "mcc\cfg\cfgFunctions.hpp"
		#include "mcc\login\cfgFunctions.hpp"
		#include "mcc\rts\cfgFunctions.hpp"
		#include "mcc\cfg\modules\cfgFunctions.hpp"
		#include "mcc\cfg\curator\cfgFunctions.hpp"
		#include "mcc\undercover\cfgFunctions.hpp"
		#include "mcc\bombDefuse\cfgFunctions.hpp"
		#include "mcc\survive\cfgFunctions.hpp"
		#include "mcc\HUD\cfgFunctions.hpp"
		#include "mcc\roleSelection\cfgFunctions.hpp"
		#include "mcc\interaction\cfgFunctions.hpp"
		#include "mcc\radio\cfgFunctions.hpp"
		#include "mcc\AAS\cfgFunctions.hpp"
		#include "mcc\missionWizard\cfgFunctions.hpp"
		#include "mcc\helpers\cfgFunctions.hpp"
		#include "mcc\helicopters\cfgFunctions.hpp"
		#include "mcc\ambient\cfgFunctions.hpp"
		#include "mcc\LHD\cfgFunctions.hpp"
	};
};

class cfgRemoteExec {
	class Functions {
		// State of remoteExec: 0-turned off, 1-turned on, taking whitelist into account, 2-turned on, however, ignoring whitelists (default because of backward compatibility)
		mode = 2;
		// Ability to send jip messages: 0-disabled, 1-enabled (default)
		jip = 1;
		#include "mcc\cfg\cfgRemoteExec.hpp"
		#include "mcc\radio\cfgRemoteExec.hpp"
		#include "mcc\AAS\cfgRemoteExec.hpp"
	};
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
	#include "mcc\ambient\CfgSounds.hpp"
};

class CfgNotifications
{
	#include "mcc\cfg\CfgNotifications.hpp"
};

class CfgMarkers
{
	#include "mcc\cfg\CfgMarkers.hpp"
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

	#include "mcc\dialogs\mcc_InteractionRsc.hpp"
	#include "mcc\dialogs\compass.hpp"
	#include "mcc\dialogs\mcc_3dObject.hpp"
	#include "mcc\dialogs\sqlPDA\MCC_SQLPDA_rsc.hpp"
	#include "mcc\survive\dialogs\mcc_rscSurviveStats.hpp"
	#include "mcc\HUD\cfg.hpp"

	//----medic-----------------
	#include "mcc\Dialogs\medic\mcc_uncMain.hpp"
};

class CfgDebriefing
{
	class KickRadio
	{
		title = "You were kicked";
		subtitle = "For abusing the radio";
		description = "You were kicked";
	};
};