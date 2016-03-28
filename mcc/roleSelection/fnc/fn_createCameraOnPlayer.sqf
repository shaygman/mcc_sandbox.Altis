//==================================================================MCC_fnc_createCameraOnPlayer=================================================================================
// Create a camera object on player
// Example: [_displayVar] call MCC_fnc_createCameraOnPlayer
//==============================================================================================================================================================================
private ["_camLogic","_displayVar"];
_displayVar = [_this, 0, "No display", [""]] call BIS_fnc_param;

_camLogic = vehicle player;

//--- Camera
CP_gearCam = "camera" camcreate (player modelToWorld [0,2.45,1.7]);
CP_gearCam cameraeffect ["internal", "BACK"];
cameraEffectEnableHUD true;
showcinemaborder false;
CP_gearCam camSetFocus [-1,-1];
CP_gearCam camsettarget _camLogic;
CP_gearCam camCommit 0;

_displayVar spawn {
	waitUntil {str (uiNamespace getVariable [_this, 0]) == "No display"};
	detach CP_gearCam;
	CP_gearCam cameraeffect ["Terminate","back"];
	camDestroy CP_gearCam;
	deleteVehicle CP_gearCam;
	CP_gearCam = nil;
};