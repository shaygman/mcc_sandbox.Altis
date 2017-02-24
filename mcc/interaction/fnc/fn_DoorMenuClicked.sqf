//=========================================================MCC_fnc_DoorMenuClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrlData","_object"];
disableSerialization;
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]

_ctrlData	= param [0,"",[""]];
if (_ctrlData == "") exitWith {};

_object = (player getVariable ["interactWith",[]]) select 0;

private ["_door","_animation","_phase","_closed","_tempArray"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

switch (true) do {
	case (_ctrlData == "charge"): {
		closedialog 0;
		enableSentences false;
		player removeMagazine MCC_CHARGE;
		["Placing Charge",4] call MCC_fnc_interactProgress;

		_n = 0;
		_position = ATLtoASL(player modelToworld [0,_n,1.5]);
		while {!lineIntersects [ATLtoASL(player modelToworld [0,0,1]), _position]} do
		{
			_n = _n + 0.1;
			_position = ATLtoASL(player modelToworld [0,_n,1]);
		};
		_position = ATLtoASL(player modelToworld [0,_n-0.15,1]);
		_c4 = "ClaymoreDirectionalMine_Remote_Ammo_Scripted" createVehicle ATLtoASL _position;
		_c4 setpos aslToAtl _position;
		_c4 setdir (getdir player);
		player addAction ["<t color=""#FF0000"">Detonate Charge</t>", {
										player removeAction (_this select 2);
										((_this select 3) select 1) animate [((_this select 3) select 2), ((_this select 3) select 3)];
										((_this select 3) select 1) setVariable [format ["bis_disabled_%1",((_this select 3) select 4)],0,true];
										sleep 0.7;
										((_this select 3) select 0) setDamage 1;
									}, [_c4,_object,_animation,_phase,_door]];
		sleep 1;
		enableSentences true;
	};

	case (_ctrlData == "camera"): {
		private ["_camera","_ppgrain","_ppblair","_keyDown","_tablet"];
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
		while {!(player getVariable ["MCC_mirrorCamOff",false]) && (alive player)} do {
			['<t font="puristaMedium" size="0.5" align="left" color="#a8e748">Use "W" "A" "S" "D" to rotate camera<br/><br/>Press "N" to activate nightvision<br/><br/>Press "Tab" to close video</t><br/>',-0.5,-0.2,0.1,0,0,1] spawn BIS_fnc_dynamicText;
			sleep 0.1;
		};

		deleteVehicle _tablet;
		player removeeventhandler ["animChanged",_eh];
		player removeaction _addIndex;
		player switchMove "AidlPknlMstpSlowWrflDnon_AI";
		(findDisplay 46) displayRemoveEventHandler  ["KeyDown",_keyDown];
		playSound "nvSound";
		/*
		_ppblair = ppEffectCreate ["radialBlur", 100];
		_ppblair ppEffectEnable true;
		_ppblair ppEffectAdjust [02, 0.2, 0.5, 0];
		_ppblair ppEffectCommit 1;
		sleep 1;
		*/
		_camera cameraEffect ["TERMINATE", "BACK"];
		camdestroy _camera;
		_camera = nil;
		/*
		_ppblair ppEffectEnable false;
		ppEffectDestroy _ppblair;


		_ppgrain ppEffectEnable false;
		ppEffectDestroy _ppgrain;
		*/
	};

	case (_ctrlData == "unlock"): {
		closedialog 0;
		["Unlocking",15] call MCC_fnc_interactProgress;
		_object setVariable [format ["bis_disabled_%1",_door],0,true];
	};

	case (_ctrlData == "lock"): {
		closedialog 0;
		["Locking",15] call MCC_fnc_interactProgress;
		_object setVariable [format ["bis_disabled_%1",_door],1,true];
	};

	case (_ctrlData == "check"): {
		_object animate [_animation, 0.1];
		sleep 0.1;
		_object animate [_animation, 0];

		_object setVariable [format ["bis_disabled_%1_info",_door],true];
	};

	case (_ctrlData == "close"): {
		closedialog 0;
	};

	case (_ctrlData == "breachandbang"):
	{
		//Breach & bang
		private ["_grenadesType","_grenade","_grenadePic","_grenadeText","_array"];
		_array = [["closeDialog 0","<t size='1' align='center' color='#ffffff'>Breach N Bang</t>",""]];

		_grenadesType = [];
		{
			_grenade = _x;
			if (count ( format ["'%1' in getArray( _x >> 'magazines' )",_grenade] configClasses ( configFile >> "CfgWeapons" >> "Throw" ) ) > 0 &&
			    !(_grenade in _grenadesType)) then {
				_grenadesType pushBack _grenade;
				_grenadePic = getText(configFile >> "CfgMagazines">> _grenade >> "picture");
				_grenadeText = getText(configFile >> "CfgMagazines">> _grenade >> "displayName");

				_array pushBack [format ["['%1'] spawn MCC_fnc_DoorMenuClicked",_grenade],format ["Breach & Bang (%1)", _grenadeText],_grenadePic];
			};
		} forEach (magazines player);

		[_array,1] call MCC_fnc_interactionsBuildInteractionUI;
	};
	case (_ctrlData in (magazines player)): {
		[player,player,[_ctrlData,_object]] spawn MCC_fnc_interactDoorGrenadeThrow;
	};
};
