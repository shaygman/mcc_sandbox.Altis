//==================================================================MCC_fnc_interactDoor===============================================================================================
// Interaction with Door type
// Example: [_object] spawn MCC_fnc_interactMan; 
//=================================================================================================================================================================================
private ["_object","_door","_optionalDoors","_suspectCorage","_typeOfSelected","_animation","_phase","_doorTypes","_isHouse","_loadName","_waitTime","_array"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool"]

disableSerialization;
_object 	= _this select 0;
_isHouse 	= _object isKindof "house";

_waitTime = 1; 
if (_isHouse) then
{
	_doorTypes	= ["door", "hatch"];
	_loadName	= "GEOM";
}
else
{
	_doorTypes	= ["door", "ramps"];
	_loadName	= "FIRE"; 
};

_optionalDoors = [_object, _loadName] intersect [asltoatl (eyepos player),(player modelToworld [0, 3, 0])];
_door = "";
{
	_typeOfSelected = _x select 0;
	{
		if ([_x,_typeOfSelected] call BIS_fnc_inString) exitWith {_door = _typeOfSelected};
	} foreach _doorTypes;
	
} forEach _optionalDoors;

if (_isHouse) then
{
	if (_door == "") exitWith {};
	_animation = _door + "_rot";
	_phase = if ((_object animationPhase _animation) > 0) then {0} else {1};
	
	//Check if locked
	if (((_object getVariable [format ["bis_disabled_%1",_door],0])==1) && !MCC_interactionKey_holding) exitWith 
	{
		_object animate [_animation, 0.1];
		sleep 0.1;
		_object animate [_animation, 0];
	};
	
	//Open dialog
	if (MCC_interactionKey_holding && _phase != 0 && !dialog) exitWith
	{
		MCC_DOOR_CAM_Handler =
		{
			private ["_keyNightVision","_keysBanned","_keyForward","_keyBack","_keyLeft","_keyRight","_mode","_input","_NVGstate","_camTarget","_pos","_relDir"];
			_keyNightVision	= actionKeys "NightVision";
			_keysBanned		= [1,15];
			_keyForward		= actionKeys "CarForward";
			_keyBack		= actionKeys "CarBack";
			_keyLeft		= actionKeys "CarLeft";
			_keyRight		= actionKeys "CarRight";
			_mode 	= _this select 0;
			_input 	= _this select 1;
			_cam 	= player getVariable ["MCC_doorCam",objNull];
			_camTarget = _cam getVariable ["MCC_DOORCAM_TARGET",[0,2,0]];
			
			if (isnil "_cam") then {player setVariable ["MCC_mirrorCamOff",true]};
			
			if (_mode == "keydown") then
			{
				_key = _input select 1;
				
				//--- Terminate 
				if (_key in _keysBanned) then {player setVariable ["MCC_mirrorCamOff",true]};
				
				//--- Start NVG
				if (_key in _keyNightVision) then 
				{
					playSound "nvSound";
					_NVGstate = !(player getVariable ["MCC_DOORCAM_NVSTATE", false]);
					camusenvg _NVGstate;
					player setVariable ["MCC_DOORCAM_NVSTATE", _NVGstate];
				};
				
				//--- UP
				if (_key in _keyForward) then 
				{
					_camTarget set [2,(_camTarget select 2)+0.03];
					_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
					_pos = _cam modelToWorld _camTarget;
					if (((_pos select 2) - ((getpos _cam) select 2)) < 1.5) then
					{
						_cam camSetTarget _pos;
					};
				};
				
				//--- Down
				if (_key in _keyBack) then 
				{
					_camTarget set [2,(_camTarget select 2)-0.03];
					_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
					_pos = _cam modelToWorld _camTarget;
					if (((_pos select 2) - ((getpos _cam) select 2)) > -1.5) then
					{
						_cam camSetTarget _pos;
					}
				};
				
				//--- Left
				if (_key in _keyLeft) then 
				{
					_camTarget set [0,(_camTarget select 0)-0.03];
					_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
					_pos = _cam modelToWorld _camTarget;
					_relDir = [player,_pos] call BIS_fnc_relativeDirTo;
					if ( _relDir > 325 || _relDir < 35) then
					{
						_cam camSetTarget _pos;
					};
				};
				
				//--- Right
				if (_key in _keyRight) then 
				{
					_camTarget set [0,(_camTarget select 0)+0.03];
					_cam setVariable ["MCC_DOORCAM_TARGET",_camTarget];
					_pos = _cam modelToWorld _camTarget;
					_relDir = [player,_pos] call BIS_fnc_relativeDirTo;
					if ( _relDir > 325 || _relDir < 35) then
					{
						_cam camSetTarget _pos;
					};
				};
				
				 _cam camCommit 0;
			};
			
		};
		MCC_fnc_DoorMenuClicked = 
		{
			private ["_ctrl","_index","_ctrlData","_object","_animation","_phase","_door"];
			disableSerialization;

			_ctrl 		= _this select 0;
			_index 		= _this select 1;
			_ctrlData	= _ctrl lbdata _index;
			
			_object = (player getVariable ["interactWith",[]]) select 0;
			_door 	= (player getVariable ["interactWith",[]]) select 1;
			_phase 	= (player getVariable ["interactWith",[]]) select 2;
			
			_animation = _door + "_rot";
			switch (_ctrlData) do
			{	
				case "charge":		
				{
					closedialog 0;
					player removeMagazine MCC_CHARGE;
					["Placing Charge",4] call MCC_fnc_interactProgress; 

					_n = 2; 
					_position = ATLtoASL(player modelToworld [0,_n,1.5]);
					while {!lineIntersects [ATLtoASL(player modelToworld [0,0,1]), _position]} do
					{
						_n = _n - 0.1;
						_position = ATLtoASL(player modelToworld [0,_n,1]);
					};	
					_position = ATLtoASL(player modelToworld [0,_n-0.9,1]);
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
				};
				
				case "camera":		
				{
					closedialog 0;
					player setVariable ["MCC_mirrorCamOff",false];
					player playMove "AidlPknlMstpSlowWrflDnon_AI";
					playSound "nvSound";
					
					private ["_camera","_ppgrain","_ppblair","_keyDown"];
					_camera = "Camera" camcreate (player modelToworld [0,2,0.2]);
					_camera setdir (getDir player);
					_camera cameraeffect ["internal","back"];
					_camera camPrepareFOV 0.900;
					_camera campreparefocus [-1,-1];
					_camera camCommitPrepared 0;
					_camera camcommit 0.01;
					cameraEffectEnableHUD true;
					showCinemaBorder false;
					
					_ppgrain = ppEffectCreate ["filmGrain", 2005];
					_ppgrain ppEffectAdjust [1, 1, 8, 0.6, 0.6,false];
					_ppgrain ppEffectCommit 0;
					_ppgrain ppEffectEnable true;
					
					_ppblair = ppEffectCreate ["radialBlur", 100];
					_ppblair ppEffectEnable true;
					_ppblair ppEffectAdjust [02, 0.2, 1, 0.5];
					_ppblair ppEffectCommit 1;
					sleep 1; 
					_ppblair ppEffectEnable false;
					ppEffectDestroy _ppblair;
					
					player setVariable ["MCC_doorCam",_camera];
					
					
					_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if !(isnil 'MCC_DOOR_CAM_Handler') then {MCC_temp = ['keydown',_this,commandingmenu] spawn MCC_DOOR_CAM_Handler; MCC_temp = nil;}"];
					
					//CLose cam
					waituntil {(player getVariable ["MCC_mirrorCamOff",false]) || !(alive player)};
					(findDisplay 46) displayRemoveEventHandler  ["KeyDown",_keyDown];
					playSound "nvSound";
					_ppblair = ppEffectCreate ["radialBlur", 100];
					_ppblair ppEffectEnable true;
					_ppblair ppEffectAdjust [02, 0.2, 0.5, 0];
					_ppblair ppEffectCommit 1;
					sleep 1;
					
					_camera cameraEffect ["TERMINATE", "BACK"];
					camdestroy _camera;
					_camera = nil; 
					
					_ppblair ppEffectEnable false;
					ppEffectDestroy _ppblair;
					
					
					_ppgrain ppEffectEnable false;
					ppEffectDestroy _ppgrain;
				};
				
				case "unlock":		
				{
					closedialog 0;
					["Unlocking",15] call MCC_fnc_interactProgress; 
					_object setVariable [format ["bis_disabled_%1",_door],0,true];
					
				};
				
				case "lock":		
				{
					closedialog 0;
					["Locking",15] call MCC_fnc_interactProgress; 
					_object setVariable [format ["bis_disabled_%1",_door],1,true];
					
				};
				case "close":		
				{
					closedialog 0;
				};
			};
		};

		
		_array = [["charge",format ["Place Breaching Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")],
		          ["camera","Mirror under the door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
				  ["unlock","Pick Lock","\A3\ui_f\data\map\groupicons\waypoint.paa"],
				  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];
				  
		//If door is unlocked change the action to lock 
		if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then
		{
			_array set [2, ["lock","Lock Door","\A3\ui_f\data\map\groupicons\waypoint.paa"]]
		};
		
		//Check if we have the tools for the job
		if !(MCC_CHARGE in magazines player) then {_array set [0,-1]};
		if (({_x in items player} count MCC_MIROR)==0) then {_array set [1,-1]};
		if (({_x in items player} count MCC_LOCKPICK)==0) then {_array set [2,-1]};
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
		sleep _waitTime; 
		player setVariable ["MCC_interactionActive",false];  
	};
	
	_object animate [_animation, _phase];
	sleep _waitTime; 
	player setVariable ["MCC_interactionActive",false];  
}
else
{
	if (player distance _object > 7) exitWith {}; 
	MCC_fnc_vehicleMenuClicked = 
	{
		private ["_ctrl","_index","_ctrlData","_object","_animation","_phase","_door"];
		disableSerialization;

		_ctrl 		= _this select 0;
		_index 		= _this select 1;
		_ctrlData	= _ctrl lbdata _index;
		_object		= player getVariable ["interactWith",objNull];
		
		closeDialog 0;
		if (_ctrlData == "gear") then 
		{
			player action ["Gear", _object];
		}
		else
		{
			if ((_object emptyPositions _ctrlData)>0) then 
			{
				closeDialog 0;
				player action [format ["getIn%1",_ctrlData], _object];
			}; 
		};
	};
	//Open dialog
	if (MCC_interactionKey_holding && ((side _object == civilian || (side _object getFriend side player)>0.6)) && !dialog) exitWith
	{
		_array = [];
		{
			if ((_object emptyPositions _x)>0) then {_array set [count _array, [_x,format ["Board %1 as %2",getText (configfile >> "CfgVehicles" >> typeof _object >> "displayName"),if (_object isKindof "air" && _x == "driver") then {"pilot"} else {_x}],format ["\A3\ui_f\data\igui\cfg\actions\getin%1_ca.paa",_x]]]};
		} foreach ["commander","driver","gunner","cargo"]; 
		_array set [count _array,["gear","Open inventory",format ["%1data\IconAmmo.paa",MCC_path]]];
		_array set [count _array,["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

		if (count _array == 1) exitWith {}; 
		_ok = createDialog "MCC_INTERACTION_MENU";
		waituntil {dialog};

		_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
		_ctrl ctrlSetPosition [0.4,0.4,0.2 * safezoneW, 0.025* count _array* safezoneH];	
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
		
		player setVariable ["interactWith",_object];
		_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_vehicleMenuClicked"];
		waituntil {!dialog};
		sleep _waitTime; 
		player setVariable ["MCC_interactionActive",false];  
	};
	
	if (_door == "") exitWith {};
	_phase = if ((_object doorPhase _door) > 0) then {0} else {1};
	_object animateDoor [_door, _phase, false];
};
