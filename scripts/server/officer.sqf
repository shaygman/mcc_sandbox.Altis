//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Officer
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------primary---------------------------------------------------------------------------

//West
CP_officerWeaponWest = ["SERVER_officer", "primary", "CP_officerWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponWest == 0) then
{
	CP_officerWeaponWest = call compileFinal str	[
							[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_556x45_Stanag_Tracer_Red",2]],
							[13,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[26,"arifle_MX_GL_Black_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ];
	 ["SERVER_officer", "primary", "CP_officerWeaponWest",CP_officerWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponWest";

{
	_weapon 	= _x select 1;
	_factor		= _forEachIndex * 13;

	 if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+2,"optic_Aco"],[_factor + 4,"optic_Holosight"],[_factor +6,"optic_MRCO"],[_factor +8,"optic_Hamr"],[_factor + 10,"optic_Arco"],[_factor + 20,"optic_tws"]], //optics
									[[0,""],[_factor +11,"muzzle_snds_h"]], //Barrel
									[[0,""],[_factor +5,"acc_flashlight"],[_factor +9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_officerWeaponWest;


//East
CP_officerWeaponEast = ["SERVER_officer", "primary", "CP_officerWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponEast == 0) then
{
	CP_officerWeaponEast = call compileFinal str	[
							[0,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Green",2,"1Rnd_HE_Grenade_shell",6]],
							[13,"arifle_Katiba_GL_F",["30Rnd_65x39_caseless_green",9,"30Rnd_65x39_caseless_green_mag_Tracer",2,"1Rnd_HE_Grenade_shell",6]],
							[26,"arifle_MX_GL_Black_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ];
	["SERVER_officer", "primary", "CP_officerWeaponEast",CP_officerWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponEast";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+2,"optic_Aco"],[_factor+4,"optic_Holosight"],[_factor+6,"optic_MRCO"],[_factor+8,"optic_Hamr"],[_factor+10,"optic_Arco"],[_factor+20,"optic_tws"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_h"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_officerWeaponEast;


//Resistance
CP_officerWeaponGuer = ["SERVER_officer", "primary", "CP_officerWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponGuer == 0) then
{
	CP_officerWeaponGuer = call compileFinal str	[
							[0,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Yellow",2,"1Rnd_HE_Grenade_shell",6]],
							[13,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[26,"arifle_MX_GL_Black_F",["30Rnd_65x39_caseless_mag",9,"1Rnd_HE_Grenade_shell",6,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ];
	["SERVER_officer", "primary", "CP_officerWeaponGuer",CP_officerWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponGuer";

{
	_weapon = _x select 1;
	_factor	= _forEachIndex * 10;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_officer", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+2,"optic_Aco"],[_factor+4,"optic_Holosight"],[_factor+6,"optic_MRCO"],[_factor+8,"optic_Hamr"],[_factor+10,"optic_Arco"],[_factor+20,"optic_tws"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_h"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_officer", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_officerWeaponGuer;


//----------------------------------------------------Secondery----------------------------------------------------------------
//west
CP_officerWeaponSecWest = ["SERVER_officer", "secondery", "CP_officerWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecWest == 0) then
{
	CP_officerWeaponSecWest 	= call compileFinal str	[
									[0,"",["",0]],
									[5,"MCC_TentDome",[]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecWest",CP_officerWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecWest";

//East
CP_officerWeaponSecEast = ["SERVER_officer", "secondery", "CP_officerWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecEast == 0) then
{
	CP_officerWeaponSecEast	= call compileFinal str	[
									[0,"",["",0]],
									[5,"MCC_TentA",[]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecEast",CP_officerWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecEast";

//Guer
CP_officerWeaponSecGuer = ["SERVER_officer", "secondery", "CP_officerWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_officerWeaponSecGuer == 0) then
{
	CP_officerWeaponSecGuer	= call compileFinal str	[
									[0,"",["",0]],
									[5,"MCC_TentA",[]]];
	["SERVER_officer", "secondery", "CP_officerWeaponSecGuer",CP_officerWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerWeaponSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------
CP_officerItmes1 = ["SERVER_officer", "items", "CP_officerItmes1", "ARRAY"] call iniDB_read;
if (count CP_officerItmes1 == 0) then
{
	CP_officerItmes1		= call compileFinal str	[
									[0,"Binocular", []],
									[20,"Rangefinder", []],
									[40,"Laserdesignator", ["Laserbatteries",1]]
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
									[13,"UGL_FlareWhite_F",2],
									[21,"UGL_FlareCIR_F",2]];

	["SERVER_officer", "items", "CP_officerItmes2",CP_officerItmes2, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerItmes2";

CP_officerItmes3 = ["SERVER_officer", "items", "CP_officerItmes3", "ARRAY"] call iniDB_read;
if (count CP_officerItmes3 == 0) then
{
	CP_officerItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[7,"HandGrenade",2],
									[11,"SmokeShellRed",2],
									[11,"SmokeShellGreen",2],
									[21,"Chemlight_green",4],
									[21,"Chemlight_red",4],
									[21,"Chemlight_yellow",4],
									[31,"B_IR_Grenade",2]];

	["SERVER_officer", "items", "CP_officerItmes3",CP_officerItmes3, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerItmes3";

CP_officerGeneralItmes = ["SERVER_officer", "items", "CP_officerGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_officerGeneralItmes == 0) then
{
	CP_officerGeneralItmes		= if (missionNamespace getVariable ["MCC_medicComplex",false]) then
										{
											call compileFinal str	[
																		[0,"ItemGPS",1],
																		[0,"ItemMap",1],
																		[0,"ItemCompass",1],
																		[0,"ItemWatch",1],
																		[0,"ItemRadio",1],
																		[0,"MCC_bandage",2]
																		];
										}
										else
										{
											call compileFinal str	[
																		[0,"ItemGPS",1],
																		[0,"ItemMap",1],
																		[0,"ItemCompass",1],
																		[0,"ItemWatch",1],
																		[0,"ItemRadio",1],
																		[0,"FirstAidKit",2]
																		];
										};



	["SERVER_officer", "items", "CP_officerGeneralItmes",CP_officerGeneralItmes, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerGeneralItmes";
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_officerUniformsWest = ["SERVER_officer", "gear", "CP_officerUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsWest == 0) then
{
	CP_officerUniformsWest	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_Cap_brn_SPECOPS"],[3,"H_Cap_blk"],[18,"H_Beret_grn_SF"],[33,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[36,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierGL_rgr"],[24,"V_TacVest_oli"],[50,"V_RebreatherB"],[42,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[12,"B_Kitbag_mcamo"],[27,"B_Bergen_mcamo"],[39,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[15,"U_B_CombatUniform_mcam_tshirt"],[30,"U_B_CombatUniform_mcam_vest"],[50,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsWest",CP_officerUniformsWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerUniformsWest";

CP_officerUniformsEast = ["SERVER_officer", "gear", "CP_officerUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsEast == 0) then
{
	CP_officerUniformsEast	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_MilCap_ocamo"],[3,"H_Cap_blk"],[18,"H_Beret_grn_SF"],[33,"H_HelmetSpecO_blk"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[9,"V_HarnessOGL_gry"],[24,"V_HarnessOSpec_gry"],[50,"V_RebreatherIR"],[39,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[12,"B_FieldPack_ocamo"],[27,"B_Carryall_ocamo"],[36,"B_FieldPack_blk"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[15,"U_O_CombatUniform_oucamo"],[30,"U_O_OfficerUniform_ocamo"],[50,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsEast",CP_officerUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerUniformsEast";

CP_officerUniformsGuar = ["SERVER_officer", "gear", "CP_officerUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_officerUniformsGuar == 0) then
{
	CP_officerUniformsGuar	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_Cap_grn"],[3,"H_Cap_blk"],[18,"H_Beret_grn_SF"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierSpec_rgr"],[24,"V_TacVest_oli"],[50,"V_RebreatherIA"],[33,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[12,"B_Kitbag_mcamo"],[27,"B_Bergen_mcamo"],[30,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_I_CombatUniform"],[15,"U_I_CombatUniform_tshirt"],[50,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_officer", "gear", "CP_officerUniformsGuar",CP_officerUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_officerUniformsGuar";