private ["_string","_logicPos","_logicEmpty","_nearObjects","_target","_nvgstate","_camLogic","_camBuildings","_camLight","_role","_exp","_level","_teleportAtStart","_starLoc"];

// - TO DO  delete corpse and items from it.
//******************************************************************************************************************************
//											Get player levels
//******************************************************************************************************************************

waituntil {alive player};
cutText ["","BLACK IN",5];
player setVariable ["cpReady",false,true];

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

//Get rank from the server
[["MCCplayerRank", player, "N/A", "STRING"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "MCCplayerRank"};
if (MCC_debug) then {systemchat format ["player Rank : %1",MCCplayerRank]};

_availableRoles = [];
_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" )) then {(missionconfigFile >> "MCC_loadouts")} else {(configFile >> "MCC_loadouts")};

//Let's build the control buttons
for "_i" from 0 to (count _cfg -1) do {
	_cfgName = format ["%1Level", configName (_cfg select _i)];
	[[_cfgName, player, CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
	waituntil {! isnil _cfgName};
	if (MCC_debug) then {systemchat format ["%2 : %1",missionNamespace getVariable [_cfgName,-1],_cfgName]};
};

/*
{
	[[_x, player, CP_defaultLevel, "ARRAY"], "MCC_fnc_getVariable", false, false] spawn BIS_fnc_MP;
	waituntil {! isnil _x};
	if (MCC_debug) then {systemchat format ["%2 : %1",missionNamespace getVariable [_x,-1],_x]};
} forEach ["officerLevel",
           "arLevel",
           "atLevel",
           "riflemanLevel",
           "corpsmanLevel",
           "marksmanLevel",
           "specialistLevel",
           "crewLevel",
           "pilotLevel"
          ];
*/
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

if (missionNamespace getVariable ["MCC_debug",false]) then {systemchat format ["position: %1",_logicPos]};

_camLogic = createagent ["Logic",_logicPos,[],0,"none"];
_camLogic setpos _logicPos;
_camLogic setdir 180;
player attachto [_camLogic,[-2,4,-0.3]];
player setvariable ["CPCenter", _camLogic];

//--- Camera
setviewdistance 3;
CP_gearCam = "camera" camcreate (player modelToWorld [0,2.45,1.7]);
CP_gearCam cameraeffect ["internal", "BACK"];
cameraEffectEnableHUD true;
showcinemaborder false;
CP_gearCam camSetFocus [-1,-1];
CP_gearCam camsettarget _camLogic;
CP_gearCam camCommit 0;


//handle NV
if (daytime > 19 || daytime < 5.5) then {camUseNVG true};


player switchmove "AidlPercMstpSlowWrflDnon_G03";

//Make sure players will have their default kit once respawn - but not before they choosed a kit
[(player getvariable ["CP_role","rifleman"]),0] call MCC_fnc_setGear;

sleep 0.3;

//--------------------------------------------------------------------
//	Spawn player
//--------------------------------------------------------------------
closeDialog 0;
waituntil {!dialog};
sleep 0.1;
_ok = createDialog "CP_RESPAWNPANEL";
if !(_ok) exitWith { hint "createDialog failed"; diag_log  "CP: create respawn Dialog failed";};

waituntil {missionNameSpace getvariable ["playerDeploy",false]};


//Spawn point found clearing not needed stuff
detach player;

detach CP_gearCam;
CP_gearCam cameraeffect ["Terminate","back"];

while {isnil "_role"} do {_role = player getvariable "CP_role";sleep 0.1;};

//If an officer and not leader make him the leader
if ( (tolower _role == "officer" ) && (player != leader player)) then {group player selectLeader player};

//Set Rank
_level 	 = call compile format  ["%1Level select 0",_role];

if (MCCplayerRank == "N/A") then {
	MCCplayerRank = [(floor (_level/10)) min 6,"classname"] call BIS_fnc_rankParams;
};

player setRank MCCplayerRank;
player switchmove "";

camDestroy CP_gearCam;
deleteVehicle CP_gearCam;
CP_gearCam = nil;

deleteVehicle _camLogic;
setviewdistance 2500;
closedialog 0;
waituntil {!dialog};
//Respawning

cutText ["Deploying ....","BLACK IN",5];
camUseNVG false;
sleep 2;
player setVariable ["cpReady",true,true];