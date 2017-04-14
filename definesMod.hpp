#define MCCPATH "\mcc_sandbox_mod\"
#define MCCVersion "(r20)"
#define MCCMODE true



//--------------------------Dialogs----------------------------------------------------
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_dialogs.hpp"
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3d_dialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_boxGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_groupsGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_MWMainDialog.hpp"

//----Console-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsole.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole2.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole3.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_missionSettings.hpp"

//----PDA-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\sqlPDA\mcc_SQLPDA.hpp"

//----Mission Wizard-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\MCCMW_briefingMap.hpp"

//----Curator-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInitDefines.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInit.hpp"

//----Logistics-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsLoadTruck.hpp"

//----Key Settings-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_rscKeyBinds.hpp"

//----medic-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\medic\mcc_uncMain.hpp"

//--------------------------------CP------------------------------------------------
#define CPPATH "\mcc_sandbox_mod\"
#define CPVersion "0.1"

#include "\mcc_sandbox_mod\mcc\roleSelection\cfg.hpp"

//--------------------------Campaign----------------------------------------------------
#include "\mcc_sandbox_mod\mcc\Dialogs\campaign\mcc_vehicleSpawner.hpp"

//--------------------------Dynamic dialog--------------------------
#include "\mcc_sandbox_mod\mcc\Dialogs\dynamicDialog\dynamicDialogUI.hpp"


//--------------------------Others----------------------------------------------------
#include "\mcc_sandbox_mod\bon_artillery\dialog\Artillery.hpp"
#include "\mcc_sandbox_mod\VAS\menu.hpp"
#include "\mcc_sandbox_mod\hcam\hcam.hpp"
#include "\mcc_sandbox_mod\spectator\spectating.hpp"

//--------------------------features----------------------------------------------------
#include "\mcc_sandbox_mod\mcc\login\cfg.hpp"
#include "\mcc_sandbox_mod\mcc\rts\cfg.hpp"
#include "\mcc_sandbox_mod\mcc\bombDefuse\cfg.hpp"
#include "\mcc_sandbox_mod\mcc\survive\cfg.hpp"
#include "\mcc_sandbox_mod\mcc\interaction\cfg.hpp"
#include "\mcc_sandbox_mod\mcc\LHD\cfg.hpp"

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#include "\mcc_sandbox_mod\gaia\cfgFunctions.hpp"
	#include "\mcc_sandbox_mod\VAS\cfgFunctions.hpp"

	class MCC
	{
		tag = "MCC";
		#include "\mcc_sandbox_mod\mcc\cfg\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\login\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\rts\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\cfg\modules\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\cfg\curator\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\undercover\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\bombDefuse\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\survive\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\HUD\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\roleSelection\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\interaction\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\radio\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\AAS\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\missionWizard\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\helpers\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\helicopters\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\ambient\cfgFunctions.hpp"
		#include "\mcc_sandbox_mod\mcc\LHD\cfgFunctions.hpp"
	};
};

class cfgRemoteExec {
	class Functions {
		// State of remoteExec: 0-turned off, 1-turned on, taking whitelist into account, 2-turned on, however, ignoring whitelists (default because of backward compatibility)
		mode = 2;
		// Ability to send jip messages: 0-disabled, 1-enabled (default)
		jip = 1;

		#include "\mcc_sandbox_mod\mcc\cfg\cfgRemoteExec.hpp"
		#include "\mcc_sandbox_mod\mcc\radio\cfgRemoteExec.hpp"
		#include "\mcc_sandbox_mod\mcc\AAS\cfgRemoteExec.hpp"
	};
};

class CfgObjectCompositions
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgObjectCompositions.hpp"
};

class CfgMusic
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgMusic.hpp"
};

class CfgSounds
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgSounds.hpp"
	#include "\mcc_sandbox_mod\mcc\ambient\CfgSounds.hpp"
};

class CfgNotifications
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgNotifications.hpp"
};

class RscTitles
{
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_InteractionRsc.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\compass.hpp"
	#include "\mcc_sandbox_mod\hcam\hcam.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3dObject.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\sqlPDA\MCC_SQLPDA_rsc.hpp"
	#include "\mcc_sandbox_mod\mcc\survive\dialogs\mcc_rscSurviveStats.hpp"
	#include "\mcc_sandbox_mod\mcc\HUD\cfg.hpp"

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

class cfgVehicles
{
	#include "\mcc_sandbox_mod\mcc\cfg\cfgVehicles.hpp"
};

class cfgMagazines
{
	class Default;
	class CA_Magazine: Default{};
	class HandGrenade: CA_Magazine{};
	class 1Rnd_HE_Grenade_shell;

	#include "\mcc_sandbox_mod\mcc\cfg\cfgMagazines.hpp"
};

class cfgWeapons
{
	class Default;
	class GrenadeLauncher: Default{};
	class arifle_MX_GL_F;
	class itemCore;
	class InventoryItem_Base_F;
	class Launcher_Base_F;
	#include "\mcc_sandbox_mod\mcc\cfg\cfgWeapons.hpp"
};

class CfgMarkers
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgMarkers.hpp"
};

class RscMapControl;
class RscText;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
//class RscButtonMenu;
class RscShortcutButton;
class RscAttributeText;
class RscAttributeOwners;
class RscCombo;
class RscCheckBox;

class TabSide;
class BLUFOR;
class OPFOR;
class Independent;
class Civilian;
class GroupList;
class UnitList;

class RscAttributeAreaSize;
class RscAttributeName;

//Extend Main menu
#include "\mcc_sandbox_mod\mcc\cfg\menuExt.hpp"

//Extend curator
#include "\mcc_sandbox_mod\mcc\cfg\curatorExt.hpp"

