private [ "_idx", "_name", "_found", "_i", "_OriginalSide","_vm_refreshNumber","_inNameCache"];

//if ( KEGsRunAbort ) then {
//	diag_log format ["refresh player start: %1", KEGs_target];
//};

	RefreshListReady = false;
		
	_vm_refreshNumber = vm_count;
	// Clear and re-fill targets listbox
	lbClear KEGs_cLBTargets;

	for "_idx" from 0 to ((count deathCam)-1) do 
	{
		_x = deathCam select _idx;
		_name = "";
		
		if(alive _x) then 
		{
			// Unit is alive, use name command
			_name = name _x;
			
			_inNameCache = _x getVariable "KEG_NAME_CACHE"; 
			if (isNil "_inNameCache") then 
			{						
				KEGs_nameCache set[_idx, _name];					
				_x setVariable ["KEG_NAME_CACHE", _name];					
			};
		} 
		else 
		{
			if ( _idx < (count KEGs_nameCache) ) then 
			{
				_deadName = (KEGs_nameCache select _idx);
			};
			if !(isNil "_deadName") then 
			{
				_name = "(DEAD) " + _deadName;
			}
			else
			{
				_name = "(DEAD) *unknown*";
			};
		};
		
		_OriginalSide = _x call VM_CheckOriginalSide; 

		if (_OriginalSide in KEGsShownSides) then 
		{					
			if (isPlayer _x) then 
			{
				if ( alive _x) then 
				{ // Players 
					_i = lbAdd[KEGs_cLBTargets, _name];					
					lbSetValue[KEGs_cLBTargets, _i, _idx]; // Value used to id unit
			
					if(_OriginalSide == west) then {lbSetColor[KEGs_cLBTargets, _i, [0.8,0.8,1,1]]};
					if(_OriginalSide == east) then {lbSetColor[KEGs_cLBTargets, _i, [1,0.8,0.8,1]]};
					if(_OriginalSide == resistance) then {lbSetColor[KEGs_cLBTargets, _i, [0.8,1,0.8,1]]};
					if(_OriginalSide == civilian) then {lbSetColor[KEGs_cLBTargets, _i, [1,1,1,1]]};								
				}
				else
				{
					if !( KEGsDeadFilter ) then
					{
						// Unit is dead, change color
						_i = lbAdd[KEGs_cLBTargets, _name];	
						lbSetColor[KEGs_cLBTargets, _i, [0.5,0.5,0.5,1]];
					};
				};
			}	
			else
			{ // AI 
				if (alive _x) then 
				{
					if (!KEGsAIfilter) then 
					{
						if (!isnil "_name") then {_i = lbAdd[KEGs_cLBTargets, _name]};
						lbSetValue[KEGs_cLBTargets, _i, _idx]; // Value used to id unit
			
						if(_OriginalSide == west) then {lbSetColor[KEGs_cLBTargets, _i, [0.8,0.8,1,1]]};
						if(_OriginalSide == east) then {lbSetColor[KEGs_cLBTargets, _i, [1,0.8,0.8,1]]};
						if(_OriginalSide == resistance) then {lbSetColor[KEGs_cLBTargets, _i, [0.8,1,0.8,1]]};
						if(_OriginalSide == civilian) then {lbSetColor[KEGs_cLBTargets, _i, [1,1,1,1]]};
					};
				}
				else
				{
					if (!KEGsAIfilter && !KEGsDeadFilter ) then
					{
						// Whoops, unit is dead, change color
						//_name = "(DEAD) " + (KEGs_nameCache select _idx) ;

						//player sideChat format ["Dead unit: %1 (%2)", _x, _name];
						if (isnil "_name") then { _name = "*Unknown*"; }; 
						
						_i = lbAdd[KEGs_cLBTargets, _name];	
						lbSetColor[KEGs_cLBTargets, _i, [0.5,0.5,0.5,1]];
					};
				};
			};
		};
	};	
	
	lbSetCurSel [KEGs_cLBTargets,KEGs_tgtSelLast];
	
	KEGsNeedUpdateLB = false;
	KEGs_lastAutoUpdateLB = time;
	RefreshListReady = true;
