/*==================================================================MCC_fnc_handleDB=============================================================================================
	read/write/initate new DB
<In>
	_this select 0:		STRING DB name
	_this select 1:		STRING section name
	_this select 2:		STRING variable name
	_this select 3:		STRING "read"/"write"
	_this select 4:		ANY	 default return value or new value
	_this select 5:		optional if true will create a new DB default false - exit. If STRING will fallback to this DB as default if DB defined in (_this select 0) is not exist
============================================================================================================================================================================*/
private ["_dbName","_section","_var","_value","_newDB","_testVar","_dbExist","_inidbi","_read"];
_dbName = param [0,"",[""]];
_section = param [1,"",[""]];
_var = param [2,"",[""]];
_read = param [3,"read",[""]];
_value = param [4,"",["",true,[],0]];
_newDB = param [5,false,["",true]];

if !(missionNamespace getVariable ["MCC_iniDBenabled",false]) exitWith {

	//No iniDB use BI profiles saves
	if (toLower _read == "read") then {
		_value = profileNamespace getVariable [format ["%1_%2_%3", _dbName, _section, _var],_value];
	}  else {
		profileNamespace setVariable [format ["%1_%2_%3", _dbName, _section, _var],_value];
		saveProfileNamespace;
	};

	_value
};

//Is DB exist
_testVar = ("getDbName" call (missionNamespace getVariable [_dbName,{}]));
_dbExist = !(isNil "_testVar");

//Not exist and asked to create new one
if (!_dbExist) then {
	//Not exist and asked to use default
	if (typeName _newDB == typeName "") then {
		_dbName = _newDB;
		_testVar = ("getDbName" call (missionNamespace getVariable [_dbName,{}]));
		_dbExist = !(isNil "_testVar");

		//The default DB is not exist - make new one
		if (!_dbExist) then {
			missionNamespace setVariable [_dbName,(["new", _dbName] call OO_INIDBI)];
		};
	};

	if (typeName _newDB == typeName true ) then {
		if (_newDB) then {
			missionNamespace setVariable [_dbName,(["new", _dbName] call OO_INIDBI)];
		};
	};

	_testVar = ("getDbName" call (missionNamespace getVariable [_dbName,{}]));
	_dbExist = !(isNil "_testVar");
};

//Still no DB exit
if (!_dbExist) exitWith {systemChat "error"; false};

//Read/write
[_read, [_section, _var, _value]] call (missionNamespace getVariable [_dbName,{}]);