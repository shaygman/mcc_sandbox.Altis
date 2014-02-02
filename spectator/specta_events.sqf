// "for Spectating Script";
// "Handles events such as keyboard keypresses";
// "by Kegetys <kegetys [ät] dnainternet.net>";

_type = _this select 0;
_param = _this select 1;

_cCamera = 55002;
_cTarget = 55003;
_cName = 55004;
KEGs_cLBCameras = 55005;
KEGs_cLBTargets = 55006;
_cCamerasBG = 55007;
_cTargetsBG = 55008;
_cBG1 = 55009;
_cBG2 = 55010;
_cTitle = 55011;
_cHelp = 55012;
_cMap = 55013;
_cMapFull = 55014;
_cMapFullBG = 55015;
_cEventLog = 50016;
_cDebug = 55100;
_UI = [_cCamera, _cTarget, _cName, KEGs_cLBCameras, KEGs_cLBTargets, _cCamerasBG, _cTargetsBG, _cBG1, _cBG2, _cTitle, _cHelp];

KEGs_fnc_camMove2 = 
{
	private ["_coef","_zCoef","_dX","_dY","_dZ","_pos","_dir","_camPos"];

	if (KEGs_cameraNames select KEGs_cameraIdx == "Free") then
	{
		_dX = _this select 0;
		_dY = _this select 1;
		_dZ = _this select 2;
		
		//--- Nelson's solution for key lag
		_coef = 0.1;
		_zCoef = 0.1;
		if (KEGs_CTRL_PRESS && { (_dZ == 0) } ) then {_coef = 5; _zCoef = 3; }; //press left ctrl key for turbo speed
		if (KEGs_ALT_PRESS) then {_coef = 1;  _zCoef = 0.5; }; //press left alt key to increase speed

		_pos = getPosASL KEGscam_free;
		_dir = (direction KEGscam_free) + _dX * 90;
		_camPos = [
			(_pos select 0) + ((sin _dir) * _coef * _dY),
			(_pos select 1) + ((cos _dir) * _coef * _dY),
			(_pos select 2) + _dZ * _zCoef * (abs(((getPosATL KEGscam_free) select 2) + 0.001379)/5)
		];
		
		_camPos set [2,(_camPos select 2) max ((getTerrainHeightASL _camPos) + 1)];
		KEGscam_free setPosASL _camPos;
	};
};

switch (_type) do 
{
	// "User clicked map, find nearest unit";
	case "MapClick": 
	{	
		_mapClickPos = _this select 1;
		
		if (KEGs_cameraNames select KEGs_cameraIdx == "Free") then  
		{
			_xx = _mapClickPos select 0;
			_yy = _mapClickPos select 1;
			//KEGs_cxpos = _xx;
			//KEGs_cypos = _yy;
						
			KEGscam_free setpos [_xx, _yy, (getPosATL KEGscam_free) select 2];
			
			KEGS_camMarker setmarkerposlocal position KEGscam_free;
			KEGS_camMarker setmarkerdirlocal direction KEGscam_free;
				
			if(ctrlVisible _cMapFull) then 
			{
				ctrlShow[_cMapFull, false];
				ctrlShow[_cMapFullBG, false];			
				0.5 fadeSound KEGsSoundVolume;
				ctrlShow[_cMap, true];
			};
		}
		else
		{
			_newCamTarget = (nearestObjects [_mapClickPos, ["CAManBase", "Air", "Car", "Tank"], 200]) select 0;
			//player globalChat format ["new target '%1' - curr target '%2' - ('%3') - ('%4')", _newCamTarget, KEGs_target, vehicle _newCamTarget, deathCam find _newCamTarget];			

			if ( !( isNull _newCamTarget ) && { ( vehicle _newCamTarget == _newCamTarget ) } ) then 
			{
				//player globalChat format ["Crew: '%1' - '%2'", _newCamTarget, crew _newCamTarget];			
				_newCamTarget = (crew _newCamTarget) select 0;
			};
			
			if ( !( isNull _newCamTarget ) && { !((deathCam find _newCamTarget) == -1) } ) then
			{
				KEGs_tgtIdx = deathCam find _newCamTarget;
				
				KEGs_target = _newCamTarget;
				
				//KEGs_cxpos = getPos KEGs_target select 0;
				//KEGs_cypos = getPos KEGs_target select 1;

				//KEGscam_free setpos [KEGs_cxpos, KEGs_cypos, (getPosATL KEGscam_free) select 2];
				
				KEGscam_free setPosATL (KEGs_target modelToWorld [0,-50,((getPosATL KEGscam_free) select 2)]);
				KEGscam_free setDir (getDir KEGs_target);
				[KEGscam_free,KEGscam_free_pitch,0] call bis_fnc_setpitchbank;
				
				KEGS_camMarker setmarkerposlocal position KEGscam_free;
				KEGS_camMarker setmarkerdirlocal direction KEGscam_free;
				
				// adjust target name bottom left
				[false] spawn PlayerMenuHandler;

				KEGs_autoTarget = KEGs_target;				
				//player sideChat format ["new target '%1' - curr target '%2' - ('%3' - '%4')", _newCamTarget, KEGs_target, KEGs_tgtIdx, deathCam select KEGs_tgtIdx];			
				
				if(ctrlVisible _cMapFull) then 
				{
					ctrlShow[_cMapFull, false];
					ctrlShow[_cMapFullBG, false];			
					0.5 fadeSound KEGsSoundVolume;
					ctrlShow[_cMap, true];
				};
			};
		};
	};
	
	case "KeyDown": 
	{		
		_key = _param select 1;
		
		//player globalChat format ["KEY: %1", _param];
		// "WSAD keys: camera movement in dropped mode";
		switch(_key) do 
		{		
			case 32: 
			{ 
				// D = right
				[1,1,0] call KEGs_fnc_camMove2;
			};	
			case 30: 
			{ 
				//A = left
				[-1,1,0] call KEGs_fnc_camMove2;
			};
			case 17: 
			{ 
				// W = forward
				[0,1,0] call KEGs_fnc_camMove2;
			};	
			case 31: 
			{ 
				// S = backward
				[0,-1,0] call KEGs_fnc_camMove2;
			};
			case 16: 
			{ 
				// Q = up
				[0,0,1] call KEGs_fnc_camMove2;
			};
			case 44: 
			{ 
				// Z = down
				[0,0,-1] call KEGs_fnc_camMove2;
			};			
			case 35: 
			{ 
				// H
				if (NORRN_noMarkersUpdates) then 
				{
					NORRN_noMarkersUpdates = false;
					titleCut ["\n\n\n\n\n\n\n\n\nMap Marker Updates Enabled","PLAIN", 0.2];
				} else {
					NORRN_noMarkersUpdates = true;
					titleCut ["\n\n\n\n\n\n\n\n\nMap Marker Updates Disabled","PLAIN", 0.2];
				};
			};
			case 56: 
			{ 
				//ALT
				KEGs_ALT_PRESS = true;
			};
			case 29: 
			{ 
				// CRTL
				KEGs_CTRL_PRESS = true;
			};
		};
	}; 
	
	// "Key up - process keypress";
	case "KeyUp": 
	{
		_key = _param select 1;

		switch(_key) do 
		{
			case 32: {
				// D
				if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
				{
					//Next target
					KEGs_tgtIdx = ( KEGs_tgtIdx + 1 );
					if ( KEGs_tgtIdx > ((count deathCam) - 1 ) ) then { KEGs_tgtIdx = 0 };
				
					KEGs_target = deathCam select KEGs_tgtIdx;
					
					// Skip dead AI/players if filter has been enabled
					while { ( KEGsDeadFilter ) && !( alive KEGs_target) } do
					{
						KEGs_tgtIdx = ( KEGs_tgtIdx + 1 );
						if ( KEGs_tgtIdx > ((count deathCam) - 1 ) ) then { KEGs_tgtIdx = 0 };
						KEGs_target = deathCam select KEGs_tgtIdx;
						
					};
					
					// Skip AI if filter has been enabled
					while { ( KEGsAIfilter ) && !( isPlayer KEGs_target) } do
					{
						KEGs_tgtIdx = ( KEGs_tgtIdx + 1 );
						if ( KEGs_tgtIdx > ((count deathCam) - 1 ) ) then { KEGs_tgtIdx = 0 };
						KEGs_target = deathCam select KEGs_tgtIdx;
					};					
					
					[false] spawn PlayerMenuHandler;
					
					if((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) then 
					{
						[] spawn CameraMenuHandler;
					};					

					KEGs_autoTarget = KEGs_target;					

					KEGscam_free setPosATL (KEGs_target modelToWorld [0,-50,((getPosATL KEGscam_free) select 2)]);
					KEGscam_free setDir (getDir KEGs_target);
					[KEGscam_free,KEGscam_free_pitch,0] call bis_fnc_setpitchbank;

				};
			};	
			case 30: {
				// A
				if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
				{
					 //Previous target
					KEGs_tgtIdx = ( KEGs_tgtIdx - 1 );
					if ( KEGs_tgtIdx < 0 ) then { KEGs_tgtIdx =  ((count deathCam) - 1 ) };
					
					KEGs_target = deathCam select KEGs_tgtIdx;
					
					// Skip dead AI/players if filter has been enabled
					while { ( KEGsDeadFilter ) && !( alive KEGs_target) } do
					{
						KEGs_tgtIdx = ( KEGs_tgtIdx - 1 );
						if ( KEGs_tgtIdx < 0 ) then { KEGs_tgtIdx =  ((count deathCam) - 1 ) };
						KEGs_target = deathCam select KEGs_tgtIdx;
					};					
					
					// Skip AI if filter has been enabled
					while { ( KEGsAIfilter ) && !( isPlayer KEGs_target) } do
					{
						KEGs_tgtIdx = ( KEGs_tgtIdx + 1 );
						if ( KEGs_tgtIdx > ((count deathCam) - 1 ) ) then { KEGs_tgtIdx = 0 };
						KEGs_target = deathCam select KEGs_tgtIdx;
					};	
					
					[false] spawn PlayerMenuHandler;
					
					if((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) then 
					{
						[] spawn CameraMenuHandler;
					};
					
					KEGs_autoTarget = KEGs_target;
					
					KEGscam_free setPosATL (KEGs_target modelToWorld [0,-50,((getPosATL KEGscam_free) select 2)]);
					KEGscam_free setDir (getDir KEGs_target);
					[KEGscam_free,KEGscam_free_pitch,0] call bis_fnc_setpitchbank;
				};
			};
		
			case 46: {
				// "C = Next camera";
				VM_CurrentCameraView = ""; 
				KEGs_cameraIdx = KEGs_cameraIdx + 1;
				KEGs_cameraIdx = KEGs_cameraIdx % (count KEGs_cameras);
				["Specta_Events"] call CameraMenuHandler;
				KEGsCamBack = false;
			};

			case 20: {
				// "T = Toggle tags";
				KEGsTags = !KEGsTags;
				if(!KEGsTags) then 
				{
					lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTags, [1,1,1,0.33]];
				}
				else
				{
					KEGSTagsScript = [] spawn KEGsShowUnitLocator;
					lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTags, [1, 0.5, 0, 1]];
				};
			};
			
			case 21: {
					// "Y = Toggle Awareness Tags";
					KEGsTagsStat = !KEGsTagsStat;
					if(!KEGsTagsStat) then 
					{
						lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTagsStat, [1,1,1,0.33]];
					}
					else
					{
						KEGSTagsStatScript = [] spawn KEGsShowCombatMode;
						lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTagsStat, [1, 0.5, 0, 1]];
					};
			};
			
			case 33: {
				// "F = Toggle filter";
				KEGsAIfilter = !KEGsAIfilter;
				KEGsNeedUpdateLB = true;
			};			
			
			case 47: {
				// "V = Toggle viewdistance";
				if ( viewDistance >  KEGsOrgViewDistance ) then 
				{ 
					if ( KEGs_ALT_PRESS ) then 
					{
						if ( viewDistance == KEGsTempViewDistance ) then 
						{
							setViewDistance KEGsOrgViewDistance;
						}
						else
						{
							setViewDistance KEGsTempViewDistance;
						};
					}
					else
					{
						if ( KEGs_CTRL_PRESS ) then 
						{
							setViewDistance 20000;
						}
						else
						{
							setViewDistance KEGsOrgViewDistance;
						};
					};
				}
				else 
				{
					if ( KEGs_ALT_PRESS ) then 
					{
						setViewDistance (( 4 * KEGsOrgViewDistance) max 9000 min 14000);
					}
					else
					{
						setViewDistance KEGsTempViewDistance;
					};
				};
			};
			
			case 57: {
				//"Space - toggle 1stperson/gunner";
				if(KEGs_cameras select KEGs_cameraIdx == KEGscam_1stperson) then 
				{
					KEGs1stGunner = !KEGs1stGunner;
				};
				[] spawn CameraMenuHandler;
			};
			
			// "Direct camera change with number keys";
			case 2: {
						KEGs_cameraIdx = 0; 
						VM_CurrentCameraView = ""; 
						//_debugPlayer globalchat "key 1"; 
						lbSetCurSel[KEGs_cLBCameras, KEGs_cameraIdx]; 
						ctrlSetText[_cCamera, format["Camera: %1", KEGs_cameraNames select KEGs_cameraIdx]]; 
						["Specta_Events"] spawn CameraMenuHandler;
					};				
			
			case 3: {
						KEGs_cameraIdx = 1; 
						VM_CurrentCameraView = ""; 
						//_debugPlayer globalchat "key 2"; 
						lbSetCurSel[KEGs_cLBCameras, KEGs_cameraIdx]; 
						ctrlSetText[_cCamera, format["Camera: %1", KEGs_cameraNames select KEGs_cameraIdx]];	
						["Specta_Events"] spawn CameraMenuHandler;
					};				
			
			case 4: {
						KEGs_cameraIdx = 2; 
						VM_CurrentCameraView = ""; 
						//_debugPlayer globalchat "key 3"; 
						lbSetCurSel[KEGs_cLBCameras, KEGs_cameraIdx]; 
						ctrlSetText[_cCamera, format["Camera: %1", KEGs_cameraNames select KEGs_cameraIdx]];	
						["Specta_Events"] spawn CameraMenuHandler;
					};
			
			case 5: {
						KEGs_cameraIdx = 3; 
						VM_CurrentCameraView = ""; 
						//_debugPlayer globalchat "key 4"; 
						lbSetCurSel[KEGs_cLBCameras, KEGs_cameraIdx]; 
						ctrlSetText[_cCamera, format["Camera: %1", KEGs_cameraNames select KEGs_cameraIdx]];	
						["Specta_Events"] spawn CameraMenuHandler;
					};					
		
			// "Toggle NVG or map text type";
			case 49: {
				if(ctrlVisible _cMapFull) then 
				{
					KEGsMarkerType = KEGsMarkerType + 1;
					if(KEGsMarkerType > 2) then {KEGsMarkerType=0;};					
				}
				else 
				{
					KEGs_camera_vision = KEGs_camera_vision + 1;
					KEGs_camera_vision = KEGs_camera_vision % 4;
					
					switch (KEGs_camera_vision) do 
					{
						case 0: {
							camusenvg false;
							false SetCamUseTi 0;
						};
						case 1: {
							camusenvg true;
							false SetCamUseTi 0;
						};
						case 2: {
							camusenvg false;
							true SetCamUseTi 0;
						};
						case 3: {
							camusenvg false;
							true SetCamUseTi 1;
						};
					};
				};
			};
			
			case 50: {["ToggleMap",0] call spectate_events;};
			case 15: {["ToggleUI",0] call spectate_events;};
			case 59: {["ToggleHelp",0] call spectate_events;};			
			
			// "Numpad + / -";
			case 78: {if(KEGsMarkerSize < 1.7) then {KEGsMarkerSize = KEGsMarkerSize * 1.15}};
			case 74: {if(KEGsMarkerSize > 0.7) then {KEGsMarkerSize = KEGsMarkerSize * (1/1.15)}};
			
			case 56: { 
				//ALT
				KEGs_ALT_PRESS = false;
			};
			case 29: { 
				// CRTL
				KEGs_CTRL_PRESS = false;
			};
		};
	}; 	
	
	// "Mouse events";
	case "MouseMoving": 
	{	
		//if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
		//{
			_x = _param select 1;
			_y = _param select 2;
			KEGsMouseCoord = [_x, _y];
			[] spawn FreeLookMovementHandler;
		//};
	};
		
	case "MouseButtonDown": 
	{
		//if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
		//{
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			KEGsMouseButtons set[_button, true];
		//};
	};
	
	case "MouseButtonUp": 
	{
		//if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
		//{
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			KEGsMouseButtons set[_button, false];
			[] spawn FreeLookMovementHandler;
		//};
	};	
	
	case "MouseZChanged": 
	{	
		//player globalChat format ["CAMERA: [%1] - [%2]", KEGs_cameraNames select KEGs_cameraIdx, KEGs_cameraIdx];
	
		if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
		{
			//KEGsMouseScroll = KEGsMouseScroll + (_param select 1);
			[(_param select 1)] spawn FreeLookMovementHandler; 
		}
		else
		{
			_camVector = vectordir KEGscam_free;

			_coef = 2;
			if (KEGs_CTRL_PRESS) then {_coef = 50;}; //press left ctrl key to turbo speed
			if (KEGs_ALT_PRESS) then {_coef = 10;}; //press left alt key to increase speed
			
			_dZ = (( _this select 1 ) select 1 ) * _coef;
			_vX = (_camVector select 0) * _dZ;
			_vY = (_camVector select 1) * _dZ;
			_vZ = 0; 

			_camPos = getPosASL KEGscam_free;
			_camPosL_z = (getPosATL KEGscam_free) select 2;
			_camPos = [
				(_camPos select 0) + _vX,
				(_camPos select 1) + _vY,
				(_camPos select 2) + _vZ
			];
			_camPos set [2,(getTerrainHeightASL _camPos) + _camPosL_z];
			KEGscam_free setPosASL _camPos;
		};
	};	

	case "MouseZChangedminimap": {
		KEGsMinimapZoom = ( KEGsMinimapZoom - ((_param select 1)*0.025) ) min 0.75 max 0.01;
		//if(KEGsMinimapZoom > 0.75) then {KEGsMinimapZoom=0.75};
		//if(KEGsMinimapZoom < 0.01) then {KEGsMinimapZoom=0.01};
	};			
		
	case "ToggleCameraMenu": {
		// "hide/unhide camera menu";
		if(ctrlVisible KEGs_cLBCameras) then {
			ctrlShow[KEGs_cLBCameras, false];
			ctrlShow[_cCamerasBG, false];
		} else {
			ctrlShow[KEGs_cLBCameras, true];
			ctrlShow[_cCamerasBG, true];
		};
	};
	
	case "ToggleTargetMenu": {
		// "hide/unhide targets menu";
		if(ctrlVisible KEGs_cLBTargets) then {
			ctrlShow[KEGs_cLBTargets, false];
			ctrlShow[_cTargetsBG, false];
		} else {
			ctrlShow[KEGs_cLBTargets, true];
			ctrlShow[_cTargetsBG, true];
		};
	};
	
	case "ToggleUI": {
		// "hide/unhide UI";
		if(ctrlVisible _cName) then {
			{ctrlShow[_x, false]} foreach _UI;
		} else {
			{ctrlShow[_x, true]} foreach _UI;
			ctrlShow[_cHelp, false];
			ctrlShow[KEGs_cLBTargets, false];
			ctrlShow[_cTargetsBG, false];			
			ctrlShow[KEGs_cLBCameras, false];
			ctrlShow[_cCamerasBG, false];			
		};
	};
		
	case "ToggleHelp": {
		// "hide/unhide Help text";
		if(ctrlVisible _cHelp) then {
			ctrlShow[_cHelp, false];
		} else {
			ctrlShow[_cHelp, true];
		};
	};

	case "ToggleMap": {
		// "hide/unhide Map";
		if(ctrlVisible _cMap and ctrlVisible _cMapFull) then {
			// "Beginning, hide both";
			ctrlShow[_cMap, false];
			ctrlShow[_cMapFull, false];			
			ctrlShow[_cMapFullBG, false];			
		};
		
		if(ctrlVisible _cMap) then {
			ctrlShow[_cMap, false];			
			ctrlShow[_cMapFull, true];
			ctrlShow[_cMapFullBG, true];			
			KEGsMarkerNames = true;
			KEGsSoundVolume = soundVolume;
			0.5 fadeSound 0.2;
		} else {
			KEGsMarkerNames = false;
			if(ctrlVisible _cMapFull) then {
				ctrlShow[_cMapFull, false];
				ctrlShow[_cMapFullBG, false];			
				0.5 fadeSound KEGsSoundVolume;
			} else {
				ctrlShow[_cMap, true];
			};
		};
	};
	
	// "Toggle particlesource tags";	
	case "ToggleTags": 
	{
	/*
		_lifeTime = 0.25;
		_dropPeriod = 0.05;
		
		_part = "\a3\data_f\cl_water.p3d";
		//_part = "\A3\data_f\ParticleEffects\Universal\smoke.p3d";
		{
			_u = _x select 0;
			_s = _x select 1;
			
			if ( KEGsTags && { !(isNull _u) } && { (alive _u) } )  then 
			{
				_size = 5 min (5* (getPosATL (KEGs_cameras select KEGs_cameraIdx) select 2)/400) max 0.2;
				
				_color = [1,1,1,1];
				switch ( side _u ) do
				{
					case east: { _color = [1,0,0,1]; };
					case west: { _color = [0,0,1,1]; };
					case resistance: { _color = [0,1,0,1]; };
					default { _color = [1,1,1,1]; };
				};

				_colorB = [_color select 0, _color select 1, _color select 2, 0];

				_s setParticleParams[_part, "", "billboard", 1, _lifeTime, [0, 0, 2], [0,0,0], 1, 1, 0.784, 0.1, [_size, _size*0.66], [_color, _color, _color, _color, _color], [1], 10.0, 0.0, "", "", vehicle _u];
				_s setDropInterval _dropPeriod;
			}		
			else
			//turn off
			{
				if !( isNull _u) then 
				{
					_s setDropInterval 0;
				};
			};
		} foreach KEGsTagSources;
		*/
	};
	
	// "Toggle particlesource tags";	
	case "ToggleTagsStat": 
	{
		if(_param select 0) then 
		{
			// "turn on";
			{
				_u = _x select 0;
				_s = _x select 1;
				[_u, _s] spawn KEGsShowCombatMode;
			} foreach KEGsTagStatSources;
		}
		else 
		{
			// "turn off";
			{
				_u = _x select 0;	
				_s = _x select 1;	
				if !(isNull _u) then 
				{
					_s setDropInterval 0;
				}
				else
				{
					deleteVehicle _s;
				};
			} foreach KEGsTagStatSources;
		};

	};	

/*	
	// "Fired eventhandler, display as marker in map";
	// "Also missile camera is handled here";
	case "UnitFired": 
	{				
		if(KEGsTags and KEGsClientAddonPresent) then {
			// "Bullet path bar";
			_u = _param select 0;
			_w = _param select 1;
			_a = _param select 4;
			_o = (getpos _u) nearestObject _a;
			
			_type = getText(configFile >> "CfgAmmo" >> format["%1", typeOf _o] >> "simulation");
			
			if(_type == "shotBullet") then {
				_bar = "KEGspect_bar_yellow";				
				if(side _u == west) then {_bar = "KEGspect_bar_red"};
				if(side _u == east) then {_bar = "KEGspect_bar_green"};
				
				_bars = [];
				for "_i" from 0 to 300 step 5 do {
					_pos = _o modelToWorld[0,_i+2.5,0];
					_b = _bar createVehicleLocal _pos;
					_b setVectorDir(vectorDir _o);
					_b setVectorUp(vectorUp _o);
					_bars set [(count _bars) , _b]; // _bars = _bars + [_b];
				};		
				_bars spawn {sleep 1.5;{deletevehicle _x} foreach _this};
			};
		};
		if(ctrlVisible _cMapFull) then {
			_u = _param select 0;
			_w = _param select 1;
			_a = _param select 4;
			_o = (getpos _u) nearestObject _a;
			_len = (speed _o)/15;
			KEGs_dir = getdir _o;
			// "Marker for shot effect (stationary circle)";
			_m2 = createMarkerLocal[format["KEGsMarkerFired%1", random 10000], getpos _o];
			_m2 setMarkerColorLocal "ColorYellow";
			_m2 setMarkerSizeLocal[0.45, 0.45];
			_m2 setMarkerTypeLocal "Select";
			
			_type = getText(configFile >> "CfgAmmo" >> format["%1", typeOf _o] >> "simulation");
			_name = getText(configFile >> "CfgWeapons" >> format["%1", _w] >> "displayName");
			
			// "Marker for round itself, for bullet display line, everything else a named marker";
			if(_type == "shotMissile" OR _type == "shotRocket" OR _type == "shotShell" OR _type == "shotTimeBomb" OR _type == "shotPipeBomb" OR _type == "shotMine" OR _type == "shotSmoke") then {
				_m = createMarkerLocal[format["KEGsMarkerFired%1", random 10000], [(getpos _o select 0)+(sin KEGs_dir)*_len, (getpos _o select 1)+(cos KEGs_dir)*_len, 0]];
				_m setMarkerTypeLocal "mil_dot";
				_m setMarkerColorLocal "ColorWhite";
				_m setMarkerSizeLocal[0.25,0.5];
				_m setMarkerTextLocal _name;
				_m2 spawn {sleep(2);deleteMarkerLocal _this};		
				[_m, _o] spawn {
					_m = _this select 0;
					_o = _this select 1;
					while{!isNull _o} do {
						_m setMarkerPosLocal getpos _o;
						_m setMarkerDirLocal getdir _o;
						sleep(1/50);
					};
					_m setMarkerColorLocal "ColorBlack";
					sleep(3);
					deleteMarkerLocal _m;
				};
			} else {
				_m = createMarkerLocal[format["KEGsMarkerFired%1", random 10000], [(getpos _o select 0)+(sin KEGs_dir)*_len, (getpos _o select 1)+(cos KEGs_dir)*_len, 0]];
				_m setMarkerShapeLocal "RECTANGLE";
				_m setMarkerSizeLocal[0.25,_len];
				_m setMarkerDirLocal (getdir _o);
				if(KEGsClientAddonPresent) then {
					_m setMarkerColorLocal "KEGsDarkYellow";
					[_m2, _m] spawn {sleep(1.0);(_this select 1) setMarkerColorLocal "KEGsYellowAlpha";sleep(1);deletemarkerLocal (_this select 1);deletemarkerLocal (_this select 0);};		
				} else {
					_m setMarkerColorLocal "ColorYellow";
					[_m2, _m] spawn {sleep(1.0);(_this select 1) setmarkerbrushLocal "grid";sleep(1);deletemarkerLocal (_this select 1);deletemarkerLocal (_this select 0);};		
				};
			}
		};
		
		// "Missile camera";			
		if(KEGsUseMissileCam and !KEGsDroppedCamera) then 
		{
			_u = _param select 0;
			_w = _param select 1;
			_a = _param select 4;
			_o = (getpos _u) nearestObject _a;
			
			_type = getText(configFile >> "CfgAmmo" >> format["%1", typeOf _o] >> "simulation");
			_name = getText(configFile >> "CfgWeapons" >> format["%1", _w] >> "displayName");
			
			if(_u == vehicle KEGs_target and (_type == "shotMissile" or _type == "shotRocket") and !KEGsMissileCamActive) then 
			{
				KEGsMissileCamActive = true;
				cutText[_name,"PLAIN DOWN", 0.10];
				KEGscam_missile switchCamera "INTERNAL";
				_debugPlayer globalchat "Line 398 KEGscam_missile switchCamera 'INTERNAL';";
				KEGscam_missile cameraEffect["internal", "BACK"];	
				KEGscam_missile camsettarget _o;
				KEGscam_missile camsetrelpos[0,0,0];
				KEGscam_missile camSetFov 0.5;
				KEGscam_missile camCommit 0;
				KEGscam_missile camSetFov 1.25;
				KEGscam_missile camCommit 2;
				_o spawn {
					while{!isNull _this and speed _this > 1} do {
						KEGscam_missile camsettarget _this;
						KEGscam_missile camsetrelpos[0,-0.1,0.20];
						KEGscam_missile camCommit 0;			
						sleep(0.01);			
					};
					sleep(3);
					KEGsMissileCamActive = false;
				};				
			};
		};
	};
*/
				
	default {
		hint "Unknown event";
	};
};

false
