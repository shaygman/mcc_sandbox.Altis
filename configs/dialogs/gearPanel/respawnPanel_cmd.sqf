private ["_cmd","_comboBox","_spawnArray","_pos","_spawn","_nearObjects","_spawnAvailable","_safepos","_targets","_target","_groups","_deployAvailable"
		,"_countRole","_roleLimit"];
disableSerialization;

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")

_cmd = _this select 0; 

switch (_cmd) do
	{
		case 0:				//LBL change on respawn marker
		{ 
			_spawnArray	 = switch (side player) do	{
					case west:			{CP_westSpawnPoints};
					case east:			{CP_eastSpawnPoints};
					case resistance:	{CP_guarSpawnPoints};
				};
			deletemarkerlocal "spawnSelected";
			
			if (count _spawnArray > 0) then {
				CP_respawnPointsIndex = (lbCurSel CP_respawnPointsList);
				_spawn	 = _spawnArray select (lbCurSel CP_respawnPointsList);
				_pos 		 = [(getpos _spawn) select 0, (getpos _spawn) select 1];
				createMarkerLocal ["spawnSelected",_pos];	//Create group's marker
				"spawnSelected" setMarkerColorLocal "ColorBlue";
				"spawnSelected" setMarkerSizeLocal [50,50];
				"spawnSelected" setMarkerShapeLocal  "ELLIPSE";
				"spawnSelected" setMarkerBrushLocal  "SOLID";
				CP_deployPanelMiniMap ctrlMapAnimAdd [0.4, 0.5, _pos];
				ctrlMapAnimCommit CP_deployPanelMiniMap;
				CP_activeSpawn = _spawn; 
				} else {CP_activeSpawn = objnull};
		};
		
		case 1:				//==================================================Deploy pressed============================================================
		{ 
			//Check if alive
			if (!alive CP_activeSpawn) exitWith {player sidechat "Spawn Point has been destroyed, select another spawn point."};
			
			//Check if player assigned to group
			_groups	 = switch (side player) do	{
								case west:			{CP_westGroups};
								case east:			{CP_eastGroups};
								case resistance:	{CP_guarGroups};
								case civilian:		{CP_guarGroups};
							};
			_deployAvailable = false; 				
			for [{_i=0},{_i < count _groups},{_i=_i+1}] do {
				if ((group player) == (_groups select _i) select 0) then {_deployAvailable = true}; 
			};
			if (!_deployAvailable) exitWith {player sidechat "You must join a group first."};
			
			//Check for roles 
			_countRole 			= 0;
			_minPlayersForRole	= 0;
			_roleLimit			= 1;
			switch (lbCurSel CP_respawnPanelRoleCombo) do	{
								case 0:				{				//officer 
														{
															if ((_x getvariable "CP_role") == "Officer") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_officerPerGroup;
														_minPlayersForRole 	= CP_officerMinPlayersInGroup;
													};	
													
								case 1:				{				//AR 
														{
															if ((_x getvariable "CP_role") == "AR") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_ARPerGroup;
														_minPlayersForRole 	= CP_ARMinPlayersInGroup;
													};
													
								case 2:				{				//Rifleman
														{
															if ((_x getvariable "CP_role") == "Rifleman") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_riflemanPerGroup;
														_minPlayersForRole 	= CP_riflemanMinPlayersInGroup;
													};	

								case 3:				{				//AT
														{
															if ((_x getvariable "CP_role") == "AT") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_ATPerGroup;
														_minPlayersForRole 	= CP_ATMinPlayersInGroup;
													};
													
								case 4:				{				//Corpsman
														{
															if ((_x getvariable "CP_role") == "Corpsman") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_CorpsmanPerGroup;
														_minPlayersForRole 	= CP_CorpsmanMinPlayersInGroup;
													};
													
								case 5:				{				//Marksman
														{
															if ((_x getvariable "CP_role") == "Marksman") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_MarksmanPerGroup;
														_minPlayersForRole 	= CP_MarksmanMinPlayersInGroup;
													};
													
								case 6:				{				//Specialist
														{
															if ((_x getvariable "CP_role") == "Specialist") then {_countRole = _countRole +1};
														} foreach units (group player); 
														_roleLimit 			= CP_SpecialistPerGroup;
														_minPlayersForRole 	= CP_SpecialistMinPlayersInGroup;
													};
							};
			
			if (_countRole > _roleLimit) exitWith {player sidechat "All kit's have been taken! Choose another kit."}; 
			if (count (units (group player)) < _minPlayersForRole) exitWith {player sidechat format ["You need %1 players in your squad to use this kit! Choose another kit.",_minPlayersForRole]};
			
			//Check if no enemy is close by
			_spawnAvailable = true;
			_targets = ["Car","Tank","Man"]; 
			_nearObjects = (getpos CP_activeSpawn) nearObjects 100;
			if ((count _nearObjects) > 0) then {
								{
									_target = _x; 
									{
										if ((_target isKindOf _x) && (side _target != civilian) && (side _target !=side player)) then {_spawnAvailable = false};
									} foreach _targets; 
								} foreach _nearObjects;
							};
			if (!_spawnAvailable) exitWith {player sidechat "Spawn Point is being overrun, select another spawn point."};
			
			//looking for a spawn point
			playerDeployPos    =[(getpos CP_activeSpawn),1,30,1,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
			if (format["%1",playerDeployPos] == "[-500,-500,0]" ) exitWith {player sidechat " No good position found! Try again."};
			playerDeploy = true;
			
			//Remove escape event handlers and reseting menu
			if (!isnil "CP_RESPAWNPANEL_IDD") then {CP_RESPAWNPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			if (!isnil "CP_SQUADPANEL_IDD") then {CP_SQUADPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			if (!isnil "CP_GEARPANEL_IDD") then {CP_GEARPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			if (!isnil "CP_WEAPONSPANEL_IDD") then {CP_WEAPONSPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			if (!isnil "CP_ACCESPANEL_IDD") then {CP_ACCESPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			if (!isnil "CP_UNIFORMSPANEL_IDD") then {CP_UNIFORMSPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc]};
			deletemarkerlocal "spawnSelected";
			CP_respawnPanelOpen = false; 
		};
		
		case 2:				//Change role
		{ 
		[(lbCurSel CP_respawnPanelRoleCombo),0] call CP_fnc_setGear; 
		[CP_gearPanelPiP] call MCC_fnc_pipOpen;
		CP_gearPanelPiP ctrlSetText "#(argb,512,512,1)r2t(rendertarget7,1.0);";
		};
	};