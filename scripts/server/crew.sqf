//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Crew
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_crewWeaponWest = ["SERVER_Crew", "primary", "CP_crewWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponWest == 0) then
{		
	CP_crewWeaponWest 	= call compileFinal str	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]	
						   ]; 
	["SERVER_Crew", "primary", "CP_crewWeaponWest",CP_crewWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Crew", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_Crew", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_crewWeaponWest;




//East
CP_crewWeaponEast = ["SERVER_Crew", "primary", "CP_crewWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponEast == 0) then
{							   
	CP_crewWeaponEast 	= call compileFinal str 	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]
							]; 
	["SERVER_Crew", "primary", "CP_crewWeaponEast",CP_crewWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Crew", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_Crew", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_crewWeaponEast;



//GUER
CP_crewWeaponGuer = ["SERVER_Crew", "primary", "CP_crewWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponGuer == 0) then
{
	CP_crewWeaponGuer 	= call compileFinal str	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]
							];
	["SERVER_Crew", "primary", "CP_crewWeaponGuer",CP_crewWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_Crew", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_Crew", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_crewWeaponGuer;


//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_crewWeaponSecWest = ["SERVER_Crew", "secondery", "CP_crewWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponSecWest == 0) then
{				   		   
	CP_crewWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_Crew", "secondery", "CP_crewWeaponSecWest",CP_crewWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponSecWest";

//East
CP_crewWeaponSecEast = ["SERVER_Crew", "secondery", "CP_crewWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponSecEast == 0) then
{
	CP_crewWeaponSecEast 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_Crew", "secondery", "CP_crewWeaponSecEast",CP_crewWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponSecEast";

//Guer
CP_crewWeaponSecGuer = ["SERVER_Crew", "secondery", "CP_crewWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_crewWeaponSecGuer == 0) then
{
	CP_crewWeaponSecGuer 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_Crew", "secondery", "CP_crewWeaponSecGuer",CP_crewWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewWeaponSecGuer";

//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_crewItmes1 = ["SERVER_Crew", "items", "CP_crewItmes1", "ARRAY"] call iniDB_read;
if (count CP_crewItmes1 == 0) then
{
	CP_crewItmes1		= call compileFinal str	[
									[0,"", []],
									[10,"Binocular", []],
									[20,"Rangefinder", []]
									];

	["SERVER_Crew", "items", "CP_crewItmes1",CP_crewItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_crewItmes1"; 


CP_crewItmes2 = ["SERVER_Crew", "items", "CP_crewItmes2", "ARRAY"] call iniDB_read;
if (count CP_crewItmes2 == 0) then
{
	CP_crewItmes2		= call compileFinal str	[
									[0,"",0]
									];

	["SERVER_Crew", "items", "CP_crewItmes2",CP_crewItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_crewItmes2"; 

CP_crewItmes3 = ["SERVER_Crew", "items", "CP_crewItmes3", "ARRAY"] call iniDB_read;
if (count CP_crewItmes3 == 0) then
{
	CP_crewItmes3		= call compileFinal str	[
									[3,"SmokeShell",0],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_Crew", "items", "CP_crewItmes3",CP_crewItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_crewItmes3"; 


CP_crewGeneralItmes = ["SERVER_Crew", "items", "CP_crewGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_crewGeneralItmes == 0) then
{
	CP_crewGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"SmokeShell",2],
									[0,"FirstAidKit",2]
									];

	["SERVER_Crew", "items", "CP_crewGeneralItmes",CP_crewGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_crewGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_crewUniformsWest = ["SERVER_Crew", "gear", "CP_crewUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_crewUniformsWest == 0) then
{
	CP_crewUniformsWest	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_B"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_CombatUniform_mcam"]]	//Uniforms
									];
	["SERVER_Crew", "gear", "CP_crewUniformsWest",CP_crewUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_crewUniformsWest";

CP_crewUniformsEast = ["SERVER_Crew", "gear", "CP_crewUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_crewUniformsEast == 0) then
{								
	CP_crewUniformsEast	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_O"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_CombatUniform_ocamo"]]	//Uniforms
									];
	["SERVER_Crew", "gear", "CP_crewUniformsEast",CP_crewUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewUniformsEast";

CP_crewUniformsGuar = ["SERVER_Crew", "gear", "CP_crewUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_crewUniformsGuar == 0) then
{	
	CP_crewUniformsGuar	= call compileFinal str	[
										[[0,""],[10,"NVGoggles"]],		//NV
										[[0,"H_HelmetCrew_I"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform"]]	//Uniforms
									];
	["SERVER_Crew", "gear", "CP_crewUniformsGuar",CP_crewUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_crewUniformsGuar";