#define HCAM_UI_DISP (uiNamespace getVariable "hcam_ui_disp")
#define HCAM_CTRL_PIP (uiNamespace getVariable "hcam_ctrl_pip")
#define HCAM_CTRL_TITLE (uiNamespace getVariable "hcam_ctrl_title")
#define HCAM_CTRL_BACK (uiNamespace getVariable "hcam_ctrl_back")
#define HCAM_CTRL_FRONT (uiNamespace getVariable "hcam_ctrl_front")

private ["_old","_neck","_pilot","_target","_camOn","_units","_pos1","_pos2","_vx1","_vy1","_vz1","_dir","_tilt","_dive","_tz","_veh"];


if (hcam_active || isDedicated) exitWith {};


// Init
_old = "";


// Create proxies
_neck = "Sign_Sphere10cm_F" createVehicleLocal position player;
_pilot = "Sign_Sphere10cm_F" createVehicleLocal position player;
_target = "Sign_Sphere10cm_F" createVehicleLocal position player;
hideObject _neck; 
hideObject _pilot; 
hideObject _target; 
_target attachTo [_neck,[0.5,10,0]];


// Create camera ->todo
//[player,_target,player,0] call BIS_fnc_liveFeed;
hcam_cam = "camera" camCreate getPos player;
waitUntil {hcam_cam != ObjNull};
808 cutRsc ["RscHcamDialog", "PLAIN"];

HCAM_CTRL_PIP ctrlsettext "#(argb,256,256,1)r2t(rendertarget0,1.0)";

// Remember zoomed state
if (hcam_zoom == 0) then {
	HCAM_CTRL_BACK ctrlSetPosition [0.85*safezoneW+safezoneX, 0.725*safezoneH+safezoneY,0.15*safezoneW,0.11*safezoneH];
	HCAM_CTRL_PIP ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.733*safezoneH+safezoneY,0.122*safezoneW,0.095*safezoneH];
	HCAM_CTRL_TITLE ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.81*safezoneH+safezoneY,0.122*safezoneW,0.015*safezoneH];
	HCAM_CTRL_FRONT ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.733*safezoneH+safezoneY,0.122*safezoneW,0.095*safezoneH];
	
	HCAM_CTRL_BACK ctrlCommit 0;
	HCAM_CTRL_PIP ctrlCommit 0;
	HCAM_CTRL_TITLE ctrlCommit 0;
	HCAM_CTRL_FRONT ctrlCommit 0;
};



// adjust Camera offset & settings
hcam_offset = [-0.18,0.08,0.05];
hcam_cam attachTo [_neck,hcam_offset]; // ->todo: grab this from a custom config
hcam_cam camSetFov 0.6;
hcam_cam camSetTarget _target;
hcam_cam camCommit 2; // commit Changes

// add color correction
"rendertarget0" setPiPEffect [3, 1, 0.8, 1, 0.1, [0.3, 0.3, 0.3, -0.1], [1.0, 0.0, 1.0, 1.0], [0, 0, 0, 0]];


// Ready!
hcam_active = true;
_camOn = false;


// start cam-update loop
if (!isnil "hcam_cam") then
	{
		while {!isNull hcam_cam} do {	
			// destroy camera and cancel the loop if player closes the liveFeed or takes off his tactical glasses.
			if ( !( (goggles player) in hcam_goggles ) ) then {
				hcam_cam cameraEffect ["TERMINATE", "BACK"];
				_camOn = false;
				camDestroy hcam_cam;
				hcam_cam = objNull;
			} else {
			
				_units = hcam_units;
				
				// Set Target
				hcam_target = _units select hcam_id;
				//HCAM_CTRL_TITLE ctrlSetText name hcam_target;
			
				// check if the camtarget has changed and update the camera
				if (name hcam_target != _old) then {
					_neck attachTo [hcam_target,[0,0,0],"neck"];
					_pilot attachTo [hcam_target,[0,0,0],"pilot"];
					_old = name hcam_target;
					hcam_cam cameraEffect ["INTERNAL", "BACK","rendertarget0"];
					[hcamNVG] call bis_fnc_livefeedeffects;
					HCAM_CTRL_TITLE ctrlsettext (name hcam_target);
				};
			
				// check if camtarget has suitable headgear
				if ( (headgear hcam_target) in hcam_headgear || (count hcam_headgear == 0)) then {
					if (!_camOn) then {
						// Valid headgear -> Re-enable the camera
						hcam_cam cameraEffect ["INTERNAL", "BACK","rendertarget0"];
						"rendertarget0" setPiPEffect [3, 1, 0.8, 1, 0.1, [0.3, 0.3, 0.3, -0.1], [1.0, 0.0, 1.0, 1.0], [0, 0, 0, 0]];
						HCAM_CTRL_PIP ctrlsettext "#(argb,256,256,1)r2t(rendertarget0,1.0)";
						[hcamNVG] call bis_fnc_livefeedeffects;
						_camOn = true;
					};
				} else {
					if (_camOn) then {
						// No valid headgear -> Black screen
						hcam_cam cameraEffect ["TERMINATE", "BACK"];
						_camOn = false;
					};
				};

			
				if (_camOn) then {
					_veh = vehicle hcam_target;

					// check if camtarget is inside vehicle
					if (hcam_target != _veh) then {
						// Attach cam to vehicle
						_mempoints = getArray ( configfile >> "CfgVehicles" >> (typeOf _veh) >> "memoryPointDriverOptics" );
						hcam_cam attachTo [_veh,[0,0,0], _mempoints select 0];
						_target attachTo [_veh,[0,1,0], _mempoints select 0];
					} else {
						// Recalculate headposition of camtarget
						_pos1 = hcam_target worldToModel getPos _pilot;
						_pos2 = hcam_target worldToModel getPos _neck;

						_vx1 = (_pos1 select 0) - (_pos2 select 0);
						_vy1 = (_pos1 select 1) - (_pos2 select 1);
						_vz1 = (_pos1 select 2) - (_pos2 select 2);
						_dir = (_vx1 atan2 _vy1) - 25;
						// _tilt = (_vz1 atan2 _vx1) - 56.6;
						_dive = (_vy1 atan2 _vz1) + 35; 
				  
						if ((sin _dive) == 0) then {_dive = _dive +1};
						_tz = ((1 / sin _dive) * cos _dive); 	

						// Update cameraposition
						hcam_cam attachTo [_neck,hcam_offset];
						_target attachTo [_neck,[0.5,10,_tz*10]];
						_neck setDir _dir;
				  
						sleep 0.1;
					};
				} else {
					sleep 1;
				};
			};
			if (isnil "hcam_cam") then {hcam_cam = ObjNull};
		};
};
// loop ended, cleanup
808 cutFadeOut 0;
hcam_active = false;
if (!isnil "_neck") then {deleteVehicle _neck};
if (!isnil "_pilot") then {deleteVehicle _pilot};
if (!isnil "_target") then {deleteVehicle _target};