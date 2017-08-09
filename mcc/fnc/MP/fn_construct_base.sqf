//==================================================================MCC_fnc_construct_base=============================================================================
// Example:[_pos, _anchorDir , _anchorType, _BuildTime, _side]  call  MCC_fnc_construct_base;
//======================================================================================================================================================================
private ["_cfgClass","_anchorType","_anchorDir","_pos","_objs","_constType","_anchor","_object","_BuildTime","_buildingObjs","_builtArray","_side","_level","_instant","_endTime","_boxName","_boxArray","_box","_text","_res","_displayName","_markerName","_root"];
#define BASE_ANCHOR "UserTexture10m_F"
#define ANCHOR_ITEM "Land_TreeBin_F"

_pos			= _this select 0;
_anchorDir 		= _this select 1;
_cfgClass		= _this select 2;
_BuildTime		= _this select 3;
_side			= _this select 4;

_instant = if (_BuildTime <=0) then {true} else {false};

//Wait for mission start
waituntil {time > 0};

if (typeName _side == "STRING") then {
	_side = switch (toupper _side) do
			{
				case "WEST":		{west};
				case "EAST":		{east};
				case "GUER":	{resistance};
				default     	{civilian};
			};
};

_root = if (isClass (missionconfigFile >> "cfgRtsBuildings")) then {missionconfigFile >> "cfgRtsBuildings" >> _cfgClass} else {configFile >> "cfgRtsBuildings" >> _cfgClass};

_anchorType = getText (_root >> "anchorType");
_constType = getText (_root >> "constType");
_level = getNumber (_root >> "level");
_res = getArray (_root >> "resources");
_objs = getArray (_root >> "objectsArray");
_displayName = getText (_root >> "displayName");


{
	if ((_x select 0)=="time") exitWith {_BuildTime = (_x select 1)};
} foreach _res;

_buildingObjs = [
					["Land_Pipes_large_F", [-7,0,-1],70],
					["Land_Pallets_stack_F",[7,0,-0.4],70],
					["Land_Bricks_V1_F", [0,7,-1],70],
					[ANCHOR_ITEM, [0,-7,-1],-70]
                ];

if (isnil "_constType") exitWith {};

//Build module
/*
if (isNil "MCC_dummyLogicGroup") then {MCC_dummyLogicGroup = createGroup sideLogic};
_module = MCC_dummyLogicGroup createunit ["Logic", _pos,[],0.5,"NONE"];
*/
_module = BASE_ANCHOR createVehicle _pos;

_module setVariable ["mcc_constructionItemType",_constType,true];
_module setVariable ["mcc_constructionItemTypeLevel",_level,true];
_module setVariable ["mcc_side",_side,true];
_module setVariable ["cfgClass",_cfgClass,true];
_module setVariable ["mcc_delete",false,true];

//Create marker
_markerName = format ["ConstCounter_%1",["MCC_ConstCounter_",1] call bis_fnc_counter];
_module setVariable ["mcc_markerName",_markerName,true];

[[[_markerName], _pos, "colorGreen", "loc_Bunker",_displayName,false],"BIS_fnc_markerCreate", _side,false] call BIS_fnc_MP;

//Building anim
if !(_instant) then {
	_anchor = ANCHOR_ITEM createVehicle _pos;
	waituntil {!isnil "_anchor"};
	_anchor enableSimulation false;
	_builtArray = [_anchor];
	_anchor setdir _anchorDir;

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
_anchor setVariable ["mcc_delete",false,true];

//Attach module to anchor
_module attachto [_anchor,[0,0,0]];
_module setVariable ["mcc_construction_anchor",_anchor,true];

//Handle damage
if (_constType != "hq") then {
	_anchor AddEventHandler ["HandleDamage",
								 {
									_obj 		= _this select 0;
									_damage		= _this select 2;
									_source 	= _this select 3;
									_ammo		= _this select 4;
									_side		= _obj getVariable ["mcc_side",sidelogic];
									_text = "<img size='5' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa'/><br/><br/><t align='center' size='1.8' color='#FFCF11'> Enemy forces are attacking your base</t><br/>";

									if (_ammo in ["SatchelCharge_Remote_Ammo","SatchelCharge_Remote_Ammo_Scripted"] && _damage > 0.6) then
									{

										{detach _x; deleteVehicle _x} foreach attachedObjects _obj;
										deleteVehicle _obj;
										[[[_side], {player addRating (if (playerside != (_this select 0)) then {500} else {-1000})}], "BIS_fnc_spawn", _source, false] spawn BIS_fnc_MP;

										[[_text,true],"MCC_fnc_globalHint",_side,false] spawn BIS_fnc_MP;

									} else {0};
								}
							];
} else {
	_anchor AddEventHandler ["HandleDamage",{}];
};

for "_i" from 0 to ((count _objs) - 1) do {
	_object = nil;
	_object = ((_objs select _i) select  0) createVehicle [0,0,0];
	waituntil {!isnil "_object"};
	for "_x" from 1 to 2 do
	{
		_object attachTo [_anchor,((_objs select _i) select  1)];
		_object setVectorDirAndUp  ((_objs select _i) select  2);
	};
	_object setVariable ["mcc_delete",false,true];
	_object AddEventHandler ["HandleDamage", {}];
};

//find the main box and add helper
if (_constType == "hq") then {
	[_side, _object] call MCC_fnc_makeObjectVirtualBox
};

if (_constType in ["workshop","barracks"]) then {
	[_side, _module,_constType] remoteExec ["MCC_fnc_initWorkshop",2];
};