/*=================================================================MCC_fnc_getSurvivalPlaceHolders===============================================================================
  Read mission or mod config and return and array with the class names of all allowed item's spawn place holders
  <IN>
  	returnObjects:		BOOLEAN if true returns an array of all optional classnames tha serves as place holders for item spawns if false return an array of all config names

*/
//Get what object spawn loot
private ["_cfgName","_return","_cfgClass","_returnObjects"];
_returnObjects = param [0,true, [true]];

if (isClass (missionconfigFile >> "CfgMCCspawnObjects")) then {
	_cfgClass = missionconfigFile >> "CfgMCCspawnObjects";
} else {
	_cfgClass = configFile >> "CfgMCCspawnObjects";
};

_return = [];
for "_i" from 0 to (count _cfgClass -1) do {
	_cfgName = configName (_cfgClass select _i);
	if (isNil _cfgName) then {
		missionNamespace setVariable [_cfgName,getArray (_cfgClass >> _cfgName >> "itemClasses")];
	};

	//Do we want all config classnames or all items classes
	if (_returnObjects) then {
		_return = _return + (missionNamespace getVariable [_cfgName,[]]);
	} else {
		_return pushBack _cfgName;
	};
};

missionNamespace setVariable ["MCC_SurvivalPlaceHoldersObjects",_return];
_return;