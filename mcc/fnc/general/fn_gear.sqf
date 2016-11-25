/* =============================================================== MCC_fnc_gear ==========================================================
	sets default gear.
========================================================================================================================================== */

private ["_unit","_role","_sideId","_isSF","_uniform","_uniformLight","_vest","_vestLight","_backPack","_backPackLight","_helmet","_helmetLight",
         "_GPS","_medPack","_medKit","_goggles","_primaryWeapon","_primaryWeaponMag","_primaryWeaponTracer","_hGrenade","_hsmokeW","_hsmokeR","_hsmokeG",
		 "_attach","_mags","_light","_nvg","_seconderyWeapon","_seconderyWeaponMags","_extraAmmo","_extraGear","_extraItems","_binos"];
_unit = param [0, objNull, [objNull,""]];
_role =  param [1, "", [""]];

if (typeName _unit != typeName objNull) exitWith {};
if (isnUll _unit || _role == "") exitWith {};

//If not local get out
if !(local _unit) exitWith {};
/*
waituntil {alive _unit && !isnil "paramsArray"};
if (isPlayer _unit) then {waituntil {!(IsNull (findDisplay 46))}};
*/
//get side
_sideId = side _unit call BIS_fnc_sideID;		//0-east 1 - west 2 - res
_isSF = ["sf", _role] call BIS_fnc_inString;

//if civilian get out
if (_sideId > 2) exitWith {};

//remove gear
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//General
_GPS 		= "";
_medPack 	= "FirstAidKit";
_medKit 	= "Medikit";
_hGrenade	= "MiniGrenade";
_hsmokeW	= "SmokeShell";
_hsmokeR	= "SmokeShellRed";
_hsmokeG	= "SmokeShellGreen";
_nvg		= ["NVGoggles","NVGoggles","NVGoggles"] select _sideId;
_seconderyWeapon = "";
_seconderyWeaponMags = [];
_extraAmmo = [];
_extraGear = [];
_extraItems = [];
_light = false;
_binos = "";

if (_isSF) then
{
	//Unitforms
	switch (paramsArray select 0) do
	{
		case 0:		//Regular
		{
			_uniform = ["U_O_CombatUniform_oucamo","U_B_CTRG_3","U_I_CombatUniform"] select _sideId;
			_uniformLight = ["U_O_CombatUniform_oucamo","U_B_CTRG_2","U_I_CombatUniform_shortsleeve"] select _sideId;
			_vest = ["V_HarnessO_gry","V_PlateCarrier2_rgr","V_PlateCarrierIAGL_dgtl"] select _sideId;
			_vestLight = ["V_HarnessOGL_gry","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl"] select _sideId;
			_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
			_backPackLight = ["B_Kitbag_cbr","B_Kitbag_cbr","B_Kitbag_rgr"] select _sideId;
			_helmet	= ["H_HelmetLeaderO_oucamo","H_HelmetSpecB_paint2","H_HelmetIA"] select _sideId;
			_helmetLight = ["H_Beret_blk","H_Booniehat_khk_hs","H_MilCap_dgtl"] select _sideId;
			_goggles = ["G_Tactical_Clear","G_Tactical_Clear","G_Tactical_Clear"] select _sideId;
		};
		case 1:		//Night
		{
			_uniform = ["U_O_CombatUniform_oucamo","U_I_G_Story_Protagonist_F","U_I_CombatUniform"] select _sideId;
			_uniformLight = ["U_O_CombatUniform_oucamo","U_I_G_Story_Protagonist_F","U_I_CombatUniform_shortsleeve"] select _sideId;
			_vest = ["V_HarnessO_gry","V_PlateCarrier1_blk","V_PlateCarrierIAGL_dgtl"] select _sideId;
			_vestLight = ["V_HarnessOGL_gry","V_TacVest_blk","V_PlateCarrierIA1_dgtl"] select _sideId;
			_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
			_backPackLight = ["B_AssaultPack_blk","B_AssaultPack_blk","B_AssaultPack_blk"] select _sideId;
			_helmet	= ["H_HelmetSpecO_blk","H_HelmetB_light_black","H_HelmetIA"] select _sideId;
			_helmetLight = ["H_Beret_blk","H_Watchcap_blk","H_MilCap_dgtl"] select _sideId;
			_goggles = ["G_Tactical_Clear","G_Tactical_Clear","G_Tactical_Clear"] select _sideId;
		};
		case 2:		//Divers
		{
			_uniform = ["U_O_Wetsuit","U_B_Wetsuit","U_I_Wetsuit"] select _sideId;
			_uniformLight = ["U_O_Wetsuit","U_B_Wetsuit","U_I_Wetsuit"] select _sideId;
			_vest = ["V_RebreatherIR","V_RebreatherB","V_RebreatherIA"] select _sideId;
			_vestLight = ["V_RebreatherIR","V_RebreatherB","V_RebreatherIA"] select _sideId;
			_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
			_backPackLight = ["B_AssaultPack_blk","B_AssaultPack_blk","B_AssaultPack_blk"] select _sideId;
			_helmet	= ["","",""] select _sideId;
			_helmetLight = ["","",""] select _sideId;
			_goggles = ["G_O_Diving","G_B_Diving","G_I_Diving"] select _sideId;
		};

		case 3:		//Ghille
		{
			_uniform = ["U_O_GhillieSuit","U_B_GhillieSuit","U_I_GhillieSuit"] select _sideId;
			_uniformLight = ["U_O_GhillieSuit","U_B_GhillieSuit","U_I_GhillieSuit"] select _sideId;
			_vest = ["V_HarnessO_gry","V_PlateCarrier2_rgr","V_PlateCarrierIAGL_dgtl"] select _sideId;
			_vestLight = ["V_HarnessOGL_gry","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl"] select _sideId;
			_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
			_backPackLight = ["B_Kitbag_cbr","B_Kitbag_cbr","B_Kitbag_rgr"] select _sideId;
			_helmet	= ["","",""] select _sideId;
			_helmetLight = ["","",""] select _sideId;
			_goggles = ["G_Tactical_Clear","G_Tactical_Clear","G_Tactical_Clear"] select _sideId;
		};

		default		//T1
		{
			_uniform = ["U_BG_Guerilla1_1","U_BG_Guerilla1_1","U_BG_Guerilla1_1"] select _sideId;
			_uniformLight = ["U_BG_Guerilla3_1","U_BG_Guerilla3_1","U_BG_Guerilla3_1"] select _sideId;
			_vest = ["V_HarnessO_gry","V_PlateCarrier2_rgr","V_PlateCarrierIAGL_dgtl"] select _sideId;
			_vestLight = ["V_HarnessOGL_gry","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl"] select _sideId;
			_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
			_backPackLight = ["B_Kitbag_cbr","B_Kitbag_cbr","B_Kitbag_rgr"] select _sideId;
			_helmet	= ["","",""] select _sideId;
			_helmetLight = ["","",""] select _sideId;
			_goggles = ["G_Tactical_Clear","G_Tactical_Clear","G_Tactical_Clear"] select _sideId;
		};
	};

	//Gear and micro manage
	switch (true) do
	{
		case (_role in ["sftl"]):
		{
			_primaryWeapon = ["arifle_Katiba_GL_F","arifle_MX_GL_Black_F","arifle_MX_GL_Black_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"] select _sideId;
			_seconderyWeapon = ["MCC_TentA","MCC_TentDome","MCC_TentDome"] select _sideId;
			_mags = [11,2];
			_light = false;
			_attach = [["muzzle_snds_H","acc_pointer_IR","optic_Hamr"],["muzzle_snds_H","acc_pointer_IR","optic_Hamr"],["muzzle_snds_H","acc_pointer_IR","optic_Hamr"]] select _sideId;
			_extraAmmo = [["1Rnd_HE_Grenade_shell",10],["1Rnd_SmokeRed_Grenade_shell",2],["1Rnd_SmokeGreen_Grenade_shell",2],["UGL_FlareWhite_F",2]];
			_extraGear = ["ItemGPS"];
			_extraItems = ["MCC_multiTool"];
			_binos = "Rangefinder";
			_helmet	= ["H_Cap_tan","H_Cap_blk","H_Cap_grn"] select _sideId;
		};
		case (_role in ["sfmg"]):
		{
			_primaryWeapon = ["LMG_Mk200_F","arifle_MX_SW_Black_F","arifle_MX_SW_Black_F"] select _sideId;
			_primaryWeaponMag = ["200Rnd_65x39_cased_Box","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag"] select _sideId;
			_primaryWeaponTracer = ["200Rnd_65x39_cased_Box_Tracer","100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag_Tracer"] select _sideId;
			_mags = [4,2];
			_light = true;
			_attach = [["muzzle_snds_H_MG","acc_pointer_IR","optic_MRCO"],["muzzle_snds_H_SW","acc_pointer_IR","optic_MRCO"],["muzzle_snds_H_SW","acc_pointer_IR","optic_MRCO"]] select _sideId;
			_extraGear = ["ItemGPS"];
			_extraItems = ["MCC_multiTool"];
			_binos = "Rangefinder";
		};
		case (_role in ["sfmed","sfdem","sfat"]):
		{
			_primaryWeapon = ["arifle_Katiba_C_F","arifle_MXC_Black_F","arifle_MXC_Black_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"] select _sideId;
			_mags = [10,2];
			_light = false;
			_attach = [["muzzle_snds_H","acc_pointer_IR","optic_Hamr"],["muzzle_snds_H","acc_pointer_IR","optic_Hamr"],["muzzle_snds_H","acc_pointer_IR","optic_Hamr"]] select _sideId;

			switch (_role) do
			{
				case "sfmed" :
				{
					_extraAmmo = [[_medPack,5],[_medKit,1]];
					_extraGear = ["ItemGPS"];
					_extraItems = ["MCC_multiTool"];
					_binos = "Rangefinder";
				};
				case "sfdem" :
				{
					_extraAmmo = [["ClaymoreDirectionalMine_Remote_Mag",3],["DemoCharge_Remote_Mag",2]];
					_extraGear = ["ItemGPS"];
					_extraItems = ["MCC_multiTool","MCC_videoProbe"];
					_binos = "Rangefinder";
				};
				case "sfat" :
				{
					_seconderyWeapon = ["launch_RPG32_F","launch_NLAW_F","launch_NLAW_F"] select _sideId;
					_seconderyWeaponMags = [["RPG32_F","RPG32_HE_F"],["NLAW_F","NLAW_F"],["NLAW_F","NLAW_F"]] select _sideId;
					_extraAmmo = [["Laserbatteries",2]];
					_extraGear = ["ItemGPS"];
					_extraItems = ["MCC_multiTool"];
					_binos = "Laserdesignator";
				};
			};
		};
		case (_role in ["sfmark"]):
		{
			_primaryWeapon = ["srifle_DMR_01_F","srifle_EBR_F","srifle_EBR_F"] select _sideId;
			_primaryWeaponMag = ["10Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag"] select _sideId;
			_primaryWeaponTracer = ["10Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag"] select _sideId;
			_mags = [9,2];
			_light = true;
			_attach = [["muzzle_snds_B","","optic_DMS"],["muzzle_snds_B","acc_pointer_IR","optic_DMS"],["muzzle_snds_B","acc_pointer_IR","optic_DMS"]] select _sideId;
			_extraGear = ["ItemGPS"];
			_extraItems = ["MCC_multiTool"];
			_binos = "Rangefinder";
			_helmetLight = ["H_Shemag_olive_hs","H_Shemag_olive_hs","H_Shemag_olive_hs"] select _sideId;
		};
	};
}
else
{
	//uniforms
	_uniform = ["U_O_CombatUniform_ocamo","U_B_CombatUniform_mcam","U_I_CombatUniform"] select _sideId;
	_uniformLight = ["U_O_CombatUniform_ocamo","U_B_CombatUniform_mcam_tshirt","U_I_CombatUniform_shortsleeve"] select _sideId;
	_vest = ["V_HarnessO_gry","V_PlateCarrier2_rgr","V_PlateCarrierIAGL_dgtl"] select _sideId;
	_vestLight = ["V_HarnessOGL_gry","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl"] select _sideId;
	_backPack = ["B_Carryall_oucamo","B_Carryall_khk","B_Carryall_oli"] select _sideId;
	_backPackLight = ["B_Kitbag_cbr","B_Kitbag_cbr","B_Kitbag_rgr"] select _sideId;
	_helmet	= ["H_HelmetO_ocamo","H_HelmetB_desert","H_HelmetIA"] select _sideId;
	_helmetLight = ["H_Cap_brn_SPECOPS","H_HelmetB_camo","H_MilCap_dgtl"] select _sideId;
	_goggles = ["","",""] select _sideId;

	switch (true) do
	{
		case (_role in ["ftl"]):
		{
			_primaryWeapon = ["arifle_Katiba_GL_F","arifle_TRG21_GL_F","arifle_Mk20_GL_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow"] select _sideId;
			_mags = [11,2];
			_light = false;
			_attach = [["","acc_flashlight","optic_Hamr"],["","acc_flashlight","optic_Hamr"],["","acc_flashlight","optic_Hamr"]] select _sideId;
			_extraAmmo = [["1Rnd_HE_Grenade_shell",10],["1Rnd_SmokeRed_Grenade_shell",2],["1Rnd_SmokeGreen_Grenade_shell",2],["UGL_FlareWhite_F",2]];
			_extraGear = ["ItemGPS"];
			_extraItems = ["MCC_multiTool"];
			_binos = "Rangefinder";
		};

		case (_role in ["mg"]):
		{
			_primaryWeapon = ["LMG_Mk200_F","LMG_Mk200_F","LMG_Mk200_F"] select _sideId;
			_primaryWeaponMag = ["200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box"] select _sideId;
			_primaryWeaponTracer = ["200Rnd_65x39_cased_Box_Tracer","200Rnd_65x39_cased_Box_Tracer","200Rnd_65x39_cased_Box_Tracer"] select _sideId;
			_mags = [3,2];
			_light = true;
			_attach = [["","acc_flashlight","optic_ACO_grn"],["","acc_flashlight","optic_Aco"],["","acc_flashlight","optic_Aco"]] select _sideId;
		};

		case (_role in ["hmg"]):
		{
			_primaryWeapon = ["LMG_Zafir_F","LMG_Zafir_F","LMG_Zafir_F"] select _sideId;
			_primaryWeaponMag = ["150Rnd_762x51_Box","150Rnd_762x51_Box","150Rnd_762x51_Box"] select _sideId;
			_primaryWeaponTracer = ["150Rnd_762x51_Box_Tracer","150Rnd_762x51_Box_Tracer","150Rnd_762x51_Box_Tracer"] select _sideId;
			_mags = [3,2];
			_light = true;
			_attach = [["","acc_flashlight","optic_MRCO"],["","acc_flashlight","optic_MRCO"],["","acc_flashlight","optic_MRCO"]] select _sideId;
		};

		case (_role in ["at","hat","aa","med","eng","crew"]):
		{
			_primaryWeapon = ["arifle_Katiba_C_F","arifle_TRG20_F","arifle_Mk20C_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow"] select _sideId;
			_mags = [10,2];
			_light = false;
			_attach = [["","acc_flashlight","optic_ACO_grn"],["","acc_flashlight","optic_Aco"],["","acc_flashlight","optic_Aco"]] select _sideId;

			switch (_role) do
			{
				case "at":
				{
					_seconderyWeapon = ["launch_RPG32_F","launch_NLAW_F","launch_NLAW_F"] select _sideId;
					_seconderyWeaponMags = [["RPG32_F","RPG32_HE_F"],["NLAW_F","NLAW_F"],["NLAW_F","NLAW_F"]] select _sideId;
				};

				case "hat":
				{
					_seconderyWeapon = ["launch_O_Titan_short_F","launch_B_Titan_short_F","launch_I_Titan_short_F"] select _sideId;
					_seconderyWeaponMags = [["Titan_AT","Titan_AT","Titan_AP"],["Titan_AT","Titan_AT","Titan_AP"],["Titan_AT","Titan_AT","Titan_AP"]] select _sideId;
				};

				case "aa":
				{
					_seconderyWeapon = ["launch_O_Titan_F","launch_B_Titan_F","launch_I_Titan_F"] select _sideId;
					_seconderyWeaponMags = [["Titan_AA","Titan_AA"],["Titan_AA","Titan_AA"],["Titan_AA","Titan_AA"]] select _sideId;
				};

				case "eng":
				{
					_extraAmmo = [["ClaymoreDirectionalMine_Remote_Mag",3],["DemoCharge_Remote_Mag",2],["MineDetector",1]];
				};

				case "med":
				{
					_extraAmmo = [[_medPack,5],[_medKit,1]];
				};

				case "crew":
				{
					_vest = ["V_Rangemaster_belt","V_Rangemaster_belt","V_Rangemaster_belt"] select _sideId;
					_backPackLight = ["","",""] select _sideId;
					_helmet	= ["H_HelmetCrew_O","H_HelmetCrew_B","H_HelmetCrew_I"] select _sideId;
				};
			};
		};

		case (_role in ["rfl","hata","aaa","mga","hmga","mort","morta"]):
		{
			_primaryWeapon = ["arifle_Katiba_F","arifle_TRG21_F","arifle_Mk20_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow"] select _sideId;
			_mags = [10,2];
			_light = false;
			_attach = [["","acc_flashlight","optic_ACO_grn"],["","acc_flashlight","optic_Aco"],["","acc_flashlight","optic_Aco"]] select _sideId;

			//extra ammo
			switch (_role) do
			{
				case "hata":
				{
					_extraAmmo = [[["Titan_AT",2],["Titan_AP",1]],[["Titan_AT",2],["Titan_AP",1]],[["Titan_AT",2],["Titan_AP",1]]] select _sideId;
				};

				case "aaa":
				{
					_extraAmmo = [[["Titan_AA",3]],[["Titan_AA",3]],[["Titan_AA",3]]] select _sideId;
				};

				case "mga":
				{
					_extraAmmo = [[["200Rnd_65x39_cased_Box",3],["200Rnd_65x39_cased_Box_Tracer",1]],[["200Rnd_65x39_cased_Box",3],["200Rnd_65x39_cased_Box_Tracer",1]],[["200Rnd_65x39_cased_Box",3],["200Rnd_65x39_cased_Box_Tracer",1]]] select _sideId;
				};

				case "hmga":
				{
					_extraAmmo = [[["150Rnd_762x51_Box",3],["150Rnd_762x51_Box_Tracer",1]],[["150Rnd_762x51_Box",3],["150Rnd_762x51_Box_Tracer",1]],[["150Rnd_762x51_Box",3],["150Rnd_762x51_Box_Tracer",1]]] select _sideId;
				};

				case "mort":
				{
					_backPackLight = ["O_Mortar_01_support_F","B_Mortar_01_support_F","I_Mortar_01_support_F"] select _sideId;
				};

				case "morta":
				{
					_backPackLight = ["O_Mortar_01_weapon_F","B_Mortar_01_weapon_F","I_Mortar_01_weapon_F"] select _sideId;
				};
			};
		};

		case (_role in ["pilot"]):
		{
			_primaryWeapon = ["SMG_02_F","SMG_01_F","hgun_PDW2000_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_9x21_Mag","30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_9x21_Mag","30Rnd_45ACP_Mag_SMG_01","30Rnd_9x21_Mag"] select _sideId;
			_mags = [6,2];
			_light = false;
			_attach = [["","acc_flashlight","optic_ACO_grn"],["","acc_flashlight","optic_Aco"],["","acc_flashlight","optic_Aco"]] select _sideId;

			_uniform = ["U_O_PilotCoveralls","U_B_PilotCoveralls","U_I_pilotCoveralls"] select _sideId;
			_vest = ["","",""] select _sideId;
			_backPackLight = ["B_Parachute","B_Parachute","B_Parachute"] select _sideId;
			_helmet	= ["H_PilotHelmetHeli_O","H_PilotHelmetHeli_B","H_PilotHelmetHeli_I"] select _sideId;
		};

		case (_role in ["snp"]):
		{
			_primaryWeapon = ["srifle_GM6_camo_F","srifle_LRR_camo_F","srifle_LRR_camo_F"] select _sideId;
			_primaryWeaponMag = ["5Rnd_127x108_Mag","7Rnd_408_Mag","7Rnd_408_Mag"] select _sideId;
			_primaryWeaponTracer = ["5Rnd_127x108_APDS_Mag","7Rnd_408_Mag","7Rnd_408_Mag"] select _sideId;
			_mags = [7,2];
			_light = false;
			_attach = [["","","optic_Nightstalker"],["","","optic_Nightstalker"],["","","optic_Nightstalker"]] select _sideId;
			_uniform = ["U_O_GhillieSuit","U_B_GhillieSuit","U_I_GhillieSuit"] select _sideId;
			_helmet	= ["","",""] select _sideId;
			_extraGear = ["ItemGPS"];
		};

		case (_role in ["spot"]):
		{
			_primaryWeapon = ["arifle_Katiba_F","arifle_TRG21_F","arifle_Mk20_F"] select _sideId;
			_primaryWeaponMag = ["30Rnd_65x39_caseless_green","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"] select _sideId;
			_primaryWeaponTracer = ["30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow"] select _sideId;
			_mags = [11,2];
			_light = false;
			_attach = [["","acc_flashlight","optic_Hamr"],["","acc_flashlight","optic_Hamr"],["","acc_flashlight","optic_Hamr"]] select _sideId;
			_uniform = ["U_O_GhillieSuit","U_B_GhillieSuit","U_I_GhillieSuit"] select _sideId;
			_helmet	= ["","",""] select _sideId;
			_extraGear = ["ItemGPS"];
			_binos = "Rangefinder";
		};
	};
};

//Load up gear
if (_light) then
{
	if (_uniformLight != "") then {_unit forceAddUniform _uniformLight};
	if (_vestLight != "") then {_unit addVest _vestLight};
	if (_backPackLight != "") then {_unit addBackpack _backPackLight};
	if (_helmetLight != "") then {_unit addHeadgear _helmetLight};
}
else
{
	if (_uniform != "") then {_unit forceAddUniform _uniform};
	if (_vest != "") then {_unit addVest _vest};
	if (_backPackLight != "") then {_unit addBackpack _backPackLight};
	if (_helmet != "") then {_unit addHeadgear _helmet};
};
if (_goggles != "") then {_unit addGoggles _goggles};

for "_i" from 1 to 2 do {_unit addItem _medPack};
for "_i" from 1 to 2 do {_unit addmagazine _hGrenade};
for "_i" from 1 to 2 do {_unit addmagazine _hsmokeW};

for "_i" from 1 to (_mags select 0) do {_unit addmagazine _primaryWeaponMag};
for "_i" from 1 to (_mags select 1) do {_unit addmagazine _primaryWeaponTracer};

_unit addWeapon _primaryWeapon;
{if (_x != "") then {_unit addPrimaryWeaponItem _x}} foreach _attach;

//Secondary
if (_seconderyWeapon != "") then
{
	{_unit addmagazine _x} foreach _seconderyWeaponMags;
	_unit addWeapon _seconderyWeapon;
};

//extra ammo
{
	_mag = _x select 0;
	for "_i" from 1 to (_x select 1) do
	{
		switch (true) do
		{
			case (isClass (configFile >> "CfgMagazines" >> _mag)) : {_unit addmagazine _mag};
			case (isClass (configFile >> "CfgWeapons" >> _mag)) : {_unit additem _mag};
			case (isClass (configFile >> "CfgGlasses" >> _mag)) : {_unit additem _mag};
		};
	};
} foreach _extraAmmo;

//Binos
if (_binos != "") then {_unit addWeapon _binos};

//nvg
if ((paramsArray select 1) == 1) then	{_unit linkItem _nvg};

//Gear
{_unit linkItem _x} foreach _extraGear;

//Items
{_unit addItem _x} foreach _extraItems;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

