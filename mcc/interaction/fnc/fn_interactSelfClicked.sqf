//=========================================================MCC_fnc_interactSelfClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrl","_ctrlData","_suspect","_ctrlIDC","_disp","_posX","_posY","_child","_array","_pos","_path","_layer"];
disableSerialization;

_ctrl 		= _this select 0;
_ctrlData	= param [1,"",[""]];
_ctrlIDC 	= ctrlIDC _ctrl;
_disp		= ctrlParent _ctrl;
_posX		= ((ctrlposition _ctrl) select 0)+ ((ctrlposition _ctrl) select 2);
_posY		= (ctrlposition _ctrl) select 1;
_suspect = (player getVariable ["interactWith",[]]) select 0;

_pos = screenToWorld [0.5,0.5];

_markTarget = {
	closeDialog 0;
	params ["_text","_pos","_tittle"];
	private ["_markerName","_path"];

	//Create marker
	_markerName = (getplayerUID player) + _text + str floor time;

	if (_text == "MinefieldAP") then {
		_path = "";
		_text = "";
	} else {
		if (playerside == east) then {_path = "b_"} else {_path = "o_"};
	};

	if (_pos distance player < 1500) then {
		player globalRadio "SentEnemyDetectedClose";
		[[_markerName, _path, _pos, _text,_tittle, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
	} else {
		player globalRadio "SentNoTarget";
	};
};

switch (true) do {
	case (_ctrlData == "medic"): {
		private ["_bandage","_medkit","_maxBleeding","_complex","_isMedic","_itemsPlayer","_itemsSuspect","_bandagePic","_medkitPic","_string","_remaineBlood","_color","_fatigueEffect"];
		//_child =  MCC_interactionMenu1;
		_complex = missionNamespace getVariable ["MCC_medicComplex",false];
		if (_complex) then {
			_bandage = "MCC_bandage";
			_medkit = "MCC_firstAidKit";
		} else {
			_bandage = "FirstAidKit";
			_medkit = "Medikit";
		};
		_bandagePic = getText (configFile >> "cfgWeapons" >> _bandage >> "picture");
		_medkitPic = getText (configFile >> "cfgWeapons" >> _medkit >> "picture");
		_itemsPlayer = items player;

		_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
		_remaineBlood = _suspect getvariable ["MCC_medicRemainBlood",_maxBleeding];
		_fatigueEffect = floor (30*(getFatigue _suspect));
		_isMedic = if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {true} else {false};

		//Blood loss
		switch (true) do {
			case (!alive _suspect) : {_string = "No pulse, he is Dead";  _color = [1,0,0,1];};
			case (_remaineBlood == _maxBleeding) : {_string = format ["Pulse %1: No Blood Loss",(floor (random 5))+80+_fatigueEffect];  _color = [1,1,1,1];};
			case (_remaineBlood/_maxBleeding < 0.4) : {_string = format ["Pulse %1: Sever Blood Loss",(floor (random 5))+160+_fatigueEffect];  _color = [1,0,0,1];};
			case (_remaineBlood/_maxBleeding < 0.7) : {_string = format ["Pulse %1: Mild Blood Loss",(floor (random 5))+120+_fatigueEffect];  _color = [1,1,0,1];};
			case (_remaineBlood/_maxBleeding >= 0.7) : {_string = format ["Pulse %1: Minor Blood Loss",(floor (random 5))+95+_fatigueEffect];  _color = [0,1,0,1];};
		};

		_array = [
				   ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
				   ["",_string,format ["%1data\IconPulse.paa",MCC_path],_color],
				   ["[(_this select 0),'physical'] spawn MCC_fnc_interactSelfClicked","Physical Check",format ["%1data\IconPhysical.paa",MCC_path]],
				   [format ["closeDialog 0;['bandage',%1] spawn MCC_fnc_medicUseItem",_suspect],format ["Bandages X %1", {_x == _bandage} count (_itemsPlayer)],_bandagePic],
				   [format ["closeDialog 0;['heal',%1] spawn MCC_fnc_medicUseItem",_suspect],"Heal",_medkitPic]
				 ];

		if ( !alive _suspect) then {_array set [2,-1]};
		if (!(_bandage in (_itemsPlayer)) || !alive _suspect) then {_array set [3,-1]};
		if (!(_medkit in _itemsPlayer) || !_isMedic || !alive _suspect || (_suspect getVariable ["MCC_medicUnconscious",false]) || ((_suspect getVariable ["MCC_medicBleeding",0])> 0.2)) then {_array set [4,-1]};
		_array = _array - [-1];
		_layer = 1;
	};

	case (_ctrlData == "physical"):	{
		private ["_string","_damage","_hitPoints","_partName","_bleeding"];
		_hitPoints = ["HitHead","HitBody","hitLegs","hitHands"];
		_partName = ["Head: ","Body: ","Legs: ","Hands: "];
		_partPic = [
					MCC_path + "mcc\dialogs\medic\data\soldier_head.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_body.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_legs.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_hands.paa"
					];
		_array = [["[(missionNamespace getVariable ['MCC_interactionLayer_1',[]]),2] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]]];
		_bleeding = _suspect getVariable ["MCC_medicBleeding",0];


		//Trauma
		{
			_subArray = [""];
			_damage = _suspect getHitPointDamage _x;
			switch (true) do {
				case (_damage < 0.05) : {_string = "No trauma"; _subArray set [3,[1,1,1,1]];};
				case (_damage < 0.3) : {_string = "Minor trauma"; _subArray set [3,[0,1,0,1]];};
				case (_damage < 0.6) : {_string = "Mild trauma"; _subArray set [3,[1,1,0,1]];};
				case (_damage >= 0.6) : {_string = "Severe trauma"; _subArray set [3,[1,0,0,1]];};
			};

			_subArray set [1,(_partName select _foreachIndex) + _string];
			_subArray set [2,(_partPic select _foreachIndex)];
			_array pushBack _subArray;
		} foreach _hitPoints;


		//Bleeding
		_subArray = [];
		_subArray set [0,""];

		switch (true) do
						{
							case (_bleeding == 0) : {_string =  "Not Bleeding"; _subArray set [3,[1,1,1,1]];};
							case (_bleeding < 0.2) : {_string =  "Minor Bleeding"; _subArray set [3,[0,1,0,1]];};
							case (_bleeding < 0.6) : {_string =  "Mild Bleeding"; _subArray set [3,[1,1,0,1]];};
							case (_bleeding >= 0.6) : {_string =  "Severe Bleeding"; _subArray set [3,[1,0,0,1]];};
						};

		_subArray set [1,"Bleeding: " + _string];
		_subArray set [2,MCC_path + "mcc\interaction\data\IconBleeding.paa"];
		_array pushBack _subArray;

		_layer = 2;
	};

	case (_ctrlData == "enemy"): {
		_path = if (playerside == east) then {"b_"} else {"o_"};
		_array = [
				   ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
				   [format ["['inf',%1,'Infantry'] spawn %2",_pos, _markTarget],"Infantry",format["\A3\ui_f\data\map\markers\nato\%1inf.paa",_path]],
				   [format ["['mech_inf',%1,'Motorized'] spawn %2",_pos, _markTarget],"Motorized",format["\A3\ui_f\data\map\markers\nato\%1motor_inf.paa",_path]],
				   [format ["['motor_inf',%1,'Mechanized'] spawn %2",_pos, _markTarget],"Mechanized",format["\A3\ui_f\data\map\markers\nato\%1mech_inf.paa",_path]],
				   [format ["['armor',%1,'Armor'] spawn %2",_pos, _markTarget],"Armor",format["\A3\ui_f\data\map\markers\nato\%1armor.paa",_path]],
				   [format ["['air',%1,'Helicopter'] spawn %2",_pos, _markTarget],"Helicopter",format["\A3\ui_f\data\map\markers\nato\%1air.paa",_path]],
				   [format ["['plane',%1,'Plane'] spawn %2",_pos, _markTarget],"Plane",format["\A3\ui_f\data\map\markers\nato\%1plane.paa",_path]],
				   [format ["['naval',%1,'Naval'] spawn %2",_pos, _markTarget],"Naval",format["\A3\ui_f\data\map\markers\nato\%1naval.paa",_path]],
				   [format ["['art',%1,'Artillery'] spawn %2",_pos, _markTarget],"Artillery",format["\A3\ui_f\data\map\markers\nato\%1art.paa",_path]],
				   [format ["['installation',%1,'Installation'] spawn %2",_pos, _markTarget],"Installation",format["\A3\ui_f\data\map\markers\nato\%1Installation.paa",_path]],
				   [format ["['unknown',%1,'Unknown'] spawn %2",_pos, _markTarget],"Unknown",format["\A3\ui_f\data\map\markers\nato\%1unknown.paa",_path]],
				   [format ["['MinefieldAP',%1,'Mine'] spawn %2",_pos, _markTarget],"Mine","\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa"]
				 ];

		_layer = 1;
	};

	case (_ctrlData == "support"): {
		_path = "\A3\ui_f\data\map\markers\military\";
		_array = [
				   ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
				   ["attack","Attack",format["%1mcc\interaction\data\attack_ca.paa",MCC_path]],
				   ["defend","Defend",format["%1mcc\interaction\data\defend_ca.paa",MCC_path]],
				   ["mil_destroy","Close Air Support",format["%1mcc\interaction\data\cas_ca.paa",MCC_path]],
				   ["mil_objective","Artillery",format["%1mcc\interaction\data\artillery_ca.paa",MCC_path]],
				   ["mil_pickup","Transport",format["%1mcc\interaction\data\transport_ca.paa",MCC_path]],
				   ["mil_warning","Medic",format["%1data\IconMed.paa",MCC_path]],
				   ["mil_warning","Ammo",format["%1data\IconAmmo.paa",MCC_path]],
				   ["mil_warning","Repairs",format["%1data\IconRepair.paa",MCC_path]],
				   ["mil_warning","Fuel",format["%1data\IconFuel.paa",MCC_path]]
				 ];

		_layer = 1;
	};
};

[_array,_layer] call MCC_fnc_interactionsBuildInteractionUI;
	/*

	case (_ctrlData == "support"): {
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
	case (_ctrlData in ["mil_destroy","mil_pickup","mil_objective","mil_marker","mil_warning"]): {
		_array = [];
		_text = ["Need CAS","Need Transport","Need Area attack","Need Support","Need Medic","Need Ammo","Need Repairs","Need Fuel"] select _index;

		if (_ctrlData in ["mil_warning","mil_pickup"]) then {_pos = getpos player};

		if (_pos distance player < 3000) then {
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
		} else {
			player globalRadio "SentCommandFailed";
		};
	};

	case (_ctrlData == "build"): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_child =  MCC_interactionMenu1;
		_path = "\A3\ui_f\data\map\markers\military\";
		_array = [
				   ["fob","Forward Outpost","\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"],
				   ["bunker","Small Bunker","\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa"],
				   ["wall","Bag Fence","\A3\ui_f\data\map\mapcontrol\Stack_CA.paa"],
				   ["hmg","HMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_MG_CA.paa"],
				   ["gmg","GMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa"],
				   ["at","AT Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa"],
				   ["aa","AA Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AA_CA.paa"],
				   ["mortar","Mortar Pit","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa"]
				 ];
	};

	case (_ctrlData in ["fob","bunker","hmg","gmg","at","aa","mortar","wall"]): {
		_conType = uinamespace getVariable "MCC_interactionMenu1Data";
		[_conType,_pos] spawn MCC_fnc_initConstract;
	};

	//Open SQL PDA
	case (_ctrlData == "sqlpda"): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_null = [nil,nil,nil,nil,3] execVM format["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];
	};

	//Rally Point
	case (_ctrlData == "rallypoint"): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		[player,player,nil] execVM format ["%1mcc\general_scripts\respawnTents\DeployRespawnTents.sqf",MCC_path];
	};

	//Open Commander Console
	case (_ctrlData == "commander"): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_null = [nil,nil,nil,nil,1] execVM format["%1mcc\dialogs\mcc_PopupMenu.sqf",MCC_path];
	};

	//Menu - gear
	case (_ctrlData in ["gear"]): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		_child =  MCC_interactionMenu1;
		_array = [];
		{
			if (_x in magazines player) then {
				_array pushBack [_x, format ["%1",getText(configFile >> "cfgMagazines" >> _x >> "displayname")], getText(configFile >> "cfgMagazines" >> _x >> "picture")];
			};
		} forEach ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","O_IR_Grenade","I_IR_Grenade"];
	};

	case (_ctrlData in ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","O_IR_Grenade","I_IR_Grenade"]): {
		MCC_interactionMenu1 ctrlShow false;
		MCC_interactionMenu2 ctrlShow false;

		player removeMagazine _ctrlData;
		_ammo = getText(configFile >> "cfgMagazines" >> _ctrlData >> "ammo");
		_item = _ammo createVehicle [0,0,0];
    	_item attachTo [player, [-0.05, 0, .09], "rightshoulder"];
    	player setVariable ["MCC_playerAttachedGearItem",_item];
    	player setVariable ["MCC_playerAttachedGearItemClass",_ctrlData];
	};

	case (_ctrlData == "detach"): {
		_item = (player getVariable ["MCC_playerAttachedGearItem",objNull]);
		detach _item;
		_item setPos [-999,-999,-999];
		sleep 1;
		deleteVehicle _item;
		player addMagazine (player getVariable ["MCC_playerAttachedGearItemClass",""]);
	};
};
/*
//Reveal
if (!isnil "_child") then {
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
