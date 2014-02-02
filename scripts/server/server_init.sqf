private ["_string","_group"];

if (CP_debug) then {diag_log "CP server init started"};

//---------------------------------------------
//		Define Global variables
//---------------------------------------------
CP_eastSpawnPoints 	= [];
CP_westSpawnPoints 	= [];
CP_guarSpawnPoints  = [];
CP_westGroups 		= [];
CP_eastGroups 		= [];
CP_guarGroups 		= [];

publicVariable "CP_eastSpawnPoints";
publicVariable "CP_westSpawnPoints";
publicVariable "CP_guarSpawnPoints";
publicVariable "CP_westGroups";
publicVariable "CP_eastGroups";
publicVariable "CP_guarGroups";
publicVariable "CP_maxPlayers";
publicVariable "CP_maxSquads";

//Tickets number
CP_eastTickets = 200; 
CP_westTickets = 200; 
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
{												//West
	_group = createGroup west;
	waituntil {!isnil "_group"};
	CP_westGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

{												//East
	_group = createGroup east;
	waituntil {!isnil "_group"};
	CP_eastGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

{												//East
	_group = createGroup resistance;
	waituntil {!isnil "_group"};
	CP_guarGroups set [_forEachIndex,[_group,_x]];
} foreach ["Alpha","Bravo","Charlie","Delta"];

publicvariable "CP_westGroups";
publicvariable "CP_eastGroups";
publicvariable "CP_guarGroups";

//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************

//---------------------------------------------
//		gears array
//---------------------------------------------
//HandGuns
CP_handguns	= 	call compileFinal str	[
				[0,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
			    [10,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
			    [20,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]]]; 
publicvariable "CP_handguns"; 				

//------------------------------------------------------------------------------------------------------------------------------
//			Roles
//------------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Officer
//---------------------------------------------------------------------------------------------------------------------------------------------------------		
//----------------------------------------------------GL Rifels----------------------------------------------------------------
CP_arifle_TRG21_GL_F	=	call compileFinal str[
							[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_M"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_TRG21_GL_F";
							
CP_arifle_Katiba_GL_F	=	call compileFinal str[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Katiba_GL_F";
							
CP_arifle_Mk20_GL_F		=	call compileFinal str[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Mk20_GL_F";
							
CP_arifle_MX_GL_F		=	call compileFinal str[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_MX_GL_F";
					  
//------------------------------------------------------------------------------primary---------------------------------------------------------------------------
CP_officerWeaponWest = call compileFinal str	[
						[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
						[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
						[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
publicvariable "CP_officerWeaponWest";
					   
CP_officerWeaponEast = call compileFinal str	[
						[0,"arifle_Katiba_GL_F",["30Rnd_65x39_caseless_green",9,"1Rnd_HE_Grenade_shell",6]],
						[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
						[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
publicvariable "CP_officerWeaponEast";
					   
CP_officerWeaponGuer = call compileFinal str	[
						[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
						[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
						[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ];
publicvariable "CP_officerWeaponGuer";				   

//------------------------------------------------------------------------------Items---------------------------------------------------------------------------							  
CP_officerItmes1		= call compileFinal str	[
								[0,"Binocular", []],
								[10,"Rangefinder", []],
								[20,"Laserdesignator", ["Laserbatteries",1]]];
publicvariable "CP_officerItmes1";
							   
CP_officerItmes2		= call compileFinal str	[
								[0,"1Rnd_Smoke_Grenade_shell",2],
								[0,"1Rnd_SmokeRed_Grenade_shell",2],
								[0,"1Rnd_SmokeGreen_Grenade_shell",2],
								[10,"UGL_FlareWhite_F",2],
								[10,"UGL_FlareCIR_F",2]];
publicvariable "CP_officerItmes2";								


//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------
CP_officerUniformsWest	= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Cap_brn_SPECOPS"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
publicvariable "CP_officerUniformsWest";
								
CP_officerUniformsEast	= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_MilCap_ocamo"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_OfficerUniform_ocamo"]]	//Uniforms
								];
publicvariable "CP_officerUniformsEast";

CP_officerUniformsGuar	= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Cap_grn"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];
publicvariable "CP_officerUniformsGuar";

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											AR
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------MG----------------------------------------------------------------					
CP_arifle_MX_SW_F		=	call compileFinal str[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_MX_SW_F";

CP_LMG_Mk200_F			=	call compileFinal str[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_H_MG"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_LMG_Mk200_F";
							
CP_LMG_Zafir_F			=	call compileFinal str[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_LMG_Zafir_F";

//----------------------------------------------------Primary----------------------------------------------------------------
CP_ARWeaponWest 	= call compileFinal str	[
						[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
						[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
						[20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
					   ]; 
publicvariable "CP_ARWeaponWest";
					   
CP_ARWeaponEast 	= call compileFinal str 	[
						[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
						[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
						[20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
						]; 
publicvariable "CP_ARWeaponEast";
						
CP_ARWeaponGuer 	= call compileFinal str	[
						[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
						[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
						[20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
						];
publicvariable "CP_ARWeaponGuer";


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Rifleman
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Rifles----------------------------------------------------------------
CP_arifle_TRG21_F	=	call compileFinal str [
								[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
								[[0,""],[9,"muzzle_snds_M"]], //Barrel
								[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
								];
publicvariable "CP_arifle_TRG21_F"; 
							
CP_arifle_Katiba_F	=	call compileFinal str	[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Katiba_F";
							
CP_arifle_Mk20_F	=	call compileFinal str	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Mk20_F";
							
CP_arifle_MX_F		=	call compileFinal str	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_MX_F";

//----------------------------------------------------Primary----------------------------------------------------------------
CP_riflemanWeaponWest = call compileFinal str	[
						[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9]],
						[10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
publicvariable "CP_riflemanWeaponWest";

CP_riflemanWeaponEast = call compileFinal str	[
						[0,"arifle_Katiba_F",["30Rnd_65x39_caseless_green",9]],
						[10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
publicvariable "CP_riflemanWeaponEast";

CP_riflemanWeaponGuer = call compileFinal str	[
						[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9]],
						[10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MX_F",["30Rnd_65x39_caseless_mag"]]
					   ]; 
publicvariable "CP_riflemanWeaponGuer";

//----------------------------------------------------Secondery----------------------------------------------------------------					   		   
CP_riflemanWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
publicvariable "CP_riflemanWeaponSecWest";

CP_riflemanWeaponSecEast	= call compileFinal str 	[[0,"",["",0]]];
publicvariable "CP_riflemanWeaponSecEast";

CP_riflemanWeaponSecGuer	= call compileFinal str	[[0,"",["",0]]];
publicvariable "CP_riflemanWeaponSecGuer";

//----------------------------------------------------Items----------------------------------------------------------------					   
CP_riflemanItmes1			= call compileFinal str	[
								[0,"", []],
								[10,"Binocular", []],
								[20,"Rangefinder", []]];
publicvariable "CP_riflemanItmes1";
							   
CP_riflemanItmes2			= call compileFinal str	[
								[0,"",0],
								[0,"30Rnd_556x45_Stanag",6],
								[0,"30Rnd_65x39_caseless_mag",6],
								[0,"150Rnd_762x51_Box",2],
								[0,"200Rnd_65x39_cased_Box",2],
								[0,"100Rnd_65x39_caseless_mag_Tracer",2]
								];
publicvariable "CP_riflemanItmes2";
								
CP_riflemanItmes3			= call compileFinal str	[
								[0,"",0],
								[5,"SmokeShell",2],
								[10,"SmokeShellRed",2],
								[10,"SmokeShellGreen",2]];
publicvariable "CP_riflemanItmes3";

//----------------------------------------------------Gear----------------------------------------------------------------									
CP_riflemanUniformsWest		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetB_plain_mcamo"],[10,"H_HelmetB_light"],[20,"H_HelmetB"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
publicvariable "CP_riflemanUniformsWest";
								
CP_riflemanUniformsEast		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetO_ocamo"],[10,"H_HelmetO_oucamo"],[20,"H_HelmetSpecO_blk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_SpecopsUniform_blk"]]	//Uniforms
								];
publicvariable "CP_riflemanUniformsEast";

CP_riflemanUniformsGuar		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetIA"],[10,"H_HelmetIA_net"],[20,"H_HelmetIA_camo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];
publicvariable "CP_riflemanUniformsGuar";

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											AT
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Carabines----------------------------------------------------------------
CP_arifle_TRG20_F	=	call compileFinal str	[
							[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_M"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_TRG20_F";

CP_arifle_Katiba_C_F	=	call compileFinal str[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Katiba_C_F";
							
CP_arifle_Mk20C_F	=	call compileFinal str	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_Mk20C_F";
							
CP_arifle_MXC_F		=	call compileFinal str	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_MXC_F";

//------------------------------------------------------------------------------primary---------------------------------------------------------------------------							
CP_carabineWeaponWest = call compileFinal str	[
						[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9]],
						[10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MXC_F",["30Rnd_65x39_caseless_mag",9]]
						]; 
publicvariable "CP_carabineWeaponWest";
						
CP_carabineWeaponEast = call compileFinal str	[
						[0,"arifle_Katiba_C_F",["30Rnd_65x39_caseless_green",9]],
						[10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
publicvariable "CP_carabineWeaponEast";
					   
CP_carabineWeaponGuer = call compileFinal str	[
						[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9]],
						[10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
						[20,"arifle_MXC_F",["30Rnd_65x39_caseless_mag"]]
					   ]; 
publicvariable "CP_carabineWeaponGuer";					   

//------------------------------------------------------------------------------Secondery---------------------------------------------------------------------------	
   
CP_ATWeaponSecWest 	= call compileFinal str	[
						[0,"launch_NLAW_F",["NLAW_F",2]],
						[10,"launch_B_Titan_F",["Titan_AA",2]],
						[20,"launch_B_Titan_short_F",["Titan_AT",2]]];
publicvariable "CP_ATWeaponSecWest";
						
CP_ATWeaponSecEast 	= call compileFinal str	[
						[0,"launch_RPG32_F",["RPG32_F",2]],
						[10,"launch_B_Titan_F",["Titan_AA",2]],
						[20,"launch_B_Titan_short_F",["Titan_AT",2]]];
publicvariable "CP_ATWeaponSecEast";
						
CP_ATWeaponSecGuer 	= call compileFinal str	[
						[0,"launch_NLAW_F",["NLAW_F",2]],
						[10,"launch_B_Titan_F",["Titan_AA",2]],
						[20,"launch_B_Titan_short_F",["Titan_AT",2]]];
publicvariable "CP_ATWeaponSecGuer";


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Corpsman
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Gear----------------------------------------------------------------
CP_corpsmanUniformsWest		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
publicvariable "CP_corpsmanUniformsWest";
								
CP_corpsmanUniformsEast		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_SpecopsUniform_blk"]]	//Uniforms
								];
publicvariable "CP_corpsmanUniformsEast";

CP_corpsmanUniformsGuar		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];	
publicvariable "CP_corpsmanUniformsGuar";
								
//----------------------------------------------------Items----------------------------------------------------------------
CP_corpsmanItmes1			= call compileFinal str	[[0,"Medikit", ["Medikit",1]]
								];
publicvariable "CP_corpsmanItmes1";
							   
CP_corpsmanItmes2			= call compileFinal str	[	[0,"",0]
								];
publicvariable "CP_corpsmanItmes2";

CP_corpsmanItmes3			= call compileFinal str	[	[0,"SmokeShell",4]
								];
publicvariable "CP_corpsmanItmes3";

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Marksman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Snipers' Rifles----------------------------------------------------------------
CP_arifle_MXM_F			=	call compileFinal str[
							[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
							[[0,""],[9,"muzzle_snds_H"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_arifle_MXM_F";
							
CP_srifle_EBR_F			=	call compileFinal str[
							[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
							[[0,""],[9,"muzzle_snds_B"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_srifle_EBR_F";
							
CP_srifle_LRR_F			=	call compileFinal str[
							[[10,"optic_MRCO"],[13,"optic_Hamr"],[16,"optic_Arco"],[19,"optic_SOS"]], //optics
							[[0,""]], //Barrel
							[[0,""]]	//Attach
							];
publicvariable "CP_srifle_LRR_F";
	
CP_srifle_GM6_F			=	call compileFinal str[
							[[20,"optic_MRCO"],[23,"optic_Hamr"],[26,"optic_Arco"],[29,"optic_SOS"]], //optics
							[[0,""]], //Barrel
							[[0,""]]	//Attach
							];
publicvariable "CP_srifle_GM6_F";

//----------------------------------------------------Gear----------------------------------------------------------------
CP_marksmanUniformsWest		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetB_light"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_GhillieSuit"]]	//Uniforms
								];
publicvariable "CP_marksmanUniformsWest";
								
CP_marksmanUniformsEast		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_MilCap_ocamo"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[20,"U_O_GhillieSuit"]]	//Uniforms
								];
publicvariable "CP_marksmanUniformsEast";

CP_marksmanUniformsGuar		= call compileFinal str	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetIA_net"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform_tshirt"],[20,"U_I_GhillieSuit"]]	//Uniforms
								];
publicvariable "CP_marksmanUniformsGuar";

//----------------------------------------------------Primary----------------------------------------------------------------								
CP_marksmanWeaponsWest		 = call compileFinal str	[
								[0,"arifle_MXM_F",["30Rnd_65x39_caseless_mag",9]],
								[10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
								[20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
								]; 
publicvariable "CP_marksmanWeaponsWest";
								
CP_marksmanWeaponsEast		 = call compileFinal str	[
								[0,"srifle_EBR_F",["20Rnd_762x51_Mag",9]],
								[10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
								[20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
							   ];	
publicvariable "CP_marksmanWeaponsEast";


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Specialist
//---------------------------------------------------------------------------------------------------------------------------------------------------------
CP_specialistItmes1			= call compileFinal str	[[0,"MineDetector",[]]];
publicvariable "CP_specialistItmes1";

CP_specialistItmes2			= call compileFinal str	[[0,"DemoCharge_Remote_Mag",3]];
publicvariable "CP_specialistItmes2";
							   
CP_specialistItmes3			= call compileFinal str	[
								[0,"",0],
								[5,"APERSMine_Range_Mag",2],
								[10,"APERSBoundingMine_Range_Mag",2],
								[15,"ATMine_Range_Mag",2],
								[20,"SLAMDirectionalMine_Wire_Mag",2],
								[25,"SatchelCharge_Remote_Mag",2]];	
publicvariable "CP_specialistItmes3";	


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Crew
//---------------------------------------------------------------------------------------------------------------------------------------------------------							
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------
CP_crewUniformsWest		= call compileFinal str	[
									[[0,""],[10,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_B"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"]]	//Uniforms
								];
publicvariable "CP_crewUniformsWest";
								
CP_crewUniformsEast		= call compileFinal str	[
									[[0,""],[10,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_O"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"]]	//Uniforms
								];
publicvariable "CP_crewUniformsEast";

CP_crewUniformsGuar		= call compileFinal str	[
									[[0,""],[10,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_I"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform"]]	//Uniforms
								];
publicvariable "CP_crewUniformsGuar";


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Pilot
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------
CP_pilotUniformsWest		= call compileFinal str	[
									[[0,""],[5,"NVGoggles"]],		//NV
									[[0,"H_PilotHelmetHeli_B"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_HeliPilotCoveralls"]]	//Uniforms
								];
publicvariable "CP_pilotUniformsWest";
								
CP_pilotUniformsEast		= call compileFinal str	[
									[[0,""],[5,"NVGoggles"]],		//NV
									[[0,"H_PilotHelmetHeli_O"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_PilotCoveralls"]]	//Uniforms
								];
publicvariable "CP_pilotUniformsEast";

CP_pilotUniformsGuar		= call compileFinal str	[
									[[0,""],[5,"NVGoggles"]],		//NV
									[[0,"H_CrewHelmetHeli_I"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform"]]	//Uniforms
								];
publicvariable "CP_pilotUniformsGuar";

//----------------------------------------------------SMG----------------------------------------------------------------
CP_SMG_01_F				=	call compileFinal str[
							[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
							[[0,""]], //Barrel
							[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
							];
publicvariable "CP_SMG_01_F";
							
CP_SMG_02_F				=	call compileFinal str[
							[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
							[[0,""]], //Barrel
							[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
							];	
publicvariable "CP_SMG_02_F";

//------------------------------------------------------------------------------Primary---------------------------------------------------------------------------
//primary
CP_pilotWeaponWest = call compileFinal str	[[0,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]]]; 
publicvariable "CP_pilotWeaponWest";

CP_pilotWeaponEast = call compileFinal str	[[0,"SMG_02_F",["30Rnd_9x21_Mag",6]]]; 
publicvariable "CP_pilotWeaponEast";


