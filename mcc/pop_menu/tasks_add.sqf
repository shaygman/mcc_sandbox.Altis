disableSerialization;
private ["_type","_string","_exe","_markerstr","_text","_stringName","_counter","_side"];

_type 				= _this select 0;
_stringName 		= _this select 1;
_stringDescription 	= _this select 2;
_pos 				= _this select 3;
_side				= _this select 4;

if (isnil "_side") then {_side = 0};

_side = switch (_side) do
		{
				case 0 : {[west,east,resistance,civilian]};
				case 1 : {[west]};
				case 2 : {[east]};
				case 3 : {[resistance]};
		};
		
if (!(side player in _side)) exitWith {}; 

if (isnil "_stringDescription") then {_stringDescription = ""}; 

switch (_type) do
{
	case 0:		//create task
	{
		_exe = player createSimpleTask [_stringName];
		_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
		MCC_tasks set [count MCC_tasks,[_stringName,_exe,_stringDescription]];
		MCC_sync=MCC_sync + FORMAT ['_type=%1;
								_stringName="%2";
								_stringDescription="%3";
								_pos = %4;
								_exe = player createSimpleTask [_stringName];
								_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
								MCC_tasks set [count MCC_tasks,[_stringName,_exe]];
								sleep 1;'								 
								,_type
								,_stringName
								,_stringDescription
								,_pos
								];
	};

	case 1:	//Set task destination
	{
		(MCC_tasks select _stringDescription) select 1 setSimpleTaskDestination _pos;
		 deleteMarker _stringName;
		_markerstr = createMarker[_stringName,_pos];
		_markerstr setMarkerShape "mil_objective";
		_stringName setMarkerType "Warning";
		_text = (MCC_tasks select _stringDescription) select 2;
		if (isnil "_text") then {_text = ""};
		["TaskAssigned",[_stringName,_stringName]] call bis_fnc_showNotification;
		sleep 3; 
		[_pos,_text,200,200,180,0,[]] spawn BIS_fnc_establishingShot;
		sleep 1;
		playmusic format ["RadioAmbient%1", (floor (random 30) + 1)];
		MCC_sync=MCC_sync + FORMAT ["_type			=%1;
								_stringName			='%2';
								_stringDescription	=%3;
								_pos 				= %4;
								_text				='%5';
								(MCC_tasks select _stringDescription) select 1 setSimpleTaskDestination _pos;
								 deleteMarker _stringName;
								_markerstr = createMarker[_stringName,_pos];
								_markerstr setMarkerShape 'mil_objective';
								_stringName setMarkerType 'Warning';
								['TaskAssigned',[_stringName,_stringName]] call bis_fnc_showNotification;
								sleep 2;
								[_pos,_text,200,200,180,0,[]] spawn BIS_fnc_establishingShot;
								sleep 5;
								"								 
								,_type
								,_stringName
								,_stringDescription
								,_pos
								,_text
								];
	};

	//Succeed
	case 2:
	{
		for [{_i=0},{_i < count MCC_tasks},{_i=_i+1}] do {
			if (_stringName == (MCC_tasks select _i) select 0) then {_counter = _i; _i = count MCC_tasks}; 
			};
		if (isnil "_counter") exitWith {}; 
		[[2,compile format ["((MCC_tasks select %1) select 1) setTaskState 'SUCCEEDED'", _counter] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		sleep 2; 
		['TaskSucceeded',["",_stringName]] call bis_fnc_showNotification;
	};

	//Failed
	case 3:
	{
		for [{_i=0},{_i < count MCC_tasks},{_i=_i+1}] do {
			if (_stringName == (MCC_tasks select _i) select 0) then {_counter = _i; _i = count MCC_tasks}; 
			};
		[[2,compile format ["((MCC_tasks select %1) select 1) setTaskState 'FAILED'", _counter] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		sleep 2; 
		['TaskFailed',["",_stringName]] call bis_fnc_showNotification;
	};

	//Canceled
	case 4:
	{
		for [{_i=0},{_i < count MCC_tasks},{_i=_i+1}] do {
			if (_stringName == (MCC_tasks select _i) select 0) then {_counter = _i; _i = count MCC_tasks}; 
			};
		[[2,compile format ["((MCC_tasks select %1) select 1) setTaskState 'CANCELED'", _counter] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		sleep 2; 
		['TaskCanceled',["",_stringName]] call bis_fnc_showNotification;
	};

	case 7:	//Set task destination - No ciniametic
	{
		MCC_tasks select _stringDescription select 1 setSimpleTaskDestination _pos;
		 deleteMarker _stringName;
		_markerstr = createMarker[_stringName,_pos];
		_markerstr setMarkerShape "mil_objective";
		_stringName setMarkerType "Warning";
		_text = (MCC_tasks select _stringDescription) select 2;
		['TaskAssigned',[_stringName,_stringName]] call bis_fnc_showNotification;
		sleep 1;
		MCC_sync=MCC_sync + FORMAT ["_type			=%1;
								_stringName			='%2';
								_stringDescription	=%3;
								_pos 				= %4;
								MCC_tasks select _stringDescription select 1 setSimpleTaskDestination _pos;
								 deleteMarker _stringName;
								_markerstr = createMarker[_stringName,_pos];
								_markerstr setMarkerShape 'mil_objective';
								_stringName setMarkerType 'Warning';
								['TaskAssigned',[_stringName,_stringName]] call bis_fnc_showNotification;
								sleep 1;
								"								 
								,_type
								,_stringName
								,_stringDescription
								,_pos
								];
	};
	case 8:		//create task and WP Mission Wizard
	{
		_exe = player createSimpleTask [_stringName];
		_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
		MCC_tasks set [count MCC_tasks,[_stringName,_exe,_stringDescription]];
		_exe setSimpleTaskDestination _pos;
		_markerstr = createMarker[_stringName,_pos];
		_markerstr setMarkerShape "mil_objective";
		_stringName setMarkerType "Warning";
		['TaskAssigned',[_stringName,_stringName]] call bis_fnc_showNotification;
		MCC_sync=MCC_sync + FORMAT ['
								_stringName="%1";
								_stringDescription="%2";
								_pos = %3;
								_exe = player createSimpleTask [_stringName];
								_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
								MCC_tasks set [count MCC_tasks,[_stringName,_exe]];
								_exe setSimpleTaskDestination _pos;
								_markerstr = createMarker[_stringName,_pos];
								_markerstr setMarkerShape "mil_objective";
								_stringName setMarkerType "Warning";
								["TaskAssigned",[_stringName,_stringName]] call bis_fnc_showNotification;
								sleep 1;'								 
								,_stringName
								,_stringDescription
								,_pos
							   ];
	};

	//Delete Task
	case 9:
	{
		for [{_i=0},{_i < count MCC_tasks},{_i=_i+1}] do 
		{
			if (_stringName == (MCC_tasks select _i) select 0) then {_counter = _i; _i = count MCC_tasks}; 
		};

		if (isnil "_counter") exitWith {};

		[[2,compile format ["player removeSimpleTask ((MCC_tasks select %1) select 1)", _counter] ], "MCC_fnc_globalExecute", true, false] call BIS_fnc_MP;

		sleep 1;
		//If server then trim the Array
		if (isServer) then
		{
			MCC_tasks set [_counter,-1];
			MCC_tasks = MCC_tasks - [-1];
			publicVariable "MCC_tasks";
		};
	};

	case 10:		//create task and WP Cinematic
	{
		_exe = player createSimpleTask [_stringName];
		_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
		MCC_tasks set [count MCC_tasks,[_stringName,_exe,_stringDescription]];
		_exe setSimpleTaskDestination _pos;
		_markerstr = createMarker[_stringName,_pos];
		_markerstr setMarkerShape "mil_objective";
		_stringName setMarkerType "Warning";
		['TaskAssigned',[_stringName,_stringName]] call bis_fnc_showNotification;
		sleep 3; 
		[_pos,_stringDescription,200,200,180,0,[]] spawn BIS_fnc_establishingShot;
		sleep 1;
		playmusic format ["RadioAmbient%1", (floor (random 30) + 1)];
		
		MCC_sync=MCC_sync + FORMAT ['
								_stringName="%1";
								_stringDescription="%2";
								_pos = %3;
								_exe = player createSimpleTask [_stringName];
								_exe setSimpleTaskDescription [_stringDescription, _stringName, _stringName];
								MCC_tasks set [count MCC_tasks,[_stringName,_exe]];
								_exe setSimpleTaskDestination _pos;
								_markerstr = createMarker[_stringName,_pos];
								_markerstr setMarkerShape "mil_objective";
								_stringName setMarkerType "Warning";
								["TaskAssigned",[_stringName,_stringName]] call bis_fnc_showNotification;
								sleep 2;
								[_pos,_stringDescription,200,200,180,0,[]] spawn BIS_fnc_establishingShot;
								sleep 5;
								'								 
								,_stringName
								,_stringDescription
								,_pos
							   ];
	};
};
 if (isServer) then {publicVariable "MCC_sync"}; 