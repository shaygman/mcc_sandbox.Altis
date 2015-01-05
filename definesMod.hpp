#define MCCPATH "\mcc_sandbox_mod\"
#define MCCVersion "0.1"
#define MCCMODE true

//--------------------------Dialogs----------------------------------------------------
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_dialogs.hpp"

#include "\mcc_sandbox_mod\mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3d_dialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_boxGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_groupsGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_loginDialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_MWMainDialog.hpp"

//----Console-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsole.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole2.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole3.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_missionSettings.hpp"

//----PDA-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_SQLPDA.hpp"

//----Mission Wizard-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\MCCMW_briefingMap.hpp"

//----Curator-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInitDefines.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInit.hpp"

//----Logistics-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsLoadTruck.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\rts\mcc_logisticsBaseBuild.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\rts\rtsMainBox.hpp"

//----Interaction-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_interactionMenu.hpp"

//----Key Settings-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_rscKeyBinds.hpp"

//----medic-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\medic\mcc_uncMain.hpp"

//--------------------------------CP------------------------------------------------
#define CPPATH "\mcc_sandbox_mod\"
#define CPVersion "0.1"

#include "\mcc_sandbox_mod\configs\dialogs\cp_dialogs.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\respawnPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\squadsPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\gearPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\weaponsPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\accessoriesPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\uniformPanel.hpp"

//--------------------------Others----------------------------------------------------
#include "\mcc_sandbox_mod\bon_artillery\dialog\Artillery.hpp"
#include "\mcc_sandbox_mod\VAS\menu.hpp"
#include "\mcc_sandbox_mod\hcam\hcam.hpp"

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#include "\mcc_sandbox_mod\gaia\cfgFunctions.hpp"
	#include "\mcc_sandbox_mod\mcc\cfg\cfgFunctions.hpp"
	#include "\mcc_sandbox_mod\VAS\cfgFunctions.hpp"

	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgFunctions.hpp"
};

class CfgObjectCompositions
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgObjectCompositions.hpp"
};

class CfgMusic
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgMusic.hpp"

	//super_flash
	#include "\mcc_sandbox_mod\super_flash\music\CfgMusic.hpp"
};

class CfgSounds
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgSounds.hpp"

	//super_flash
	#include "\mcc_sandbox_mod\super_flash\sounds\CfgSounds.hpp"
};

class CfgCloudlets
{
	//super_flash
	class Default;
	#include "\mcc_sandbox_mod\super_flash\CfgCloudlets.hpp"
};

class CfgLights
{
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgLights.hpp"
};

class CfgNotifications
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgNotifications.hpp"
};

class cfgRtsBuildings
{
	#include "\mcc_sandbox_mod\mcc\cfg\cfgRtsBuildings.hpp"
};

class RscTitles
{
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_InteractionRsc.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\compass.hpp"
	#include "\mcc_sandbox_mod\hcam\hcam.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3dObject.hpp"
};

class cfgVehicles
{
	#include "\mcc_sandbox_mod\mcc\cfg\cfgVehicles.hpp"
};

class CfgAmmo
{
	//super_flash
	class GrenadeHand;
	class G_40mm_HE;
	#include "\mcc_sandbox_mod\super_flash\CfgAmmo.hpp"
};

class cfgMagazines
{
	class Default;
	class CA_Magazine: Default{};
	class HandGrenade: CA_Magazine{};
	class 1Rnd_HE_Grenade_shell;

	#include "\mcc_sandbox_mod\mcc\cfg\cfgMagazines.hpp"

	//super_flash
	#include "\mcc_sandbox_mod\super_flash\cfgMagazines.hpp"
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

	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgWeapons.hpp"
};



class RscMapControl;
class RscText;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButtonMenu;
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

