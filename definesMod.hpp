#define MCCPATH "\mcc_sandbox_mod\"
#define MCCVersion "0.1"
#define MCCMODE true

#include "\mcc_sandbox_mod\mcc\dialogs\mcc_dialogs.hpp"


#include "\mcc_sandbox_mod\mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3d_dialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_boxGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_groupsGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_loginDialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_MWMainDialog.hpp"

#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsole.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole2.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole3.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_missionSettings.hpp"

#include "\mcc_sandbox_mod\mcc\Dialogs\MCCMW_briefingMap.hpp"

#include "\mcc_sandbox_mod\mcc\Dialogs\compass.hpp"
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
//#include "\mcc_sandbox_mod\VAS\menu.hpp"
#include "\mcc_sandbox_mod\spectator\spectating.hpp"
#include "\mcc_sandbox_mod\hcam\hcam.hpp"
//---------------------------Functions------------------------------------------------

class RscTitles
{
	#include "\mcc_sandbox_mod\mcc\dialogs\compass.hpp"
	#include "\mcc_sandbox_mod\hcam\hcam.hpp"
};

class CfgFunctions
{
	class MCC
	{
		tag = "MCC";
		
		class general
		{
			file = "\mcc_sandbox_mod\mcc\fnc\general";
			
			class pre_init
			{
				preInit = 1;
				description = "Pre init mod only";
			};
			
			class mobileRespawn
			{
				description = "will move the respawn marker to the current position of the unit while the unit is alive, if the unit dead will move the marker to the prvious location.";
			};
			
			class buildingPosCount
			{
				description = "return the ammount of indexed positions in a building.";
			};
			
			class makeUnitsArray
			{
				description = "returns a unit array consist of all the units from the given function and simulation in format [_cfgclass,_vehicleDisplayName].";
			};
			
			class countGroup
			{
				description = "Count the number of infantry, vehicles, tank, air, ships in a group.";
			};
			
			class PiPOpen
			{
				description = "Do the transmitting feed animation.";
			};
			
			class time2String
			{
				description = "convert time to string.";
			};
			
			class time
			{
				description = "convert time to hh:mm:ss.";
			};
			
			class setVehicleInit
			{
				description = "Sets vehicle init.";
			};
			
			class setVehicleName
			{
				description = "Sets vehicle name.";
			};
			
			class setTime
			{
				description = "Setstime on all clients.";
			};
			
			class setWeather
			{
				description = "Sets weather  on all clients  - skip time by one hour to make the weather change.";
			};
			
			class globalSay3D
			{
				description = "Say sound on 3d on all clients.";
			};
			
			class globalHint
			{
				description = "Broadcast a meesege on all clients.";
			};
			
			class globalExecute
			{
				description = "Global execute a command on selected clients or server.";
			};
			
			class groupChat
			{
				description = "Send chat across MP.";
			};
			
			class moveToPos
			{
				description = "move an object to a new location.";
			};
			
			class pickItem
			{
				description = "Make a vehicle class item pickable and add variable to it.";
			};
			
			class broadcast
			{
				description = "Create a virtual camera and broadcast a short PiP video to all clients for 15 seconds.";
			};
			
			class paradrop
			{
				description = "Create a HALO or regular parachute jump for the given unit.";
			};
			
			class countGroupHC
			{
				description = "Count the number of infantry, vehicles, tank, air, ships in a group expand.";
			};
			
			class manageWp
			{
				description = "Create and control AI WP on map.";
			};
			
			class sync
			{
				description = "Sync the player with the server.";
			};
			
			class objectMapper
			{
				description = "Takes an array of data about a dynamic object template and creates the objects.";
			};
			
			class findRoadsLeadingZone
			{
				description = "Find Road segments leading to an area.";
			};
			
			class nearestRoad
			{
				description = "Return a Road segments array near positions";
			};
			
			class garrison
			{
				description = "Populate soldiers inside empty houses";
			};
			
			class saveToSQM
			{
				description = "Save MCC's 3D editor placments in SQM file format and copy it to clipboard";
			};
			
			class saveToComp
			{
				description = "Save MCC's 3D editor placments in composition format";
			};
			
			class replaceString
			{
				description = "Filter a string and removes certain characters ( _filter)";
			};
			
			class dirToString
			{
				description = "Get direction integer and return it as a strin North, east exc";
			};
			
			class startLocations
			{
				description = "Teleport the player when start location has been found";
			};
			
			class spawnGroup
			{
				description = "MCC Custom group spawning";
			};
			
			class createTask
			{
				description = "create a simple task with trigger assigned to a specific object";
			};
		};
		
		class ui
		{
			file = "\mcc_sandbox_mod\mcc\fnc\ui";

			class countDownLine
			{
				description = "Create a filling waiting bar - made by BIS all credits to them.";
			};
			
			class drawLine
			{
				description = " Draw an arrow on the map localy between two points.";
			};
			
			class drawArrow
			{
				description = " Expand:Draw a line on the map localy between two points.";
			};
			
			class drawBox
			{
				description = "Draw a box on the map localy between two points.";
			};
			
			class trackUnits
			{
				description = "Track units on the given map display";
			};
		};
		
		class ied
		{
			file = "\mcc_sandbox_mod\mcc\fnc\ied";

			class IedFakeExplosion
			{
				description = "Create a fake explosion.";
			};
			
			class IedDeadlyExplosion
			{
				description = "Create a deadly explosion.";
			};
			
			class IedDisablingExplosion
			{
				description = "Create a disabling explosion.";
			};
			
			class ACSingle
			{
				description = "Create an armed civilian at the given position.";
			};
			
			class trapSingle
			{
				description = "Create an IED at the given position.";
			};
			
			class iedHit
			{
				description = "Determine what will happened when an IED got hit.";
			};
			
			class ambushSingle
			{
				description = "Create an ambush group.";
			};
		};
		
		class cas
		{
			file = "\mcc_sandbox_mod\mcc\fnc\cas";

			class CreateAmmoDrop
			{
				description = "drop an object from a plane and attach paracute to it, thanks to BIS.";
			};
			
			class createPlane
			{
				description = "create a flying plane from the given type and return the plane , pilot and group.";
			};
			
			class deletePlane
			{
				description = "set a plane to move to a location and delete it once it come closer then 800 meters.";
			};
			
		};
		
		class artillery
		{
			file = "\mcc_sandbox_mod\mcc\fnc\artillery";

			class CBU
			{
				description = "drop a bomb that explode to some skeets with paracute the explode to some kind of CBU.";
			};
			
			class SADARM
			{
				description = "drop a bomb that explode to some skeets that will search and destroy near by armor.";
			};
			
			class artyBomb
			{
				description = "Create artillery strike with sounds on given spot.";
			};
			
			class artyFlare
			{
				description = "Create a flare.";
			};
			
			class artyDPICM
			{
				description = "Create DPICM artillery barage.";
			};
			
			class amb_Art
			{
				description = "Create ambient artillery barage.";
			};
			
		};
		
		class console
		{
			file = "\mcc_sandbox_mod\mcc\fnc\console";

			class consoleClickGroupIcon
			{
				description = "Define icon behaviot when clicked on the MCC Console";
			};
		};
		
		class groupGen
		{
			file = "\mcc_sandbox_mod\mcc\fnc\groupGen";

			class groupGenRefresh
			{
				description = "Refresh the group gen markers";
			};
			
			class groupSpawn
			{
				description = "Create a group on the server";
			};
			
			class groupGenUMRefresh
			{
				description = "Refresh the group gen units lists";
			};
		};
		
		class missionWizard
		{
			file = "\mcc_sandbox_mod\mcc\fnc\missionWizard";
			
			class MWFindMissionCenter
			{
				description = "Find the mission Wizard's center";
			};
			
			class MWbuildLocations
			{
				description = "If the map have locations system it will build the locations";
			};
			
			class MWCreateTask
			{
				description = "Create Task";
			};
			
			class MWFindbuildingPos
			{
				description = "Scan for buildings and building's pos";
			};
			
			class MWfindObjectivePos
			{
				description = "Create objective position";
			};
			
			class MWObjectiveHVT
			{
				description = "Create an HVT objective";
			};
			
			class MWObjectiveDestroy
			{
				description = "Create a Destroy objective";
			};
			
			class MWObjectiveIntel
			{
				description = "Create a pick intel objective";
			};
			
			class MWObjectiveClear
			{
				description = "Create a clear area objective";
			};
			
			class MWObjectiveDisable
			{
				description = "Create a disable IED area objective";
			};
			
			class MWCreateUnitsArray
			{
				description = " Create units array by type";
			};
			
			class MWUpdateZone
			{
				description = " Create or update a new zone";
			};
			
			class MWSpawnInZone
			{
				description = "Spawn units or groups in a zone";
			};
			
			class MWSpawnInfantry
			{
				description = "Spawn infantry groups in the zone.";
			};
			
			class MWSpawnVehicles
			{
				description = "Spawn vehicles in the zone.";
			};
			
			class buildRoadblock
			{
				description = "Create a road block in the given position and direction.";
			};
			
			class MWopenBriefing
			{
				description = "Create The breifings.";
			};
			
			class MWMapTooltip
			{
				description = "Create The tooltips on breifings.";
			};
			
			class MWreinforcement
			{
				description = "Create a reinforcment type.";
			};
			
			class MWSpawnStatic
			{
				description = "Spawn static weapons in the zone.";
			};
		};
		
		class ai
		{
			file = "\mcc_sandbox_mod\mcc\fnc\ai";
			
			class garrisonBehavior
			{
				description = "Contorol units under garrison behavior.";
			};
			
			class paratroops
			{
				description = "Contorol the paratroop reinforcement spawn.";
			};
			
			class reinforcement
			{
				description = "Contorol the motorized reinforcement spawn.";
			};
			
			class setUnitPos
			{
				description = "Sets units pos.";
			};
		};
		
	};
	
	/*
	class VAS
	{
		tag = "VAS";
		class functions
		{
			file = "\mcc_sandbox_mod\VAS\functions";
			class onRespawn {description = "Called when a selected loadout is set to be loaded on respawn.";};
			class deleteGear {description = "Deletes the selected slot from the profileNamespace.";};
			class loadoutInfo {description = "Pulls up information about the selected slot and displays it.";};
			class loadGear {description = "Loads the selected VAS saved slot.";};
			class saveGear {description = "Saves current gear into selected slot for VAS.";};
			class SaveLoad {description = "Handles request and pulls up either the load menu or save menu.";};
			class details {description = "Handles request, if it is a weapon it will display the magazines for the weapon.";};
			class removeGear {description = "Handles request and removes the selected gear from the player.";};
			class addGear {description = "Adds the selected gear to the player.";};
			class handleItem {description = "Handles the incoming requests and decides how it is to be added or removed.";};
			class filterShow {description = "Checks if we need to hide/show filters.";};
			class filterMenu {description = "When a filter is called it will give us the details and we shall short her out!";};
			class fetchCfg {description = "Checks where to fetch the Cfg Patches from.";};
			class fetchCfgDetails {description = "Returns information about the entity, if no information it will return either nil or an empty array";};
			class buildConfig {description = "Used in preloading of VAS, builds the arrays of weapons/items.";};
			class filter {description = "Takes array of types and filters it and returns what the filter was.";};
			class fetchPlayerGear {description = "Fetches all the gear on the player and returns as one single array.";};
			class mainDisplay {description = "Handles the main part of VAS's Display";};
			class playerDisplay {description = "Used in refreshing the items a player has.";};
			class accType {_description = "Checks what type of an attachment is passed and what it is compatible with.";};
			class openDetails {};
			class closeDetails {};
			class quickMag {};
			class quickItem {};
			class qRemoveItem {};
			class mainInit {description = "Main initialization of VAS, called on mission start."; preInit = 1;};
			class KRON_StrLeft {};
			class KRON_StrToArray {};
			class accPrompt {};
			class quickAddDrag {};
			class updateLoad {};
			class transferMenu {};
			class transferAction {};
			class transferNetwork {};
			class transferSaveMenu {};
			class transferSaveGear {};
			class VASP {};
			class quickAttachment {};
			class accList {};
		};
	}
	*/
};

//=====================DOC=========================
class CfgObjectCompositions
{
//------------------BLU-----------------------------
	file = "\mcc_sandbox_mod\mcc\general_scripts\docobject";
	class b_fobSmall
	{
		faction = "BLU_F";
		displayName = "F.O.B - Small";
	};
	
	class b_fobLarge
	{
		faction = "BLU_F";
		displayName = "F.O.B - Large";
	};
	
	class b_fobHuge
	{
		faction = "BLU_F";
		displayName = "F.O.B - Huge";
	};
	
	class b_campSIte
	{
		faction = "BLU_F";
		displayName = "Camp Site";
	};
	
	class b_mortarCampEmpty
	{
		faction = "BLU_F";
		displayName = "Mortar Camp - Empty";
	};
	
	class b_mortarCampAmbient
	{
		faction = "BLU_F";
		displayName = "Mortar Camp - Ambient Shooting";
	};
	
	class b_mortarCampObserver
	{
		faction = "BLU_F";
		displayName = "Mortar Camp - Console's Mortar team";
	};
	
	class b_mobileArtilleryCampEmpty
	{
		faction = "BLU_F";
		displayName = "Mobile Heavy Artillery Camp - Empty";
	};
	
	class b_mobileArtilleryCampAmbient
	{
		faction = "BLU_F";
		displayName = "Mobile Heavy Artillery Camp - Ambient Shooting";
	};
	
	class b_mobileArtilleryCampObserver
	{
		faction = "BLU_F";
		displayName = "Mobile Heavy Artillery Camp - Console's Heavy Artillery";
	};
	
	class b_AAVehicleSiteEmpty
	{
		faction = "BLU_F";
		displayName = "AAA Vehicle Nest - Empty";
	};
	
	class b_AAVehicleSiteAmbient
	{
		faction = "BLU_F";
		displayName = "AAA Vehicle Nest -  Ambient Shooting";
	};
//------------------CIV-----------------------------
	class c_abandonedTown
	{
		faction = "CIV_F";
		displayName = "Abandoned Town - Small";
	};
	
	class c_fuel
	{
		faction = "CIV_F";
		displayName = "Gas station";
	};
	
	class c_indOld
	{
		faction = "CIV_F";
		displayName = "Old factory";
	};
	
	class c_projectBuildings
	{
		faction = "CIV_F";
		displayName = "Construction Site";
	};
	
	class c_castle
	{
		faction = "CIV_F";
		displayName = "Castle";
	};
	
	class c_villa
	{
		faction = "CIV_F";
		displayName = "Villa";
	};
	
	class c_campSite
	{
		faction = "CIV_F";
		displayName = "Camp Site";
	};
	
	class c_slums
	{
		faction = "CIV_F";
		displayName = "Slums Site";
	};
	
	class c_nestBig
	{
		faction = "CIV_F";
		displayName = "Nest Big";
	};
	
	class c_nestSmall
	{
		faction = "CIV_F";
		displayName = "Nest Small";
	};
	
	class c_hanger
	{
		faction = "CIV_F";
		displayName = "Fortified hanger";
	};
	
	class c_roadBlock
	{
		faction = "CIV_F";
		displayName = "Roadblock";
	};
//------------------OPF-----------------------------
	class o_campSIte
	{
		faction = "OPF_F";
		displayName = "Camp Site";
	};
	
	class o_fobSmall
	{
		faction = "OPF_F";
		displayName = "F.O.B - Small";
	};
	
	class o_fobLarge
	{
		faction = "OPF_F";
		displayName = "F.O.B - Large";
	};
	
	class o_fobHuge
	{
		faction = "OPF_F";
		displayName = "F.O.B - Huge";
	};
	
	class o_mortarCampEmpty
	{
		faction = "OPF_F";
		displayName = "Mortar Camp - Empty";
	};
	
	class o_mortarCampAmbient
	{
		faction = "OPF_F";
		displayName = "Mortar Camp - Ambient Shooting";
	};
	
	class o_mortarCampObserver
	{
		faction = "OPF_F";
		displayName = "Mortar Camp - Console's Mortar team";
	};
	
	class o_mobileArtilleryCampEmpty
	{
		faction = "OPF_F";
		displayName = "Mobile Heavy Artillery Camp - Empty";
	};
	
	class o_mobileArtilleryCampAmbient
	{
		faction = "OPF_F";
		displayName = "Mobile Heavy Artillery Camp - Ambient Shooting";
	};
	
	class o_mobileArtilleryCampObserver
	{
		faction = "OPF_F";
		displayName = "Mobile Heavy Artillery Camp - Console's Heavy Artillery";
	};
	
	class o_AAVehicleSiteEmpty
	{
		faction = "OPF_F";
		displayName = "AAA Vehicle Nest - Empty";
	};
	
	class o_AAVehicleSiteAmbient
	{
		faction = "OPF_F";
		displayName = "AAA Vehicle Nest -  Ambient Shooting";
	};
//------------------IND-----------------------------
	class i_fobSmall
	{
		faction = "IND_F";
		displayName = "F.O.B - Small";
	};
	
	class i_fobLarge
	{
		faction = "IND_F";
		displayName = "F.O.B - Large";
	};
	
	class i_mortarCampEmpty
	{
		faction = "IND_F";
		displayName = "Mortar Camp - Empty";
	};
	
	class i_mortarCampAmbient
	{
		faction = "IND_F";
		displayName = "Mortar Camp - Ambient Shooting";
	};
	
	class i_mortarCampObserver
	{
		faction = "IND_F";
		displayName = "Mortar Camp - Console's Mortar team";
	};
};

class CfgSounds	{	
	class noSound
	{
	name = "noSound";
	sound[] = {"", 0, 1};
	titles[] = {};
	};
	//================================Arti sound================================
	class requestO1 {
	name = "requestO1";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\1requestO.ogg", 1, 1};
	titles[] = {};
	};
	class requestS1 {
	name = "requestS1";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\1requestS.ogg", 1, 1};
	titles[] = {};
	};
	class gridO2 {
	name = "gridO2";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\2gridO.ogg", 1, 1};
	titles[] = {};
	};
	class gridS2 {
	name = "gridS2";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\2gridS.ogg", 1, 1};
	titles[] = {};
	};
	class splashO3 {
	name = "splashO3";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\3splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS3 {
	name = "splashS3";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\3splashS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeS4 {
	name = "messegeS4";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\4messegeS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeO4 {
	name = "messegeO4";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\4messegeO.ogg", 1, 1};
	titles[] = {};
	};
	class shoutS5 {
	name = "shoutS5";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\5shoutS.ogg", 1, 1};
	titles[] = {};
	};
	class shoutO5 {
	name = "shoutO5";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\5shoutO.ogg", 1, 1};
	titles[] = {};
	};
	class splashO6 {
	name = "splashO6";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\6splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS6 {
	name = "splashS6";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\6splashS.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionO7 {
	name = "endmissionO7";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\7endmissionO.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionS7 {
	name = "endmissionS7";
	sound[] = {"\mcc_sandbox_mod\sounds\artysounds\7endmissionS.ogg", 1, 1};
	titles[] = {};
	};
	
	class bon_Shell_In_v01 {
	name = "bon_Shell_In_v01";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v01.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v02 {
	name = "bon_Shell_In_v02";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v02.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v03 {
	name = "bon_Shell_In_v03";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v03.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v04 {
	name = "bon_Shell_In_v04";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v04.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v05 {
	name = "bon_Shell_In_v05";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v05.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v06 { 
	name = "bon_Shell_In_v06";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v06.wss", db-0, 1};
	titles[] = {};
	};
	class bon_Shell_In_v07 {
	name = "bon_Shell_In_v07";
	sound[] = {"\mcc_sandbox_mod\sounds\bon_Shell_In_v07.wss", db-0, 1};
	titles[] = {};
	};
	//================================Traps=======================================
	class suicide
	{
	name = "suicide";
	sound[] = {"\mcc_sandbox_mod\sounds\suicide.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class dontshot
	{
	name = "dontshot";
	sound[] = {"\mcc_sandbox_mod\sounds\dont_shot.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class enough
	{
	name = "enough";
	sound[] = {"\mcc_sandbox_mod\sounds\enough.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class hands
	{
	name = "hands";
	sound[] = {"\mcc_sandbox_mod\sounds\hands.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class dontmove
	{
	name = "dontmove";
	sound[] = {"\mcc_sandbox_mod\sounds\dont_move.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class hell
	{
	name = "hell";
	sound[] = {"\mcc_sandbox_mod\sounds\hell.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class alone
	{
	name = "alone";
	sound[] = {"\mcc_sandbox_mod\sounds\alone.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class pig
	{
	name = "pig";
	sound[] = {"\mcc_sandbox_mod\sounds\pig.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarm1
	{
	name = "disarm1";
	sound[] = {"\mcc_sandbox_mod\sounds\disarm1.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarm2
	{
	name = "disarm2";
	sound[] = {"\mcc_sandbox_mod\sounds\disarm2.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarm3
	{
	name = "disarm3";
	sound[] = {"\mcc_sandbox_mod\sounds\disarm3.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarm4
	{
	name = "disarm4";
	sound[] = {"\mcc_sandbox_mod\sounds\disarm4.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarmfail1
	{
	name = "disarmfail1";
	sound[] = {"\mcc_sandbox_mod\sounds\disarmfail1.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarmfail2
	{
	name = "disarmfail2";
	sound[] = {"\mcc_sandbox_mod\sounds\disarmfail2.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarmfail3
	{
	name = "disarmfail3";
	sound[] = {"\mcc_sandbox_mod\sounds\disarmfail3.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarmcrit1
	{
	name = "disarmcrit1";
	sound[] = {"\mcc_sandbox_mod\sounds\disarmcrit1.ogg", 1, 1};
	titles[] = {0, ""};
	};
	class disarmcrit2
	{
	name = "disarmcrit2";
	sound[] = {"\mcc_sandbox_mod\sounds\disarmcrit2.ogg", 1, 1};
	titles[] = {0, ""};
	};
		//======================================= AC sounds================================
	class gun1
	{
	name = "gun1";
	sound[] = {"\mcc_sandbox_mod\sounds\gun1.ogg", 1, 1};
	titles[] = {};
	};
	class gun2
	{
	name = "gun2";
	sound[] = {"\mcc_sandbox_mod\sounds\gun2.ogg", 1, 1};
	titles[] = {};
	};
	class gun3
	{
	name = "gun3";
	sound[] = {"\mcc_sandbox_mod\sounds\gun3.ogg", 1, 1};
	titles[] = {};
	};
	class gunReload
	{
	name = "gunReload";
	sound[] = {"\mcc_sandbox_mod\sounds\gunReload.ogg", 1, 1};
	titles[] = {};
	};
	class missileLunch
	{
	name = "missileLunch";
	sound[] = {"\mcc_sandbox_mod\sounds\missile.ogg", 1, 1};
	titles[] = {};
	};
	
	class nvSound
	{
		name = "nvSound";
		sound[] = {"\mcc_sandbox_mod\sounds\nvSound.ogg", 1, 1};
		titles[] = {};
	};
	
	class MCC_woosh
	{
		name = "MCC_woosh";
		sound[] = {"\mcc_sandbox_mod\sounds\woosh.ogg", 1, 1};
		titles[] = {};
	};
};

class CfgMusic {
	class ac130
	{
		name = "ac130";
		sound[] = {"\mcc_sandbox_mod\sounds\ac130.ogg", 1, 1};
		titles[] = {};
	};
	
	class mcc_wind
	{
		name = "mcc_wind";
		sound[] = {"\mcc_sandbox_mod\sounds\wind.ogg", 1, 1};
		titles[] = {};
	};
}; 

class CfgNotifications
{
	class MCCNotifications
	{
		description = "%1";
		iconPicture = "%2";
		iconText = "%3";
		priority = 4;
		sound = "communicationMenuItemAdded";
		title = "NEW SUPPORT AVAILABLE";
	};
}
