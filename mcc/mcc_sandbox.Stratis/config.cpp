class CfgPatches {

	class mcc_sandbox {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 3";
		version = "0.7";
	};
};	

class CfgMissions {

	class MPMissions {
		class MP_COOP_MCC_SANDBOX {
			directory = "\mcc_sandbox_mod\sampleMissions\mcc_template.stratis";		
		};		
	};
};

class Extended_PreInit_EventHandlers	{
	class mcc_sandbox_initialize	{
		init = "if (isNil 'mcc_sandbox') then { mcc_sandbox = true;[] execVM '\mcc_sandbox_mod\init.sqf'};"; 
	};
};

#include "\mcc_sandbox_mod\definesMod.hpp"

class cfgVehicles
{
	class Logic ;

	class mcc_sandbox_module : Logic
	{
		displayName = "(MCC Sandbox) Access Rights";
		icon = "\mcc_sandbox_mod\data\mcc_access.paa";
		picture = "\mcc_sandbox_mod\data\mcc_access.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleAcess.sqf'";
		};
	};
	
		
	class mcc_sandbox_moduleTP : Logic
	{
		displayName = "(MCC Sandbox) Always Allow Teleport";
		icon = "\mcc_sandbox_mod\data\mcc_access.paa";
		picture = "\mcc_sandbox_mod\data\mcc_access.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleTeleport.sqf'";
		};
	};
	
	class mcc_sandbox_moduleTS : Logic
	{
		displayName = "(MCC Sandbox) Disable Auto Teleport to Start";
		icon = "\mcc_sandbox_mod\data\mcc_access.paa";
		picture = "\mcc_sandbox_mod\data\mcc_access.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleStartTeleport.sqf'";
		};
	};
	
	class mcc_sandbox_moduleSF : Logic
	{
		displayName = "(MCC Sandbox) Special Forces";
		icon = "\mcc_sandbox_mod\data\mcc_sf.paa";
		picture = "\mcc_sandbox_mod\data\mcc_sf.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleSF.sqf'";
		};
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
	sound[] = {"\mcc_sandbox_mod\artysounds\1requestO.ogg", 1, 1};
	titles[] = {};
	};
	class requestS1 {
	name = "requestS1";
	sound[] = {"\mcc_sandbox_mod\artysounds\1requestS.ogg", 1, 1};
	titles[] = {};
	};
	class gridO2 {
	name = "gridO2";
	sound[] = {"\mcc_sandbox_mod\artysounds\2gridO.ogg", 1, 1};
	titles[] = {};
	};
	class gridS2 {
	name = "gridS2";
	sound[] = {"\mcc_sandbox_mod\artysounds\2gridS.ogg", 1, 1};
	titles[] = {};
	};
	class splashO3 {
	name = "splashO3";
	sound[] = {"\mcc_sandbox_mod\artysounds\3splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS3 {
	name = "splashS3";
	sound[] = {"\mcc_sandbox_mod\artysounds\3splashS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeS4 {
	name = "messegeS4";
	sound[] = {"\mcc_sandbox_mod\artysounds\4messegeS.ogg", 1, 1};
	titles[] = {};
	};
	class messegeO4 {
	name = "messegeO4";
	sound[] = {"\mcc_sandbox_mod\artysounds\4messegeO.ogg", 1, 1};
	titles[] = {};
	};
	class shoutS5 {
	name = "shoutS5";
	sound[] = {"\mcc_sandbox_mod\artysounds\5shoutS.ogg", 1, 1};
	titles[] = {};
	};
	class shoutO5 {
	name = "shoutO5";
	sound[] = {"\mcc_sandbox_mod\artysounds\5shoutO.ogg", 1, 1};
	titles[] = {};
	};
	class splashO6 {
	name = "splashO6";
	sound[] = {"\mcc_sandbox_mod\artysounds\6splashO.ogg", 1, 1};
	titles[] = {};
	};
	class splashS6 {
	name = "splashS6";
	sound[] = {"\mcc_sandbox_mod\artysounds\6splashS.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionO7 {
	name = "endmissionO7";
	sound[] = {"\mcc_sandbox_mod\artysounds\7endmissionO.ogg", 1, 1};
	titles[] = {};
	};
	class endmissionS7 {
	name = "endmissionS7";
	sound[] = {"\mcc_sandbox_mod\artysounds\7endmissionS.ogg", 1, 1};
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
};

class CfgMusic {
	class ac130
	{
		name = "ac130";
		sound[] = {"\mcc_sandbox_mod\sounds\ac130.ogg", 1, 1};
		titles[] = {};
	};
}; 

class cfgWeapons
{
	class Default;
	
	class itemCore;
	
	class ItemGPS;
	
	class MCC_Console : ItemGPS 
	{
	displayName = "MCC Console";
	picture = "\mcc_sandbox_mod\data\console_small.paa";
	descriptionShort = "Tactical PDA";
	scope = 2;
	};
};