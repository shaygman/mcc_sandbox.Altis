private ["_disp","_comboBox","_scale","_array"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_SQLPDA", _disp];
uiNamespace setVariable ["MCC_sqlpdaMenu0", _disp displayCtrl 0];
uiNamespace setVariable ["MCC_sqlpdaMenu1", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_sqlpdaMenu2", _disp displayCtrl 2];
uiNamespace setVariable ["MCC_CONSOLEINFOLIVEFEED", _disp displayCtrl 3];
uiNamespace setVariable ["MCC_CONSOLEINFOTEXT", _disp displayCtrl 4];
uiNamespace setVariable ["MCC_sqlpdaCloseLF", _disp displayCtrl 25];

#define MCC_sqlpdaMenu0 (uiNamespace getVariable "MCC_sqlpdaMenu0")
#define MCC_sqlpdaMenu1 (uiNamespace getVariable "MCC_sqlpdaMenu1")
#define MCC_sqlpdaMenu2 (uiNamespace getVariable "MCC_sqlpdaMenu2")
#define MCC_CONSOLEINFOLIVEFEED (uiNamespace getVariable "MCC_CONSOLEINFOLIVEFEED")
#define MCC_CONSOLEINFOTEXT (uiNamespace getVariable "MCC_CONSOLEINFOTEXT")
#define MCC_sqlpdaCloseLF (uiNamespace getVariable "MCC_sqlpdaCloseLF")

(["MCC_SQLPDA_rsc"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

{
	_x ctrlshow false;
} foreach [MCC_sqlpdaMenu0,MCC_sqlpdaMenu1,MCC_sqlpdaMenu2,MCC_CONSOLEINFOLIVEFEED,MCC_CONSOLEINFOTEXT,MCC_sqlpdaCloseLF];

_scale = switch (player getvariable ["MCC_sqlPDAScale",0]) do {
    case 0: {
    	 [
    	 	[0.116146,0.434,0.2,0.5],	//pic
    	 	[0.14,0.526,0.153,0.32],	//bcg
    	 	[0.14,0.526,0.153,0.32],	//map
    	 	[0.2,0.85,0.035,0.043],		//close
    	 	[0.2,0.85,0.035,0.043],		//close LF
    	 	[0.24,0.85,0.035,0.043],	//Scale
    	 	[0.16,0.85,0.035,0.043]		//bckg
    	 ];
    };

    case 1: {
    	 [
    	 	[0.116146,0.434,0.35,0.53],	//pic
    	 	[0.156,0.533,0.27,0.341],	//bcg
    	 	[0.156,0.533,0.27,0.341],	//map
    	 	[0.275,0.885,0.04,0.043],	//close
    	 	[0.275,0.885,0.04,0.043],	//close LF
    	 	[0.34,0.885,0.04,0.043],	//Scale
    	 	[0.21,0.885,0.04,0.043]		//bckg
    	 ];
    };

    case 2: {
    	 [
    	 	[0.15,0.05,0.6,0.9],		//pic
    	 	[0.22,0.23,0.465,0.55],		//bcg
    	 	[0.22,0.23,0.465,0.55],		//map
    	 	[0.4,0.8,0.08,0.06],		//close
    	 	[0.4,0.8,0.08,0.06],		//close LF
    	 	[0.55,0.8,0.08,0.06],		//Scale
    	 	[0.25,0.8,0.08,0.06]		//bckg
    	 ];
    };
};

_ctrl = (_disp displayCtrl 24);

if ((player getvariable ["MCC_sqlPDAScale",0])==2) then {
	_ctrl ctrlsetText (MCC_path + "mcc\dialogs\sqlpda\data\zoomOut.paa");
} else {
	_ctrl ctrlsetText (MCC_path + "mcc\dialogs\sqlpda\data\zoomIn.paa");
};

{
	_array = _scale select _foreachIndex;
	_ctrl = (_disp displayCtrl _x);
	_ctrl ctrlSetPosition [(_array select 0) * safezoneW + safezoneX, (_array select 1) * safezoneH + safezoneY, (_array select 2) * safezoneW , (_array select 3) * safezoneH];
	_ctrl ctrlCommit 0;
} forEach [21,22,9120,23,25,24,26];
sleep 0.5;

(_disp displayCtrl 24) ctrlAddEventHandler ["ButtonClick","player setvariable ['MCC_sqlPDAScale',(((player getvariable ['MCC_sqlPDAScale',0])+1) mod 3)]; 0 spawn {closedialog 0; waituntil {!dialog}; createDialog 'MCC_SQLPDA'}"];

MCC_fnc_SQLPDAMenuClear =
{
	MCC_sqlpdaMenu0 ctrlShow false;
	MCC_sqlpdaMenu1 ctrlShow false;
	MCC_sqlpdaMenu2 ctrlShow false;
};

MCC_fnc_SQLPDAMenuclicked =
{
	private ["_disp","_comboBox","_ctrlIDC","_index","_posX","_posY","_array","_child","_path","_markerName","_text","_respawPositions","_conType","_available",
	         "_errorMessege","_errorMessegeIndex"];

	_ctrl 		= _this select 0;
	_index 		= _this select 1;
	_ctrlData	= _ctrl lbdata _index;
	_ctrlIDC 	= ctrlIDC _ctrl;
	_disp		= ctrlParent _ctrl;
	_posX		= ((ctrlposition _ctrl) select 0)+ ((ctrlposition _ctrl) select 2);
	_posY		= (ctrlposition _ctrl) select 1;

	//saveData
	switch (_ctrlIDC) do
	{
		case 0:	{uinamespace setVariable ["MCC_sqlpdaMenu0Data", _ctrlData]};
		case 1:	{uinamespace setVariable ["MCC_sqlpdaMenu1Data", _ctrlData]};
		case 2:	{uinamespace setVariable ["MCC_sqlpdaMenu2Data", _ctrlData]};
	};

	switch (true) do
	{
		//Menu - enemy - markers
		case (_ctrlData in ["enemy"]):
		{
			//enemy
			_child =  MCC_sqlpdaMenu1;
			_path = if (playerside == east) then {"b_"} else {"o_"};
			_array = [
					   ["inf","Infantry",format["\A3\ui_f\data\map\markers\nato\%1inf.paa",_path]],
					   ["mech_inf","Motorized",format["\A3\ui_f\data\map\markers\nato\%1motor_inf.paa",_path]],
					   ["motor_inf","Mechanized",format["\A3\ui_f\data\map\markers\nato\%1mech_inf.paa",_path]],
					   ["armor","Armor",format["\A3\ui_f\data\map\markers\nato\%1armor.paa",_path]],
					   ["air","Helicopter",format["\A3\ui_f\data\map\markers\nato\%1air.paa",_path]],
					   ["plane","Plane",format["\A3\ui_f\data\map\markers\nato\%1plane.paa",_path]],
					   ["naval","Ship",format["\A3\ui_f\data\map\markers\nato\%1naval.paa",_path]],
					   ["art","Artillery",format["\A3\ui_f\data\map\markers\nato\%1art.paa",_path]],
					   ["installation","Installation",format["\A3\ui_f\data\map\markers\nato\%1Installation.paa",_path]],
					   ["unknown","Unknown",format["\A3\ui_f\data\map\markers\nato\%1unknown.paa",_path]],
					   ["MinefieldAP","Mine","\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa"]
					 ];

		};

		//Menu - enemy - markers - Size
		case (_ctrlData in ["inf","mech_inf","motor_inf","armor","air","plane","naval","art"]):
		{
			_child =  MCC_sqlpdaMenu2;
			_path ="\A3\ui_f\data\map\markers\nato\group";
			_array = [
					   ["Fire Team","Fire Team",format["%1_0.paa",_path]],
					   ["Squad","Squad",format["%1_1.paa",_path]],
					   ["Section","Section",format["%1_2.paa",_path]],
					   ["Platoon","Platoon",format["%1_3.paa",_path]],
					   ["Company","Company",format["%1_4.paa",_path]]
					 ];
		};

		//Menu - enemy - markers - Size (no size)
		case (_ctrlData in ["installation","unknown","MinefieldAP"]):
		{
			_child =  MCC_sqlpdaMenu2;
			_array = [];

			//clear
			[] call MCC_fnc_SQLPDAMenuClear;

			//Create marker
			_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_sqlpdaMenu1Data") + str floor time;
			_text = uinamespace getVariable "MCC_sqlpdaMenu1Data";
			if (_ctrlData == "MinefieldAP") then {_path = "";_text = ""} else {if (playerside == east) then {_path = "b_"} else {_path = "o_"}};

			[[_markerName, _path, MCC_ConsoleWPpos, uinamespace getVariable "MCC_sqlpdaMenu1Data",_text, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		};

		//Menu - enemy - markers - Size set
		case (_ctrlData in ["Fire Team","Squad","Section","Platoon","Company"]):
		{
			_array = [];

			//clear
			[] call MCC_fnc_SQLPDAMenuClear;

			//Create marker
			_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_sqlpdaMenu1Data") + str floor time;
			_path = if (playerside == east) then {"b_"} else {"o_"};
			[[_markerName, _path, MCC_ConsoleWPpos, uinamespace getVariable "MCC_sqlpdaMenu1Data", uinamespace getVariable "MCC_sqlpdaMenu2Data", time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		};

//------------------------------------------------------------------------------------Menu - support----------------------------------------------------------------------------------------------------------------------
		case (_ctrlData in ["support"]):
		{
			MCC_sqlpdaMenu1 ctrlShow false;
			MCC_sqlpdaMenu2 ctrlShow false;

			_child =  MCC_sqlpdaMenu1;
			_path = "\A3\ui_f\data\map\markers\military\";
			_array = [
					   ["mil_destroy","Need CAS",format["%1destroy_CA.paa",_path]],
					   ["mil_pickup","Need Transport",format["%1pickup_CA.paa",_path]],
					   ["mil_objective","Need Area Attack",format["%1objective_CA.paa",_path]],
					   ["mil_marker","Need Support",format["%1marker_CA.paa",_path]],
					   ["mil_warning","Need Medic",format["%1warning_CA.paa",_path]],
					   ["mil_warning","Need Ammo",format["%1warning_CA.paa",_path]],
					   ["mil_warning","Need Repairs",format["%1warning_CA.paa",_path]],
					   ["mil_warning","Need Fuel",format["%1warning_CA.paa",_path]]
					 ];

		};

		//Menu - support selected
		case (_ctrlData in ["mil_destroy","mil_pickup","mil_objective","mil_marker","mil_warning"]):
		{
			_array = [];
			_text = ["Need CAS","Need Transport","Need Area attack","Need Support","Need Medic","Need Ammo","Need Repairs","Need Fuel"] select _index;
			//clear
			[] call MCC_fnc_SQLPDAMenuClear;

			//Create marker
			_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_sqlpdaMenu1Data") + str floor time;
			_path = "";
			[[_markerName, _path, MCC_ConsoleWPpos, uinamespace getVariable "MCC_sqlpdaMenu1Data", _text, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		};

//------------------------------------------------------------------------------------Menu - Construct----------------------------------------------------------------------------------------------------------------------
		case (_ctrlData in ["build"]):
		{
			MCC_sqlpdaMenu1 ctrlShow false;
			MCC_sqlpdaMenu2 ctrlShow false;

			_child =  MCC_sqlpdaMenu1;
			_path = "\A3\ui_f\data\map\markers\military\";
			_array = [
					   ["fob","Forward Outpost","\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa"],
					   ["bunker","Small Bunker","\A3\ui_f\data\map\mapcontrol\Stack_CA.paa"],
					   ["hmg","HMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_MG_CA.paa"],
					   ["gmg","GMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa"],
					   ["at","AT Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa"],
					   ["aa","AA Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AA_CA.paa"],
					   ["mortar","Mortar Pit","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa"]
					 ];

		};

		//Menu - Construct selected
		case (_ctrlData in ["fob","bunker","hmg","gmg","at","aa","mortar"]):
		{
			_child =  MCC_sqlpdaMenu2;
			_path = "";
			_array = [
					   ["0","Facing North",""],
					   ["45","Facing NE",""],
					   ["90","Facing East",""],
					   ["135","Facing SE",""],
					   ["180","Facing South",""],
					   ["225","Facing SW",""],
					   ["270","Facing West",""],
					   ["315","Facing NW",""]
					 ];
		};

		//Menu - Construct selected
		case (_ctrlData in ["0","45","90","135","180","225","270","315"]):
		{
			_array = [];

			//clear
			[] call MCC_fnc_SQLPDAMenuClear;

			_conType = uinamespace getVariable "MCC_sqlpdaMenu1Data";
			[_conType,MCC_ConsoleWPpos] spawn MCC_fnc_initConstract;
		};
	};

	//Reveal
	_child ctrlShow true;
	_child ctrlSetPosition [_posX,_posY,0.12 * safezoneW, ((count _array)-1) * (0.027* safezoneH)];
	_child ctrlCommit 0;

	_child ctrlRemoveAllEventHandlers "LBSelChanged";

	_comboBox = _child;
	lbClear _comboBox;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _comboBox lbAdd _displayname;
		if (!isnil "_pic") then {_comboBox lbSetPicture [_index, _pic]};
		_comboBox lbSetData [_index, _class];
	} foreach _array;
	_comboBox lbSetCurSel 0;

	_child ctrlAddEventHandler ["LBSelChanged","_this call MCC_fnc_SQLPDAMenuclicked"];
};



//------------------------------------------Group Control-------------------------------------------------------------------------------------
//---------------------Console Groups management

if (!isnil "HCEast" ||  !isnil "HCWest" || !isnil "HCGuer") exitWith {}; 			//If HC is working aboart process
onGroupIconClick
{
    if (!dialog) exitWith {};

	_is3D = _this select 0;
    _group = _this select 1;
    _wpID = _this select 2;
    _button = _this select 3;
    _posx = _this select 4;
    _posy = _this select 5;
    _shift = _this select 6;
    _ctrl = _this select 7;
    _alt = _this select 8;

	[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] execVM format ["%1mcc\fnc\console\fn_PDAClickGroupIcon.sqf",MCC_path];
	//[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] spawn MCC_fnc_consoleClickGroupIcon;
};

MCC_fnc_mapDrawWPPDA =
{
	_map = _this select 0;
	{
		_leader = (leader _x);
		_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
		_haveGPS =  if (vehicle _leader != _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
		if (isnil "_haveGPS") then {_haveGPS = false};
		if ((side _leader == side player) && alive _leader && _groupControl && ((MCC_ConsoleOnlyShowUnitsWithGPS && _haveGPS) || !MCC_ConsoleOnlyShowUnitsWithGPS)) then
		{
			_wpArray = waypoints (group _leader);
			if (count _wpArray > 0)then
			{
				private ["_wp","_wPos","_wType"];
				MCC_lastPos = nil;
				_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");
				for [{_i= currentWaypoint (group _leader)},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
				{
					_wp = (_wpArray select _i);
					_wPos  = waypointPosition _wp;
					if ((_wPos  distance [0,0,0]) > 50) then
					{
						_wType = waypointType _wp;


						_map drawIcon [
							_texture,
							[0,0,1,1],
							_wPos,
							24,
							24,
							0,
							_wType,
							0,
							0.04,
							"PuristaBold",
							"center"
						];

						if (isnil "MCC_lastPos") then {MCC_lastPos = [(getpos _leader) select 0,(getpos _leader) select 1]};

						_map drawLine [
							MCC_lastPos,
							_wPos,
							[0,0,1,1]
						];

						MCC_lastPos = _wPos;
					};
				};
			};
		};
	} foreach allgroups;
};

_disp call
{
	private ["_handler","_markerSupport","_markerAutonomous","_markerColor","_markerNaval","_markerRecon","_haveGPS","_leader","_groupStatus","_wpArray","_behaviour","_groupControl","_haveGPS","_groupName","_markerType","_markerInf","_markerMech","_markerArmor","_markerAir"];

	_handler = (_disp displayCtrl 9120) ctrladdeventhandler ["draw","_this call MCC_fnc_mapDrawWPPDA;"];

	setGroupIconsVisible [true,false];
	setGroupIconsSelectable true;


	while {(str (_disp displayCtrl 9120))!= "No control"} do 		//Draw WP
	{
		{
			_leader = (leader _x);
			_groupStatus = _x getvariable "MCC_support";
			_wpArray = waypoints (group _leader);
			_behaviour = behaviour _leader;
			_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
			_haveGPS =  if (vehicle _leader != _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
			if (isnil "_haveGPS") then {_haveGPS = false};
			if ((side _leader == side player) && alive _leader && _groupControl && ((MCC_ConsoleOnlyShowUnitsWithGPS && _haveGPS) || !MCC_ConsoleOnlyShowUnitsWithGPS)) then
				{
					switch (side _leader) do
					{
						case east: //East
							{
							_side			= east;
							_markerColor 	= [1,0,0,0.7];
							_markerInf		= "o_inf";
							_markerRecon	= "o_recon";
							_markerSupport	= "o_support";
							_markerAutonomous = "o_uav";
							_markerMech		= "o_mech_inf";
							_markerArmor	= "o_armor";
							_markerAir		= "o_air";
							_markerNaval	= "o_naval";
							};

						case west: //West
							{
							_side			= west;
							_markerColor 	= [0,0,1,1];
							_markerInf		= "b_inf";
							_markerRecon	= "b_recon";
							_markerSupport	= "b_support";
							_markerAutonomous = "b_uav";
							_markerMech		= "b_mech_inf";
							_markerArmor	= "b_armor";
							_markerAir		= "b_air";
							_markerNaval	= "b_naval";
							};

						case resistance: //Resistance
							{
							_side			= resistance;
							_markerColor 	= [0,1,0,0.7];
							_markerInf		= "n_inf";
							_markerRecon	= "n_recon";
							_markerSupport	= "n_support";
							_markerAutonomous = "n_uav";
							_markerMech		= "n_mech_inf";
							_markerArmor	= "n_armor";
							_markerAir		= "n_air";
							_markerNaval	= "n_naval";
							};
						case civilian: //Resistance
							{
							_side			= civilian;
							_markerColor 	= [1,1,1,0.7];
							_markerInf		= "n_inf";
							_markerRecon	= "n_recon";
							_markerSupport	= "n_support";
							_markerAutonomous = "n_uav";
							_markerMech		= "n_mech_inf";
							_markerArmor	= "n_armor";
							_markerAir		= "n_air";
							_markerNaval	= "n_naval";
							};
					};

					_groupName = _x getVariable ["name",""];

					_groupName = if (_groupName == "") then	{groupID _x} else {_groupName};

					_x setGroupIconParams [_markerColor,_groupName ,1,true];

					_unitsCount = [group _leader] call MCC_fnc_countGroupHC;
					_unitsSize = 0;
					_markerType = nil;
					if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
					if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
					if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
					if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
					if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
					if (_unitsCount select 5 > 0) then {_markerType = _markerRecon; _unitsSize = _unitsSize + (1*(_unitsCount select 5))};
					if (_unitsCount select 6 > 0) then {_markerType = _markerSupport; _unitsSize = _unitsSize + (3*(_unitsCount select 6))};
					if (_unitsCount select 7 > 0) then {_markerType = _markerAutonomous; _unitsSize = _unitsSize + (1*(_unitsCount select 7))};

					if (isnil "_markerType") then
					{
						_unitsCount = [group _leader] call MCC_fnc_countGroup;
						if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
						if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
						if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
						if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
						if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
					};

					//How big is the squad
					_unitsSize = floor (_unitsSize/4);
					if (_unitsSize > 10) then {_unitsSize = 10};
					_unitsSizeMarker = format ["group_%1",_unitsSize];

					//Set markers
					_icon = (_x getvariable "MCCgroupIconData");
					if (!isnil "_icon") then {_x removeGroupIcon _icon};
					_icon = _x addGroupIcon [_markerType,[0,0]];
					_x setGroupIconParams [_markerColor,format ["%1",_groupName],1,true];
					_x setvariable ["MCCgroupIconData",_icon,false];

					_icon = (_x getvariable "MCCgroupIconSize") select 0;
					if (!isnil "_icon") then {_x removeGroupIcon _icon};
					_icon = _x addGroupIcon [_unitsSizeMarker,[0,0]];
					_x setvariable ["MCCgroupIconSize",[_icon,_unitsSizeMarker],false];

					if (! isnil "_groupStatus") then 					//Draw group status
						{
							private ["_time","_status"];
							_time 		= _groupStatus select 1;
							_status 	= _groupStatus select 0;

							if (abs (time - _time) < 180) then
								{
									_x setGroupIconParams [_markerColor,format ["%1%2",_groupName,_status],1,true];
								}
								else
								{
									_x setGroupIconParams [_markerColor,_groupName,1,true];
								};
						};

					if (_behaviour == "COMBAT") then				//Show in combat
						{
							_x setGroupIconParams [[1,1,1,1],_groupName,1,true];
						};
				};
		} foreach allgroups;
		sleep 0.5;
	};

	//Clear stuff after exiting
	{
		_leader = (leader _x);
		if ((side _leader == side player) && alive _leader) then
			{
				clearGroupIcons _x;
			};
	} foreach allgroups;

	setGroupIconsVisible [false,false];
	setGroupIconsSelectable false;

	//Remove EH
	(_disp displayCtrl 9120) ctrlRemoveEventHandler ["draw",_handler];
};