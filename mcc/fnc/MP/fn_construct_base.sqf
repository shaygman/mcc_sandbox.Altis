//==================================================================MCC_fnc_construct_base======================================================================================
// Example:[_pos, _anchorDir , _anchorType, _BuildTime, _side]  call  MCC_fnc_construct_base;
//==============================================================================================================================================================================
private ["_cfgClass","_anchorType","_anchorDir","_pos","_objs","_constType","_anchor","_object","_BuildTime","_buildingObjs","_builtArray",
         "_side","_level","_instant","_endTime","_boxName","_boxArray","_box"];


_pos			= _this select 0;
_anchorDir 		= _this select 1;
_cfgClass		= _this select 2;
_BuildTime		= _this select 3;
_side			= _this select 4;

_instant = if (_BuildTime <=0) then {true} else {false};

//Do we have a box for our side?

if (MCC_isMode) then
{
	_anchorType = getText (configFile >> "cfgRtsBuildings" >> _cfgClass >> "anchorType");
	_constType = getText (configFile >> "cfgRtsBuildings" >> _cfgClass >> "constType");
	_level = getNumber (configFile >> "cfgRtsBuildings" >> _cfgClass >> "level");
	_res = getArray (configFile >> "cfgRtsBuildings" >> _cfgClass >> "resources");
	_objs = getArray (configFile >> "cfgRtsBuildings" >> _cfgClass >> "objectsArray");

	{
		if ((_x select 0)=="time") exitWith {_BuildTime = (_x select 1)};
	} foreach _res;
}
else
{
	_anchorType = getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgClass >> "anchorType");
	_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _cfgClass >> "constType");
	_level = getNumber (missionconfigFile >> "cfgRtsBuildings" >> _cfgClass >> "level");
	_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgClass >> "resources");
	_objs = getArray (missionconfigFile >> "cfgRtsBuildings" >> _cfgClass >> "objectsArray");

	{
		if ((_x select 0)=="time") exitWith {_BuildTime = (_x select 1)};
	} foreach _res;
};

if (_constType == "hq") then
{
	_boxName = format ["MCC_rtsMainBox%1",_side];
	_box = missionNamespace getVariable [_boxName,objNull];
	if !(isNull _box) then
	{
		_boxArray = _box getvariable ["MCC_virtual_cargo",[[],[],[],[]]];
	}
	else
	{
		_boxArray = [[],[],[],[]];
	};
};

_buildingObjs = [
					["Land_Pipes_large_F", [-7,0,-1],70],
					["Land_Pallets_stack_F",[7,0,-0.4],70],
					["Land_Bricks_V1_F", [0,7,-1],70],
					["Land_Bricks_V3_F", [0,-7,-1],-70]
                ];

if (isnil "_constType") exitWith {};
//Build module
if (isNil "MCC_dummyLogicGroup") then {MCC_dummyLogicGroup = createGroup sideLogic};
_module = MCC_dummyLogicGroup createunit ["Logic", _pos,[],0.5,"NONE"];
_module setVariable ["mcc_constructionItemType",_constType,true];
_module setVariable ["mcc_constructionItemTypeLevel",_level,true];

//Building anim
if !(_instant) then
{
	_anchor = "Land_Rampart_F" createVehicle _pos;
	waituntil {!isnil "_anchor"};

	_builtArray = [_anchor];
	_anchor setdir _anchorDir;
	s1 = _anchor;

	for "_i" from 0 to ((count _buildingObjs) - 1) do
	{
		_object = nil;
		_object = ((_buildingObjs select _i) select  0) createVehicle [0,0,0];
		waituntil {!isnil "_object"};
		_object attachTo [_anchor,((_buildingObjs select _i) select  1)];
		_object setdir ((getdir _anchor) + ((_buildingObjs select _i) select 2));
		_builtArray = _builtArray + [_object];
	};

	_module setVariable ["mcc_constructionendTime",_BuildTime,true];
	_module setVariable ["mcc_constructionStartTime",time,true];
	sleep _BuildTime;

	{deleteVehicle _x} foreach _builtArray;
	sleep 0.5;
};

//Build object
_anchor = _anchorType createVehicle _pos;
waituntil {!isnil "_anchor"};
_anchor setdir _anchorDir;
_anchor setVariable ["mcc_side",_side,true];

s1 = _anchor;		//TODO Remove

//Attach module to anchor
_module attachto [_anchor,[0,0,0]];
_module setVariable ["mcc_construction_anchor",_anchor,true];

_anchor AddEventHandler ["HandleDamage",
							 {
								_obj 		= _this select 0;
								_damage		= _this select 2;
								_source 	= _this select 3;
								_ammo		= _this select 4;
								_side		= _obj getVariable ["mcc_side",sidelogic];

								if (_ammo in ["SatchelCharge_Remote_Ammo"] && _damage > 0.6) then
								{

									{detach _x; deleteVehicle _x} foreach attachedObjects _obj;
									_obj setdamage 1;
									[[[_side], {player addRating (if (playerside != (_this select 0)) then {500} else {-1000})}], "BIS_fnc_spawn", _source, false] spawn BIS_fnc_MP;
								} else {0};
							}
						];

for "_i" from 0 to ((count _objs) - 1) do
{
	_object = nil;
	_object = ((_objs select _i) select  0) createVehicle [0,0,0];
	waituntil {!isnil "_object"};
	for "_x" from 1 to 2 do
	{
		_object attachTo [_anchor,((_objs select _i) select  1)];
		_object setVectorDirAndUp  ((_objs select _i) select  2);
	};
	_object AddEventHandler ["HandleDamage", {}];
};

//find the main box and add helper
if (_constType == "hq") then
{
	clearItemCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearBackpackCargoGlobal _object;
	_object setVariable ["MCC_virtual_cargo",_boxArray,true];
	[_object,"Hold %1 to open cargo box"] spawn MCC_fnc_createHelper;
};
//_this attachTo [s1,[0,0,0]]; _this setVectorDirAndUp [[0,1,0],[0,0,1]]