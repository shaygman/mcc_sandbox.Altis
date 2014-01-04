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

private ["_mccdialog","_group","_button","_posX","_posY","_shift","_ctrl","_alt","_html","_info","_rank","_icon","_groupSize"];
disableSerialization;

_mccdialog = findDisplay groupGen_IDD;

_group = _this select 0;
_button = _this select 1;
_posX = (_this select 2) select 0;
_posY = (_this select 2) select 1;
_shift = _this select 3;
_ctrl = _this select 4;
_alt = _this select 5;

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
		//Reveal background info
		(_mccdialog displayctrl MCC_GroupGenInfoText_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenInfoText_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenInfoText_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenInfoText_IDC) ctrlSetPosition [_posX, _posY,0.15 * safezoneW,0.205 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenInfoText_IDC) ctrlCommit 0.1;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenInfoText_IDC)};
		
		_rank =[leader _group,"displayNameShort"] call BIS_fnc_rankParams;
					
		_groupSize	= gettext (configfile >> "CfgMarkers" >> ((_group getvariable "MCCgroupIconSize") select 1) >> "name"); 		
		_html = "<t color='#818960' size='1' shadow='1' align='left' underline='true'>" +groupID _group + " - " + toupper _groupSize +"</t><br/>";
		_info = [_group] call MCC_fnc_countGroupHC;
		
		_html = _html + "<t font='puristaMedium' color='#fefefe' size='0.9' shadow='1' align='left' underline='false'>" + _rank + " " + name leader _group + " - " + behaviour leader _group + " </t><br/>";
		
		//Infantry
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Infantry: " + str (_info select 0) + " </t>";
		for [{_x = 0},{_x < (_info select 0)},{_x = _x+1}] do	
			{
				_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>|</t>";
			};
		_html = _html +	"<br/>";
		
		//Vehicles
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Motorized: " + str (_info select 1) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 0); 
		_html = _html +	"<br/>";
		
		//Armor
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Armored: " + str (_info select 2) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 1); 
		_html = _html +	"<br/>";
		
		//Air
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Air: " + str (_info select 3) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 2); 
		_html = _html +	"<br/>";
		
		//Naval
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Naval: " + str (_info select 4) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 3); 
		_html = _html +	"<br/>";
		
		//Support
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Support: " + str (_info select 4) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 4); 
		_html = _html +	"<br/>";
		
		//autonomous
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Autonomous: " + str (_info select 4) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select 8) select 5); 
		_html = _html +	"<br/>";

		
		(_mccdialog displayctrl MCC_GroupGenInfoText_IDC) ctrlSetStructuredText parseText _html;
	};
