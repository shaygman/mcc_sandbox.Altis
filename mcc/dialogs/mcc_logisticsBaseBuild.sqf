private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_camera","_startPos","_createBorder","_list","_obj","_NVGstate","_size"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD", _disp];

waituntil {dialog};
//Hide buttons
for "_i" from 100 to 115 do {_disp displayCtrl _i ctrlShow false};
_size = 150;

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
_list = _startPos nearEntities ["logic", _size];
player sidechat str _list; 
for "_i" from 0 to (count _list-1) do 
{
	_obj = _list select _i;
	if ((_obj getVariable ["mcc_constructionItemType",""]) == "") then {_list set [_i,-1]};
};
_list = _list - [-1];
player sidechat str _list; 
["mcc_constBaseID", "onEachFrame", 
{
	disableSerialization;
	
	_list = _this;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	{
		_ctrl = _disp displayCtrl (_foreachIndex+100); 

		_pos = worldToScreen getpos _x;
		if (count _pos > 0) then
		{
			_ctrl ctrlSetPosition [_pos select 0,_pos select 1,0.1,0.1];	
			_ctrl ctrlShow true;
			_ctrl ctrlCommit 0;
		};
	} foreach _list;

},_list] call BIS_fnc_addStackedEventHandler;



MCCCONSBASEKeyDown			=	(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayAddEventHandler  ["KeyDown",		"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['keydown',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
MCCCONSBASEKeyUP			=	(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayAddEventHandler  ["KeyUp",		"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['KeyUp',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];


MCC_CONST_CAM_Handler =
{
	private ["_mode","_input","_camera","_terminate","_keysCancel","_keysUpObj","_keysDownObj","_keysUp","_keysDown","_keysShift","_keysBanned","_keyNightVision",
	         "_keyplace","_keyalt","_keydelete","_keyGUI","_colorGreen","_colorRed","_NVGstate","_keyForward","_keyBack","_keyLeft","_keyRight","_pos","_factor",
			 "_keyUp","_keyDown"];
	_mode = _this select 0;
	_input = _this select 1;
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
		
		if (_key in _keysShift) then
		{
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",3];
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
			
			_pos = [_camera, (((getpos _camera) select 2)/20 min 20)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1]), getdir _camera] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};
		
		//--- Back
		if (_key in _keyBack) then 
		{
			_pos = [_camera, (((getpos _camera) select 2)/20 min 20)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1]), (getdir _camera)-180] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};
		
		//--- Left
		if (_key in _keyLeft) then 
		{
			_pos = [_camera, (((getpos _camera) select 2)/20 min 20)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1]), (getdir _camera)-90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};
		
		//--- Right
		if (_key in _keyRight) then 
		{
			_pos = [_camera, (((getpos _camera) select 2)/20 min 20)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1]), (getdir _camera)+90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};
		
		//--- Up
		if (_key in _keyUp) then 
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, (_pos select 2) + (((getpos _camera) select 2)/20 min 10)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1])];			
			MCC_CONST_CAM SetPos _pos;
		};
		
		//--- Down
		if (_key in _keyDown) then 
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, (_pos select 2) -(((getpos _camera) select 2)/20 min 10)*(uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1])];
			MCC_CONST_CAM SetPos _pos;
		};
	};
	
	if (_mode == "keyUp") then
	{
		_key = _input select 1;
		
		if (_key in _keysShift) then
		{
			uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_FACTOR",1];
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

//Remove the event handlers
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyDown",MCCCONSBASEKeyDown];
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyUp",MCCCONSBASEKeyUp];

/*
_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_LOAD_TRUCK", _disp];
uiNamespace setVariable ["MCC_loadTruckC1", _disp displayCtrl 0];

uiNamespace setVariable ["MCC_loadTruckSupplies", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_loadTruckRepair", _disp displayCtrl 2];
uiNamespace setVariable ["MCC_loadTruckFuel", _disp displayCtrl 3];

uiNamespace setVariable ["MCC_loadTruckOutpot", _disp displayCtrl 4];
uiNamespace setVariable ["MCC_loadTruckOutpot2", _disp displayCtrl 5];
uiNamespace setVariable ["MCC_loadTruckOutpot3", _disp displayCtrl 6];
#define CRATE_COST 100
#define ANCHOR_POINT_WEST [0,-0.2,0]
#define ANCHOR_POINT_EAST [0,-0.9,0]
#define ANCHOR_POINT_GUER [0,+0.5,0]

#define MCC_LOGISTICS_LOAD_TRUCK (uiNamespace getVariable "MCC_LOGISTICS_LOAD_TRUCK")
#define MCC_loadTruckC1 (uiNamespace getVariable "MCC_loadTruckC1")

#define MCC_loadTruckSupplies (uiNamespace getVariable "MCC_loadTruckSupplies")
#define MCC_loadTruckRepair (uiNamespace getVariable "MCC_loadTruckRepair")
#define MCC_loadTruckFuel (uiNamespace getVariable "MCC_loadTruckFuel")

#define MCC_loadTruckOutpot (uiNamespace getVariable "MCC_loadTruckOutpot")
#define MCC_loadTruckOutpot2 (uiNamespace getVariable "MCC_loadTruckOutpot2")
#define MCC_loadTruckOutpot3 (uiNamespace getVariable "MCC_loadTruckOutpot3")

MCC_FNC_LOGTRUCK_REFRESH =
{
	private ["_loadedCrates","_loadedCratesIDC","_ctrl","_displayname","_truck"];
	_truck = vehicle player; 
	_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];
	_loadedCratesIDC = [MCC_loadTruckOutpot,MCC_loadTruckOutpot2,MCC_loadTruckOutpot3]; 
	
	//clear
	{
		_x ctrlsetText "";
	} foreach _loadedCratesIDC;
	
	//load
	{
		_ctrl =  _loadedCratesIDC select _foreachIndex; 
		_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
		//_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
		_ctrl ctrlsetText _displayname;
	} foreach _loadedCrates;
};

MCC_FNC_LOGTRUCK_ADD = 
{
	private ["_add","_loadedCrates","_truck","_crateType","_index","_array","_resLevel","_crate","_attachPoint","_attachedObjects","_startLoad","_nearByCrates",
	         "_position","_factor","_unload"];
	_add 		= _this select 0;
	_startLoad	= _this select 1;
	_ctrl		= (_this select 2) select 0;
	_unload		= false; 
	if (uiNameSpace getVariable ["MCC_logisticLoadingPressed", false]) exitWith {}; 
	
	uiNameSpace setVariable ["MCC_logisticLoadingPressed", true];
	
	_truck = vehicle player; 
	_attachPoint = switch (MCC_supplyTracks find typeof _truck) do
					{
						case 0: {ANCHOR_POINT_WEST};
						case 1: {ANCHOR_POINT_EAST};
						case 2: {ANCHOR_POINT_GUER};
						default {[0,0,0]};
					};
	_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];
	_array = call compile format ["MCC_res%1",playerside];
	
	
	if (_add) then
	{
		if (count _loadedCrates <3) then
		{
			//get type of crate and resources
			_crateType = MCC_loadTruckC1 lbData (lbCurSel MCC_loadTruckC1);
			_index = MCC_logisticsCrates_Types find _crateType;
			_resLevel = _array select _index; 
			
			if (_startLoad) then
			{
				if (_resLevel >= CRATE_COST) then
				{
					
					_crate = _crateType createVehicle [0,0,0];
					_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
					_crate attachTo [_truck, _attachPoint];
					_loadedCrates set [count _loadedCrates, _crateType];
					_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
					
					//reduce cost
					_array set [_index, _resLevel - CRATE_COST];
					missionNamespace setVariable [format ["MCC_res%1",playerside],_array]; 
					publicVariable format ["MCC_res%1",playerside];
				};
			}
			else
			{
				_nearByCrates = [];
				{
					if (isNull attachedTo _x) then
					{
						_nearByCrates set [count _nearByCrates, _x];
					};
				} foreach (nearestObjects [getposATL _truck, MCC_logisticsCrates_Types ,50]);
				
				if (count _nearByCrates >0) then
				{
					_crate = _nearByCrates select 0;
					_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
					_crate attachTo [_truck, _attachPoint];
					_loadedCrates set [count _loadedCrates, typeof _crate];
					_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
				}
				else
				{
					player sidechat "No crate from this type found"; 
				};
			};
		};
	}
	else
	{
		if (count _loadedCrates >0) then
		{
			//get type of crate and resources
			_crateType = _loadedCrates select (count _loadedCrates -1);
			_index = MCC_logisticsCrates_Types find _crateType;
			_resLevel = _array select _index; 
			
			
			//remove from truck
			_attachedObjects = attachedObjects _truck; 
			_crate =  (_attachedObjects select (count _attachedObjects)-1);
			_crate disableCollisionWith _truck;
						
			if (_startLoad) then 
			{
				detach _crate;
				_factor = if (MCC_isMode) then
							{
								switch (_index) do
								{
									case 0 : {getAmmoCargo _crate};
									case 1 : {getRepairCargo _crate};	
									case 2 : {getFuelCargo _crate};
								};
							}
							else {1};
				deleteVehicle _crate;
				_unload		= true; 
			} 
			else 
			{	
				_position = ATLtoASL(_truck modelToworld [0,(-12 + (count _loadedCrates*1.6)),0]);
								
				while {!lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]] && _position select 2 > getTerrainHeightASL _position} do
				{
					_position set [2, (_position select 2) - 0.1];
				};

				if (_position select 2 < getTerrainHeightASL _position) then
				{
					_position set [2, getTerrainHeightASL _position];
				};

				while {lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]]} do
				{
					_position set [2, (_position select 2) + 0.01];
				};
				
				_obj = lineIntersectsObjs [_position, getpos _truck, _truck, _truck, true, 32];
				
				_position = ASLtoATL _position;
				
				if (!(lineIntersects [getPosASL _truck, _position]) && count _obj == 0) then
				{
					detach _crate;
					_crate setposATL _position;
					_unload		= true; 
				}
				else
				{
					player sidechat "There is not enough space to unload cargo"; 
				};
			};
			
			if (_unload) then
			{
				waituntil {count ( attachedObjects _truck) != count _attachedObjects}; 
				
				_loadedCrates set [(count _loadedCrates)-1, -1];
				_loadedCrates = _loadedCrates - [-1];
				_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
				
				if (_startLoad) then 
				{
					//refund cost
					_array set [_index, _resLevel + (CRATE_COST*_factor)];
					missionNamespace setVariable [format ["MCC_res%1",playerside],_array]; 
					publicVariable format ["MCC_res%1",playerside];
				};
			};
		};
	};
	
	[] call MCC_FNC_LOGTRUCK_REFRESH;
	uiNameSpace setVariable ["MCC_logisticLoadingPressed", false];
};

_sideID = playerside call BIS_fnc_sideID;
_startLoad = player getVariable ["mcc_logTruck_screenStart",false];

_comboBox = MCC_loadTruckC1; 
lbClear _comboBox;
{
	_class			= configName(configFile >> "CfgVehicles">> _x);
	_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
	//_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
	_comboBox lbAdd _displayname;
	
	//_comboBox lbSetPicture [_foreachIndex, _pic];
	_comboBox lbSetData [_foreachindex, _class];
} foreach MCC_logisticsCrates_Types;
lbSort [_comboBox, "ASC"];
_comboBox lbSetCurSel 0;

//If not empty truck
[] call MCC_FNC_LOGTRUCK_REFRESH;

//If + or - pressed
(_disp displayCtrl 1000) ctrlAddEventHandler ["ButtonClick",format ["[false, %1, _this] call MCC_FNC_LOGTRUCK_ADD",_startLoad]]; 
(_disp displayCtrl 1001) ctrlAddEventHandler ["ButtonClick",format ["[true, %1, _this] call MCC_FNC_LOGTRUCK_ADD",_startLoad]];

//Load available resources
while {dialog} do
{
	_array = call compile format ["MCC_res%1",playerside];
	MCC_loadTruckSupplies ctrlSetText str floor (_array select 1); 
	MCC_loadTruckRepair ctrlSetText str floor (_array select 0); 
	MCC_loadTruckFuel ctrlSetText str floor (_array select 2); 
	sleep 0.1;
};