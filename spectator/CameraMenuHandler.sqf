private ["_Source", "_debugPlayer", "_cName", "_cCamera", "_KEGs_cs"];

//diag_log format ["camera menu start: %1", KEGs_target];

//_Source = _this select 0;

//_debugPlayer=objNull;
//if ( f_var_debugMode == 1 ) then {
//	_debugPlayer=player;
//};
//_debugPlayer groupchat format ["CameraMenuHandler Source: %1", _Source]; 
//_msg = format["CameraMenuHandler Source: %1", _Source];
//if ( f_var_debugMode == 1 ) then { diag_log  _msg; };

_cName = 55004;
_cCamera = 55002;

// ----------------------------------------------------------------------------------------------------------------------------------------------------
	// Check for listbox selections
	if(KEGs_camSelLast != lbCurSel KEGs_cLBCameras) then 
	{
		_KEGs_cs = lbCurSel KEGs_cLBCameras;
		if(_KEGs_cs == KEGs_cLbSeparator) then {
			_KEGs_cs = KEGs_camSelLast;
			//_debugPlayer globalchat "KEGs_cLbSeparator";
		};
		
		// Special for toggling tags
		if(_KEGs_cs == KEGs_cLbToggleTags) then {
			KEGsTags = !KEGsTags;
			//["ToggleTags", [KEGsTags]] call spectate_events;
			if ( KEGsTags ) then { KEGSTagsScript = [] spawn KEGsShowUnitLocator; };
			_KEGs_cs = KEGs_camSelLast;
			//_debugPlayer globalchat "toggle tags";
		};
		
		// Special for toggling awareness ststus tags
		if(_KEGs_cs == KEGs_cLbToggleTagsStat) then {
			KEGsTagsStat = !KEGsTagsStat;
			//["ToggleTagsStat", [KEGsTagsStat]] call spectate_events;
			if ( KEGsTagsStat ) then { KEGSTagsStatScript = [] spawn KEGsShowCombatMode; };
			_KEGs_cs = KEGs_camSelLast;
			//_debugPlayer globalchat "toggle tags";
		};						
		
		// Special for toggling AI filter
		if(_KEGs_cs == KEGs_cLbToggleAiFilter) then {
			KEGsAIfilter = !KEGsAIfilter;
			_KEGs_cs = KEGs_camSelLast;				
			KEGsNeedUpdateLB = true; // Request listbox update
			//_debugPlayer globalchat "toggle AI filter";
		};
		
		// Special for toggling Unknown (Dead) Players
		if(_KEGs_cs == KEGs_cLbToggleDeadFilter) then 
		{
			KEGsDeadFilter = !KEGsDeadFilter;
			_KEGs_cs = KEGs_camSelLast;				
			KEGsNeedUpdateLB = true; // Request listbox update
//			_debugPlayer globalchat "toggle Unknown (Dead) filter";
		};
		
		// Special for toggling Unknown (Dead) Players
		if(_KEGs_cs == KEGs_cLbToggleCombatActionFilter) then 
		{
			KEGsCombatActionFilter = !KEGsCombatActionFilter;
			_KEGs_cs = KEGs_camSelLast;				
			KEGsNeedUpdateLB = true; // Request listbox update
//			_debugPlayer globalchat "toggle Unknown (Dead) filter";
		};
		
		KEGs_cameraIdx = _KEGs_cs;
		KEGs_camSelLast = lbCurSel KEGs_cLBCameras; //immediately capture the last selected camera index
		//_debugPlayer globalchat "Reset KEGs_cameraIdx to the New or Current Mode";			
	};
	
	lbSetCurSel[KEGs_cLBCameras, KEGs_cameraIdx];	// reset camera mode selection in the listbox to the new or current camera mode
	
	// Check limits
	if(KEGs_cameraIdx < 0) then {KEGs_cameraIdx = 0};
	if(KEGs_cameraIdx >= count KEGs_cameras) then {KEGs_cameraIdx = (count KEGs_cameras)-1;};
	
	// If not in First Person mode rest camera
	//if (!((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) && !(VM_CurrentCameraView in ["INTERNAL","GUNNER"]) ) then 
	if !( (KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson )  then 
	{ 
		(KEGs_cameras select KEGs_cameraIdx) cameraEffect["internal", "BACK"]; // CHECK IF NEEDED !!!
		//_debugplayer globalchat format ["Resetting Camera on to %1", KEGs_target];
	};

// ----------------------------------------------------------------------------------------------------------------------------------------------------
	// Set toggle text color for camera menu		
		
	if(KEGsTags) then {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTags, [1, 0.5, 0, 1]]} 
	else {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTags, [1,1,1,0.33]]};			

	if(KEGsTagsStat) then {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTagsStat, [1, 0.5, 0, 1]]} 
	else {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleTagsStat, [1,1,1,0.33]]};			
	
	if(KEGsAIfilter) then {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleAiFilter, [1, 0.5, 0, 1]]} 
	else {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleAiFilter, [1,1,1,0.33]]};			

	if(KEGsDeadFilter) then {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleDeadFilter, [1, 0.5, 0, 1]]} 
	else {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleDeadFilter, [1,1,1,0.33]]};	
	
	if(KEGsCombatActionFilter) then {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleCombatActionFilter, [1, 0.5, 0, 1]]} 
	else {lbSetColor[KEGs_cLBCameras, KEGs_cLbToggleCombatActionFilter, [1,1,1,0.33]]};
	
// ----------------------------------------------------------------------------------------------------------------------------------------------------
	// Toggle 1st Person view
	if((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) then 
	{
		// 1st person view
		VM_CurrentCameraView = cameraView; // Save the current CameraView
		//player globalChat ("Camera View: "+ str(VM_CurrentCameraView) );	
		
		if ( (KEGs1stGunner) && !(VM_CurrentCameraView == "GUNNER") ) then 
		{
			(vehicle KEGs_target) switchCamera "GUNNER";
			//player globalchat "switchCamera 'GUNNER'";
		}
		else 
		{
			(vehicle KEGs_target) switchCamera "INTERNAL";
			//player globalchat "switchCamera 'INTERNAL'";
		};
		//player globalchat Format ["**Handler CameraView is currently %1",cameraView];
		 (vehicle KEGs_target) cameraEffect ["terminate","BACK"]; 
		 (vehicle KEGs_target) camcommit 0;
	};


ctrlSetText[_cCamera, format["Camera: %1", KEGs_cameraNames select KEGs_cameraIdx]];	
KEGs_camSelLast = lbCurSel KEGs_cLBCameras; 
