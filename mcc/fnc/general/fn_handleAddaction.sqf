//==================================================================MCC_fnc_handleAddaction=====================================================================================
// handle add action
// Examp: [] call MCC_fnc_handleAddaction;
// <in> Nothing
//<out> Nothing
//==============================================================================================================================================================================
private ["_string","_respawnItems","_airports","_counter","_searchArray","_key","_text"];

//Interactive objects EH
uiNameSpace setVariable ["MCC_interactionActive",false];

["MCC_interactionEH", "onEachFrame", {
		if !(missionNameSpace getVariable ["MCC_ingameUI", true]) exitWith {};
		_interactiveObjects = missionNameSpace getVariable ["MCC_interactionObjects",[]];
		{
			_obj 	= _x select 0;
			_text 	= _x select 1;
			_dist 	= (player distance _obj) / 10;
			_color  = [1,0,1,1 - _dist];
			drawIcon3D [
							"",
							_color,
							[
								_obj select 0,
								_obj select 1,
								(_obj select 2)
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
_text = "";
waituntil {!(IsNull (findDisplay 46))};

if ((MCC_isACE) && MCC_isMode) then {
	_key = ["ACE3 Common","ace_interact_menu_InteractKey"] call MCC_fnc_getKeyFromCBA;
} else {
	if (MCC_isCBA) then {
		_key = ["MCC","interactionKey"] call CBA_fnc_getKeybind;
		if (((_key select 5) select 1) select 0) then {_text = "Shift + "};
		if (((_key select 5) select 1) select 1) then {_text = _text + "Ctrl + "};
		if (((_key select 5) select 1) select 2) then {_text = _text + "Alt + "};
		_text = format ["%1%2",_text,keyName ((_key select 5) select 0)];

	} else {
		waituntil {!isnil "MCC_keyBinds"};

		_key = MCC_keyBinds select 4;
		if (_key select 0) then {_text = "Shift + "};
		if (_key select 1) then {_text = _text + "Ctrl + "};
		if (_key select 2) then {_text = _text + "Alt + "};
		_text = format ["%1%2",_text,keyName (_key select 3)];
	};
};


_text spawn
{
	private ["_keyName","_interactiveObjects","_objects","_selected","_dir","_text","_tested","_ingameText"];
	_keyName = _this;

	while {alive player} do
	{
		if (vehicle player == player) then
		{
			_objects = player nearObjects ["UserTexture1m_F",7];
			_interactiveObjects = [];

			//Handle Objects
			if (count _objects > 0) then
			{
				_selected = objnull;
				{
					_tested = ([_objects,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy) select _foreachIndex;
					_dir	  = [player, _tested] call BIS_fnc_relativeDirTo;
					if (_dir>340 || _dir < 20) exitWith {_selected = _tested};
				} foreach _objects;

				if (!isnull _selected) then
				{
					//IED
					_text =_selected getVariable ["MCC_helperText",""];
					if ((_text != "") && !(_selected getVariable ["MCC_isInteracted",false])) then
					{
						_interactiveObjects set [count _interactiveObjects, [getpos _selected,format [_text,_keyName]]];
					};
				};
			};
			missionNameSpace setVariable ["MCC_interactionObjects",_interactiveObjects];
		};

		_ingameText = vehicle player getVariable ["MCC_ingameText",""];
		if (_ingameText != "") then {
			titleText [_ingameText,"PLAIN DOWN"];
			titleFadeOut 1;
			vehicle player setVariable ["MCC_ingameText",""];
		};
		sleep 1;
	};
};

//Add MCC respawn tent string
if (MCC_isMode) then
{
	if ((player getVariable ["MCC_actionRespawnTent",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionRespawnTent",nil])};
	_respawnItems = ["MCC_TentDome","MCC_TentA"];	//respawn items
	_string = format ["secondaryWeapon _target in %1 && (vehicle _target == vehicle _this) && (leader _this == _this)",_respawnItems];
	_null = player addaction ["<t color=""#FFCC00"">Assemble respawn tent</t>", MCC_path + "mcc\general_scripts\respawnTents\DeployRespawnTents.sqf",[],-1,false,true,"",_string];
	player setVariable ["MCC_actionRespawnTent",_null];
};

if (missionNamespace getvariable ["MCC_showActionKey",true]) then
{
	/*
	if !(MCC_isACE && MCC_isMode) then {
		//Add MCC Comander
		if ((player getVariable ["MCC_actionCommander",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionCommander",nil])};
		_string = format ["((MCC_server getVariable ['CP_commander%1','']) == getPlayerUID _this )&& (vehicle _target == vehicle _this) && (missionNamespace getVariable ['MCC_allowConsole',true]) && (missionNamespace getvariable ['MCC_showActionKey',true])",side player];
		_null = player addaction ["<t color=""#FFCC01"">Commander - Console</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,1],-1,false,true,"",_string];
		player setVariable ["MCC_actionCommander",_null];

		//Add MCC Squad leader PDA
		if ((player getVariable ["MCC_actionSQLpda",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionSQLpda",nil])};
		_string = "((count units _this > 1) && (leader _this == _this)) && (missionNamespace getVariable ['MCC_allowsqlPDA',true]) && 'ItemGPS' in (assignedItems _this) && (missionNamespace getvariable ['MCC_showActionKey',true])";
		_null = player addaction ["<t color=""#FFCC01"">Squad Leader - PDA</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,3],-1,false,true,"",_string];
		player setVariable ["MCC_actionSQLpda",_null];
	};
	*/
	// Add MCC to the action menu
	if ((player getVariable ["MCC_actionMCCMain",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionMCCMain",nil])};
	_string = "(vehicle _target == vehicle _this) && (getplayerUID player in (missionNamespace getvariable ['MCC_allowedPlayers',[]]) || 'all' in  (missionNamespace getvariable ['MCC_allowedPlayers',['all']]) || (serverCommandAvailable '#logout' && missionNamespace getvariable ['MCC_allowAdmin',true]) || (isServer && missionNamespace getvariable ['MCC_allowAdmin',true]) || (player getvariable ['MCC_allowed',false])) && (missionNamespace getvariable ['MCC_showActionKey',true])";
	mcc_actionInedx = player addaction ["<t color=""#99FF00"">--= MCC =--</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,0], 0,false, false, "",_string];
	player setVariable ["MCC_actionMCCMain",mcc_actionInedx];
};