private ["_string","_logicPos","_logicEmpty","_nearObjects","_target","_nvgstate","_camLogic","_camBuildings","_camLight"];

if (!MCC_iniDBenabled) exitWIth {player sidechat "iniDB isn't running. Can't access role selection"};

//Black Screen on mission startup
cutText ["","BLACK",0.1];
// - TO DO  delete corpse and items from it.
//******************************************************************************************************************************
//											Get player levels
//******************************************************************************************************************************
waituntil {alive player};

//Get rank from the server
[["MCCplayerRank", player, "PRIVATE", "STRING"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "MCCplayerRank"};
if (CP_debug) then {player sidechat format ["player Rank : %1",MCCplayerRank]};
player setRank MCCplayerRank; 

[["officerLevel", player, CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "officerLevel"};
if (CP_debug) then {player sidechat format ["officerLevel : %1",officerLevel]};

[["arLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "arLevel"};
if (CP_debug) then {player sidechat format ["arLevel : %1",arLevel]};

[["riflemanLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "riflemanLevel"};
if (CP_debug) then {player sidechat format ["riflemanLevel : %1",riflemanLevel]};

[["ATLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "ATLevel"};
if (CP_debug) then {player sidechat format ["ATLevel : %1",ATLevel]};

[["corpsmanLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "corpsmanLevel"};
if (CP_debug) then {player sidechat format ["corpsmanLevel : %1",corpsmanLevel]};

[["marksmanLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "marksmanLevel"};
if (CP_debug) then {player sidechat format ["marksmanLevel : %1",marksmanLevel]};

[["specialistLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "specialistLevel"};
if (CP_debug) then {player sidechat format ["specialistLevel : %1",specialistLevel]};

[["crewLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "crewLevel"};
if (CP_debug) then {player sidechat format ["crewLevel : %1",crewLevel]};

[["pilotLevel", player,CP_defaultLevel, "ARRAY"], "CP_fnc_getVariable", false, false] spawn BIS_fnc_MP;
waituntil {! isnil "pilotLevel"};
if (CP_debug) then {player sidechat format ["pilotLevel : %1",pilotLevel]};

//---------------------------------------------
//		group markers
//---------------------------------------------
[] spawn {
			private ["_groups","_mkr","_mkrArray"]; 
			_mkrArray = [];
			while {alive player && MCC_groupMarkers} do	
			{
					waituntil {side player in [west, east, resistance]};
					_groups	 = switch (side player) do	
							{
								case west:			{CP_westGroups};
								case east:			{CP_eastGroups};
								case resistance:	{CP_guarGroups};
								case civilian:		{CP_guarGroups};
							};
					{
						_mkr = createMarkerLocal [(_x select 1),[(getPos leader (_x select 0) select 0),(getPos leader (_x select 0) select 1)]];
						_mkr setMarkerShapeLocal "ICON";
						(_x select 1) setMarkerTypeLocal "b_hq";
						(_x select 1) setMarkerColorLocal "ColorGreen";
						(_x select 1) setMarkerSizeLocal [0.8, 0.8];
						(_x select 1) setMarkerTextLocal (_x select 1);
						_mkrArray set [count _mkrArray ,(_x select 1)];
					} foreach _groups;
					
					sleep 6;
					{deletemarkerlocal _x} foreach _mkrArray;
					_mkrArray = [];
			};
		  };
		  
//******************************************************************************************************************************
//											Start camera
//******************************************************************************************************************************
playerDeploy = false; 

//--- Unit pos
_logicPos = [(random 1000) + 1000,(random 1000) + 1000,(random 1000) + 10000];

_logicEmpty = false;
while {!_logicEmpty} do 
{																//Check if can spawn a dummy unit
		_nearObjects = _logicPos nearObjects ["Man",50];
		if ((count _nearObjects) == 0) then {_logicEmpty = true} else {_logicPos = [_logicPos select 0,_logicPos select 1, (_logicPos select 2)-30]};
};

if (CP_debug) then {player sidechat format ["position: %1",_logicPos]};
_camLogic = createagent ["Logic",_logicPos,[],0,"none"];
_camLogic setpos _logicPos;
_camLogic setdir 180;
_camBuildings = "Land_u_Addon_01_V1_F" createvehiclelocal _logicPos; 
_camBuildings attachto [_camLogic,[3.5,4.5,0]];
_camBuildings setdir (getdir _camLogic);
_camLight = "FirePlace_burning_F" createvehiclelocal _logicPos; 
_camLight attachto [_camLogic,[1,2,0]];
//_camLight setpos [(_logicPos select 0) - 2, (_logicPos select 1) - 3,(_logicPos select 2)]; 
player attachto [_camLogic,[0,4,0]];
player setvariable ["CPCenter", _camLogic]; 

//--- Camera
setviewdistance 3;
CP_gearCamFOV = 0.15;
CP_gearCam = "camera" camcreate position _camLogic;
CP_gearCam cameraeffect ["internal", "BACK", "rendertarget7"];
CP_gearCam campreparefocus [-1,-1];
CP_gearCam camSetFov CP_gearCamFOV;
CP_gearCam camcommitprepared 0;
cameraEffectEnableHUD true;
showcinemaborder false;

//handle NV
_nvgstate = if (daytime > 19 || daytime < 5.5) then {[1]} else {[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]};
"rendertarget7" setPiPEffect _nvgstate;

//CP_gearCampos = [[0,0,1.5],12,0] call bis_fnc_relpos;
CP_gearCam attachto [_camLogic,[0.5,12,2.6],""];
player setvariable ["attachObject",_camLogic];
CP_gearCam campreparetarget _camLogic;
CP_gearCam camcommitprepared 0;
CP_gearCam camcommit 0;

player switchmove "AidlPercMstpSlowWrflDnon_G03";
sleep 0.3;

//--------------------------------------------------------------------
//	Spawn player
//--------------------------------------------------------------------
closeDialog 0;
waituntil {!dialog};
sleep 0.1;
_ok = createDialog "CP_RESPAWNPANEL";
if !(_ok) exitWith { hint "createDialog failed"; diag_log  "CP: create respawn Dialog failed";};

waituntil {playerDeploy};
//Spawn point found clearing not needed stuff
detach player;
detach CP_gearCam; 
CP_gearCam cameraeffect ["Terminate","back"];
player setpos playerDeployPos;

camDestroy CP_gearCam;
deleteVehicle CP_gearCam;
deleteVehicle _camLogic; 
deleteVehicle _camBuildings; 
deleteVehicle _camLight;
setviewdistance 2500;
closedialog 0; 
waituntil {!dialog};
//Respawning

cutText ["Deploying ....","BLACK IN",5];