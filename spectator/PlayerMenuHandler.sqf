private ["_Source", "_debugPlayer", "_cName", "_cCamera", "_idx", "_found", "_role", "_name", "_ccName", "_disp", "_mode", "_KEGs_target"];

_cName = 55004;
_cCamera = 55002;
_name = ""; 

if ( _this select 0 ) then 
{
	/****************************************   PLAYER MENU HANDLING ***************************************************/

	if(lbCurSel KEGs_cLBTargets > lbSize KEGs_cLBTargets) then 
	{
		lbSetCurSel[KEGs_cLBTargets, lbSize KEGs_cLBTargets];	// Selection outside listbox size
		//_debugPlayer globalchat "Selection outside listbox size - reset select";
	};

	// CHECK FOR NEW PLAYER TARGET 
	if ( KEGs_tgtSelLast != lbCurSel KEGs_cLBTargets ) then 
	{
		KEGs_tgtIdx = lbValue[KEGs_cLBTargets, (lbCurSel KEGs_cLBTargets)]; // Get the new target
		KEGs_lastTgt = KEGs_tgtIdx;	//immediately capture the last target index
		KEGs_tgtSelLast = lbCurSel KEGs_cLBTargets; //immediately capture the last selected target index
	
		// Check limits
		if(KEGs_tgtIdx >= count deathCam) then {KEGs_tgtIdx = (count deathCam)-1;};
		if(KEGs_tgtIdx < 0) then {KEGs_tgtIdx = 0};	
						
		//player globalchat format ["*Changing Camera to %1", (KEGs_cameras select KEGs_cameraIdx) ];
		_KEGs_target = deathCam select KEGs_tgtIdx;  // reset camera to the new or current player target
		//KEGs_cxpos = getPosATL _KEGs_target select 0;
		//KEGs_cypos = getPosATL _KEGs_target select 1;

		KEGs_target = _KEGs_target;
		KEGs_autoTarget = _KEGs_target;
		
		// move free cam to same position
		//KEGscam_free setPosATL [KEGs_cxpos, KEGs_cypos, (getPosATL KEGscam_free) select 2];
		KEGscam_free setPosATL (KEGs_target modelToWorld [0,-50,((getPosATL KEGscam_free) select 2)]);
		KEGscam_free setDir (getDir KEGs_target);
		
	};
	
	
	// If not in First Person mode rest camera
	If (!((KEGs_cameras select KEGs_cameraIdx) == KEGscam_1stperson) && !(VM_CurrentCameraView in ["INTERNAL","GUNNER"]) ) then 
	{ 
		(KEGs_cameras select KEGs_cameraIdx) cameraEffect["internal", "BACK"];
		//player globalchat format ["Resetting Camera on to %1", KEGs_target];
	};
	
	
	if( lbValue[KEGs_cLBTargets, (lbCurSel KEGs_cLBTargets)] != KEGs_tgtIdx) then 
	{
		// Find listbox element with matching value
		for "_idx" from 0 to (lbSize KEGs_cLBTargets) do 
		{
			if(lbValue[KEGs_cLBTargets, (lbCurSel KEGs_cLBTargets)] == KEGs_tgtIdx) then 
			{
				lbSetCurSel[KEGs_cLBTargets, _idx];
				//_found = true;
			};
		};
	};
	
};		
	
// Set UI texts
_role = "";
_KEGs_target = KEGs_target;

// _name = "Unknown";
if(alive _KEGs_target) then 
{	
	_name = name _KEGs_target;
	KEGs_targetName = _name;

	if(_name == "Error: no unit") then { _name = "Unknown" };
	
	if(vehicle _KEGs_target != _KEGs_target) then 
	{
		if(_KEGs_target == driver vehicle _KEGs_target) then {_role = "(Driver)"};
		if(_KEGs_target == gunner vehicle _KEGs_target) then {_role = "(Gunner)"};
		if(_KEGs_target == commander vehicle _KEGs_target) then {_role = "(Commander)"};
	};		
}
else
{
	_Idx_KEGS_Target = deathCam find _KEGs_target;
	if (lbValue [KEGs_cLBTargets, (lbCurSel KEGs_cLBTargets)] != KEGs_tgtIdx) then 
	{
		// Find listbox element with matching value
		for "_idx" from 0 to (lbSize KEGs_cLBTargets) do 
		{
			if(lbValue[KEGs_cLBTargets, (lbCurSel KEGs_cLBTargets)] == KEGs_tgtIdx) then 
			{
				_name = KEGs_nameCache select _idx;
				KEGs_targetName = _name;
				//_found = true;
			};
		};
	};
};

ctrlSetText[_cName, format["Focus: %1 %2", _name, _role]];	
