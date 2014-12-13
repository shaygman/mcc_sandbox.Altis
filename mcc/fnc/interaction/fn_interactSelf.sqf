//==================================================================MCC_fnc_interactSelf========================================================================================
// Interaction with self
// Example: [] spawn MCC_fnc_interactSelf;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos"];
_suspect 	= _this select 0;

disableSerialization;

if (!dialog) exitWith
{
	MCC_fnc_ManMenuClicked =
	{
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
		if (_ctrlData in ["close","bandage","epipen","saline","heal","drag","carry"]) then {closeDialog 0};

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

			_child ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_ManMenuClicked"];
		};
	};

	_array = [["",format ["-= %1 =-",if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect}],""],
			  ["medic","Examine",format ["%1data\IconMed.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];


	if (count _array == 2) exitWith {};
	_ok = createDialog "MCC_INTERACTION_MENU";
	waituntil {dialog};

	_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
	_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
	_ctrl ctrlCommit 0;

	_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

	lbClear _ctrl;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _ctrl lbAdd _displayname;
		_ctrl lbSetPicture [_index, _pic];
		_ctrl lbSetData [_index, _class];
	} foreach _array;
	_ctrl lbSetCurSel 0;

	player setVariable ["interactWith",[_suspect]];
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_ManMenuClicked"];
	waituntil {!dialog};
};
