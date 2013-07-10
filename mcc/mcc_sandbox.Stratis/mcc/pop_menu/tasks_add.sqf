disableSerialization;
private ["_type","_string","_exe","_markerstr","_text"];

_type = _this select 0;
_stringName = _this select 1;
_stringDescription = _this select 2;
_pos = _this select 3;

switch (_type) do
{
   case 0:		//create task
   {_exe = player createSimpleTask [_stringName];
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
   {MCC_tasks select _stringDescription select 1 setSimpleTaskDestination _pos;
	 deleteMarker _stringName;
   	_markerstr = createMarker[_stringName,_pos];
	_markerstr setMarkerShape "mil_objective";
	_stringName setMarkerType "Warning";
	_text = (MCC_tasks select _stringDescription) select 2;
	sleep 3; 
	[_pos,_text,200,200,180,0,[]] spawn BIS_fnc_establishingShot;
	sleep 1;
	playmusic format ["RadioAmbient%1", (floor (random 30) + 1)];
	MCC_sync=MCC_sync + FORMAT ["_type			=%1;
							_stringName			='%2';
						    _stringDescription	='%3';
							_pos 				= %4;
							_text				='%5';
							MCC_tasks select _stringDescription select 1 setSimpleTaskDestination _pos;
							 deleteMarker _stringName;
							_markerstr = createMarker[_stringName,_pos];
							_markerstr setMarkerShape 'mil_objective';
							_stringName setMarkerType 'Warning';
							sleep 1;
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
   
    case 2:
	{
	[[2,compile format ["%1 setTaskState 'SUCCEEDED'", _stringDescription] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	sleep 2; 
	[[2,compile format ["['TaskSucceeded',['%1','%2']] call bis_fnc_showNotification;", _stringName,_stringDescription]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	};
	
	case 3:
	{
	[[2,compile format ["%1 setTaskState 'FAILED'", _stringDescription] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	sleep 2; 
	[[2,compile format ["['TaskFailed',['%1','%2']] call bis_fnc_showNotification;", _stringName,_stringDescription]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	};
	
	case 4:
	{
	[[2,compile format ["%1 setTaskState 'CANCELED'", _stringDescription] ], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	sleep 2; 
	[[2,compile format ["['TaskCanceled',['%1','%2']] call bis_fnc_showNotification;", _stringName,_stringDescription]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	};
 };