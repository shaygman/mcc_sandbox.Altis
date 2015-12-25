//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											marksman
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West
CP_marksmanWeaponsWest = ["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsWest", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsWest == 0) then
{
	CP_marksmanWeaponsWest 	= call compileFinal str	[
								[0,"arifle_MXM_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
								[13,"srifle_LRR_F",["7Rnd_408_Mag",9]],
								[26,"srifle_GM6_F",["5Rnd_127x108_Mag",9]],
								[39,"arifle_MXM_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
								[52,"srifle_EBR_F",["20Rnd_762x51_Mag",9]]
						   ];
	["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsWest",CP_marksmanWeaponsWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsWest";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_MARKSMAN", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,"optic_MRCO"],[_factor+3,"optic_DMS"],[_factor+6,"optic_SOS"],[_factor+15,"optic_tws"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_H"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_MARKSMAN", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_marksmanWeaponsWest;




//East
CP_marksmanWeaponsEast = ["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsEast", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsEast == 0) then
{
	CP_marksmanWeaponsEast 	= call compileFinal str 	[
							[0,"srifle_DMR_01_F",["10Rnd_762x51_Mag",9]],
							[13,"srifle_LRR_F",["7Rnd_408_Mag",9]],
							[26,"srifle_GM6_F",["5Rnd_127x108_Mag",9]],
							[39,"srifle_EBR_F",["20Rnd_762x51_Mag",9]]
							];
	["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsEast",CP_marksmanWeaponsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsEast";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_MARKSMAN", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,"optic_MRCO"],[_factor+3,"optic_DMS"],[_factor+6,"optic_SOS"],[_factor+15,"optic_tws"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_B"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_MARKSMAN", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_marksmanWeaponsEast;



//GUER
CP_marksmanWeaponsGuer = ["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsGuer", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsGuer == 0) then
{
	CP_marksmanWeaponsGuer 	= call compileFinal str	[
							[0,"srifle_EBR_F",["20Rnd_762x51_Mag",9]],
							[13,"srifle_LRR_F",["7Rnd_408_Mag",9]],
							[26,"srifle_GM6_F",["5Rnd_127x108_Mag",9]],
							[39,"srifle_DMR_01_F",["10Rnd_762x51_Mag",9]]
							];
	["SERVER_MARKSMAN", "primary", "CP_marksmanWeaponsGuer",CP_marksmanWeaponsGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsGuer";

{
	_weapon = _x select 1;
	_factor		= _forEachIndex * 13;

	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_MARKSMAN", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read;
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,"optic_MRCO"],[_factor+3,"optic_DMS"],[_factor+6,"optic_SOS"],[_factor+15,"optic_tws"]], //optics
									[[0,""],[_factor+11,"muzzle_snds_B"]], //Barrel
									[[0,""],[_factor+5,"acc_flashlight"],[_factor+9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_MARKSMAN", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_marksmanWeaponsGuer;

//----------------------------------------------------Secondery----------------------------------------------------------------
//west
CP_marksmanWeaponsSecWest = ["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecWest", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsSecWest == 0) then
{
	CP_marksmanWeaponsSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecWest",CP_marksmanWeaponsSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsSecWest";

//East
CP_marksmanWeaponsSecEast = ["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecEast", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsSecEast == 0) then
{
	CP_marksmanWeaponsSecEast	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecEast",CP_marksmanWeaponsSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsSecEast";

//Guer
CP_marksmanWeaponsSecGuer = ["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecGuer", "ARRAY"] call iniDB_read;
if (count CP_marksmanWeaponsSecGuer == 0) then
{
	CP_marksmanWeaponsSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_MARKSMAN", "secondery", "CP_marksmanWeaponsSecGuer",CP_marksmanWeaponsSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanWeaponsSecGuer";
//------------------------------------------------------------------------------Items---------------------------------------------------------------------------
CP_marksmanItmes1 = ["SERVER_MARKSMAN", "items", "CP_marksmanItmes1", "ARRAY"] call iniDB_read;
if (count CP_marksmanItmes1 == 0) then
{
	CP_marksmanItmes1		= call compileFinal str	[
									[0,"Binocular", []],
									[10,"Rangefinder", []],
									[20,"Laserdesignator", ["Laserbatteries",1]]
									];

	["SERVER_MARKSMAN", "items", "CP_marksmanItmes1",CP_marksmanItmes1, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanItmes1";


CP_marksmanItmes2 = ["SERVER_MARKSMAN", "items", "CP_marksmanItmes2", "ARRAY"] call iniDB_read;
if (count CP_marksmanItmes2 == 0) then
{
	CP_marksmanItmes2		= call compileFinal str	[
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

	["SERVER_MARKSMAN", "items", "CP_marksmanItmes2",CP_marksmanItmes2, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanItmes2";

CP_marksmanItmes3 = ["SERVER_MARKSMAN", "items", "CP_marksmanItmes3", "ARRAY"] call iniDB_read;
if (count CP_marksmanItmes3 == 0) then
{
	CP_marksmanItmes3		= call compileFinal str	[
									[0,"MiniGrenade",2],
									[3,"SmokeShell",0],
									[7,"HandGrenade",2],
									[11,"SmokeShellRed",2],
									[11,"SmokeShellGreen",2],
									[21,"Chemlight_green",4],
									[21,"Chemlight_red",4],
									[21,"Chemlight_yellow",4],
									[31,"B_IR_Grenade",2]
									];

	["SERVER_MARKSMAN", "items", "CP_marksmanItmes3",CP_marksmanItmes3, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanItmes3";

CP_marksmanGeneralItmes = ["SERVER_MARKSMAN", "items", "CP_marksmanGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_marksmanGeneralItmes == 0) then
{
	CP_marksmanGeneralItmes		= if (missionNamespace getVariable ["MCC_medicComplex",false]) then
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

	["SERVER_MARKSMAN", "items", "CP_marksmanGeneralItmes",CP_marksmanGeneralItmes, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanGeneralItmes";
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_marksmanUniformsWest = ["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_marksmanUniformsWest == 0) then
{
	CP_marksmanUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetB_camo"],[3,"H_Shemag_khk"],[12,"H_Shemag_olive"],[24,"H_Shemag_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[15,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierGL_rgr"],[18,"V_TacVest_oli"],[50,"V_RebreatherB"],[27,"V_PlateCarrier1_blk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_CombatUniform_mcam_tshirt"],[21,"U_B_GhillieSuit"],[50,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsWest",CP_marksmanUniformsWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanUniformsWest";

CP_marksmanUniformsEast = ["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_marksmanUniformsEast == 0) then
{
	CP_marksmanUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_MilCap_ocamo"],[3,"H_Shemag_khk"],[12,"H_Shemag_olive"],[24,"H_Shemag_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[15,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[9,"V_HarnessOGL_gry"],[18,"V_HarnessOSpec_gry"],[50,"V_RebreatherIR"],[27,"V_TacVestIR_blk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[21,"U_O_GhillieSuit"],[50,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsEast",CP_marksmanUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanUniformsEast";

CP_marksmanUniformsGuar = ["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_marksmanUniformsGuar == 0) then
{
	CP_marksmanUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_HelmetIA_net"],[3,"H_Shemag_khk"],[12,"H_Shemag_olive"],[24,"H_Shemag_khk"]],	//Head
										[[0,""],[0,"G_Combat"],[6,"G_Tactical_Black"],[15,"G_Sport_Blackred"],[50,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[9,"V_PlateCarrierSpec_rgr"],[18,"V_TacVest_oli"],[50,"V_RebreatherIA"],[27,"V_TacVestIR_blk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform_tshirt"],[21,"U_I_GhillieSuit"],[50,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_MARKSMAN", "gear", "CP_marksmanUniformsGuar",CP_marksmanUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_marksmanUniformsGuar";