//Made by Shay_Gman (c) 02.14
private ["_action","_control","_show"];
disableSerialization;

_action = _this select 0;

//-------------------------------------------------------------------------------------Weather----------------------------------------------------------------------------------------------
if (_action == 0) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 501);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;		
	
	if (_show) then
	{
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10) sliderSetRange [0, 1];
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11) sliderSetRange [0, 1];
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12) sliderSetRange [0, 1];
		
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10) sliderSetPosition fog;
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11) sliderSetPosition rain;
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12) sliderSetPosition overcast;
	};
};

//-------------------------------------------------------------------------------------Time----------------------------------------------------------------------------------------------
if (_action == 1) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 502);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------Fill index--------------------------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 15);		// MONTH
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_months_array;
		_comboBox lbSetCurSel (date select 1)-1;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 16);		// Day
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach MCC_days_array;
		_comboBox lbSetCurSel (date select 2)-1;
		
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 17);		//  Year
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach [1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030];
		_comboBox lbSetCurSel ((date select 0)-1990);

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 18);		// HOUR
		lbClear _comboBox;
		{
			_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
			_comboBox lbAdd _displayname;
		} foreach MCC_hours_array;
		_comboBox lbSetCurSel (date select 3);

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 19);		// Minutes
		lbClear _comboBox;
		{
			_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
			_comboBox lbAdd _displayname;
		} foreach MCC_minutes_array;
		_comboBox lbSetCurSel (date select 4);
	};
};

//-------------------------------------------------------------------------------------RESPWAN----------------------------------------------------------------------------------------------
if (_action == 2) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 503);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------Fill index--------------------------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 20);		// Teleport
		lbClear _comboBox;
		{
			_displayname = _x;
			_comboBox lbAdd _displayname;
		} foreach ["Yes","No"];
		_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 21);		// FOB
		lbClear _comboBox;
		{
			_displayname = _x;
			_comboBox lbAdd _displayname;
		} foreach ["HQ","FOB"];
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------DEBUG----------------------------------------------------------------------------------------------
if (_action == 3) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 504);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
};

//-------------------------------------------------------------------------------------CAS----------------------------------------------------------------------------------------------
if (_action == 4) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 500);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------CAS--------------------------------------------------------------------------

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 25);		//fill combobox CAS Plane Type
		lbClear _comboBox;
		{
			_displayname =  format ["%1",(_x select 3)select 0];
			_index = _comboBox lbAdd _displayname;		
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach (U_GEN_AIRPLANE+U_GEN_HELICOPTER);
		_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 26);		//fill combobox CAS Bomb Type
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach MCC_CASBombs;
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------Artillery----------------------------------------------------------------------------------------------
if (_action == 5) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 505);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	//---------------------------------Artillery----------------------------------------------------------------------------
	_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30);		// Artillery Type
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_artilleryTypeArray;
		_comboBox lbSetCurSel 0;
		
	_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 31);		//Artillery Spread
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_artillerySpreadArray;
		_comboBox lbSetCurSel 0;

	_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 32);		//Artillery Number
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach MCC_artilleryNumberArray;
		_comboBox lbSetCurSel 0;
		
	_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 33);		//Artillery Delay
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["0","20 sec","40 sec","1 min","80  sec","100  sec","2 min","140 sec","160 sec","3 min"];
	_comboBox lbSetCurSel 0;
};