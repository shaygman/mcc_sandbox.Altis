/*
	MCC_fnc_MWopenBriefing
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

private ["_mapCenter","_missions","_ok","_markers","_images","_overcast","_scale","_defaultScale","_simulationEnabled","_colorOutside","_maxSatelliteAlpha","_displayClass","_display","_playerIcon","_playerColor","_cloudTextures","_cloudsGrid","_cloudsMax","_cloudsSize","_map","_fade","_brief","_sounds","_music","_plainText","_playMusic","_preciseMarkers"];

disableserialization;

if (isDedicated) exitWith {};

_mapCenter 			= _this select 0;
_missions 			= _this select 1;
_defaultScale 		= _this select 2;
_brief 				= _this select 3;
_sounds				= param [4, [], [[]]];
_music				= param [5, "", [""]];
_plainText			= param [6, [], [[]]];
_playMusic 			=  param [8, 0,[0]];
_preciseMarkers		=  param [9, false,[false]];

_mapCenter 			= _mapCenter call bis_fnc_position;
_overcast 			= overcast;
_isNight 			= if ((date select 3)>19 || (date select 3)<6) then {true} else {false};

if (count _this <=0 || (vehicle player != player && driver vehicle player == player && vehicle player isKindOf "air")) exitWith {};

_simulationEnabled = true;
waituntil {((player getVariable ["cpReady",true]) && !(player getvariable ["MCC_medicUnconscious",false]))};
waituntil {!dialog};

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


//Cinematic
if (_playMusic == 0) then {
	private ["_module","_object","_taskDescription","_sfx","_zoomEnd","_specialIntro","_units"];

		_object = ((((missionNamespace getVariable format ["MCC_missionsInfo_%1", side player]) select 1) select 0) select 8);

		//Do we have a sky intro
		_units = (getpos _object) nearEntities [["Man", "Air", "Car", "Tank"], 1000];
		for "_i" from 0 to (count _units)-1 step 1 do {
			if (side (_units select _i) in [side player, sideLogic, civilian]) then {
				_units set [_i,-1];
			}
		};
		_units = _units - [-1];
		_sfx =  if (_isNight) then {"nv"} else {"none"};


		//First scene
		_specialIntro = switch (true) do
							{
								case (overcast > 0.2 && random 1 < 0.3): {"sky"};
								case (count _units > 3  && random 1 < 0.3): {_units};
								default	{"uav"};
							};

		//make a scene
		[_object,"",_sfx,0.3,0.3,10,1,_specialIntro,_sounds,_music,_plainText] call MCC_fnc_movieMaker;

	//If precise markers then show the objectives locations
	if (_preciseMarkers) then {
		{
			_module = (_x select 8);
			_object = if !(isnull (_module getVariable ["AttachObject_object",objNull])) then {_module getVariable ["AttachObject_object",objNull]} else {_module};
			_taskDescription = _x select 3;
			_zoomEnd = if (_object isKindOf "man") then {0.6} else {0.3};

			_sfx =  switch (true) do
					{
						case (_isNight && _object isKindOf "man"): 	{"ti"};
						case (_isNight): 	{"nv"};
						default	{"none"};
					};

			//make a scene
			[_object,_taskDescription,_sfx,0.3,_zoomEnd,10,1,"none",[],"",""] call MCC_fnc_movieMaker;
		} foreach ((missionNamespace getVariable format ["MCC_missionsInfo_%1", side player]) select 1);
	};
};


with uinamespace do {
	MCC_MWMap_scale = _scale;
	MCC_MWMap_maxSatelliteAlpha = _maxSatelliteAlpha;

	MCC_MWMap_colorOutside_R = _colorOutside select 0;
	MCC_MWMap_colorOutside_G = _colorOutside select 1;
	MCC_MWMap_colorOutside_B = _colorOutside select 2;
};

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
		if (_picture != "") then {_infoText = _infoText + format ["<br /><img size='5.55' image='%1' />",_picture];};

		MCC_MWMap_missions pushBack
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
			];


	} foreach _missions;
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
				//[_selected,_display,MC_MWMap_mousePos] execVM MCC_path + "mcc\missionWizard\fnc\fn_MWMapTooltip.sqf";
				[_selected,_display,MC_MWMap_mousePos] spawn MCC_fnc_MWMapTooltip;
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

if (_isNight) then
{
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
ctrlsetfocus (_display displayctrl MCC_MINIMAP);

//stop music
0 spawn {sleep 10; waitUntil {!dialog}; playMusic ""};

_display