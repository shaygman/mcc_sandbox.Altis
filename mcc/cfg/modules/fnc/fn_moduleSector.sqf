/*
	MCC_fnc_moduleSector

	based on the script by BIS's Karel Moricky extended for MCC_fnc_moduleSector

	Description:
	Initialize a sector module. Can be also used to get sector parameters.

	--- Get all sectors ---
	Parameter(s):
		0: BOOL

	Returns:
	ARRAY of OBJECTs

	--- Get number of sectors held by a side ---
	Parameter(s):
		0: SIDE

	Returns:
	NUMBER - number of sectors owned by the side

	--- Set sector owner ---
	Parameter(s):
		0: OBJECT - sector module
		1: SIDE

	Returns:
	BOOL

	--- Initialize ---
	Parameter(s):
		0: OBJECT - sector module

	Returns:
	NOTHING
*/

private ["_logic","_units","_activated"];
_logic = [_this,0,objnull] call bis_fnc_param;
_units = [_this,1,[]] call bis_fnc_param;
_activated = [_this,2,true,[true]] call bis_fnc_param;

//--- Return all sectors
if (typename _logic == typename true) exitwith {
	missionnamespace getvariable ["MCC_fnc_moduleSector_sectors",[]]
};

//--- Return sectors belonging to a side
if (typename _logic == typename sideunknown) exitwith {
	private ["_side","_sideID"];
	_side = _logic;
	_sideID = _side call bis_fnc_sideID;
	if (_sideID in [0,1,2,3,4]) then {MCC_fnc_moduleSector_sideSectors select _sideID} else {-1}
};

//--- Set side
if (typename _units == typename sideunknown) exitwith {
	_logic setvariable ["owner",_units,true];
	true
};

//--- Initialize the sector
if !(_activated) exitwith {};
_mode = [_this,3,"init",[""]] call bis_fnc_param;

switch _mode do {

	case "init": {
		[_logic,[],_activated,"server"] spawn MCC_fnc_moduleSector;
	};

	case "server": {
		/////////////////////////////////////////////////////////////////////////////////////
		// Server
		/////////////////////////////////////////////////////////////////////////////////////
		_loadingScreen = format ["MCC_fnc_moduleSector:%1",_logic];
		_loadingScreen call bis_fnc_startloadingscreen;

		//--- Prepare error handling
		_exitCode = {
			_sectorsError = missionnamespace getvariable ["MCC_fnc_moduleSector_sectorsError",[]];
			_sectorsError set [count _sectorsError,_logic];
			missionnamespace setvariable ["MCC_fnc_moduleSector_sectorsError",_sectorsError];
			publicvariable "MCC_fnc_moduleSector_sectorsError";
			 _loadingScreen call bis_fnc_endloadingscreen;
		};

		//--- Wait until previous sectors are initialized to maintain the same order as in editor
		waituntil {
			_sectors = (entities "MCC_ModuleSector_F") - (missionnamespace getvariable ["MCC_fnc_moduleSector_sectors",[]]) - (missionnamespace getvariable ["MCC_fnc_moduleSector_sectorsError",[]]);
			if (count _sectors > 0) then {(_sectors select 0) == _logic} else {true};
		};

		_logicParent = _logic;
		if (typeof _logic == "ModuleSectorDummy_F") then {
			{
				if (typeof _x == "MCC_ModuleSector_F") then {_logicParent = _x;};
			} foreach (synchronizedobjects _logic);
		};

		//--- Load params
		[_logic,"MCC_fnc_moduleSector_sector"] call bis_fnc_objectvar;
		_name = _logic getvariable ["Name",""];
		_designation = _logic getvariable ["Designation",""];
		_ownerLimit = (_logicParent getvariable ["OwnerLimit","0"]) call bis_fnc_parsenumber;
		_onOwnerChange = compile (_logicParent getvariable ["OnOwnerChange","true"]);
		_captureCoef = (_logicParent getvariable ["CaptureCoef","0.05"]) call bis_fnc_parsenumber;
		_costInfantry = (_logicParent getvariable ["CostInfantry","0.5"]) call bis_fnc_parsenumber;
		_costWheeled = (_logicParent getvariable ["CostWheeled","0.5"]) call bis_fnc_parsenumber;
		_costTracked = (_logicParent getvariable ["CostTracked","0.5"]) call bis_fnc_parsenumber;
		_costWater = (_logicParent getvariable ["CostWater","0"]) call bis_fnc_parsenumber;
		_costAir = (_logicParent getvariable ["CostAir","0"]) call bis_fnc_parsenumber;
		_costPlayers = compile (_logicParent getvariable ["CostPlayers","0.5"]);
		_defaultOwner = (_logicParent getvariable ["DefaultOwner","-1"]) call bis_fnc_parsenumber;
		_taskOwner = (_logicParent getvariable ["TaskOwner",0]) call bis_fnc_parsenumber;
		_taskTitle = _logicParent getvariable ["TaskTitle","%1"];
		_taskDescription = _logicParent getvariable ["TaskDescription","%1%2%3"];
		_scoreReward = (_logicParent getvariable ["ScoreReward",0]) call bis_fnc_parsenumber;
		_sides = _logic getvariable ["sides",[]]; //--- Not configurable in module attributes, only by script
		_useDefaultSides = !isnil {_logic getvariable "sides"};

		//--- Register the expression as a scripted event handler
		[_logic,"ownerChanged",_onOwnerChange] call bis_fnc_addscriptedeventhandler;

		//--- Load visuals
		if (_name == "") then {
			_nameID = ["MCC_fnc_moduleSector_nameID",1] call bis_fnc_counter;
			_nameID = ((_nameID - 1) % 26) + 1;
			_name = _nameID call bis_fnc_phoneticalWord;
			_logic setvariable ["name",_name];
		};
		if (_designation == "") then {_designation = _name;};
		_designation = tostring [toarray _designation select 0];
		_markerName = if ((toarray _name select 0) == (toarray _designation select 0)) then {_name} else {format ["%1: %2",_designation,_name];};

		_icon = "n_installation";
		_iconTexture = _icon call bis_fnc_textureMarker;

		//--- Get task titles and descriptions per side (scripted option only)
		_taskTitles = _taskTitle;
		if (typename _taskTitles == typename "") then {
			_taskTitles = [_taskTitles];
		};
		_taskTitle = "";
		for "_i" from 0 to 5 do {
			_taskTitle = [_taskTitles,_i,_taskTitle,[""]] call bis_fnc_paramin;
			_taskTitles set [_i,_taskTitle];
		};
		_taskDescriptions = _taskDescription;
		if (typename _taskDescriptions == typename "") then {
			_taskDescriptions = [_taskDescriptions];
		};
		_taskDescription = "";
		for "_i" from 0 to 5 do {
			_taskDescription = [_taskDescriptions,_i,_taskDescription,[""]] call bis_fnc_paramin;
			_taskDescriptions set [_i,_taskDescription];
		};

		//--- Load synced objects
		_sectorsModules = count (entities "MCC_ModuleSector_F");
		_sectors = missionnamespace getvariable ["MCC_fnc_moduleSector_sectors",[]];
		_sectorID = count _sectors;
		_areas = [];
		_sideUnits = [[],[],[],[],[],[]];
		_sectorScore = [0,0,0,0,0,0];
		_sideScore = [0,0,0,0,0,0];
		_tasks = ["","","","","",""];
		_taskOrders = [true,true,true,true,true,true];
		_flags = [];
		_markersArea = [];
		_markerIcon = "";
		_markerIconText = "";
		_taskDescriptionUnlocks = "";
		_unlockTriggers = [[],[],[],[],[]];

		_fnc_initArea = {
			_trigger = _this;
			_areas = _areas - [_trigger];
			_areas set [count _areas,_trigger];

			_trigger settriggeractivation ["any","present",false];
			_trigger settriggerstatements ["false","",""];
			_trigger settriggertype "none";

			_triggerMarkers = _trigger getvariable ["markers",[]];
			_markerArea = createmarker ["MCC_fnc_moduleSector_area" + str _trigger,position _trigger];
			_markerArea setmarkerbrush "grid";
			_markerArea setmarkercolor "colorwhite";
			_markerArea setmarkeralpha 0.5;
			_markersArea set [count _markersArea,_markerArea];
			_triggerMarkers set [count _triggerMarkers,_markerArea];

			if (_markerIcon == "") then {
				_markerIcon = createmarker ["MCC_fnc_moduleSector_icon" + str _logic,position _trigger];
				_markerIcon setmarkertype _icon;
				_markerIcon setmarkercolor "colorwhite";
				//_markerIcon setmarkertext _markerName;
				_markerIcon setmarkersize [1.5,1.5];
				_triggerMarkers set [count _triggerMarkers,_markerIcon];

				_markerIconText = createmarker ["MCC_fnc_moduleSector_iconText" + str _logic,position _trigger];
				_markerIconText setmarkertype "EmptyIcon";
				_markerIconText setmarkercolor "colorblack";
				_markerIconText setmarkertext _markerName;
				_markerIconText setmarkersize [1.5,1.5];
				_triggerMarkers set [count _triggerMarkers,_markerIconText];
			};
			_trigger setvariable ["markers",_triggerMarkers];
			_trigger setvariable ["pos",[0,0,0]];

			//--- Show sector rewards
			{
				_xtype = tolower typeof _x;
				switch _xType do {
					case "modulerespawnposition_f": {
						_xTypeID = (_x getvariable ["Type","0"]) call bis_fnc_parsenumber;
						_xSideID = (_x getvariable ["Side","-1"]) call bis_fnc_parsenumber;
						_xSideName = if (_xSideID < 0) then {localize "STR_A3_CfgVehicles_ModuleRespawnPosition_F_Arguments_Side_values_Leader_0"} else {_xSideID call bis_fnc_sidename};

						_xMarkerType = ["respawn_inf","respawn_unknown","respawn_motor","respawn_armor","respawn_air","respawn_plane"] select _xTypeID;
						_xMarkerTypeName = gettext (configfile >> "cfgmarkers" >> _xMarkerType >> "name");
						_xMarkerIcon = (gettext (configfile >> "cfgmarkers" >> _xMarkerType >> "texture")) call bis_fnc_textureMarker;
						_taskDescriptionUnlocks = _taskDescriptionUnlocks + format ["<img image='%1' width='16'/> %2 (%3)<br />",_xMarkerIcon,_xMarkerTypeName,_xSideName];
					};
					case "modulerespawnvehicle_f": {
						_xLogic = _x;
						{
							_xCfg = configfile >> "cfgvehicles" >> typeof _x;
							_xSimulation = tolower gettext (_xCfg >> "simulation");
							if (_xSimulation in ["carx","tankx","helicopterx","planex","shipx","submarinex","helicopterrtd"]) then {
								_xName = gettext (_xCfg >> "displayName");
								_xPicture = (gettext (_xCfg >> "picture")) call bis_fnc_textureVehicleIcon;
								_xPosition = (_xLogic getvariable ["Position","0"]) call bis_fnc_parsenumber;
								_xSide = switch _xPosition do {
									case 2: {(getnumber (_xCfg >> "side")) call bis_fnc_sideName;};
									case 3;
									case 4;
									case 5;
									case 6: {(_xPosition - 3) call bis_fnc_sideName;};
									default {""};
								};
								if (_xSide != "") then {_xSide = format ["(%1)",_xSide];};
								_taskDescriptionUnlocks = _taskDescriptionUnlocks + format ["<img image='%1' width='16'/> %2 %3<br />",_xPicture,_xName,_xSide];
							};
						} foreach (synchronizedobjects _x);
					};
				};
			} foreach (synchronizedobjects _trigger);
		};

		{
			switch (true) do {
				case (typeof _x == "LocationArea_F"): {
					{
						if (_x iskindof "EmptyDetector") then {
							_x call _fnc_initArea;
						};
					} foreach (synchronizedobjects _x);
				};
				case (typeof _x == "MiscUnlock_F"): {
					{
						if (_x iskindof "EmptyDetector") then {
							_trigger = _x;
							_side = triggeractivation _trigger select 0;
							_sideIDs = switch _side do {
								case "EAST";
								case "WEST";
								case "GUER";
								case "CIV";
								case "LOGIC": {[["EAST","WEST","GUER","CIV","LOGIC"] find _side];};
								case "ANY": {[0,1,2,3,4]};
								default {[]};
							};
							{
								_sideTriggers = _unlockTriggers select _x;
								_sideTriggers set [count _sideTriggers,_trigger];

								_triggerStatements = triggerstatements _trigger;
								_triggerStatements set [
									0,
									format [
										"(%1 getvariable ['owner',sideunknown]) == %2",
										_logic,
										["east","west","resistance","civilian","sideunknown"] select _x
									]
								];
								_trigger settriggerstatements _triggerStatements;
							} foreach _sideIDs;
						};
					} foreach (synchronizedobjects _x);

				};
				case (_x iskindof "FlagCarrierCore"): {
					_flags set [count _flags,_x];
				};
			};
		} foreach (synchronizedobjects _logic);

		//--- No synced triggers found - create a default one
		if (count _areas == 0) then {
			_areaTrigger = createtrigger ["emptydetector",position _logic];
			_areaTrigger settriggerarea [50,50,0,false];
			_areaTrigger call _fnc_initArea;
			_areaTrigger attachto [_logic];
		};

		//--- Explain capture ratios
		_participant = "<font color='%2'>%1</font>";
		_participantColor = {if (_this > 0) then {"#ffffff"} else {"#33ffffff"}};
		_taskDescriptionCapture = format [
			"<br /><br /><font size='18'>%1</font><br />%2 / %3 / %4 / %5 / %6",
			localize "str_a3_cfgvehicles_MCC_ModuleSector_F_forces",
			format [_participant,gettext (configfile >> "CfgVehicleClasses" >> "Men" >> "displayName"),_costInfantry call _participantColor],
			format [_participant,gettext (configfile >> "CfgVehicleClasses" >> "Car" >> "displayName"),_costWheeled call _participantColor],
			format [_participant,gettext (configfile >> "CfgVehicleClasses" >> "Armored" >> "displayName"),_costTracked call _participantColor],
			format [_participant,gettext (configfile >> "CfgVehicleClasses" >> "Air" >> "displayName"),_costAir call _participantColor],
			format [_participant,gettext (configfile >> "CfgVehicleClasses" >> "Ship" >> "displayName"),_costWater call _participantColor]
			//format [_participant,localize "str_disp_mp_players_title",_costPlayers call _participantColor]
		];

		//--- Explain sector unlocks
		if (_taskDescriptionUnlocks != "") then {
			_taskDescriptionUnlocks = format ["<br /><br /><font size='18'>%1</font><br />%2",localize "str_a3_cfgvehicles_MCC_ModuleSector_F_rewards",_taskDescriptionUnlocks];
		};

		_taskPos = position (_areas select 0);
		{
			switch (true) do {
				case (_x iskindof "SideBLUFOR_F");
				case (_x iskindof "SideOPFOR_F");
				case (_x iskindof "SideResistance_F"): {
					_side = (["SideOPFOR_F","SideBLUFOR_F","SideResistance_F"] find (typeof _x)) call bis_fnc_sideType;
					_sides set [count _sides,_side];
				};
			};
		} foreach ([_logic,[typeof _logic]] call bis_fnc_allSynchronizedObjects);

		if (count _sides == 0 && _useDefaultSides) then {_sides = [east,west,resistance,civilian];};
		//if (count _sides == 0) exitwith {["No sides defined for %1",_logic] call bis_fnc_error; [] call _exitCode};
		if (_defaultOwner >= 0 && !((_defaultOwner call bis_fnc_sidetype) in _sides)) then {["Default owner %1 is not a competing side for sector %2. No default owner used instead.",_defaultOwner call bis_fnc_sidetype,_name] call bis_fnc_error;};

		//--- Save global variables
		_logic setvariable ["finalized",false,true];
		_logic setvariable ["pos",markerpos _markerIcon,true];
		_logic setvariable ["areas",_areas,true];
		_logic setvariable ["sides",_sides,true];
		_logic setvariable ["flags",_flags,true];
		_logic setvariable ["tasks",_tasks,true];
		_logic setvariable ["designation",_designation,true];

		_sectors set [count _sectors,_logic];
		missionnamespace setvariable ["MCC_fnc_moduleSector_sectors",_sectors];
		publicvariable "MCC_fnc_moduleSector_sectors";

		if (isnil {MCC_fnc_moduleSector_sideSectors}) then {MCC_fnc_moduleSector_sideSectors = [0,0,0,0,0];};

		//--- Execute local function
		//[[_logic,[],true,"player"],"MCC_fnc_moduleSector",_sides - [sideunknown],true] call bis_fnc_mp;

		_fnc_conversion = {
			_total = 0;
			_result = +(_this select 0);
			_coef = _this select 1;
			{_total = _total + _x;} foreach _result;
			if (_total > 1) then {
				{
					_result set [_foreachindex,(_result select _foreachindex) / _total * _coef];
				} foreach _result;
			};
			_result
		};
		_fnc_threat = {
			private ["_veh","_coef","_scanCrew","_threat","_score"];
			_veh = _this select 0;
			_coef = _this select 1;
			_scanCrew = _this select 2;
			_threat = getarray (configfile >> "cfgvehicles" >> typeof _veh >> "threat");

			_score = 0;
			{_score = _score + _x} foreach _threat;
			_score = _score * _coef;
			if (isplayer _veh) then {_score = _score * _costPlayersLocal;};

			if (_scanCrew) then {
				{
					_score = _score + ([_x,_costInfantry,false] call _fnc_threat);
					if (isplayer _x) then {_score = _score * _costPlayersLocal;};
				} foreach (crew _veh - [_veh]);
			};
			_score
		};
		_fnc_sort = {
			_unsorted = +_sectorScore;
			_sorted = [];
			while {count _sorted != count _unsorted} do {
				_max = -1;
				_maxIndex = -1;
				_index = count _sorted;
				{
					if (_x > _max) then {
						_max = _x;
						_maxIndex = _foreachindex;
						_sorted set [_index,_maxIndex];
					};
				} foreach _unsorted;
				_unsorted set [_maxIndex,-1];
			};
			_sorted
		};

		//--- Wait until scripts are initialized (to avoid being faster than initServer.sqf)
		waituntil {!isnil "bis_fnc_init"};
		_loadingScreen call bis_fnc_endloadingscreen;


		//--- Global loop -----------------------------------------------------------
		_allSides = [east,west,resistance,civilian,sideunknown,sideenemy];
		_time = 0;
		_pos = position _logic;
		_posOld = _pos;
		_owner = sideEnemy;
		_ownerOld = _owner;
		_maxScoreOld = 0;
		_firstLoop = true;
		_sidesOld = [];
		_sidesOldStr = str _sidesOld;
		_step = 0;

		while {!(isnull _logic) && (simulationenabled _logic) && !(_logic getvariable ["finalized",false])} do {

			//--- Load variables
			_areas = _logic getvariable ["areas",_areas];
			_sides = _logic getvariable ["sides",_sides];
			_flags = _logic getvariable ["flags",_flags];
			_tasks = _logic getvariable ["tasks",_tasks];
			_ownerForced = _logic getvariable ["owner",_owner];
			_designation = _logic getvariable ["designation",_designation];

			//--- Detect participating sides
			if (str _sides != _sidesOldStr) then {

				//--- Show MP progress HUD - disable HUD
				//[[_logic,[],true,"player"],"MCC_fnc_moduleSector",_sides - _sidesOld,true] call bis_fnc_mp;

				//--- Add sides
				{
					_side = _x;
					_sideID = _side call bis_fnc_sideID;

					_task = _tasks select _sideID;
					_taskOrder = true;
					_addTask = switch _taskOwner do {
						case 0: {false};
						case 1: {true};
						case 2: {_sideID == _defaultOwner};
						case 3: {_sideID != _defaultOwner};
					};
					if (_task == "" && _addTask) then {

						//--- Set currents tasks from the top (false) or from the bottom (true)
						_taskOrder = if (_defaultOwner >= 0) then {
							[_side,_defaultOwner call bis_fnc_sidetype] call bis_fnc_arefriendly
						} else {
							([_side,east] call bis_fnc_arefriendly) || !([_side,west] call bis_fnc_arefriendly)
						};

						_taskTitle = _taskTitles select _sideID;
						_taskDescription = _taskDescriptions select _sideID;
						if (_taskTitle == "") then {_taskTitle = "%1";};
						if (_taskDescription == "") then {_taskDescription = "%1%2%3";};
						_taskID = str _logic + str _side;
						_taskPrio = _sectorID / _sectorsModules;
						_taskCurrent = if (_taskOrder) then {_sectorID == _sectorsModules - 1} else {_taskPrio = 1 - _taskPrio; _sectorID == 0};
						_task = [_taskID,_side,[[_taskDescription,_name,_taskDescriptionCapture,_taskDescriptionUnlocks],[_taskTitle,_name],_name],_taskPos,_taskCurrent,_taskPrio] call bis_fnc_setTask;
					};
					_scoreDefault = if (_sideID == _defaultOwner) then {1} else {0};

					_sideUnits set [_sideID,[]];
					_sectorScore set [_sideID,_scoreDefault];
					_sideScore set [_sideID,_scoreDefault];
					_tasks set [_sideID,_task];
					_taskOrders set [_sideID,_taskOrder];
				} foreach (_sides - _sidesOld);

				//--- Remove sides
				{
					_side = _x;
					_sideID = _side call bis_fnc_sideID;
					_task = _tasks select _sideID;
					if (_task != "") then {
						//[_task,nil,nil,nil,"canceled"] call bis_fnc_settask;
						_task call bis_fnc_deletetask;
						_tasks set [_sideID,""];
					};
				} foreach (_sidesOld - _sides);

				_logic setvariable ["tasks",_tasks,true];
			};
			_sidesOld = _sides;
			_sidesOldStr = str _sidesOld;
			_sides = [sideunknown] + _sides;

			//--- Detect leading side
			_owner = sideUnknown;
			_timeCoef = _captureCoef * (time - _time);

			_sectorScore = [_sectorScore,1] call _fnc_conversion;
			_sectorScoreSorted = _sectorScore call _fnc_sort;

			_side1ID = _sectorScoreSorted select 0;
			_side1score = _sectorScore select _side1ID;
			_scoreDiffAdd = 0;
			_scoreDiffRemove = 0;
			if (count _sides > 1) then {
				_side2ID = _sectorScoreSorted select 1;
				_side2score = _sectorScore select _side2ID;
				_scoreDiffAdd = (_side1score - _side2score) * _timeCoef;
				_scoreDiffRemove = _scoreDiffAdd / ((count _sides - 1) max 1);
			};

			//--- Force owner
			if (_ownerForced != _ownerOld && _ownerForced in _sides) then {
				_ownerForcedID = _ownerForced call bis_fnc_sideID;
				{
					_sideScore set [_foreachindex,if (_foreachindex == _ownerForcedID) then {1} else {0}];
				} foreach _sideScore;
			};

			//--- Increase score of the leader, decrease score of others
			_maxScore = 0;
			_ownerScore = 0;
			_totalScore = 0;
			_ownerID = -1;
			_sideUnitsLocal = +_sideUnits;
			{
				if (_x in _sides) then {
					_xScore = _sideScore select _foreachindex;
					_xScore = if (_foreachindex == _side1ID) then {
						_xScore + _scoreDiffAdd
					} else {
						(_xScore - _scoreDiffRemove) max 0
					};
					if (_xScore >= _ownerLimit && _xScore > _ownerScore) then {
						_owner = _x;
						_ownerScore = _xScore;
						_ownerID = _foreachindex;
					};
					_totalScore = _totalScore + _xScore;
					if (_foreachindex > 0) then {_maxScore = _maxScore max _xScore min 1;};
					_sideScore set [_foreachindex,_xScore];
					_sectorScore set [_foreachindex,0];
					_sideUnits set [_foreachindex,[]];
				} else {
					_sideScore set [_foreachindex,0];
				};
			} foreach _allSides;//_sides;
			if (_totalScore < 0.99999) then {_sideScore set [4,1 - _totalScore];}; //--- Don't compare with 1, because it's not always 1 ;)
			_sideScore = [_sideScore,1] call _fnc_conversion;

			//--- Store sector score
			_logic setvariable ["sideScore",_sideScore,true];

			//--- Store sector status
			_contested = _maxScore != _maxScoreOld;
			_contestedOld = _logic getvariable ["contested",false];
			if ((_contested && !_contestedOld) || (!_contested && _contestedOld)) then {
				_logic setvariable ["contested",_contested,true];
			};
			_maxScoreOld = _maxScore;

			//--- Execute code when ownership changes
			if (_owner != _ownerOld) then {

				//--- Call custom code
				[_logic,"ownerChanged",[_logic,_owner,_ownerOld]] call bis_fnc_callscriptedeventhandler;

				//--- Broadcast
				_logic setvariable ["owner",_owner,true];

				//--- Reward
				_owner addscoreside _scoreReward;

				//--- Update total count
				_ownerSideID = _owner call bis_fnc_sideID;
				_ownerOldSideID = (_ownerOld call bis_fnc_sideID) min 4;
				MCC_fnc_moduleSector_sideSectors set [_ownerSideID,(MCC_fnc_moduleSector_sideSectors select _ownerSideID) + 1];
				MCC_fnc_moduleSector_sideSectors set [_ownerOldSideID,((MCC_fnc_moduleSector_sideSectors select _ownerOldSideID) - 1) max 0];
				publicvariable "MCC_fnc_moduleSector_sideSectors";

				//--- Update markers
				//_iconColor = [0.25,0.25,0.25,0.5];
				_markerColor = "colorblack";
				if (_owner != sideUnknown) then {
					//_iconColor = _owner call bis_fnc_sidecolor;
					_markerColor = [_owner,true] call bis_fnc_sidecolor;
				};
				_icon = ["o_installation","b_installation","n_installation","n_installation","u_installation"] select ((_owner call bis_fnc_sideID) min 4);
				_iconTexture = _icon call bis_fnc_texturemarker;
				_markerIcon setmarkertype _icon;
				_markerIcon setmarkercolor _markerColor;
				{
					_x setmarkercolor _markerColor;
					if (_markerColor == "colorblack") then {_x setmarkeralpha 0.25;} else {_x setmarkeralpha 0.5;};
				} foreach _markersArea;
				//_logic setvariable ["ownerTexture",_iconTexture,true];
				//_logic setvariable ["ownerColor",_iconColor,true];

				//--- Show notification
				_ownerName = _owner call bis_fnc_sidename;
				if (_owner != sideunknown) then {
					[[format ["sectorCaptured%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_sides - [_ownerOld]] call bis_fnc_mp;
					[[format ["sectorLost%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_ownerOld] call bis_fnc_mp;
				};

				//--- Update flag (not for default owner)
				if ((_firstLoop && _defaultOwner < 0) || !_firstLoop) then {
					_flagTexture = if (_ownerID < 0) then {
						""
					} else {
						_units = _sideUnitsLocal select _ownerID;
						if (count _units > 0) then {
							_ownerFaction = gettext (configfile >> "cfgvehicles" >> typeof (_units select 0) >> "faction");
							gettext (configfile >> "cfgfactionclasses" >> _ownerFaction >> "flag");
						} else {
							(_owner call bis_fnc_sidecolor) call bis_fnc_colorRGBAtoTexture
						};
					};
					{_x setflagtexture _flagTexture;} foreach _flags;
				};

				//--- Update tasks (not in the first run to prevent creating task before others)
				if !(_firstLoop) then {
					_ownerID = _owner call bis_fnc_sideID;//_sides find _owner;
					_firstSector = objnull;
					_lastSector = objnull;
					{
						if (simulationenabled _x || _x == _logic) then {
							if (isnull _firstSector) then {_firstSector = _x;};
							_lastSector = _x;
						};
					} foreach _sectors;
					{
						if (_x != "") then {
							_taskOrder = _taskOrders select _foreachindex;
							_taskState = if (_foreachindex == _ownerID) then {
								"SUCCEEDED"
							} else {
								_compareSector = if (_taskOrder) then {_lastSector} else {_firstSector};
								if (_logic == _compareSector) then {"ASSIGNED"} else {"CREATED"}
							};
							[_x,nil,nil,nil,_taskState,nil,false] call bis_fnc_setTask;
						};
					} foreach _tasks;
				};
			};
			_ownerOld = _owner;
			_time = time;

			//--- Update area positions
			{
				_trigger = _x;
				_pos = position _trigger;
				if (_pos distance (_trigger getvariable ["pos",[0,0,0]]) > 0) then {
					_trigger setvariable ["pos",_pos];
					_markers = _trigger getvariable ["markers",[]];
					{
						_x setmarkerpos position _trigger;
						if (markertype _x == "") then {
							_triggerArea = triggerarea _trigger;
							if (_triggerArea select 3) then {_x setmarkershape "rectangle";} else {_x setmarkershape "ellipse";};
							_x setmarkerdir (_triggerArea select 2);
							_x setmarkersize [_triggerArea select 0,_triggerArea select 1];
						};
					} foreach _markers;
					if (_markerIcon in _markers) then {
						_logic setvariable ["pos",markerpos _markerIcon,true];
					};
				};
			} foreach _areas;

			//--- Calculate side strengths for the next cycle
			_costPlayersLocal = _costPlayers call bis_fnc_parsenumber;
			{
				{
					if ({alive _x} count crew _x > 0) then {
						_side = side group _x;
						if (_side in _sides) then {
							_sideID = _side call bis_fnc_sideID;//_sides find _side;
							_units = _sideUnits select _sideID;
							if !(_x in _units) then {
								_score = _sectorScore select _sideID;

								_simulation = gettext (configfile >> "cfgvehicles" >> typeof _x >> "simulation");

								_xScore = switch (tolower _simulation) do {
									case "soldier": {
										[_x,_costInfantry,true] call _fnc_threat;
									};
									case "carx": {
										[_x,_costWheeled,true] call _fnc_threat;
									};
									case "tankx": {
										[_x,_costTracked,true] call _fnc_threat;
									};
									case "shipx";
									case "submarinex": {
										[_x,_costWater,true] call _fnc_threat;
									};
									case "airplanex";
									case "helicopterx": {
										[_x,_costAir,true] call _fnc_threat;
									};
									default {
										0
									};
								};
								_score = _score + _xScore;
								_sectorScore set [_sideID,_score];

								_units set [count _units,_x];
								_sideUnits set [_sideID,_units];
							};
						};
						sleep 0.05;
					};
				} foreach list _x;
				sleep 0.1;
			} foreach _areas;

			//--- Loop counter for outside use
			_step = _step + 1;
			_logic setvariable ["step",_step];

			_firstLoop = false;
			sleep 0.1;
		};

		//--- Sector finalized
		if (isnull _logic) then {

			_sectors = missionnamespace getvariable ["MCC_fnc_moduleSector_sectors",[]];
			_sectors = _sectors - [_logic,objnull];
			missionnamespace setvariable ["MCC_fnc_moduleSector_sectors",_sectors];
			publicvariable "MCC_fnc_moduleSector_sectors";

			//--- Delete markers
			{
				deletemarker _x;
			} foreach (_markersArea + [_markerIcon,_markerIconText]);
		} else {
			//--- Mark as finalized globaly (enableSImulation is local only)
			_logic setvariable ["finalized",true,true];
			_logic setvariable ["contested",false,true];

			//--- Make markers transparent
			{
				_x setmarkeralpha (markeralpha _x * 0.5);
			} foreach (_markersArea + [_markerIcon,_markerIconText]);
		};

		//--- Activate area triggers
		{
			_x settriggeractivation ["any","present",false];
			_x settriggerstatements ["true","",""];
			_x settriggertype "none";
		} foreach _areas;

		//--- Finalize the tasks
		_ownerID = _owner call bis_fnc_sideID;//_sides find _owner;
		{
			if (_x != "") then {
				_taskState = if (_foreachindex == _ownerID) then {"SUCCEEDED"} else {"CANCELED"};
				[_x,nil,nil,nil,_taskState] call bis_fnc_setTask;
			};
		} foreach _tasks;
	};
	case "player": {
		/////////////////////////////////////////////////////////////////////////////////////
		// Player
		/////////////////////////////////////////////////////////////////////////////////////
		_areas = _logic getvariable ["areas",[]];

		{
			_x settriggeractivation ["any","present",false];
			_x settriggerstatements ["false","",""];
			_x settriggertype "none";
		} foreach _areas;

		_layer = "RscMPProgress" call bis_fnc_rscLayer;
		_layer cutrsc ["RscMPProgress","plain"];

		waituntil {
			sleep 0.1;
			(_logic getvariable ["finalized",false]) || (isnull _logic)
		};
		_logic enablesimulation false;
	};
};