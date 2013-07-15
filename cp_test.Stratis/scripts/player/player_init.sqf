private ["_string","_logicPos","_logicEmpty","_nearObjects","_target","_nvgstate","_camLogic","_camBuildings","_camLight"];

//--------------------------------------------------------------------
//		Start the player gear and respawn selection
//--------------------------------------------------------------------

//Black Screen on mission startup
cutText ["","BLACK",0.1];
// - TO DO  delete corpse and items from it.
waituntil {alive player};

playerDeploy = false; 
//--- Unit pos
_logicPos = [1000,1000,10000];

_logicEmpty = false;
while {!_logicEmpty} do {																//Check if can spawn a dummy unit
		_nearObjects = _logicPos nearObjects ["Man",50];
		if ((count _nearObjects) == 0) then {_logicEmpty = true} else {_logicPos = [1000,1000, (_logicPos select 2)-51]};
		sleep 0.5;
	};

_camLogic = createagent ["Logic",_logicPos,[],0,"none"];
_camLogic setpos _logicPos;
_camLogic setdir 180;
_camBuildings = "Land_u_Addon_01_V1_F" createvehicle _logicPos; 
_camBuildings attachto [_camLogic,[3.5,4.5,0]];
_camBuildings setdir (getdir _camLogic);
_camLight = "FirePlace_burning_F" createvehicle _logicPos; 
_camLight attachto [_camLogic,[1,2,0]];
//_camLight setpos [(_logicPos select 0) - 2, (_logicPos select 1) - 3,(_logicPos select 2)]; 
player attachto [_camLogic,[0,4,0]];


//--- Camera
setviewdistance 1;
CP_gearCamFOV = 0.15;
CP_gearCam = "camera" camcreate position _camLogic;
CP_gearCam cameraeffect ["internal", "BACK", "rendertarget10"];
CP_gearCam campreparefocus [-1,-1];
CP_gearCam camSetFov CP_gearCamFOV;
CP_gearCam camcommitprepared 0;
cameraEffectEnableHUD true;
showcinemaborder false;

//handle NV
_nvgstate = if (daytime > 19 || daytime < 5.5) then {[1]} else {[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]};
"rendertarget10" setPiPEffect _nvgstate;

//CP_gearCampos = [[0,0,1.5],12,0] call bis_fnc_relpos;
CP_gearCam attachto [_camLogic,[0.5,12,2.6],""];
player setvariable ["attachObject",_camLogic];
CP_gearCam campreparetarget _camLogic;
CP_gearCam camcommitprepared 0;
CP_gearCam camcommit 0;

player switchmove "AidlPercMstpSlowWrflDnon_G03";
sleep 0.3;

//endloadingscreen;

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

camDestroy CP_gearCam;
deleteVehicle CP_gearCam;
deleteVehicle _camLogic; 
deleteVehicle _camBuildings; 
deleteVehicle _camLight;
setviewdistance 2500;
closedialog 0; 
waituntil {!dialog};
//Respawning
cutText ["Deploying ....","BLACK IN",5];