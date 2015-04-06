private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_camera","_startPos","_list","_obj","_NVGstate","_size",
         "_ctrlEHarray","_ctrlEH"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD", _disp];
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEAREA", _disp displayCtrl 2];

#define MCC_LOGISTICS_BASE_BUILD_MOUSEAREA (uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD_MOUSEAREA")

//test
MCC_fnc_baseSelected =  compile (preprocessFileLineNumbers (MCC_path +"mcc\fnc\rts\fn_baseSelected.sqf"));


waituntil {dialog};
_size = 200;
player setVariable ["MCC_baseSize",_size];

if (isnil format ["MCC_START_%1",playerSide]) exitWith {closeDialog 0; systemchat "You must have a base to expand"};
_startPos = call compile format ["MCC_START_%1",playerSide];

if (isnil "MCC_CONST_CAM") then
{
	_camera = "camCurator" camcreate [_startPos select 0, _startPos select 1,(_startPos select 2) +200];
	//_camera = "camconstruct" camcreate [_pos select 0, _pos select 1,((getpos player) select 2) +15];
	_camera cameraeffect ["internal","back"];
	_camera camPrepareFOV 0.900;
	_camera campreparefocus [-1,-1];
	_camera camCommitPrepared 0;
	cameraEffectEnableHUD true;
	_camera setdir 0;
	[_camera,-90,0] call BIS_fnc_setPitchBank;
	_camera camCommitPrepared 0;

	_camera camConstuctionSetParams ([_startPos]+[_size,100]);

	MCC_CONST_CAM = _camera;
};

//Create Selector
if (isnil "MCC_CONST_SELECTOR") then
{
	MCC_CONST_SELECTOR = "Sign_Circle_F" createVehicleLocal [0,0,0];
};

//Selected
MCC_CONST_SELECTED = objnull;
MCC_CONST_PLACEHOLDER = objnull;

//NV State
_NVGstate = if ( sunOrMoon < 0.5 ) then {true} else {false};
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_NVSTATE", _NVGstate];
camusenvg _NVGstate;

//Loop while open
[_startPos,_size] spawn
{
	private ["_startPos","_size","_buildings","_cargoSpace","_value","_ctrl","_units"];
	_startPos = _this select 0;
	_size = _this select 1;

	disableSerialization;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	//Load available resources
	_array = call compile format ["MCC_res%1",playerside];
	while {(str (_disp displayCtrl 2) != "No control")} do
	{
		//get number of storage
		_buildings = _startPos nearEntities [["logic"], _size];
		_cargoSpace = 500;
		_units = 0;
		{
			if ((_x getVariable ["mcc_constructionItemType",""]) == "storage" && !(isNull attachedTo _x)) then
			{
				_cargoSpace = _cargoSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*500);
			};

			if ((_x getVariable ["mcc_constructionItemType",""]) == "barracks" && !(isNull attachedTo _x)) then
			{
				_units = _units + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*4);
			};
		} foreach _buildings;



		{
			_value = floor (_array select _forEachIndex);
			_ctrl = _disp displayCtrl _x;
			_ctrl ctrlSetText format ["%1/%2",_value,_cargoSpace];
			if (_value <= 200) then
			{
				_ctrl ctrlSetTextColor [1,0,0,0.8];
			}
			else
			{
				_ctrl ctrlSetTextColor [1,1,1,0.8];
			};
		} foreach [81,82,83,84,85];

		//units
		(_disp displayCtrl 86) ctrlSetText str _units;

		//Loop for reseting UI if the object we are watching died
		if (isnull MCC_CONST_SELECTED) then
		{
			[_startPos,player getVariable ["MCC_baseSize",300]] call MCC_fnc_baseOpenConstMenu;
		};
		sleep 0.5;
	};
};

//open construction menu
[_startPos, _size*2] call MCC_fnc_baseOpenConstMenu;

//Create borders
_createBorderScope = [MCC_CONST_CAM,_size] call MCC_fnc_baseBuildBorders;

//Create structures Icons
["mcc_constBaseID", "onEachFrame",
{
	disableSerialization;
	private ["_startPos","_size","_list","_type","_pos","_sizeIcon","_icon","_text","_cfgName","_endTime","_segmentsElapsed","_startTime"];
	_startPos 	= _this select 0;
	_size		= _this select 1;

	_list = _startPos nearEntities ["logic", _size];

	{
		_type = _x getVariable ["mcc_constructionItemType",""];

		if (_type != "") then
		{
			_pos = getpos _x;
			_sizeIcon =if ((1.5 - ((MCC_CONST_CAM distance _x)*0.0005)) < 0) then {0} else {(1.5 - ((MCC_CONST_CAM distance _x)*0.0005))};

			_endTime = _x getVariable ["mcc_constructionendTime",30];
			_startTime = _x getVariable ["mcc_constructionStartTime",time];
			_cfgName 	= format ["MCC_rts_%1%2",_type,(_x getVariable ["mcc_constructionItemTypeLevel",1])];

			if ((_startTime+_endTime) > time) then
			{
				_text = "";
				_segmentsElapsed = round((time -_startTime)/_endTime * 20);
				for "_i" from 1 to _segmentsElapsed do
				{
					_text = _text + "|";
				};

			}
			else
			{
				_text =if (MCC_isMode) then
					{
						 getText (configFile >> "cfgRtsBuildings" >> _cfgName >> "displayName");
					}
					else
					{
						 getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "displayName");
					};
			};
			switch (tolower _type) do
			{
				case "hq": {_icon = "n_hq"};
				case "storage": {_icon = "n_unknown"};
				case "barracks": {_icon = "n_inf"};
				case "workshop": {_icon = "n_service"};
			};

			if (!isnil "_icon") then
			{
				_texture = gettext (configfile >> "CfgMarkers" >> _icon >> "icon");

				drawIcon3D [
								_texture,
								[0,0,0.6,0.6],
								[_pos select 0, _pos select 1,(_pos select 2)+ 10],
								_sizeIcon,
								_sizeIcon,
								0,
								_text
							];
			};
		};
	} foreach _list;

},[_startPos,_size]] call BIS_fnc_addStackedEventHandler;



MCCCONSBASEKeyDown			=	(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayAddEventHandler  ["KeyDown",		"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['keydown',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
MCCCONSBASEKeyUP			=	(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayAddEventHandler  ["KeyUp",		"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['KeyUp',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];


//Add controls event handlers
_ctrlEHarray = [];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["MouseButtonDown",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['MouseButtonDown',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray pushback [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["MouseButtonDown",_ctrlEH]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["MouseButtonUp",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['MouseButtonUp',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray pushback [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["MouseButtonUp",_ctrlEH]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["mousemoving",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['mousemoving',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray pushback [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["mousemoving",_ctrlEH]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["mouseholding",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['mouseholding',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray pushback [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["mouseholding",_ctrlEH]];


MCC_CONST_CAM_Handler =
{
	private ["_mode","_input","_camera","_terminate","_keysCancel","_keysUpObj","_keysDownObj","_keysUp","_keysDown","_keysShift","_keysBanned","_keyNightVision",
	         "_keyplace","_keyalt","_keydelete","_keyGUI","_colorGreen","_colorRed","_NVGstate","_keyForward","_keyBack","_keyLeft","_keyRight","_pos","_factor",
			 "_keyUp","_keyDown","_posX","_posY","_shiftK","_ctrlK","_altK","_disp"];
	disableSerialization;

	_mode = _this select 0;
	_input = _this select 1;

	_disp = uinamespace getVariable "MCC_LOGISTICS_BASE_BUILD";
	if (! isnil "MCC_CONST_CAM") then {_camera = MCC_CONST_CAM};

	_terminate = false;

	_keysCancel		= actionKeys "MenuBack";
	_keysUpObj		= [45];
	_keysDownObj	= [46];
	_keysUp			= actionKeys "nextAction";
	_keysDown		= actionKeys "prevAction";
	_keysShift		= [42];
	_keysBanned		= [1,15];
	_keyNightVision	= actionKeys "NightVision";
	_keyplace 		= [57];
	_keyalt 		= [56];
	_keydelete 		= [211];
	_keyGUI			= [35];
	_keyForward		= actionKeys "CarForward";
	_keyBack		= actionKeys "CarBack";
	_keyLeft		= actionKeys "CarLeft";
	_keyRight		= actionKeys "CarRight";
	_keyUp			= actionKeys "HeliRudderLeft";
	_keyDown		= actionKeys "HeliDown";

	//--- Key DOWN
	if (_mode == "keydown") exitWith
	{
		_key = _input select 1;
		_factor = if (uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_SHIFT",false]) then {3} else {1};

		if (_key in _keysShift) then
		{
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_SHIFT",true];
		};

		//--- Terminate
		if (_key in _keysBanned) then {_terminate = true};

		//--- Start NVG
		if (_key in _keyNightVision) then
		{
			playSound "nvSound";
			_NVGstate = !(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_NVSTATE", false]);
			camusenvg _NVGstate;
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_NVSTATE", _NVGstate];
		};

		//--- Forward
		if (_key in _keyForward) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 40)* _factor, getdir _camera] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Back
		if (_key in _keyBack) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 40)*_factor, (getdir _camera)-180] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Left
		if (_key in _keyLeft) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 40)*_factor, (getdir _camera)-90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Right
		if (_key in _keyRight) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 40)*_factor, (getdir _camera)+90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Up
		if (_key in _keyUp) then
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, (_pos select 2) + (((getpos _camera) select 2)/20 min 10)*_factor];
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Down
		if (_key in _keyDown) then
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, (_pos select 2) -(((getpos _camera) select 2)/20 min 10)*_factor];
			MCC_CONST_CAM SetPos _pos;
		};
	};

	if (_mode == "keyUp") exitWith
	{
		_key = _input select 1;

		if (_key in _keysShift) then
		{
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_SHIFT",false];
		};
	};

	if (_mode == "MouseButtonUp") exitWith
	{
		_key	= _input select 1;
		_posX 	= _input select 2;
		_posY 	= _input select 3;
		_shiftK	= _input select 4;
		_ctrlK 	= _input select 5;
		_altK	= _input select 6;
		uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWN",false];


		if (_key == 0) exitWith
		{
			_list = ((screenToWorld [_posX,_posY]) nearObjects ["LandVehicle", 20]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["Ship", 20]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["Air", 20]);
			for "_i" from 0 to (count _list)-1 do {if !(isNull attachedTo (_list select _i)) then {_list set [_i, -1]}};
			_list = _list - [-1];
			_list = _list + ((screenToWorld [_posX,_posY]) nearEntities ["logic", 20]);
			_list = [_list,[],{(screenToWorld [_posX,_posY]) distance _x},"ASCEND"] call BIS_fnc_sortBy;
			if (count _list > 0) then
			{
				if (MCC_CONST_SELECTED != _list select 0) then
				{
					MCC_CONST_SELECTED = _list select 0;
					[MCC_CONST_SELECTED] spawn MCC_fnc_baseSelected;
					MCC_CONST_SELECTOR setpos (getpos MCC_CONST_SELECTED);
					MCC_CONST_SELECTOR setpos (getpos MCC_CONST_SELECTED);
					MCC_CONST_SELECTOR setVectorDirAndUp [[0,0,1],[0,1,0]];
				}
			}
			else
			{
				MCC_CONST_SELECTOR setpos [0,0,0];
				MCC_CONST_SELECTED = objNull;
				[[0]] spawn MCC_fnc_baseActionExit;
			};

			//Build
			if (!isnull MCC_CONST_PLACEHOLDER && !isnil "MCC_canSpawn3DConst") then
			{
				if (!MCC_canSpawn3DConst) exitWith {};

				//get cfg
				_cfgName = MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingToBuild",[]];
				_buildArray = (MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingToBuild",[]]);
				_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "resources");

				[_res] spawn MCC_fnc_baseResourceReduce;

				//[getpos MCC_CONST_PLACEHOLDER, getdir MCC_CONST_PLACEHOLDER ,_buildArray, 1, playerside] execVM "mcc\fnc\mp\fn_construct_base.sqf";
				player globalRadio "SentAssemble";
				[[getpos MCC_CONST_PLACEHOLDER, getdir MCC_CONST_PLACEHOLDER ,(MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingToBuild",""]), 1, playerside],"MCC_fnc_construct_base",false] call bis_fnc_MP;

				deleteVehicle MCC_CONST_PLACEHOLDER;
				MCC_CONST_PLACEHOLDER = objnull;
			};
		};

		if (_key == 1) exitWith
		{
			//Cancel Build
			if (!isnull MCC_CONST_PLACEHOLDER) then
			{
				deleteVehicle MCC_CONST_PLACEHOLDER;
				MCC_CONST_PLACEHOLDER = objnull;
			};
		};
	};

	if (_mode == "MouseButtonDown") exitWith
	{
		_key	= _input select 1;
		_posX 	= _input select 2;
		_posY 	= _input select 3;
		_shiftK	= _input select 4;
		_ctrlK 	= _input select 5;
		_altK	= _input select 6;
		uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWN",true];

	};

	if (_mode in ["mouseholding","mousemoving"]) exitWith
	{
		_ctrl 	= _input select 0;
		_posX 	= _input select 1;
		_posY 	= _input select 2;

		if (!isnil "MCC_mousePos") then
		{
			_ctrlPos 	= ctrlPosition _ctrl;
			_ctrlPosX 	= _ctrlPos select 0;
			_ctrlPosY 	= _ctrlPos select 1;
			_ctrlPosW 	= _ctrlPos select 2;
			_ctrlPosH 	= _ctrlPos select 3;

			if (!isnull MCC_CONST_PLACEHOLDER) then
			{
				if (uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWN",false]) exitWith
				{
					MCC_CONST_PLACEHOLDER setDir (getdir MCC_CONST_PLACEHOLDER - (_posX - ((uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEXY",[_posX,_posY]]) select 0))*(player getVariable ["MCC_baseSize",300]));
				};

				_pos = screenToWorld [_posX,_posY];

				MCC_CONST_PLACEHOLDER setpos _pos;

				//--- No Place To Build
				_isFlat = _pos isflatempty [
					(sizeof typeof MCC_CONST_PLACEHOLDER)*0.8,	//--- Minimal distance from another object
					0,				//--- If 0, just check position. If >0, select new one
					0.9,				//--- Max gradient
					(sizeof typeof MCC_CONST_PLACEHOLDER),	//--- Gradient area
					0,				//--- 0 for restricted water, 2 for required water,
					false,				//--- True if some water can be in 25m radius
					MCC_CONST_PLACEHOLDER			//--- Ignored object
				];

				_center = (missionnamespace getvariable ["MCC_CON_border",[]]) select 0;

				_colorGreen = "#(argb,8,8,3)color(0,1,0,0.3,ca)";
				_colorRed = "#(argb,8,8,3)color(1,0,0,0.3,ca)";
				_color = "#(argb,8,8,3)color(1,0,0,0.3,ca)";

				if ((count _isFlat == 0) || (([position MCC_CONST_PLACEHOLDER,_center] call BIS_fnc_distance2D) > (player getVariable ["MCC_baseSize",300]))) then
				{
					_color = _colorRed;
					MCC_canSpawn3DConst = false;
				}
				else
				{
					_color = _colorGreen;
					MCC_canSpawn3DConst = true;
				};

				{MCC_CONST_PLACEHOLDER setObjectTexture [_x,_color]} foreach [0,1,2];
			};

			if (_mode =="mouseholding") then
			{
				//Mouse pan left
				if ((MCC_mousePos select 0) < (_ctrlPosX + (_ctrlPosW * 0.04))) then
				{
					_pos = [_camera, (((getpos _camera) select 2)/40 min 40), (getdir _camera)-90] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan right
				if ((MCC_mousePos select 0) > (_ctrlPosX + (_ctrlPosW * 0.96))) then
				{
					_pos = [_camera, (((getpos _camera) select 2)/40 min 40), (getdir _camera)+90] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan UP
				if ((MCC_mousePos select 1) < (_ctrlPosY + (_ctrlPosH *0.1))) then
				{
					_pos = [_camera, (((getpos _camera) select 2)/40 min 40), getdir _camera] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan down
				if ((MCC_mousePos select 1) > (_ctrlPosY + (_ctrlPosH *0.98))) then
				{
					_pos = [_camera, (((getpos _camera) select 2)/40 min 40), (getdir _camera)-180] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};
			};
		};

		uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEXY",[_posX,_posY]];
	};
};
//Clean up
waituntil {!dialog};

["mcc_constBaseID", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

//Clean Camera
if !(isnil "MCC_CONST_CAM") then {MCC_CONST_CAM cameraeffect ["terminate","back"];camdestroy MCC_CONST_CAM;};
MCC_CONST_CAM = nil;

//Clear borders
_border = missionnamespace getvariable ["MCC_CON_border",[]];
{deletevehicle _x} foreach _border;
missionnamespace setvariable ["MCC_CON_border",nil];

//Clear Selector
if (!isnil "MCC_CONST_SELECTOR") then {deleteVehicle MCC_CONST_SELECTOR; MCC_CONST_SELECTOR = nil};
if (!isnil "MCC_CONST_PLACEHOLDER") then {deleteVehicle MCC_CONST_PLACEHOLDER; MCC_CONST_PLACEHOLDER = objnull};

//Remove the event handlers
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyDown",MCCCONSBASEKeyDown];
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyUp",MCCCONSBASEKeyUp];

//Remove controls event handlers
{(_x select 0) ctrlRemoveEventHandler (_x select 1)} foreach _ctrlEHarray;