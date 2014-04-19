private ["_target", "_killer", "_seagull", "_markers", "_KEGsNextRun", "_name", "_setOriginalSide", "_OriginalSide", "_RatingDelta",
		"_ehVehicles", "_t", "_disp", "_cCamera", "_cTarget", "_cName", "_cCamerasBG", "_cTargetsBG", "_cMap", "_cMapFull", "_cDebug",
		"_pos", "_foo", "_nNoDialog", "_lastUpdateMarkers", "_lastUpdateMarkerTypes", "_lastUpdateTags", "_allUnits", "_allVehicles",
		"_newUnits", "_newVehicles", "_fh", "_kh", "_waitUnits", "_m", "_s", "_rate", "_doMarkerTypes", "_mapFull", "_mappos", 
		"_markedVehicles", "_i", "_u", "_type", "_icon", "_map", "_tt", "_bpos", "_bird", "_KEGs_EH_Indx", "_KEGs_EHF_Indx","_nextTarget"];

//
// Spectating Script for ArmA 3
// by Kegetys 
// updated for ArmA3 by Ollem
//

disableSerialization;

if ( ( count _this ) > 0 ) then { _target = _this select 0; };

VM_scriptName="specta";
VM_SpectatorCamerasEnabled = False;

f_var_debugMode = 0;

cutText ["Initializing Spectator Script...","BLACK IN", 2];

// Globals etc.
vm_count = 0; //Debug loop counter
debugX = [];
NORRN_noMarkersUpdates = false; //Added for no marker update - NORRN

VM_CurrentCameraView = "";
KEG_Spect_Init = false;
KEGs_tgtSelLast = 0; 
KEGsEHlist = [];
KEGsEHFlist = [];

//set focus to killer else player
if ( !(isNil "_target") && { ( alive _target ) } ) then 
{
	//diag_log format ["Target: %1", _target];
	KEGs_target = _target;
}
else
{
	//diag_log format ["No Killer: %1", player];
	//if ( (isNil "KEGs_target") || { !(alive KEGs_target) } ) then { KEGs_target = player; };
	if ( isNil "KEGs_target" ) then { KEGs_target = player; };
};

KEGs_targetName = "unknown";
if ( alive KEGs_target ) then { KEGs_targetName = name KEGs_target };

KEGs_autoTarget = KEGs_target;
KEGs_autoTargetOrg = KEGs_autoTarget;
_nextTarget = time;

KEGsMouseButtons = [false, false];
KEGsMouseScroll = 0;
KEGsMouseCoord = [0.5, 0.5];
KEGsUseNVG = false;
//KEGsMissileCamActive = false;
//KEGsUseMissileCam = false;
KEGsMarkerNames = false; // True = display marker names and arrows
KEGsMarkerType = 1; // 0 = disabled, 1 = names, 2 = types
KEGsTags = false; // Particlesource tags
KEGsTagsStat = false; // Particlesource status tags
KEGsAIfilter = false; // Filter AI units (only players displayed)
KEGsDeadFilter = false; // Filter Unknown Dead units (only Alive players displayed)
KEGsCombatActionFilter = false; // automatically set camera focus on shooter
//KEGsClientAddonPresent = false; // Is client-side addon present?
KEGsMarkerSize = 1.0; // Full map marker size
KEGsMinimapZoom = 0.5; // Minimap zoom
KEGsSelect = 0; // Offset Used to change selected target
KEGsCurrentSelectIdx = 0; // Current Index of the selected target
KEGs1stGunner = false; // Gunner view on 1st person camera?
//KEGsDroppedCamera = false; // Free camera dropped (non-targeted with free motion)?
//KEGsCamForward = false;
//KEGsCamBack = false;
//KEGsCamLeft = false;
//KEGsCamRight = false;
//KEGsCamUp = false;
//KEGsCamDown = false;
KEGsNeedUpdateLB = false;
mouseDeltaX = 0;
mouseDeltaY = 0;
sdistance = 5; // camera distance
fangle  = 0; // Free camera angle
fangleY = 15;
//KEGs_flybydst = 35; // Distance of flyby camera (adjusted based on target speed)
szoom = 0.976;
_markers = []; // Map markers showing positions of all units
KEGsTagSources = []; // Particle sources for tags
KEGsTagStatSources = []; // Particle sources for status tags
KEGs_lastTgt = 0;
_KEGs_dir = 0;
KEGs_nameCache = [];
//_name = "Unknown";
CheckNewUnitsReady = true;
RefreshListReady = true;

KEGsOrgViewDistance = viewDistance;
KEGsTempViewDistance = (2 * KEGsOrgViewDistance) min 10000 max 4000;
setViewDistance KEGsTempViewDistance;

KEGs_camera_vision = 0;
KEGscam_free_pitch = -45;

KEGs_ALT_PRESS = false;
KEGs_CTRL_PRESS = false;

CameraLoop_count = 0;

spectate_events = compile preprocessFileLineNumbers format ["%1spectator\specta_events.sqf",MCC_path];
RefreshPlayerList = compile preprocessFileLineNumbers format ["%1spectator\RefreshPlayerList.sqf",MCC_path];
FreeLookMovementHandler = compile preprocessFileLineNumbers format ["%1spectator\FreeLookMovementHandler.sqf",MCC_path];
CameraMenuHandler = compile preprocessFileLineNumbers format ["%1spectator\CameraMenuHandler.sqf",MCC_path];
PlayerMenuHandler = compile preprocessFileLineNumbers format ["%1spectator\PlayerMenuHandler.sqf",MCC_path];
KEGsShowCombatMode = compile preprocessFileLineNumbers format ["%1spectator\specta_combatmode.sqf",MCC_path];
KEGsShowUnitLocator = compile preprocessFileLineNumbers format ["%1spectator\specta_locator.sqf",MCC_path];

// Unit sides shown - Show all if sides not set
if(isNil "KEGsShownSides") then {
	KEGsShownSides = [west, east, resistance, civilian];
};

// In an effort to compensate for Renegades (players with ratings of less than -2000) we will add this Renegage fix
//Renegade Fix add function _setOriginalSide - ViperMaul 
VM_CheckOriginalSide =  
{
	private ["_unit", "_OriginalSide", "_RatingDelta"];

	_unit = _this;
	
	_OriginalSide = _unit getVariable ["KEG_OriginalSide",  sideLogic];	
	
	if ( _OriginalSide == sideLogic ) then
	{
		_RatingDelta = abs(Rating _unit);
		_unit addRating _RatingDelta; 
		_unit setVariable ["KEG_OriginalSide",(side _unit)];
		_unit addRating -(_RatingDelta);
	};
	_OriginalSide = _unit getVariable ["KEG_OriginalSide", civilian];
	
	_OriginalSide
};

deathCam = [];

// Create dialog & assign keyboard handler
createDialog "KEGsRscSpectate";
_disp = (findDisplay 55001);
_disp displaySetEventHandler["KeyDown", "[""KeyDown"",_this] call spectate_events"];
_disp displaySetEventHandler["KeyUp", "[""KeyUp"",_this] call spectate_events"];

// hide menus by default
["ToggleCameraMenu",0] call spectate_events;
["ToggleTargetMenu",0] call spectate_events;
["ToggleHelp",0] call spectate_events;
["ToggleMap",0] call spectate_events;

// IDC's from rsc
_cCamera = 55002;
_cTarget = 55003;
_cName = 55004;
KEGs_cLBCameras = 55005;
KEGs_cLBTargets = 55006;
_cCamerasBG = 55007;
_cTargetsBG = 55008;
_cMap = 55013;
_cMapFull = 55014;
_cDebug = 55100;

// "Beginning, hide map and minimap";
ctrlShow[_cMap, false];

_pos = [(KEGs_target modelToWorld [0,0,0] select 0)-1+random 2, (KEGs_target modelToWorld [0,0,0] select 1)-1+random 2, 2];
_targetPos = [(KEGs_target modelToWorld [0,0,0] select 0), (KEGs_target modelToWorld [0,0,0] select 1), 1];

KEGscam_target = "camera" camCreate _targetPos; // "Dummy" target camera for smooth transitions
KEGscam_chase = "camera" camCreate _targetPos;
KEGscam_lockon = "camera" camCreate _targetPos;
KEGscam_1stperson = "camera" camCreate _targetPos;
KEGscam_free = "camera" camCreate (KEGs_target modelToWorld [0,-25,25]);
KEGscam_free setDir (getDir KEGs_target);
[KEGscam_free,KEGscam_free_pitch,0] call bis_fnc_setpitchbank;

KEGscam_lockon camSetTarget KEGscam_target;
KEGscam_chase camSetTarget KEGscam_target;

//KEGscam_target switchCamera "INTERNAL";
//KEGscam_target cameraEffect["INTERNAL", "BACK"];
//KEGscam_target camsettarget KEGs_target;
//KEGscam_target camsetrelpos[0,-0.1,0.20]

//--- Create Cam Marker
KEGS_camMarker = createMarkerLocal ["KEGS_camMarker", getPos KEGscam_free];
KEGS_camMarker setMarkerTypeLocal "mil_start";
KEGS_camMarker setMarkerColorLocal "colorpink";
KEGS_camMarker setMarkerSizeLocal [.75,.75];

//KEGscam_flyby = "camera" camCreate _pos;
//KEGscam_topdown = "camera" camCreate _pos;
//KEGscam_1stperson = "camera" camCreate _pos; // Dummy camera
//KEGscam_missile = "camera" camCreate _pos; // Missile camera
KEGscam_fullmap = "camera" camCreate _pos; // Full map view camera
//KEGs_cameras = [KEGscam_lockon, KEGscam_chase, KEGscam_free,KEGscam_1stperson];
//KEGs_cameraNames = ["Lock-on", "Chase", "Free", "1st-Person"];
KEGs_cameras = [KEGscam_lockon, KEGscam_chase, KEGscam_1stperson, KEGscam_free];
KEGs_cameraNames = ["Lock-on", "Chase", "1st-Person", "Free"];

// Add cameras to listbox
lbClear KEGs_cLBCameras;
{ lbAdd[KEGs_cLBCameras, _x] } forEach KEGs_cameraNames;

// Add separator & toggles
KEGs_cLbSeparator = lbAdd[KEGs_cLBCameras, "---"];
lbSetColor[KEGs_cLBCameras, KEGs_cLbSeparator, [0.5, 0.5, 0.5, 0.5]];
//KEGs_cLbMissileCam = lbAdd[KEGs_cLBCameras, "Missile camera"];
//KEGs_cLbToggleNVG = lbAdd[KEGs_cLBCameras, "Night vision"];
KEGs_cLbToggleTags = lbAdd[KEGs_cLBCameras, "Unit tags"];
KEGs_cLbToggleTagsStat = lbAdd[KEGs_cLBCameras, "Combat status tags"];
KEGs_cLbToggleAiFilter = lbAdd[KEGs_cLBCameras, "Filter AI"];
KEGs_cLbToggleDeadFilter = lbAdd[KEGs_cLBCameras, "Filter Unknown/Dead"];
KEGs_cLbToggleCombatActionFilter = lbAdd[KEGs_cLBCameras, "Combat Action Focus"];

KEGs_tgtIdx = 0;
KEGs_cameraIdx = 0;
showCinemaBorder false;
lbClear KEGs_cLBTargets;
onMapSingleClick "[""MapClick"",_pos] call spectate_events";

// Spawn thread to display help reminder after a few seconds
[] spawn {sleep(3);if(dialog) then {cutText["\n\n\n\n\nPress F1 for help","PLAIN DOWN", 0.75]}};

KEGs_camSelLast = 0;
mouseLastX = 0.5;
mouseLastY = 0.5;
_nNoDialog = 0;
lastCheckNewUnits = -100;
_lastUpdateMarkers = -100;
_lastUpdateMarkerTypes = -100;
_lastUpdateTags = -100;
KEGs_lastAutoUpdateLB = time;
KEGsCamPos = [0,0,0];
//KEGs_cxpos = 0;
//KEGs_cypos = 0;
//KEGs_czpos = 0;
KEGs_cspeedx = 0;
KEGs_cspeedy = 0;
KEGs_tbase = 0.1;

// Initialize the arrays and the listboxes.
	CheckNewUnits = 
		{
			private["_vm_CheckNewUnitsNumber"];
			CheckNewUnitsReady = false;
			RefreshListReady = false;
			_vm_CheckNewUnitsNumber = vm_count;
			_allUnits = allUnits;
			_allVehicles = Vehicles;
			
			// Avoid game logic
	
			_newUnits = _allUnits - deathCam;	
			
			if (count _allVehicles > 0) then {
				// Add event handlers to new vehicles
				_ehVehicles = _allVehicles;
				{
					// Add fired eventhandler for map indication
					_nn = _x getVariable "KEGsEHfired";
					if (isNil "_nn") then {
						_fh = _x addeventhandler["fired", { KEGs_autoTarget = gunner (_this select 0); }];
						_x setVariable["KEGsEHfired", _fh];
					};
				} count _allVehicles;
			};			
			
			if(count _newUnits > 0) then 
			{
				_waitUnits = [];
				{
					if !( _x getVariable ["KEG_SPECT", false] ) then
					{
						// If variable not found, set it, thus unit is tagged for next update cycle
						// This way, (re)spawned units have some time to fully initialize. Name arma.rpt Error fix.
						_x setVariable ["KEG_SPECT", true];
						_waitUnits set [(count _waitUnits ),_x]; // _waitUnits = _waitUnits + [_x];
					};
					
					// In an effort to compensate for Renegades (players with ratings of less than -2000) we will add this Renegage fix
					//Renegade Fix - ViperMaul
					_x call VM_CheckOriginalSide;
					
					if ( (typeOf _x) in ["Logic","SideBLUFOR_F","SideOPFOR_F","SideResistance_F"] ) then 
					{
						_newUnits = _newUnits - [_x];
					};
					
				} forEach _newUnits;
				
				_newUnits = _newUnits - _waitUnits;			

				// Add new units to end of list
				deathCam = deathCam + _newUnits;
				
				// Request listbox update
				KEGsNeedUpdateLB = true;
				
				// Create markers
				{
					if ( isNil "_markers" ) then { diag_log format ["spectator script: '_markers' error for unit [%1]", _x]; };
					
					// Create marker
					_m = createMarkerLocal[format["KEGsMarker%1", count _markers], (player modelToWorld [0,0,0]) ];
					_m setMarkerTypeLocal "mil_dot";			
					_m setMarkerSizeLocal[0.4, 0.4];
					_markers set [(count _markers),_m];
					
					_OriginalSide = _x call VM_CheckOriginalSide;  
					
					// Set marker color
					if(_OriginalSide == west) then {_m setMarkerColorLocal "ColorBlue";};
					if(_OriginalSide == east) then {_m setMarkerColorLocal "ColorRed";};
					if(_OriginalSide == resistance) then {_m setMarkerColorLocal "ColorGreen";};
					if(_OriginalSide == civilian) then {_m setMarkerColorLocal "ColorWhite";};			
					
					_KEGs_EHF_Indx = _x addEventHandler["fired", { KEGs_autoTarget = _this select 0 } ];
					KEGsEHFlist set [(count KEGsEHFlist), [_x, _KEGs_EHF_Indx]];
					
				} forEach _newUnits;
			};
			
			RefreshListReady = true;
			CheckNewUnitsReady = true;	
			lastCheckNewUnits = time;
		};  // End of Spawn CheckNewUnits
		  

KEGs_fnc_MovementCameraLoop = 
	{
		private ["_bb", "_nextTarget", "_foo", "_name", "_targetSpeed", "_KEGs_targetPos", "_actionCam", "_checkTarget", "_hstr", "_d", "_z", "_cMapFull", "_camMove", "_comSpeed", "_coef", "_zCoef", "_camPos", "_dX", "_dY", "_dZ", "_dir", "_pos"  ];
		_cMapFull = 55014;
		_CameraLoop_count = 0;
		CameraLoop_count = 0;
		
		_nextTarget = time;		
		
		While { VM_SpectatorCamerasEnabled  } do 
		{			
			_actionCam = false;
			
			if ( 
					KEGsCombatActionFilter && 
					{ (time > _nextTarget) } && 
					{ !(KEGs_autoTarget == KEGs_target) } && 
					{ (alive KEGs_autoTarget) } &&
					{ ( !KEGsAIfilter || isPlayer KEGs_AutoTarget ) }
				) then 
			{
				//diag_log format ["%1 - switch to new auto target: %2 (old target: %3)", time, name KEGs_autoTarget, name KEGs_target];
				KEGs_target = KEGs_AutoTarget;
				_nextTarget = time + (random 10 max 4 min 6);
				// set camera focus name lower left corner
				[false] spawn PlayerMenuHandler;
				_actionCam = true;
				
				if((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) then 
				{
					[] spawn CameraMenuHandler;
				};
			};
	
			//while { sleep 0.05; ( ( !(isPlayer KEGs_target) || ((isPlayer KEGs_target) && { (alive KEGs_target) } )) && { KEGsNextRun } ); } do  
			if ( !(isNull KEGs_target) && { (alive KEGs_target) } ) then
			{	
				_KEGs_target = KEGs_target;
				
				_KEGs_targetPos = (vehicle _KEGs_target modelToWorld [0,0,0]);
				_KEGs_dir = direction _KEGs_target;
				
				_targetSpeed = speed vehicle _KEGs_target;
				_comSpeed = ((1.0 - (_targetSpeed/70))/3) max 0.1;	
				
				//KEGs_cxpos = _KEGs_targetPos select 0;
				//KEGs_cypos = _KEGs_targetPos select 1;
				//KEGs_czpos = _KEGs_targetPos select 2;
				
				_stance = "VEHICLE";
				if ( vehicle _KEGs_target == _KEGs_target ) then 
				{
					_stance = stance _KEGs_target;
				};
				
				switch ( _stance ) do
				{
					case "STAND": 
					{
						_foo = 2.10;
					};
					case "CROUCH":
					{
						_foo = 1.50;
					};
					case "PRONE":
					{
						_foo = 0.5;
					};
					case "VEHICLE":
					{
						_foo = 2.6;
					};						
					default 
					{
						_foo = 2;
					};
				};

				//if (KEGs_cameraNames select KEGs_cameraIdx == "Lock-on") then 
				//{	
				// if Action cam keep same angle to user
				if ( _actionCam ) then { KEGscam_lockon setDir _KEGs_dir };
				//};
				
				//Set dummy cam location
				//KEGscam_target camSetPos[KEGs_cxpos, KEGs_cypos, KEGs_czpos+(_foo*0.7)];
				KEGscam_target camSetPos[(_KEGs_targetPos select 0), (_KEGs_targetPos select 1), (_KEGs_targetPos select 2)+(_foo*0.7)];
				
				if( (vehicle KEGs_target) distance KEGscam_target > 650 ) then
				{ 
					_comSpeed = 0;
				};
				
				KEGscam_target camCommit _comSpeed; // /2;
				
				// Lockon camera, user rotates camera around target
				
				_d = (-(2*(0.3 max sdistance)));
				_z = sin(fangleY)*(2*(0.3 max sdistance));
				KEGscam_lockon camSetRelPos[(sin(fangle)*_d)*cos(fangleY), (cos(fangle)*_d)*cos(fangleY), _z];
				KEGscam_lockon camCommit _comSpeed;

				// Chase Camera
				KEGscam_chase setDir _KEGs_dir;
				KEGscam_chase camSetRelPos[sin(_KEGs_dir)*(-(2*sdistance)), cos(_KEGs_dir)*(-(2*sdistance)), 0.6*abs sdistance];
				KEGscam_chase camCommit _comSpeed;

				// Free camera
				if (KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
				{
					KEGS_camMarker setMarkerPosLocal position KEGscam_free;
					KEGS_camMarker setMarkerDirLocal direction KEGscam_free;
				};
				
				{_x camSetFov szoom} foreach KEGs_cameras;	
				
			};

			_CameraLoop_count = _CameraLoop_count + 1;
			//CameraLoop_count = CameraLoop_count +1;
			
			//player target got killed		
			//if ( (isNull KEGs_target) || { !(alive KEGs_target) } ) then 
			if ( (isNull KEGs_target) ) then 
			{
				private ["_newCheckUnits", "_foundUnit", "_s1", "_s2"];
				
				diag_log format ["WARNING - KEGs_target no longer found - waiting for new target"];
				
				waitUntil { sleep 0.5; if ( (isNull KEGs_target) && ( alive player ) ) then { KEGs_target = player}; ( !(isNull KEGs_target) ); };

				diag_log format ["KEGs_target found - switching to new target: %1 (%2) (%3 - %4)", KEGs_target, KEGs_targetName, _CameraLoop_count, CameraLoop_count];

				[] call RefreshPlayerList;
			};
		};
		
		diag_log "Exiting Spectator mode";
	};		
// end MovementCameraLoop
	
//call 
//	{
		
			lastCheckNewUnits = time;
			
			_allUnits = allUnits;
			_allVehicles = Vehicles;
			_newUnits = _allUnits - deathCam;	
		
			if (count _allVehicles > 0) then 
			{
				// Add event handlers to new vehicles
				_ehVehicles = _allVehicles;
				{
					// Add fired eventhandler for map indication
					_nn = _x getVariable "KEGsEHfired";
					if (isNil "_nn") then {
						_fh = _x addeventhandler["fired", { KEGs_autoTarget = gunner (_this select 0); }];
						_x setVariable["KEGsEHfired", _fh];
					};
				} count _allVehicles;
			};
			
			if(count _newUnits > 0) then 
			{
				_waitUnits = [];
				{
					if !( _x getVariable ["KEG_SPECT", false] ) then					
					{
						// If variable not found, set it, thus unit is tagged for next update cycle
						// This way, (re)spawned units have some time to fully initialize. Name arma.rpt Error fix.
						_x setVariable ["KEG_SPECT", true];
						_waitUnits set [(count _waitUnits ),_x];
					};
					
					// In an effort to compensate for Renegades (players with ratings of less than -2000) we will add this Renegage fix
					//Renegade Fix - ViperMaul
					_x call VM_CheckOriginalSide;
					
					if ( (typeOf _x) in ["Logic","SideBLUFOR_F","SideOPFOR_F","SideResistance_F"] ) then 
					{
						_newUnits = _newUnits - [_x];
					};
					
				} forEach _newUnits;
				
				// Add new units to end of list
				deathCam = deathCam + _newUnits;
				
				// Request listbox update
				KEGsNeedUpdateLB = true;
				
				// Create markers
				{ 
					// Create marker
					_m = createMarkerLocal[format["KEGsMarker%1", count _markers], (player modelToWorld [0,0,0]) ];
					_m setMarkerTypeLocal "mil_dot";			
					_m setMarkerSizeLocal[0.4, 0.4];
					_markers set [(count _markers),_m];
					
					_OriginalSide = _x call VM_CheckOriginalSide;  
					
					// Set marker color
					if(_OriginalSide == west) then {_m setMarkerColorLocal "ColorBlue";};
					if(_OriginalSide == east) then {_m setMarkerColorLocal "ColorRed";};
					if(_OriginalSide == resistance) then {_m setMarkerColorLocal "ColorGreen";};
					if(_OriginalSide == civilian) then {_m setMarkerColorLocal "ColorWhite";};			
					
					_KEGs_EHF_Indx = _x addeventhandler["fired", { KEGs_autoTarget = _this select 0 } ];
					KEGsEHFlist set [(count KEGsEHFlist), [_x, _KEGs_EHF_Indx]];
					
				} count _newUnits;						
			};
			
			[] call RefreshPlayerList;
			["Init"] call CameraMenuHandler;
			[true] call PlayerMenuHandler;
			
			if(count deathCam > 0 and !KEG_Spect_Init) then 
			{ 
				KEG_Spect_Init = true; 
				VM_SpectatorCamerasEnabled = true; 
			};
			
		   KEGs_mainLoop = [] spawn KEGs_fnc_MovementCameraLoop; 
	//};

EndLoadingScreen;		

		
		
while{ dialog } do 
{
		// Request listbox update every 20 seconds to update dead units or jip player names (
		if(time - KEGs_lastAutoUpdateLB > 20 && (RefreshListReady) && (CheckNewUnitsReady)) then 
		{
			KEGs_lastAutoUpdateLB = time;
			KEGsNeedUpdateLB = true;
		};	
	
		if(KEGsNeedUpdateLB && RefreshListReady && (CheckNewUnitsReady)) then 
		{
			[] spawn RefreshPlayerList;
		};
	
		// Check for new units every 20 seconds
		if((time - lastCheckNewUnits > 20)  && (CheckNewUnitsReady) ) then 
		{
			lastCheckNewUnits = time;
			RefreshListReady = false;
			[] spawn CheckNewUnits;
		}; 
		// End of If statement for Checking New Units

		// Update markers 10fps
		_rate = 10; // modified from 15 - norrin/ViperMaul
		if(count _markers > 100) then {_rate = 5}; // Update large number of markers less often // modified from 7.5 - norrin/ViperMaul
		if(count _markers > 200) then {_rate = 0.5}; // Update large number of markers less often // added - norrin/ViperMaul
		
		if(time - _lastUpdateMarkers > (1/_rate)) then 
		{
			_lastUpdateMarkers = time;
		
			if (!NORRN_noMarkersUpdates) then //added check to remove marker updates - norrin
			{
				// setMarkerTypeLocal is very slow, call it only once per second
				_doMarkerTypes = false;
				if(time - _lastUpdateMarkerTypes > 1) then 
				{
					_lastUpdateMarkerTypes = time;
					_doMarkerTypes = true; // Allow update marker types
				};
				
				if(ctrlVisible _cMapFull) then 
				{
					// Position camera in the middle of full map, for sound and
					// smoother marker motion (distant objects appear less smooth)
					_mapFull = _disp displayctrl _cMapFull;
					_mappos = _mapFull posScreenToWorld[0.5, 0.5];
					KEGscam_fullmap camSetTarget _mappos;
					KEGscam_fullmap camSetRelPos [0, -1, 150];
					KEGscam_fullmap camCommit 0;
				};
				
				_markedVehicles = []; // Keep track of vehicles with markers to avoid multiple markers for one vehicle
				for "_i" from 0 to ((count _markers)-1) do 
				{
					_m = _markers select _i;
					_u = (deathCam select _i);
					_m setMarkerPosLocal ((vehicle _u modelToWorld [0,0,0]));
					
					_OriginalSide = _u getVariable ["KEG_OriginalSide", side _u]; 
					if(!((_OriginalSide) in KEGsShownSides)) then 
					{
						// We arent' supposed to show this side unit - hide marker
						if(_doMarkerTypes) then {_m setMarkerTypeLocal "empty"};
					}
					else 
					{ 				
						if(KEGsMarkerNames or KEGsMinimapZoom < 0.15) then 
						{
							// Set full screen map marker types - Also zoomed minimap
							if(ctrlVisible _cMapFull) then 
							{
								switch(KEGsMarkerType) do 
								{
									case 0: {	// No text
										_m setMarkerTextLocal "";
									};
									case 1: {	// Names
										if(alive (vehicle _u)) then 
										{
											if(name (vehicle _u) != "Error: no unit") then {_m setMarkerTextLocal name ( _u)};
										};
									};
									case 2: {	// Types
										_m setMarkerTextLocal getText (configFile >> "CfgVehicles" >> format["%1", typeOf (vehicle _u)] >> "DisplayName");
									};
								};
							} 
							else 
							{
								// Minimap with detailed icons but no text
								_m setMarkerTextLocal "";
							};
							
							// No client side addon - basic markers
							if(_doMarkerTypes) then {_m setMarkerTypeLocal "mil_arrow"};
							
							if(_u == vehicle _u) then 
							{
								_m setMarkerSizeLocal[0.33*KEGsMarkerSize, 0.27*KEGsMarkerSize];
							}
							else 
							{
								_m setMarkerSizeLocal[0.42*KEGsMarkerSize, 0.42*KEGsMarkerSize];
							};						
							
							_m setMarkerDirLocal (getdir (vehicle _u));
						} 
						else 
						{
							_m setMarkerTextLocal "";
							if(_doMarkerTypes) then 
							{
								_m setMarkerTypeLocal "mil_dot";
							};
							_m setMarkerSizeLocal[0.4,0.4];
						};		
					};
					
					if(not alive _u) then 
					{
						_m setMarkerColorLocal "ColorBlack"
					};
					
					if(vehicle _u in _markedVehicles) then 
					{
						// This vehicle was already marked, hide marker
						_m setMarkerTypeLocal "Empty";
					} 
					else 
					{
						_markedVehicles set [(count _markedVehicles) , vehicle _u]; 
					};
				};	
			};
			// END OF added check to remove marker updates - norrin
			
			// Follow target with small map			
			_map = _disp displayctrl _cMap;
			ctrlMapAnimClear _map;
			if (KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
			{
				// Center on free camera position
				_map ctrlMapAnimAdd[0.3, KEGsMinimapZoom, [getPos KEGscam_free  select 0, getPos KEGscam_free  select 1,0]];
				
			} 
			else 
			{
				// Center on target
				_map ctrlMapAnimAdd[0.3, KEGsMinimapZoom, visiblePosition KEGs_target];
			};
			ctrlMapAnimCommit _map;					

			// Check if target changed and center main map
			if(KEGs_tgtIdx != KEGs_lastTgt) then 
			{
				//diag_log format ["specta update map: %1 - %2 - %3", KEGs_target, KEGs_tgtIdx, KEGs_lastTgt];
		
				_map = _disp displayctrl _cMapFull;
				ctrlMapAnimClear _map;
				_map ctrlMapAnimAdd [0.2, 1.0, visiblePosition (deathcam select KEGs_tgtIdx)];
				ctrlMapAnimCommit _map;			
			};
		};
			
		KEGs_lastTgt = KEGs_tgtIdx;	 //capture the last target index for the player in focus	

		// Wait a moment. 125fps ought to be enough for everyone :-)
		//_tt = time;
		//sleep(1/125);
		//KEGs_tbase = time-_tt;
		
		vm_count = vm_count + 1;
};

//StartLoadingScreen ["EXITING SPECTATOR MODE..."];

VM_SpectatorCamerasEnabled = False;

//diag_log format ["Exiting Spectator mode: script running: %1", !(scriptDone KEGs_mainLoop)];
terminate KEGs_mainLoop;
waitUntil { scriptDone KEGs_mainLoop };
//diag_log format ["Exiting Spectator mode: script running: %1", !(scriptDone KEGs_mainLoop)];

// Dialog closed with esc key
titleText["","BLACK IN", 0.5];

// Destroy cameras, markers, particlesources, etc.
camDestroy KEGscam_target;
//camDestroy KEGscam_missile;
camDestroy KEGscam_fullmap;
camDestroy KEGscam_free;
{camDestroy _x} foreach KEGs_cameras;
{deletemarkerlocal _x} foreach _markers;	 

if ( !(isNil "KEGSTagsScript") && { scriptDone KEGSTagsScript } ) then { terminate KEGSTagsScript; };
if ( !(isNil "KEGSTagsStatScript") && { scriptDone KEGSTagsStatScript } ) then { terminate KEGSTagsStatScript; };
KEGsTags = false;
KEGsTagsStat = false;
sleep 0.1; // to allow 
onMapSingleClick "";
//Clear particle sources
{deletevehicle _x;} count KEGsTagSources;
{deletevehicle _x;} count KEGsTagStatSources;
{ 
	if ( !isNull (_x getVariable ["spect_locator", objNull] ) ) then 
	{
		_x setVariable ["spect_locator", nil]; 
	};
	if ( !isNull (_x getVariable ["spect_combatmode", objNull] ) ) then 
	{
		_x setVariable ["spect_combatmode", nil]; 
	}; 	
} count allUnits;
KEGsTagSources = [];
KEGsTagStatSources = [];
//Remove EHs
{ (_x select 0) removeEventHandler ["killed", (_x select 1)] } forEach KEGsEHlist;
{ (_x select 0) removeEventHandler ["fired", (_x select 1)] } forEach KEGsEHFlist;
KEGsEHlist = [];
KEGsEHFlist = [];
//Restore viewDistance
setViewDistance KEGsOrgViewDistance;

deletemarkerlocal KEGS_camMarker;

//EndLoadingScreen;	

player switchCamera "INTERNAL";
player cameraEffect["terminate","FRONT"];

if ( (name player) == mcc_missionmaker ) then 
{
	// Close all dialogs and restart MCC
	closeDialog 0;
	[] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";
};
