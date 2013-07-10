#define MCC_SANDBOX3_IDD 3000
#define MCC_TASKS_NAME 3056
#define MCC_TASKS_DESCRIPTION 3057
#define MCC_TASKS_LIST 3058

disableSerialization;
private ["_type", "_dlg", "_stringName", "_stringDescription", "_ok", "_comboBox"];
_type = _this select 0;

_dlg = findDisplay MCC_SANDBOX3_IDD;

	if (mcc_missionmaker == (name player)) then {
	switch (_type) do
	{
	   case 0:	//create
	   {_stringName = ctrlText (_dlg displayCtrl MCC_TASKS_NAME);
		_stringDescription = ctrlText (_dlg displayCtrl MCC_TASKS_DESCRIPTION); 
		_pos =[];
		mcc_safe=mcc_safe + FORMAT ["_type=%1;
								 _stringName='%2';
								 _stringDescription='%3';
								 _pos = %4;
								 [[_type, _stringName, _stringDescription, _pos],'MCC_fnc_makeTaks',true,false] spawn BIS_fnc_MP;
								sleep 1;"								 
								,_type
								,_stringName
								,_stringDescription
								,_pos
								];
		hint "Task updated";
		[[_type, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;
		sleep 1;
		_comboBox = (findDisplay MCC_SANDBOX3_IDD) displayCtrl MCC_TASKS_LIST; //fill Tasks
		lbClear _comboBox;
		{
			_comboBox lbAdd format ["%1",_x select 0];
		} foreach MCC_tasks;
		_comboBox lbSetCurSel 0;
		};
		
	   case 1:	//Set WP
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		stringDescription = lbCurSel MCC_TASKS_LIST;
		typ = _type;
		hint "Left click on the map to set a WP for this Task";
		if (MCC_capture_state) then
			{
			onMapSingleClick " 	hint 'Wp captured.'; 
								MCC_capture_var = MCC_capture_var + FORMAT ['
								[[%1, ""%2"", %3, %4],""MCC_fnc_makeTaks"",true,false] spawn BIS_fnc_MP;
								'
								,typ
								,stringName
								,stringDescription
								,_pos
								];
								onMapSingleClick """";";
			} else 
			{
			onMapSingleClick " 	hint 'Wp added.'; 
								[[typ, stringName, stringDescription, _pos],""MCC_fnc_makeTaks"",true,false] spawn BIS_fnc_MP;
								onMapSingleClick """";";
			};
		};
		
		case 2:	//Set Succeeded
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then  
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								_stringDescription =  (MCC_tasks select %1) select 1;
								_stringDescription setTaskState "SUCCEEDED";
								[[2,{["TaskSucceeded",["","%2"]] call bis_fnc_showNotification}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
								'
								,lbCurSel MCC_TASKS_LIST
								,_stringName
								];
			} else
			{
			_stringDescription setTaskState "SUCCEEDED";
			[[2,compile format ["['TaskSucceeded',['','%1']] call bis_fnc_showNotification;", _stringName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
		
		case 3:	//Set Failed
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								_stringDescription =  (MCC_tasks select %1) select 1;
								_stringDescription setTaskState "FAILED";
								[[2,{["TaskFailed",["","%2"]] call bis_fnc_showNotification}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
								'
								,lbCurSel MCC_TASKS_LIST
								,_stringName
								];
			} else
			{
			_stringDescription setTaskState "FAILED";
			[[2,compile format ["['TaskFailed',['','%1']] call bis_fnc_showNotification;", _stringName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
		
		case 4:	//Set Canceled
	   {
		if (count MCC_tasks == 0) exitWith {hint "You must create a task first"};
		_stringName = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 0; 
		_stringDescription = MCC_tasks select (lbCurSel MCC_TASKS_LIST) select 1;
		_pos =[];
		if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								_stringDescription =  (MCC_tasks select %1) select 1;
								_stringDescription setTaskState "CANCELED";
								[[2,{["TaskCanceled",["","%2"]] call bis_fnc_showNotification}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
								'
								,lbCurSel MCC_TASKS_LIST
								,_stringName
								];
			} else
			{
			_stringDescription setTaskState "CANCELED";
			[[2,compile format ["['TaskCanceled',['','%1']] call bis_fnc_showNotification;", _stringName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
		
		case 5:	//End Mission : Sucess
		{
			if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[2,{"end1" call BIS_fnc_endMission; playMusic "Track06_CarnHeli";}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
								'
								];
			} else
			{
			[[2,{"end1" call BIS_fnc_endMission; playMusic "Track06_CarnHeli";}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
		
		case 6:	//End Mission : Fail
		{
			if (MCC_capture_state) then
			{
			MCC_capture_var = MCC_capture_var + FORMAT ['
								[[2,{"LOSER" call BIS_fnc_endMission; playMusic "Track07_ActionDark";}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
								'
								];
			} else
			{
			[[2,{"LOSER" call BIS_fnc_endMission; playMusic "Track07_ActionDark";}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
	 };
} else {player globalchat "Access Denied"};

