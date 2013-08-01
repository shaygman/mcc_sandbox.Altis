private ["_cmd","_comboBox","_spawnArray","_pos","_spawn","_nearObjects","_spawnAvailable","_safepos","_targets","_target"];
disableSerialization;

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")

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
		
		case 1:				//Deploy pressed
		{ 
			//Check if alive
			if (!alive CP_activeSpawn) exitWith {player sidechat "Spawn Point has been destroyed, select another spawn point."};
			
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
			CP_groupPanelOpen	= false; 
			
		};
		
		case 2:				//Change role
		{ 
		 [(lbCurSel CP_respawnPanelRoleCombo),0] call CP_fnc_setGear; 
		};
	};