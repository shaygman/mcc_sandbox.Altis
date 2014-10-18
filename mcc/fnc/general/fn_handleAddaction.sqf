//==================================================================MCC_fnc_handleAddaction===============================================================================================
// handle add action 
// Examp: [] call MCC_fnc_handleAddaction; 
// <in> Nothing
//<out> Nothing
//==============================================================================================================================================================================	
private ["_string","_respawnItems","_airports","_counter","_searchArray","_key","_textKey","_text"];

//Interactive objects EH
uiNameSpace setVariable ["MCC_interactionActive",false];  

["MCC_interactionEH", "onEachFrame", {
		_interactiveObjects = missionNameSpace getVariable ["MCC_interactionObjects",[]];
		{
			_obj 	= _x select 0;
			_text 	= _x select 1;
			_dist 	= (player distance _obj) / 10;
			_color = [1,1,1,1 - _dist];
			drawIcon3D [
							"",
							_color,
							[
								_obj select 0,
								_obj select 1,
								(_obj select 2) + _dist / 5
							],
							0,
							0,
							0,
							_text,
							2,
							0.06,
							"PuristaMedium"
						];
		} foreach _interactiveObjects;
	}, ""] call BIS_fnc_addStackedEventHandler;

	
//Find out interaction key name
waituntil {!isnil "MCC_keyBinds"};
_key = MCC_keyBinds select 4;
_text = "";
if (_key select 0) then {_text = "Shift + "}; 
if (_key select 1) then {_text = _text + "Ctrl + "}; 
if (_key select 2) then {_text = _text + "Alt + "}; 
_textKey = 	[(_key select 3)] call MCC_fnc_keyToName;
_text = format ["%1%2",_text,_textKey];
		
_text spawn
{
	private ["_keyName","_interactiveObjects","_objects","_selected","_dir","_positionStart","_positionEnd","_pointIntersect"];
	_keyName = _this; 
	
	while {alive player} do
	{
		sleep 1;
		_interactiveObjects = [];
		if (vehicle player == player) then
		{
			_objects = player nearObjects [MCC_dummy,5];
	
			//Handle Objects
			if (count _objects > 0) then
			{
				_selected = ([_objects,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy) select 0;
				_dir	  = [player, _selected] call BIS_fnc_relativeDirTo;
				if (_dir>340 || _dir < 20) then 
				{
					//IED
					if (((_selected getVariable ["MCC_IEDtype",""]) == "ied") && !(_selected getVariable ["MCC_isInteracted",false])) then
					{
						_interactiveObjects set [count _interactiveObjects, [getpos _selected,format ["Hold %1 to disarm",_keyName]]];
					};
				};
			};
			
			//Not MCC object
			_positionStart 	= eyePos player;
			_positionEnd 	= ATLtoASL screenToWorld [0.5,0.5];
			_pointIntersect = lineIntersectsWith [_positionStart, _positionEnd, player, objNull, true];
			if (count _pointIntersect > 0) then
			{
				_selected = _pointIntersect select ((count _pointIntersect)-1);
				if (player distance _selected < 5 && (typeOf _selected == "")) then
				{
					_interactiveObjects set [count _interactiveObjects, [getpos _selected,format ["Hold %1 to search",_keyName]]];
				};
			};
	
			missionNameSpace setVariable ["MCC_interactionObjects",_interactiveObjects];
		};
	};
};

//Add MCC respawn tent string
if (MCC_isMode) then
{
	_respawnItems = ["MCC_TentDome","MCC_TentA"];	//respawn items
	_string = format ["secondaryWeapon _target in %1 && (vehicle _target == vehicle _this) && (leader _this == _this)",_respawnItems]; 
	_null = player addaction ["<t color=""#FFCC00"">Assemble respawn tent</t>", MCC_path + "mcc\general_scripts\respawnTents\DeployRespawnTents.sqf",[],-1,false,true,"teamSwitch",_string];
};

//Add MCC Comander
_string = format ["((MCC_server getVariable ['CP_commander%1','']) == getPlayerUID _this )&& (vehicle _target == vehicle _this) && MCC_allowConsole",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Commander - Console</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,1],-1,false,true,"teamSwitch",_string];

//Add MCC Squad leader PDA
_string = format ["(count units _this > 1) && (leader _this == _this) && ('ItemGPS' in (assignedItems _this)) && (vehicle _target == vehicle _this) && MCC_allowsqlPDA",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Squad Leader - PDA</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,3],-1,false,true,"teamSwitch",_string];

// Add MCC to the action menu
if (getplayerUID player in MCC_allowedPlayers || "all" in MCC_allowedPlayers || serverCommandAvailable "#logout" || isServer || (player getvariable ["MCC_allowed",false])) then 
{
	mcc_actionInedx = player addaction ["<t color=""#99FF00"">--= MCC =--</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,0], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
	player setvariable ["MCC_allowed",true,true];
};