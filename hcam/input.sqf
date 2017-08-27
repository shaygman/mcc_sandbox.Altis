#define HCAM_UI_DISP (uiNamespace getVariable "hcam_ui_disp")
#define HCAM_CTRL_PIP (uiNamespace getVariable "hcam_ctrl_pip")
#define HCAM_CTRL_TITLE (uiNamespace getVariable "hcam_ctrl_title")
#define HCAM_CTRL_BACK (uiNamespace getVariable "hcam_ctrl_back")
#define HCAM_CTRL_FRONT (uiNamespace getVariable "hcam_ctrl_front")

private ["_key","_shift","_ctrl","_alt","_units","_hcam_key"];


_key = _this select 0;
_shift = _this select 1;
_ctrl = _this select 2;
_alt = _this select 3;
_hcam_key = actionKeys (format ["User%1",hcam_Key]);

_units = hcam_units;



// Not the key we want? End the script! T_HCAM_KEY
//if ( _key != 55 ) exitWith {};
if !( _key in _hcam_key ) exitWith {};


// ALT+KEY pressed - Turn Camera off
if ( !_shift && !_ctrl && _alt ) then {
	if (hcam_active) then {
		hcam_cam cameraEffect ["TERMINATE", "BACK"];
		camDestroy hcam_cam;
		hcam_cam = nil;
	};
};

// SHIFT+KEY pressed - Toggle size
if ( _shift && !_ctrl && !_alt ) then {
	if (hcam_active) then {
		if (hcam_zoom == 1) then {
			HCAM_CTRL_BACK ctrlSetPosition [0.85*safezoneW+safezoneX, 0.725*safezoneH+safezoneY,0.15*safezoneW,0.11*safezoneH];
			HCAM_CTRL_PIP ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.733*safezoneH+safezoneY,0.122*safezoneW,0.095*safezoneH];
			HCAM_CTRL_TITLE ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.81*safezoneH+safezoneY,0.122*safezoneW,0.015*safezoneH];
			HCAM_CTRL_FRONT ctrlSetPosition [0.8635*safezoneW+safezoneX, 0.733*safezoneH+safezoneY,0.122*safezoneW,0.095*safezoneH];

			HCAM_CTRL_BACK ctrlCommit 1;
			HCAM_CTRL_PIP ctrlCommit 1;
			HCAM_CTRL_TITLE ctrlCommit 1;
			HCAM_CTRL_FRONT ctrlCommit 1;

			hcam_zoom = 0;
		} else {
			HCAM_CTRL_BACK ctrlSetPosition [0.78*safezoneW+safezoneX, 0.67*safezoneH+safezoneY,0.22*safezoneW,0.17*safezoneH];
			HCAM_CTRL_PIP ctrlSetPosition [0.8*safezoneW+safezoneX, 0.68*safezoneH+safezoneY,0.18*safezoneW,0.15*safezoneH];
			HCAM_CTRL_TITLE ctrlSetPosition [0.8*safezoneW+safezoneX, 0.81*safezoneH+safezoneY,0.18*safezoneW,0.02*safezoneH];
			HCAM_CTRL_FRONT ctrlSetPosition [0.8*safezoneW+safezoneX, 0.68*safezoneH+safezoneY,0.18*safezoneW,0.15*safezoneH];

			HCAM_CTRL_BACK ctrlCommit 1;
			HCAM_CTRL_PIP ctrlCommit 1;
			HCAM_CTRL_TITLE ctrlCommit 1;
			HCAM_CTRL_FRONT ctrlCommit 1;

			hcam_zoom = 1;
		};
	};
};

if (! _shift && _ctrl && !_alt ) then {
	switch (hcamNVG) do
		{
			case 0:	//Regular
			{
				[1] call bis_fnc_livefeedeffects;
				hcamNVG = 1;
			};

			case 1:	//NV
			{
				[2] call bis_fnc_livefeedeffects;
				hcamNVG = 2;
			};

			case 2:	//Thermal
			{
				[0] call bis_fnc_livefeedeffects;
				hcamNVG = 0;
			};
		};
};
// KEY pressed - Switch to next groupmember
if ( !_shift && !_ctrl && !_alt ) then {

	// Is HCam already active? If not, create it.
	if (!hcam_active) then {
		nul = [] execVM (hcam_basepath + "helmetcam.sqf");
	} else {;
		// Continue only if player isnt alone in group
		if ( count _units > 1 ) then {

			// Select next groupmember (or go back to the first one)
			hcam_id = hcam_id + 1;
			if ( hcam_id >= count _units ) then {
				hcam_id = 0;
			};

			hcam_cam cameraEffect ["TERMINATE", "BACK"];

		};
	};
};