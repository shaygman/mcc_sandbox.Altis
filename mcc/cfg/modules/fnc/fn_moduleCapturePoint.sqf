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

	--- Get number of sectors held by a side ---
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

//--- Return all capture points
if (typename _logic == typename true) exitwith {
	missionnamespace getvariable ["MCC_fnc_moduleCapturPoints_all",[]]
};

//--- Return all capture points belonging to a side
if (typename _logic == typename sideunknown) exitwith {
	private ["_side","_sideID"];
	_side = _logic;
	_sideID = _side call bis_fnc_sideID;
	_sectors = [];
	{
		if ((_x getvariable ["owner",sideUnknown])==_side) then {_sectors pushBack _x};
	} forEach (missionnamespace getvariable ["MCC_fnc_moduleCapturPoints_all",[]]);

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
		if (typeName (_logic getVariable ["type",true]) == typeName 0) then {
			_null = [_logic,[],_activated,"server"] spawn MCC_fnc_moduleCapturePoint;
		} else {
			//Zeus
			private ["_resualt","_type","_scoreReward","_flag","_radius"];

			_resualt = ["Create a cpature point",[
 						["Type",[["Ammo",format ["%1data\IconAmmo.paa",MCC_path]],["Supply",format ["%1data\IconRepair.paa",MCC_path]],["Fuel",format ["%1data\IconFuel.paa",MCC_path]]]],
 						["Radius",300],
 						["Score Reward",50],
 						["Flag",false]
 					  ]] call MCC_fnc_initDynamicDialog;

			_type = _resualt select 0;
			_radius = _resualt select 1;
			_scoreReward = _resualt select 2;
			_flag = _resualt select 3;

			if (count _resualt == 0) exitWith {deleteVehicle _logic};
			_logic setvariable ["type",_type,true];
			_logic setvariable ["ScoreReward",_scoreReward,true];
			_logic setvariable ["flag",_flag,true];
			_logic setvariable ["radius",_radius,true];

			_null = [[_logic,[],_activated,"server"],"MCC_fnc_moduleCapturePoint",false] call bis_fnc_mp;
		};
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
		_sides = [west,east,resistance];
		_iconsPaths = ["markerAmmo","markerRepair","markerFuel"];

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
			    case 0: {_markerName = _markerName + " (Supply)"};
			    case 1: {_markerName = _markerName + " (Fuel)"};
			    default {_markerName = _markerName + " (Ammo)"};
			};
		};

		_icon = if (MCC_isMode) then {format ["MCC_n_%1",_iconsPaths select _type]} else {"n_installation"};
		_iconTexture = _icon call bis_fnc_textureMarker;

		//--- Load synced objects
		_sectors = missionnamespace getvariable ["MCC_fnc_moduleCapturPoints_all",[]];
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
				MCC_curator addCuratorEditableObjects [[_dummy],false];
			};

			_trigger setvariable ["markers",_triggerMarkers];
			_trigger setvariable ["pos",[0,0,0]];
		};

		{
			if (_x iskindof "EmptyDetector") then {
				_x call _fnc_initArea;
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
		missionnamespace setvariable ["MCC_fnc_moduleCapturPoints_all",_sectors];
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
			_sides = _logic getvariable ["sides",_sides];
			_sectorScore = _logic getvariable ["sectorScore",[0,0,0]];
			_owner = _logic getvariable ["owner",sideUnknown];
			_sectorBalance = [0,0,0];

			//Calculate side strengths
			{
				{
					if ({alive _x} count crew _x > 0) then {
						_side = side group _x;
						if (_side in _sides && !(vehicle _x isKindOf "air")) then {
							_sideID = _side call bis_fnc_sideID;
							_balance = _sectorBalance select _sideID;
							_balance = _balance + ((count crew _x) min 3);
							_sectorBalance set [_sideID,_balance];
						};

						sleep 0.01;
					};

					if (isPlayer _x) then {
						if !(_x in _playersInList) then {_playersInList pushBack _x};
						[[_logic,[],true,"player",true],"MCC_fnc_moduleCapturePoint",_x] call bis_fnc_mp;
					};
				} foreach list _x;

				//Disable Progress Bar
				for "_i" from 0 to (count _playersInList)-1 do {
					private ["_player"];
					_player = _playersInList select _i;
					if !(_player in list _x) then {
						_playersInList set [_i,-1];
						[[_logic,[],true,"player",false],"MCC_fnc_moduleCapturePoint",_player] call bis_fnc_mp;
					};
					_playersInList = _playersInList - [-1];
				};

				sleep 0.1;
			} foreach _areas;

			//Lets find out who is wining
			_extreme = [_sectorBalance, 1] call BIS_fnc_findExtreme;
			_sideLeadingID = _sectorBalance find _extreme;
			_sideLeading = _sideLeadingID call bis_fnc_sideType;

			//Decay sector
			if (_extreme !=0) then {

				for "_i" from 0 to (count _sectorScore)-1 do {
					_score = ((_sectorScore select _i) + (if (_i == _sideLeadingID) then {_extreme} else {-_extreme})) max 0;
					_sectorScore set [_i,_score min 100];

					//we have a winner
					if (_score >= 100 && _owner !=(_i call bis_fnc_sideType)) exitWith {
						_owner = (_i call bis_fnc_sideType);
						_sectorScore = [0,0,0];
						_sectorScore set [_i,100];
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

				if (MCC_isMode) then {
					_icon = format ["MCC_%1_%2",["o","b","n"] select ((_owner call bis_fnc_sideID) min 2), _iconsPaths select _type];
				} else {
					_icon = ["o_installation","b_installation","n_installation"] select ((_owner call bis_fnc_sideID) min 2);
				};

				_iconTexture = _icon call bis_fnc_texturemarker;
				_markerIcon setmarkertype _icon;
				_markerIcon setmarkercolor _markerColor;

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
				{_x setflagtexture _flagTexture;} foreach nearestObjects [_logic,["FlagCarrierCore"],_radius];


				//--- Show notification
				_ownerName = _owner call bis_fnc_sidename;
				if (_owner != sideunknown) then {
					[[format ["sectorCaptured%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_sides - [_ownerOld]] call bis_fnc_mp;
					[[format ["sectorLost%1",_owner],[_name,_ownerName,_iconTexture,_designation]],"BIS_fnc_showNotification",_ownerOld] call bis_fnc_mp;
				};
			};

			_ownerOld = _owner;

			_logic setvariable ["sectorScore",_sectorScore,true];

			//Add resources
			if (_step mod 5 == 0 && _owner != sideUnknown) then {
				private ["_array","_res"];
				_array = call compile format ["MCC_res%1",_owner];
				_res = (_array select _type)+5;
				_array set [_type,_res];
				publicvariable format ["MCC_res%1",_owner];
			};

			_step =_step + 1;
			sleep 1;
		};

		//--- Sector finalized
		if (isnull _logic) then {

			_sectors = missionnamespace getvariable ["MCC_fnc_moduleCapturPoints_all",[]];
			_sectors = _sectors - [_logic,objnull];
			missionnamespace setvariable ["MCC_fnc_moduleCapturPoints_all",_sectors];
			publicvariable "MCC_fnc_moduleCapturPoints_all";

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
	};

	case "player": {
		private ["_progress","_logic"];
		disableSerialization;
		_logic = _this select 0;
		_progress = (_logic getvariable ["sectorScore",[0,0,0]]) select ((playerSide call bis_fnc_sideID) min 2);

		_progress = _progress/100;

		//Close the cature UI
		if (!(_this select 4) || _progress == 1) exitWith {(["MCC_captureProgressRsc"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];};



		//Create progress bar
		if (isnull (uiNamespace getVariable ["MCC_captureProgressRsc",objNull])) then {
			(["MCC_captureProgressRsc"] call BIS_fnc_rscLayer) cutRsc ["MCC_captureProgressRsc", "PLAIN"];
		};

		_ctrl = ((uiNameSpace getVariable "MCC_captureProgressRsc") displayCtrl 2);
		_ctrl ctrlSetText (_logic getvariable ["name",""]);
		_ctrl = ((uiNameSpace getVariable "MCC_captureProgressRsc") displayCtrl 1);

		_ctrl progressSetPosition _progress;
	};
};