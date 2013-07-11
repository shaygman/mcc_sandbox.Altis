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
			CP_respawnPointsIndex = (lbCurSel CP_respawnPointsList);
			deletemarkerlocal "spawnSelected";
			_spawnArray	 = if (side player == west) then {CP_westSpawnPoints} else {CP_eastSpawnPoints};  
			_spawn		 = _spawnArray select (lbCurSel CP_respawnPointsList);
			_pos 		 = [(getpos _spawn) select 0, (getpos _spawn) select 1];
			createMarkerLocal ["spawnSelected",_pos];	//Create group's marker
			"spawnSelected" setMarkerColorLocal "ColorBlue";
			"spawnSelected" setMarkerSizeLocal [50,50];
			"spawnSelected" setMarkerShapeLocal  "ELLIPSE";
			"spawnSelected" setMarkerBrushLocal  "SOLID";
			/*
			"spawnSelected" setMarkerTypeLocal (if (_spawn getvariable "type" == "FOB") then {"mil_triangle"} else {"mil_start"});
			"spawnSelected" setMarkerColorLocal "ColorBlue";*/
			CP_deployPanelMiniMap ctrlMapAnimAdd [0.4, 0.5, _pos];
			ctrlMapAnimCommit CP_deployPanelMiniMap;
			CP_activeSpawn = _spawn; 
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
			_safepos    =[(getpos CP_activeSpawn),1,30,1,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
			if (format["%1",_safepos] == "[-500,-500,0]" ) exitWith {player sidechat " No good position found! Try again."};
			//Spawn point found clearing not needed stuff
			detach player;
			detach CP_gearCam; 
			CP_gearCam cameraeffect ["Terminate","back"];
			player setpos _safepos;
			camDestroy CP_gearCam;
			deleteVehicle CP_gearCam;
			deleteVehicle CP_camLogic; 
			deleteVehicle CP_camBuildings; 
			deleteVehicle CP_camLight;
			setviewdistance 2500;
			closedialog 0; 
			waituntil {!dialog};
			//Respawning
			cutText ["Deploying ....","BLACK IN",5];
			closedialog 0; 
			waituntil {!dialog};
			//Remove escape event handlers and reseting menu
			CP_RESPAWNPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc];
			CP_SQUADPANEL_IDD displayRemoveEventHandler ["KeyDown", CP_disableEsc];
			deletemarkerlocal "spawnSelected";
			CP_respawnPanelOpen = false; 
			CP_groupPanelOpen	= false; 
			[CP_classes select CP_classesIndex] call CP_fnc_assignGear;			
		};
		
		case 2:				//Change role
		{ 
		 [(lbCurSel CP_respawnPanelRoleCombo),0] call CP_fnc_setGear; 
		};
	};