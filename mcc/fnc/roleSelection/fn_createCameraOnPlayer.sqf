//==================================================================MCC_fnc_createCameraOnPlayer=================================================================================
// Create a camera object on player
// Example: [_displayVar] call MCC_fnc_createCameraOnPlayer
//==============================================================================================================================================================================
private ["_camLogic","_displayVar"];
_displayVar = [_this, 0, "No display", [""]] call BIS_fnc_param;

//--- Camera
_camLogic = vehicle player;
CP_gearCamFOV = 0.15;
CP_gearCam = "camera" camcreate position _camLogic;
CP_gearCam cameraeffect ["internal", "BACK", "rendertarget7"];
CP_gearCam campreparefocus [-1,-1];
CP_gearCam camSetFov CP_gearCamFOV;
CP_gearCam camcommitprepared 0;
cameraEffectEnableHUD true;
showcinemaborder false;
player setvariable ["CPCenter", _camLogic];

CP_gearCam attachto [_camLogic,[0.5,8,2],""];
player setvariable ["attachObject",_camLogic];
CP_gearCam campreparetarget _camLogic;
CP_gearCam camcommitprepared 0;
CP_gearCam camcommit 0;

_displayVar spawn {
	waitUntil {str (uiNamespace getVariable [_this, 0]) == "No display"};
	detach CP_gearCam;
	CP_gearCam cameraeffect ["Terminate","back"];
	camDestroy CP_gearCam;
	deleteVehicle CP_gearCam;
	CP_gearCam = nil;
};