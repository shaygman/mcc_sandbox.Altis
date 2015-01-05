private ["_cmd","_comboBox","_groupName","_groupArray","_group","_array","_groups","_role","_activeGroup","_countRole","_minPlayersForRole","_roleLimit","_commander"];
disableSerialization;

#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD")
#define CP_squadPanelSquadList (uiNamespace getVariable "CP_squadPanelSquadList")
#define CP_squadPanelPlayersList (uiNamespace getVariable "CP_squadPanelPlayersList")
#define CP_squadsPanelActiveSquadTittle (uiNamespace getVariable "CP_squadsPanelActiveSquadTittle")
#define CP_squadPanelJoinButton (uiNamespace getVariable "CP_squadPanelJoinButton")
#define CP_squadPanelCreateSquadText (uiNamespace getVariable "CP_squadPanelCreateSquadText")
#define CP_squadPanelCreateSquadButton (uiNamespace getVariable "CP_squadPanelCreateSquadButton")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")
#define CP_Exit (uiNamespace getVariable "CP_Exit")
#define CP_respawnButton (uiNamespace getVariable "CP_respawnButton")
#define CP_squadButton (uiNamespace getVariable "CP_squadButton")
#define CP_gearButton (uiNamespace getVariable "CP_gearButton")
#define CP_switchSideButton (uiNamespace getVariable "CP_switchSideButton")
#define CP_respawnPanelBckg (uiNamespace getVariable "CP_respawnPanelBckg")
#define CP_LockSquad (uiNamespace getVariable "CP_LockSquad")
#define CP_Teleport (uiNamespace getVariable "CP_Teleport")
#define CP_commanderName (uiNamespace getVariable "CP_commanderName")
#define CP_Mutiny (uiNamespace getVariable "CP_Mutiny")

#define CP_flag (uiNamespace getVariable "CP_flag")

_cmd = _this select 0;

_groups	 = switch (player getVariable ["CP_side", playerside]) do
			{
				case west:			{CP_westGroups};
				case east:			{CP_eastGroups};
				case resistance:	{CP_guarGroups};
			};

_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];

//Build dummy array with only the groups in it
_array = [];
{
	_array set [count _array, _x select 0];
} foreach _groups;

switch (_cmd) do
{
	case 0:				//LBL change on Squad List
	{
		if ((lbCurSel CP_squadPanelSquadList) == -1) exitWith {};
		CP_squadListIndex = (lbCurSel CP_squadPanelSquadList);
		deletemarkerlocal "squadSelected";
		CP_activeGroup	 = _groups select (lbCurSel CP_squadPanelSquadList);
		CP_squadsPanelActiveSquadTittle ctrlSetText (CP_activeGroup select 1);
	};

	case 1:				//Join/Leave button pressed
	{
		CP_activeSpawn = objNull;
		if ((ctrlText CP_squadPanelJoinButton) == "Join Squad") exitWith
		{
			_activeGroup = (CP_activeGroup select 0);

			//If the group got deleted
			if (isnull _activeGroup && ((lbCurSel CP_squadPanelSquadList) < (count CP_defaultGroups))) then
			{
				_activeGroup = createGroup playerside;
				waituntil {!isnil "_activeGroup"};
				_activeGroup setVariable ["MCC_CPGroup",true,true];
				_activeGroup setVariable ["name",(CP_activeGroup select 1),true];
				 switch (player getVariable ["CP_side", playerside]) do
				{
					case west:
					{
						CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[_activeGroup,(CP_activeGroup select 1)]];
						publicVariable "CP_westGroups";
					};
					case east:
					{
						CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[_activeGroup,(CP_activeGroup select 1)]];
						publicVariable "CP_eastGroups";
					};
					case resistance:
					{
						CP_guarGroups set [(lbCurSel CP_squadPanelSquadList),[_activeGroup,(CP_activeGroup select 1)]];
						publicVariable "CP_guarGroups";
					};
				};
			};

			if (!isnull _activeGroup && !(_activeGroup getVariable ["locked",false])) then
			{
				//Check for roles
				_countRole 			= 0;
				_minPlayersForRole	= 0;
				_roleLimit			= 1;
				_role 				= player getvariable ["CP_role","na"];

				switch (_role) do
				{
						case "Officer":		{				//officer
												_roleLimit 			= CP_officerPerGroup;
												_minPlayersForRole 	= CP_officerMinPlayersInGroup;
											};

						case "AR":			{				//AR
												_roleLimit 			= CP_ARPerGroup;
												_minPlayersForRole 	= CP_ARMinPlayersInGroup;
											};

						case "Rifleman":	{				//Rifleman
												_roleLimit 			= CP_riflemanPerGroup;
												_minPlayersForRole 	= CP_riflemanMinPlayersInGroup;
											};

						case "AT":			{				//AT
												_roleLimit 			= CP_ATPerGroup;
												_minPlayersForRole 	= CP_ATMinPlayersInGroup;
											};

						case "Corpsman":	{				//Corpsman
												_roleLimit 			= CP_CorpsmanPerGroup;
												_minPlayersForRole 	= CP_CorpsmanMinPlayersInGroup;
											};

						case "Marksman":	{				//Marksman
												_roleLimit 			= CP_MarksmanPerGroup;
												_minPlayersForRole 	= CP_MarksmanMinPlayersInGroup;
											};

						case "Specialist":	{				//Specialist
												_roleLimit 			= CP_SpecialistPerGroup;
												_minPlayersForRole 	= CP_SpecialistMinPlayersInGroup;
											};

						default				{				//Default
												_roleLimit 			= 999;
												_minPlayersForRole 	= 0;
											};
				};

				//Check if we can switch by the groups size and roles restrictions
				{
					if ((_x getvariable "CP_role") == _role) then {_countRole = _countRole +1};
				} foreach units _activeGroup;

				if (_countRole > (_roleLimit -1)) exitWith {systemchat "Can't switch to that group all kit's have been taken!"};

				if (count (units _activeGroup) < (_minPlayersForRole-1)) exitWith {systemchat format ["Not enough players to join this squad with this kit, Squad needs %1 players to use this kit!",_minPlayersForRole]};

				//If we got this far lets switch
				[player] join (CP_activeGroup select 0);

				//If an officer and not leader make him the leader
				if ( ( (tolower (player getvariable ["CP_role","n/a"])) == "officer" ) && (player != leader player)) then {group player selectLeader player};
			};
		};

		if ((ctrlText CP_squadPanelJoinButton) == "Leave Squad") exitWith
		{
			//Work around for destroying empty groups
			if (count (units (group player)) == 1) then
			{
				_groupName 	=  if ((lbCurSel CP_squadPanelSquadList) < (count CP_defaultGroups)) then {(CP_activeGroup select 1)} else {"--Empty Squad--"};
				_side = player getVariable ["CP_side", playerSide];

				[player] join grpNull;
				_group = creategroup _side;
				waituntil {!isnil "_group"};
				_group setVariable ["MCC_CPGroup",true,true];

				//Unlock the group
				_group setVariable ["locked",false,true];
				_group setVariable ["name",(CP_activeGroup select 1),true];

				if (_side == west) exitWith {CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_westGroups"};
				if (_side == east) exitWith {CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_eastGroups"};
				if (_side== resistance) exitWith {CP_guarGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_guarGroups"};
			}
			else
			{
				[player] join grpNull;
			};

		};

		//Kick Player
		if ((ctrlText CP_squadPanelJoinButton) == "Kick Player") exitWith
		{
			_unit = player getVariable ["MCC_selectedUnit", objnull];

			//Kick
			if (_unit != player && player == leader _unit) then
			{
				_str = "<t size='0.6' font = 'puristaLight' color='#FFFFFF'>" + format ["%1 kicked %2 from the squad",name player, name _unit] + "</t>";
				[[_str,0,0.2,5,1,0.0], "bis_fnc_dynamictext", group _unit, false] spawn BIS_fnc_MP;
				[_unit] join grpNull;
			};
		};

		_null = [0] execVM format["%1configs\dialogs\gearPanel\squadPanel_cmd.sqf",MCC_path];
	};

	case 2:				//Switch side
	{
		//Find the active sides
		_activeSides = [] call MCC_fnc_getActiveSides;

		if (count _activeSides <2) exitWith {};

		_side = _activeSides select (((_activeSides find (player getVariable ["CP_side", playerSide]))+1) mod (Count _activeSides));

		//check if player in group
		if ((count (units (group player)) > 0) && ((group player) in _array)) exitWith
		{
			systemchat "You must leave your squad before changing sides";
		};

		//check if there is room in the other side
		private "_counter";
		_counter = 0;
		{
			if (isPlayer _x) then
			{
				if ((_x getVariable ["CP_side", side _x]) == _side) then {_counter = _counter +1};
			};
		} foreach allUnits;

		if (_counter >= CP_maxPlayers) exitWith
		{
			systemchat Format ["%1 side is full",_side];
		};

		//check if the player is currently a commander for his side
		if (_commander == getPlayerUID player) exitWith
		{
			systemchat "You must leave the commander slot before you can switch sides";
		};

		//Make the switch
		_group = creategroup _side;

		player setVariable ["CP_side", _side, true];

		//Set side flag
		CP_flag ctrlSetText call compile format ["CP_flag%1", (player getVariable ["CP_side", playerSide])];

		[player] join _group;
		_group = grpNull;
		deleteGroup _group;
		systemchat format["You are now part of the %1 side", side player];
		CP_weaponAttachments =[];		//Reset atachments choice
		CP_playerUniforms =  nil;
		CP_opticsIndex = 0;
		CP_barrelIndex = 0;
		CP_attachsIndex = 0;
		CP_weaponAttachments =[];
		[CP_classesIndex,0] call MCC_fnc_setGear;
	};

	case 3:				//Create Squad
	{
		private "_text";
		_text = ctrlText CP_squadPanelCreateSquadText;

		if (_text == "") exitWith {systemchat "Squad name can't be empty"};

		//Rename squad if it is not a predefined squad
		if ((ctrlText CP_squadPanelCreateSquadButton ==  "Rename")) then
		{
			if  ((lbCurSel CP_squadPanelSquadList) < (count CP_defaultGroups)) then
			{
				systemchat "Can't rename predefined squad name";
			}
			else
			{
				group player setVariable ["name",_text,true];
				switch (player getVariable ["CP_side",  playerside]) do
				{
					case west:			{CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,_text]]};
					case east:			{CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,_text]]};
					case resistance:	{CP_guarGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,_text]]};
				};
			};
		}
		else
		{

				//check if player in group
				if ((count (units (group player)) > 0) && ((group player) in _array)) exitWith
				{
					systemchat "You must leave your squad first";
				};

				//check if there is room to make another squad
				if ((count _groups) >= CP_maxSquads) exitWith {
					systemchat format ["Max number of squads reached %1/%2", count _groups, CP_maxSquads];
					};

				//Create a new squad
				_group = creategroup (player getVariable ["CP_side",  playerside]);
				[player] join _group;
				switch (player getVariable ["CP_side",  playerside]) do
					{
						case west:			{CP_westGroups set [count CP_westGroups,[_group,_text]];
												publicvariable "CP_westGroups";};
						case east:			{CP_eastGroups set [count CP_eastGroups,[_group,_text]];
												publicvariable "CP_eastGroups";};
						case resistance:	{CP_guarGroups set [count CP_guarGroups,[_group,_text]];
										publicvariable "CP_guarGroups";};
					};
				_group setVariable ["name",_text,true];
				sleep 0.5;
				CP_squadPanelSquadList lbSetCurSel (count _groups);

				systemchat format ["Squad %1 Created", _text, _group];
			};

		_null = [0] execVM format["%1configs\dialogs\gearPanel\squadPanel_cmd.sqf",MCC_path];
	};

	case 4:				//Focuse on Player
	{

		private ["_unit","_units","_nvgstate"];

		//Make the leader first in list
		_units = units (CP_activeGroup select 0);

		if (count _units > 1) then
		{
			_leader = [leader (CP_activeGroup select 0)];
			_units = _units - _leader;
			_units = _leader + _units;
		};

		_unit = _units select (lbCurSel CP_squadPanelPlayersList);
		player setVariable ["MCC_selectedUnit", _unit];

		//Only work if we didn't came here after respawn
		if (!MCC_squadDialogOpen || isnil "_unit" || !MCC_allowSquadDialogCamera) exitWith {};

		//Set camera on squad member
		if (_unit in units player) exitWith
		{
			if !(isnil "CP_gearCam") then
			{
				detach CP_gearCam;
				CP_gearCam cameraeffect ["Terminate","back"];
				camDestroy CP_gearCam;
				deleteVehicle CP_gearCam;
				CP_gearCam = nil;
			};

			//--- Camera
			CP_gearCamFOV = 0.15;
			CP_gearCam = "camera" camcreate [0,0,0];
			CP_gearCam cameraeffect ["internal", "BACK", "rendertarget7"];
			CP_gearCam campreparefocus [-1,-1];
			CP_gearCam camSetFov CP_gearCamFOV;
			CP_gearCam camcommitprepared 0;
			cameraEffectEnableHUD true;
			showcinemaborder false;
			player setvariable ["CPCenter", _unit];

			//handle NV
			_nvgstate = if (daytime > 19 || daytime < 5.5) then {[1]} else {[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]};
			"rendertarget7" setPiPEffect _nvgstate;

			CP_gearCam attachto [_unit,[0.5,-12,2.8],""];
			CP_gearCam campreparetarget _unit;
			CP_gearCam camcommitprepared 0;
			CP_gearCam camcommit 0;
		};
	};

	case 5:				//Lock/Unlock Squad
	{
			if (isnil "CP_activeGroup") exitWith {};
			_group = CP_activeGroup select 0;

			if (isnil "_group") exitWith {};
			if (isnull _group) exitWith {};

			//Lock
			if (player == leader _group) then
			{
				if (_group getVariable ["locked",false]) then
				{
					_group setVariable ["locked",false,true];
					CP_LockSquad ctrlSetText (MCC_path +"data\unlocked.paa");
				}
				else
				{
					_group setVariable ["locked",true,true];
					CP_LockSquad ctrlSetText (MCC_path +"data\locked.paa");
				};
			};
	};

	case 6:				//Teleport
	{
		if (isnil "CP_activeGroup" || isnull (CP_activeGroup select 0)) exitWith {};
		if ((lbCurSel CP_squadPanelPlayersList) == -1) exitWith {};


		_unit = player getVariable ["MCC_selectedUnit", player];

		if (!isnil "_unit" && (_unit in (units group player))) then
		{
			[_unit] execVM format ["%1mcc\general_scripts\mcc_SpawnToPosition.sqf",MCC_path];
		};

		sleep 1;
		if (!MCC_teleportToTeam) then {CP_Teleport ctrlShow false};
	};

	case 7:				//Mutiny
	{
		//Become a commander
		if (_commander == "") then
		{
			_str = "<t size='1' font = 'puristaLight' color='#FFFFFF'>" + format ["%1 logged in as the commander",name player] + "</t>";
			_command = format ['["MCC_woosh",true] spawn BIS_fnc_playSound; ["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_str];
			[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

			MCC_server setVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],getPlayerUID player, true];
		}
		else
		{
			//Leave commander
			if (_commander == getPlayerUID player) then
			{
				_str = "<t size='1' font = 'puristaLight' color='#FFFFFF'>" + format ["%1 is no longer the commander",name player] + "</t>";
				_command = format ['["MCC_woosh",true] spawn BIS_fnc_playSound; ["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_str];
				[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

				MCC_server setVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],"", true];
			}
			else	//Start Mutiny
			{
				private ["_lastMutiny","_numberPlayers"];
				_lastMutiny = MCC_server getVariable [format ["CP_commander%1_lastMutiny",(player getVariable ["CP_side",  playerside])],time];

				if (_lastMutiny <= time) then
				{
					MCC_server setVariable [format ["CP_commander%1_lastMutiny",(player getVariable ["CP_side",  playerside])],(time + 300), true];
					CP_mutiny = 0;
					publicVariable "CP_mutiny";
					sleep 1;
					[[format ["%1 have started a mutiny. do you want to kick the commander?", name player], "MUTINY" , "CP_mutiny"] ,"MCC_fnc_vote",(player getVariable ["CP_side",  playerside]),false] spawn BIS_fnc_MP;
					sleep 30;
					_numberPlayers = (player getVariable ["CP_side",  playerside]) countSide allunits;
					[[{publicVariable "CP_mutiny"}], "BIS_fnc_spawn", false, false] spawn BIS_fnc_MP;
					sleep 2;

					if (CP_mutiny > (_numberPlayers/2)) then
					{
						_str = "<t size='1' font = 'puristaLight' color='#FFFFFF'>" + format ["Mutiny succeed, the commander has been kicked. %1 is the new commander",name player] + "</t>";
						_command = format ['["MCC_woosh",true] spawn BIS_fnc_playSound; ["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_str];
						[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

						MCC_server setVariable [format ["CP_commander%1",(player getVariable ["CP_side",  playerside])],getPlayerUID player, true];
					}
					else
					{
						_str = "<t size='1' font = 'puristaLight' color='#FFFFFF'>" + "Mutiny failed" + "</t>";
						_command = format ['["MCC_woosh",true] spawn BIS_fnc_playSound; ["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_str];
						[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					}
				}
				else
				{
					systemchat format["You can only start mutiny once every 5 minutes. Time to wait %1 seconds", floor (_lastMutiny - time)];
				};
			};
		};
	};
};