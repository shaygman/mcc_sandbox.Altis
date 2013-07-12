//==================================================================CP_fnc_setGear======================================================================================
// Sets gear to role
// Example: [roleNumber, gear/uniform/select],_id], "CP_fnc_setGear", true, false] spawn BIS_fnc_MP;
//roleNumber: 0-officer, 1-AR, 2-Rifleman, 3-AT, 4-medic, 5-marksman, 6- specialist, 7- crewman, 8-pilot
// Gear: 0- select, 1-gear, 2-uniform 
//==============================================================================================================================================================================	
private ["_role","_select","_mag","_magazines","_muzzles","_ok"];
_role 	= _this select 0;			
_select	= _this select 1; 
CP_classesIndex = _role;

switch (_role) do
	{
		case 0:	//Officer
		{ 
			//Fets correct weapons Arrays
			if (side player == west) then {
				CP_currentWeaponArray 		= CP_officerWeaponWest;
				CP_currentWeaponSecArray	= CP_officerWeaponSecWest;
				};
			if (side player == east) then {
				CP_currentWeaponArray 		= CP_officerWeaponEast;
				CP_currentWeaponSecArray	= CP_officerWeaponSecEast;
				};
			if (side player == resistance) then {
				CP_currentWeaponArray 		= CP_officerWeaponGuer;
				CP_currentWeaponSecArray	= CP_officerWeaponSecGuer;
				};
			
			//Set playr level
			CP_currentLevel = commanderLevel select 0;
			
			//Set Role
			_role = "Officer"; 
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
	missionNamespace setVariable [format["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player], CP_officerItmes1 select 0];
	CP_currentItems1 = missionNamespace getVariable format ["CP_player%1Items1_%2_%3",_role,getplayerUID player,side player];
	CP_currentItems1Index = 0; 
	};

if (_select == 1) then {			//open weapon menu	
	closeDialog 0;
	_ok = createDialog "CP_WEAPONSPANEL";
 	if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create weapon Dialog failed";}};	
	
if (_select == 2) then {};	//open uniform menu
	
removeAllWeapons player;
removeAllItems player;

//Add weapons for the toon view
if ((CP_currentWeapon select 1) != "") then {player addWeapon (CP_currentWeapon select 1)}; 
if ((CP_currentSecWeapon select 1) != "") then {player addWeapon (CP_currentSecWeapon select 1)};
if ((CP_currentHandguns select 1) != "") then {player addWeapon (CP_currentHandguns select 1)};
if ((CP_currentItems1 select 1) != "") then {player addWeapon (CP_currentItems1 select 1)};
