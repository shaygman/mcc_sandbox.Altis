//==================================================================MCC_fnc_PDAClickGroupIcon==========================================================================
// Define what will happen once a group icon has been pressed in the MCC conosle
// Example:[_group,_button,_pos,_shift,_ctrl,_alt] call MCC_fnc_PDAClickGroupIcon;
// _group	 	= group
// _button 		= integer, 0 - left mouse button, 1 - right mouse button
// _pos 		= _x, _y
//_shift 		= boolean
//_ctrl 		= boolean
//_alt 			= boolean
//=============================================================================================================================================================================
#define MCC_SQLPDA_IDD 2996
#define MCC_MINIMAP 9120
#define MCC_CONSOLEINFOLIVEFEED (uiNamespace getVariable "MCC_CONSOLEINFOLIVEFEED")
#define MCC_CONSOLEINFOTEXT (uiNamespace getVariable "MCC_CONSOLEINFOTEXT")

private ["_mccdialog","_group","_button","_posX","_posY","_shift","_ctrl","_alt","_html","_info","_rank","_icon","_groupControl","_groupSize","_properCfg","_lineCounter"];
disableSerialization;
_mccdialog = findDisplay MCC_SQLPDA_IDD;

_group = _this select 0;
_button = _this select 1;
_posX = (_this select 2) select 0;
_posY = (_this select 2) select 1;
_shift = _this select 3;
_ctrl = _this select 4;
_alt = _this select 5;
_groupControl = if (isplayer (leader _group)) then {true} else {_group getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
_properCfg = 8; 		//if the cfg file is good then take from array number 8  else false - count on sim not vehicleClass take from array 5

player setVariable ["MCC_PDAselectedGroup",_group];

//Right click - get info
if (_button == 1) then
{
	_rank = [leader _group,"displayNameShort"] call BIS_fnc_rankParams;

	_groupSize	= gettext (configfile >> "CfgMarkers" >> ((_group getvariable "MCCgroupIconSize") select 1) >> "name");
	_html = "<t color='#818960' size='1' shadow='1' align='left' underline='true'>" +groupID _group + " - " + toupper _groupSize +"</t><br/>";

	_info = [_group] call MCC_fnc_countGroupHC;
	if (_info select 0 == 0 && _info select 1 == 0 && _info select 2 == 0 && _info select 3 == 0 && _info select 4 == 0 && _info select 5 == 0 && _info select 6 == 0 && _info select 5 == 0) then
	{
		_info = [_group] call MCC_fnc_countGroup;
		_properCfg = 5;
	};

	_html = _html + "<t font='puristaMedium' color='#fefefe' size='0.9' shadow='1' align='left' underline='false'>" + _rank + " " + name leader _group + " - " + behaviour leader _group + " </t><br/>";

	_lineCounter = 0;

	//Infantry
	private "_infCount";
	_infCount = if (_properCfg > 5) then {(_info select 0) + (_info select 5)} else {(_info select 0)};

	if (_infCount > 0) then
	{
		_lineCounter = _lineCounter + 1;
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Infantry: " + str (_info select 0) + " </t>";
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
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Support: " + str (_info select 4) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select 8) select 4);
			_html = _html +	"<br/>";
		};

		//autonomous
		if ((_info select 7) > 0) then
		{
			_lineCounter = _lineCounter + 1;
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Autonomous: " + str (_info select 4) + " </t>";
				{
					_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
				} foreach ((_info select 8) select 5);
			_html = _html +	"<br/>";
		};
	};

	private ["_UIFactor","_ctrl","_displayname"];

	_UIFactor = (0.02 * _lineCounter)* safezoneH;

	//Prase the text :)
	_ctrl = MCC_CONSOLEINFOTEXT;
	_ctrl ctrlSetStructuredText parseText _html;

	while {! ctrlShown _ctrl} do {

		//Reveal background info
		_ctrl ctrlSetPosition [_posX,_posY,0,0];
		_ctrl ctrlShow true;
		_ctrl ctrlCommit 0;
		_ctrl ctrlSetPosition [_posX, _posY,0.15 * safezoneW,_UIFactor + (0.09 * safezoneH)];
		_ctrl ctrlCommit 0.1;
		waituntil {ctrlCommitted _ctrl};

		ctrlsetFocus _ctrl;
	};

	//Reveal Live feed button
	if (!MCC_ConsoleLiveFeedHelmetsOnly || (headgear (leader _group) in MCC_ConsoleLiveFeedHelmets) || (vehicle(leader _group) !=  (leader _group))) then
	{
		_ctrl = MCC_CONSOLEINFOLIVEFEED;
		_ctrl ctrlShow true;
		_ctrl ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (_UIFactor + (0.05 * safezoneH)),0.06 * safezoneW,0.03 * safezoneH];
		_ctrl ctrlCommit 0;
		ctrlsetFocus _ctrl;
	};
};



