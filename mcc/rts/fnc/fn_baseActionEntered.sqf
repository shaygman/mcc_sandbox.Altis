//=================================================================MCC_fnc_baseActionEntered==============================================================================
//	hovering over a base icon
//  Parameter(s):
//     _ctrl: CONTROL
//     _ctrlText: STRING
//==============================================================================================================================================================================
private ["_ctrl","_ctrlPic","_ctrlText","_disp","_text","_res","_action","_cfgtext","_cfgName","_reqText","_req","_cfgFile","_radius"];
disableSerialization;

_ctrl = (_this select 0) select 0;
_cfgFile = _this select 1;

_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";
_radius = 200;

_cfgName = missionNamespace getVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],""];


//Action or building?
if (isClass (missionconfigFile >> _cfgFile)) then {
	_cfgtext = [getText (missionconfigFile >> _cfgFile >> _cfgName >> "displayName"),getText (missionconfigFile >> _cfgFile >> _cfgName >> "descriptionShort")];
	_res = getArray (missionconfigFile >> _cfgFile >> _cfgName >> "resources");
	_req = getArray (missionconfigFile >> _cfgFile >> _cfgName >> "requiredBuildings");
} else {
	_cfgtext = [getText (configFile >> _cfgFile >> _cfgName >> "displayName"),getText (configFile >> _cfgFile >> _cfgName >> "descriptionShort")];
	_res = getArray (configFile >> _cfgFile >> _cfgName >> "resources");
	_req = getArray (configFile >> _cfgFile >> _cfgName >> "requiredBuildings");
};

//Required buildings
_reqText = "";
{
	if !([_x, (MCC_ConsoleGroupSelected select 0), _radius] call MCC_fnc_CheckBuildings) then {
		if (_forEachIndex != 0) then {_reqText = _reqText + ", "};
		_reqText = _reqText + (if (MCC_isMode) then
		                {
		                 	getText (configFile >> "cfgRtsBuildings" >> (format ["MCC_rts_%1%2",_x select 0,_x select 1]) >> "displayName");
						}
						else
						{
							getText (missionconfigFile >> "cfgRtsBuildings" >> (format ["MCC_rts_%1%2",_x select 0,_x select 1]) >> "displayName");
						});
	};
} forEach _req;

//If we don't have all the needed facilities around let the player know
_text = if (_reqText != "") then {
	 format ["<t color='#FFD700' underline='true'>%1</t><br />%2 <br /><t color='#ff0000'>Requires: %3</t>",(_cfgtext select 0),(_cfgtext select 1),_reqText];
} else {
	 format ["<t color='#FFD700' underline='true'>%1</t><br />%2 <br /></t>",(_cfgtext select 0),(_cfgtext select 1),_reqText];
};

//Populate Resources
for [{_i= 121},{_i <= 127},{_i = _i + 2}] do
{
	_ctrl 		= (_disp displayCtrl _i);
	_ctrlPic	= (_disp displayCtrl (_i-1));
	if (count _res > 0) then
	{
		_action = _res select 0;
		_res set [0,-1];
		_res = _res - [-1];

		_ctrl ctrlShow true;
		_ctrlPic ctrlShow true;

		_ctrl ctrlSetText str(_action select 1);
		_ctrlPic ctrlSetText (format["%1data\Icon%2.paa",MCC_path,(_action select 0)]);

		if ([playerSide, _action] call MCC_fnc_CheckRes) then {
			_ctrl ctrlSetTextColor [1,1,1,1]
		}
		else
		{
			_ctrl ctrlSetTextColor [1,0,0,1]
		};
		_ctrl ctrlCommit 0;
	}
	else
	{
		_ctrl ctrlShow false;
		_ctrlPic ctrlShow false;
	};
};

//Add text
(_disp displayCtrl 150) ctrlSetStructuredText parseText _text;