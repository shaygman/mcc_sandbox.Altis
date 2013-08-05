//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_select","_mag","_magazines","_muzzles","_ok","_wepItems"];
_role 	= _this select 0;			
_select	= _this select 1; 

if (CP_classesIndex != _role) then {CP_playerUniforms =  nil; CP_weaponAttachments = []};
CP_classesIndex = _role;

switch (_role) do
	{
		case 0:	//Officer
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_officerWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_officerUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_officerWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_officerUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_officerWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_officerUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_officerItmes1;
			CP_currentItmes2 	= CP_officerItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = officerLevel select 0;
			
			//Set Role
			_role = "Officer"; 
		};
		
		case 1:	//AR
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_ARWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_riflemanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_ARWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_riflemanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_ARWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_riflemanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_riflemanItmes1;
			CP_currentItmes2 	= CP_riflemanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = arLevel select 0;
			
			//Set Role
			_role = "AR"; 
		};
		
		case 2:	//Rifleman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_riflemanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_riflemanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_riflemanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_riflemanItmes1;
			CP_currentItmes2 	= CP_riflemanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = riflemanLevel select 0;
			
			//Set Role
			_role = "Rifleman"; 
		};
		case 3:	//AT
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_carabineWeaponWest;
				CP_currentWeaponSecArray	= CP_ATWeaponSecWest;
				CP_currentUniforms 			= CP_riflemanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_carabineWeaponEast;
				CP_currentWeaponSecArray	= CP_ATWeaponSecEast;
				CP_currentUniforms 			= CP_riflemanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_carabineWeaponGuer;
				CP_currentWeaponSecArray	= CP_ATWeaponSecGuer;
				CP_currentUniforms 			= CP_riflemanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_riflemanItmes1;
			CP_currentItmes2 	= CP_riflemanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = ATLevel select 0;
			
			//Set Role
			_role = "AT"; 
		};
		case 4:	//Corpsman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_carabineWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_corpsmanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_carabineWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_corpsmanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_carabineWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_corpsmanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_corpsmanItmes1;
			CP_currentItmes2 	= CP_corpsmanItmes2;
			CP_currentItmes3 	= CP_corpsmanItmes3;
			
			//Set playr level
			CP_currentLevel = corpsmanLevel select 0;
			
			//Set Role
			_role = "Corpsman"; 
		};
		case 5:	//Marksman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_marksmanWeaponsWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_marksmanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_marksmanWeaponsEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_marksmanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_marksmanWeaponsWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_marksmanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_officerItmes1;
			CP_currentItmes2 	= CP_corpsmanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = marksmanLevel select 0;
			
			//Set Role
			_role = "Marksman"; 
		};
		case 6:	//Rifleman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_riflemanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_riflemanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_riflemanWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_riflemanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_specialistItmes1;
			CP_currentItmes2 	= CP_specialistItmes2;
			CP_currentItmes3 	= CP_specialistItmes3;
			
			//Set playr level
			CP_currentLevel = specialistLevel select 0;
			
			//Set Role
			_role = "Specialist"; 
		};
		case 7:	//Crew
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_carabineWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_crewUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_carabineWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_crewUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_carabineWeaponGuer;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_crewUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_riflemanItmes1;
			CP_currentItmes2 	= CP_corpsmanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = crewLevel select 0;
			
			//Set Role
			_role = "Crew"; 
		};
		case 8:	//Pilot
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_pilotWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecWest;
				CP_currentUniforms 			= CP_pilotUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_pilotWeaponEast;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecEast;
				CP_currentUniforms 			= CP_pilotUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_pilotWeaponWest;
				CP_currentWeaponSecArray	= CP_riflemanWeaponSecGuer;
				CP_currentUniforms 			= CP_pilotUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_riflemanItmes1;
			CP_currentItmes2 	= CP_corpsmanItmes2;
			CP_currentItmes3 	= CP_riflemanItmes3;
			
			//Set playr level
			CP_currentLevel = pilotLevel select 0;
			
			//Set Role
			_role = "Pilot"; 
		};
	};
	
//Set Primary weapon
CP_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentWeapon") then {														
	missionNamespace setVariable [format["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponArray select 0];
	CP_currentWeapon = missionNamespace getVariable format ["CP_player%1Weapon_%2_%3",_role,getplayerUID player,side player];
	CP_currentWeaponIndex = 0; 
	};
	
//Set Secondary weapon
CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentSecWeapon") then {														
	missionNamespace setVariable [format["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player], CP_currentWeaponSecArray select 0];
	CP_currentSecWeapon = missionNamespace getVariable format ["CP_player%1SecWeapon_%2_%3",_role,getplayerUID player,side player];
	CP_currentSecWeaponIndex = 0; 
	};
	
//Set handgun
CP_currentHandguns = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentHandguns") then {														
	missionNamespace setVariable [format["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player], CP_handguns select 0];
	CP_currentHandguns = missionNamespace getVariable format ["CP_player%1Handguns_%2_%3",_role,getplayerUID player,side player];
	CP_currentHandgunsIndex = 0; 
	};
	
//Set Items1
CP_currentItems1 = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems1") then {														
	missionNamespace setVariable [format["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player], CP_currentItmes1 select 0];
	CP_currentItems1 = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems1Index = 0; 
	};
	
//Set Items2
CP_currentItems2 = missionNamespace getVariable format ["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems2") then {														
	missionNamespace setVariable [format["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player], CP_currentItmes2 select 0];
	CP_currentItems2 = missionNamespace getVariable format ["CP_player%1Items2_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems2Index = 0; 
	};
	
//Set Items3
CP_currentItems3 = missionNamespace getVariable format ["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentItems3") then {														
	missionNamespace setVariable [format["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player], CP_currentItmes3 select 0];
	CP_currentItems3 = missionNamespace getVariable format ["CP_player%1Items3_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems3Index = 0; 
	};

//Set player role
player setvariable ["CP_role", _role, true]; 

//Open subMenu if needed
if (_select == 1) then {[4] execVM CP_path+"configs\dialogs\switchDialog.sqf"};			//open weapon menu	
if (_select == 2) then {[5] execVM CP_path+"configs\dialogs\switchDialog.sqf"};			//open uniform menu

if (isnil "CP_playerUniforms") then {
	CP_playerUniforms = [	((CP_currentUniforms select 0) select 0) select 1,
							((CP_currentUniforms select 1) select 0) select 1,
							((CP_currentUniforms select 2) select 0) select 1,
							((CP_currentUniforms select 3) select 0) select 1,
							((CP_currentUniforms select 4) select 0) select 1,
							((CP_currentUniforms select 5) select 0) select 1
						];
	};
[CP_classes select CP_classesIndex] call CP_fnc_assignGear;	

