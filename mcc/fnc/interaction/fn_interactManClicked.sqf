//=========================================================MCC_fnc_interactManClicked==========================================================================================
//==============================================================================================================================================================================
private ["_ctrl","_index","_ctrlData","_suspect","_ctrlIDC","_disp","_posX","_posY","_child","_array"];
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

//saveData
switch (_ctrlIDC) do
{
	case 0:	{uinamespace setVariable ["MCC_interactionMenu0Data", _ctrlData]};
	case 1:	{uinamespace setVariable ["MCC_interactionMenu1Data", _ctrlData]};
};

//Close dialog
if (_ctrlData in ["zip","follow","pickKit","close","bandage","epipen","saline","heal","drag","carry"]) then {closeDialog 0};

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
		private ["_bandage","_epipen","_saline","_medkit","_maxBleeding","_complex","_isMedic","_itemsPlayer","_itemsSuspect","_bandagePic","_epipenPic","_salinePic","_medkitPic"];
		_child =  MCC_interactionMenu1;
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
		_isMedic = if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {true} else {false};

		_array = [
				   ["pulse","Pulse Check",format ["%1data\IconPulse.paa",MCC_path],[0,1,0,1]],
				   ["physical","Physical Check",format ["%1data\IconPhysical.paa",MCC_path],[0,1,0,1]],
				   ["bandage",format ["Bandage X %1", {_x == _bandage} count (_itemsPlayer+_itemsSuspect)],_bandagePic],
				   ["epipen",format ["Inject epipen X %1", {_x == _epipen} count (_itemsPlayer+_itemsSuspect)],_epipenPic],
				   ["saline",format ["Saline transfusion X %1", {_x == _saline} count (_itemsPlayer+_itemsSuspect)],_salinePic],
				   ["heal","First Aid",_medkitPic]
				 ];

		if ( !alive _suspect) then {_array set [1,-1]};
		if (!(_bandage in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [2,-1]};
		if (!(_epipen in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [3,-1]};
		if (!(_saline in (_itemsPlayer+_itemsSuspect)) || !alive _suspect) then {_array set [4,-1]};
		if (!(_medkit in _itemsPlayer) || !_isMedic || !alive _suspect || (_suspect getVariable ["MCC_medicUnconscious",false]) || ((_suspect getVariable ["MCC_medicBleeding",0])> 0.2)) then {_array set [5,-1]};
		_array = _array - [-1];
	};

	case (_ctrlData in ["bandage","epipen","saline","heal"]): {
		[_ctrlData, _suspect] call MCC_fnc_medicUseItem;
	};

	case (_ctrlData == "pulse"): {
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

	case (_ctrlData == "physical"): {
		private ["_string","_damage","_hitPoints","_subArray","_partName","_bleeding","_partPic"];
		_child =  MCC_interactionMenu2;
		_hitPoints = ["HitHead","HitBody","hitLegs","hitHands"];
		_partName = ["Head: ","Body: ","Legs: ","Hands: "];
		_partPic = [
					MCC_path + "mcc\dialogs\medic\data\soldier_head.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_body.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_legs.paa",
					MCC_path + "mcc\dialogs\medic\data\soldier_hands.paa"
					];
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
			_subArray set [1,(_partName select _foreachIndex) + _string];
			_subArray set [2,(_partPic select _foreachIndex)];
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

	case (_ctrlData in ["drag","carry"] ): {

		[player,_suspect, _ctrlData == "carry"] call MCC_fnc_medicDragCarry;
	};

	case (["load",_ctrlData] call bis_fnc_inString): {
		closeDialog 0;
		[[_suspect,_ctrlData,true], "MCC_fnc_loadWounded", _suspect, false] spawn BIS_fnc_MP;
	};
};

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

	_child ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_interactManClicked"];
};
