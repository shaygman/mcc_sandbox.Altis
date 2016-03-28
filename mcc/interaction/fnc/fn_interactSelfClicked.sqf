//=========================================================MCC_fnc_interactSelfClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrl","_ctrlData","_suspect","_child","_array","_pos","_path","_layer"];
disableSerialization;

_ctrl 		= _this select 0;
_ctrlData	= param [1,"",[""]];
_suspect = (player getVariable ["interactWith",[]]) select 0;

_pos = screenToWorld [0.5,0.5];

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
				   [format ["['bandage',%1] spawn MCC_fnc_medicUseItem",_suspect],format ["Bandages X %1", {_x == _bandage} count (_itemsPlayer)],_bandagePic],
				   [format ["['heal',%1] spawn MCC_fnc_medicUseItem",_suspect],"Heal",_medkitPic]
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
				   [format ["['inf',%1,'Infantry'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Infantry",format["\A3\ui_f\data\map\markers\nato\%1inf.paa",_path]],
				   [format ["['mech_inf',%1,'Motorized'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Motorized",format["\A3\ui_f\data\map\markers\nato\%1motor_inf.paa",_path]],
				   [format ["['motor_inf',%1,'Mechanized'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Mechanized",format["\A3\ui_f\data\map\markers\nato\%1mech_inf.paa",_path]],
				   [format ["['armor',%1,'Armor'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Armor",format["\A3\ui_f\data\map\markers\nato\%1armor.paa",_path]],
				   [format ["['air',%1,'Helicopter'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Helicopter",format["\A3\ui_f\data\map\markers\nato\%1air.paa",_path]],
				   [format ["['plane',%1,'Plane'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Plane",format["\A3\ui_f\data\map\markers\nato\%1plane.paa",_path]],
				   [format ["['naval',%1,'Naval'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Naval",format["\A3\ui_f\data\map\markers\nato\%1naval.paa",_path]],
				   [format ["['art',%1,'Artillery'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Artillery",format["\A3\ui_f\data\map\markers\nato\%1art.paa",_path]],
				   [format ["['installation',%1,'Installation'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Installation",format["\A3\ui_f\data\map\markers\nato\%1Installation.paa",_path]],
				   [format ["['unknown',%1,'Unknown'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Unknown",format["\A3\ui_f\data\map\markers\nato\%1unknown.paa",_path]],
				   [format ["['MinefieldAP',%1,'Mine'] spawn MCC_fnc_interactionMarkerCreate",_pos],"Mine","\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa"]
				 ];

		_layer = 1;
	};

	case (_ctrlData == "support"): {
		_path = "\A3\ui_f\data\map\markers\military\";
		_array = [
				   ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
				   [format ["['mil_objective',%1,'Attack',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Attack",format["%1mcc\interaction\data\attack_ca.paa",MCC_path]],
				   [format ["['mil_objective',%1,'Defend',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Defend",format["%1mcc\interaction\data\defend_ca.paa",MCC_path]],
				   [format ["['mil_destroy',%1,'Need CAS',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Close Air Support",format["%1mcc\interaction\data\cas_ca.paa",MCC_path]],
				   [format ["['mil_destroy',%1,'Need Artillery',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Artillery",format["%1mcc\interaction\data\artillery_ca.paa",MCC_path]],
				   [format ["['mil_pickup',%1,'Need Transport',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Transport",format["%1mcc\interaction\data\transport_ca.paa",MCC_path]],
				   [format ["['mil_warning',%1,'Need Medic',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Medic",format["%1data\IconMed.paa",MCC_path]],
				   [format ["['mil_warning',%1,'Need Ammo',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Ammo",format["%1data\IconAmmo.paa",MCC_path]],
				   [format ["['mil_warning',%1,'Need Repairs',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Repairs",format["%1data\IconRepair.paa",MCC_path]],
				   [format ["['mil_warning',%1,'Need Fuel',true] spawn MCC_fnc_interactionMarkerCreate",_pos],"Fuel",format["%1data\IconFuel.paa",MCC_path]]
				 ];

		_layer = 1;
	};

	case (_ctrlData == "build"): {
		_path = "\A3\ui_f\data\map\markers\military\";
		_array = [
				   ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
				   [format["['fob',%1] spawn MCC_fnc_initConstract",_pos],"Forward Outpost","\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"],
				   [format["['bunker',%1] spawn MCC_fnc_initConstract",_pos],"Small Bunker","\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa"],
				   [format["['wall',%1] spawn MCC_fnc_initConstract",_pos],"Bag Fence","\A3\ui_f\data\map\mapcontrol\Stack_CA.paa"],
				   [format["['hmg',%1] spawn MCC_fnc_initConstract",_pos],"HMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_MG_CA.paa"],
				   [format["['gmg',%1] spawn MCC_fnc_initConstract",_pos],"GMG Pit","\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa"],
				   [format["['at',%1] spawn MCC_fnc_initConstract",_pos],"AT Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa"],
				   [format["['aa',%1] spawn MCC_fnc_initConstract",_pos],"AA Pit","\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AA_CA.paa"],
				   [format["['mortar',%1] spawn MCC_fnc_initConstract",_pos],"Mortar Pit","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa"]
				 ];

		_layer = 1;
	};

	case (_ctrlData in ["gear"]): {
		_array = [
					 ["[(missionNamespace getVariable ['MCC_interactionLayer_0',[]]),1] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
					 ["[(_this select 0),'uniform'] spawn MCC_fnc_interactSelfClicked","Uniform",format ["%1mcc\roleSelection\data\ui\uniform_ca.paa", MCC_path]],
					 ["[(_this select 0),'weapon'] spawn MCC_fnc_interactSelfClicked","Weapon",format ["%1mcc\roleSelection\data\ui\primaryweapon_ca.paa", MCC_path]]
				 ];

		_layer = 1;
	};

	case (_ctrlData in ["uniform"]): {
		_array = [
					 ["[(missionNamespace getVariable ['MCC_interactionLayer_1',[]]),2] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]]
				 ];

		if (isNull(player getVariable ["MCC_playerAttachedGearItem",objNull])) then {
			{
				if (_x in magazines player) then {
					_array pushBack [format ["['%1',true] spawn MCC_fnc_attachItemUniform",_x], format ["%1",getText(configFile >> "cfgMagazines" >> _x >> "displayname")], getText(configFile >> "cfgMagazines" >> _x >> "picture")];
				};
			} forEach ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","O_IR_Grenade","I_IR_Grenade"];
		} else {
			_array pushBack ["['',false] spawn MCC_fnc_attachItemUniform","Detach", "\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
		};

		_layer = 2;
	};

	case (_ctrlData in ["weapon"]): {
		_array = [
					 ["[(missionNamespace getVariable ['MCC_interactionLayer_1',[]]),2] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]],
					 ["[(_this select 0),'CowsSlot'] spawn MCC_fnc_interactSelfClicked","Optics",format ["%1mcc\roleSelection\data\ui\itemoptic_ca.paa", MCC_path]],
					 ["[(_this select 0),'PointerSlot'] spawn MCC_fnc_interactSelfClicked","Rails",format ["%1mcc\roleSelection\data\ui\itemacc_ca.paa", MCC_path]],
					 ["[(_this select 0),'MuzzleSlot'] spawn MCC_fnc_interactSelfClicked","Muzzle",format ["%1mcc\roleSelection\data\ui\itemmuzzle_ca.paa", MCC_path]],
					 ["[(_this select 0),'UnderBarrelSlot'] spawn MCC_fnc_interactSelfClicked","Bipod",format ["%1mcc\roleSelection\data\ui\itembipod_ca.paa", MCC_path]]
				 ];

		_layer = 2;
	};

	case (_ctrlData in ["CowsSlot","PointerSlot","MuzzleSlot","UnderBarrelSlot"]): {
		private ["_items","_assignedItems"];
		_assignedItems = [];
		_array = [
					 ["[(missionNamespace getVariable ['MCC_interactionLayer_2',[]]),3] spawn MCC_fnc_interactionsBuildInteractionUI","Back",format ["%1mcc\interaction\data\iconBack.paa",MCC_path]]
				 ];

		if (((primaryWeaponItems player) select (["MuzzleSlot","PointerSlot","CowsSlot","UnderBarrelSlot"] find _ctrlData))=="") then {

			_items = getArray (configFile >> "CfgWeapons" >> primaryWeapon player >> "WeaponSlotsInfo" >> _ctrlData >> "compatibleItems");

			{
				//Only god knows why BI is on inconsistante with config files one weapon it is an array the the other it isn't even a config
				if (tolower _x in _items || _x in _items) then {
					_assignedItems pushBack _x;
					_array pushBack [format ["['%1',true,'%2'] spawn MCC_fnc_attachItemWeapons",_x,_ctrlData], format ["%1",getText(configFile >> "CfgWeapons" >> _x >> "displayname")], getText(configFile >> "CfgWeapons" >> _x >> "picture")];
				};
				/*
				 else {
					if (((getNumber(configFile >> "CfgWeapons" >> primaryWeapon player >> "WeaponSlotsInfo" >> _ctrlData >> "compatibleItems" >> _x))>0)  && !(_x in _assignedItems)) then {
						_assignedItems pushBack _x;
						_array pushBack [format ["['%1',true,'%2'] spawn MCC_fnc_attachItemWeapons",_x,_ctrlData], format ["%1",getText(configFile >> "CfgWeapons" >> _x >> "displayname")], getText(configFile >> "CfgWeapons" >> _x >> "picture")];
					};
				};
				*/
			} forEach (items player);
		} else {
			_array pushBack [format ["['',false,'%1'] spawn MCC_fnc_attachItemWeapons",_ctrlData],"Detach", "\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
		};

		_layer = 3;
	};
};

[_array,_layer] call MCC_fnc_interactionsBuildInteractionUI;