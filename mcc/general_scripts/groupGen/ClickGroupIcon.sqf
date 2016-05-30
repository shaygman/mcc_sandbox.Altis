//==================================================================ClickGroupIcon===============================================================================================
// Define what will happen once a group icon has been pressed in the MCC conosle
// Example:[_group,_button,_pos,_shift,_ctrl,_alt] execVM ClickGroupIcon.sqf;
// _group	 = group
// _button = integer, 0 - left mouse button, 1 - right mouse button
// _pos = _x, _y
//_shift = boolean
//_ctrl = boolean
//_alt = boolean
//==================================================================================================================================================================================
#define groupGen_IDD 2994
#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenInfo_IDC 530
#define MCC_GroupGenInfo_zone_IDC 5311
#define MCC_GroupGenInfo_gaiaBehaviorCombo_IDC 5312
#define MCC_GroupGenInfo_gaiaBehaviorButton_IDC 5313
#define MCC_GroupGenInfo_gaiaRespawnCombo_IDC 5314
#define MCC_GroupGenInfo_gaiaRespawnComboButton_IDC 5315
#define MCC_GroupGenInfo_giveToPlayer_IDC 5316
#define MCC_GroupGenInfo_cacheButton_IDC 5317

private ["_mccdialog","_group","_button","_posX","_posY","_shift","_ctrl","_alt","_html","_info","_rank","_icon","_groupSize","_properCfg","_lineCounter"];
disableSerialization;

_mccdialog = findDisplay groupGen_IDD;

_group = _this select 0;
_button = _this select 1;
_posX = (_this select 2) select 0;
_posY = (_this select 2) select 1;
_shift = _this select 3;
_ctrl = _this select 4;
_alt = _this select 5;
_properCfg = 8; 		//if the cfg file is good then take from array number 8  else false - count on sim not vehicleClass take from array 5

if (isnil "MCC_GroupGenGroupSelected") then {MCC_GroupGenGroupSelected = []};

if ((_button == 0) && (_ctrl)) then 													//multi-select
	{
		MCC_GroupGenGroupSelected set [count MCC_GroupGenGroupSelected, _group];
		_icon = _group addGroupIcon ["selector_selectedFriendly",[0,0]];
		_group setvariable ["MCCgroupIconDataSelected",_icon,false];
	};

if (((_button == 0) && (!_ctrl)) || (_button == 1 )) then 								//Not multi-select
	{
		MCC_ConsoleGroupFocused = _group;
		{_x removeGroupIcon (_x getvariable "MCCgroupIconDataSelected")} foreach MCC_GroupGenGroupSelected;
		MCC_GroupGenGroupSelected = [];
		MCC_GroupGenGroupSelected set [count MCC_GroupGenGroupSelected, _group];
		_icon = _group addGroupIcon ["selector_selectedFriendly",[0,0]];
		_group setvariable ["MCCgroupIconDataSelected",_icon,false];
	};

if (_button == 0) then 												//Left Click
	{

	};

if (_button == 1) then 											//Right click - get info
	{
		_rank =[leader _group,"displayNameShort"] call BIS_fnc_rankParams;

		_groupSize	= gettext (configfile >> "CfgMarkers" >> ((_group getvariable "MCCgroupIconSize") select 1) >> "name");
		_html = "<t color='#818960' size='1' shadow='1' align='center' underline='true'>" +groupID _group + " - " + toupper _groupSize +"</t><br/>";

		_info = [_group] call MCC_fnc_countGroupHC;
		if (_info select 0 == 0 && _info select 1 == 0 && _info select 2 == 0 && _info select 3 == 0 && _info select 4 == 0 && _info select 5 == 0 && _info select 6 == 0 && _info select 7 == 0) then
		{
			_info = [_group] call MCC_fnc_countGroup;
			_properCfg = 5;
		};

		_html = _html + "<t font='puristaMedium' color='#fefefe' size='0.9' shadow='1' align='center' underline='false'>" + _rank + " " + name leader _group + "<br/>" + behaviour leader _group + " </t><br/>";

		_lineCounter = 0;

		//Infantry
		private "_infCount";
		_infCount = if (_properCfg > 5) then {(_info select 0) + (_info select 5)} else {(_info select 0)};

		if (_infCount > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Infantry: " + str _infCount + " </t>";
			for [{_x = 0},{_x < (_info select 0)},{_x = _x+1}] do
				{
					_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>|</t>";
				};
			_html = _html +	"<br/>";
		};

		//Vehicles
		if ((_info select 1) > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Motorized: " + str (_info select 1) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select _properCfg) select 0);
			_html = _html +	"<br/>";
		};

		//Armor
		if ((_info select 2) > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Armored: " + str (_info select 2) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select _properCfg) select 1);
			_html = _html +	"<br/>";
		};

		//Air
		if ((_info select 3) > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Air: " + str (_info select 3) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select _properCfg) select 2);
			_html = _html +	"<br/>";
		};

		//Naval
		if ((_info select 4) > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Naval: " + str (_info select 4) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select _properCfg) select 3);
			_html = _html +	"<br/>";
		};

		if (_properCfg > 5) then
		{
			//Support
			if ((_info select 6) > 0) then
			{
				_lineCounter = _lineCounter + 1;
				_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Support: " + str (_info select 6) + " </t>";
					{
						_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
					} foreach ((_info select _properCfg) select 4);
				_html = _html +	"<br/>";
			};

			//autonomous
			if ((_info select 7) > 0) then
			{
				_lineCounter = _lineCounter + 1;
				_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Autonomous: " + str (_info select 7) + " </t>";
					{
						_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
					} foreach ((_info select _properCfg) select 5);
				_html = _html +	"<br/>";
			};
		};

		private ["_UIFactor","_ctrl","_displayname"];

		_UIFactor = (0.02 * _lineCounter)* safezoneH;

		//Prase the text :)
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfoText_IDC;
		_ctrl ctrlSetStructuredText parseText _html;
		_ctrl ctrlSetPosition [0, 0,0.17 * safezoneW, _UIFactor + (0.07 * safezoneH)];
		_ctrl ctrlCommit 0;

		//Reveal GAIA Zone
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_zone_IDC;
		_ctrl ctrlSetPosition [(0.002 * safezoneW), _UIFactor + (0.07 * safezoneH) ,0.0458333 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		lbClear _ctrl;
		{
			_displayname = format ["%1",_x];
			_ctrl lbAdd _displayname;
		} foreach (missionNamespace getVariable ["MCC_zones_numbers",[]]);
		_ctrl lbSetCurSel MCC_zone_index;

		//Reveal GAIA Behavior
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_gaiaBehaviorCombo_IDC;
		_ctrl ctrlSetPosition [(0.055 * safezoneW), _UIFactor + (0.07 * safezoneH) ,0.06875 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		lbClear _ctrl;
		{
			_displayname = format ["%1",_x select 0];
			_index = _ctrl lbAdd _displayname;
		} foreach MCC_GAIA_spawn_behaviors;
		_ctrl lbSetCurSel 0;

		//Reveal GAIA Button
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_gaiaBehaviorButton_IDC;
		_ctrl ctrlSetPosition [(0.13 * safezoneW), _UIFactor + (0.07 * safezoneH) ,0.035 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;


		//Reveal GAIA Respawn numbers
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_gaiaRespawnCombo_IDC;
		_ctrl ctrlSetPosition [(0.002 * safezoneW), _UIFactor + (0.1 * safezoneH) ,0.0458333 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		lbClear _ctrl;
		{
			_displayname = format ["%1",_x];
			_ctrl lbAdd _displayname;
		} foreach [0,1,2,3,4,5,6,7,8,9,10,999];
		_ctrl lbSetCurSel 0;

		//Reveal GAIA Button
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_gaiaRespawnComboButton_IDC;
		_ctrl ctrlSetPosition [(0.07 * safezoneW), _UIFactor + (0.1 * safezoneH) ,0.095 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		//Reveal Player Button
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_giveToPlayer_IDC;
		_ctrl ctrlSetPosition [(0.002 * safezoneW), _UIFactor + (0.13 * safezoneH) ,0.035 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		//Reveal Cache Button
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_cacheButton_IDC;
		_ctrl ctrlSetPosition [(0.13 * safezoneW), _UIFactor + (0.13 * safezoneH) ,0.035 * safezoneW,0.0219914 * safezoneH];
		_ctrl ctrlCommit 0;

		//Reveal background info
		_ctrl = _mccdialog displayctrl MCC_GroupGenInfo_IDC;
		_ctrl ctrlSetPosition [_posX,_posY,0,0];

		ctrlShow [MCC_GroupGenInfo_IDC,true];
		_ctrl ctrlCommit 0;
		_ctrl ctrlSetPosition [_posX, _posY,0.18 * safezoneW, _UIFactor + (0.16 * safezoneH)];
		_ctrl ctrlCommit 0.1;

	};
