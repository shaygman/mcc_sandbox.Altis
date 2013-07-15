private ["_null"];
//init started
CP_initDone = false; 

//Debug
CP_debug = true; 

//Check for mode and define path
CP_isMode = isClass (configFile >> "CfgPatches" >> "chock_point");	//check if MCC is mod version

if (CP_isMode) then {
	CP_path = "\chock_point\";
	[] execVM CP_path +"init_mod.sqf";
		} else {
			CP_path = ""; 
			enableSaving [false, false];
			};
			
//- TODO introduction dialog
//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************

//---------------------------------------------
//		numbers of roles
//---------------------------------------------
CP_availablePilots 	= 1;
CP_availableCrew 	= 3; 

//---------------------------------------------
//		gears array
//---------------------------------------------
//HandGuns
CP_handguns	=	[[0,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
			    [10,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
			    [20,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]]]; 

//------------------------------------------------------------------------------------------------------------------------------
//			Accessory
//------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Rifles----------------------------------------------------------------
CP_arifle_TRG21_F	=	[
							[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_M"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Katiba_F	=	[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Mk20_F		=	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_MX_F		=	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
//----------------------------------------------------Carabines----------------------------------------------------------------
CP_arifle_TRG20_F	=	[
							[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_M"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Katiba_C_F	=	[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Mk20C_F		=	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_MXC_F		=	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];

//----------------------------------------------------GL----------------------------------------------------------------
CP_arifle_TRG21_GL_F	=	[
							[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_M"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Katiba_GL_F	=	[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_Mk20_GL_F		=	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_M"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
							
CP_arifle_MX_GL_F		=	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""],[29,"muzzle_snds_h"]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];

//----------------------------------------------------MG----------------------------------------------------------------					
CP_arifle_MX_SW_F		=	[
							[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
							[[0,""],[9,"muzzle_snds_h"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];

CP_LMG_Mk200_F			=	[
							[[10,""],[13,"optic_Aco"],[14,"optic_Holosight"],[15,"optic_MRCO"],[18,"optic_Hamr"],[19,"optic_Arco"]], //optics
							[[10,""],[19,"muzzle_snds_H_MG"]], //Barrel
							[[10,""],[15,"acc_flashlight"],[19,"acc_pointer_IR"]]	//Attach
							];
							
CP_LMG_Zafir_F			=	[
							[[20,""],[23,"optic_Aco"],[24,"optic_Holosight"],[25,"optic_MRCO"],[28,"optic_Hamr"],[29,"optic_Arco"]], //optics
							[[20,""]], //Barrel
							[[20,""],[25,"acc_flashlight"],[29,"acc_pointer_IR"]]	//Attach
							];
//----------------------------------------------------Snipers----------------------------------------------------------------
CP_arifle_MXM_F			=	[
							[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
							[[0,""],[9,"muzzle_snds_H"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_srifle_EBR_F			=	[
							[[0,"optic_MRCO"],[3,"optic_Hamr"],[6,"optic_Arco"],[9,"optic_SOS"]], //optics
							[[0,""],[9,"muzzle_snds_B"]], //Barrel
							[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
							];
							
CP_srifle_LRR_F			=	[
							[[10,"optic_MRCO"],[13,"optic_Hamr"],[16,"optic_Arco"],[19,"optic_SOS"]], //optics
							[[0,""]], //Barrel
							[[0,""]]	//Attach
							];
	
CP_srifle_GM6_F			=	[
							[[20,"optic_MRCO"],[23,"optic_Hamr"],[26,"optic_Arco"],[29,"optic_SOS"]], //optics
							[[0,""]], //Barrel
							[[0,""]]	//Attach
							];
							
//----------------------------------------------------SMG----------------------------------------------------------------
CP_SMG_01_F				=	[
							[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
							[[0,""]], //Barrel
							[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
							];
							
CP_SMG_02_F				=	[
							[[0,""],[5,"optic_Aco"],[10,"optic_Holosight"]], //optics
							[[0,""]], //Barrel
							[[0,""],[10,"acc_flashlight"],[15,"acc_pointer_IR"]]	//Attach
							];							
//------------------------------------------------------------------------------------------------------------------------------
//			Roles
//------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------AR---------------------------------------------------------------------------
//primary
CP_ARWeaponWest 	=[[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
					   [10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
					   [20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
					   ]; 
CP_ARWeaponEast 	=[[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
					   [10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
					   [20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
					   ]; 
CP_ARWeaponGuer 	=[[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag_Tracer",8]],
					   [10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",5]],
					   [20,"LMG_Zafir_F",["150Rnd_762x51_Box",5]]
					   ];
//------------------------------------------------------------------------------Rifleman---------------------------------------------------------------------------
//primary
CP_riflemanWeaponWest =[[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9]],
					   [10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
CP_riflemanWeaponEast =[[0,"arifle_Katiba_F",["30Rnd_65x39_caseless_green",9]],
					   [10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
CP_riflemanWeaponGuer =[[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9]],
					   [10,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MX_F",["30Rnd_65x39_caseless_mag"]]
					   ]; 
					   
//Secondery					   
CP_riflemanWeaponSecWest 	=[[0,"",["",0]]];
CP_riflemanWeaponSecEast	=[[0,"",["",0]]];
CP_riflemanWeaponSecGuer	=[[0,"",["",0]]];

//Items
CP_riflemanItmes1			= [[0,"", []],
							   [10,"Binocular", []],
							   [20,"Rangefinder", []]];
							   
CP_riflemanItmes2			= [	[0,"",0],
								[0,"30Rnd_556x45_Stanag",6],
								[0,"30Rnd_65x39_caseless_mag",6],
								[0,"150Rnd_762x51_Box",2],
								[0,"200Rnd_65x39_cased_Box",2],
								[0,"100Rnd_65x39_caseless_mag_Tracer",2]
								];
CP_riflemanItmes3			= 	[[0,"",0],
								[5,"SmokeShell",2],
								[10,"SmokeShellRed",2],
								[10,"SmokeShellGreen",2]];
								
CP_riflemanUniformsWest		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetB_plain_mcamo"],[10,"H_HelmetB_light"],[20,"H_HelmetB"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[20,"V_PlateCarrier2_blk"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
								
CP_riflemanUniformsEast		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetO_ocamo"],[10,"H_HelmetO_oucamo"],[20,"H_HelmetSpecO_blk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_SpecopsUniform_blk"]]	//Uniforms
								];

CP_riflemanUniformsGuar		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetIA"],[10,"H_HelmetIA_net"],[20,"H_HelmetIA_camo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];
//------------------------------------------------------------------------------Corpsman---------------------------------------------------------------------------
CP_corpsmanUniformsWest		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[20,"V_PlateCarrier2_blk"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
								
CP_corpsmanUniformsEast		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_SpecopsUniform_blk"]]	//Uniforms
								];

CP_corpsmanUniformsGuar		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"],[20,"H_Booniehat_ocamo"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];	
								
//Items
CP_corpsmanItmes1			= 	[[0,"Medikit", ["Medikit",1]]
								];
							   
CP_corpsmanItmes2			= 	[	[0,"",0]
								];
CP_corpsmanItmes3			= 	[	[0,"SmokeShell",4]
								];
//------------------------------------------------------------------------------Marksman---------------------------------------------------------------------------
CP_marksmanUniformsWest		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetB_light"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[20,"V_PlateCarrier2_blk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_GhillieSuit"]]	//Uniforms
								];
								
CP_marksmanUniformsEast		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_MilCap_ocamo"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[20,"U_O_GhillieSuit"]]	//Uniforms
								];

CP_marksmanUniformsGuar		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_HelmetIA_net"],[10,"H_Booniehat_khk"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform_tshirt"],[20,"U_I_GhillieSuit"]]	//Uniforms
								];
								
CP_marksmanWeaponsWest		 =[[0,"arifle_MXM_F",["30Rnd_65x39_caseless_mag",9]],
							   [10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
							   [20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
							   ]; 		
CP_marksmanWeaponsEast		 =[[0,"srifle_EBR_F",["20Rnd_762x51_Mag",9]],
							   [10,"srifle_LRR_F",["7Rnd_408_Mag",9]],
							   [20,"srifle_GM6_F",["5Rnd_127x108_Mag",9]]
							   ];	
//------------------------------------------------------------------------------Specialist---------------------------------------------------------------------------	
CP_specialistItmes1			= [[0,"MineDetector",[]]];
CP_specialistItmes2			= [[0,"DemoCharge_Remote_Mag",3]];
							   
CP_specialistItmes3			= [[0,"",0],
							   [5,"APERSMine_Range_Mag",2],
							   [10,"APERSBoundingMine_Range_Mag",2],
							   [15,"ATMine_Range_Mag",2],
							   [20,"SLAMDirectionalMine_Wire_Mag",2],
							   [25,"SatchelCharge_Remote_Mag",2]];							   
//------------------------------------------------------------------------------Crew---------------------------------------------------------------------------
CP_crewUniformsWest		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_B"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"]]	//Uniforms
								];
								
CP_crewUniformsEast		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_O"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"]]	//Uniforms
								];

CP_crewUniformsGuar		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_HelmetCrew_I"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform"]]	//Uniforms
								];
//------------------------------------------------------------------------------Pilot---------------------------------------------------------------------------
CP_pilotUniformsWest		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_PilotHelmetHeli_B"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_B_HeliPilotCoveralls"]]	//Uniforms
								];
								
CP_pilotUniformsEast		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_PilotHelmetHeli_O"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_O_PilotCoveralls"]]	//Uniforms
								];

CP_pilotUniformsGuar		= 	[
									[[0,"NVGoggles"]],		//NV
									[[0,"H_CrewHelmetHeli_I"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_TacVest_khk"]],	//Vest
									[[0,""]],	//Backpack
									[[0,"U_I_CombatUniform"]]	//Uniforms
								];
//primary
CP_pilotWeaponWest =[[0,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]]]; 
CP_pilotWeaponEast =[[0,"SMG_02_F",["30Rnd_9x21_Mag",6]]]; 

//------------------------------------------------------------------------------AT---------------------------------------------------------------------------							
//primary
CP_carabineWeaponWest =[[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9]],
					   [10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MXC_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
CP_carabineWeaponEast =[[0,"arifle_Katiba_C_F",["30Rnd_65x39_caseless_green",9]],
					   [10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9]]
					   ]; 
CP_carabineWeaponGuer =[[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9]],
					   [10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9]],
					   [20,"arifle_MXC_F",["30Rnd_65x39_caseless_mag"]]
					   ]; 

//Secondery					   
CP_ATWeaponSecWest 			=[[0,"launch_NLAW_F",["NLAW_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
CP_ATWeaponSecEast 			=[[0,"launch_RPG32_F",["RPG32_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
CP_ATWeaponSecGuer 			=[[0,"launch_NLAW_F",["NLAW_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
							  
//------------------------------------------------------------------------------Officer---------------------------------------------------------------------------
//primary
CP_officerWeaponWest =[[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
CP_officerWeaponEast =[[0,"arifle_Katiba_GL_F",["30Rnd_65x39_caseless_green",9,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
CP_officerWeaponGuer =[[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
					   

							  
//Items
CP_officerItmes1			= [[0,"Binocular", []],
							   [10,"Rangefinder", []],
							   [20,"Laserdesignator", ["Laserbatteries",1]]];
							   
CP_officerItmes2			= [[0,"1Rnd_Smoke_Grenade_shell",2],
							   [0,"1Rnd_SmokeRed_Grenade_shell",2],
							   [0,"1Rnd_SmokeGreen_Grenade_shell",2],
							   [10,"UGL_FlareWhite_F",2],
							   [10,"UGL_FlareCIR_F",2]];

CP_officerUniformsWest		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Cap_brn_SPECOPS"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[20,"V_PlateCarrier2_blk"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
								];
								
CP_officerUniformsEast		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_MilCap_ocamo"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
									[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
									[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_OfficerUniform_ocamo"]]	//Uniforms
								];

CP_officerUniformsGuar		= 	[
									[[0,""],[20,"NVGoggles"]],		//NV
									[[0,"H_Cap_brn_SERO"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
									[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
									[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
									[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
									[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
								];

//******************************************************************************************************************************
//											Stop Editing here
//******************************************************************************************************************************			
//---------------------------------------------
//		Handle functions
//---------------------------------------------
CP_fnc_globalExecute 	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_globalExecute.sqf");
CP_fnc_setValue 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setValue.sqf");
CP_fnc_getVariable 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_getVariable.sqf");
CP_fnc_buildSpawnPoint 	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_buildSpawnPoint.sqf");
CP_fnc_setGroupID 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setGroupID.sqf");
CP_fnc_getGroupID 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_getGroupID.sqf");
CP_fnc_setGear			= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setGear.sqf");
CP_fnc_assignGear		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_assignGear.sqf");
CP_fnc_addWeapon		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_addWeapon.sqf");
CP_fnc_addItem			= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_addItem.sqf");
CP_fnc_setVehicleInit	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setVehicleInit.sqf");

//---------------------------------------------
//		Server Init
//---------------------------------------------
if (isServer) then {
		_null=[] execVM CP_path + "scripts\server\server_init.sqf";
	};
	
CP_gotValueFromServer =false;

//---------------------------------------------
//		Player Init
//---------------------------------------------
if (!isDedicated) then {
		waituntil {alive player}; 
		player addEventHandler ["Respawn",{player execVM CP_path + "scripts\player\player_init.sqf";}];
		[["commanderLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "commanderLevel"};
		if (CP_debug) then {player sidechat format ["commanderLevel : %1",commanderLevel]};

		[["arLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "arLevel"};
		if (CP_debug) then {player sidechat format ["arLevel : %1",arLevel]};

		[["riflemanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "riflemanLevel"};
		if (CP_debug) then {player sidechat format ["riflemanLevel : %1",riflemanLevel]};

		[["ATLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "ATLevel"};
		if (CP_debug) then {player sidechat format ["ATLevel : %1",ATLevel]};

		[["corpsmanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "corpsmanLevel"};
		if (CP_debug) then {player sidechat format ["corpsmanLevel : %1",corpsmanLevel]};

		[["marksmanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "marksmanLevel"};
		if (CP_debug) then {player sidechat format ["marksmanLevel : %1",marksmanLevel]};

		[["specialistLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "specialistLevel"};
		if (CP_debug) then {player sidechat format ["specialistLevel : %1",specialistLevel]};

		[["crewLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "crewLevel"};
		if (CP_debug) then {player sidechat format ["crewLevel : %1",crewLevel]};

		[["pilotLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "pilotLevel"};
		if (CP_debug) then {player sidechat format ["pilotLevel : %1",pilotLevel]};
		
		_null=[] execVM CP_path + "scripts\player\player_init.sqf";
	};

//---------------------------------------------
//		Global CP Defines
//---------------------------------------------
CP_respawnPointsIndex 	= 0;
CP_squadListIndex		= 0;
CP_classes = ["Officer","AR","Rifleman","AT","Corpsman","Marksman","Specialist","Crew","Pilot"];
CP_classesPic = [	CP_path +"configs\data\Officer.paa",
					CP_path +"configs\data\AR.paa",
					CP_path +"configs\data\Rifleman.paa",
					CP_path +"configs\data\AT.paa",
					CP_path +"configs\data\Corpsman.paa",
					CP_path +"configs\data\Marksman.paa",
					CP_path +"configs\data\Specialist.paa",
					CP_path +"configs\data\Crew.paa",
					CP_path +"configs\data\Pilot.paa"
				];
CP_classesIndex = 0; 

CP_NVIndex 			= 0;
CP_headgearIndex 	= 0;
CP_gogglesIndex 	= 0;
CP_vestIndex 		= 0;
CP_backpackIndex 	= 0;
CP_uniformsIndex 	= 0;

CP_weaponAttachments 	= []; 
CP_currentItems1Index = 0;
CP_currentItems2Index = 0;
CP_currentItems3Index = 0;