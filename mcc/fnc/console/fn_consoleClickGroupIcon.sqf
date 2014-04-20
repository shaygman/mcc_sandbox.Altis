//==================================================================MCC_fnc_consoleClickGroupIcon===============================================================================================
// Define what will happen once a group icon has been pressed in the MCC conosle
// Example:[_group,_button,_pos,_shift,_ctrl,_alt] call MCC_fnc_consoleClickGroupIcon;
// _group	 = group
// _button = integer, 0 - left mouse button, 1 - right mouse button
// _pos = _x, _y
//_shift = boolean
//_ctrl = boolean
//_alt = boolean
//==================================================================================================================================================================================
#define mcc_playerConsole_IDD 2993
#define mcc_playerConsole2_IDD 5000
#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_CONSOLEINFOUAVCONTROL 9162
private ["_mccdialog","_group","_button","_posX","_posY","_shift","_ctrl","_alt","_html","_info","_rank","_icon","_groupControl","_groupSize","_properCfg"];
disableSerialization;

if (MCC_Console1Open) then {_mccdialog = findDisplay mcc_playerConsole_IDD};
if (MCC_Console2Open) then {_mccdialog = findDisplay mcc_playerConsole2_IDD};
if (MCC_Console3Open) then {_mccdialog = findDisplay mcc_playerConsole3_IDD};

_group = _this select 0;
_button = _this select 1;
_posX = (_this select 2) select 0;
_posY = (_this select 2) select 1;
_shift = _this select 3;
_ctrl = _this select 4;
_alt = _this select 5;
_groupControl = if ((isplayer (leader _group)) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle (leader _group) >> "vehicleClass")== "Autonomous")) then {true} else {_group getvariable "MCC_canbecontrolled"};	//Can we control this group
_properCfg = 8; 		//if the cfg file is good then take from array number 8  else false - count on sim not vehicleClass take from array 5

if (isnil "MCC_ConsoleGroupSelected") then {MCC_ConsoleGroupSelected = []}; 

if ((_button == 0) && (_ctrl) && (!isnil "_groupControl")) then 								//multi-select
	{
		MCC_ConsoleGroupSelected set [count MCC_ConsoleGroupSelected, _group];
		_icon = _group addGroupIcon ["selector_selectedFriendly",[0,0]];
		_group setvariable ["MCCgroupIconDataSelected",_icon,false]; 
	};

if (((!isnil "_groupControl") && (_button == 0) && (!_ctrl)) || (_button == 1 )) then 								//Not multi-select
	{
		MCC_ConsoleGroupFocused = _group;
		if (isnil "_groupControl") exitWith {};
		{_x removeGroupIcon (_x getvariable "MCCgroupIconDataSelected")} foreach MCC_ConsoleGroupSelected;
		MCC_ConsoleGroupSelected = []; 
		MCC_ConsoleGroupSelected set [count MCC_ConsoleGroupSelected, _group];
		_icon = _group addGroupIcon ["selector_selectedFriendly",[0,0]];
		_group setvariable ["MCCgroupIconDataSelected",_icon,false]; 
	};
	
if (_button == 0) then 												//Left Click
	{
		
	};

if (_button == 1) then 											//Right click - get info
	{
		//Reveal background info
		(_mccdialog displayctrl MCC_CONSOLEINFOTEXT) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_CONSOLEINFOTEXT,true];
		(_mccdialog displayctrl MCC_CONSOLEINFOTEXT) ctrlCommit 0;
		(_mccdialog displayctrl MCC_CONSOLEINFOTEXT) ctrlSetPosition [_posX, _posY,0.15 * safezoneW,0.205 * safezoneH];
		(_mccdialog displayctrl MCC_CONSOLEINFOTEXT) ctrlCommit 0.1;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEINFOTEXT)};
		
		//Reveal Live feed button
		if (!MCC_ConsoleLiveFeedHelmetsOnly || (headgear (leader _group) in MCC_ConsoleLiveFeedHelmets) || (vehicle(leader _group) !=  (leader _group))) then
			{
				(_mccdialog displayctrl MCC_CONSOLEINFOLIVEFEED) ctrlSetPosition [_posX, _posY + (0.17 * safezoneH),0,0];	
				ctrlShow [MCC_CONSOLEINFOLIVEFEED,true];
				(_mccdialog displayctrl MCC_CONSOLEINFOLIVEFEED) ctrlCommit 0;
				(_mccdialog displayctrl MCC_CONSOLEINFOLIVEFEED) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.17 * safezoneH),0.06 * safezoneW,0.03 * safezoneH];
				(_mccdialog displayctrl MCC_CONSOLEINFOLIVEFEED) ctrlCommit 0.1;
			};
			
		//Reveal UAV Control
		if ((vehicle leader _group) in allUnitsUav) then
			{
				MCC_ConolseUAV = (vehicle leader _group); 
				(_mccdialog displayctrl MCC_CONSOLEINFOUAVCONTROL) ctrlSetPosition [_posX , _posY + (0.17 * safezoneH),0,0];	
				ctrlShow [MCC_CONSOLEINFOUAVCONTROL,true];
				(_mccdialog displayctrl MCC_CONSOLEINFOUAVCONTROL) ctrlCommit 0;
				(_mccdialog displayctrl MCC_CONSOLEINFOUAVCONTROL) ctrlSetPosition [_posX + (0.07 * safezoneW), _posY + (0.17 * safezoneH),0.07 * safezoneW,0.03 * safezoneH];
				(_mccdialog displayctrl MCC_CONSOLEINFOUAVCONTROL) ctrlCommit 0.1;
			};

		
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
			} foreach ((_info select _properCfg) select 0); 
		_html = _html +	"<br/>";
		
		//Armor
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Armored: " + str (_info select 2) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select _properCfg) select 1); 
		_html = _html +	"<br/>";
		
		//Air
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Air: " + str (_info select 3) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select _properCfg) select 2); 
		_html = _html +	"<br/>";
		
		//Naval
		_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Naval: " + str (_info select 4) + " </t>";
			{
				_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
			} foreach ((_info select _properCfg) select 3); 
		_html = _html +	"<br/>";
		
		if (_properCfg > 5) then
		{
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
		};
		
		(_mccdialog displayctrl MCC_CONSOLEINFOTEXT) ctrlSetStructuredText parseText _html;
	};
		
//hint format ["_group: %1; _button = %2; _pos: %3, _shift: %4; _ctrl: %5; _alt: %6;",_group,_button,[_posX,_posY],_shift,_ctrl,_alt]; 

