#define MCCPATH ""
#define MCCVersion "0.1"

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

//---------------------------Functions------------------------------------------------

class CfgFunctions
{
	class MCC
	{
		tag = "MCC";

		class general
		{
			file = "mcc\fnc\general";

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

			class realParadrop
			{
				description = "Create a HALO or regular parachute jump for the given units with simulation of runing out of an airplane.";
			};

			class realParadropPlayer
			{
				description = "Handle the paradrop from the unit side.";
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
				description = "Save MCC's placments in SQM file format and copy it to clipboard";
			};

			class saveToMCC
			{
				description = "prepare the mcc_output variable";
			};

			class loadFromMCC
			{
				description = "Load the mcc_output variable";
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

			class keyToName
			{
				description = "get idkKey and return string with his name";
			};

			class makeBriefing
			{
				description = "Server Only - create a Logic based briefing";
			};

			class handleAddaction
			{
				description = "Handle addactions after respawn - init";
			};
		};

		class ui
		{
			file = "mcc\fnc\ui";

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

			class camp_showOSD
			{
				description = "Show player OSD";
			};

			class curatorInitLine
			{
				description = "Handle MCC's curator init line";
			};

			class initDispaly
			{
				description = "Handle MCC's displays init";
			};

			class makeMarker
			{
				description = "Create a marker";
			};

			class createMCCZones
			{
				description = "Create MCC zones localy";
			};

			class initCuratorAttribute
			{
				description = "Init MCC's curato Attribute";
			};
		};

		class ied
		{
			file = "mcc\fnc\ied";

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

			class createIED
			{
				description = "Create the IED mechanic.";
			};

			class manageAmbush
			{
				description = "Manage ambush behavior in a group.";
			};

			class manageAC
			{
				description = "Manage armed civilian behavior.";
			};

			class SBSingle
			{
				description = "Place suicide bomber.";
			};

			class manageSB
			{
				description = "Manage SB bomber behavior.";
			};
		};

		class cas
		{
			file = "mcc\fnc\cas";

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
			file = "mcc\fnc\artillery";

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

			class calcSolution
			{
				description = "calculate artillery solution high or low";
			};

			class artyGetSolution
			{
				description = "Broadcast artillery solution high or low";
			};

			class consoleFireArtillery
			{
				description = "Broadcast artillery to artillery units";
			};

		};

		class groupGen
		{
			file = "mcc\fnc\groupGen";

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

		class console
		{
			file = "mcc\fnc\console";

			class consoleClickGroupIcon
			{
				description = "Define icon behaviot when clicked on the MCC Console";
			};
		};

		class missionWizard
		{
			file = "mcc\fnc\missionWizard";

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
				description = "Create units array by type";
			};

			class MWUpdateZone
			{
				description = "Create or update a new zone";
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

			class customTasks
			{
				description = "Manage custom tasks.";
			};

			class MWspawnAnimals
			{
				description = "spawn animals in the area.";
			};

			class MWinitMission
			{
				description = "Init generated mission.";
			};
		};

		class ai
		{
			file = "mcc\fnc\ai";

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

			class populateVehicle
			{
				description = "Populate a not empty vehicle with antoher group contains units acording to its faction and cargo space.";
			};
		};

		class mp
		{
			file = "mcc\fnc\mp";

			class vote
			{
				description = "Start a voting process.";
			};

			class getActiveSides
			{
				description = "Return an array of the active sides in a role selection game.";
			};

			class unlock
			{
				description = "Check for gear unlocks and notify the player.";
			};

			class gainXPfromRoles
			{
				description = "gain XP from specific roles.";
			};

			class createRespawnTent
			{
				description = "Creates a respawn tent";
			};

			class PDAcreatemarker
			{
				description = "Creates markers on mp per side and delete them after a period of time";
			};

			class construction
			{
				description = "Constract a tactical building on the server side";
			};

			class construct_base
			{
				description = "Constract a building in base";
			};
		};

		class MCCmodules
		{
			file = "mcc\fnc\MCCmodules";

			class moduleSector
			{
				description = "Handles Sectors built on BIS Sector by  Karel Moricky.";
			};

			class accessRights
			{
				description = "Handles access rights to MCC.";
			};

			class SF
			{
				description = "Defines units as SF.";
			};

			class moduleObjectiveSectorMCC
			{
				ext = ".fsm";
			};

			class createRestrictedZones
			{
				description = "create restriction zone around a marker.";
			};

			class RestrictZoneEffect
			{
				description = "Effect while inside a restricted zone.";
			};
		};

		class aircraft
		{
			file = "mcc\fnc\aircraft";

			class ilsChilds
			{
				description = "Handles ILS childs";
			};

			class ilsMain
			{
				description = "Handles ILS main dialog";
			};
		};
	};

	#include "gaia\cfgFunctions.hpp"
	#include "f\cfgFunctions.hpp"

	#include "VAS\cfgfunctions.hpp"

	#include "ais_injury\cfgFunctionsAIS.hpp"
};

//=====================DOC=========================
class CfgObjectCompositions
{
//------------------BLU-----------------------------
	file = "mcc\general_scripts\docobject";
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

class CfgMusic {
	class ac130
	{
		name = "ac130";
		sound[] = {"sounds\ac130.ogg", 1, 1};
		titles[] = {};
	};

	class mcc_wind
	{
		name = "mcc_wind";
		sound[] = {"sounds\wind.ogg", 1, 1};
		titles[] = {};
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
	sound[] = {"sounds\artysounds\1requestO.ogg", 1, 1};
	titles[] = {};
	};
	class requestS1 {
	name = "requestS1";
	sound[] = {"sounds\artysounds\1requestS.ogg", 1, 1};
	titles[] = {};
	};
	class gridO2 {
	name = "gridO2";
	sound[] = {"sounds\artysounds\2gridO.ogg", 1, 1};
	titles[] = {};
	};
	class gridS2 {
	name = "gridS2";
	sound[] = {"sounds\artysounds\2gridS.ogg", 1, 1};
	titles[] = {};
	};
	class splashO3 {
	name = "splashO3";
	sound[] = {"sounds\artysounds\3splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS3 {
	name = "splashS3";
	sound[] = {"sounds\artysounds\3splashS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeS4 {
	name = "messegeS4";
	sound[] = {"sounds\artysounds\4messegeS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeO4 {
	name = "messegeO4";
	sound[] = {"sounds\artysounds\4messegeO.ogg", 1, 1};
	titles[] = {};
	};
	class shoutS5 {
	name = "shoutS5";
	sound[] = {"sounds\artysounds\5shoutS.ogg", 1, 1};
	titles[] = {};
	};
	class shoutO5 {
	name = "shoutO5";
	sound[] = {"sounds\artysounds\5shoutO.ogg", 1, 1};
	titles[] = {};
	};
	class splashO6 {
	name = "splashO6";
	sound[] = {"sounds\artysounds\6splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS6 {
	name = "splashS6";
	sound[] = {"sounds\artysounds\6splashS.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionO7 {
	name = "endmissionO7";
	sound[] = {"sounds\artysounds\7endmissionO.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionS7 {
	name = "endmissionS7";
	sound[] = {"sounds\artysounds\7endmissionS.ogg", 1, 1};
	titles[] = {};
	};

	class bon_Shell_In_v01 {
	name = "bon_Shell_In_v01";
	sound[] = {"sounds\bon_Shell_In_v01.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v02 {
	name = "bon_Shell_In_v02";
	sound[] = {"sounds\bon_Shell_In_v02.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v03 {
	name = "bon_Shell_In_v03";
	sound[] = {"sounds\bon_Shell_In_v03.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v04 {
	name = "bon_Shell_In_v04";
	sound[] = {"sounds\bon_Shell_In_v04.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v05 {
	name = "bon_Shell_In_v05";
	sound[] = {"sounds\bon_Shell_In_v05.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v06 {
	name = "bon_Shell_In_v06";
	sound[] = {"sounds\bon_Shell_In_v06.wss", 3, 1};
	titles[] = {};
	};
	class bon_Shell_In_v07 {
	name = "bon_Shell_In_v07";
	sound[] = {"sounds\bon_Shell_In_v07.wss", 3, 1};
	titles[] = {};
	};
	//================================Traps=======================================
	class suicide1
	{
		name = "suicide1";
		sound[] = {"sounds\suicide1.ogg", 3, 1};
		titles[] = {};
	};
	class suicide2
	{
		name = "suicide2";
		sound[] = {"sounds\suicide2.ogg", 3, 1};
		titles[] = {};
	};
	class suicide3
	{
		name = "suicide3";
		sound[] = {"sounds\suicide3.ogg", 3, 1};
		titles[] = {};
	};
	class suicide4
	{
		name = "suicide3";
		sound[] = {"sounds\suicide3.ogg", 3, 1};
		titles[] = {};
	};

	class dontshot
	{
	name = "dontshot";
	sound[] = {"sounds\dont_shot.ogg", 1, 1};
	titles[] = {};
	};
	class enough
	{
	name = "enough";
	sound[] = {"sounds\enough.ogg", 1, 1};
	titles[] = {};
	};
	class hands
	{
	name = "hands";
	sound[] = {"sounds\hands.ogg", 1, 1};
	titles[] = {};
	};
	class dontmove
	{
	name = "dontmove";
	sound[] = {"sounds\dont_move.ogg", 1, 1};
	titles[] = {};
	};
	class hell
	{
	name = "hell";
	sound[] = {"sounds\hell.ogg", 1, 1};
	titles[] = {};
	};
	class alone
	{
	name = "alone";
	sound[] = {"sounds\alone.ogg", 1, 1};
	titles[] = {};
	};
	class pig
	{
	name = "pig";
	sound[] = {"sounds\pig.ogg", 1, 1};
	titles[] = {};
	};
	class disarm1
	{
	name = "disarm1";
	sound[] = {"sounds\disarm1.ogg", 1, 1};
	titles[] = {};
	};
	class disarm2
	{
	name = "disarm2";
	sound[] = {"sounds\disarm2.ogg", 1, 1};
	titles[] = {};
	};
	class disarm3
	{
	name = "disarm3";
	sound[] = {"sounds\disarm3.ogg", 1, 1};
	titles[] = {};
	};
	class disarm4
	{
		name = "disarm4";
		sound[] = {"sounds\disarm4.ogg", 1, 1};
		titles[] = {};
	};
	class disarm5
	{
		name = "disarm5";
		sound[] = {"sounds\disarm5.ogg", 1, 1};
		titles[] = {};
	};
	class disarm6
	{
		name = "disarm6";
		sound[] = {"sounds\disarm6.ogg", 1, 1};
		titles[] = {};
	};
	class disarm7
	{
		name = "disarm7";
		sound[] = {"sounds\disarm7.ogg", 1, 1};
		titles[] = {};
	};

	class disarmfail1
	{
	name = "disarmfail1";
	sound[] = {"sounds\disarmfail1.ogg", 1, 1};
	titles[] = {};
	};
	class disarmfail2
	{
		name = "disarmfail2";
		sound[] = {"sounds\disarmfail2.ogg", 1, 1};
		titles[] = {};
	};
	class disarmfail3
	{
		name = "disarmfail3";
		sound[] = {"sounds\disarmfail3.ogg", 1, 1};
		titles[] = {};
	};
	class disarmcrit1
	{
		name = "disarmcrit1";
		sound[] = {"sounds\disarmcrit1.ogg", 1, 1};
		titles[] = {};
	};
	class disarmcrit2
	{
		name = "disarmcrit2";
		sound[] = {"sounds\disarmcrit2.ogg", 1, 1};
		titles[] = {};
	};
	//================================Misison Wizard=======================================
	class MWName_operation
	{
		name = "0_operation";
		sound[] = {"sounds\mwSounds\missionNames\0_operation.ogg", 1, 1};
		titles[] = {};
	};

	//Mission Names
	class MWName_desert
	{
		name = "1_desert";
		sound[] = {"sounds\mwSounds\missionNames\1_desert.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_oversized
	{
		name = "1_oversized";
		sound[] = {"sounds\mwSounds\missionNames\1_oversized.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_roguish
	{
		name = "1_roguish";
		sound[] = {"sounds\mwSounds\missionNames\1_roguish.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_smoldering
	{
		name = "1_smoldering";
		sound[] = {"sounds\mwSounds\missionNames\1_smoldering.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_cold
	{
		name = "1_cold";
		sound[] = {"sounds\mwSounds\missionNames\1_cold.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_flaring
	{
		name = "1_flaring";
		sound[] = {"sounds\mwSounds\missionNames\1_flaring.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_furious
	{
		name = "1_furious";
		sound[] = {"sounds\mwSounds\missionNames\1_furious.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_silver
	{
		name = "1_silver";
		sound[] = {"sounds\mwSounds\missionNames\1_silver.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_vengeance
	{
		name = "1_vengeance";
		sound[] = {"sounds\mwSounds\missionNames\1_vengeance.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_yellow
	{
		name = "1_yellow";
		sound[] = {"sounds\mwSounds\missionNames\1_yellow.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_red
	{
		name = "1_red";
		sound[] = {"sounds\mwSounds\missionNames\1_red.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_blue
	{
		name = "1_blue";
		sound[] = {"sounds\mwSounds\missionNames\1_blue.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_white
	{
		name = "1_white";
		sound[] = {"sounds\mwSounds\missionNames\1_white.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_gold
	{
		name = "1_gold";
		sound[] = {"sounds\mwSounds\missionNames\1_gold.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_dark
	{
		name = "1_dark";
		sound[] = {"sounds\mwSounds\missionNames\1_dark.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_broken
	{
		name = "1_broken";
		sound[] = {"sounds\mwSounds\missionNames\1_broken.ogg", 1, 1};
		titles[] = {};
	};

	class MWName_morbid
	{
		name = "1_morbid";
		sound[] = {"sounds\mwSounds\missionNames\1_morbid.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_flying
	{
		name = "1_flying";
		sound[] = {"sounds\mwSounds\missionNames\1_flying.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_living
	{
		name = "1_living";
		sound[] = {"sounds\mwSounds\missionNames\1_living.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_swift
	{
		name = "1_swift";
		sound[] = {"sounds\mwSounds\missionNames\1_swift.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_evil
	{
		name = "1_evil";
		sound[] = {"sounds\mwSounds\missionNames\1_evil.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_fallen
	{
		name = "1_fallen";
		sound[] = {"sounds\mwSounds\missionNames\1_fallen.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_solitary
	{
		name = "1_solitary";
		sound[] = {"sounds\mwSounds\missionNames\1_solitary.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_alpha
	{
		name = "1_alpha";
		sound[] = {"sounds\mwSounds\missionNames\1_alpha.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_bravo
	{
		name = "1_bravo";
		sound[] = {"sounds\mwSounds\missionNames\1_bravo.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_charlie
	{
		name = "1_charlie";
		sound[] = {"sounds\mwSounds\missionNames\1_charlie.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_delta
	{
		name = "1_delta";
		sound[] = {"sounds\mwSounds\missionNames\1_delta.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_echo
	{
		name = "1_echo";
		sound[] = {"sounds\mwSounds\missionNames\1_echo.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_foxtrot
	{
		name = "1_foxtrot";
		sound[] = {"sounds\mwSounds\missionNames\1_foxtrot.ogg", 1, 1};
		titles[] = {};
	};


	//Mission Name 2
	class MWName_storm
	{
		name = "2_storm";
		sound[] = {"sounds\mwSounds\missionNames\2_storm.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_lightning
	{
		name = "2_lightning";
		sound[] = {"sounds\mwSounds\missionNames\2_lightning.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_rain
	{
		name = "2_rain";
		sound[] = {"sounds\mwSounds\missionNames\2_rain.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_thunder
	{
		name = "2_thunder";
		sound[] = {"sounds\mwSounds\missionNames\2_thunder.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_tornado
	{
		name = "2_tornado";
		sound[] = {"sounds\mwSounds\missionNames\2_tornado.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_hurricane
	{
		name = "2_hurricane";
		sound[] = {"sounds\mwSounds\missionNames\2_hurricane.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_flood
	{
		name = "2_flood";
		sound[] = {"sounds\mwSounds\missionNames\2_flood.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_dragonfly
	{
		name = "2_dragonfly";
		sound[] = {"sounds\mwSounds\missionNames\2_dragonfly.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_ocelot
	{
		name = "2_ocelot";
		sound[] = {"sounds\mwSounds\missionNames\2_ocelot.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_cobra
	{
		name = "2_cobra";
		sound[] = {"sounds\mwSounds\missionNames\2_cobra.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_fiend
	{
		name = "2_fiend";
		sound[] = {"sounds\mwSounds\missionNames\2_fiend.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_father
	{
		name = "2_father";
		sound[] = {"sounds\mwSounds\missionNames\2_father.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_horse
	{
		name = "2_horse";
		sound[] = {"sounds\mwSounds\missionNames\2_horse.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_thorn
	{
		name = "2_thorn";
		sound[] = {"sounds\mwSounds\missionNames\2_thorn.ogg", 1, 1};
		titles[] = {};
	};
	//----
	class MWName_arrow
	{
		name = "2_arrow";
		sound[] = {"sounds\mwSounds\missionNames\2_arrow.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_cage
	{
		name = "2_cage";
		sound[] = {"sounds\mwSounds\missionNames\2_cage.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_contempt
	{
		name = "2_contempt";
		sound[] = {"sounds\mwSounds\missionNames\2_contempt.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_dagger
	{
		name = "2_dagger";
		sound[] = {"sounds\mwSounds\missionNames\2_dagger.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_famine
	{
		name = "2_famine";
		sound[] = {"sounds\mwSounds\missionNames\2_famine.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_one
	{
		name = "2_one";
		sound[] = {"sounds\mwSounds\missionNames\2_one.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_priest
	{
		name = "2_priest";
		sound[] = {"sounds\mwSounds\missionNames\2_priest.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_serpent
	{
		name = "2_serpent";
		sound[] = {"sounds\mwSounds\missionNames\2_serpent.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_snake
	{
		name = "2_snake";
		sound[] = {"sounds\mwSounds\missionNames\2_snake.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_stranger
	{
		name = "2_stranger";
		sound[] = {"sounds\mwSounds\missionNames\2_stranger.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_three
	{
		name = "2_three";
		sound[] = {"sounds\mwSounds\missionNames\2_three.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_two
	{
		name = "2_two";
		sound[] = {"sounds\mwSounds\missionNames\2_two.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_urgency
	{
		name = "2_urgency";
		sound[] = {"sounds\mwSounds\missionNames\2_urgency.ogg", 1, 1};
		titles[] = {};
	};
	class MWName_zero
	{
		name = "2_zero";
		sound[] = {"sounds\mwSounds\missionNames\2_zero.ogg", 1, 1};
		titles[] = {};
	};

	//General
	class general1
	{
		name = "1general1";
		sound[] = {"sounds\mwSounds\1general1.ogg", 1, 1};
		titles[] = {};
	};
	class general2
	{
		name = "1general2";
		sound[] = {"sounds\mwSounds\1general2.ogg", 1, 1};
		titles[] = {};
	};
	class general3
	{
		name = "1general3";
		sound[] = {"sounds\mwSounds\1general3.ogg", 1, 1};
		titles[] = {};
	};

	class isCQB1
	{
		name = "2_isCQB1";
		sound[] = {"sounds\mwSounds\2_isCQB1.ogg", 1, 1};
		titles[] = {};
	};
	class isCQB2
	{
		name = "2_isCQB2";
		sound[] = {"sounds\mwSounds\2_isCQB2.ogg", 1, 1};
		titles[] = {};
	};

	class infantrypresent
	{
		name = "3infantrypresent";
		sound[] = {"sounds\mwSounds\3infantrypresent.ogg", 1, 1};
		titles[] = {};
	};

	class isVehicles
	{
		name = "4_vehicles";
		sound[] = {"sounds\mwSounds\4_vehicles.ogg", 1, 1};
		titles[] = {};
	};

	class isArmor
	{
		name = "5_armor";
		sound[] = {"sounds\mwSounds\5_armor.ogg", 1, 1};
		titles[] = {};
	};

	class isArtillery
	{
		name = "6_artillery";
		sound[] = {"sounds\mwSounds\6_artillery.ogg", 1, 1};
		titles[] = {};
	};

	class isRoadblocks
	{
		name = "7_isRoadblocks";
		sound[] = {"sounds\mwSounds\7_isRoadblocks.ogg", 1, 1};
		titles[] = {};
	};

	class isIED
	{
		name = "8_isIED";
		sound[] = {"sounds\mwSounds\8_isIED.ogg", 1, 1};
		titles[] = {};
	};

	class isAS
	{
		name = "9_isAS";
		sound[] = {"sounds\mwSounds\9_isAS.ogg", 1, 1};
		titles[] = {};
	};

	class isReinforcement_generic
	{
		name = "10_reinforcement_generic";
		sound[] = {"sounds\mwSounds\10_reinforcement_generic.ogg", 1, 1};
		titles[] = {};
	};
	class isReinforcement1
	{
		name = "10_reinforcement1";
		sound[] = {"sounds\mwSounds\10_reinforcement1.ogg", 1, 1};
		titles[] = {};
	};
	class isReinforcement2
	{
		name = "10_reinforcement2";
		sound[] = {"sounds\mwSounds\10_reinforcement2.ogg", 1, 1};
		titles[] = {};
	};
	class isReinforcement3
	{
		name = "10_reinforcement3";
		sound[] = {"sounds\mwSounds\10_reinforcement3.ogg", 1, 1};
		titles[] = {};
	};

	class isMissiongo
	{
		name = "11missiongo";
		sound[] = {"sounds\mwSounds\11missiongo.ogg", 1, 1};
		titles[] = {};
	};
	//======================================= AC sounds================================
	class gun1
	{
	name = "gun1";
	sound[] = {"sounds\gun1.ogg", 1, 1};
	titles[] = {};
	};
	class gun2
	{
	name = "gun2";
	sound[] = {"sounds\gun2.ogg", 1, 1};
	titles[] = {};
	};
	class gun3
	{
	name = "gun3";
	sound[] = {"sounds\gun3.ogg", 1, 1};
	titles[] = {};
	};
	class gunReload
	{
	name = "gunReload";
	sound[] = {"sounds\gunReload.ogg", 1, 1};
	titles[] = {};
	};
	class missileLunch
	{
	name = "missileLunch";
	sound[] = {"sounds\missile.ogg", 1, 1};
	titles[] = {};
	};

	class nvSound
	{
		name = "nvSound";
		sound[] = {"sounds\nvSound.ogg", 1, 1};
		titles[] = {};
	};

	class MCC_woosh
	{
		name = "MCC_woosh";
		sound[] = {"sounds\woosh.ogg", 1, 1};
		titles[] = {};
	};

};

class CfgNotifications
{
	#include "mcc\cfgNotifications.hpp"
	#include "f\cfgNotifications.hpp"
};
