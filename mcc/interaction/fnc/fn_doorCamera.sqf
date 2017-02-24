//==================================================================MCC_fnc_doorCamera=========================================================================================
// Mirror under the door
// Example:[_object] spawn MCC_fnc_doorCamera;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
private ["_object","_addIndex","_eh","_camera","_keyDown","_tablet"];
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]

_object = _this select 0;

private ["_door","_animation","_phase","_closed","_tempArray"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

if (_door == "") exitWith {};

closedialog 0;
player setVariable ["MCC_mirrorCamOff",false];

//tablet
_tablet = "Land_Tablet_01_F" createVehicle [0,0,0];
_tablet attachto [player,[-0.1,0.4,-0.2],"neck"];
_tablet setVectorDirAndUp [[0,1,1],[0,-1,0]];
_tablet setObjectTexture [0, "#(argb,512,512,1)r2t(uavrtt,1)"];

//animate - disable input
player playMove "AidlPknlMstpSlowWrflDnon_AI";
sleep 0.5;
player switchmove "acts_CrouchingIdleRifle01";
_addIndex = player addAction ["", {}, "", 0, false, true, "NightVision"];
_eh = player addeventhandler ["animChanged",{player switchMove "acts_CrouchingIdleRifle01";}];
playSound "nvSound";

if (cameraView != "INTERNAL") then {player switchCamera "INTERNAL"};


_camera = "Camera" camcreate (player modelToworld [0,2,0.4]);
_camera setdir (getDir player);
_camera cameraeffect ["internal","back","uavrtt"];
_camera camPrepareFOV 0.900;
_camera campreparefocus [-1,-1];
_camera camCommitPrepared 0;
_camera camcommit 0.01;
cameraEffectEnableHUD true;
showCinemaBorder false;

player setVariable ["MCC_doorCam",_camera];


_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if !(isnil 'MCC_fnc_DOOR_CAM_Handler') then {MCC_temp = ['keydown',_this,commandingmenu] spawn MCC_fnc_DOOR_CAM_Handler; MCC_temp = nil;}"];

//CLose cam
while {!(player getVariable ["MCC_mirrorCamOff",false]) && (alive player)} do
{
	['<t font="puristaMedium" size="0.5" align="left" color="#a8e748">Use "W" "A" "S" "D" to rotate camera<br/><br/>Press "N" to activate nightvision<br/><br/>Press "Tab" to close video</t><br/>',-0.5,-0.2,0.1,0,0,1] spawn BIS_fnc_dynamicText;
	sleep 0.1;
};

deleteVehicle _tablet;
player removeeventhandler ["animChanged",_eh];
player removeaction _addIndex;
player switchMove "AidlPknlMstpSlowWrflDnon_AI";
(findDisplay 46) displayRemoveEventHandler  ["KeyDown",_keyDown];
playSound "nvSound";

_camera cameraEffect ["TERMINATE", "BACK"];
camdestroy _camera;
_camera = nil;