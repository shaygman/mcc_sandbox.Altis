private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_camera","_startPos","_createBorder","_list","_obj","_NVGstate","_size",
         "_ctrlEHarray","_ctrlEH"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD", _disp];
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEAREA", _disp displayCtrl 2];

#define MCC_LOGISTICS_BASE_BUILD_MOUSEAREA (uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD_MOUSEAREA")

waituntil {dialog};
//Hide buttons
for "_i" from 100 to 115 do {_disp displayCtrl _i ctrlShow false};
_size = 300;

if (isnil format ["MCC_START_%1",playerSide]) exitWith {closeDialog 0; player sidechat "You must have a base to expand"};
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
//NV State
_NVGstate = if ( sunOrMoon < 0.5 ) then {true} else {false};
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_NVSTATE", _NVGstate];
camusenvg _NVGstate;

//Create borders
_createBorder =
	{
		_center = position _this;

		_oldBorder = missionnamespace getvariable "MCC_CON_border";
		if (!isnil "_oldBorder") then
		{
			{deletevehicle _x} foreach _oldBorder;
		};

		missionnamespace setvariable ["MCC_CON_border",nil];

		_border = [];

		_width = 30;

		_pi = 3.14159265358979323846;
		_perimeter = (_size * _pi);
		_perimeter = _perimeter + _width - (_perimeter % _width);
		_size = (_perimeter / _pi);
		_wallcount = _perimeter / _width * 2;
		_total = _wallcount;

		_centerObj = "VR_Area_01_circle_4_yellow_F" createvehiclelocal _center;
		_centerObj setpos _center;
		_centerObj hideObject true;
		_border = _border + [_centerObj];

		for "_i" from 1 to _total do
		{
			_dir = (360 / _total) * _i;
			_xpos = (_center select 0) + (sin _dir * _size);
			_ypos = (_center select 1) + (cos _dir * _size);
			_zpos = (_center select 2);

			_a = "Land_VR_Block_01_F" createvehiclelocal [_xpos,_ypos,_zpos];
			_a setpos [_xpos,_ypos,0];
			_a setdir (_dir + 90);
			_border = _border + [_a];
		};

		missionnamespace setvariable ["MCC_CON_border",_border];
	};

_createBorderScope = MCC_CONST_CAM call _createBorder;

//Create structures Icons
["mcc_constBaseID", "onEachFrame",
{
	disableSerialization;
	private ["_startPos","_size","_list","_type","_pos","_sizeIcon","_icon","_text"];
	_startPos 	= _this select 0;
	_size		= _this select 1;

	_list = _startPos nearEntities ["logic", _size];

	{
		_type = _x getVariable ["mcc_constructionItemType",""];
		if (_type != "") then
		{
			_pos = getpos _x;
			_sizeIcon =if ((1.5 - ((MCC_CONST_CAM distance _x)*0.0005)) < 0) then {0} else {(1.5 - ((MCC_CONST_CAM distance _x)*0.0005))};

			switch _type do
			{
				case "hq": {_icon = "n_hq"; _text ="H.Q"};
				case "storage": {_icon = "n_unknown"; _text ="Storage"};
				case "barracks": {_icon = "n_inf"; _text ="Barracks"};
				case "vehicleservice": {_icon = "n_service"; _text ="Service"};
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

_ctrlEH	=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["MouseButtonDown",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['MouseButtonDown',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray set [count _ctrlEHarray, [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["MouseButtonDown",_ctrlEH]]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["MouseButtonUp",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['MouseButtonUp',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray set [count _ctrlEHarray, [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["MouseButtonUp",_ctrlEH]]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["mousemoving",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['mousemoving',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray set [count _ctrlEHarray, [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["mousemoving",_ctrlEH]]];

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["mouseholding",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['mouseholding',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray set [count _ctrlEHarray, [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["mouseholding",_ctrlEH]]];


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

	_colorGreen = "#(argb,8,8,3)color(0,1,0,0.3,ca)";
	_colorRed = "#(argb,8,8,3)color(1,0,0,0.3,ca)";

	//--- Key DOWN
	if (_mode == "keydown") then
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
			_pos = [_camera, (((getpos _camera) select 2)/40 min 20)* _factor, getdir _camera] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Back
		if (_key in _keyBack) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 20)*_factor, (getdir _camera)-180] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Left
		if (_key in _keyLeft) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 20)*_factor, (getdir _camera)-90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Right
		if (_key in _keyRight) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/40 min 20)*_factor, (getdir _camera)+90] call BIS_fnc_relPos;
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

	if (_mode == "keyUp") then
	{
		_key = _input select 1;

		if (_key in _keysShift) then
		{
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_SHIFT",false];
		};
	};

	if (_mode == "MouseButtonUp") then
	{
		_key	= _input select 1;
		_posX 	= _input select 2;
		_posY 	= _input select 3;
		_shiftK	= _input select 4;
		_ctrlK 	= _input select 5;
		_altK	= _input select 6;

		_list = (screenToWorld [_posX,_posY]) nearEntities ["logic", 20];
		player sidechat str _list;

		if (_key == 0) then
		{
			if (count _list > 0) then
			{
				if (MCC_CONST_SELECTED != _list select 0) then
				{
					MCC_CONST_SELECTED = _list select 0;
					MCC_CONST_SELECTOR setpos (getpos MCC_CONST_SELECTED);
					MCC_CONST_SELECTOR setVectorDirAndUp [[0,0,1],[0,1,0]];
				}
			}
			else
			{
				MCC_CONST_SELECTOR setpos [0,0,0];
				MCC_CONST_SELECTED = objNull;
			};
		};
	};

	if (_mode == "MouseButtonDown") then
	{
		_key	= _input select 1;
		_posX 	= _input select 2;
		_posY 	= _input select 3;
		_shiftK	= _input select 4;
		_ctrlK 	= _input select 5;
		_altK	= _input select 6;

	};

	if (_mode == "mouseholding") then
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

			//Mouse pan left
			if ((MCC_mousePos select 0) < (_ctrlPosX + (_ctrlPosW * 0.04))) then
			{
				_pos = [_camera, (((getpos _camera) select 2)/40 min 20), (getdir _camera)-90] call BIS_fnc_relPos;
				MCC_CONST_CAM SetPos _pos;
			};

			//Mouse pan right
			if ((MCC_mousePos select 0) > (_ctrlPosX + (_ctrlPosW * 0.96))) then
			{
				_pos = [_camera, (((getpos _camera) select 2)/40 min 20), (getdir _camera)+90] call BIS_fnc_relPos;
				MCC_CONST_CAM SetPos _pos;
			};

			//Mouse pan UP
			if ((MCC_mousePos select 1) < (_ctrlPosY + (_ctrlPosH *0.04))) then
			{
				_pos = [_camera, (((getpos _camera) select 2)/40 min 20), getdir _camera] call BIS_fnc_relPos;
				MCC_CONST_CAM SetPos _pos;
			};

			//Mouse pan down
			if ((MCC_mousePos select 1) > (_ctrlPosY + (_ctrlPosH *0.96))) then
			{
				_pos = [_camera, (((getpos _camera) select 2)/40 min 20), (getdir _camera)-180] call BIS_fnc_relPos;
				MCC_CONST_CAM SetPos _pos;
			};
		};
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

//Remove the event handlers
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyDown",MCCCONSBASEKeyDown];
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyUp",MCCCONSBASEKeyUp];

//Remove controls event handlers
{(_x select 0) ctrlRemoveEventHandler (_x select 1)} foreach _ctrlEHarray;