#define mcc_playerConsole_IDD 2993

#define MCC_MINIMAP 9120
#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_MAPBACKGROUND 9152
#define MCC_CONSOLEINFOLIVEFEEDNV 9153
#define MCC_CONSOLEINFOLIVEFEEDTM 9154
#define MCC_CONSOLEINFOLIVEFEEDCLOSE 9155
#define MCC_CONSOLEINFOLIVEFEEDNORMAL 9156
#define MCC_CONSOLEINFOUAVCONTROL 9162
#define MCC_ConsoleMapRulerButton 9163
#define MCC_ConsoleMapRulerDir 9164
#define MCC_ConsoleMapRulerDis 9165


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

MCC_consoleLiveFeed = false;

if (_option== 3) exitWith					//Close Live Feed
	{
		ctrlShow [MCC_CONSOLEINFOTEXT,true];
		ctrlShow [MCC_CONSOLEINFOLIVEFEED,true];
		ctrlShow [MCC_CONSOLEINFOUAVCONTROL,true];
		ctrlShow [MCC_MINIMAP,true];
		ctrlShow [MCC_ConsoleMapRulerButton,true];
		ctrlShow [MCC_ConsoleMapRulerDir,true];
		ctrlShow [MCC_ConsoleMapRulerDis,true];

		ctrlShow [MCC_CONSOLEINFOLIVEFEEDNV,false];
		ctrlShow [MCC_CONSOLEINFOLIVEFEEDTM,false];
		ctrlShow [MCC_CONSOLEINFOLIVEFEEDCLOSE,false];
		ctrlShow [MCC_CONSOLEINFOLIVEFEEDNORMAL,false];
		ctrlShow [MCC_CONSOLEINFOUAVCONTROL,false];
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
_mccdialog = findDisplay mcc_playerConsole_IDD;

//Close all controls
ctrlShow [MCC_CONSOLEINFOTEXT,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEED,false];
ctrlShow [MCC_MINIMAP,false];
ctrlShow [MCC_CONSOLEINFOUAVCONTROL,false];
ctrlShow [MCC_ConsoleMapRulerButton,false];
ctrlShow [MCC_ConsoleMapRulerDir,false];
ctrlShow [MCC_ConsoleMapRulerDis,false];

ctrlShow [MCC_CONSOLEINFOLIVEFEEDNV,true];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDTM,true];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDCLOSE,true];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDNORMAL,true];

//Create the target
MCC_consoleLiveFeedTarget = "Sign_Sphere10cm_F" createvehiclelocal [0,0,0];
MCC_consoleLiveFeedTarget hideObjectGlobal true;

// Create fake camera
MCC_consoleLiveFeedCam = "Camera" camCreate [10,10,10];
MCC_consoleLiveFeedCam cameraEffect ["INTERNAL", "BACK", "rendertarget12"];

_leader = leader MCC_ConsoleGroupFocused;
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
ctrlSetText [MCC_MAPBACKGROUND, ""];
_control = _mccdialog displayCtrl MCC_MAPBACKGROUND;
[_control] call MCC_fnc_pipOpen;
ctrlSetText [MCC_MAPBACKGROUND, "#(argb,512,512,1)r2t(rendertarget12,1.0);"];
"rendertarget12" setPiPEffect _effectParams;
ctrlsetFocus _control;

waituntil {!MCC_Console1Open || !dialog};		//CleanUp
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