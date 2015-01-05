//=========================================================MCC_fnc_interactSelfClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrl","_index","_ctrlData","_suspect","_ctrlIDC","_disp","_posX","_posY","_child","_array","_pos","_path"];
disableSerialization;

_ctrl 		= _this select 0;
_index 		= _this select 1;
_ctrlData	= _ctrl lbdata _index;
_ctrlIDC 	= ctrlIDC _ctrl;
_disp		= ctrlParent _ctrl;
_posX		= ((ctrlposition _ctrl) select 0)+ ((ctrlposition _ctrl) select 2);
_posY		= (ctrlposition _ctrl) select 1;
_suspect = (player getVariable ["interactWith",[]]) select 0;

uiNamespace setVariable ["MCC_interactionMenu0", _disp displayCtrl 0];
uiNamespace setVariable ["MCC_interactionMenu1", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_interactionMenu2", _disp displayCtrl 2];

#define MCC_interactionMenu0 (uiNamespace getVariable "MCC_interactionMenu0")
#define MCC_interactionMenu1 (uiNamespace getVariable "MCC_interactionMenu1")
#define MCC_interactionMenu2 (uiNamespace getVariable "MCC_interactionMenu2")

#define REQUIRE_SQL_CONSTRUCT_DISTANCE 200
#define REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE 300
#define REQUIRE_FOB_FOB_MIN_DISTANCE 1000
#define REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE 500
#define ANCHOR_ITEM "Land_Rampart_F"

//saveData
switch (_ctrlIDC) do
{
	case 0:	{uinamespace setVariable ["MCC_interactionMenu0Data", _ctrlData]};
	case 1:	{uinamespace setVariable ["MCC_interactionMenu1Data", _ctrlData]};
	case 2:	{uinamespace setVariable ["MCC_interactionMenu2Data", _ctrlData]};
};

//Close dialog
if !(_ctrlData in ["physical","medic","enemy","inf","mech_inf","motor_inf","armor","air","plane","naval","art","support","build","pulse"]) then {closeDialog 0};
_pos = screenToWorld [0.5,0.5];

switch (true) do
{
	case (_ctrlData == "medic"):
	{
		private ["_bandage","_medkit","_maxBleeding","_complex","_isMedic","_itemsPlayer","_itemsSuspect","_bandagePic","_medkitPic"];
		_child =  MCC_interactionMenu1;
		_complex = missionNamespace getVariable ["MCC_medicComplex",false];
		if (_complex) then
		{
			_bandage = "MCC_bandage";
			_bandagePic = getText (configFile >> "CfgMagazines" >> _bandage >> "picture");

			_medkit = "MCC_firstAidKit";
			_medkitPic = getText (configFile >> "CfgMagazines" >> _medkit >> "picture");
		}
		else
		{
			_bandage = "FirstAidKit";
			_bandagePic = getText (configFile >> "CfgWeapons" >> _bandage >> "picture");

			_medkit = "Medikit";
			_medkitPic = getText (configFile >> "CfgWeapons" >> _medkit >> "picture");
		};

		_itemsPlayer = magazines player;

		_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
		_isMedic = if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {true} else {false};

		_array = [
				   ["pulse","Pulse Check",format ["%1data\IconPulse.paa",MCC_path],[0,1,0,1]],
				   ["physical","Physical Check",format ["%1data\IconPhysical.paa",MCC_path],[0,1,0,1]],
				   ["bandage",format ["Bandage X %1", {_x == _bandage} count (_itemsPlayer)],_bandagePic],
				   ["heal","First Aid",_medkitPic]
				 ];

		if ( !alive _suspect) then {_array set [1,-1]};
		if (!(_bandage in (_itemsPlayer)) || !alive _suspect) then {_array set [2,-1]};
		if (!(_medkit in _itemsPlayer) || !_isMedic || !alive _suspect || (_suspect getVariable ["MCC_medicUnconscious",false]) || ((_suspect getVariable ["MCC_medicBleeding",0])> 0.2)) then {_array set [3,-1]};
		_array = _array - [-1];
	};

	case (_ctrlData in ["bandage","heal"]):
	{
		[_ctrlData, _suspect] call MCC_fnc_medicUseItem;
	};

	case (_ctrlData == "pulse"):
	{
		private ["_string","_maxBleeding","_remaineBlood","_subArray","_fatigueEffect"];
		_child =  MCC_interactionMenu2;
		_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
		_remaineBlood = _suspect getvariable ["MCC_medicRemainBlood",_maxBleeding];
		_fatigueEffect = floor (30*(getFatigue _suspect));

		MCC_interactionMenu2 ctrlShow false;

		//Blood loss
		switch (true) do
					{
						case (!alive _suspect) : {_string = "No pulse, he is Dead";  _subArray = [1,1,1,1];};
						case (_remaineBlood == _maxBleeding) : {_string = format ["%1 - No blood loss",(floor (random 5))+80+_fatigueEffect]; _subArray = [1,1,1,1];};
						case (_remaineBlood/_maxBleeding < 0.4) : {_string = format ["%1 - Severe blood Loss",(floor (random 5))+160+_fatigueEffect]; _subArray = [1,0,0,1];};
						case (_remaineBlood/_maxBleeding < 0.7) : {_string = format ["%1 - Mild blood loss",(floor (random 5))+120+_fatigueEffect]; _subArray = [1,1,0,1];};
						case (_remaineBlood/_maxBleeding >= 0.7) : {_string = format ["%1 - Minor blood loss",(floor (random 5))+95+_fatigueEffect]; _subArray = [0,1,0,1];};
					};
		_array = [
				   ["pulseReport",_string,"",_subArray]
				 ];
	};

	case (_ctrlData == "physical"):
	{
		private ["_string","_damage","_hitPoints","_subArray","_partName","_bleeding"];
		_child =  MCC_interactionMenu2;
		_hitPoints = ["HitHead","HitBody","hitLegs","hitHands"];
		_partName = ["Head: ","Body: ","Legs: ","Hands: "];
		_array = [];
		_bleeding = _suspect getVariable ["MCC_medicBleeding",0];

		MCC_interactionMenu2 ctrlShow false;

		//Trauma
		{
			_subArray = [];
			_damage = _suspect getHitPointDamage _x;
			switch (true) do
					{
						case (_damage < 0.05) : {_string = "No trauma"; _subArray set [3,[1,1,1,1]];};
						case (_damage < 0.3) : {_string = "Minor trauma"; _subArray set [3,[0,1,0,1]];};
						case (_damage < 0.6) : {_string = "Mild trauma"; _subArray set [3,[1,1,0,1]];};
						case (_damage >= 0.6) : {_string = "Severe trauma"; _subArray set [3,[1,0,0,1]];};
					};
			_subArray set [0,"physicalReport"];
			_subArray set [1,(_partName select _foreachIndex) + _string]; lbSetColor
			_subArray set [2,""];
			_array pushBack _subArray;
		} foreach _hitPoints;


		//Bleeding
		_subArray = [];
		_subArray set [0,"physicalReport"];

		switch (true) do
						{
							case (_bleeding == 0) : {_string =  "Not Bleeding"; _subArray set [3,[1,1,1,1]];};
							case (_bleeding < 0.2) : {_string =  "Minor Bleeding"; _subArray set [3,[0,1,0,1]];};
							case (_bleeding < 0.6) : {_string =  "Mild Bleeding"; _subArray set [3,[1,1,0,1]];};
							case (_bleeding >= 0.6) : {_string =  "Severe Bleeding"; _subArray set [3,[1,0,0,1]];};
						};

		_subArray set [1,"Bleeding: " + _string];
		_subArray set [2,""];
		_array pushBack _subArray;
	};

	case (_ctrlData in ["drag","carry"] ):
	{

		[player,_suspect, _ctrlData == "carry"] call MCC_fnc_medicDragCarry;
	};

	case (_ctrlData == "enemy"):
	{
		//enemy
		_child =  MCC_interactionMenu1;
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
		_child =  MCC_interactionMenu2;
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
		_child =  MCC_interactionMenu2;
		_array = [];

		//Create marker
		_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_interactionMenu1Data") + str floor time;
		_text = uinamespace getVariable "MCC_interactionMenu1Data";
		if (_ctrlData == "MinefieldAP") then
		{
			_path = "";
			_text = "";
		}
		else
		{
			if (playerside == east) then {_path = "b_"} else {_path = "o_"};
		};

		if (_pos distance player < 1500) then
		{
			player globalRadio "SentEnemyDetectedClose";
			[[_markerName, _path, _pos, uinamespace getVariable "MCC_interactionMenu1Data",_text, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		}
		else
		{
			player globalRadio "SentNoTarget";
		};
	};

	//Menu - enemy - markers - Size set
	case (_ctrlData in ["Fire Team","Squad","Section","Platoon","Company"]):
	{
		_array = [];

		if (_pos distance player < 1500) then
		{
			//Create marker
			_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_interactionMenu1Data") + str floor time;
			_path = if (playerside == east) then {"b_"} else {"o_"};

			player globalRadio "CuratorWaypointPlacedAttack";
			[[_markerName, _path, _pos, uinamespace getVariable "MCC_interactionMenu1Data", uinamespace getVariable "MCC_interactionMenu2Data", time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		}
		else
		{
			player globalRadio "SentNoTarget";
		};
	};

	case (_ctrlData == "support"):
	{
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_child =  MCC_interactionMenu1;
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

		if (_ctrlData in ["mil_warning","mil_pickup"]) then {_pos = getpos player};

		if (_pos distance player < 3000) then
		{
			//Create marker
			_markerName = (getplayerUID player) + (uinamespace getVariable "MCC_interactionMenu1Data") + str floor time;
			_path = "";

			private ["_radioSelf","_radioGlobal","_type"];

			switch (_text) do {
			    case "Need CAS": {
			    	_radioSelf = "SentSupportRequestRGCASBombing";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_casrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_casrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Transport": {
			    	_radioSelf = "SentSupportRequestRGTransport";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_transportrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_transportrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Area attack": {
			    	_radioSelf = "SentSupportRequestRGArty";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_casrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_casrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Medic": {
			    	_radioSelf = "SentSupportAskHeal";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Ammo": {
			    	_radioSelf = "SentSupportAskRearm";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Repairs": {
			    	_radioSelf = "SentSupportAskRepair";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
			    };

			    case "Need Fuel": {
			    	_radioSelf = "SentSupportAskRefuel";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
			    };

			    default {
			     	_radioSelf = "SentSupportRequestRGSupplyDrop";
			    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
			    };
			};

			player globalRadio _radioSelf;

			//broadcast
			[[player,_radioGlobal] ,"MCC_fnc_radioSupport", playerside,false] call BIS_fnc_MP;

			[[_markerName, _path, _pos, uinamespace getVariable "MCC_interactionMenu1Data", _text, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
		}
		else
		{
			player globalRadio "SentCommandFailed";
		};
	};

	case (_ctrlData == "build"):
	{
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_child =  MCC_interactionMenu1;
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

	case (_ctrlData in ["fob","bunker","hmg","gmg","at","aa","mortar"]):
	{
		private ["_conType","_available","_errorMessegeIndex","_errorMessege","_check","_respawPositions"];
		_conType = uinamespace getVariable "MCC_interactionMenu1Data";

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
		_check = ({alive _x} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]));
		if (_check != 0) then {_available = false; _errorMessegeIndex = 4};

		//Check Near FOB
		_respawPositions = [player] call BIS_fnc_getRespawnPositions;
		if (_conType == "fob") then
		{
			_check = {_pos distance _x < REQUIRE_FOB_FOB_MIN_DISTANCE} count _respawPositions;
			_check = _check + ({((_x getVariable ["MCC_conType",""])=="fob") && (playerside == _x getVariable ["MCC_side",sidelogic])} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_FOB_FOB_MIN_DISTANCE]));
			if (_check > 0) then {_available = false; _errorMessegeIndex = 2};
		}
		else
		{
			_check = {_pos distance _x < REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE} count _respawPositions;
			if (_check == 0) then {_available = false; _errorMessegeIndex = 3};
		};

		//Check if not on water
		if (surfaceIsWater _pos) then {_available = false; _errorMessegeIndex = 1};

		//Check if not too far
		if (_pos distance player > REQUIRE_SQL_CONSTRUCT_DISTANCE) then {_available = false; _errorMessegeIndex = 0};


		//Create structure
		if (_available) then
		{
			_path = "";
			[[_conType, _pos, playerside, str (getdir player)] ,"MCC_fnc_construction", false,false] call BIS_fnc_MP;

			//broadcast
			player globalRadio "SentAssemble";
			[[player,(if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]})] ,"MCC_fnc_radioSupport", playerside,false] call BIS_fnc_MP;
		}
		else
		{
			systemchat (_errorMessege select _errorMessegeIndex);
			player globalRadio "SentCommandFailed";
		}
	};
};

//Reveal
if (!isnil "_child") then
{
	_child ctrlShow true;
	_child ctrlSetPosition [_posX,_posY,0.12 * safezoneW, ((count _array)) * (0.025* safezoneH)];
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
		if (count _x > 3) then {_comboBox lbSetColor [_index, _x select 3]};
	} foreach _array;

	_child ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_interactSelfClicked"];
};
