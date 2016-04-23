//=========================================================MCC_fnc_DoorMenuClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrl","_index","_ctrlData","_object","_animation","_phase","_door"];
disableSerialization;
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]
#define MCC_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

_ctrl 		= _this select 0;
_index 		= _this select 1;
_ctrlData	= _ctrl lbdata _index;

_object = (player getVariable ["interactWith",[]]) select 0;
_door 	= (player getVariable ["interactWith",[]]) select 1;
_phase 	= (player getVariable ["interactWith",[]]) select 2;

if (tolower worldName in MCC_ARMA2MAPS) then {
	_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
	_animation = "dvere"+_str;
} else {
	_animation = _door + "_rot";
};

switch (_ctrlData) do {
	case "charge": {
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

	case "camera": {
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


		_camera = "Camera" camcreate (player modelToworld [0,2,0.3]);
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

	case "unlock": {
		closedialog 0;
		["Unlocking",15] call MCC_fnc_interactProgress;
		_object setVariable [format ["bis_disabled_%1",_door],0,true];
	};

	case "lock": {
		closedialog 0;
		["Locking",15] call MCC_fnc_interactProgress;
		_object setVariable [format ["bis_disabled_%1",_door],1,true];
	};

	case "check": {
		if (tolower worldName in MCC_ARMA2MAPS) then {
			_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
			_animation = "dvere"+_str;
		} else {
			_animation = _door + "_rot";
		};

		_object animate [_animation, 0.1];
		sleep 0.1;
		_object animate [_animation, 0];

		_object setVariable [format ["bis_disabled_%1_info",_door],true];
		hint (if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then {"Unlocked"} else {"Locked"});
		//Refresh dialog - move to funciton
		waitUntil {closeDialog 0; !dialog};
		_array = [["charge",format ["Place Breaching Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")],
			  ["check","Check door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
			  ["camera","Mirror under the door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

		//If door is unlocked change the action to lock
		if (_object getVariable [format ["bis_disabled_%1_info",_door],false]) then {
				if (({_x in items player} count MCC_LOCKPICK)!=0) then {
					if ((_object getVariable [format ["bis_disabled_%1",_door],0])!=0) then
					{
						_array set [1, ["lock","Wedge Door","\A3\ui_f\data\map\groupicons\waypoint.paa"]]
					} else {
						_array set [1, ["unlock","Pick Lock","\A3\ui_f\data\map\groupicons\waypoint.paa"]];
					};
				} else {
						_array set [1, ["nothing",if (((_object getVariable [format ["bis_disabled_%1",_door],0])==0)) then {"Door Unlocked"} else {"Door Locked"},"\A3\ui_f\data\map\groupicons\waypoint.paa"]]
				};
			};


		//Check if we have the tools for the job
		if !(MCC_CHARGE in magazines player) then {_array set [0,-1]};
		if (({_x in items player} count MCC_MIROR)==0) then {_array set [2,-1]};
		_array = _array - [-1];

		if (count _array == 1) exitWith {};
		_ok = createDialog "MCC_INTERACTION_MENU";
		waituntil {dialog};

		_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
		_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
		_ctrl ctrlCommit 0;

		_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

		lbClear _ctrl;
		{
			_class			= _x select 0;
			_displayname 	= _x select 1;
			_pic 			= _x select 2;
			_index 			= _ctrl lbAdd _displayname;
			_ctrl lbSetPicture [_index, _pic];
			_ctrl lbSetData [_index, _class];
		} foreach _array;
		_ctrl lbSetCurSel 0;

		player setVariable ["interactWith",[_object, _door, _phase]];
		_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_DoorMenuClicked"];
		waituntil {!dialog};
		sleep 1;
		player setVariable ["MCC_interactionActive",false];
	};

	case "close": {
		closedialog 0;
	};
};
