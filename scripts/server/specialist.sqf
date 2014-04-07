//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											specialist
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_specialistWeaponWest = ["SERVER_SPECIALIST", "primary", "CP_specialistWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponWest == 0) then
{		
	CP_specialistWeaponWest 	= call compileFinal str	[
							[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_Red",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]],
							[20,"arifle_MX_Black_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
						   ]; 
	["SERVER_SPECIALIST", "primary", "CP_specialistWeaponWest",CP_specialistWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_SPECIALIST", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_Aco"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_SPECIALIST", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_specialistWeaponWest;


//East
CP_specialistWeaponEast = ["SERVER_SPECIALIST", "primary", "CP_specialistWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponEast == 0) then
{							   
	CP_specialistWeaponEast 	= call compileFinal str 	[
							[0,"arifle_Katiba_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							]; 
	["SERVER_SPECIALIST", "primary", "CP_specialistWeaponEast",CP_specialistWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_SPECIALIST", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_ACO_grn"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_SPECIALIST", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_specialistWeaponEast;



//GUER
CP_specialistWeaponGuer = ["SERVER_SPECIALIST", "primary", "CP_specialistWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponGuer == 0) then
{
	CP_specialistWeaponGuer 	= call compileFinal str	[
							[0,"arifle_TRG21_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[5,"arifle_Mk20_F",["30Rnd_556x45_Stanag",9,"30Rnd_65x39_caseless_green",2]],
							[10,"arifle_MX_F",["30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2]]
							];
	["SERVER_SPECIALIST", "primary", "CP_specialistWeaponGuer",CP_specialistWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_SPECIALIST", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[3,"optic_ACO_grn"],[5,"optic_Holosight"],[10,"optic_MRCO"],[13,"optic_Hamr"],[15,"optic_Arco"],[20,"optic_tws"]], //optics
									[[0,""],[9,"muzzle_snds_h"]], //Barrel
									[[0,""],[5,"acc_flashlight"],[9,"acc_pointer_IR"]]	//Attach
									];
			["SERVER_SPECIALIST", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_specialistWeaponGuer;

//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_specialistWeaponSecWest = ["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponSecWest == 0) then
{				   		   
	CP_specialistWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecWest",CP_specialistWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponSecWest";

//East
CP_specialistWeaponSecEast = ["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponSecEast == 0) then
{
	CP_specialistWeaponSecEast	= call compileFinal str 	[[0,"",["",0]]];
	["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecEast",CP_specialistWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponSecEast";

//Guer
CP_specialistWeaponSecGuer = ["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_specialistWeaponSecGuer == 0) then
{
	CP_specialistWeaponSecGuer	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_SPECIALIST", "secondery", "CP_specialistWeaponSecGuer",CP_specialistWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistWeaponSecGuer";

//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_specialistItmes1 = ["SERVER_SPECIALIST", "items", "CP_specialistItmes1", "ARRAY"] call iniDB_read;
if (count CP_specialistItmes1 == 0) then
{
	CP_specialistItmes1		= call compileFinal str	[
									[0,"MineDetector", []],
									[5,"Binocular", []],
									[10,"ToolKit", []],
									[15,"B_UavTerminal", []],
									[20,"Rangefinder", []]									
									];

	["SERVER_SPECIALIST", "items", "CP_specialistItmes1",CP_specialistItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_specialistItmes1"; 


CP_specialistItmes2 = ["SERVER_SPECIALIST", "items", "CP_specialistItmes2", "ARRAY"] call iniDB_read;
if (count CP_specialistItmes2 == 0) then
{
	CP_specialistItmes2		= call compileFinal str	[
									[0,"",0],
									[0,"APERSMine_Range_Mag",2],
									[5,"SLAMDirectionalMine_Wire_Mag",2],
									[10,"APERSBoundingMine_Range_Mag",2],
									[15,"ATMine_Range_Mag",2],
									[20,"SatchelCharge_Remote_Mag",2]
									];

	["SERVER_SPECIALIST", "items", "CP_specialistItmes2",CP_specialistItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_specialistItmes2"; 

CP_specialistItmes3 = ["SERVER_SPECIALIST", "items", "CP_specialistItmes3", "ARRAY"] call iniDB_read;
if (count CP_specialistItmes3 == 0) then
{
	CP_specialistItmes3		= call compileFinal str	[
									[0,"",0],
									[0,"MiniGrenade",2],
									[3,"SmokeShell",2],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_SPECIALIST", "items", "CP_specialistItmes3",CP_specialistItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_specialistItmes3"; 

CP_specialistGeneralItmes = ["SERVER_SPECIALIST", "items", "CP_specialistGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_specialistGeneralItmes == 0) then
{
	CP_specialistGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"HandGrenade",2],
									[0,"SmokeShell",2],
									[0,"SmokeShell",2],
									[0,"FirstAidKit",2],
									[0,"DemoCharge_Remote_Mag",2]									
									];
									
	["SERVER_SPECIALIST", "items", "CP_specialistGeneralItmes",CP_specialistGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_specialistGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_specialistUniformsWest = ["SERVER_SPECIALIST", "gear", "CP_specialistUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_specialistUniformsWest == 0) then
{
	CP_specialistUniformsWest	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Watchcap_blk"],[10,"H_HelmetB_light"],[15,"H_HelmetB_light_black"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[5,"V_PlateCarrierGL_rgr"],[10,"V_TacVest_oli"],[15,"V_RebreatherB"],[20,"V_PlateCarrier1_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"B_UAV_01_backpack_F"]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"],[5,"U_B_CombatUniform_mcam_tshirt"],[10,"U_B_CombatUniform_mcam_vest"],[15,"U_B_Wetsuit"]]	//Uniforms
									];
	["SERVER_SPECIALIST", "gear", "CP_specialistUniformsWest",CP_specialistUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_specialistUniformsWest";

CP_specialistUniformsEast = ["SERVER_SPECIALIST", "gear", "CP_specialistUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_specialistUniformsEast == 0) then
{								
	CP_specialistUniformsEast	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Watchcap_blk"],[10,"H_HelmetO_oucamo"],[20,"H_HelmetSpecO_blk"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"],[10,"V_HarnessOGL_gry"],[20,"V_HarnessOSpec_gry"],[15,"V_RebreatherIR"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_ocamo"],[5,"B_FieldPack_ocamo"],[10,"B_Carryall_ocamo"],[15,"O_UAV_01_backpack_F"]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"],[5,"U_O_CombatUniform_oucamo"],[10,"U_O_SpecopsUniform_blk"],[15,"U_O_Wetsuit"]]	//Uniforms
									];
	["SERVER_SPECIALIST", "gear", "CP_specialistUniformsEast",CP_specialistUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistUniformsEast";

CP_specialistUniformsGuar = ["SERVER_SPECIALIST", "gear", "CP_specialistUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_specialistUniformsGuar == 0) then
{	
	CP_specialistUniformsGuar	= call compileFinal str	[
										[[0,""],[20,"NVGoggles"]],		//NV
										[[0,"H_Watchcap_blk"],[10,"H_HelmetIA_net"],[20,"H_HelmetIA_camo"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_PlateCarrier1_rgr"],[10,"V_PlateCarrierSpec_rgr"],[20,"V_TacVest_oli"],[15,"V_RebreatherIA"],[20,"V_TacVestIR_blk"]],	//Vest
										[[0,"B_AssaultPack_mcamo"],[5,"B_Kitbag_mcamo"],[10,"B_Bergen_mcamo"],[15,"I_UAV_01_backpack_F"]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_CombatUniform_tshirt"],[15,"U_I_Wetsuit"]]	//Uniforms
									];
	["SERVER_SPECIALIST", "gear", "CP_specialistUniformsGuar",CP_specialistUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_specialistUniformsGuar";