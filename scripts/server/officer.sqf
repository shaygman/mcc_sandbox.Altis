//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Officer
//---------------------------------------------------------------------------------------------------------------------------------------------------------		
//------------------------------------------------------------------------------primary---------------------------------------------------------------------------

//West 
CP_officerWeaponWest = ["SERVER_officer", "primary", "CP_officerWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponWest == 0) then
{	
	CP_officerWeaponWest = call compileFinal str	[
							[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
							[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
							[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
						   ]; 
	 ["SERVER_officer", "primary", "CP_officerWeaponWest",CP_officerWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
	};
} foreach CP_officerWeaponWest;
publicvariable format ["CP_%1",_weapon];

//East
CP_officerWeaponEast = ["SERVER_officer", "primary", "CP_officerWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponEast == 0) then
{						   
	CP_officerWeaponEast = call compileFinal str	[
							[0,"arifle_Katiba_GL_F",["30Rnd_65x39_caseless_green",9,"1Rnd_HE_Grenade_shell",6]],
							[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
							[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
						   ]; 
	["SERVER_officer", "primary", "CP_officerWeaponEast",CP_officerWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
	};
} foreach CP_officerWeaponEast;
publicvariable format ["CP_%1",_weapon];

//Resistance
CP_officerWeaponGuer = ["SERVER_officer", "primary", "CP_officerWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponGuer == 0) then
{	
	CP_officerWeaponGuer = call compileFinal str	[
							[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
							[10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6]],
							[20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6]]
						   ];
	["SERVER_officer", "primary", "CP_officerWeaponGuer",CP_officerWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponGuer";		

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[4,"optic_Holosight"],[5,"optic_MRCO"],[8,"optic_Hamr"],[9,"optic_Arco"]], //optics
									[[0,""],[9,"muzzle_snds_M"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
	};
} foreach CP_officerWeaponGuer;
publicvariable format ["CP_%1",_weapon];

//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_officerWeaponSecWest = ["SERVER_officer", "secondery", "CP_officerWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecWest == 0) then
{				   		   
	CP_officerWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecWest",CP_officerWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecWest";

//East
CP_officerWeaponSecEast = ["SERVER_officer", "secondery", "CP_officerWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecEast == 0) then
{
	CP_officerWeaponSecEast	= call compileFinal str 	[[0,"",["",0]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecEast",CP_officerWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecEast";

//Guer
CP_officerWeaponSecGuer = ["SERVER_officer", "secondery", "CP_officerWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecGuer == 0) then
{
	CP_officerWeaponSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecGuer",CP_officerWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_officerItmes1 = ["SERVER_officer", "items", "CP_officerItmes1", "ARRAY"] call iniDB_read;
if (count CP_officerItmes1 == 0) then
{
	CP_officerItmes1		= call compileFinal str	[
									[0,"Binocular", []],
									[10,"Rangefinder", []],
									[10,"Laserdesignator", ["Laserbatteries",1]],
									[15,"B_UavTerminal", []]
									];

	["SERVER_officer", "items", "CP_officerItmes1",CP_officerItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_officerItmes1"; 


CP_officerItmes2 = ["SERVER_officer", "items", "CP_officerItmes2", "ARRAY"] call iniDB_read;
if (count CP_officerItmes2 == 0) then
{
	CP_officerItmes2		= call compileFinal str	[
									[0,"1Rnd_Smoke_Grenade_shell",2],
									[0,"1Rnd_SmokeRed_Grenade_shell",2],
									[0,"1Rnd_SmokeGreen_Grenade_shell",2],
									[10,"UGL_FlareWhite_F",2],
									[10,"UGL_FlareCIR_F",2]];

	["SERVER_officer", "items", "CP_officerItmes2",CP_officerItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_officerItmes2"; 

CP_officerItmes3 = ["SERVER_officer", "items", "CP_officerItmes3", "ARRAY"] call iniDB_read;
if (count CP_officerItmes3 == 0) then
{
	CP_officerItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_officer", "items", "CP_officerItmes3",CP_officerItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_officerItmes3"; 

//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_officerUniformsWest = ["SERVER_officer", "gear", "CP_officerUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsWest == 0) then
{
	CP_officerUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Cap_brn_SPECOPS"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"],[15,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierGL_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[10,"U_B_CombatUniform_mcam_tshirt"],[20,"U_B_CombatUniform_mcam_vest"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsWest",CP_officerUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_officerUniformsWest";

CP_officerUniformsEast = ["SERVER_officer", "gear", "CP_officerUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsEast == 0) then
{								
	CP_officerUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_MilCap_ocamo"],[5,"H_Cap_blk"],[10,"H_Beret_grn_SF"],[15,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[10,"B_FieldPack_ocamo"],[20,"B_Carryall_ocamo"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[10,"U_O_SpecopsUniform_ocamo"],[20,"U_O_OfficerUniform_ocamo"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsEast",CP_officerUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerUniformsEast";

CP_officerUniformsGuar = ["SERVER_officer", "gear", "CP_officerUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsGuar == 0) then
{	
	CP_officerUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Cap_grn"],[10,"H_Cap_blk"],[20,"H_Beret_grn_SF"]],	//Head
										[[0,""],[0,"G_Combat"],[10,"G_Tactical_Black"],[20,"G_Sport_Blackred"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[10,"B_Kitbag_mcamo"],[20,"B_Bergen_mcamo"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsGuar",CP_officerUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerUniformsGuar";