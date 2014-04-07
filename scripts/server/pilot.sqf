//---------------------------------------------------------------------------------------------------------------------------------------------------------
//											Pilot
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------Primary----------------------------------------------------------------

//West 
CP_pilotWeaponWest = ["SERVER_PILOT", "primary", "CP_pilotWeaponWest", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponWest == 0) then
{		
	CP_pilotWeaponWest 	= call compileFinal str	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]		
						   ]; 
	["SERVER_PILOT", "primary", "CP_pilotWeaponWest",CP_pilotWeaponWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponWest";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_PILOT", "primary_attachments_west", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_PILOT", "primary_attachments_west", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_pilotWeaponWest;




//East
CP_pilotWeaponEast = ["SERVER_PILOT", "primary", "CP_pilotWeaponEast", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponEast == 0) then
{							   
	CP_pilotWeaponEast 	= call compileFinal str 	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]						
							]; 
	["SERVER_PILOT", "primary", "CP_pilotWeaponEast",CP_pilotWeaponEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponEast";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_PILOT", "primary_attachments_east", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_PILOT", "primary_attachments_east", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_pilotWeaponEast;



//GUER
CP_pilotWeaponGuer = ["SERVER_PILOT", "primary", "CP_pilotWeaponGuer", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponGuer == 0) then
{
	CP_pilotWeaponGuer 	= call compileFinal str	[
							[0,"hgun_PDW2000_F",["30Rnd_9x21_Mag",6]],
							[5,"SMG_01_F",["30Rnd_45ACP_Mag_SMG_01",6]],
							[10,"SMG_02_F",["30Rnd_9x21_Mag",6]]	
							];
	["SERVER_PILOT", "primary", "CP_pilotWeaponGuer",CP_pilotWeaponGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponGuer";

{
	_weapon = _x select 1;
	if (!isnil "_weapon") then
	{
		_weaponAttachments = ["SERVER_PILOT", "primary_attachments_guer", format ["CP_%1",_weapon] , "ARRAY"] call iniDB_read; 
		if (count _weaponAttachments == 0) then
		{
			_weaponAttachments	=	call compileFinal str[
									[[0,""],[5,"optic_Aco_smg"],[10,"optic_Holosight_smg"]], //optics
									[[0,""]], //Barrel
									[[0,""]]	//Attach
									];
			["SERVER_PILOT", "primary_attachments_guer", format ["CP_%1",_weapon], _weaponAttachments, "ARRAY"] call iniDB_write;
		};
		 missionNamespace setvariable [format ["CP_%1",_weapon], _weaponAttachments];
		 publicvariable format ["CP_%1",_weapon];
	};
} foreach CP_pilotWeaponGuer;


//----------------------------------------------------Secondery----------------------------------------------------------------	
//west
CP_pilotWeaponSecWest = ["SERVER_PILOT", "secondery", "CP_pilotWeaponSecWest", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponSecWest == 0) then
{				   		   
	CP_pilotWeaponSecWest 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_PILOT", "secondery", "CP_pilotWeaponSecWest",CP_pilotWeaponSecWest, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponSecWest";

//East
CP_pilotWeaponSecEast = ["SERVER_PILOT", "secondery", "CP_pilotWeaponSecEast", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponSecEast == 0) then
{
	CP_pilotWeaponSecEast 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_PILOT", "secondery", "CP_pilotWeaponSecEast",CP_pilotWeaponSecEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponSecEast";

//Guer
CP_pilotWeaponSecGuer = ["SERVER_PILOT", "secondery", "CP_pilotWeaponSecGuer", "ARRAY"] call iniDB_read;
if (count CP_pilotWeaponSecGuer == 0) then
{
	CP_pilotWeaponSecGuer 	= call compileFinal str	[[0,"",["",0]]];
	["SERVER_PILOT", "secondery", "CP_pilotWeaponSecGuer",CP_pilotWeaponSecGuer, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotWeaponSecGuer";

//------------------------------------------------------------------------------Items---------------------------------------------------------------------------	
CP_pilotItmes1 = ["SERVER_PILOT", "items", "CP_pilotItmes1", "ARRAY"] call iniDB_read;
if (count CP_pilotItmes1 == 0) then
{
	CP_pilotItmes1		= call compileFinal str	[
									[0,"", []]
									];

	["SERVER_PILOT", "items", "CP_pilotItmes1",CP_pilotItmes1, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_pilotItmes1"; 


CP_pilotItmes2 = ["SERVER_PILOT", "items", "CP_pilotItmes2", "ARRAY"] call iniDB_read;
if (count CP_pilotItmes2 == 0) then
{
	CP_pilotItmes2		= call compileFinal str	[
									[0,"",0]
									];

	["SERVER_PILOT", "items", "CP_pilotItmes2",CP_pilotItmes2, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_pilotItmes2"; 

CP_pilotItmes3 = ["SERVER_PILOT", "items", "CP_pilotItmes3", "ARRAY"] call iniDB_read;
if (count CP_pilotItmes3 == 0) then
{
	CP_pilotItmes3		= call compileFinal str	[
									[3,"SmokeShell",0],
									[5,"HandGrenade",2],
									[7,"SmokeShellRed",2],
									[9,"SmokeShellGreen",2],
									[11,"Chemlight_green",4],
									[11,"Chemlight_red",4],
									[11,"Chemlight_yellow",4],
									[15,"B_IR_Grenade",2]];

	["SERVER_PILOT", "items", "CP_pilotItmes3",CP_pilotItmes3, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_pilotItmes3"; 


CP_pilotGeneralItmes = ["SERVER_PILOT", "items", "CP_pilotGeneralItmes", "ARRAY"] call iniDB_read;
if (count CP_pilotGeneralItmes == 0) then
{
	CP_pilotGeneralItmes		= call compileFinal str	[
									[0,"ItemMap",1],
									[0,"ItemCompass",1],
									[0,"ItemWatch",1],
									[0,"ItemRadio",1],
									[0,"FirstAidKit",2]
									];

	["SERVER_PILOT", "items", "CP_pilotGeneralItmes",CP_pilotGeneralItmes, "ARRAY"] call iniDB_write;
}; 
publicvariable "CP_pilotGeneralItmes"; 
//------------------------------------------------------------------------------Gear---------------------------------------------------------------------------

CP_pilotUniformsWest = ["SERVER_PILOT", "gear", "CP_pilotUniformsWest", "ARRAY"] call iniDB_read;
if (count CP_pilotUniformsWest == 0) then
{
	CP_pilotUniformsWest	= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_PilotHelmetHeli_B"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_B_HeliPilotCoveralls"],[10,"U_B_PilotCoveralls"]]	//Uniforms
									];
	["SERVER_PILOT", "gear", "CP_pilotUniformsWest",CP_pilotUniformsWest, "ARRAY"] call iniDB_write;	
};
publicvariable "CP_pilotUniformsWest";

CP_pilotUniformsEast = ["SERVER_PILOT", "gear", "CP_pilotUniformsEast", "ARRAY"] call iniDB_read;
if (count CP_pilotUniformsEast == 0) then
{								
	CP_pilotUniformsEast	= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_PilotHelmetHeli_O"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_BandollierB_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_O_PilotCoveralls"]]	//Uniforms
									];
	["SERVER_PILOT", "gear", "CP_pilotUniformsEast",CP_pilotUniformsEast, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotUniformsEast";

CP_pilotUniformsGuar = ["SERVER_PILOT", "gear", "CP_pilotUniformsGuar", "ARRAY"] call iniDB_read;
if (count CP_pilotUniformsGuar == 0) then
{	
	CP_pilotUniformsGuar	= call compileFinal str	[
										[[0,""],[5,"NVGoggles"]],		//NV
										[[0,"H_CrewHelmetHeli_I"]],	//Head
										[[0,""],[0,"G_Combat"],[5,"G_Tactical_Black"],[10,"G_Sport_Blackred"],[15,"G_B_Diving"]],	//Goggles
										[[0,"V_TacVest_khk"]],	//Vest
										[[0,""]],	//Backpack
										[[0,"U_I_CombatUniform"],[10,"U_I_pilotCoveralls"]]	//Uniforms
									];
	["SERVER_PILOT", "gear", "CP_pilotUniformsGuar",CP_pilotUniformsGuar, "ARRAY"] call iniDB_write;
};
publicvariable "CP_pilotUniformsGuar";