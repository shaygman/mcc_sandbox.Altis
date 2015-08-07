private ["_string","_logicPos","_logicEmpty","_nearObjects","_target","_nvgstate","_camLogic","_camBuildings","_camLight","_role","_exp","_level","_safePos","_rad"];

if (!MCC_iniDBenabled) exitWIth {systemchat "iniDB isn't running. Can't access role selection"};

// - TO DO  delete corpse and items from it.
//******************************************************************************************************************************
//											Get player levels
//******************************************************************************************************************************
waituntil {alive player};
//Disable weapon disassemble
player removeEventHandler ["WeaponDisassembled",(player getVariable ["MCC_disableStatic",999])];

_eh = player addEventHandler ["WeaponDisassembled",
{
	_this spawn
	{
		_unit = _this select 0;
		_bag1 = _this select 1;
		_bag2 = _this select 2;

		_currBag = unitBackpack _unit;

		titleText ["You are not allowed to disassemble static weapons.", "PLAIN DOWN", 0.5];

		_unit action ["TakeBag", _bag1];

		_time = time;
		waitUntil {unitBackpack _unit == _bag1 || time - _time > 3};

		_unit action ["Assemble", _bag2];

		if (!isNull _currBag) then { _unit action ["TakeBag", _currBag] };
	};
}];

player setVariable ["MCC_disableStatic",_eh];

//Mark it zero again
player addRating (-1 * (rating player));

player setVariable ["cpReady",false,true];

//Get rank from the server
[["MCCplayerRank", player, "N/A", "STRING"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "MCCplayerRank"};
if (CP_debug) then {systemchat format ["player Rank : %1",MCCplayerRank]};

[["officerLevel", player, CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "officerLevel"};
if (CP_debug) then {systemchat format ["officerLevel : %1",officerLevel]};

[["arLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "arLevel"};
if (CP_debug) then {systemchat format ["arLevel : %1",arLevel]};

[["riflemanLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "riflemanLevel"};
if (CP_debug) then {systemchat format ["riflemanLevel : %1",riflemanLevel]};

[["ATLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "ATLevel"};
if (CP_debug) then {systemchat format ["ATLevel : %1",ATLevel]};

[["corpsmanLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "corpsmanLevel"};
if (CP_debug) then {systemchat format ["corpsmanLevel : %1",corpsmanLevel]};

[["marksmanLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "marksmanLevel"};
if (CP_debug) then {systemchat format ["marksmanLevel : %1",marksmanLevel]};

[["specialistLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "specialistLevel"};
if (CP_debug) then {systemchat format ["specialistLevel : %1",specialistLevel]};

[["crewLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "crewLevel"};
if (CP_debug) then {systemchat format ["crewLevel : %1",crewLevel]};

[["pilotLevel", player,CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "pilotLevel"};
if (CP_debug) then {systemchat format ["pilotLevel : %1",pilotLevel]};

//******************************************************************************************************************************
//											Start camera
//******************************************************************************************************************************
playerDeploy = false;

//--- Unit pos
_logicPos = [(random 1000) + 1000,(random 1000) + 1000,(random 1000) + 10000];

_logicEmpty = false;
while {!_logicEmpty} do
{																//Check if can spawn a dummy unit
		_nearObjects = _logicPos nearObjects ["Man",50];
		if ((count _nearObjects) == 0) then {_logicEmpty = true} else {_logicPos = [_logicPos select 0,_logicPos select 1, (_logicPos select 2)-30]};
};

if (CP_debug) then {systemchat format ["position: %1",_logicPos]};
_camLogic = createagent ["Logic",_logicPos,[],0,"none"];
_camLogic setpos _logicPos;
_camLogic setdir 180;
_camBuildings = "Land_u_Addon_01_V1_F" createvehiclelocal _logicPos;
_camBuildings attachto [_camLogic,[3.5,4.5,0]];
_camBuildings setdir (getdir _camLogic);
_camLight = "Land_PortableLight_double_F" createvehiclelocal _logicPos;
_camLight attachto [_camLogic,[1,2,0]];
_camLight setdir 140;
//_camLight setpos [(_logicPos select 0) - 2, (_logicPos select 1) - 3,(_logicPos select 2)];
player attachto [_camLogic,[0,4,0]];

//--- Camera
setviewdistance 3;
CP_gearCamFOV = 0.15;
CP_gearCam = "camera" camcreate position _camLogic;
CP_gearCam cameraeffect ["internal", "BACK", "rendertarget7"];
CP_gearCam campreparefocus [-1,-1];
CP_gearCam camSetFov CP_gearCamFOV;
CP_gearCam camcommitprepared 0;
cameraEffectEnableHUD true;
showcinemaborder false;
player setvariable ["CPCenter", _camLogic];

//handle NV
/*
_nvgstate = if (daytime > 19 || daytime < 5.5) then {[1]} else {[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]};
"rendertarget7" setPiPEffect _nvgstate;
*/
//CP_gearCampos = [[0,0,1.5],12,0] call bis_fnc_relpos;
CP_gearCam attachto [_camLogic,[0.5,12,2.6],""];
player setvariable ["attachObject",_camLogic];
CP_gearCam campreparetarget _camLogic;
CP_gearCam camcommitprepared 0;
CP_gearCam camcommit 0;

player switchmove "AidlPercMstpSlowWrflDnon_G03";
sleep 0.3;

//--------------------------------------------------------------------
//	Spawn player
//--------------------------------------------------------------------
closeDialog 0;
waituntil {!dialog};
sleep 0.1;
_ok = createDialog "CP_RESPAWNPANEL";
if !(_ok) exitWith { hint "createDialog failed"; diag_log  "CP: create respawn Dialog failed";};

waituntil {playerDeploy};
//Spawn point found clearing not needed stuff
detach player;
detach CP_gearCam;
CP_gearCam cameraeffect ["Terminate","back"];

_safePos = [-500,-500,0];
_rad = 10;
while {str _safepos == "[-500,-500,0]"} do {
	_safePos = [(playerDeployPos),_rad,30,1,0,900,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	_rad = _rad + 10;
	sleep 0.1;
};

missionNamespace setvariable ["CP_gainXPFirstTime",true];
player setpos _safePos;

while {isnil "_role"} do {_role = player getvariable "CP_role";};

//If an officer and not leader make him the leader
if ( (tolower _role == "officer" ) && (player != leader player)) then {group player selectLeader player};

//Set Rank
_level 	 = call compile format  ["%1Level select 0",_role];
if (MCCplayerRank == "N/A") then
{
	MCCplayerRank = [(floor (_level/10)) min 6,"classname"] call BIS_fnc_rankParams;
};

player setRank MCCplayerRank;
player switchmove "";

camDestroy CP_gearCam;
deleteVehicle CP_gearCam;
CP_gearCam = nil;

deleteVehicle _camLogic;
deleteVehicle _camBuildings;
deleteVehicle _camLight;
setviewdistance 2500;
closedialog 0;
waituntil {!dialog};
//Respawning

cutText ["Deploying ....","BLACK IN",5];

sleep 2;
player setVariable ["cpReady",true,true];