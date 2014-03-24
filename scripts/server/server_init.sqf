private ["_string","_group","_weapon","_weaponAttachments"];

if (CP_debug) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
if (isnil "CP_eastSpawnPoints") then {CP_eastSpawnPoints 	= []};
if (isnil "CP_westSpawnPoints") then {CP_westSpawnPoints 	= []};
if (isnil "CP_guarSpawnPoints") then {CP_guarSpawnPoints  = []};
if (isnil "CP_westGroups") then {CP_westGroups 		= []};
if (isnil "CP_eastGroups") then {CP_eastGroups 		= []};
if (isnil "CP_guarGroups") then {CP_guarGroups 		= []};


publicVariable "CP_westSpawnPoints";
publicVariable "CP_guarSpawnPoints";
publicVariable "CP_westGroups";
publicVariable "CP_eastGroups";
publicVariable "CP_guarGroups";
publicVariable "CP_maxPlayers";
publicVariable "CP_maxSquads";

//Tickets number
if (isnil "CP_eastTickets") then {CP_eastTickets = 200}; 
if (isnil "CP_westTickets") then {CP_westTickets = 200}; 
publicVariable "CP_eastTickets";
publicVariable "CP_westTickets";

/*
//Build starting spawn points
[[getpos spawn_west, getdir spawn_west, "west", "HQ-BASE", false] , "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
[[getpos spawn_east, getdir spawn_east,"east", "HQ-BASE", false] , "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
*/


//---------------------------------------------
//		Create custom groups
//---------------------------------------------
if (count CP_westGroups == 0) then
{
	{												//West
		_group = createGroup west;
		waituntil {!isnil "_group"};
		CP_westGroups set [_forEachIndex,[_group,_x]];
	} foreach ["Alpha","Bravo","Charlie","Delta"];
	
	publicvariable "CP_westGroups";
};

if (count CP_eastGroups == 0) then
{
	{												//East
		_group = createGroup east;
		waituntil {!isnil "_group"};
		CP_eastGroups set [_forEachIndex,[_group,_x]];
	} foreach ["Alpha","Bravo","Charlie","Delta"];
	
	publicvariable "CP_eastGroups";
};

if (count CP_guarGroups == 0) then
{
	{												//East
		_group = createGroup resistance;
		waituntil {!isnil "_group"};
		CP_guarGroups set [_forEachIndex,[_group,_x]];
	} foreach ["Alpha","Bravo","Charlie","Delta"];
	
	publicvariable "CP_guarGroups";
};


//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************

//---------------------------------------------
//		gears array
//---------------------------------------------

//HandGuns
CP_handguns = ["SERVER_misc", "handguns", "CP_handguns", "ARRAY"] call iniDB_read;

if (count CP_handguns == 0) then
{
	CP_handguns	= 	call compileFinal str	[
					[0,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
					[10,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
					[20,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]]]; 
					
	 ["SERVER_misc", "handguns", "CP_handguns",CP_handguns, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_handguns"; 		


//------------------------------------------------------------------------------------------------------------------------------
//			Roles
//------------------------------------------------------------------------------------------------------------------------------

#include "officer.sqf"
#include "ar.sqf"
#include "rifleman.sqf"
#include "at.sqf"

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Corpsman
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Gear----------------------------------------------------------------

if (isnil "CP_corpsmanUniformsWest") then
{
	CP_corpsmanUniformsWest		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
									];
	publicvariable "CP_corpsmanUniformsWest";
};

if (isnil "CP_corpsmanUniformsEast") then
{							
	CP_corpsmanUniformsEast		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_SpecopsUniform_blk"]]	//Uniforms
									];
	publicvariable "CP_corpsmanUniformsEast";
};

if (isnil "CP_corpsmanUniformsGuar") then
{
	CP_corpsmanUniformsGuar		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
									];	
	publicvariable "CP_corpsmanUniformsGuar";
};								
//----------------------------------------------------Items----------------------------------------------------------------

if (isnil "CP_corpsmanItmes1") then
{
	CP_corpsmanItmes1			= call compileFinal str	[[0,"Medikit", ["Medikit",1]]
									];
	publicvariable "CP_corpsmanItmes1";
};

if (isnil "CP_corpsmanItmes2") then
{
	CP_corpsmanItmes2			= call compileFinal str	[	[0,"",0]
									];
	publicvariable "CP_corpsmanItmes2";
};

if (isnil "CP_corpsmanItmes3") then
{
	CP_corpsmanItmes3			= call compileFinal str	[	[0,"SmokeShell",4]
									];
	publicvariable "CP_corpsmanItmes3";
};


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Marksman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Snipers' Rifles----------------------------------------------------------------

if (isnil "CP_arifle_MXM_F") then
{
	CP_arifle_MXM_F			=	call compileFinal str[
								[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
								[[0,""],[9,"muzzle_snds_H"]], //Barrel
								[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
								];
	publicvariable "CP_arifle_MXM_F";
};

if (isnil "CP_srifle_EBR_F") then
{							
	CP_srifle_EBR_F			=	call compileFinal str[
								[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
								[[0,""],[9,"muzzle_snds_B"]], //Barrel
								[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
								];
	publicvariable "CP_srifle_EBR_F";
};

if (isnil "CP_srifle_LRR_F") then
{							
	CP_srifle_LRR_F			=	call compileFinal str[
								[[10,"optic_MRCO"],[13,"optic_Hamr"],[16,"optic_Arco"],[19,"optic_SOS"]], //optics
								[[0,""]], //Barrel
								[[0,""]]	//Attach
								];
	publicvariable "CP_srifle_LRR_F";
};

if (isnil "CP_srifle_GM6_F") then
{	
	CP_srifle_GM6_F			=	call compileFinal str[
								[[20,"optic_MRCO"],[23,"optic_Hamr"],[26,"optic_Arco"],[29,"optic_SOS"]], //optics
								[[0,""]], //Barrel
								[[0,""]]	//Attach
								];
	publicvariable "CP_srifle_GM6_F";
};
//----------------------------------------------------Gear----------------------------------------------------------------
if (isnil "CP_marksmanUniformsWest") then
{
	CP_marksmanUniformsWest		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetB_light"],[10,"H_Booniehat_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_GhillieSuit"]]	//Uniforms
									];
	publicvariable "CP_marksmanUniformsWest";
};

if (isnil "CP_marksmanUniformsEast") then
{								
	CP_marksmanUniformsEast		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_MilCap_ocamo"],[10,"H_Booniehat_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[20,"U_O_GhillieSuit"]]	//Uniforms
									];
	publicvariable "CP_marksmanUniformsEast";
};

if (isnil "CP_marksmanUniformsGuar") then
{
	CP_marksmanUniformsGuar		= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetIA_net"],[10,"H_Booniehat_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform_tshirt"],[20,"U_I_GhillieSuit"]]	//Uniforms
									];
	publicvariable "CP_marksmanUniformsGuar";
};

//----------------------------------------------------Primary----------------------------------------------------------------	
if (isnil "CP_marksmanWeaponsWest") then
{							
	CP_marksmanWeaponsWest		 = call compileFinal str	[
									[0,"arifle_MXM_F",["30Rnd_65x39_caseless_mag",9]],
									[10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
									[20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
									]; 
	publicvariable "CP_marksmanWeaponsWest";
};

if (isnil "CP_marksmanWeaponsEast") then
{								
	CP_marksmanWeaponsEast		 = call compileFinal str	[
									[0,"srifle_EBR_F",["20Rnd_762x51_Mag",9]],
									[10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
									[20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
								   ];	
	publicvariable "CP_marksmanWeaponsEast";
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Specialist
//---------------------------------------------------------------------------------------------------------------------------------------------------------
if (isnil "CP_specialistItmes1") then
{
	CP_specialistItmes1			= call compileFinal str	[[0,"MineDetector",[]]];
	publicvariable "CP_specialistItmes1";
};

if (isnil "CP_specialistItmes2") then
{
	CP_specialistItmes2			= call compileFinal str	[[0,"DemoCharge_Remote_Mag",3]];
	publicvariable "CP_specialistItmes2";
};

if (isnil "CP_specialistItmes3") then
{							   
	CP_specialistItmes3			= call compileFinal str	[
									[0,"",0],
									[5,"APERSMine_Range_Mag",2],
									[10,"APERSBoundingMine_Range_Mag",2],
									[15,"ATMine_Range_Mag",2],
									[20,"SLAMDirectionalMine_Wire_Mag",2],
									[25,"SatchelCharge_Remote_Mag",2]];	
	publicvariable "CP_specialistItmes3";	
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Crew
//---------------------------------------------------------------------------------------------------------------------------------------------------------							
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------
if (isnil "CP_crewUniformsWest") then
{
	CP_crewUniformsWest		= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_B"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"]]	//Uniforms
									];
	publicvariable "CP_crewUniformsWest";
};

if (isnil "CP_crewUniformsEast") then
{								
	CP_crewUniformsEast		= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_O"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_BandollierB_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"]]	//Uniforms
									];
	publicvariable "CP_crewUniformsEast";
};

if (isnil "CP_crewUniformsGuar") then
{
	CP_crewUniformsGuar		= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_I"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform"]]	//Uniforms
									];
	publicvariable "CP_crewUniformsGuar";
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Pilot
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------
if (isnil "CP_pilotUniformsWest") then
{
	CP_pilotUniformsWest		= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_PilotHelmetHeli_B"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_HeliPilotCoveralls"]]	//Uniforms
									];
	publicvariable "CP_pilotUniformsWest";
};

if (isnil "CP_pilotUniformsEast") then
{								
	CP_pilotUniformsEast		= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_PilotHelmetHeli_O"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_BandollierB_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_PilotCoveralls"]]	//Uniforms
									];
	publicvariable "CP_pilotUniformsEast";
};

if (isnil "CP_pilotUniformsGuar") then
{
	CP_pilotUniformsGuar		= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_CrewHelmetHeli_I"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform"]]	//Uniforms
									];
	publicvariable "CP_pilotUniformsGuar";
};

//----------------------------------------------------SMG----------------------------------------------------------------
if (isnil "CP_SMG_01_F") then
{
	CP_SMG_01_F				=	call compileFinal str[
								[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
								[[0,""]], //Barrel
								[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
								];
	publicvariable "CP_SMG_01_F";
};

if (isnil "CP_SMG_02_F") then
{							
	CP_SMG_02_F				=	call compileFinal str[
								[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
								[[0,""]], //Barrel
								[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
								];	
	publicvariable "CP_SMG_02_F";
};

//------------------------------------------------------------------------------Primary---------------------------------------------------------------------------
//primary
if (isnil "CP_pilotWeaponWest") then
{
	CP_pilotWeaponWest = call compileFinal str	[[0,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]]]; 
	publicvariable "CP_pilotWeaponWest";
};

if (isnil "CP_pilotWeaponEast") then
{
	CP_pilotWeaponEast = call compileFinal str	[[0,"SMG_02_F",["30Rnd_9x21_Mag",6]]]; 
	publicvariable "CP_pilotWeaponEast";
};

