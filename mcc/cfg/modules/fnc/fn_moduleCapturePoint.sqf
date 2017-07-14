/*
	MCC_fnc_moduleCapturePoint

	based on the script by BIS's Karel Moricky extended for MCC_fnc_moduleCapturePoint

	Description:
	Initialize a sector module. Can be also used to get sector parameters.

	--- Get all sectors ---
	Parameter(s):
		0: BOOL

	Returns:
	ARRAY of OBJECTs

	--- Get list of sectors held by a side ---
	Parameter(s):
		0: SIDE

	Returns:
	ARRAY - Array of sectors owned by the side

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

private ["_logic","_units","_activated","_markerIcon"];
_logic = param [0,objnull];
_units = param [1,[]];
_activated = param [2,true,[true]];
_mode = param [3,"init",[""]];

waitUntil {!isNil "MCC_initDone"};

//--- Return all capture points
if (typename _logic == typename true) exitwith {
	missionnamespace getvariable ["BIS_fnc_moduleSector_sectors",[]]
};

//--- Return all capture points belonging to a side
if (typename _logic == typename sideunknown) exitwith {
	private ["_side","_sideID"];
	_side = _logic;
	_sideID = _side call bis_fnc_sideID;
	_sectors = [];
	{
		if ((_x getvariable ["owner",sideUnknown])==_side) then {_sectors pushBack _x};
	} forEach (missionnamespace getvariable ["BIS_fnc_moduleSector_sectors",[]]);

	_sectors
};

//--- Set side
if (typename _units == typename sideunknown) exitwith {
	_logic setvariable ["owner",_units,true];
	true
};

//--- Initialize the sector
if !(_activated) exitwith {};


switch _mode do {

	case "init": {
		//did we get here from the 2d editor?
		_null = [_logic,[],_activated,"server"] spawn MCC_fnc_moduleCapturePoint;
	};

	case "server": {
		/////////////////////////////////////////////////////////////////////////////////////
		// Server
		/////////////////////////////////////////////////////////////////////////////////////

		//--- Load params
		_name = _logic getvariable ["Name",""];
		_designation = _logic getvariable ["Designation",""];
		_onOwnerChange = compile (_logic getvariable ["OnOwnerChange","true"]);
		_scoreReward = (_logic getvariable ["ScoreReward",0]) call bis_fnc_parsenumber;
		_type = (_logic getvariable ["type",0]) call bis_fnc_parsenumber;
		_radius = (_logic getvariable ["radius",50]) call bis_fnc_parsenumber;
		_flag = _logic getvariable ["flag",false];
		_enableHUD = _logic getvariable ["enableHUD",true];

		if (typeName _flag == typeName 0) then {_flag = _flag == 0};

		_sides = [west,east,resistance];
		_iconsPaths = ["markerAmmo","markerRepair","markerFuel"];

		//Enable HUD
		if (_enableHUD) then {
			{
				[[_logic,[],true,"initHUDLocal",false],"MCC_fnc_moduleCapturePoint",_x,true] call bis_fnc_mp;
			} forEach _sides;
		};

		//Start ticket bleed
		if (_type == 3) then {
			_null = [_logic,[],true,"initTickets"] spawn MCC_fnc_moduleCapturePoint;
		};

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
		if !(MCC_isMode) then {
			switch (_type) do {
			    case 0: {_markerName = _markerName + " (Ammo)"};
			    case 1: {_markerName = _markerName + " (Supply)"};
			    case 2: {_markerName = _markerName + " (Fuel)"};
			};
		};

		_icon = if (MCC_isMode && _type <3) then {format ["MCC_n_%1",_iconsPaths select _type]} else {"n_installation"};
		_iconTexture = _icon call bis_fnc_textureMarker;
		_logic setVariable ["texture",_iconTexture,true];

		//--- Load synced objects
		_sectors = missionnamespace getvariable ["BIS_fnc_moduleSector_sectors",[]];
		_areas = [];
		_markersArea = [];
		_markerIconText = "";

		_fnc_initArea = {
			_trigger = _this;
			_areas = _areas - [_trigger];
			_areas set [count _areas,_trigger];

			_trigger settriggeractivation ["any","present",false];
			_trigger settriggerstatements ["false","",""];
			_trigger settriggertype "none";
			_size = (triggerArea _trigger);
			_size resize 2;
			_triggerMarkers = _trigger getvariable ["markers",[]];
			_markerArea = createmarker ["MCC_fnc_moduleSector_area" + str _trigger,position _trigger];
			_markerArea setMarkerBrush "Grid";
			_markerArea setMarkerColor "colorwhite";
			_markerArea setMarkerShape "ELLIPSE";
			_markerArea setmarkeralpha 0.5;
			_markerArea setMarkerDir ((triggerArea _trigger) select 2);
			_markerArea setMarkerSize _size;
			_markersArea pushBack _markerArea;

			_triggerMarkers set [count _triggerMarkers,_markerArea];

			_markerIcon = createmarker ["MCC_fnc_moduleSector_icon" + str _logic,position _trigger];
			_markerIcon setmarkertype _icon;
			_markerIcon setmarkercolor "colorwhite";
			_markerIcon setmarkersize [1.5,1.5];
			_triggerMarkers set [count _triggerMarkers,_markerIcon];

			_markerIconText = createmarker ["MCC_fnc_moduleSector_iconText" + str _logic,position _trigger];
			_markerIconText setmarkertype "EmptyIcon";
			_markerIconText setmarkercolor "colorblack";
			_markerIconText setmarkertext _markerName;
			_markerIconText setmarkersize [1.5,1.5];
			_triggerMarkers set [count _triggerMarkers,_markerIconText];

			//build flag pole
			if (_flag) then {
				_dummy = "FlagPole_F" createVehicle position _trigger;
				{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;

			};

			_trigger setvariable ["markers",_triggerMarkers];
			_trigger setvariable ["pos",[0,0,0]];
		};

		//Find zones
		{
			switch (true) do {
				case (typeof _x == "MiscUnlock_F"): {
					{
						if (_x iskindof "EmptyDetector") then {
							waituntil {triggerActivated _x};
						};
					} forEach (synchronizedobjects _x);
				};

				case (typeof _x == "LocationArea_F"): {
					{
						if (_x iskindof "EmptyDetector") then {
							_x call _fnc_initArea;
						};
					} forEach (synchronizedobjects _x);
				};
			};
		} foreach (synchronizedobjects _logic);

		//--- No synced triggers found - create a default one
		if (count _areas == 0) then {
			_areaTrigger = createtrigger ["emptydetector",position _logic];
			_areaTrigger settriggerarea [_radius,_radius,0,false];
			_areaTrigger call _fnc_initArea;
			_areaTrigger attachto [_logic];
		};

		//--- Save global variables
		_logic setvariable ["finalized",false,true];
		_logic setvariable ["pos",markerpos _markerIcon,true];
		_logic setvariable ["areas",_areas,true];
		_logic setvariable ["sides",_sides,true];
		_logic setvariable ["designation",_designation,true];

		_sectors set [count _sectors,_logic];
		missionnamespace setvariable ["BIS_fnc_moduleSector_sectors",_sectors];
		publicvariable "MCC_fnc_moduleCapturPoints_all";

		//--- Wait until scripts are initialized (to avoid being faster than initServer.sqf)
		waituntil {!isnil "bis_fnc_init"};

		//--- Global loop -----------------------------------------------------------
		_allSides = [east,west,resistance,civilian,sideunknown,sideenemy];
		_pos = position _logic;
		_owner = sideEnemy;
		_ownerOld = _owner;
		_sideLeading = sideUnknown;
		_sideLeadingID = 0;
		_step = 0;
		_playersInList = [];

		while {!(isnull _logic) && (simulationenabled _logic) && !(_logic getvariable ["finalized",false])} do {

			//--- Load variables
			_areas = _logic getvariable ["areas",_areas];
			_sides = [west,east,resistance];
			_sectorScore = _logic getvariable ["sideScore",[0,0,0,0,0,0]];
			_owner = _logic getvariable ["owner",sideUnknown];
			_sectorBalance = [0,0,0,0,0,0];

			//Calculate side strengths
			{
				{
					if ({alive _x} count crew _x > 0) then {
						_side = side group _x;
						if (_side in _sides && !(vehicle _x isKindOf "air")) then {
							_sideID = _side call bis_fnc_sideID;
							_balance = _sectorBalance select _sideID;
							_balance = _balance + (((count crew _x) min 3)/200);
							_sectorBalance set [_sideID,_balance];
						};

						sleep 0.01;
					};

					if (isPlayer _x) then {
						if !(_x in _playersInList) then {_playersInList pushBack _x};
						[[_logic,[],true,"player",true],"MCC_fnc_moduleCapturePoint",_x] call bis_fnc_mp;
					};
				} foreach list _x;

				sleep 0.1;
			} foreach _areas;

			//Disable Progress Bar
			for "_i" from 0 to (count _playersInList)-1 do {
				private ["_player"];
				_player = _playersInList select _i;
				if !(isNil "_player") then {
					if ({_player in list _x} count _areas <= 0) then {
						_playersInList set [_i,-1];
						[[_logic,[],true,"player",false],"MCC_fnc_moduleCapturePoint",_player] call bis_fnc_mp;
					};
				};
			};

			_playersInList = _playersInList - [-1];

			//Lets find out who is wining
			_extreme = [_sectorBalance, 1] call BIS_fnc_findExtreme;
			_sideLeadingID = _sectorBalance find _extreme;
			_sideLeading = _sideLeadingID call bis_fnc_sideType;

			//Decay sector
			if (_extreme !=0) then {

				for "_i" from 0 to (count _sectorScore)-1 do {
					_score = ((_sectorScore select _i) + (if (_i == _sideLeadingID) then {_extreme} else {-_extreme})) max 0;
					_sectorScore set [_i,_score min 1];

					//we have a winner
					if (_score >= 1 && _owner !=(_i call bis_fnc_sideType)) exitWith {
						_owner = (_i call bis_fnc_sideType);
						_sectorScore = [0,0,0,0,0,0];
						_sectorScore set [_i,1];
					};
				};
			};

			//--- Execute code when ownership changes
			if (_owner != _ownerOld) then {

				//--- Call custom code
				[_logic,"ownerChanged",[_logic,_owner,_ownerOld]] call bis_fnc_callscriptedeventhandler;

				//--- Broadcast
				_logic setvariable ["owner",_owner,true];

				//--- Reward
				_owner addscoreside _scoreReward;

				//--- Update markers
				_markerColor = "colorwhite";
				if (_owner != sideUnknown) then {
					_markerColor = [_owner,true] call bis_fnc_sidecolor;
				};

				if (MCC_isMode && _type <3) then {
					_icon = format ["MCC_%1_%2",["o","b","n"] select ((_owner call bis_fnc_sideID) min 2), _iconsPaths select _type];
				} else {
					_icon = ["o_installation","b_installation","n_installation"] select ((_owner call bis_fnc_sideID) min 2);
				};

				_iconTexture = _icon call bis_fnc_texturemarker;
				_markerIcon setmarkertype _icon;
				_markerIcon setmarkercolor _markerColor;
				_logic setVariable ["texture",_iconTexture,true];

				{
					_x setmarkercolor _markerColor;
					if (_markerColor == "colorblack") then {_x setmarkeralpha 0.25;} else {_x setmarkeralpha 0.5;};
				} foreach _markersArea;

				//----Update Flags
				_flagTexture = "";
				{
					{
						if (_flagTexture != "") exitWith {};

						if (side _x == _owner) then {
							_ownerFaction = gettext (configfile >> "cfgvehicles" >> typeof _x >> "faction");
							_flagTexture = gettext (configfile >> "cfgfactionclasses" >> _ownerFaction >> "flag");
						};
					} foreach list _x;

					if (_flagTexture != "") exitWith {};

					sleep 0.1;
				} foreach _areas;

				if (_flagTexture =="") then {(_owner call bis_fnc_sidecolor) call bis_fnc_colorRGBAtoTexture};

				//Change texture
				{
					{_x setflagtexture _flagTexture;} foreach nearestObjects [(getpos _x),["FlagCarrierCore"],_radius];
				} foreach _areas;


				//--- Show notification
				_ownerName = _owner call bis_fnc_sidename;
				if (_owner != sideunknown) then {
					[[format ["sectorCaptured%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_sides - [_ownerOld]] call bis_fnc_mp;
					[[format ["sectorLost%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_ownerOld] call bis_fnc_mp;
				};
			};

			_ownerOld = _owner;

			_logic setvariable ["sideScore",_sectorScore,true];

			//Add resources
			if (_step mod 5 == 0 && _owner != sideUnknown && _type <3) then {
				private ["_array","_res","_resources"];
				_array = call compile format ["MCC_res%1",_owner];

				//get number of storage
				_resources = ["resources",_owner] call MCC_fnc_rtsCalculateResourceTreshold;
				_res = (_array select _type)+5;

				//Don't add more resources then can handle
				if (_res <= _resources) then {
					_array set [_type,_res];
					publicvariable format ["MCC_res%1",_owner];
				};
			};

			_step =_step + 1;
			sleep 1;
		};

		//Disable Progress Bar
		for "_i" from 0 to (count _playersInList)-1 do {
			private ["_player"];
			_player = _playersInList select _i;
			[[_logic,[],true,"player",false],"MCC_fnc_moduleCapturePoint",_player] call bis_fnc_mp;
			sleep 0.01;
		};

		//--- Sector finalized
		if (isnull _logic) then {

			_sectors = missionnamespace getvariable ["BIS_fnc_moduleSector_sectors",[]];
			_sectors = _sectors - [_logic,objnull];
			missionnamespace setvariable ["BIS_fnc_moduleSector_sectors",_sectors];
			publicvariable "BIS_fnc_moduleSector_sectors";

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
				//_x setmarkeralpha (markeralpha _x * 0.5);
				deleteMarker _x;
			} foreach (_markersArea + [_markerIcon,_markerIconText]);
		};

		//--- Activate area triggers
		{
			_x settriggeractivation ["any","present",false];
			_x settriggerstatements ["true","",""];
			_x settriggertype "none";
		} foreach _areas;
	};

	case "player": {
		private ["_progress","_logic"];
		disableSerialization;
		_logic = _this select 0;
		_progress = (_logic getvariable ["sideScore",[0,0,0,0,0]]) select ((playerSide call bis_fnc_sideID) min 2);

		//_progress = _progress/100;

		//Create progress bar
		if (isnull (uiNamespace getVariable ["MCC_hud",objNull])) then {
			(["MCC_hud"] call BIS_fnc_rscLayer) cutRsc ["MCC_hud", "PLAIN"];
			_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl 20);
			_ctrl ctrlSetPosition  [(0.5 * safezoneW + safezoneX), (0.1 * safezoneH + safezoneY), 0, (0.033 * safezoneH)];
			_ctrl ctrlCommit 0;
		};

		_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl 20);

		//Close the capture UI
		if ((!(_this select 4) || _progress == 1 || !(alive player) || (player getvariable ["MCC_medicUnconscious",false])) && (((ctrlPosition _ctrl) select 2) > 0)) exitWith {
			_ctrl ctrlSetPosition  [(0.5 * safezoneW + safezoneX), (0.1 * safezoneH + safezoneY), 0, (0.033 * safezoneH)];
			_ctrl ctrlCommit 0.2;
			playSound "MCC_pop";
		};

		//Open ctrl
		if (((ctrlPosition _ctrl) select 2) == 0 && _progress < 1) then {
			_ctrl ctrlSetPosition  [(0.298906 * safezoneW + safezoneX), (0.1 * safezoneH + safezoneY), (0.4125 * safezoneW), (0.033 * safezoneH)];
			_ctrl ctrlCommit 0.2;
			playSound "MCC_pop"
		};

		_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl 22);
		_ctrl ctrlSetText (_logic getvariable ["name",""]);
		_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl 21);

		_ctrl progressSetPosition _progress;
	};

	case "initHUDLocal": {
		if (missionNamespace getVariable ["MCC_capturePointsHudEnabled",false]) exitWith {};
		missionNamespace setVariable ["MCC_capturePointsHudEnabled",true];

		//Create game HUD
		private _layer = "RscMPProgress" call bis_fnc_rscLayer;
		_layer cutrsc ["RscMPProgress","plain"];

		//Create structures Icons
		["MCC_capturePointsHudID", "onEachFrame",
		{
			private ["_obj","_text","_color","_texture","_pos"];
			{
				_obj 	= _x;
				_pos = position ((_obj getvariable ["areas",[objNull]]) select 0);
				_pos set [2,(_pos select 2)+20];

				_text 	= _obj getvariable ["name",""];
				_texture = _obj getVariable ["texture",""];
				_color = [(_obj getvariable ["owner",sideUnknown])] call bis_fnc_sidecolor;
				_color set [3,1-(((player distance2d _pos)/1000)) max 0.2];
				_text = _text + format [" %1 m",floor (player distance2d _pos)];


				drawIcon3D [
								_texture,
								_color,
								_pos,
								1,
								1,
								0,
								_text,
								1,
								0.04,
								"PuristaMedium"
							];
			} forEach ([true] call MCC_fnc_moduleCapturePoint);
		}] call BIS_fnc_addStackedEventHandler;
	};

	case "initTickets": {
		if (missionNamespace getVariable ["MCC_capturePointsinitTickets",false]) exitWith {};
		missionNamespace setVariable ["MCC_capturePointsinitTickets",true];

		private ["_scoreWest","_scoreEast","_scoreReistance","_winingSide","_sides","_side"];

		while {true} do {
		    _scoreEast = 0;
			_scoreWest = 0;
			_scoreReistance = 0;
			_sides = [west,east,resistance];
			_winingSide = sideUnknown;

			{
				if ((_x getvariable ["type",0])==3) then {
					switch (_x getvariable ["owner",sideUnknown]) do {
					    case east: {_scoreEast = _scoreEast +1};
					    case west: {_scoreWest = _scoreWest +1};
					    case resistance: {_scoreReistance = _scoreReistance +1};
					};
				};
			} forEach ([true] call MCC_fnc_moduleCapturePoint);


			if (_scoreEast > _scoreWest && _scoreEast > _scoreReistance) then {
				_winingSide = east;
			} else {
				if (_scoreWest > _scoreEast && _scoreWest > _scoreReistance) then {
					_winingSide = west;
				} else {
					if (_scoreReistance > _scoreEast && _scoreReistance > _scoreWest) then {
						_winingSide = resistance;
					};
				};
			};

			/*
			if (_winingSide != sideUnknown) then {
				_sides = _sides - [_winingSide];

				//Bleed tickets
				{
					_side = _x;
					if ({side _x == _side} count allUnits > 2) then {
						[_side,-1] call BIS_fnc_respawnTickets;
					};


					if (([_side] call BIS_fnc_respawnTickets)<1) exitWith {
						[["sidetickets"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP;
					};

				} forEach _sides;
			};
			*/
			sleep 10;
		};
	};
};