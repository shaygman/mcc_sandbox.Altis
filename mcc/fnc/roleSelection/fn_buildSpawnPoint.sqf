//================================================================MCC_fnc_buildSpawnPoint======================================================================================
//Create a spawn point to the given side - SERVER ONLY
// Example: [[pos, dir, side,size,destructable], "MCC_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
// pos: Array, position
// dir; number, direction
// side: string, "west", "east" or "GUER"
// size: string  "FOB" or  "HQ"
// destructable: Boolean
//==============================================================================================================================================================================
private ["_side","_size","_destructable","_building","_dummy","_sphere","_dir","_animate","_flag","_flagTex","_name","_logic","_pos"];
if ((typeName (_this select 0)) == "OBJECT") then
{
	_logic			= _this select 0;
	_pos			= getpos _logic;
	_dir			= getdir _logic;

	_side 			= (_logic getvariable ["side",0]) call bis_fnc_sideType;
	_size 			= toupper (_logic getvariable ["size","FOB"]);
	_destructable	= _logic getvariable ["distractable",true];
	_animate		= false;

}
else
{
	_pos			= _this select 0;
	_dir			= _this select 1;
	_side 			= _this select 2;
	_size 			= toupper (_this select 3);
	_destructable	= _this select 4;
	_animate		= if (count _this > 5) then {_this select 5} else {false};
};


#define REQUIRE_MEMBERS 3

if (isServer) then
{
	if (typeName _side == "STRING") then
	{
		_side = switch (toupper _side) do
				{
					case "WEST":		{west};
					case "EAST":		{east};
					case "GUER":	{resistance};
					default     	{civilian};
				};
	};

	//animate the process of building a FOB
	if (_animate) then
	{
		//Phase 1
		private ["_anchor","_prop","_class","_modelWorld","_objects","_propPos","_newObjects","_anchorPos","_time"];
		_anchor = "Land_PaperBox_closed_F" createvehicle _pos;

		_objects = [];
		{
			_class = _x select 0;
			_modelWorld = _x select 1;
			_prop = _class createvehicle (_anchor modelToworld _modelWorld);
			_objects set [count _objects, _prop];
		} foreach [["Land_PaperBox_closed_F",[4,0,0]],["Land_PaperBox_closed_F",[-4,0,0]],["Land_PaperBox_closed_F",[0,-4,0]]];

		_finished = false;
		_newObjects = [];
		_time = floor diag_ticktime;
		while {!_finished} do
		{
			sleep 1;
			if (_time !=  floor diag_ticktime) then
			{
				_time = floor diag_ticktime;

				//How many players from my side are near
				_nearby = {alive _x && {side _x == _side}} count (getPosATL _anchor nearEntities ["CAManBase", 50]);

				if (count _objects == 0) then
				{
					_finished = true;
					deletevehicle _anchor;
					{deletevehicle _x; sleep 1} foreach _newObjects;
				};

				if ((_time % 20 == 0) && _nearby > REQUIRE_MEMBERS && count _objects > 0) then
				{
					if (typeof _anchor == "Land_PaperBox_closed_F") then
					{
						_anchorPos = getposATL _anchor;
						deletevehicle _anchor;
						_anchor = "Land_FishingGear_01_F" createvehicle _anchorPos;
					}
					else
					{
						_prop = _objects select 0;
						_propPos = getposATL _prop;
						deletevehicle _prop;
						_prop = "Land_Sacks_heap_F" createvehicle _propPos;
						_newObjects set [count _newObjects, _prop];
						_objects set [0,-1];
						_objects = _objects - [-1];
					};
				};
			};
		};
	};

	switch (_side) do
	{
		case west:	//west
		{
			if (_size == "FOB") then
			{
				_building = "Land_BagBunker_Tower_F";
				_flagTex = CP_flagWest;
			}
			else
			{
				_building = "ProtectionZone_Invisible_F";
				_flagTex = CP_flagWest;
			};
		};

		case east:	//east
		{
			if (_size == "FOB") then
			{
				_building = "Land_BagBunker_Tower_F";
				_flagTex = CP_flagEast;
			}
			else
			{
				_building = "ProtectionZone_Invisible_F";
				_flagTex = CP_flagEast;
			};
		};
		case resistance:	//east
		{
			if (_size == "FOB") then
			{
				_building = "Land_BagBunker_Tower_F";
				_flagTex = CP_flagGUER;
			}
			else
			{
				_building = "ProtectionZone_Invisible_F";
				_flagTex = CP_flagGUER;
			};
		};

		default
		{
			_building = "ProtectionZone_Invisible_F";
			_flagTex = CP_flagGUER;
		};
	};

	_dummy = _building createvehicle _pos;
	_dummy setdir _dir;
	_dummy setVariable ["mcc_delete",false,true];

	_flag = "FlagPole_F" createvehicle _pos;
	sleep 0.5;
	_flag setFlagTexture _flagTex;

	_dummy setvariable ["type",_size,true];
	_dummy setvariable ["side",_side,true];
	_dummy setvariable ["mcc_flag",_flag,true];
	_dummy setVariable ["mcc_delete",false,true];

	//If is FOB
	if (_size == "FOB") then
	{
		//Attach flag
		_flag attachto [_dummy,[2.8,2,1.5]];

		//Only destroyable with satchel or demo charges
		_dummy addEventHandler ["handledamage",{
										if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted"]) then
										{
											private ["_obj","_mark","_flag","_side"];
											_obj = _this select 0;
											_obj setVariable ["dead",true,true];
											_mark = _obj getVariable ["mcc_fob_name",""];
											_side = _obj getVariable ["side",civilian];

											[compile format ['deleteMarker "%1";',_mark],"BIS_fnc_spawn", _side,false] call BIS_fnc_MP;

											_flag = _obj getVariable ["mcc_flag",objnull];
											if (!isnil "_flag") then
											{
												deletevehicle _flag;
											};
											deletevehicle _obj;
											1
										};
											}];

		_name = format ["FOB_%1",["MCC_fob_counter",1] call bis_fnc_counter];
		_dummy setvariable ["mcc_fob_name",_name, true];

		//Create marker
		[[[_name], _pos, "colorGreen", "loc_Bunker",_name,false],"BIS_fnc_markerCreate", _side,false] call BIS_fnc_MP;
	}
	else
	{
		//Not destroyable
		_dummy addEventHandler ["handledamage",{0}];
		missionNameSpace setVariable [format ["MCC_START_%1",_side],_pos];
		publicVariable format ["MCC_START_%1",_side];

		//Make it as  medic area
		_dummy spawn MCC_fnc_medicArea;
	};

	if (!_destructable) then
	{
		_sphere = "ProtectionZone_Invisible_F" createvehicle (getpos _dummy);
		_sphere setpos (getpos _dummy);
		_sphere setVariable ["mcc_delete",false,true];
	};

	[_side, _dummy] call BIS_fnc_addRespawnPosition;

};