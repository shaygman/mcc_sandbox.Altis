private ["_string","_logicPos","_logicEmpty","_nearObjects","_target","_nvgstate"];

//--------------------------------------------------------------------
//		Start the player gear and respawn selection
//--------------------------------------------------------------------

//Black Screen on mission startup
cutText ["","BLACK",0.1];
// - TO DO  delete corpse and items from it.
 
waituntil {alive player};

//--- Unit pos
_logicPos = [1000,1000,10000];

_logicEmpty = false;

while {!_logicEmpty} do {																//Check if can spawn a dummy unit
		_nearObjects = _logicPos nearObjects ["Man",50];
		if ((count _nearObjects) == 0) then {_logicEmpty = true} else {_logicPos = [1000,1000, (_logicPos select 2)+51]};
		sleep 0.1;
	};

CP_camLogic = createagent ["Logic",_logicPos,[],0,"none"];
CP_camLogic setpos _logicPos;
CP_camLogic setdir 180;
CP_camBuildings = "Land_u_Addon_01_V1_F" createvehicle _logicPos; 
CP_camBuildings setpos [(_logicPos select 0) - 1.2, (_logicPos select 1) - 3,(_logicPos select 2) - 0.3]; 
CP_camLight = "FirePlace_burning_F" createvehicle _logicPos; 
CP_camLight attachto [CP_camLogic,[1,2,0]];
//CP_camLight setpos [(_logicPos select 0) - 2, (_logicPos select 1) - 3,(_logicPos select 2)]; 
player attachto [CP_camLogic,[0,4,0]];


//--- Camera
setviewdistance 1;
CP_gearCamFOV = 0.15;
CP_gearCam = "camera" camcreate position CP_camLogic;
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
CP_gearCam attachto [CP_camLogic,[0.5,12,2.6],""];
CP_gearCam campreparetarget CP_camLogic;
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