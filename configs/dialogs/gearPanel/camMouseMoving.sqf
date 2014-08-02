private ["_mode","_ctrl","_posX","_posY","_newY","_center"];

disableSerialization;
_mode = _this select 0;
_input = _this select 1;

_ctrl = _input select 0;

if (isnil "CP_gearCam") exitWith {};
if (isnull CP_gearCam) exitWith {};

if (_mode == "MouseButtonDown") then
{
	_key = _input select 1;
	
	//--- mouseHolding 
	if (_key == 0) then 
	{			
		if (isnil "CP_camMouseHolding") then {CP_camMouseHolding = true}; 
		CP_camMouseHolding = true;
	};
}; 
		
if (_mode == "MouseButtonUp") then
		{
		_key = _input select 1;
		if (_key == 0) then {			//--- mouse no longer Holding 
			CP_camMouseHolding = false;
			};
		};
		
if (_mode == "MouseZChanged") then
		{
		_key = _input select 1;
		if (_key<0) then {
			CP_gearCamFOV = CP_gearCamFOV + 0.02;
			} else {
				CP_gearCamFOV = CP_gearCamFOV - 0.02;
				};
		if (CP_gearCamFOV <= 0.05) then {CP_gearCamFOV = 0.05};
		if (CP_gearCamFOV >= 0.15) then {CP_gearCamFOV = 0.15};
		CP_gearCam camsetFOV CP_gearCamFOV;
		CP_gearCam camCommit 0.1;
		};
		
if (_mode == "mousemoving") then
{
	if (isnil "CP_camMouseHolding") exitWith {}; 
	
	if (CP_camMouseHolding) then 
	{
		private ["_factor"];
		_factor = if (MCC_squadDialogOpen) then {0.5} else {0.1};
		
		_posX = _input select 1;
		if (isnil "CP_camMouseMovingX") then {CP_camMouseMovingX = _posX};
		if (isnil "CP_camMouseMovingAttachposX") then {CP_camMouseMovingAttachposX = 0.5};
		_newX = CP_camMouseMovingX - _posX;
		if (_newX > 0) then {CP_camMouseMovingAttachposX = CP_camMouseMovingAttachposX + _factor} else {CP_camMouseMovingAttachposX = CP_camMouseMovingAttachposX - _factor}; 
		
		//If we came here after respawn we want to limit view to the front only of the player
		if !(MCC_squadDialogOpen) then
		{
			CP_camMouseMovingAttachposX = (-1.5 max CP_camMouseMovingAttachposX) min 1.5;
			CP_gearCam attachto [player getvariable "CPCenter" ,[CP_camMouseMovingAttachposX,12,2.8],""];
		}
		else
		{
			CP_camMouseMovingAttachposX = (-10 max CP_camMouseMovingAttachposX) min 10;
			CP_gearCam attachto [player getvariable "CPCenter" ,[CP_camMouseMovingAttachposX,-12,2.8],""];
		};
		
		CP_camMouseMovingX = _posX; 
	};
};