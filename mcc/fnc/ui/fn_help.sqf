//==================================================================MCC_fnc_help===============================================================================================
// Display tooltip
//==================================================================================================================================================================================

private ["_control","_open","_multiplier","_pos","_posX","_posY","_posW","_posH","_helpText","_text"];
disableSerialization;

_control	= (_this select 0) select 0;
_open  		= _this select 1;
_multiplier = _this select 2;
_helpText 	= _this select 3;

_pos = ctrlPosition _control;
_posX = _pos select 0;
_posY = _pos select 1;

if (_open) then
{
	_text = "";
	switch (tolower _helpText) do
		{
			case ("console") : 
			{
				_text = _text +"<t size='0.8'>* Right click on a squad icon to inspect it</t><br/><br/>";
				_text = _text +"<t size='0.8'>* While inspecting a squad you can view the live feed from squad leader camera by pressing the 'Live Feed' button</t><br/><br/>";
				_text = _text +"<t size='0.8'>* While inspecting a squad you can take control over a UAV by clicking 'Take Control' button</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Draw a bounding box around group for multi-select or individually select groups by holding Ctrl and clicking on a squad's icon</t><br/><br/>";
				_text = _text +"<t size='0.8'>* You can create group squads together by pressing Ctrl + 1-9 keys, press 1-9 key to quickly select the squads again</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Issue orders by double clicking the map or create a quick waypoint by holding Ctrl + double click the map</t><br/><br/>";
				_text = _text + "<a underline='true' href='http://mccsandbox.wikia.com/wiki/Commander_Console'>Wiki:&#160;Comander&#160;Console</a>"
			}; 
		};
		
	_posW = (_pos select 2)*_multiplier;
	_posH = (_pos select 3)*_multiplier;
	
	_control ctrlSetPosition [_posX,_posY,_posW,_posH];	
	_control ctrlCommit 0;
	waituntil {ctrlCommitted _control};
	_control ctrlRemoveAllEventHandlers "MouseEnter";
	_control ctrlAddeventhandler ["MouseExit",format ["[_this, false,%1,'%2'] spawn MCC_fnc_help",_multiplier,_helpText]];
	_control ctrlSetStructuredText parseText _text;	
}
else
{
	_posW = (_pos select 2)/_multiplier;
	_posH = (_pos select 3)/_multiplier;
	
	_control ctrlSetPosition [_posX,_posY,_posW,_posH];	
	_control ctrlCommit 0;
	waituntil {ctrlCommitted _control};
	_control ctrlRemoveAllEventHandlers "MouseExit";
	_control ctrlAddeventhandler ["MouseEnter",format ["[_this, true,%1,'%2'] spawn MCC_fnc_help",_multiplier,_helpText]];
	_control ctrlSetStructuredText parseText "(?)";	
};

