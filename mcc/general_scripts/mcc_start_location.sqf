#define MCCENABLECP 1027
private ["_side","_null"];
disableSerialization;

_side = _this select 0;
if (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 21)==1) then {_side = _side + 7};
MCC_teleportAtStart = if (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 20)==1) then {false} else {true};
publicVariable "MCC_teleportAtStart";

if (mcc_missionmaker == (name player)) then {
	if !mcc_isloading then 
		{
			switch (_side) do
				{
					case 0:	//West
					{ 
						hint "click on map where you want your start location"; 
						onMapSingleClick "	
								MCC_START_WEST  = _pos;
								publicVariable ""MCC_START_WEST"";
								[[_pos, 0, 'west','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								
								[[1], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
								mcc_safe=mcc_safe + FORMAT [""
															MCC_START_WEST  = %1;
															publicVariable 'MCC_START_WEST';
															[[MCC_START_WEST, 0, 'west','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,MCC_START_WEST
															];
								hint ""Start WEST location updated.""
							";
					};
					
					case 1:	//East
					{ 
						hint "click on map where you want your start location"; 
						onMapSingleClick "	
								MCC_START_EAST  = _pos;
								publicVariable ""MCC_START_EAST"";
								[[_pos, 0, 'east','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								
								[[0], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
								mcc_safe=mcc_safe + FORMAT [""
															MCC_START_EAST  = %1;
															publicVariable 'MCC_START_EAST';
															[[_pos, 0, 'east','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,MCC_START_EAST
															];
								hint ""Start East location updated.""
							";
					};
					
					case 2:	//Guer
					{ 
						hint "click on map where you want your start location"; 
						onMapSingleClick "	
								MCC_START_GUER  = _pos;
								publicVariable ""MCC_START_GUER"";
								[[_pos, 0, 'RESISTANCE','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								
								[[2], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
								mcc_safe=mcc_safe + FORMAT [""
															MCC_START_GUER  = %1;
															publicVariable 'MCC_START_GUER';
															[[_pos, 0, 'RESISTANCE','HQ',false], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,MCC_START_GUER
															];
								hint ""Start Guer location updated.""
							";
					};
					
					case 3:	//Civ
					{ 
						hint "click on map where you want your start location"; 
						onMapSingleClick "	
								MCC_START_CIV  = _pos;
								publicVariable ""MCC_START_CIV"";
								onMapSingleClick """";
								
								[[3], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
								mcc_safe=mcc_safe + FORMAT [""
															MCC_START_CIV  = %1;
															publicVariable 'MCC_START_GUER';
															""							  
															,MCC_START_CIV
															];
								hint ""Start Guer location updated.""
							";
					};
					
					case 4:	//Disable respawn
					{ 
						MCC_TRAINING = FALSE;
						publicVariable "MCC_TRAINING";
						[["Mission started, respawn is off"],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
						MCC_enable_respawn=false;
					};
					
					case 5:	//Start on LHD
					{ 
					};
					
					case 6:	//Enable CP
					{ 
						CP_activated = missionnamespace getVariable ["CP_activated", false];
						missionnamespace setVariable ["CP_activated", !CP_activated];
						publicVariable "CP_activated";
						if (CP_activated) then
						{
							ctrlsettext [520,"Disable Roles"];
						}
						else
						{
							ctrlsettext [520,"Enable Roles"];
						};
						
						mcc_safe=mcc_safe + format ['CP_activated = %1; publicVariable "CP_activated";',CP_activated];
						if (CP_activated) then {_null=[] execVM CP_path + "scripts\player\player_init.sqf"};
					};
					
					case 7:	//FOB West
					{ 
						hint "click on map inorder to place the FOB"; 
						onMapSingleClick "	
								[[_pos, 0, 'west' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								mcc_safe=mcc_safe + FORMAT [""
															[[%1, 0, 'west' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,_pos
															];
								hint ""FOB placed.""
							";
					};
					
					case 8:	//FOB East
					{ 
						hint "click on map inorder to place the FOB"; 
						onMapSingleClick "	
								[[_pos, 0, 'east' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								mcc_safe=mcc_safe + FORMAT [""
															[[%1, 0, 'east' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,_pos
															];
								hint ""FOB placed.""
							";
					};
					
					case 9:	//FOB RESISTANCE
					{ 
						hint "click on map inorder to place the FOB"; 
						onMapSingleClick "	
								[[_pos, 0, 'RESISTANCE' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								mcc_safe=mcc_safe + FORMAT [""
															[[%1, 0, 'RESISTANCE' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,_pos
															];
								hint ""FOB placed.""
							";
					};
					
					case 10:	//FOB Civilian
					{ 
						hint "click on map inorder to place the FOB"; 
						onMapSingleClick "	
								[[_pos, 0, 'CIV' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
								onMapSingleClick """";
								mcc_safe=mcc_safe + FORMAT [""
															[[%1, 0, 'CIV' ,'FOB',true], 'CP_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
															""							  
															,_pos
															];
								hint ""FOB placed.""
							";
					};
				};
		};
} else {player globalchat "Access Denied"};
		


