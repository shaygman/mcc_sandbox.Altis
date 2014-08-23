//==================================================================MCC_fnc_initCuratorAttribute===============================================================================================

with uinamespace do 
{
	private ["_params","_class","_path","_fncName","_control","_fncFile"];

	_params = _this select 0;
	_class = _this select 1;
	
	_path =  if (isClass (configFile >> "CfgPatches" >> "mcc_sandbox")) then {"\mcc_sandbox_mod\"} 	else {""};
	
	//Work around for not showing sides
	_fncName = _class;
		
	_fncFile = preprocessfilelinenumbers format ["%2mcc\UI\rscommon\%1.sqf",_fncName, _path];
	_fncFile = format ["scriptname '%1_%2'; _fnc_scriptName = '%1';",_fncName] + _fncFile;
	uinamespace setvariable ["MCC_"+ _fncName,compile _fncFile];
	
	_control = _params select 0;
	_control ctrlremovealleventhandlers "setFocus";


	_display = ctrlparent _control;
	_display displayaddeventhandler ["unload",format ["with uinamespace do {['onUnload',_this,missionnamespace getvariable ['BIS_fnc_initCuratorAttributes_target',objnull]] call %1};","MCC_"+ _fncName]];


	_ctrlButtonOK = _display displayctrl 	1;
	_ctrlButtonOK ctrladdeventhandler [
	"buttonclick",
	format ["with uinamespace do {MCC_curatorOkButtonPressed = true;['confirmed',[ctrlparent (_this select 0)],missionnamespace getvariable ['BIS_fnc_initCuratorAttributes_target',objnull]] call %1}; false","MCC_"+ _fncName]
	];
	uinamespace setVariable ["MCC_curatorOkButtonPressed",false];
	_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull]; 
	["onLoad",[ctrlparent (_params select 0)],_target] call (uinamespace getvariable "MCC_"+ _fncName);
};
