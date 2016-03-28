/*==================================================================MCC_fnc_inGameUI=====================================================================================
	manage inGameUI
	[0,true,true,trur,true,false,true] call MCC_fnc_inGameUI
	<IN>
	_this select 0 		INTEGER -
							-1 Disabled
							0 force always
							1 allow 3d all vehicles
							2 allow 3d air only

	_this select 1		BOOLEAN
							true - enable HUD compass
							false - disable HUD compass

	_this select 2		BOOLEAN
							true - enable HUD compass show teammates
							false - disable HUD compass show teammates

	_this select 3		BOOLEAN
							true - enable Group Markers on map
							false - disable Group Markers on map

	_this select 4		BOOLEAN
							true - enable Indivdual Markers on map
							false - disable Indivdual Markers on map

	_this select 5		BOOLEAN
							true - enable Name Tags
							false - disable Name Tags

	_this select 6		BOOLEAN
							true - enable suppression
							false - disable suppression

	<<<<<<<<<<<         LOCAL Function     >>>>>>>>>>>>>>>>>>>>>>>>>>>

==============================================================================================================================================================*/
private ["_mode","_compass","_compassTeamMates","_module"];
_mode = param [0,0,[0,objNull]];

//If it's a mod not a call
if (typeName _mode == typeName objNull) then {
	_module = _mode;
	_mode = _module getVariable ["mode",0];
	_compass = _module getVariable ["compass",false];
	_compassTeamMates = _module getVariable ["compassTeamMates",false];

	//Group Markers
	missionNamespace setVariable ["MCC_groupMarkers",_module getvariable ["groupMarkers",true]];

	//Indevidual Markers
	missionNamespace setVariable ["MCC_indevidualMarkers",_module getvariable ["indevidualMarkers",false]];

	//NameTags
	missionNamespace setVariable ["MCC_nameTags",_module getvariable ["nameTags",false]];

	//Supression
	missionNamespace setVariable ["MCC_suppressionOn",_module getvariable ["suppression",false]];
} else {
	_compass = param [1,false,[false]];
	_compassTeamMates = param [2,false,[false]];

	//Group Markers
	missionNamespace setVariable ["MCC_groupMarkers",param [3,false,[false]]];

	//Indevidual Markers
	missionNamespace setVariable ["MCC_indevidualMarkers",param [4,false,[false]]];

	//NameTags
	missionNamespace setVariable ["MCC_nameTags",param [5,false,[false]]];

	//Supression
	missionNamespace setVariable ["MCC_suppressionOn",param [6,false,[false]]];
};

//Compass HUD
if (_compass) then {_compassTeamMates spawn MCC_fnc_initCompassHUD};

//Supression
if (missionNamespace getVariable ["MCC_suppressionOn",false]) then {[] spawn MCC_fnc_supressionInit};

//Force Camera
if (_mode > -1) then {
	[_mode] spawn {
		private ["_mode"];
		_mode = param [0,0,[0,objNull]];

		if (missionNamespace getVariable ["MCC_forceCamera",false]) exitWith {};
		while {true} do {
			missionNamespace setVariable ["MCC_forceCamera",true];
			waitUntil {cameraView == "External"};

			switch (_mode) do {

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
};