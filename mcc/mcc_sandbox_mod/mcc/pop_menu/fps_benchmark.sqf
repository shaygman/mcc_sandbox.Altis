// script called by event handler in order to display server and Headless client FPS in MCC Gui
private ["_i"];

//diag_log format ["FPS: this: [%1] - running [%2]", _this, mcc_fps_running];

// mcc_fps_running is used to make sure only one FPS instance is running
// run FPS diag for about 10 seconds

if !( mcc_fps_running )  then
{
	if ( isServer ) then 
	{
		mcc_fps_running = true;
		publicvariable "mcc_fps_running";
	};
	
	_i = 0;
	
	while { ( _i < 10 ) && (mcc_fps_running) } do
	{
		if (isServer) then 
		{
			MCC_serverFPS = round(diag_fps);
			publicvariable "MCC_serverFPS";
		};
	
		if (MCC_isLocalHC) then 
		{
			MCC_hcFPS = round(diag_fps);
			publicvariable "MCC_hcFPS";
		};

		sleep 1;
		_i = _i + 1;
	};
	
	if ( MCC_isLocalHC ) then 
	{
		MCC_hcFPS = round(diag_fps);
		publicvariable "MCC_hcFPS";
	};

	if (isServer) then 
	{
		MCC_serverFPS = round(diag_fps);
		publicvariable "MCC_serverFPS";
		publicvariable "mcc_fps_running";
	};
};
//diag_log format ["FPS: [%1] - [%2]", MCC_hcFPS, MCC_serverFPS];
