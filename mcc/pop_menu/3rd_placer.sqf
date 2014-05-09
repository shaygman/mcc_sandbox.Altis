/*
	Based on BIS's coin by: Karel Moricky
	
	Author: Shay_Gman 01/2011

	Description:
		3D placer for MCC Sandbox

	Parameter(s):
		_this slect 0 - the vehicle to spawn.

	Returned value(s):
		position/direction
*/
private ["_logic", "_camera","_logicGrp","_logicASL","_nvgstate","_preview","_pos","_GUIstate"];

MCC_3Dterminate 		= false; 
MCC_3DterminateNoMCC	= false; 
preview3DClass 	= _this select 0;
_pos 			= _this select 1;

if (isnil "MCC_Camera") then {
	createcenter sidelogic;
	_logicGrp = creategroup sidelogic;
	_logicASL = _logicGrp createunit ["Logic",position player,[],0,"none"];
	MCC_Camera = _logicASL;
};

_logic = MCC_Camera;

uinamespace setvariable ["MCC_3D_displayMain",finddisplay 46];

diag_log format ["Log: [3D] %1 executed 3D",player];

//--- Terminate of system is already running
if !(isnil {player getvariable "3D_isRuning"}) exitwith {debuglog "Log: [3D] Camera script is already running"};
player setvariable ["3D_isRuning",0];
DOperator = player;
DOperator setvariable ["MCC_3D_logic",_logic];

//////////////////////////////////////////////////
startLoadingScreen ["3D Placing","RscDisplayLoadMission"];
//////////////////////////////////////////////////
(["MCC_compass"] call BIS_fnc_rscLayer) cutRsc ["MCC_compass", "PLAIN"];

//track Units
MCC_trackMarkerHandler3D = ((uiNamespace getVariable "MCC_compass") displayCtrl 5) ctrladdeventhandler ["draw","_this call MCC_fnc_trackUnits; _this call MCC_fnc_mapDrawWP;"];

if (isnil "MCC_3D_CAM") then {
	//_camera = "camCurator" camcreate [_pos select 0, _pos select 1,((getpos player) select 2) +15];
	_camera = "camconstruct" camcreate [_pos select 0, _pos select 1,((getpos player) select 2) +15];
	_camera cameraeffect ["internal","back"];
	_camera camPrepareFOV 0.900;
	_camera campreparefocus [-1,-1];
	_camera camCommitPrepared 0;
	cameraEffectEnableHUD true;
	_camera setdir direction player;
	[_camera,-30,0] call BIS_fnc_setPitchBank;
	_camera camConstuctionSetParams ([position _logic]+[200000,500]);
};

//_camera camConstructionSetParams [[position player select 0,position player select 1,(position player select 2)+15],5000, 300];
MCC_3D_CAM = _camera;
MCC_3D_CAM_LMB = false;
MCC_3D_CAM_RMB = false;
showcinemaborder false;

MCC3DKeyDown			=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["KeyDown",		"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['keydown',_this,commandingmenu] spawn MCC_3D_CAM_Handler; BIS_temp = nil;}"];
MCC3DKeyUp				=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["KeyUp",		"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['keyup',_this] spawn MCC_3D_CAM_Handler; BIS_temp = nil;}"];
MCC3DMouseButtonDown	=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["MouseButtonDown",	"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['mousedown',_this,commandingmenu] spawn MCC_3D_CAM_Handler; BIS_temp = nil; MCC_3D_CAM_onMouseButtonDown = _this; if (_this select 1 == 1) then {MCC_3D_CAM_RMB = true}; if (_this select 1 == 0) then {MCC_3D_CAM_LMB = true};}"];
MCC3DMouseButtonUp		=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["MouseButtonUp",	"if !(isnil 'MCC_3D_CAM_Handler') then {MCC_3D_CAM_RMB = false; MCC_3D_CAM_LMB = false;}"];
MCC3Dmousemoving		=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["mousemoving",	"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['mousemoving',_this,commandingmenu] spawn MCC_3D_CAM_Handler; BIS_temp = nil;}"];
MCC3Dmouseholding		=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["mouseholding",	"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['mouseholding',_this,commandingmenu] spawn MCC_3D_CAM_Handler; BIS_temp = nil;}"];
MCC3DMouseZChanged		=	(uinamespace getvariable "MCC_3D_displayMain") displayAddEventHandler  ["MouseZChanged",	"if !(isnil 'MCC_3D_CAM_Handler') then {BIS_temp = ['MouseZChanged',_this,commandingmenu] spawn MCC_3D_CAM_Handler; BIS_temp = nil;}"];

MCC_3D_CAM_keys = [];

if (isnil "MCC_3D_CAM_ASL") then {
	createcenter sidelogic;
	_logicGrp = creategroup sidelogic;
	_logicASL = _logicGrp createunit ["Logic",position player,[],0,"none"];
	MCC_3D_CAM_ASL = _logicASL;
};

_logic setvariable ["MCC_3D_menu","#USER:BIS_Coin_categories_0"];

//NV State
_nvgstate = if ( sunOrMoon < 0.5 ) then {2} else {4};
if (_nvgstate == 2) then 
{
	camusenvg true;
	[] spawn { 
				((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "N/V";
				sleep 1.5;
				((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
			};
}
else
{
	[] spawn { 
				((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "Normal";
				sleep 1.5;
				((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
			};
}; 
_logic setvariable ["MCC_3D_nvg",_nvgstate];

_GUIstate = true; 
_logic setvariable ["MCC_3D_GUI",_GUIstate];

//Create the placeholder
MCC_dummyObject =  "Sign_Sphere25cm_F" createvehiclelocal (screentoworld [0.5,0.5]);
MCC_dummyObject addEventHandler ["handleDamage",""];
 
z3DHight = (getpos MCC_dummyObject) select 2;
if (z3DHight < 0) then {z3DHight = 0};

//Create camera marker
MCC_3DeditorMarker = createmarkerLocal ["MCC_3DeditorMarker", [getpos MCC_3D_CAM select 0,getpos MCC_3D_CAM select 1]];
MCC_3DeditorMarker setMarkerTypeLocal "loc_ViewTower";
MCC_3DeditorMarker setMarkerColorLocal "ColorBlue";
MCC_3DeditorMarker setMarkerDirLocal getdir MCC_3D_CAM;
MCC_3DeditorMarker setMarkerSizeLocal [1, 1];

if !(isnil "MCC_3D_CAM_Handler") exitwith {hint "MCC_3D_CAM_Handler is nill";endLoadingScreen};
MCC_3D_CAM_Handler =
	{
	private ["_mode", "_input", "_camera", "_logic", "_terminate", "_keysCancel", "_keysUpObj", "_keysDownObj", "_keysUp", "_keysDown" ,"_keysShift","_key","_keydelete","_offSet","_compassdDir","_compassdPos"
			,"_keysBanned", "_keyNightVision","_finished", "_keyplace","_objectPos","_objectDir","_keyalt","_nearObjects", "_vehicleclass","_html","_ctrlKey","_gain","_keyGUI","_mapScale"];
			
	_mode = _this select 0;
	_input = _this select 1;
	if (! isnil "MCC_3D_CAM") then {_camera = MCC_3D_CAM};
	_logic = DOperator getvariable "MCC_3D_logic";
	_terminate = false;
	if (isnil "_logic") exitwith {};

	_keysCancel		= actionKeys "MenuBack";
	_keysUpObj		= [45];
	_keysDownObj	= [46];
	_keysUp			= actionKeys "nextAction";
	_keysDown		= actionKeys "prevAction";
	_keysShift		= [42];
	_keysBanned		= [1,15];
	_keyNightVision	= actionKeys "NightVision";
	_keyplace 		= [57];
	_keyalt 		= [56];
	_keydelete 		= [211];
	_keyGUI			= [35]; 
		
	//--- Mouse Moving/Holding
	if (_mode in ["mousemoving", "mouseholding"]) then 
	{
		_key = _input select 1;
		if (! isnil "MCC_3D_CAM") then 
		{
			MCC_3D_CAM camsettarget MCC_dummyObject;
			MCC_3D_CAM camcommit 0;
			
			//Compass
			for [{_i = 0;_j = 0},{_i < 360;_j < 4},{_i = _i + 90;_j = _j + 1}] do 
			{
				_x = (0.476 + sin(_i - (getdir MCC_3D_CAM))*(SafeZoneW/8 - SafeZoneW/200));
				_y = (0.42 - cos(_i - (getdir MCC_3D_CAM))*(SafeZoneH/8 - SafeZoneH/200));
				
				((uiNamespace getVariable "MCC_compass") displayCtrl _j) ctrlSetPosition  [_x,_y];
				((uiNamespace getVariable "MCC_compass") displayCtrl _j) ctrlCommit 0;
			};
			
			//Anim Map
			_mapScale = (ctrlMapScale ((uiNamespace getVariable "MCC3D_Dialog") displayCtrl 0));
			if (isnil "_mapScale") then 
			{
				_mapScale = 0.15; uiNamespace setVariable ["MCC3D_DialogMapScale",0.15];
			}
			else
			{
				if (_mapScale > 0) then
					{
						uiNamespace setVariable ["MCC3D_DialogMapScale",  (ctrlMapScale ((uiNamespace getVariable "MCC3D_Dialog") displayCtrl 0))];
					};
			};
			
			_mapScale = uiNamespace getVariable "MCC3D_DialogMapScale";		
			
			((uiNamespace getVariable "MCC_compass") displayCtrl 5)  ctrlMapAnimAdd [0,_mapScale, getpos MCC_3D_CAM];
			ctrlMapAnimCommit ((uiNamespace getVariable "MCC_compass") displayCtrl 5);
			
			MCC_3DeditorMarker setMarkerDirLocal getdir MCC_3D_CAM;
			MCC_3DeditorMarker setMarkerPoslocal [getpos MCC_3D_CAM select 0,getpos MCC_3D_CAM select 1];
		};
		
		if (! isnil "Object3D") then 
		{
			Object3D setpos [getpos MCC_dummyObject select 0, getpos MCC_dummyObject select 1, z3DHight];
			Object3D setpos [getpos MCC_dummyObject select 0, getpos MCC_dummyObject select 1, z3DHight];
			Object3D setdir (getdir MCC_dummyObject);
		};
	};

	//--- Key DOWN
	if (_mode == "keydown") then
		{
		_key = _input select 1;
		
		//--- Terminate 
		if (_key in _keysBanned) then {_terminate = true};
		
		//--- Start NVG
		if (_key in _keyNightVision) then 
		{
			_NVGstate = ((_logic getvariable "MCC_3D_nvg")+1) mod 5;
			_logic setvariable ["MCC_3D_nvg",_NVGstate];
			
			switch (_NVGstate) do	
			{	
				case 0:		//WHOT
					{
						playSound "nvSound";
						true setCamUseTi _NVGstate; 
						[] spawn { 
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "WHOT";
									sleep 3;
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
								};
					};
				
				case 1:		//BHOT
					{
						playSound "nvSound";
						true setCamUseTi _NVGstate; 
						[] spawn { 
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "BHOT";
									sleep 3;
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
								};
					};	
				
				case 2:		//RHOT
					{
						playSound "nvSound";
						true setCamUseTi 7; 
						[] spawn { 
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "THERMAL";
									sleep 3;
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
								};						
					};
					
				case 3:		//NV			
					{ 
						playSound "nvSound";
						false setCamUseTi _NVGstate; 
						camusenvg true;
						[] spawn { 
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "N/V";
									sleep 3;
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
								};
					}; 
					
				case 4:		//Normal			
					{ 
						playSound "nvSound";
						false setCamUseTi _NVGstate; 
						camusenvg false;
						[] spawn { 
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "Normal";
									sleep 1.5;
									((uiNamespace getVariable "MCC_compass") displayCtrl 4) ctrlSettext "";
								};
					};
			};
		};
		
		//--- Hide GUI
		if (_key in _keyGUI) then 
		{
			_GUIstate = !(_logic getvariable "MCC_3D_GUI");
			_logic setvariable ["MCC_3D_GUI",_GUIstate];
			MCC_dummyObject hideObject !(_GUIstate); 
			if (_GUIstate) then
			{
				(["MCC_compass"] call BIS_fnc_rscLayer) cutRsc ["MCC_compass", "PLAIN"];
				MCC_trackMarkerHandler3D = ((uiNamespace getVariable "MCC_compass") displayCtrl 5) ctrladdeventhandler ["draw","_this call MCC_fnc_trackUnits; _this call MCC_fnc_mapDrawWP;"];
			}
			else
			{
				(["MCC_compass"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
				if (!isnil "MCC_trackMarkerHandler3D") then {(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["draw",MCC_trackMarkerHandler3D]};
			};
		};
		
		//Delete object
		if (_key in _keydelete) then 
			{
				if (!isnil "Object3D") then {deletevehicle Object3D};
				_nearObjects = (getpos MCC_dummyObject) nearobjects 5; 
				
				if ((count _nearObjects)>1 && ((_nearObjects select 0) != MCC_dummyObject)) then 
				{
					_nearObjects = [_nearObjects, [], {(getpos MCC_dummyObject) distance _x }, "descend"] call BIS_fnc_sortBy;
					private ["_deletedObj","_index"];
					_deletedObj = (_nearObjects select 0);
					_inArray = false;
					
					{
						if (typeName _x == "ARRAY") then
						{
							if (_deletedObj == _x select 0) exitWith 
							{
								_index = _forEachIndex;
							};
							
						}
						else
						{
							if (_deletedObj == _x) then 
							{
								_index = _forEachIndex;
							}
						}
					} foreach MCC_lastSpawn; 
					
					if (!isnil "_index") then 
					{
						if (typeName (MCC_lastSpawn select _index) == "ARRAY") then
						{
							/*
							mcc_safe = mcc_safe + FORMAT ["
						                                    deleteVehicle ((MCC_lastSpawn select %1) select 0);
							                                {deleteVehicle _x} forEach ((MCC_lastSpawn select %1) select 1);
								                          "
								                          , _index
								                          ];
							*/
							deleteVehicle ((MCC_lastSpawn select _index) select 0);
							{deleteVehicle _x} forEach ((MCC_lastSpawn select _index) select 1);
						}	
						else	
						{
							/*
							mcc_safe = mcc_safe + FORMAT ["
						                                    deleteVehicle (MCC_lastSpawn select %1);
								                          "
								                          , _index
								                          ];
							*/
							deleteVehicle (MCC_lastSpawn select _index);
						};
						
						mcc_safe = mcc_safe + FORMAT ["
						                                    MCC_lastSpawn set [%1, -1];
								                            MCC_lastSpawn = MCC_lastSpawn - [-1];
															publicVariable 'MCC_lastSpawn';
								                      "
								                      , _index
								                      ];
						MCC_lastSpawn set [_index, -1];
						MCC_lastSpawn = MCC_lastSpawn - [-1];
						publicVariable "MCC_lastSpawn";
					}
					else
					{
						deletevehicle _deletedObj;
					}
				}; 
			};
		};
	
	if (_mode == "MouseZChanged") then
		{
		_key = _input select 1;
		_gain = if (MCC_smooth3D) then {0.025} else {0.3};
		//raise
		if (_key < 0) then 
			{
			z3DHight =z3DHight + _gain;
			if (!isnil "Object3D") then {Object3D setpos [getpos Object3D select 0, getpos Object3D select 1,z3DHight]};
			};
		//Lower	
		if (_key > 0) then 
			{
			z3DHight =z3DHight - _gain;
			if (!isnil "Object3D") then {Object3D setpos [getpos Object3D select 0, getpos Object3D select 1,z3DHight]};
			};
		};
		
	//--- Key UP
	if (_mode == "keyup") then 
	{
		_key = _input select 1;
		_ctrlKey = _input select 3;
		if (_key in _keyplace) then 
			{
				_objectPos = [getpos Object3D select 0, getpos Object3D select 1, z3DHight] ;
				_objectDir = getdir Object3D;
				deletevehicle Object3D;
				sleep 0.2; 
				MCC3DgotValue = true; 
				MCC3DValue = [_objectPos,_objectDir];
				hint "Object placed";
				deletevehicle Object3D;

				if (mcc_spawntype == "MINES") then	
					{
						Object3D = createMine [mcc_spawnname,[0,0,500], [], 0];
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];
					}
					else	
					{
						deletevehicle Object3D;
						sleep 0.01;
						Object3D = mcc_spawnname createvehiclelocal [0,0,500];	
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];
					};
			};
		if (_key in _keyalt) then 		//Align
			{
				if (MCC_align3D) then 
				{
					MCC_align3D=false;
					publicVariable "MCC_align3D";
					MCC_align3DText = "Enabled";
				} 
				else
				{
					MCC_align3D=true;
					publicVariable "MCC_align3D";
					MCC_align3DText = "Disabled";
				};
			};

		if (_key in _keysShift) then 			//Smooth
			{
			if (MCC_smooth3D) then {
				MCC_smooth3D=false;
				MCC_smooth3DText = "Disabled";
				} else
					{
					MCC_smooth3D=true;
					MCC_smooth3DText = "Enabled";
					};		
			};
		//open menu
		if (_key in _keysUpObj && !(_ctrlKey)) then 
		{
			if (!dialog) then 
			{
				_ok = createDialog "MCC3D_Dialog";
			}
			else
			{
				closeDialog 0;
			};
		};
		
		//Undo
		if ((_key in _keysUpObj) && _ctrlKey) then 
			{
				_null = [1] execVM MCC_path +"mcc\general_scripts\delete\undo.sqf";
			};
		if (_key in MCC_3D_CAM_keys) then {MCC_3D_CAM_keys = MCC_3D_CAM_keys - [_key]};
		};
	
	//Mouse down
	if (_mode == "mousedown") then 
		{
			_key = _input select 1;
			if ((_key ==1) && ! isnil "Object3D") then {deletevehicle Object3D};
		};

	//--- Deselect or CloseTerminate 
	if (_terminate || MCC_3Dterminate || MCC_3DterminateNoMCC) then 
	{
		MCC_mcc_screen=2;
		//--- Close
		MCC3DRuning = false; 
		if (! isnil "MCC_3D_CAM") then {
			MCC_3D_CAM cameraeffect ["terminate","back"];
			camdestroy MCC_3D_CAM;
			MCC_3D_CAM = nil;
		};		
		if (! isnil "Object3D") then {deletevehicle Object3D};
		if (! isnil "MCC_dummyObject") then {deletevehicle MCC_dummyObject};
		player setvariable ["3D_isRuning",nil];
		hintsilent "";
		waituntil {isnil "MCC_3D_CAM"};
		while {dialog} do {closeDialog 0; sleep 0.1};
		if !(MCC_3DterminateNoMCC) then {_null = [] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf"};
	};

		//--- Camera no longer exists - terminate and start cleanup	
	if (isnil "MCC_3D_CAM" || player != DOperator || !alive player) exitwith
	{
		//////////////////////////////////////////////////
		startLoadingScreen ["MCC 3D","RscDisplayLoadMission"];
		//////////////////////////////////////////////////

		if !(isnil "MCC_3D_CAM") then {MCC_3D_CAM cameraeffect ["terminate","back"];camdestroy MCC_3D_CAM;};
		MCC_3D_CAM = nil;
		MCC_3D_CAM_Handler = nil;
		1122 cuttext ["","plain"];
		_player = DOperator;
		_player setvariable ["MCC_3D_logic",nil];
		DOperator = objnull;
		_preview = _logic getvariable "MCC_3D_preview";
		if !(isnil "_preview") then {deletevehicle _preview};
		//_logic setvariable ["BIS_COIN_mousepos",nil];
		_logic setvariable ["MCC_3D_preview",nil];
		_logic setvariable ["MCC_3D_selected",nil];
		_logic setvariable ["MCC_3D_params",nil];
		_logic setvariable ["BIS_COIN_lastdir",nil];
		_logic setvariable ["MCC_3D_tooltip",nil];
		_logic setvariable ["BIS_COIN_fundsOld",nil];
		_logic setvariable ["MCC_3D_restart",nil];
		_logic setvariable ["MCC_3D_nvg",nil];
		_logic setvariable ["MCC_3D_GUI",nil];
		showcommandingmenu "";
		
		//Remove the event handlers
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["KeyDown",MCC3DKeyDown];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["KeyUp",MCC3DKeyUp];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["MouseButtonDown",MCC3DMouseButtonDown];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["MouseButtonUp",MCC3DMouseButtonUp];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["mousemoving",MCC3Dmousemoving];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["mouseholding",MCC3Dmouseholding];
		(uinamespace getvariable "MCC_3D_displayMain") displayRemoveEventHandler ["MouseZChanged",MCC3DMouseZChanged];
		
		if (!isnil "MCC_trackMarkerHandler3D") then {((uiNamespace getVariable "MCC_compass") displayCtrl 5) ctrlRemoveEventHandler ["draw",MCC_trackMarkerHandler3D]}; 
		if (!isnil "MCC_trackMarkerHandler3DDialog") then {((uiNamespace getVariable "MCC3D_Dialog") displayCtrl 0) ctrlRemoveEventHandler ["draw",MCC_trackMarkerHandler3DDialog]}; 

		missionnamespace setvariable ["BIS_COIN_border",nil];
		
		//Clean 3D placer
		(["MCC_compass"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
		deleteMarkerLocal MCC_3DeditorMarker; 
		
		MCC_mcc_screen=2;
		MCC3DRuning = false; 
		if (! isnil "Object3D") then {deletevehicle Object3D};
		if (! isnil "MCC_dummyObject") then {deletevehicle MCC_dummyObject};
		player setvariable ["3D_isRuning",nil];
		hintsilent "";
		
		debuglog format ["Log: [3D] %1 terminated %2",player,_logic getvariable "BIS_COIN_name"];

		//////////////////////////////////////////////////
		endLoadingScreen;
		//////////////////////////////////////////////////
	};
	_html = "<t color='#818960' size='2' shadow='0' align='left' underline='true'>" + "Controls:" + "</t><br/><br/>";
	_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left' >" + 
			"Tab:        Close Editor" + "<br/>" +
			"X:          Open/Close Menu" + "<br/>" + 
			"Ctrl + X:   Undo last spawn" + "<br/>" +
			"Delete:     Delete object" + "<br/>" +
			"Space:      Place object" + "<br/>" +
			"MouseWheel: Raise\Low object" + "<br/>" +
			"Hold Ctrl:  Rotate object" + "<br/>" +
			"Alt:        Terrain alignment" + "<br/>" +
			"Shift:      Toggle smoothness" + "<br/>" +
			"N:          Toggle vision" + "<br/>" + 
			"H:          Hide/Show GUI" + "<br/>" + "<br/>" + 
			"Double click(map): move camera" + "<br/>" +
			"Alighn to terrain: " + MCC_align3DText + "<br/>" +
			"Smooth placing: " + MCC_smooth3DText + "</t>";
			
	if (_logic getvariable "MCC_3D_GUI") then
	{	
		hintsilent parseText(_html);
	}
	else
	{
		hintsilent ""; 
	};
};
endLoadingScreen;
