//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											AR
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_ARWeaponWest = ["SERVER_AR", "primary", "CP_ARWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_ARWeaponWest == 0) then
{		
	CP_ARWeaponWest 	= call compileFinal str	[
							[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[5,"arifle_MX_SW_Black_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",3,"200Rnd_65x39_cased_Box_Tracer",2]],
							[20,"LMG_Zafir_F",["150Rnd_762x51_Box",3,"150Rnd_762x51_Box_Tracer",2]]
						   ]; 
	["SERVER_AR", "primary", "CP_ARWeaponWest",CP_ARWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_ARWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_AR", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_AR", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_ARWeaponWest;


//East
CP_ARWeaponEast = ["SERVER_AR", "primary", "CP_ARWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_ARWeaponEast == 0) then
{							   
	CP_ARWeaponEast 	= call compileFinal str 	[
							[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[5,"arifle_MX_SW_Black_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",3,"200Rnd_65x39_cased_Box_Tracer",2]],
							[20,"LMG_Zafir_F",["150Rnd_762x51_Box",3,"150Rnd_762x51_Box_Tracer",2]]
							]; 
	["SERVER_AR", "primary", "CP_ARWeaponEast",CP_ARWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_ARWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_AR", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_AR", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_ARWeaponEast;



//GUER
CP_ARWeaponGuer = ["SERVER_AR", "primary", "CP_ARWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_ARWeaponGuer == 0) then
{
	CP_ARWeaponGuer 	= call compileFinal str	[
							[0,"arifle_MX_SW_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[5,"arifle_MX_SW_Black_F",["100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2]],
							[10,"LMG_Mk200_F",["200Rnd_65x39_cased_Box",3,"200Rnd_65x39_cased_Box_Tracer",2]],
							[20,"LMG_Zafir_F",["150Rnd_762x51_Box",3,"150Rnd_762x51_Box_Tracer",2]]
							];
	["SERVER_AR", "primary", "CP_ARWeaponGuer",CP_ARWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_ARWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_AR", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_AR", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_ARWeaponGuer;

//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_arWeaponSecWest = ["SERVER_AR", "secondery", "CP_arWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_arWeaponSecWest == 0) then
{				   		   
	CP_arWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_AR", "secondery", "CP_arWeaponSecWest",CP_arWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_arWeaponSecWest";

//East
CP_arWeaponSecEast = ["SERVER_AR", "secondery", "CP_arWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_arWeaponSecEast == 0) then
{
	CP_arWeaponSecEast	= call compileFinal str 	[[0,"",["",0]]];
	["SERVER_AR", "secondery", "CP_arWeaponSecEast",CP_arWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_arWeaponSecEast";

//Guer
CP_arWeaponSecGuer = ["SERVER_AR", "secondery", "CP_arWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_arWeaponSecGuer == 0) then
{
	CP_arWeaponSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_AR", "secondery", "CP_arWeaponSecGuer",CP_arWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_arWeaponSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_ARItmes1 = ["SERVER_AR", "items", "CP_ARItmes1", "ARRAY"] call iniDB_read;
if (count CP_ARItmes1 == 0) then
{
	CP_ARItmes1		= call compileFinal str	[
									[0,"Binocular", []],
									[10,"Rangefinder", []]
									];

	["SERVER_AR", "items", "CP_ARItmes1",CP_ARItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_ARItmes1"; 


CP_ARItmes2 = ["SERVER_AR", "items", "CP_ARItmes2", "ARRAY"] call iniDB_read;
if (count CP_ARItmes2 == 0) then
{
	CP_ARItmes2		= call compileFinal str	[
									[0,"",0],
									[5,"30Rnd_556x45_Stanag",6],
									[10,"30Rnd_65x39_caseless_mag",6],
									[15,"150Rnd_762x51_Box",2],
									[12,"200Rnd_65x39_cased_Box",2],
									[0,"100Rnd_65x39_caseless_mag_Tracer",2]
									];

	["SERVER_AR", "items", "CP_ARItmes2",CP_ARItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_ARItmes2"; 

CP_ARItmes3 = ["SERVER_AR", "items", "CP_ARItmes3", "ARRAY"] call iniDB_read;
if (count CP_ARItmes3 == 0) then
{
	CP_ARItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_AR", "items", "CP_ARItmes3",CP_ARItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_ARItmes3"; 

CP_ARGeneralItmes = ["SERVER_AR", "items", "CP_ARGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_ARGeneralItmes == 0) then
{
	CP_ARGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"HandGrenade",2],
									[0,"SmokeShell",2],
									[0,"FirstAidKit",2]
									];

	["SERVER_AR", "items", "CP_ARGeneralItmes",CP_ARGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_ARGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_ARUniformsWest = ["SERVER_AR", "gear", "CP_ARUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_ARUniformsWest == 0) then
{
	CP_ARUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Bandanna_khk"],[3,"H_Bandanna_mcamo"],[6,"H_Bandanna_camo"],[10,"H_HelmetB_light"],[15,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[5,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[15,"V_RebreatherB"],[20,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[5,"U_B_CombatUniform_mcam_tshirt"],[10,"U_B_CombatUniform_mcam_vest"],[15,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_AR", "gear", "CP_ARUniformsWest",CP_ARUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_ARUniformsWest";

CP_ARUniformsEast = ["SERVER_AR", "gear", "CP_ARUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_ARUniformsEast == 0) then
{								
	CP_ARUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Bandanna_khk"],[3,"H_Bandanna_mcamo"],[6,"H_Bandanna_camo"],[10,"H_HelmetO_oucamo"],[20,"H_HelmetSpecO_blk"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"],[15,"V_RebreatherIR"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[5,"B_FieldPack_ocamo"],[10,"B_Carryall_ocamo"],[15,"B_FieldPack_blk"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[5,"U_O_CombatUniform_oucamo"],[10,"U_O_SpecopsUniform_blk"],[15,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_AR", "gear", "CP_ARUniformsEast",CP_ARUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_ARUniformsEast";

CP_ARUniformsGuar = ["SERVER_AR", "gear", "CP_ARUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_ARUniformsGuar == 0) then
{	
	CP_ARUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Bandanna_khk"],[3,"H_Bandanna_mcamo"],[6,"H_Bandanna_camo"],[10,"H_HelmetIA_net"],[20,"H_HelmetIA_camo"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"],[15,"V_RebreatherIA"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"],[15,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_AR", "gear", "CP_ARUniformsGuar",CP_ARUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_ARUniformsGuar";