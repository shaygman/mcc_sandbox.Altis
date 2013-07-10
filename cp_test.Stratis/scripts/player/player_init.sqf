private ["_string","_logicPos","_logicEmpty","_nearObjects","_target"];

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

player attachto [CP_camLogic,[0,0,0]];

//--- Camera
setviewdistance 1;

CP_gearCam = "camera" camcreate position CP_camLogic;
CP_gearCam cameraeffect ["internal","back"];
CP_gearCam campreparefocus [-1,-1];
CP_gearCam camSetFov 0.2;
CP_gearCam camcommitprepared 0;
cameraEffectEnableHUD true;
showcinemaborder false;

CP_gearCampos = [[0,0,1.5],12,0] call bis_fnc_relpos;
CP_gearCam attachto [player,CP_gearCampos,""];
CP_gearCam campreparetarget player;
CP_gearCam camcommitprepared 0;

player switchmove "AidlPercMstpSlowWrflDnon_G03";
sleep 0.3;

//endloadingscreen;

closeDialog 0;
waituntil {!dialog};
sleep 0.1;
_ok = createDialog "CP_RESPAWNPANEL";
if !(_ok) exitWith { hint "createDialog failed"; diag_log  "CP: create respawn Dialog failed";};