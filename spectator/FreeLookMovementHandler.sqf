//FreeLookMovementHandler = 
//{
	private ["_dX", "_dY", "_mouseScroll", "_zfactor"];

	mouseDeltaX = mouseLastX - (KEGsMouseCoord select 0);
	mouseDeltaY = mouseLastY - (KEGsMouseCoord select 1);	
			
	_mouseScroll = 0;
	_zfactor = 0.1;
	
	// ------------------------------------------------------------------------------------------------------
	// Process mouse movement
	
	if !(KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
	{
		if ( count _this > 0 ) then { _mouseScroll = _this select 0; };
	
		if ( (KEGsMouseButtons select 1) && { !(KEGsMouseButtons select 0) } ) then 
		{
			// Right mouse button - Adjust position
			fangle = fangle - (mouseDeltaX*360);
			fangleY = (fangleY + (mouseDeltaY*180)) min 89 max -89;
		};

		// Mouse scroll wheel - Adjust distance Lock-on mode
		if ( (_mouseScroll != 0) && { (KEGs_cameraNames select KEGs_cameraIdx == "Lock-on") } ) then 
		{
			// Maximum view distance = 100 m
			sdistance = (sdistance - (_mouseScroll*sdistance/10)) max 0 min 75;
		};
		
		// Mouse scroll wheel - Adjust distance Chase mode
		if ( (_mouseScroll != 0) && { (KEGs_cameraNames select KEGs_cameraIdx == "Chase") } ) then 
		{
			// Maximum view distance = -50 m / 50 m 
			if ( abs(sdistance) > 3 ) then { _zfactor = abs(sdistance)/10 };
			sdistance = (sdistance - (_mouseScroll*_zfactor)) max -50 min 50;
		};
		
		// Both mousebuttons + ALT = Adjust zoom		
		if( KEGs_ALT_PRESS && { (KEGsMouseButtons select 0) } && { (KEGsMouseButtons select 1) } ) then 
		{
			// Maximum zoom level = 0.05
			// Minimum zoom level = 2;
			szoom = (szoom - (mouseDeltaY*3)) min 2 max 0.05;
		};
		
		// Both mousebuttons + ALT + CTRL = Reset zoom
		if( KEGs_CTRL_PRESS && { KEGs_ALT_PRESS } && { (KEGsMouseButtons select 0) } && { (KEGsMouseButtons select 1) } ) then 
		{
			szoom = 1;
		};
	}
	// ------------------------------------------------------------------------------------------------------
	//	if (KEGs_cameraNames select KEGs_cameraIdx == "Free") then 
	else
	{
		if(!(KEGsMouseButtons select 0) and (KEGsMouseButtons select 1)) then 
		{
			_dX = 0;
			_dY = 0;
			
			 if !( mouseDeltaX == 0 ) then {  _dX = mouseDeltaX * -100; };
			 if !( mouseDeltaY == 0 ) then {  _dY = mouseDeltaY * 50; };
	
			_dX = _dX max -180 min +180;
			
			KEGscam_free_pitch = (KEGscam_free_pitch + _dY) max -90 min +90;

			KEGscam_free setdir (direction KEGscam_free + _dX);
			[KEGscam_free,KEGscam_free_pitch,0] call bis_fnc_setpitchbank;
		};
	};

	mouseLastX = KEGsMouseCoord select 0;
	mouseLastY = KEGsMouseCoord select 1;	
//};


