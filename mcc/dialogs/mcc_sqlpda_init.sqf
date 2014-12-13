private ["_disp","_comboBox"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_SQLPDA", _disp];
uiNamespace setVariable ["MCC_sqlpdaMenu0", _disp displayCtrl 0];
uiNamespace setVariable ["MCC_sqlpdaMenu1", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_sqlpdaMenu2", _disp displayCtrl 2];

#define MCC_sqlpdaMenu0 (uiNamespace getVariable "MCC_sqlpdaMenu0")
#define MCC_sqlpdaMenu1 (uiNamespace getVariable "MCC_sqlpdaMenu1")
#define MCC_sqlpdaMenu2 (uiNamespace getVariable "MCC_sqlpdaMenu2")

#define REQUIRE_SQL_CONSTRUCT_DISTANCE 200
#define REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE 300
#define REQUIRE_FOB_FOB_MIN_DISTANCE 1000
#define REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE 500
#define ANCHOR_ITEM "Land_Rampart_F"
{
	_x ctrlshow false;
} foreach [MCC_sqlpdaMenu0,MCC_sqlpdaMenu1,MCC_sqlpdaMenu2];

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

			_available = true;
			_errorMessegeIndex = 0;
			_errorMessege = [
								format ["Can't order to build deployables further then %1m from the player",REQUIRE_SQL_CONSTRUCT_DISTANCE],
								"Can't build on water",
								format ["FOB must be build in a minimum distance of %1m from another FOB or HQ",REQUIRE_FOB_FOB_MIN_DISTANCE],
								format ["Deployables can be build in a maximum distance of %1m from an FOB",REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE],
								format ["Only one construction can be built at the same time in %1 meters radius",REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]
		                    ];

			//Check if no more then one construct from the same type is beeing build in the area and
			_check = ({alive _x} count (MCC_ConsoleWPpos nearObjects [ANCHOR_ITEM, REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]));
			if (_check != 0) then {_available = false; _errorMessegeIndex = 4};

			//Check Near FOB
			_respawPositions = [player] call BIS_fnc_getRespawnPositions;
			if (_conType == "fob") then
			{
				_check = {MCC_ConsoleWPpos distance _x < REQUIRE_FOB_FOB_MIN_DISTANCE} count _respawPositions;
				_check = _check + ({((_x getVariable ["MCC_conType",""])=="fob") && (playerside == _x getVariable ["MCC_side",sidelogic])} count (MCC_ConsoleWPpos nearObjects [ANCHOR_ITEM, REQUIRE_FOB_FOB_MIN_DISTANCE]));
				if (_check > 0) then {_available = false; _errorMessegeIndex = 2};
			}
			else
			{
				_check = {MCC_ConsoleWPpos distance _x < REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE} count _respawPositions;
				if (_check == 0) then {_available = false; _errorMessegeIndex = 3};
			};

			//Check if not on water
			if (surfaceIsWater MCC_ConsoleWPpos) then {_available = false; _errorMessegeIndex = 1};

			//Check if not too far
			if (MCC_ConsoleWPpos distance player > REQUIRE_SQL_CONSTRUCT_DISTANCE) then {_available = false; _errorMessegeIndex = 0};


			//Create structure
			if (_available) then
			{
				_path = "";
				[[_conType, MCC_ConsoleWPpos, playerside, uinamespace getVariable "MCC_sqlpdaMenu2Data"] ,"MCC_fnc_construction", false,false] call BIS_fnc_MP;
			}
			else
			{
				systemchat (_errorMessege select _errorMessegeIndex);
			}
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
