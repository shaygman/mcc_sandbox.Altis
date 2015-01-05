private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_camera","_startPos","_list","_obj","_NVGstate","_size",
         "_ctrlEHarray","_ctrlEH"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD", _disp];
uiNamespace setVariable ["MCC_LOGISTICS_BASE_BUILD_MOUSEAREA", _disp displayCtrl 2];

#define MCC_LOGISTICS_BASE_BUILD_MOUSEAREA (uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD_MOUSEAREA")

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

//move
MCC_fnc_baseResourceReduce =
{
	private ["_resToCheck","_var","_level","_res"];
	//removes resources

	_res = _this select 0;
	_resToCheck = call compile format ["MCC_res%1",playerSide];
	{
		_var   = _x select 0;
		_level = _x select 1;

		switch (tolower _var) do
					{
						case "ammo": {_resToCheck set [0,(_resToCheck select 0)-_level]};
						case "repair": {_resToCheck set [1,(_resToCheck select 1)-_level]};
						case "fuel": {_resToCheck set [2,(_resToCheck select 2)-_level]};
						case "food": {_resToCheck set [3,(_resToCheck select 3)-_level]};
						case "med": {_resToCheck set [4,(_resToCheck select 4)-_level]};
						case "time": {};
					};
	} foreach _res;

	missionNameSpace setVariable [format ["MCC_res%1",playerSide],_resToCheck];
	publicVariable format ["MCC_res%1",playerSide];
};

MCC_fnc_baseSelected = 										//<------------ TODO move to fnc
{
	private ["_obj","_constType","_cfgtext","_text","_disp","_availableActions","_availableUpgrades","_availableBuildings"];
	disableSerialization;
	_obj  = _this select 0;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	if (_obj iskindof "logic") then
	{
		_constType 	= format ["MCC_rts_%1%2",(_obj getVariable ["mcc_constructionItemType",""]),(_obj getVariable ["mcc_constructionItemTypeLevel",1])];

		if (MCC_isMode) then
		{
			_cfgtext = [getText (configFile >> "cfgRtsBuildings" >> _constType >> "displayName"),getText (configFile >> "cfgRtsBuildings" >> _constType >> "descriptionShort")];
			_availableUpgrades = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "upgradeTo");
			_availableBuildings = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "buildings");
			_availableActions = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "actions");
		}
		else
		{
			_cfgtext = [getText (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "displayName"),getText (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "descriptionShort")];
			_availableUpgrades = getArray (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "upgradeTo");
			_availableBuildings = getArray (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "buildings");
			_availableActions = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "actions");
		};

		//Add text
		if !(isnil "_cfgtext") then
		{
			_text = format ["<t color='#ff0000' underline='true'>%1</t><br />%2",(_cfgtext select 0),(_cfgtext select 1)];
			(_disp displayCtrl 150) ctrlSetStructuredText parseText _text;
		};

		//diable actions/upgrades while under construction
		if ((_obj getVariable ["mcc_constructionStartTime",time]) + (_obj getVariable ["mcc_constructionendTime",0])> time) then
		{
			_availableUpgrades 	= [];
			_availableActions 	= [];
			_availableBuildings = [];
		};


		private ["_available","_resToCheck","_pic","_res","_req","_var","_level","_facility","_buildings"];

		//what can we build
		_buildings = (getpos _obj) nearEntities [["logic"], 200];

		//Let see what we already built
		_facility = [];
		{
			_var = _x getVariable ["mcc_constructionItemType",""];
			_level = _x getVariable ["mcc_constructionItemTypeLevel",1];
			if (_var != "" && !(isNull attachedTo _x)) then
			{
				_facility pushBack [_var,_level];
			};
		} foreach _buildings;

		//Populate upgrades
		for "_i" from 160 to 162 do
		{
			_ctrl = (_disp displayCtrl _i);
			if (count _availableUpgrades > 0) then
			{
				//Resize array
				_action = _availableUpgrades select 0;
				_availableUpgrades set [0,-1];
				_availableUpgrades = _availableUpgrades - [-1];

				//Get CFG
				if (MCC_isMode) then
				{
					_constType = getText (configFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (configFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (configFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (configFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				}
				else
				{
					_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				};

				_ctrl ctrlShow true;
				_ctrl ctrlSetText _pic;
				missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

				//Now let see if we enable the contorl
				_available = true;
				{
					_var   = _x select 0;
					_level = _x select 1;

					if (({(_x select 0) == _var && (_x select 1) >= _level}count _facility)<=0) exitWith {_available = false};
				} foreach _req;

				//Do we have the resources
				if (_available) then
				{
					_resToCheck = call compile format ["MCC_res%1",playerSide];
					{
						_var   = _x select 0;
						_level = _x select 1;

						_available = switch (tolower _var) do
									{
										case "ammo": {if ((_resToCheck select 0)>=_level) then {true} else {false}};
										case "repair": {if ((_resToCheck select 1)>=_level) then {true} else {false}};
										case "fuel": {if ((_resToCheck select 2)>=_level) then {true} else {false}};
										case "food": {if ((_resToCheck select 3)>=_level) then {true} else {false}};
										case "med": {if ((_resToCheck select 4)>=_level) then {true} else {false}};
										case "time": {true};
									};
						if (!_available) exitWith {};
					} foreach _res;
				};

				if (_available) then
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 1];
				}
				else
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 0.4];
				};

				//remove
				_ctrl ctrlRemoveAllEventHandlers "MouseButtonClick";
				_ctrl ctrlRemoveAllEventHandlers "MouseHolding";
				_ctrl ctrlRemoveAllEventHandlers "MouseExit";

				//add EH
				if (_available) then
				{
					_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[MCC_CONST_SELECTED, false] call MCC_fnc_rtsClearBuilding; [[getpos MCC_CONST_SELECTED, getdir MCC_CONST_SELECTED,'%1', 1, playerside],'MCC_fnc_construct_base',false] call bis_fnc_MP;",_action]];
				};
				_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
				_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
			}
			else
			{
				_ctrl ctrlShow false;
			};
		};

		//Populate buildings
		for "_i" from 101 to 103 do
		{
			_ctrl = (_disp displayCtrl _i);
			if (count _availableBuildings > 0) then
			{
				//Resize array
				_action = _availableBuildings select 0;
				_availableBuildings set [0,-1];
				_availableBuildings = _availableBuildings - [-1];

				//Get CFG
				if (MCC_isMode) then
				{
					_constType = getText (configFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (configFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (configFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (configFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				}
				else
				{
					_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				};

				_ctrl ctrlShow true;
				_ctrl ctrlSetText _pic;
				missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

				//Now let see if we enable the contorl
				_available = false;
				{
					_var   = _x select 0;
					_level = _x select 1;

					if (({(_x select 0) == _var && (_x select 1) >= _level}count _facility)>0) exitWith {_available = true};
				} foreach _req;

				//Do we have the resources
				if (_available) then
				{
					_resToCheck = call compile format ["MCC_res%1",playerSide];
					{
						_var   = _x select 0;
						_level = _x select 1;

						_available = switch (tolower _var) do
									{
										case "ammo": {if ((_resToCheck select 0)>=_level) then {true} else {false}};
										case "repair": {if ((_resToCheck select 1)>=_level) then {true} else {false}};
										case "fuel": {if ((_resToCheck select 2)>=_level) then {true} else {false}};
										case "food": {if ((_resToCheck select 3)>=_level) then {true} else {false}};
										case "med": {if ((_resToCheck select 4)>=_level) then {true} else {false}};
										case "time": {true};
									};
						if (!_available) exitWith {};
					} foreach _res;
				};

				if (_available) then
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 1];
				}
				else
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 0.4];
				};

				//remove
				_ctrl ctrlRemoveAllEventHandlers "MouseButtonClick";
				_ctrl ctrlRemoveAllEventHandlers "MouseHolding";
				_ctrl ctrlRemoveAllEventHandlers "MouseExit";

				//add EH
				if (_available) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0,'%1'] call MCC_fnc_baseActionClicked",_action]]};
				_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
				_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
			}
			else
			{
				_ctrl ctrlShow false;
			};
		};

		//Populate actions
		for "_i" from 104 to 112 do
		{
			_ctrl = (_disp displayCtrl _i);
			if (count _availableActions > 0) then
			{
				//Resize array
				_action = _availableActions select 0;
				_availableActions set [0,-1];
				_availableActions = _availableActions - [-1];

				//Get CFG
				if (MCC_isMode) then
				{
					_constType = getText (configFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (configFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (configFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (configFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				}
				else
				{
					_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "constType");
					_pic = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "picture");
					_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "resources");
					_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
				};

				_ctrl ctrlShow true;
				_ctrl ctrlSetText _pic;
				missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

				//Now let see if we enable the contorl
				_available = false;
				{
					_var   = _x select 0;
					_level = _x select 1;

					if (({(_x select 0) == _var && (_x select 1) >= _level}count _facility)>0) exitWith {_available = true};
				} foreach _req;

				//Do we have the resources
				if (_available) then
				{
					_resToCheck = call compile format ["MCC_res%1",playerSide];
					{
						_var   = _x select 0;
						_level = _x select 1;

						_available = switch (tolower _var) do
									{
										case "ammo": {if ((_resToCheck select 0)>=_level) then {true} else {false}};
										case "repair": {if ((_resToCheck select 1)>=_level) then {true} else {false}};
										case "fuel": {if ((_resToCheck select 2)>=_level) then {true} else {false}};
										case "food": {if ((_resToCheck select 3)>=_level) then {true} else {false}};
										case "med": {if ((_resToCheck select 4)>=_level) then {true} else {false}};
										case "time": {true};
									};
						if (!_available) exitWith {};
					} foreach _res;
				};

				if (_available) then
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 1];
				}
				else
				{
					_ctrl ctrlSetTextColor [1, 1, 1, 0.4];
				};

				//remove
				_ctrl ctrlRemoveAllEventHandlers "MouseButtonClick";
				_ctrl ctrlRemoveAllEventHandlers "MouseHolding";
				_ctrl ctrlRemoveAllEventHandlers "MouseExit";

				//add EH
				if (_available) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0,'%1'] call MCC_fnc_baseActionClicked",_action]]};
				_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
				_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
			}
			else
			{
				_ctrl ctrlShow false;
			};
		};
	};
};

MCC_fnc_rtsClearBuilding =				//<------------ TODO move to fnc
{
	private ["_module","_deleteModule","_anchor"];
	_module			= [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_deleteModule 	= [_this, 1, true, [true]] call BIS_fnc_param;

	_anchor = _module getVariable ["mcc_construction_anchor",objNull];

	{deletevehicle _x} foreach (attachedObjects _anchor);
	deletevehicle _anchor;
	if (_deleteModule) then
	{
		deletevehicle _module;
	};
};

MCC_fnc_baseActionClicked = 										//<------------ TODO move to fnc
{
	private ["_ctrl","_ctrlText","_cfgName"];
	disableSerialization;
	_ctrl 		= _this select 0;
	_ctrlText 	= _this select 1;

	if (_ctrlText == "") exitWith {};

	_cfgName = missionNamespace getVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],""];
	if (isnull MCC_CONST_PLACEHOLDER) then
	{
		MCC_CONST_PLACEHOLDER = "CamoNet_BLUFOR_big_Curator_F" createVehicleLocal [0,0,100];
	};
	MCC_CONST_PLACEHOLDER setVariable ["MCC_baseBuildingToBuild",_cfgName];
};

MCC_fnc_baseActionEntered = 										//<------------ TODO move to fnc
{
	private ["_ctrl","_ctrlPic","_ctrlText","_disp","_text","_res","_action","_cfgtext","_cfgName","_reqText","_req"];
	disableSerialization;

	_ctrl 		= (_this select 0) select 0;
	_ctrlText 	= _this select 1;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	_cfgName = missionNamespace getVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],""];

	if (MCC_isMode) then
	{
		_cfgtext = [getText (configFile >> "cfgRtsBuildings" >> _cfgName >> "displayName"),getText (configFile >> "cfgRtsBuildings" >> _cfgName >> "descriptionShort")];
		_res = getArray (configFile >> "cfgRtsBuildings" >> _cfgName >> "resources");
		_req = getArray (configFile >> "cfgRtsBuildings" >> _cfgName >> "requiredBuildings");
	}
	else
	{
		_cfgtext = [getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "displayName"),getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "descriptionShort")];
		_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "resources");
		_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgName >> "requiredBuildings");
	};

	_reqText = "";
	{
		if (_forEachIndex != 0) then {_reqText = _reqText + ", "};
		_reqText = _reqText + (if (MCC_isMode) then
		                {
		                 	getText (configFile >> "cfgRtsBuildings" >> (format ["MCC_rts_%1%2",_x select 0,_x select 1]) >> "displayName");
						}
						else
						{
							getText (missionconfigFile >> "cfgRtsBuildings" >> (format ["MCC_rts_%1%2",_x select 0,_x select 1]) >> "displayName");
						});

	} forEach _req;

	_text = format ["<t color='#ff0000' underline='true'>%1</t><br />%2 <br /><t color='#ff0000'>Requires: %3</t>",(_cfgtext select 0),(_cfgtext select 1),_reqText];

	//Populate Resources
	for [{_i= 121},{_i <= 127},{_i = _i + 2}] do
	{
		_ctrl 		= (_disp displayCtrl _i);
		_ctrlPic	= (_disp displayCtrl (_i-1));
		if (count _res > 0) then
		{
			_action = _res select 0;
			_res set [0,-1];
			_res = _res - [-1];

			_ctrl ctrlShow true;
			_ctrlPic ctrlShow true;

			_ctrl ctrlSetText str(_action select 1);
			_ctrlPic ctrlSetText (format["%1data\Icon%2.paa",MCC_path,(_action select 0)]);
		}
		else
		{
			_ctrl ctrlShow false;
			_ctrlPic ctrlShow false;
		};
	};

	//Add text
	(_disp displayCtrl 150) ctrlSetStructuredText parseText _text;
};

MCC_fnc_baseActionExit = 										//<------------ TODO move to fnc
{
	private ["_ctrl","_ctrlText","_disp","_text"];
	disableSerialization;

	_ctrl = (_this select 0) select 0;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	//Remove text
	(_disp displayCtrl 150) ctrlSetStructuredText parseText"";

	//Hide resources
	for "_i" from 120 to 127 do {(_disp displayCtrl _i) ctrlShow false};
};

//Change into construction by default
MCC_fnc_baseOpenConstMenu = 										//<------------ TODO move to fnc
{
	private ["_disp","_buildings","_center","_radius","_ctrl","_availableActions","_res","_constType",
	         "_pic","_available","_facility","_req","_var","_level","_resToCheck"];
	disableSerialization;

	_center = _this select 0;
	_radius = _this select 1;
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	//what can we build
	_buildings = _center nearEntities [["logic"], _radius];

	//filter not needed buildings
	for "_i" from 0 to (count _buildings)-1 do
	{
		if (((_buildings select _i) getVariable ["mcc_constructionItemType",""]) == "") then {_buildings set [_i,-1]};
	};

	_buildings = _buildings - [-1];

	//Let see what we already built
	_facility = [];
	{
		_var = _x getVariable ["mcc_constructionItemType",""];
		_level = _x getVariable ["mcc_constructionItemTypeLevel",1];
		if (_var != "" && !(isNull attachedTo _x)) then
		{
			_facility pushBack [_var,_level];
		};
	} foreach _buildings;

	//Hide upgrades
	for "_i" from 160 to 163 do
	{
		(_disp displayCtrl _i) ctrlShow false;
	};

	//Hide actions
	for "_i" from 101 to 112 do
	{
		(_disp displayCtrl _i) ctrlShow false;
	};
};
[_startPos, _size*2] call MCC_fnc_baseOpenConstMenu;



//Create borders
MCC_fnc_baseBuildBorders = 										//<------------ TODO move to fnc
{
	private ["_center","_oldBorder","_border","_width","_pi","_perimeter","_size","_wallcount","_total","_centerObj","_dir","_xpos","_ypos","_zpos","_a"];
	disableSerialization;

	_center = position (_this select 0);
	_size 	= _this select 1;

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
			_list = (screenToWorld [_posX,_posY]) nearEntities ["logic", 20];
			if (count _list > 0) then
			{
				if (MCC_CONST_SELECTED != _list select 0) then
				{
					MCC_CONST_SELECTED = _list select 0;
					[MCC_CONST_SELECTED] spawn MCC_fnc_baseSelected;
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