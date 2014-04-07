//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Corpsman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_corpsmanWeaponWest = ["SERVER_Corpsman", "primary", "CP_corpsmanWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_corpsmanWeaponWest == 0) then
{		
	CP_corpsmanWeaponWest 	= call compileFinal str	[
							[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[5,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[10,"arifle_MXC_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[20,"arifle_MXC_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ]; 
	["SERVER_Corpsman", "primary", "CP_corpsmanWeaponWest",CP_corpsmanWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Corpsman", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[10,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_Corpsman", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_corpsmanWeaponWest;




//East
CP_corpsmanWeaponEast = ["SERVER_Corpsman", "primary", "CP_corpsmanWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_corpsmanWeaponEast == 0) then
{							   
	CP_corpsmanWeaponEast 	= call compileFinal str 	[
							[0,"arifle_Katiba_C_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[20,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							]; 
	["SERVER_Corpsman", "primary", "CP_corpsmanWeaponEast",CP_corpsmanWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Corpsman", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_ACO_grn"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[10,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_Corpsman", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_corpsmanWeaponEast;



//GUER
CP_corpsmanWeaponGuer = ["SERVER_Corpsman", "primary", "CP_corpsmanWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_corpsmanWeaponGuer == 0) then
{
	CP_corpsmanWeaponGuer 	= call compileFinal str	[
							[0,"arifle_TRG20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_Mk20C_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[20,"arifle_MXC_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							];
	["SERVER_Corpsman", "primary", "CP_corpsmanWeaponGuer",CP_corpsmanWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Corpsman", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_ACO_grn"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[10,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_Corpsman", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_corpsmanWeaponGuer;

//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_corpsmanSecWest = ["SERVER_Corpsman", "secondery", "CP_corpsmanSecWest", "ARRAY"] call iniDB_read;
if (count CP_corpsmanSecWest == 0) then
{				   		   
	CP_corpsmanSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_Corpsman", "secondery", "CP_corpsmanSecWest",CP_corpsmanSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanSecWest";

//East
CP_corpsmanSecEast = ["SERVER_Corpsman", "secondery", "CP_corpsmanSecEast", "ARRAY"] call iniDB_read;
if (count CP_corpsmanSecEast == 0) then
{
	CP_corpsmanSecEast	= call compileFinal str 	[[0,"",["",0]]];
	["SERVER_Corpsman", "secondery", "CP_corpsmanSecEast",CP_corpsmanSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanSecEast";

//Guer
CP_corpsmanSecGuer = ["SERVER_Corpsman", "secondery", "CP_corpsmanSecGuer", "ARRAY"] call iniDB_read;
if (count CP_corpsmanSecGuer == 0) then
{
	CP_corpsmanSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_Corpsman", "secondery", "CP_corpsmanSecGuer",CP_corpsmanSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_corpsmanItmes1 = ["SERVER_Corpsman", "items", "CP_corpsmanItmes1", "ARRAY"] call iniDB_read;
if (count CP_corpsmanItmes1 == 0) then
{
	CP_corpsmanItmes1		= call compileFinal str	[
									[0,"Binocular", []],
									[10,"Rangefinder", []]
									];

	["SERVER_Corpsman", "items", "CP_corpsmanItmes1",CP_corpsmanItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_corpsmanItmes1"; 


CP_corpsmanItmes2 = ["SERVER_Corpsman", "items", "CP_corpsmanItmes2", "ARRAY"] call iniDB_read;
if (count CP_corpsmanItmes2 == 0) then
{
	CP_corpsmanItmes2		= call compileFinal str	[
									[0,"",0],
									[5,"30Rnd_556x45_Stanag",6],
									[10,"30Rnd_65x39_caseless_mag",6],
									[15,"150Rnd_762x51_Box",2],
									[12,"200Rnd_65x39_cased_Box",2],
									[0,"100Rnd_65x39_caseless_mag_Tracer",2]
									];

	["SERVER_Corpsman", "items", "CP_corpsmanItmes2",CP_corpsmanItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_corpsmanItmes2"; 

CP_corpsmanItmes3 = ["SERVER_Corpsman", "items", "CP_corpsmanItmes3", "ARRAY"] call iniDB_read;
if (count CP_corpsmanItmes3 == 0) then
{
	CP_corpsmanItmes3		= call compileFinal str	[
									[0,"FirstAidKit",10],
									[3,"SmokeShell",2],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_Corpsman", "items", "CP_corpsmanItmes3",CP_corpsmanItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_corpsmanItmes3"; 


CP_corpsmanGeneralItmes = ["SERVER_Corpsman", "items", "CP_corpsmanGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_corpsmanGeneralItmes == 0) then
{
	CP_corpsmanGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"FirstAidKit",10],
									[0,"SmokeShell",2],
									[0,"Medikit",1]
									];

	["SERVER_Corpsman", "items", "CP_corpsmanGeneralItmes",CP_corpsmanGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_corpsmanGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_corpsmanUniformsWest = ["SERVER_Corpsman", "gear", "CP_corpsmanUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_corpsmanUniformsWest == 0) then
{
	CP_corpsmanUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[5,"H_Booniehat_mcamo"],[10,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[5,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[15,"V_RebreatherB"],[20,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[5,"U_B_CombatUniform_mcam_tshirt"],[10,"U_B_CombatUniform_mcam_vest"],[15,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_Corpsman", "gear", "CP_corpsmanUniformsWest",CP_corpsmanUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_corpsmanUniformsWest";

CP_corpsmanUniformsEast = ["SERVER_Corpsman", "gear", "CP_corpsmanUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_corpsmanUniformsEast == 0) then
{								
	CP_corpsmanUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"],[15,"V_RebreatherIR"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[5,"B_FieldPack_ocamo"],[10,"B_Carryall_ocamo"],[15,"B_FieldPack_blk"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[5,"U_O_CombatUniform_oucamo"],[10,"U_O_SpecopsUniform_blk"],[15,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_Corpsman", "gear", "CP_corpsmanUniformsEast",CP_corpsmanUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanUniformsEast";

CP_corpsmanUniformsGuar = ["SERVER_Corpsman", "gear", "CP_corpsmanUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_corpsmanUniformsGuar == 0) then
{	
	CP_corpsmanUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Booniehat_khk"],[10,"H_Booniehat_mcamo"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"],[15,"V_RebreatherIA"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"],[15,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_Corpsman", "gear", "CP_corpsmanUniformsGuar",CP_corpsmanUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_corpsmanUniformsGuar";