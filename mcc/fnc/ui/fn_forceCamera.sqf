/*==================================================================MCC_fnc_forceCamera=====================================================================================
	force 1st person camera
	[0] call MCC_fnc_forceCamera
	<IN>
	_mode		INTEGER -
						0 force always
						1 allow 3d all vehicles
						2 allow 3d air only
==============================================================================================================================================================*/
private ["_mode"];
_mode = param [0,0,[0,objNull]];

if (typeName _mode == typeName objNull) then {
	_mode = _mode getVariable ["mode",0];
};

_mode spawn {
	while {true} do {
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

