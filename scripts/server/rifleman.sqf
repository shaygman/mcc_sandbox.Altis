//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											rifleman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_riflemanWeaponWest = ["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponWest == 0) then
{		
	CP_riflemanWeaponWest 	= call compileFinal str	[
							[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[20,"arifle_MX_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ]; 
	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponWest",CP_riflemanWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_RIFLEMAN", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_riflemanWeaponWest;





//East
CP_riflemanWeaponEast = ["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponEast == 0) then
{							   
	CP_riflemanWeaponEast 	= call compileFinal str 	[
							[0,"arifle_Katiba_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							]; 
	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponEast",CP_riflemanWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_ACO_grn"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_RIFLEMAN", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_riflemanWeaponEast;


//GUER
CP_riflemanWeaponGuer = ["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponGuer == 0) then
{
	CP_riflemanWeaponGuer 	= call compileFinal str	[
							[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag_Tracer",2]]
							];
	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponGuer",CP_riflemanWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_RIFLEMAN", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_riflemanWeaponGuer;

//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_riflemanWeaponSecWest = ["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponSecWest == 0) then
{				   		   
	CP_riflemanWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecWest",CP_riflemanWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponSecWest";

//East
CP_riflemanWeaponSecEast = ["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponSecEast == 0) then
{
	CP_riflemanWeaponSecEast	= call compileFinal str 	[[0,"",["",0]]];
	["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecEast",CP_riflemanWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponSecEast";

//Guer
CP_riflemanWeaponSecGuer = ["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponSecGuer == 0) then
{
	CP_riflemanWeaponSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_RIFLEMAN", "secondery", "CP_riflemanWeaponSecGuer",CP_riflemanWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_riflemanItmes1 = ["SERVER_RIFLEMAN", "items", "CP_riflemanItmes1", "ARRAY"] call iniDB_read;
if (count CP_riflemanItmes1 == 0) then
{
	CP_riflemanItmes1		= call compileFinal str	[
									[0,"", []],
									[10,"Binocular", []],
									[20,"Rangefinder", []]
									];

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes1",CP_riflemanItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_riflemanItmes1"; 


CP_riflemanItmes2 = ["SERVER_RIFLEMAN", "items", "CP_riflemanItmes2", "ARRAY"] call iniDB_read;
if (count CP_riflemanItmes2 == 0) then
{
	CP_riflemanItmes2		= call compileFinal str	[
									[0,"",0],
									[0,"30Rnd_556x45_Stanag",6],
									[10,"30Rnd_65x39_caseless_mag",6],
									[15,"150Rnd_762x51_Box",2],
									[12,"200Rnd_65x39_cased_Box",2],
									[5,"100Rnd_65x39_caseless_mag_Tracer",2]
									];

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes2",CP_riflemanItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_riflemanItmes2"; 

CP_riflemanItmes3 = ["SERVER_RIFLEMAN", "items", "CP_riflemanItmes3", "ARRAY"] call iniDB_read;
if (count CP_riflemanItmes3 == 0) then
{
	CP_riflemanItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes3",CP_riflemanItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_riflemanItmes3"; 

CP_riflemanGeneralItmes = ["SERVER_RIFLEMAN", "items", "CP_riflemanGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_riflemanGeneralItmes == 0) then
{
	CP_riflemanGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"HandGrenade",2],
									[0,"SmokeShell",2],
									[0,"FirstAidKit",2]
									];

	["SERVER_RIFLEMAN", "items", "CP_riflemanGeneralItmes",CP_riflemanGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_riflemanGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_riflemanUniformsWest = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsWest == 0) then
{
	CP_riflemanUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetB"],[10,"H_HelmetB_light"],[15,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[5,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[15,"V_RebreatherB"],[20,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[5,"U_B_CombatUniform_mcam_tshirt"],[10,"U_B_CombatUniform_mcam_vest"],[15,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsWest",CP_riflemanUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_riflemanUniformsWest";

CP_riflemanUniformsEast = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsEast == 0) then
{								
	CP_riflemanUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetO_ocamo"],[10,"H_HelmetO_oucamo"],[20,"H_HelmetSpecO_blk"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"],[15,"V_RebreatherIR"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[5,"B_FieldPack_ocamo"],[10,"B_Carryall_ocamo"],[15,"B_FieldPack_blk"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[5,"U_O_CombatUniform_oucamo"],[10,"U_O_SpecopsUniform_blk"],[15,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsEast",CP_riflemanUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanUniformsEast";

CP_riflemanUniformsGuar = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsGuar == 0) then
{	
	CP_riflemanUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetIA"],[10,"H_HelmetIA_net"],[20,"H_HelmetIA_camo"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"],[15,"V_RebreatherIA"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"],[15,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsGuar",CP_riflemanUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanUniformsGuar";