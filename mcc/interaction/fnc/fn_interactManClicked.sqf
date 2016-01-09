//=========================================================MCC_fnc_interactManClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrlData","_suspect","_array"];
disableSerialization;

_ctrlData	= param [0,"",[""]];
_suspect = (player getVariable ["interactWith",[]]) select 0;


switch (true) do {
	case (_ctrlData == "zip"): {

		//Zipcuff
		if ((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player)) exitWith {
			["Restraining suspect",5] call MCC_fnc_interactProgress;
			playsound "MCC_zip";
			if (MCC_isACE) then {
				[_suspect, true] call ACE_captives_fnc_setHandcuffed;
			} else {
				sleep 1.5;
				[[_suspect, "AmovPercMstpSnonWnonDnon_Ease", false, -1],"MCC_fnc_setUnitAnim", _suspect, false] spawn BIS_fnc_MP;
			};

			_suspect setVariable ["MCC_disarmed",false,true];
			_suspect setVariable ["MCC_neutralize",true,true];
		};
	};

	case (_ctrlData == "follow"): {
		if ((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2))) exitWith {
				_null = [_suspect, player, 0,[0]] execVM format ["%1mcc\general_scripts\hostages\hostage.sqf",MCC_path];
		};
	};

	case (_ctrlData == "pickKit"): {
		[_suspect] call MCC_fnc_pickKit;
	};

	case (_ctrlData == "medic"): {
		private ["_bandage","_epipen","_saline","_medkit","_maxBleeding","_complex","_isMedic","_itemsPlayer","_itemsSuspect","_bandagePic","_epipenPic","_salinePic","_medkitPic","_remaineBlood","_fatigueEffect","_string","_color"];

		_complex = missionNamespace getVariable ["MCC_medicComplex",false];

		if (_complex && MCC_isMode) then {
			_bandage = "MCC_bandage";
			_bandagePic = getText (configFile >> "cfgWeapons" >> _bandage >> "picture");

			_epipen = "MCC_epipen";
			_epipenPic = getText (configFile >> "cfgWeapons" >> _epipen >> "picture");

			_saline = "MCC_salineBag";
			_salinePic = getText (configFile >> "cfgWeapons" >> _saline >> "picture");

			_medkit = "MCC_firstAidKit";
			_medkitPic = getText (configFile >> "cfgWeapons" >> _medkit >> "picture");
		} else {
			_bandage = "FirstAidKit";
			_bandagePic = getText (configFile >> "CfgWeapons" >> _bandage >> "picture");

			_epipen = "Medikit";
			_epipenPic = format ["%1data\items\epipen.paa",MCC_path];

			_saline = "Medikit";
			_salinePic = format ["%1data\items\saline.paa",MCC_path];

			_medkit = "Medikit";
			_medkitPic = getText (configFile >> "CfgWeapons" >> _medkit >> "picture");
		};

		_itemsPlayer =  items player;
		_itemsSuspect = if (_suspect getvariable ["MCC_medicUnconscious",false]) then {items _suspect} else {[]};

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
				   ["['physical'] spawn MCC_fnc_interactManClicked","Physical Check",format ["%1data\IconPhysical.paa",MCC_path]],
				   ["['bandage'] spawn MCC_fnc_interactManClicked",format ["Bandage X %1", {_x == _bandage} count (_itemsPlayer+_itemsSuspect)],_bandagePic],
				   ["['epipen'] spawn MCC_fnc_interactManClicked",format ["Inject epipen X %1", {_x == _epipen} count (_itemsPlayer+_itemsSuspect)],_epipenPic],
				   ["['saline'] spawn MCC_fnc_interactManClicked",format ["Saline transfusion X %1", {_x == _saline} count (_itemsPlayer+_itemsSuspect)],_salinePic],
				   ["['heal'] spawn MCC_fnc_interactManClicked","First Aid",_medkitPic]
				 ];

		if ( !alive _suspect) then {_array set [2,-1]};
		if (!(_bandage in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [3,-1]};
		if (!(_epipen in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [4,-1]};
		if (!(_saline in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [5,-1]};
		if (!(_medkit in _itemsPlayer) || !_isMedic || !alive _suspect || (_suspect getVariable ["MCC_medicUnconscious",false]) || ((_suspect getVariable ["MCC_medicBleeding",0])> 0.2)) then {_array set [6,-1]};
		_array = _array - [-1];

		[_array,1] call MCC_fnc_interactionsBuildInteractionUI;
	};

	case (_ctrlData in ["bandage","epipen","saline","heal"]): {
		_null = [_ctrlData,_suspect] spawn MCC_fnc_medicUseItem
	};

	case (_ctrlData == "physical"): {
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

		[_array,2] call MCC_fnc_interactionsBuildInteractionUI;
	};

	case (_ctrlData in ["drag","carry"] ): {

		[player,_suspect, _ctrlData == "carry"] call MCC_fnc_medicDragCarry;
	};

	case (["load",_ctrlData] call bis_fnc_inString): {
		closeDialog 0;
		[[_suspect,_ctrlData,true], "MCC_fnc_loadWounded", _suspect, false] spawn BIS_fnc_MP;
	};
};