//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											rifleman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West
CP_riflemanWeaponWest = ["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_riflemanWeaponWest == 0) then
{
	CP_riflemanWeaponWest 	= call compileFinal str	[
							[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2]],
							[13,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[26,"arifle_MX_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ];

	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponWest",CP_riflemanWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponWest";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+3,"optic_Aco"],[_factor+4,"optic_Holosight"],[_factor+6,"optic_MRCO"],[_factor+8,"optic_Hamr"],[_factor+10,"optic_Arco"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_M"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
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
							[0,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Green",2]],
							[13,"arifle_Katiba_F",["30Rnd_65x39_caseless_green",9,"30Rnd_65x39_caseless_green_mag_Tracer",2]],
							[26,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							];
	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponEast",CP_riflemanWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponEast";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+3,"optic_ACO_grn"],[_factor+4,"optic_Holosight"],[_factor+6,"optic_MRCO"],[_factor+8,"optic_Hamr"],[_factor+10,"optic_Arco"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_h"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
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
							[0,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Yellow",2]],
							[13,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[26,"arifle_MX_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							];
	["SERVER_RIFLEMAN", "primary", "CP_riflemanWeaponGuer",CP_riflemanWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanWeaponGuer";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_RIFLEMAN", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[_factor+3,"optic_Aco"],[_factor+4,"optic_Holosight"],[_factor+6,"optic_MRCO"],[_factor+8,"optic_Hamr"],[_factor+10,"optic_Arco"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_M"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
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
									[20,"Binocular", []],
									[40,"Rangefinder", []]
									];

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes1",CP_riflemanItmes1, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanItmes1";


CP_riflemanItmes2 = ["SERVER_RIFLEMAN", "items", "CP_riflemanItmes2", "ARRAY"] call iniDB_read;
if (count CP_riflemanItmes2 == 0) then
{
	if (MCC_isMode) then
	{
		CP_riflemanItmes2		= call compileFinal str	[
										[0,"", 0],
										[0,"MCC_ammoBoxMag",2],
										[3,"SmokeShell",2],
										[7,"HandGrenade",2],
										[11,"SmokeShellRed",2],
										[11,"SmokeShellGreen",2],
										[21,"Chemlight_green",4],
										[21,"Chemlight_red",4],
										[21,"Chemlight_yellow",4],
										[31,"B_IR_Grenade",2]
										];
	}
	else
	{
		CP_riflemanItmes2		= call compileFinal str	[
										[3,"MiniGrenade",2],
										[0,"SmokeShell",0],
										[7,"HandGrenade",2],
										[11,"SmokeShellRed",2],
										[11,"SmokeShellGreen",2],
										[21,"Chemlight_green",4],
										[21,"Chemlight_red",4],
										[21,"Chemlight_yellow",4],
										[31,"B_IR_Grenade",2]
										];
	};

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes2",CP_riflemanItmes2, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanItmes2";

CP_riflemanItmes3 = ["SERVER_RIFLEMAN", "items", "CP_riflemanItmes3", "ARRAY"] call iniDB_read;
if (count CP_riflemanItmes3 == 0) then
{
	CP_riflemanItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[7,"HandGrenade",2],
									[11,"SmokeShellRed",2],
									[11,"SmokeShellGreen",2],
									[21,"Chemlight_green",4],
									[21,"Chemlight_red",4],
									[21,"Chemlight_yellow",4],
									[31,"B_IR_Grenade",2]];

	["SERVER_RIFLEMAN", "items", "CP_riflemanItmes3",CP_riflemanItmes3, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanItmes3";

CP_riflemanGeneralItmes = ["SERVER_RIFLEMAN", "items", "CP_riflemanGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_riflemanGeneralItmes == 0) then
{
	CP_riflemanGeneralItmes		= if (missionNamespace getVariable ["MCC_medicComplex",false]) then
	{
		call compileFinal str	[
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
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"FirstAidKit",2]
									];
	};

	["SERVER_RIFLEMAN", "items", "CP_riflemanGeneralItmes",CP_riflemanGeneralItmes, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanGeneralItmes";
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_riflemanUniformsWest = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsWest == 0) then
{
	CP_riflemanUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetB"],[3,"H_HelmetB_light"],[18,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[36,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierGL_rgr"],[24,"V_TacVest_oli"],[50,"V_RebreatherB"],[42,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[12,"B_Kitbag_mcamo"],[27,"B_Bergen_mcamo"],[39,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[15,"U_B_CombatUniform_mcam_tshirt"],[30,"U_B_CombatUniform_mcam_vest"],[50,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsWest",CP_riflemanUniformsWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanUniformsWest";

CP_riflemanUniformsEast = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsEast == 0) then
{
	CP_riflemanUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetO_ocamo"],[3,"H_HelmetO_oucamo"],[18,"H_HelmetSpecO_blk"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[9,"V_HarnessOGL_gry"],[24,"V_HarnessOSpec_gry"],[50,"V_RebreatherIR"],[39,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[12,"B_FieldPack_ocamo"],[27,"B_Carryall_ocamo"],[36,"B_FieldPack_blk"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[15,"U_O_CombatUniform_oucamo"],[30,"U_O_OfficerUniform_ocamo"],[50,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsEast",CP_riflemanUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanUniformsEast";

CP_riflemanUniformsGuar = ["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_riflemanUniformsGuar == 0) then
{
	CP_riflemanUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetIA"],[3,"H_HelmetIA_net"],[18,"H_HelmetIA_camo"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[21,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierSpec_rgr"],[24,"V_TacVest_oli"],[50,"V_RebreatherIA"],[33,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[12,"B_Kitbag_mcamo"],[27,"B_Bergen_mcamo"],[30,"B_AssaultPack_blk"]],	//Backpack
										[[0,"U_I_CombatUniform"],[15,"U_I_CombatUniform_tshirt"],[50,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_RIFLEMAN", "gear", "CP_riflemanUniformsGuar",CP_riflemanUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_riflemanUniformsGuar";