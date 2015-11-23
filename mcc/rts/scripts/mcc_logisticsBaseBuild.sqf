private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_camera","_startPos","_list","_obj","_NVGstate","_size",
         "_ctrlEHarray","_ctrlEH","_ppgrain"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD", _disp];
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEAREA", _disp displayCtrl 2];

#define MCC_LOGISTICS_BASE_BUILD_MOUSEAREA (uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD_MOUSEAREA")

//reset controls array
missionNamespace setVariable ["MCC_rtsUIGroupsIcons", []];

//IDC Counter
uiNamespace setVariable ["MCC_idcCounter",1212];

waituntil {dialog};

//CLose is RTS isn't allowed
if !(missionNamespace getVariable ["MCC_allowRTS",false]) exitWith {closeDialog 0; systemchat "RTS isn't allowed by the Mission Maker"};

//hide selection box
 (_disp displayCtrl 9929) ctrlShow false;

_size = 200;
player setVariable ["MCC_baseSize",_size];

if (isnil format ["MCC_START_%1",playerSide]) exitWith {closeDialog 0; systemchat "You must have a base to expand"};

//Camera effects
_camera = "Camera" camcreate [(getpos player) select 0, (getpos player) select 1,((getpos player) select 2) + 100];
_camera cameraeffect ["internal","back"];
_camera camPrepareFOV 0.900;
_camera camsetTarget player;
_camera campreparefocus [-1,-1];
_camera camCommitPrepared 0;
_camera camcommit 0.01;
cameraEffectEnableHUD true;

_ppgrain = ppEffectCreate ["radialBlur", 100];
_ppgrain ppEffectAdjust [0.5, 0.5, 0.3, 0.3];
_ppgrain ppEffectCommit 0;
_ppgrain ppEffectEnable true;

playsound "MCC_woosh";
for "_i" from floor((getpos player) select 2) to 200 step 5 do
{
	_camera camsetpos [(getpos player) select 0, (getpos player) select 1,_i];
	_camera camcommit 0.01;
	sleep 0.01;
};

_camera cameraEffect ["TERMINATE", "BACK"];
camdestroy _camera;
_camera = nil;
ppEffectDestroy _ppgrain;

//open compass
 (["MCC_compass"] call BIS_fnc_rscLayer) cutRsc ["MCC_compass", "PLAIN"];

for "_i" from 5 to 6 do {
	((uiNamespace getVariable "MCC_compass") displayCtrl _i) ctrlShow false;
};

//Set side flag
private ["_idc","_activeSides"];
_activeSides = [] call MCC_fnc_getActiveSides;
_idc = 20;
{
	(_disp displayCtrl _idc) ctrlSetBackgroundColor (_x call bis_fnc_sideColor);
	_idc = _idc + 1;
} foreach _activeSides;

_startPos = call compile format ["MCC_START_%1",playerSide];

if (isnil "MCC_CONST_CAM") then {
	_pos = getPos player;
	_pos set [2,200];
	_camera = "camCurator" camcreate _pos;
	//_camera = "camconstruct" camcreate [_pos select 0, _pos select 1,((getpos player) select 2) +15];
	_camera cameraeffect ["internal","back"];
	_camera camPrepareFOV 0.900;
	_camera campreparefocus [-1,-1];
	_camera camCommitPrepared 0;
	cameraEffectEnableHUD true;
	_camera setdir 0;
	[_camera,-90,0] call BIS_fnc_setPitchBank;
	_camera camCommitPrepared 0;

	_camera camConstuctionSetParams [_startPos,-1,150];

	missionNamespace setVariable ["MCC_CONST_CAM_START",_startPos];
	MCC_CONST_CAM = _camera;
};

//Create Selector
if (isnil "MCC_CONST_SELECTOR") then {
	MCC_CONST_SELECTOR = [];
};

//Selected
MCC_ConsoleGroupSelected = [];
MCC_CONST_PLACEHOLDER = objnull;

//NV State
_NVGstate = if ( sunOrMoon < 0.5 ) then {true} else {false};
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_NVSTATE", _NVGstate];
camusenvg _NVGstate;

missionNamespace setVariable ["MCC_playerViewDistance",viewDistance];
setViewDistance 1800;

//add map draw EH
_handler = (_disp displayCtrl 9120) ctrladdeventhandler ["draw","_this call MCC_fnc_mapDrawWPConsole;"];

//Loop while open
[_startPos,_size] spawn {
	private ["_startPos","_size","_buildings","_cargoSpace","_value","_ctrl","_units","_unitsSpace"];
	_startPos = _this select 0;
	_size = _this select 1;

	disableSerialization;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	//Load available resources
	_array = call compile format ["MCC_res%1",playerside];
	while {(str (_disp displayCtrl 2) != "No control")} do {
		//get number of storage
		_buildings = _startPos nearObjects ["UserTexture10m_F", _size];
		_cargoSpace = 500;
		_unitsSpace = 4;

		{
			if ((_x getVariable ["mcc_constructionItemType",""]) == "storage" && !(isNull attachedTo _x)) then {
				_cargoSpace = _cargoSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*500);
			};

			if ((_x getVariable ["mcc_constructionItemType",""]) == "barracks" && !(isNull attachedTo _x)) then {
				_unitsSpace = _unitsSpace + ((_x getVariable ["mcc_constructionItemTypeLevel",0])*4);
			};
		} foreach _buildings;



		{
			_value = floor (_array select _forEachIndex);
			_ctrl = _disp displayCtrl _x;
			_ctrl ctrlSetText format ["%1/%2",_value,_cargoSpace];
			if (_value >= _cargoSpace) then 	{
				_ctrl ctrlSetTextColor [1,0,0,0.8];
			} else {
				_ctrl ctrlSetTextColor [1,1,1,0.8];
			};
		} foreach [81,82,83,84,85];

		//units
		_units = {side _x == playerSide && (isPlayer _x || _x getVariable ["MCC_isRTSunit",false])} count allUnits;
		_ctrl = (_disp displayCtrl 86);
		_ctrl ctrlSetText format ["%1/%2",_units,_unitsSpace];
		if (_units >= _unitsSpace) then {
			_ctrl ctrlSetTextColor [1,0,0,0.8];
		} else {
			_ctrl ctrlSetTextColor [1,1,1,0.8];
		};

		//Loop for reseting UI if the object we are watching died
		if (count MCC_ConsoleGroupSelected <=0) then	{
			[] call MCC_fnc_baseOpenConstMenu;
		};

		//Fog of war
		private ["_fog","_cam"];
		_cam = missionnamespace getVariable ["MCC_CONST_CAM",objNull];
		if (isNull _cam) exitWith {};

		_fog = true;
		{
			if (side _x == playerSide) exitWith {_fog = false}
		} forEach ((position _cam) nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 100]);

		if (_fog && (viewDistance > 100) && (_cam distance _startPos > 300)) then {setViewDistance 100};
		if ((!_fog || (_cam distance _startPos < 300)) && viewDistance < 1800 ) then {setViewDistance 1800};

		//Buildings UI
		private ["_type","_endTime","_startTime","_cfgName","_text","_segmentsElapsed","_elec","_icon","_texture","_color","_buildingIcons"];

		_buildingIcons = [];
		{
			if (isNull _cam) exitWith {};

			_type = _x getVariable ["mcc_constructionItemType",""];

			if (_type != "") then {
				_endTime = _x getVariable ["mcc_constructionendTime",-30];
				_startTime = _x getVariable ["mcc_constructionStartTime",time];
				_cfgName 	= format ["MCC_rts_%1%2",_type,(_x getVariable ["mcc_constructionItemTypeLevel",1])];
				_elec = false;
				if ((_startTime+_endTime) > time) then {
					_text = "";
					_segmentsElapsed = round((time -_startTime)/_endTime * 20);
					for "_i" from 1 to _segmentsElapsed do
					{
						_text = _text + "|";
					};

				} else {
					if (isClass (missionconfigFile >> "cfgRtsBuildings")) then {
							_text = getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "displayName");
							_elec = (getNumber (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "needelectricity"))==1;
						} else {
							_text = getText (configFile >> "cfgRtsBuildings" >> _cfgName >> "displayName");
							_elec = (getNumber (configFile >> "cfgRtsBuildings" >> _cfgName >> "needelectricity"))==1;
						};
				};

				switch (tolower _type) do {
					case "hq": {_icon = "n_hq"};
					case "storage": {_icon = "n_unknown"};
					case "barracks": {_icon = "n_inf"};
					case "workshop": {_icon = "n_service"};
					case "tradepost": {_icon = "loc_Tourism"};
				};

				if (!isnil "_icon") then {
					_texture = gettext (configfile >> "CfgMarkers" >> _icon >> "icon");
					_color = [0,0,0.6,0.6];

					if (_elec && !(missionNamespace getVariable [format ["MCC_rtsElecOn_%1", playerSide],false])) then {
						_color = [0.6,0,0,0.6];
						_text = format ["%1 (Offline)", _text];
					} else {
						_color = [0,0,0.6,0.6];
					};

					_buildingIcons pushBack [_x, _texture, _color, _text];
				};
			};
		} foreach _buildings;

		missionNamespace setvariable ["MCC_rtsBuildingsIcons",_buildingIcons];

		//Group Icons
		private ["_leader","_side","_group","_uiPos","_display","_ctrl","_ratio","_groupCtrls","_inFOV","_ctrlIndex","_ctrlPos","_texture","_unit","_hiddenUnits"];

		_display = uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD", displayNull];
		_groupCtrls = missionNamespace getVariable ["MCC_rtsUIGroupsIcons", []];
		_hiddenUnits = missionNamespace getVariable ["MCC_rtsHiddenUnits", []];

		{
			if (isnull (_x select 1)) then {(_x select 0) ctrlShow false};
		} forEach _groupCtrls;

		//add icons to groups
		{
			if (isNull _cam) exitWith {};

			_group = _x;
			_leader = leader _x;

			if !(isnil "_leader") then {

				_inFOV = ((worldToScreen (visiblePosition _leader)) select 0 > (0 * safezoneW + safezoneX)) && ((worldToScreen (visiblePosition _leader)) select 0 <(1 * safezoneW + safezoneX)) && _cam distance _leader < 2000;

				if (isNil "_inFOV") then {_inFOV = false};

				if (_inFOV) then {
					_side = side _x;
					_pos = position _leader;

					if (_side == playerside) then {
						_ctrlIndex = [_groupCtrls, _group] call bis_fnc_findNestedElement;
						_ctrl = if (count _ctrlIndex <= 0) then {controlNull} else {(_groupCtrls select (_ctrlIndex select 0)) select 0};

						if (isNull _ctrl) then {
							_ctrl = [_group] call MCC_fnc_rtsCreateUICtrl;

							_groupCtrls pushBack [_ctrl,_group];
							 missionNamespace setVariable ["MCC_rtsUIGroupsIcons", _groupCtrls];
						};
					} else {
						//Hide unkonwn units
						{
							_unit = _x;
							_knowsAbout = _unit getVariable ["MCC_knowsAbout",0];
							if ((playerside knowsAbout _unit < _knowsAbout || _knowsAbout < 3) &&
								(((_unit targetKnowledge (_unit findNearestEnemy _unit)) select 2) + 60 < time)
							   ) then {
								vehicle _unit hideObject true;
								_hiddenUnits pushBack vehicle _unit;
							} else {
								_unit hideObject false;
								_unit setVariable ["MCC_knowsAbout",playerside knowsAbout _unit];
							};
						} forEach units _group;
					};
				};
			};
		} foreach allGroups;
		missionNamespace setVariable ["MCC_rtsHiddenUnits", _hiddenUnits];

		//Set tickets
		_activeSides = [] call MCC_fnc_getActiveSides;
		_idc = 20;
		{
			ctrlSetText [_idc, str ([_x] call BIS_fnc_respawnTickets)];
			_idc = _idc + 1;
		} foreach _activeSides;

		sleep 0.5;
	};
};

MCC_fnc_rtsDrawWpGroup = {
	private ["_group","_unit","_texture","_bbr","_p1","_p2","_maxHeight","_sizeIcon","_camera","_wpArray","_wp","_wPos","_wType","_lastPos","_color"];
	_group = param [0,grpNull];
	_color = (side _group) call bis_fnc_sideColor;
	_camera = param [1,objNull];

	{
		_unit = _x;

		if((_camera distance vehicle _unit)<500) then {
			_bbr = boundingBoxReal vehicle _unit;
			_p1 = _bbr select 0;
			_p2 = _bbr select 1;
			_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

			if (_x != leader _group) then {
				drawLine3D [
					[(getpos vehicle _unit) select 0, (getpos vehicle _unit) select 1, ((getpos vehicle _unit) select 2) + _maxHeight],
					[(getpos vehicle (leader _group)) select 0, (getpos vehicle(leader _group)) select 1, ((getpos vehicle (leader _group)) select 2) + _maxHeight],
					_color
				];
			};
		};

		//Draw the current WP
		_wpArray = waypoints _group;
		if (count _wpArray > 0)then  {
			_lastPos = nil;
			_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");
			_sizeIcon =if ((1.5 - ((_camera distance _x)*0.0005)) < 0) then {0} else {(1.5 - ((_camera distance _x)*0.0005))};

			for [{_i= currentWaypoint _group},{_i < count _wpArray},{_i=_i+1}] do {
				_wp = (_wpArray select _i);
				_wPos  = waypointPosition _wp;
				_wPos set [2, (_wPos select 2) + 2];

				if ((_wPos  distance [0,0,0]) > 50) then {
					_wType = waypointType _wp;

					drawIcon3D [
								_texture,
								[0.255,0.255,0,1],
								_wPos,
								_sizeIcon,
								_sizeIcon,
								0,
								_wType
							];

					if (isnil "_lastPos") then {_lastPos = [(getpos leader _group) select 0,(getpos leader _group) select 1,((getpos leader _group) select 2)+2]};

					drawLine3D [
						_lastPos,
						_wPos,
						[0.255,0.255,0,1]
					];

					_lastPos = _wPos;
				};
			};
		};

	} foreach (units _group);
};
MCC_fnc_rtsCreateUICtrl = {
	private ["_ctrlColor","_display","_ctrl","_idc","_group","_texture","_ctrlGroup","_ctrlPos"];
	disableSerialization;

	_group = param [0,grpNull];
	if (isNull _group) exitWith {};

	_leader = leader _group;
	_display = uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD", displayNull];
	_idc = uiNamespace getVariable ["MCC_idcCounter",1212];
	uiNamespace setVariable ["MCC_idcCounter",_idc+4];

	_ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", _idc];
	_ctrlPos= ctrlPosition _ctrlGroup;
	_ctrlPos set [2,0.1 * safezoneW];
	_ctrlPos set [3,0.1 * safezoneH];
	_ctrlGroup ctrlSetPosition _ctrlPos;
	_ctrlGroup ctrlCommit 0;

	_ctrl = _display ctrlCreate ["RscActivePicture", _idc+1,_ctrlGroup];
	_ctrlPos= ctrlPosition _ctrl;
	_ctrlPos set [2,0.02 * safezoneW];
	_ctrlPos set [3,0.025 * safezoneH];
	_ctrl ctrlSetPosition _ctrlPos;
	_ctrl ctrlCommit 0;

	_group setVariable ["MCC_rtsGroupIcon",_idc];

	_texture = if (isClass (missionconfigFile >> "cfgMCCRtsGroups")) then {
					getText (missionconfigFile >> "cfgMCCRtsGroups" >> (_group getVariable ["MCC_rtsGroupCfg",""]) >> "picture");
				} else {
					getText (configFile >> "cfgMCCRtsGroups" >> (_group getVariable ["MCC_rtsGroupCfg",""]) >> "picture");
				};

	if (_texture == "") then {
		_icon = ([_group] call MCC_fnc_getGroupIconData) select 2;
		_texture = gettext (configfile >> "CfgMarkers" >> _icon >> "icon");
	};

	_ctrl ctrlSetText _texture;
	_ctrlColor = (side _leader) call bis_fnc_sideColor;
	_ctrlColor set [3,0.8];
	_ctrl ctrlSetTextColor _ctrlColor;

	_ctrl ctrlAddEventHandler ["MouseEnter",format ["[_this select 0,true, %1] call MCC_fnc_highlightUICtrl;",_ctrlColor]];
	_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this select 0,false, %1] call MCC_fnc_highlightUICtrl",_ctrlColor]];

	_ctrlColors = [[],[],[0,1,0,0.8],[1,1,1,0.8]];
	for "_i" from 2 to 3 do {
		_ctrl =_display ctrlCreate ["RscProgress", _idc+_i,_ctrlGroup];

		_ctrl ctrlSetPosition [0, ((0.015+_i/130 )* safezoneH), 0.04 * safezoneW, 0.005 * safezoneH];
		_ctrl progressSetPosition 1;
		_ctrl ctrlSetTextColor (_ctrlColors select _i);
		_ctrl ctrlCommit 0;
	};

	_ctrlGroup ctrlAddEventHandler ["MouseButtonClick","_this call MCC_fnc_rtsSelectGroup"];
	_ctrlGroup
};

MCC_fnc_isGroupConsoleAllowed = {
 	private ["_group","_leader","_groupControl","_haveGPS","_showUnitsWithGPS","_enabled"];
 	_group = param [ 0, grpNull];

 	_leader = (leader _group);
	_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_group getvariable ["MCC_canbecontrolled",false]};

	_haveGPS =  if ((vehicle _leader != _leader) || !isPlayer _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader)  || "O_UavTerminal" in (assignedItems _leader)  || "I_UavTerminal" in (assignedItems _leader))};
	if (isnil "_haveGPS") then {_haveGPS = false};
	_showUnitsWithGPS = missionNamespace getVariable ["MCC_ConsoleOnlyShowUnitsWithGPS",false];
	_enabled = ((side _leader == playerSide) && alive _leader && _groupControl && ((_showUnitsWithGPS && _haveGPS) || !_showUnitsWithGPS));
	_enabled
};

MCC_fnc_rtsMakeMarkers = {
	private ["_marker","_obj"];
	{
		detach _x;
		deletevehicle _x;
	} forEach MCC_CONST_SELECTOR;

	{
		_marker = "Sign_Circle_F" createVehicleLocal [0,0,0];

		MCC_CONST_SELECTOR pushBack _marker;
		_obj = if (typeName _x == typeName grpNull) then {vehicle leader _x} else {_x};

		if (_obj isKindOf "UserTexture10m_F") then {
			_marker setposatl (getposatl _obj);
		} else {
			_marker attachTo [_obj,[0,0,0]];
		};
		_marker setVectorDirAndUp [[0,0,1],[0,1,0]];
	} foreach MCC_ConsoleGroupSelected;
};

MCC_fnc_rtsSelectGroup = {
	private ["_groupCtrls","_ctrl","_index","_group","_pos","_groups"];
	_ctrl = _this select 0;
	_key = _this select 1;

	_groupCtrls = missionNamespace getVariable ['MCC_rtsUIGroupsIcons', []];
	_index = ([_groupCtrls,_ctrl] call bis_fnc_findNestedElement) select 0;
	_group = (_groupCtrls select _index) select 1;
	if !([_group] call MCC_fnc_isGroupConsoleAllowed) exitWith {};
	playsound "click";

	//Get inside vehicle
	if (_key == 1) then {
		{
			_group = _x;
			_pos = ctrlPosition (_this select 0);
			_pos resize 2;

			_groups = [];
			{
				if (typeName _x == typeName grpNull) then {
					if (canMove leader _x && (vehicle leader _x isKindOf "Man")) then {_groups pushBack _x};
				};
			} forEach MCC_ConsoleGroupSelected;

			if (count _groups > 0) then {
				player globalRadio "CuratorWaypointPlaced";
				{
					[[1,screentoworld _pos,[2,"YELLOW","NO CHANGE","FULL","AWARE","true","",0],[_x],true],"MCC_fnc_manageWp", leader _x, false] spawn BIS_fnc_MP;
				} forEach _groups;
			};
		} forEach MCC_ConsoleGroupSelected;
	} else {
		MCC_ConsoleGroupSelected = [_group];
		[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;
		[] call MCC_fnc_rtsMakeMarkersGroups;
	};
};

MCC_fnc_rtsMakeMarkersGroups = {
	disableSerialization;
	private ["_marker","_obj","_group","_ctrl","_disp","_ctrlColor"];
	_disp = uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD", displayNull];

	//remove logic markers
	{
		detach _x;
		deletevehicle _x;
	} forEach MCC_CONST_SELECTOR;

	//remove all markers
	{
		_group = _x;
		if (_group getvariable ["MCC_rtsIsSelectedGroup",false]) then {
			_group setvariable ["MCC_rtsIsSelectedGroup",false];
			_ctrlColor = (side _group) call bis_fnc_sideColor;

			[_disp displayCtrl (_group getVariable ["MCC_rtsGroupIcon",-1]), false,_ctrlColor] spawn MCC_fnc_highlightUICtrl;
		};
	} forEach allGroups;


	{
		_group = _x;
		_group setvariable ["MCC_rtsIsSelectedGroup",true];
		_ctrlColor = (side _group) call bis_fnc_sideColor;
		[_disp displayCtrl (_group getVariable ["MCC_rtsGroupIcon",-1]), true,_ctrlColor] spawn MCC_fnc_highlightUICtrl;
	} foreach MCC_ConsoleGroupSelected;
};

MCC_fnc_highlightUICtrl = {
	disableSerialization;
	private ["_ctrl","_increase","_disp","_group","_ctrlColor","_group","_groupCtrls","_index","_iconCtrl"];
	_ctrl = _this select 0;
	_increase = _this select 1;
	_ctrlColor = _this select 2;
	_disp = uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD", displayNull];

	//Not a ctrl group get the active picture control
	if (((ctrlIDC _ctrl)-1212) mod 4 != 0) then {
		_ctrl = _disp displayCtrl (ctrlIDC _ctrl)-1;
	};

	_iconCtrl = _disp displayCtrl (ctrlIDC _ctrl)+1;

	//find group
	_groupCtrls = missionNamespace getVariable ["MCC_rtsUIGroupsIcons", []];

	if (count _groupCtrls == 0) exitWith {};
	_index = ([_groupCtrls,_ctrl] call bis_fnc_findNestedElement) select 0;
	if (isNil "_index") exitWith {};

	_group = (_groupCtrls select _index) select 1;

	if (_increase) then {
		_iconCtrl ctrlSetScale 1.1;
		_iconCtrl ctrlSetTextColor [1,1,1,1];
		_group setVariable ["MCC_rtsHighlightedGroup",true];
	} else {
		if ({ctrlidc _ctrl == (_x getVariable ["MCC_rtsGroupIcon",-1])} count MCC_ConsoleGroupSelected ==  0) then {
			_ctrlColor set [3,0.8];
			_iconCtrl ctrlSetScale 1;
			_iconCtrl ctrlSetTextColor _ctrlColor;
			_group setVariable ["MCC_rtsHighlightedGroup",false];
		};
	};
	_iconCtrl ctrlCommit 0;
	_iconCtrl ctrlEnable true;
	ctrlSetFocus _iconCtrl;
};

//open construction menu
[] call MCC_fnc_baseOpenConstMenu;

//Create borders
_createBorderScope = [_startPos,_size] call MCC_fnc_baseBuildBorders;

//Create structures Icons
["mcc_constBaseID", "onEachFrame",
{
	disableSerialization;
	private ["_startPos","_size","_pos","_sizeIcon","_texture","_text","_obj","_color","_group","_leader","_inFOV","_ctrl","_uiPos","_visPos"];
	_startPos 	= _this select 0;
	_size		= _this select 1;

	//building Icons
	{
		_obj =(_x select 0);
		_pos = getpos _obj;
		_texture = (_x select 1);
		_color = (_x select 2);
		_text = (_x select 3);
		_sizeIcon =if ((1.5 - ((MCC_CONST_CAM distance _obj)*0.0005)) < 0) then {0} else {(1.5 - ((MCC_CONST_CAM distance _obj)*0.0005))};
		drawIcon3D [
									_texture,
									_color,
									[_pos select 0, _pos select 1,(_pos select 2)+ 10],
									_sizeIcon,
									_sizeIcon,
									0,
									_text
								];
	} forEach (missionNamespace getvariable ["MCC_rtsBuildingsIcons",[]]);

	{
		_ctrl = _x select 0;
		_group = _x select 1;
		_leader = leader _group;
		_pos = visiblePosition _leader;
		_pos set [2,(_pos select 2)+3];

		//In FOV
		_visPos = (worldToScreen (visiblePosition _leader));
		if (count _visPos > 1) then {
			_inFOV = (_visPos select 0 > (0 * safezoneW + safezoneX)) && (_visPos select 0 <(1 * safezoneW + safezoneX)) && (_visPos select 1 > (0 * safezoneH + safezoneY)) && (_visPos select 1 < (0.676 * safezoneH + safezoneY)) && MCC_CONST_CAM distance _leader < 1000;
		};

		if (isNil "_inFOV") then {_inFOV = false};

		if (_inFOV && group (vehicle _leader) == _group ) then {
			if !(ctrlshown _ctrl) then {_ctrl ctrlShow true};
			_ctrlPos = ctrlPosition _ctrl;
			_uiPos = worldToScreen _pos;

			if (count _uiPos > 1) then {
				_ratio = MCC_CONST_CAM distance _leader < 1000;
				_ctrl ctrlSetPosition [_uiPos select 0, _uiPos select 1, 0.05 * safezoneW, 0.05 * safezoneH];
				_ctrl ctrlCommit 0;
				_ctrl ctrlEnable true;
				ctrlSetFocus _ctrl;

				_disp = (ctrlParent _ctrl);
				_ctrlIdc = ctrlIDC _ctrl;

				//health
				if (_ratio && _group getVariable ["MCC_rtsHighlightedGroup",false]) then {
					_value = 0;
					{
						_value = _value + getDammage vehicle _x;
					} forEach (units _group);
					_value = _value/count units _group;

					_ctrl = _disp displayCtrl (_ctrlIdc + 2);
					_ctrl progressSetPosition (1-_value);
					_ctrl ctrlShow true;

					//fuel
					_ctrl =  _disp displayCtrl (_ctrlIdc + 3);
					if (vehicle _leader != _leader) then {
						_ctrl progressSetPosition (fuel vehicle _leader);
						_ctrl ctrlShow true;
					} else {
						_ctrl ctrlShow false;
					};
				} else {
					for "_i" from 2 to 3 do {(_disp displayCtrl (_ctrlIdc + _i)) ctrlshow false};
				};
			};
		} else {
			_ctrl ctrlShow false
		};

		//draw WP
		if (_group in MCC_ConsoleGroupSelected || _group getVariable ["MCC_rtsHighlightedGroup",false]) then {
			[_group,MCC_CONST_CAM] call MCC_fnc_rtsDrawWpGroup;
		};
	} forEach ( missionNamespace getVariable ["MCC_rtsUIGroupsIcons", []]);
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

_ctrlEH		=	MCC_LOGISTICS_BASE_BUILD_MOUSEAREA ctrlAddEventHandler  ["MouseButtonDblClick",	"if !(isnil 'MCC_CONST_CAM_Handler') then {MCC_temp = ['mousebuttondblclick',_this,commandingmenu] spawn MCC_CONST_CAM_Handler; MCC_temp = nil;}"];
_ctrlEHarray pushback [MCC_LOGISTICS_BASE_BUILD_MOUSEAREA, ["mousebuttondblclick",_ctrlEH]];


MCC_CONST_CAM_Handler =
{
	private ["_mode","_input","_camera","_terminate","_keysCancel","_keysUpObj","_keysDownObj","_keysUp","_keysDown","_keysShift","_keysBanned","_keyNightVision",
	         "_keyplace","_keyalt","_keydelete","_keyGUI","_colorGreen","_colorRed","_NVGstate","_keyForward","_keyBack","_keyLeft","_keyRight","_pos","_factor",
			 "_keyUp","_keyDown","_posX","_posY","_shiftK","_ctrlK","_altK","_disp","_isFort","_res"];
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
			_pos = [_camera, (((getpos _camera) select 2)/35 min 40)* _factor, getdir _camera] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Back
		if (_key in _keyBack) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/35 min 40)*_factor, (getdir _camera)-180] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Left
		if (_key in _keyLeft) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/35 min 40)*_factor, (getdir _camera)-90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Right
		if (_key in _keyRight) then
		{
			_pos = [_camera, (((getpos _camera) select 2)/35 min 40)*_factor, (getdir _camera)+90] call BIS_fnc_relPos;
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Up
		if (_key in _keyUp) then
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, ((_pos select 2) + (((getpos _camera) select 2)/20 min 10)*_factor) min 150];
			MCC_CONST_CAM SetPos _pos;
		};

		//--- Down
		if (_key in _keyDown) then
		{
			_pos = getpos MCC_CONST_CAM;
			_pos set [2, ((_pos select 2) -(((getpos _camera) select 2)/20 min 10)*_factor) max 20];
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

	if (_mode == "mousebuttondblclick") exitWith
	{
		_key	= _input select 1;
		_posX 	= _input select 2;
		_posY 	= _input select 3;
		_shiftK	= _input select 4;
		_ctrlK 	= _input select 5;
		_altK	= _input select 6;
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
		uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWNLeft",false];

		if (_key == 0) exitWith	{
			private ["_groupCtrls","_ctrl","_index","_borderXleft","_borderXright","_borderYdown","_borderYtop","_ctrlPos","_groupX","_groupY"];

			uiNamespace setVariable ["MCC_rtsMenuLeftClickXYpos",[_posX,_posY]];
			//Build
			_isFort = false;
			if (!isnull MCC_CONST_PLACEHOLDER && !isnil "MCC_canSpawn3DConst") then {
				_isFort = MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingIsFort",false];

				if (!MCC_canSpawn3DConst && !_isFort) exitWith {};

				//get cfg
				_cfgName = MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingToBuild",""];

				if (_isFort) then {
					_res = MCC_CONST_PLACEHOLDER getVariable ["MCC_baseBuildingRes",[]];
				} else {
					if (MCC_isMode) then {
						_res = getArray (configFile >> "cfgRtsBuildings" >> _cfgName >> "resources");
					} else {
						_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "resources");
					};
				};

				[_res] spawn MCC_fnc_baseResourceReduce;

				if (_isFort) then {
					private ["_dummy","_dummyPos","_dummyDir"];
					_dummyPos = getposATL MCC_CONST_PLACEHOLDER;
					_dummyDir = getdir MCC_CONST_PLACEHOLDER;

					_dummy = _cfgName createVehicle _dummyPos;
					_dummy setposATL _dummyPos;
					_dummy setposATL _dummyPos;
					_dummy setdir _dummyDir;
					_dummy setVariable ["MCC_rtsObject",true,true];
					playsound "click";
				} else {
					player globalRadio "SentAssemble";
					[[getpos MCC_CONST_PLACEHOLDER, getdir MCC_CONST_PLACEHOLDER ,_cfgName, 1, playerside],"MCC_fnc_construct_base",false] call bis_fnc_MP;
				};

				missionNamespace setVariable ["MCC_rtsUIBuiltTime",time];
				deleteVehicle MCC_CONST_PLACEHOLDER;
				MCC_CONST_PLACEHOLDER = objnull;
			};

			//selection box
			_ctrl = _disp displayCtrl 9929;
			_ctrlPos = ctrlPosition _ctrl;
			if (abs(_ctrlPos select 2)>0.1) exitWith {

				_borderXleft = if ((_ctrlPos select 2)<0) then {(_ctrlPos select 0) + (_ctrlPos select 2)} else {(_ctrlPos select 0)};
				_borderXright = if ((_ctrlPos select 2)<0) then {(_ctrlPos select 0)} else {(_ctrlPos select 0) + (_ctrlPos select 2)};
				_borderYdown = if ((_ctrlPos select 3)<0) then {(_ctrlPos select 1) + (_ctrlPos select 3)} else {(_ctrlPos select 1)};
				_borderYtop =  if ((_ctrlPos select 3)<0) then {(_ctrlPos select 1)} else {(_ctrlPos select 1) + (_ctrlPos select 3)};
				_ctrl ctrlShow false;

				_groupCtrls = missionNamespace getVariable ['MCC_rtsUIGroupsIcons', []];
				MCC_ConsoleGroupSelected = [];
				{
					_ctrlPos = ctrlPosition (_x select 0);
					_groupX = _ctrlPos select 0;
					_groupY = _ctrlPos select 1;
					if (
						_groupX > _borderXleft &&
						_groupX < _borderXright &&
						_groupY > _borderYdown &&
						_groupY < _borderYtop
					) then {
						if ([(_x select 1)] call MCC_fnc_isGroupConsoleAllowed) then {
							MCC_ConsoleGroupSelected pushBack (_x select 1);
						};
					};
				} foreach _groupCtrls;

				[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;
				[] call MCC_fnc_rtsMakeMarkersGroups;
			};

			_list = ((screenToWorld [_posX,_posY]) nearObjects ["LandVehicle", 10]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["Ship", 10]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["Air", 10]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["Strategic", 10]);
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["HBarrier_base_F", 10]);

			for "_i" from 0 to (count _list)-1 do {if !(isNull attachedTo (_list select _i)) then {_list set [_i, -1]}};
			_list = _list - [-1];
			_list = _list + ((screenToWorld [_posX,_posY]) nearObjects ["UserTexture10m_F", 20]);
			_list = [_list,[],{(screenToWorld [_posX,_posY]) distance _x},"ASCEND"] call BIS_fnc_sortBy;

			if (count _list > 0 && !_isFort) then {
				_obj = _list select 0;
				if (side _obj in [playerSide,sideLogic,civilian,sideFriendly,sideUnknown]
				    &&
				    !(_obj in MCC_ConsoleGroupSelected)
				    &&
				    ((count crew _obj == 0) || _obj isKindOf "UserTexture10m_F")
				    ) then {
					MCC_ConsoleGroupSelected = [_list select 0];
					[MCC_ConsoleGroupSelected] spawn MCC_fnc_baseSelected;

					[] call MCC_fnc_rtsMakeMarkers;
				};
			};
		};

		if (_key == 1) exitWith	{
			//Cancel Build
			if (!isnull MCC_CONST_PLACEHOLDER) then {
				deleteVehicle MCC_CONST_PLACEHOLDER;
				MCC_CONST_PLACEHOLDER = objnull;
			};

			//Add WP
			if (isnull MCC_CONST_PLACEHOLDER && abs (_posX - ((uiNamespace getVariable ["MCC_rtsMenuXYpos",[0,0]]) select 0))<0.005) then {
				private ["_groups","_action","_groupCtrls"];
				_groupCtrls = missionNamespace getVariable ['MCC_rtsUIGroupsIcons', []];
				_action = switch (true) do {
							//Get In
						    case ({ctrlScale (_x select 0) > 1} count _groupCtrls > 0): {2};
						    //move
						    default {0};
						};

				_groups = [];
				{
					if (typeName _x == typeName grpNull) then {
						if (canMove leader _x && !(vehicle leader _x isKindOf "StaticWeapon")) then {_groups pushBack _x};
					};
				} forEach MCC_ConsoleGroupSelected;

				if (count _groups > 0) then {
					private ["_wpPos","_string","_wpType"];

					_wpPos = screenToWorld [_posX,_posY];
					_wpType = 0;
					_string = "";

					player globalRadio "CuratorWaypointPlaced";

					{
						if (leader _x isKindOf "Man") then {
							_list = (_wpPos nearObjects ["LandVehicle", 10]);
							_list = _list + (_wpPos nearObjects ["Ship", 10]);

							//Fortify buildings
							if ((nearestBuilding _wpPos) distance _wpPos < 5) then {
								_buildingPos = [(nearestBuilding _wpPos), count units _x] call BIS_fnc_buildingPositions;
								_x setVariable ["MCC_rtsIsFortified",true,true];

								_string = format ["{
								                      _unit = (thislist select  _forEachIndex);
								                      _unit domove _x;
								                      _unit setSpeedMode 'FULL';
								                      _unit spawn {
								                      	sleep 5;
								                      	waituntil {unitready _this};
								                      	_this disableai 'move';
								                      	while {(unitready leader _this)} do {sleep 1};
								                      	_this enableai 'move';
								                       };
								                  } forEach %1;",_buildingPos];
							} else {
								//Board empty vehicles
								if ({count crew _x ==0} count _list > 0) then {
									_wpType = 15;
								};
							};
						};

						[[if (_ctrlK) then {0} else {1},_wpPos,[_wpType,"YELLOW","NO CHANGE","FULL","AWARE","true",_string,0],[_x],true],"MCC_fnc_manageWp", leader _x, false] spawn BIS_fnc_MP;
					} forEach _groups;
				};
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
		uiNamespace setVariable ["MCC_rtsMenuXYpos",[_posX,_posY]];
		if (_key == 0) then {uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWNLeft",true]};
	};

	if (_mode in ["mouseholding","mousemoving"]) exitWith
	{
		_ctrl 	= _input select 0;
		_posX 	= _input select 1;
		_posY 	= _input select 2;

		if (!isnil "MCC_mousePos") then {
			_ctrlPos 	= ctrlPosition _ctrl;
			_ctrlPosX 	= _ctrlPos select 0;
			_ctrlPosY 	= _ctrlPos select 1;
			_ctrlPosW 	= _ctrlPos select 2;
			_ctrlPosH 	= _ctrlPos select 3;

			//Compass
			_cam = missionNamespace getVariable ["MCC_CONST_CAM",objNull];

			if (_mode == "mousemoving" && !isNull _cam) then {
				private ["_offset","_ctrlClass","_ctrl","_camPos"];
				disableSerialization;

				_camPos = positionCameraToWorld [0,4.3,10];

				for "_i" from 10 to 21 do {
					_ctrl = (uiNamespace getVariable "MCC_compass") displayCtrl _i;
					_ctrlClass = ctrlClassName _ctrl;
					if (isClass(missionConfigFile >>"RscTitles" >> "MCC_compass")) then {
						_offset = getArray(missionconfigFile >>"RscTitles" >> "MCC_compass" >> "controls" >> _ctrlClass >> "offSet");
					} else {
						_offset = getArray(configFile >>"RscTitles" >> "MCC_compass" >> "controls" >> _ctrlClass >> "offSet");
					};

					_ctrl ctrlSetPosition (worldToScreen (_camPos vectoradd _offset));
					_ctrl ctrlCommit 0;
				};
			};

			if (!isnull MCC_CONST_PLACEHOLDER) then {
				if (uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWN",false]) exitWith {
					MCC_CONST_PLACEHOLDER setDir (getdir MCC_CONST_PLACEHOLDER - (_posX - ((uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEXY",[_posX,_posY]]) select 0))*(player getVariable ["MCC_baseSize",300]));
					missionNamespace setVariable ["MCC_rtsFortDir",getdir MCC_CONST_PLACEHOLDER];
				};

				_pos = screenToWorld [_posX,_posY];

				MCC_CONST_PLACEHOLDER setpos _pos;

				//--- No Place To Build
				_isFlat = _pos isflatempty [
					(sizeof typeof MCC_CONST_PLACEHOLDER)/8,	//--- Minimal distance from another object
					0,				//--- If 0, just check position. If >0, select new one
					0.7,				//--- Max gradient
					(sizeof typeof MCC_CONST_PLACEHOLDER)/8,	//--- Gradient area
					0,				//--- 0 for restricted water, 2 for required water,
					false,				//--- True if some water can be in 25m radius
					MCC_CONST_PLACEHOLDER			//--- Ignored object
				];

				_center = (missionnamespace getvariable ["MCC_CON_border",[]]) select 0;

				_colorGreen = "#(argb,8,8,3)color(0,1,0,0.3,ca)";
				_colorRed = "#(argb,8,8,3)color(1,0,0,0.3,ca)";
				_color = "#(argb,8,8,3)color(1,0,0,0.3,ca)";

				if ((count _isFlat == 0) || (([position MCC_CONST_PLACEHOLDER,_center] call BIS_fnc_distance2D) > (player getVariable ["MCC_baseSize",300]))) then {
					_color = _colorRed;
					MCC_canSpawn3DConst = false;
				} else {
					_color = _colorGreen;
					MCC_canSpawn3DConst = true;
				};

				{MCC_CONST_PLACEHOLDER setObjectTexture [_x,_color]} foreach [0,1,2];
			};


			if (_mode =="mouseholding" && !(isNil "_camera")) then {
				//Mouse pan left
				if ((MCC_mousePos select 0) < (_ctrlPosX + (_ctrlPosW * 0.04))) then {
					_pos = [_camera, (((getpos _camera) select 2)/20 min 40), (getdir _camera)-90] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan right
				if ((MCC_mousePos select 0) > (_ctrlPosX + (_ctrlPosW * 0.96))) then {
					_pos = [_camera, (((getpos _camera) select 2)/20 min 40), (getdir _camera)+90] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan UP
				if ((MCC_mousePos select 1) < (_ctrlPosY + (_ctrlPosH *0.1))) then {
					_pos = [_camera, (((getpos _camera) select 2)/20 min 40), getdir _camera] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};

				//Mouse pan down
				if ((MCC_mousePos select 1) > (_ctrlPosY + (_ctrlPosH *0.98))) then {
					_pos = [_camera, (((getpos _camera) select 2)/20 min 40), (getdir _camera)-180] call BIS_fnc_relPos;
					MCC_CONST_CAM SetPos _pos;
				};
			};


			//selection box
			if (uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD_MBDOWNLeft",false] && (isnull MCC_CONST_PLACEHOLDER)) then {
				private ["_start","_width","_hight","_markersize","_pointA","_pointB"];
				//Start creating the box
				_pointA = uiNamespace getVariable ["MCC_rtsMenuXYpos",[0,0]];
				_pointB = MCC_mousePos;
				_start = _pointA;
				_width = ((_pointB select 1) - (_start select 1));
				_hight = ((_pointB select 0) - (_start select 0));

				_ctrl = _disp displayCtrl 9929;
				_ctrl ctrlShow true;
				_ctrl ctrlSetTextColor [0,1,0,1];
				_ctrl ctrlSetPosition _start + [_hight] + [_width];
				_ctrl ctrlCommit 0;
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
if (!isnil "MCC_CONST_SELECTOR") then {
	{deleteVehicle _x} forEach MCC_CONST_SELECTOR;
};
if (!isnil "MCC_CONST_PLACEHOLDER") then {deleteVehicle MCC_CONST_PLACEHOLDER; MCC_CONST_PLACEHOLDER = objnull};
MCC_ConsoleGroupSelected = [];

//Remove the event handlers
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyDown",MCCCONSBASEKeyDown];
(uinamespace getvariable "MCC_LOGISTICS_BASE_BUILD") displayRemoveEventHandler ["KeyUp",MCCCONSBASEKeyUp];

//Remove controls event handlers
{(_x select 0) ctrlRemoveEventHandler (_x select 1)} foreach _ctrlEHarray;

//remove fog effects
setViewDistance (missionNamespace getVariable ["MCC_playerViewDistance",1800]);

//Clean Compass
(["MCC_compass"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

missionNamespace setVariable ['MCC_rtsUIGroupsIcons', []];

//Unhide units
{
	_x hideObject false;
} forEach (missionNamespace getVariable ["MCC_rtsHiddenUnits", []]);