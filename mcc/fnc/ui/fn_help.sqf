//==================================================================MCC_fnc_help===============================================================================================
// Display tooltip
//==================================================================================================================================================================================

private ["_control","_open","_multiplierW","_multiplierH","_pos","_posX","_posY","_posW","_posH","_helpText","_text"];
disableSerialization;

_control	= (_this select 0) select 0;
_open  		= _this select 1;
_multiplierW = (_this select 2) select 0;
_multiplierH = (_this select 2) select 1;
_helpText 	= _this select 3;

_pos = ctrlPosition _control;
_posX = _pos select 0;
_posY = _pos select 1;

if (_open) then
{
	_text = "";
	switch (_helpText) do
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
			case ("squadDialog") :
			{
				_text = _text + "<a underline='true' href='http://mccsandbox.wikia.com/wiki/Squad_Dialog'>Wiki:&#160;Squad&#160;Dialog</a>"
			};

			case ("mccmain") :
			{
				_text = _text +"<t size='0.8'>* Right click on a squad icon to inspect it</t><br/><br/>";
				_text = _text +"<t size='0.8'>* While inspecting a squad you can assign it behaviour or number of respawns</t><br/><br/>";
				_text = _text +"<t size='0.8'>* While inspecting a squad you can cache the grouo or give to the player control (Commander Console)</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Draw a bounding box around group for multi-select or individually select groups by holding Ctrl and clicking on a squad's icon</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Issue orders by double clicking the map or create a quick waypoint by holding Ctrl + double click the map</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Delete selected groups by pressing the Delete key</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Use the group managment sectio bellow to control units inside the group</t><br/><br/>";
				_text = _text +"<t size='0.8'>* Press Alt + left mouse button to open the 3D editor</t><br/><br/>";
				_text = _text + "<a underline='true' href='http://mccsandbox.wikia.com/wiki/Zones'>Wiki:&#160;MCC</a>"
			};
		};

	_posW = (_pos select 2)*_multiplierW;
	_posH = (_pos select 3)*_multiplierH;

	_control ctrlSetPosition [_posX,_posY,_posW,_posH];
	_control ctrlCommit 0;
	waituntil {ctrlCommitted _control};
	_control ctrlRemoveAllEventHandlers "MouseEnter";
	_control ctrlAddeventhandler ["MouseExit",format ["[_this, false,%1,'%2'] spawn MCC_fnc_help",[_multiplierW,_multiplierH],_helpText]];
	_control ctrlSetStructuredText parseText _text;
}
else
{
	_posW = (_pos select 2)/_multiplierW;
	_posH = (_pos select 3)/_multiplierH;

	_control ctrlSetPosition [_posX,_posY,_posW,_posH];
	_control ctrlCommit 0;
	waituntil {ctrlCommitted _control};
	_control ctrlRemoveAllEventHandlers "MouseExit";
	_control ctrlAddeventhandler ["MouseEnter",format ["[_this, true,%1,'%2'] spawn MCC_fnc_help",[_multiplierW,_multiplierH],_helpText]];
	_control ctrlSetStructuredText parseText "(?)";
};

