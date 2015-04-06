
#define MCC_MINIMAP 9120
#define MCC_MAPBACKGROUND 22
#define MCC_SQLPDA (uiNamespace getVariable "MCC_SQLPDA")
#define MCC_sqlpdaMenu0 (uiNamespace getVariable "MCC_sqlpdaMenu0")
#define MCC_sqlpdaMenu1 (uiNamespace getVariable "MCC_sqlpdaMenu1")
#define MCC_sqlpdaMenu2 (uiNamespace getVariable "MCC_sqlpdaMenu2")
#define MCC_CONSOLEINFOLIVEFEED (uiNamespace getVariable "MCC_CONSOLEINFOLIVEFEED")
#define MCC_CONSOLEINFOTEXT (uiNamespace getVariable "MCC_CONSOLEINFOTEXT")


private ["_mccdialog","_control","_target","_mempoints","_veh","_option","_effectParams","_leader"];
disableSerialization;

_option = _this select 0;
//Cleanup previos camera
if (!isnil "MCC_consoleLiveFeedCam")  then
{
	if (!isnull MCC_consoleLiveFeedCam) then
	{
		MCC_consoleLiveFeedCam cameraEffect ["TERMINATE", "BACK"];
		detach MCC_consoleLiveFeedCam;
		camDestroy MCC_consoleLiveFeedCam;
		deletevehicle MCC_consoleLiveFeedCam;
		MCC_consoleLiveFeedCam = objnull;
	}
};

if (!isnil "MCC_consoleLiveFeedTarget") then
{
	if (!isnull MCC_consoleLiveFeedTarget) then
	{
		detach MCC_consoleLiveFeedTarget;
		deletevehicle MCC_consoleLiveFeedTarget;
	}
};

if (_option== 3) exitWith					//Close Live Feed
{
	ctrlShow [MCC_MINIMAP,true];
	ctrlShow [25,false];
	ctrlShow [23,true];
	ctrlShow [26,true];
};

switch (_option) do
{
	// Normal
	case 0: {
		_effectParams = [3, 0.1,1, 1, 0, [0,0,0,0], [1.1,0.7,1.1,1.1], [1.0,0.7,1.0,1.1]];
	};

	// Night vision
	case 1: {
		_effectParams = [1];
	};

	// Thermal imaging
	case 2: {
		_effectParams = [2, 1,1, 1, 0, [0,0,0,0], [1.1,0.7,1.1,1.1], [1.0,0.7,1.0,1.1]];
	};
};
_mccdialog = MCC_SQLPDA;

//Close all controls
MCC_CONSOLEINFOTEXT ctrlShow false;
MCC_CONSOLEINFOLIVEFEED ctrlShow false;
MCC_sqlpdaMenu0 ctrlShow false;
MCC_sqlpdaMenu1 ctrlShow false;
MCC_sqlpdaMenu2 ctrlShow false;

ctrlShow [MCC_MINIMAP,false];
ctrlShow [23,false];
ctrlShow [25,true];
ctrlShow [26,false];


//Create the target
MCC_consoleLiveFeedTarget = "Sign_Sphere10cm_F" createvehiclelocal [0,0,0];
MCC_consoleLiveFeedTarget hideObjectGlobal true;

// Create fake camera
MCC_consoleLiveFeedCam = "Camera" camCreate [10,10,10];
MCC_consoleLiveFeedCam cameraEffect ["INTERNAL", "BACK", "rendertarget12"];

_leader = leader (player getVariable ["MCC_PDAselectedGroup",grpNull]);
_veh = vehicle _leader;
if (_veh != _leader) then		//Inside a vehicle
	{
		_mempoints = getArray ( configfile >> "CfgVehicles" >> (typeOf _veh) >> "memoryPointDriverOptics" );
		if (count _mempoints > 0) then
			{
				MCC_consoleLiveFeedCam attachTo [_veh,[0,4,0], _mempoints select 0];
				MCC_consoleLiveFeedTarget attachTo [_veh,[0,10,0], _mempoints select 0];
			}
			else
			{
				MCC_consoleLiveFeedCam attachTo [_veh,[0,0,0.8]];
				MCC_consoleLiveFeedTarget attachTo [_veh,[0,15,0]];
			};
	}
	else
	{
		MCC_consoleLiveFeedCam attachTo [_leader,[-0.18,0.08,0.05],"neck"];
		MCC_consoleLiveFeedTarget attachTo [_leader,[0.5,10,0],"neck"];
	};

MCC_consoleLiveFeedCam camsetTarget MCC_consoleLiveFeedTarget;
MCC_consoleLiveFeedCam camCommit 0;

//PiP effects
_control = _mccdialog displayCtrl MCC_MAPBACKGROUND;
ctrlSetText [MCC_MAPBACKGROUND, ""];

//Sets scale
[_control] call MCC_fnc_pipOpen;
ctrlSetText [MCC_MAPBACKGROUND, "#(argb,512,512,1)r2t(rendertarget12,1.0);"];
"rendertarget12" setPiPEffect _effectParams;
ctrlsetFocus _control;


waituntil {!dialog};		//CleanUp
//Cleanup previos camera
if (!isnil "MCC_consoleLiveFeedCam")  then
{
	if (!isnull MCC_consoleLiveFeedCam) then
		{
			MCC_consoleLiveFeedCam cameraEffect ["TERMINATE", "BACK"];
			detach MCC_consoleLiveFeedCam;
			camDestroy MCC_consoleLiveFeedCam;
			MCC_consoleLiveFeedCam = objnull;
		}
};

if (!isnil "MCC_consoleLiveFeedTarget") then
{
	if (!isnull MCC_consoleLiveFeedTarget) then
	{
		detach MCC_consoleLiveFeedTarget;
		deletevehicle MCC_consoleLiveFeedTarget;
	}
};