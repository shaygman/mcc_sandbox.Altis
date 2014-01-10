/*
	Open breifing map for mission wizard based on script by Author: Karel Moricky

	Description:
	Open strategic map.

	Parameter(s):
		0: ARRAY - default view position in format [x,y,y] or [x,y]
		1: ARRAY - list of missions in format:
			0: ARRAY - mission position in format [x,y,y] or [x,y]
			1: CODE - expression executed when user clicks on mission icon
			2: STRING - mission name
			3: STRING - short description
			4: STRING - name of mission's player
			5: STRING - path to overview image
			6: NUMBER - size multiplier, 1 means default size
			7: ARRAY - parameters for the -on click- code; referenced from the script as (_this select 9)
		2: NUMBER - value in range <0-1> defining weather on strategic map (i.e. density of clouds)
		3: BOOL - true for night version of strategic map (darker with blue tone)
		4: NUMBER - default map scale coeficient (1 is automatic scale)

	Returns:
	DISPLAY - RscDisplayStrategicMap
*/

#define MCCMW_briefingMap_IDD 951
#define MCC_MINIMAP 51
#define MCC_MWBriefingsTooltip_IDC 9511
#define MCC_MWBriefingText_IDC 9512

private ["_mapCenter","_missions","_ok","_markers","_images","_overcast","_scale","_defaultScale","_simulationEnabled","_colorOutside","_maxSatelliteAlpha",
         "_displayClass","_display","_playerIcon","_playerColor","_cloudTextures","_cloudsGrid","_cloudsMax","_cloudsSize","_map","_fade","_brief"];
		 
disableserialization;

if (isDedicated) exitWith {};

_mapCenter = _this select 0; 
_mapCenter = _mapCenter call bis_fnc_position;
_missions = _this select 1; 
_overcast = ([_this,2,overcast,[0]] call bis_fnc_param) max 0 min 1;
_isNight = [_this,3,false,[false]] call bis_fnc_param;
_defaultScale = [_this,4,1,[0]] call bis_fnc_param;
_brief = _this select 5; 
_simulationEnabled = true;

//--- Calculate terrain size and outside color
_mapSize = [] call bis_fnc_mapSize;
MCC_MWMap_mapSize = _mapSize;
MCC_MWMap_isNight = _isNight;

_scale = 3500 / _mapSize / safezoneH;
_scale = _scale * (_defaultScale max 0 min 1);
_maxSatelliteAlpha = if (_isNight) then {0.75} else {1};

_colorOutside = configfile >> "CfgWorlds" >> worldname >> "OutsideTerrain" >> "colorOutside";
_colorOutside = if (isarray _colorOutside) then {
	_colorOutside call bis_fnc_colorCOnfigToRGBA;
} else {
	["colorOutside param is mission in ""CfgWorlds"" >> ""%1"" >> ""OutsideTerrain""",worldname] call bis_fnc_error;
	[0,0,0,1]
};

with uinamespace do {
	MCC_MWMap_scale = _scale;
	MCC_MWMap_maxSatelliteAlpha = _maxSatelliteAlpha;

	MCC_MWMap_colorOutside_R = _colorOutside select 0;
	MCC_MWMap_colorOutside_G = _colorOutside select 1;
	MCC_MWMap_colorOutside_B = _colorOutside select 2;
};

//--- Create the control
_ok = createdialog "MCCMW_briefingMap"; 		
waituntil {_ok}; 
_display = finddisplay MCCMW_briefingMap_IDD;					
ctrlshow [MCC_MWBriefingsTooltip_IDC,false]; 


_control = (finddisplay MCCMW_briefingMap_IDD) displayCtrl MCC_MWBriefingText_IDC;
_control ctrlsetstructuredtext parsetext _brief;



//--- Life, calculations and everything
startloadingscreen ["","RscDisplayLoadingBlack"];

MCC_MWMap_player = player;

//--- Process Missions
MCC_MWMap_missions = [];
if (count _missions > 0) then {
	_playerIcon = gettext (configfile >> "CfgInGameUI" >> "IslandMap" >> "iconPlayer");
	_playerColor = (getarray (configfile >> "cfgingameui" >> "islandmap" >> "colorMe")) call BIS_fnc_colorRGBAtoHTML;

	{
		private ["_pos","_code","_title","_description","_player","_picture","_iconSize","_infoText","_codeParams"];
		_pos = [_x,0,player] call bis_fnc_paramIn;
		_pos = _pos call bis_fnc_position;

		_code = [_x,1,{},[{}]] call bis_fnc_paramIn;
		_title = [_x,2,"ERROR: MISSING TITLE",[""]] call bis_fnc_paramIn;
		_description = [_x,3,"",[""]] call bis_fnc_paramIn;
		_player = [_x,4,"",[""]] call bis_fnc_paramIn;
		_picture = [_x,5,"",[""]] call bis_fnc_paramIn;
		_iconSize = [_x,6,1,[1]] call bis_fnc_paramIn;
		_codeParams = [_x,7,[],[[]]] call bis_fnc_param;

		_infoText = format ["<t size='1' color='#a8e748'>%1</t>",_title];
		if (_player != "") then {_infoText = _infoText + format ["<br /><t size='0.2' color='#00000000'>-<br /></t><img size='1' image='%2' color='%3'/><t size='0.8'> %1</t>",_player,_playerIcon,_playerColor];};
		if (_description != "") then {_infoText = _infoText + format ["<br /><t size='0.5' color='#00000000'>-<br /></t><t size='0.8'>%1</t>",_description];};
		//if (_picture != "") then {_infoText = _infoText + format ["<br /><img size='5.55' image='%1' />",_picture];};

		MCC_MWMap_missions set [
			count MCC_MWMap_missions,
			[
				_pos,
				_code,
				_title,
				_iconSize,
				_picture,
				0,
				0,
				0,
				_infoText,
				_codeParams
			]
		];
	} foreach _missions;
};

//--- Random clouds
_cloudTextures = [
	"\A3\data_f\mrak_01_ca.paa",
	"\A3\data_f\mrak_02_ca.paa",
	"\A3\data_f\mrak_03_ca.paa",
	"\A3\data_f\mrak_04_ca.paa"
];
_cloudsGrid = 500;
_cloudsMax = (_mapSize / _cloudsGrid) * _overcast;
_cloudsSize = (_cloudsGrid / 2) + (_cloudsGrid * _overcast);
MCC_MWMap_overcast = _overcast;
MCC_MWMap_clouds = [];

for "_i" from 1 to (_cloudsMax) do {
	MCC_MWMap_clouds set [
		count MCC_MWMap_clouds,
		[
			_cloudTextures call bis_fnc_selectrandom,
			(random _mapSize),
			((_mapSize / _cloudsMax) * _i),
			random 360,
			_cloudsSize + (_cloudsSize * _overcast),
			[1,1,1,0.25]
		]
	];
};

MCC_fnc_MWMapOpen_draw = {
	_map = _this select 0;
	_mapSize = MCC_MWMap_mapSize / 2;
	_display = ctrlparent _map;
	_time = diag_ticktime;

	_mousePos = _map ctrlmapscreentoworld MC_MWMap_mousePos;
	_mouseLimit = 2.5 / safezoneh;
	_selected = [];

	//--- Cross grid
	_map drawRectangle [
		[_mapSize,_mapSize,0],
		_mapSize,
		_mapSize,
		0,
		[1,1,1,0.42],
		"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"
	];

	//--- Clouds
	_cloudSpeed = sin _time * (1138 + 2000 * MCC_MWMap_overcast);
	{
		_texture = _x select 0;
		_posX = _x select 1;
		_posY = _x select 2;
		_dir = _x select 3;
		_size = _x select 4;
		_color = _x select 5;

		_map drawIcon [
			_texture,
			_color,
			[
				_posX + _cloudSpeed,
				_posY
			],
			_size,
			_size,
			_dir + (_time * _foreachindex) / (count MCC_MWMap_clouds * 3),
			"",
			false
		];
	} foreach MCC_MWMap_clouds;

	//--- Missions
	_textureAnimPhase = abs(6 - floor (_time * 16) % 12);
	{
		_pos = _x select 0;
		_title = _x select 2;
		_size = (_x select 3) * 32;
		_dir = 0;
		_alpha = 0.75;
		_texture = format ["\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",_textureAnimPhase];

		//--- Icon is under cursor
		if ((_pos distance _mousePos) < (_mouseLimit * _size)) then {
			_size = _size * 1.2;
			_alpha = 1;
			_selected = _x;
		};

		//--- Outside of the screen area
		_mappos = _map ctrlmapworldtoscreen _pos;
		_mapposX = _mappos select 0;
		_mapposY = _mappos select 1;

		_borderLeft = 0.219271 * safezoneW + safezoneX;
		_borderRight = (0.219271 * safezoneW + safezoneX) + (0.532813 * safezoneW);
		_borderTop = 0.412034 * safezoneH + safezoneY;
		_borderBottom = (0.412034 * safezoneH + safezoneY) + (0.505803 * safezoneH);

		if (
			_mapposX < _borderLeft || _mapposX > _borderRight
			||
			_mapposY < _borderTop || _mapposY > _borderBottom
		) then {
			_texture = gettext (configfile >> "CfgInGameUI" >> "Cursor" >> "outArrow");
			_mapposX = _mapposX max (0.219271 * safezoneW + safezoneX) min ((0.219271 * safezoneW + safezoneX) + safezoneW);
			_mapposY = _mapposY max (0.412034 * safezoneH + safezoneY) min ((0.412034 * safezoneH + safezoneY) + safezoneH);
			_title = "";

			_offset = (_size / 600);
			_offsetDefX = _offset;
			_offsetDefY = _offset * 4/3;
			_offsetX = 0;
			_offsetY = 0;
			_dir = -([[0.5,0.5],_mappos] call bis_fnc_dirto) - 90;

			switch (true) do {
				case (_mapposX <= _borderLeft): {
					_offsetX = +_offsetDefX;
					_mapposY = _mapposY min (_borderBottom - _offsetDefY) max (_borderTop + _offsetDefY);
				};
				case (_mapposX >= _borderRight): {
					_offsetX = -_offsetDefX;
					_mapposY = _mapposY min (_borderBottom - _offsetDefY) max (_borderTop + _offsetDefY);
				};
				case (_mapposY <= _borderTop): {
					_offsetY = +_offsetDefY;
					_mapposX = _mapposX min (_borderRight - _offsetDefX) max (_borderLeft + _offsetDefX);
				};
				case (_mapposY >= _borderBottom): {
					_offsetY = -_offsetDefY;
					_mapposX = _mapposX min (_borderRight - _offsetDefX) max (_borderLeft + _offsetDefX);
				};
			};

			_pos = _map ctrlmapscreentoworld [
				_mapposX + _offsetX,
				_mapposY + _offsetY
			];
		};

		_map drawIcon [
			_texture,
			[1,1,1,_alpha],
			_pos,
			_size,
			_size,
			_dir,
			" " + _title,
			2,
			0.08,
			"PuristaBold"
		];
	} foreach MCC_MWMap_missions;

	//--- Night
	if (MCC_MWMap_isNight) then {
		_map drawRectangle [
			[_mapSize,_mapSize,0],
			99999,
			99999,
			0,
			[0,0.05,0.2,0.42],
			"#(argb,8,8,3)color(1,1,1,1)"
		];
	};

	//--- Tooltip
	if (count _selected > 0 && !MCC_MWMap_mouseClickDisable) then {
		switch (count _selected) do {

			//--- Mission
			case 10;
			case 9: 
			{
				[_selected,_display,MC_MWMap_mousePos] execVM MCC_path + "mcc\fnc\missionWizard\fn_MWMapTooltip.sqf";
				//[_selected,_display,MC_MWMap_mousePos] call MCC_fnc_MWMapTooltip;
			};
		};
	};
	MCC_MWMap_selected = _selected;
};

//--- Mouse click on icon
MCC_MWMap_mouseClickDisable = false;
MCC_MWMap_selected = [];
MC_MWMap_mousePos = [0,0];
MCC_MWMap_mouse = {
	MC_MWMap_mousePos = [_this select 1,_this select 2];
};

_map = _display displayctrl 51;
_map ctrlmapanimadd [0,_scale,_mapCenter];
ctrlmapanimcommit _map;
MCC_MWMap_mapCenter = _mapCenter;

_map ctrladdeventhandler ["draw","_this call MCC_fnc_MWMapOpen_draw;"];
_map ctrladdeventhandler ["mousemoving","_this call MCC_MWMap_mouse;"];
_map ctrladdeventhandler ["mouseholding","_this call MCC_MWMap_mouse;"];

if (_isNight) then {
	_map ctrlsetbackgroundcolor [0,0,0,1];
	_map ctrlcommit 0;
};

//--- Garbage collector
_display displayaddeventhandler [
	"unload",
	"
		MCC_MWMap_player = nil;
		MCC_MWMap_mapSize = nil;
		MCC_MWMap_mapCenter = nil;
		MCC_MWMap_isNight = nil;
		MCC_MWMap_missions = nil;
		MCC_fnc_MWMapOpen_draw = nil;
		MCC_MWMap_clouds = nil;
		MC_MWMap_mousePos = nil;
		MCC_MWMap_mouseClickDisable = nil;
		MCC_MWMap_selected = nil;
		
		with uinamespace do {
			MCC_MWMap_scale = nil;
			MCC_MWMap_maxSatelliteAlpha = nil;
			MCC_MWMap_colorOutside_R = nil;
			MCC_MWMap_colorOutside_G = nil;
			MCC_MWMap_colorOutside_B = nil;
		};
	"
];

cuttext ["","black in"];
endloadingscreen;

_display