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
				CP_currentWeaponSecArray	= CP_officerWeaponSecWest;
				CP_currentUniforms 			= CP_officerUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_officerWeaponEast;
				CP_currentWeaponSecArray	= CP_officerWeaponSecEast;
				CP_currentUniforms 			= CP_officerUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_officerWeaponGuer;
				CP_currentWeaponSecArray	= CP_officerWeaponSecGuer;
				CP_currentUniforms 			= CP_officerUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_officerItmes1;
			CP_currentItmes2 	= CP_officerItmes2;
			CP_currentItmes3 	= CP_officerItmes3;
			CP_currentGeneralItmes = CP_officerGeneralItmes;
			
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
				CP_currentWeaponSecArray	= CP_arWeaponSecWest;
				CP_currentUniforms 			= CP_ARUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_ARWeaponEast;
				CP_currentWeaponSecArray	= CP_arWeaponSecEast;
				CP_currentUniforms 			= CP_ARUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_ARWeaponGuer;
				CP_currentWeaponSecArray	= CP_arWeaponSecGuer;
				CP_currentUniforms 			= CP_ARUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_ARItmes1;
			CP_currentItmes2 	= CP_ARItmes2;
			CP_currentItmes3 	= CP_ARItmes3;
			CP_currentGeneralItmes = CP_ARGeneralItmes;
			
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
			CP_currentGeneralItmes = CP_riflemanGeneralItmes;
			
			//Set playr level
			CP_currentLevel = riflemanLevel select 0;
			
			//Set Role
			_role = "Rifleman"; 
		};
		case 3:	//AT
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_ATWeaponWest;
				CP_currentWeaponSecArray	= CP_ATWeaponSecWest;
				CP_currentUniforms 			= CP_ATUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_ATWeaponEast;
				CP_currentWeaponSecArray	= CP_ATWeaponSecEast;
				CP_currentUniforms 			= CP_ATUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_ATWeaponGuer;
				CP_currentWeaponSecArray	= CP_ATWeaponSecGuer;
				CP_currentUniforms 			= CP_ATUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_ATItmes1;
			CP_currentItmes2 	= CP_ATItmes2;
			CP_currentItmes3 	= CP_ATItmes3;
			CP_currentGeneralItmes = CP_ATGeneralItmes;
			
			//Set playr level
			CP_currentLevel = ATLevel select 0;
			
			//Set Role
			_role = "AT"; 
		};
		case 4:	//Corpsman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_corpsmanWeaponWest;
				CP_currentWeaponSecArray	= CP_corpsmanSecWest;
				CP_currentUniforms 			= CP_corpsmanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_corpsmanWeaponEast;
				CP_currentWeaponSecArray	= CP_corpsmanSecEast;
				CP_currentUniforms 			= CP_corpsmanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_corpsmanWeaponGuer;
				CP_currentWeaponSecArray	= CP_corpsmanSecGuer;
				CP_currentUniforms 			= CP_corpsmanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_corpsmanItmes1;
			CP_currentItmes2 	= CP_corpsmanItmes2;
			CP_currentItmes3 	= CP_corpsmanItmes3;
			CP_currentGeneralItmes = CP_corpsmanGeneralItmes;
			
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
				CP_currentWeaponSecArray	= CP_marksmanWeaponsSecWest;
				CP_currentUniforms 			= CP_marksmanUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_marksmanWeaponsEast;
				CP_currentWeaponSecArray	= CP_marksmanWeaponsSecEast;
				CP_currentUniforms 			= CP_marksmanUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_marksmanWeaponsGuer;
				CP_currentWeaponSecArray	= CP_marksmanWeaponsSecGuer;
				CP_currentUniforms 			= CP_marksmanUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_marksmanItmes1;
			CP_currentItmes2 	= CP_marksmanItmes2;
			CP_currentItmes3 	= CP_marksmanItmes3;
			CP_currentGeneralItmes = CP_marksmanGeneralItmes;
			
			//Set playr level
			CP_currentLevel = marksmanLevel select 0;
			
			//Set Role
			_role = "Marksman"; 
		};
		case 6:	//Rifleman
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_specialistWeaponWest;
				CP_currentWeaponSecArray	= CP_specialistWeaponSecWest;
				CP_currentUniforms 			= CP_specialistUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_specialistWeaponEast;
				CP_currentWeaponSecArray	= CP_specialistWeaponSecEast;
				CP_currentUniforms 			= CP_specialistUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_specialistWeaponGuer;
				CP_currentWeaponSecArray	= CP_specialistWeaponSecGuer;
				CP_currentUniforms 			= CP_specialistUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_specialistItmes1;
			CP_currentItmes2 	= CP_specialistItmes2;
			CP_currentItmes3 	= CP_specialistItmes3;
			CP_currentGeneralItmes = CP_specialistGeneralItmes;
			
			//Set playr level
			CP_currentLevel = specialistLevel select 0;
			
			//Set Role
			_role = "Specialist"; 
		};
		case 7:	//Crew
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_crewWeaponWest;
				CP_currentWeaponSecArray	= CP_crewWeaponSecWest;
				CP_currentUniforms 			= CP_crewUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_crewWeaponEast;
				CP_currentWeaponSecArray	= CP_crewWeaponSecEast;
				CP_currentUniforms 			= CP_crewUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_crewWeaponGuer;
				CP_currentWeaponSecArray	= CP_crewWeaponSecGuer;
				CP_currentUniforms 			= CP_crewUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_crewItmes1;
			CP_currentItmes2 	= CP_crewItmes2;
			CP_currentItmes3 	= CP_crewItmes3;
			CP_currentGeneralItmes = CP_crewGeneralItmes;
			
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
				CP_currentWeaponSecArray	= CP_pilotWeaponSecWest;
				CP_currentUniforms 			= CP_pilotUniformsWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_pilotWeaponEast;
				CP_currentWeaponSecArray	= CP_pilotWeaponSecEast;
				CP_currentUniforms 			= CP_pilotUniformsEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_pilotWeaponWest;
				CP_currentWeaponSecArray	= CP_pilotWeaponSecGuer;
				CP_currentUniforms 			= CP_pilotUniformsGuar;
				};
			//set Items array
			CP_currentItmes1 	= CP_pilotItmes1;
			CP_currentItmes2 	= CP_pilotItmes2;
			CP_currentItmes3 	= CP_pilotItmes3;
			CP_currentGeneralItmes = CP_pilotGeneralItmes;
			
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

//Set General Items
CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player];
if (isnil "CP_currentGeneralItems") then 
{														
	missionNamespace setVariable [format["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player], CP_currentGeneralItmes];
	CP_currentGeneralItems = missionNamespace getVariable format ["CP_player%1GeneralItems_%2_%3",_role,getplayerUID player,side player];
	CP_currentGeneralItems = 0; 
};
	
//Set player role
player setvariable ["CP_role", _role, true]; 
player setvariable ["CP_roleLevel", call compile format ["%1Level select 0",_role], true]; 

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

