#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018
#define MCCENABLECP 1027

private ["_side","_null"];

_side = _this select 0;

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
								
								[[], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
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
								
								[[], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
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
								
								[[], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
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
								
								[[], 'MCC_fnc_startLocations', true, false] spawn BIS_fnc_MP;
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
						CP_activated = true;
						publicVariable "CP_activated";
						ctrlEnable [MCCENABLECP,false];
						mcc_safe=mcc_safe + 'CP_activated = true; publicVariable "CP_activated";';
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
				};
			closeDialog 0;
			_null = [] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";
		};
} else {player globalchat "Access Denied"};
		


