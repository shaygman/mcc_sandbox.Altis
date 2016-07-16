//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params", "_ctrl", "_pressed", "_posX", "_posY", "_shift", "_ctrlKey", "_alt", "_eib_marker","_pointB","_nearObjectsA","_nearObjectsB","_groupSelected"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2;
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

MCC_ConsoleMouseButtonDown = false;	//Mouse state
MCC_ConsoleMouseButtonUp = true;
_groupSelected = missionNamespace getVariable ["MCC_ConsoleGroupSelected",[]];

//Quick WP
if (_pressed == 1  && (count _groupSelected > 0) && abs (_posX - ((missionNamespace getVariable ["MCCConsoleDispPosXYScreen",[0,0]]) select 0))<0.005) then {
	private ["_groups","_pos"];
	_groups = [];
	_pos = _ctrl ctrlmapscreentoworld [_posX,_posY];
	{
		if ((MCC_ConsoleCanCommandAI || (!MCC_ConsoleCanCommandAI && isplayer leader _x))&& (leader _x distance2D _pos > (1000*ctrlMapScale _ctrl))) then {
			_groups pushBack _x;
		};
	} foreach _groupSelected;

	//Call the server to handle WP
	if (count _groups > 0) then {
		player globalRadio "CuratorWaypointPlaced";
		[[if (_ctrlKey) then {0} else {1},_pos,[0,"YELLOW","NO CHANGE","FULL","AWARE","true","",0],_groups,true],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;
	};
};