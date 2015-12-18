/*==================================================================MCC_fnc_inGameUI=====================================================================================
	manage inGameUI
	[0,true,true] call MCC_fnc_inGameUI
	<IN>
	_this select 0 		INTEGER -
							0 force always
							1 allow 3d all vehicles
							2 allow 3d air only

	_this select 1		BOOLEAN
							true - enable HUD compass
							false - disable HUD compass

	_this select 2		BOOLEAN
							true - enable HUD compass show teammates
							false - disable HUD compass show teammates

==============================================================================================================================================================*/
private ["_mode","_compass","_compassTeamMates","_module"];
_mode = param [0,0,[0,objNull]];

//If it's a mod not a call
if (typeName _mode == typeName objNull) then {
	_module = _mode;
	_mode = _module getVariable ["mode",0];
	_compass = _module getVariable ["compass",false];
	_compassTeamMates = _module getVariable ["compassTeamMates",false];
} else {
	_compass = param [1,false,[false]];
	_compassTeamMates = param [2,false,[false]];
};

[_mode,_compass,_compassTeamMates] spawn {
	private ["_mode","_compass","_compassTeamMates"];
	_mode = param [0,0,[0,objNull]];
	_compass = param [1,false,[false]];
	_compassTeamMates = param [2,false,[false]];

	//Compass HUD
	if (_compass) then {_compassTeamMates spawn MCC_fnc_initCompassHUD};

	if (missionNamespace getVariable ["MCC_forceCamera",false]) exitWith {};
	while {true} do {
		missionNamespace setVariable ["MCC_forceCamera",true];
		waitUntil {cameraView == "External"};

		switch (_this) do {

			//Always
		    case 0: {
		    	player switchCamera "Internal";
		    };

		    //vehicles
		    case 1: {
		    	if (vehicle player == player || player != driver vehicle player) then {player switchCamera "Internal"};
		    };

		    default {
		     	if (vehicle player == player || !(vehicle player isKindOf "air") || player != driver vehicle player) then {player switchCamera "Internal"};
		    };
		};

		sleep 0.1;
	};
};

