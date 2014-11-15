//==================================================================MCC_fnc_interactMan===============================================================================================
// Interaction with man type
// Example: [_suspect,_men] spawn MCC_fnc_interactMan; 
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos"];
_suspect 	= _this select 0;
_men 		= _this select 1;
_keyName	= _this select 2;

disableSerialization;
player setVariable ["MCC_interactionActive",true];

//draw interaction text
if (!MCC_interactionKey_holding && ((_suspect getVariable ["MCC_disarmed",false]) || ((_suspect getVariable ["MCC_neutralize",false])) && !(_suspect in units group player))) then
{
	_pos = getpos _suspect;
	_pos set [2, (_pos select 2) + 1.5];
	missionNameSpace setVariable ["MCC_interactionObjects", [[_pos, format ["Hold %1 to interact",_keyName]]]];
}
else
{
	missionNameSpace setVariable ["MCC_interactionObjects", []];
};

if (MCC_interactionKey_holding && (player distance  _suspect < 5) && !dialog) exitWith
{
	MCC_fnc_ManMenuClicked =
	{
		private ["_ctrl","_index","_ctrlData","_suspect"];
		disableSerialization;

		_ctrl 		= _this select 0;
		_index 		= _this select 1;
		_ctrlData	= _ctrl lbdata _index;
		
		_suspect = (player getVariable ["interactWith",[]]) select 0;
		closeDialog 0;
		
		switch (_ctrlData) do
		{	
			case "zip":		
			{
				//Zipcuff
				if ((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player)) exitWith
				{
					["Restraining suspect",5] call MCC_fnc_interactProgress; 
					playsound "MCC_zip";
					_suspect setVariable ["MCC_disarmed",false,true];
					sleep 1.5;
					[[_suspect, "AmovPercMstpSnonWnonDnon_Ease", false, -1],"MCC_fnc_setUnitAnim", _suspect, false] spawn BIS_fnc_MP;
					_suspect setVariable ["MCC_neutralize",true,true];
				};
			};
			
			case "follow":		
			{
				if ((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2))) exitWith
				{
						_null = [_suspect, player, 0,[0]] execVM format ["%1mcc\general_scripts\hostages\hostage.sqf",MCC_path];
				};
			};
			
			case "pickKit":		
			{
				private ["_itemsPlayer","_itemsSuspect","_wepHolder","_backPackSuspect","_backPackPlayer","_vestPlayer","_vestSuspect","_time","_wepSuspect",
				         "_wepPlayer"];
				
				_itemsPlayer  = itemsWithMagazines player;
				_itemsSuspect = itemsWithMagazines _suspect;

				_backPackSuspect	= backpack _suspect;
				_backPackPlayer 	= backpack player;
				_vestSuspect 		= vest _suspect;
				_vestPlayer 		= vest player;
				
				_wepPlayer = weapons player; 
				_wepSuspect = weapons _suspect;
				
				//remove
				removeAllItemsWithMagazines player;
				removeAllItemsWithMagazines _suspect;

				//Backpack
				if (_backPackPlayer != "") then
				{
					removeBackpackGlobal player;

					if (_backPackSuspect != "") then
					{
						removeBackpackGlobal _suspect;
						player addBackpack _backPackSuspect;
						_time = time;
						waituntil {backpack player == _backPackSuspect || time - _time > 3 };
					};
					_suspect addBackpack _backPackPlayer;
					_time = time;
					waituntil {backpack _suspect == _backPackPlayer || time - _time > 3 };
				}
				else
				{
					if (_backPackSuspect != "") then
					{
						removeBackpackGlobal _suspect;
						player addBackpack _backPackSuspect;
						_time = time;
						waituntil {backpack player == _backPackSuspect || time - _time > 3 };
					};
				};
				
				//Vest
				if (_vestPlayer != "") then
				{
					removeVest player;

					if (_vestSuspect != "") then
					{
						removeVest _suspect;
						player addVest _vestSuspect;
						_time = time;
						waituntil {vest player == _vestSuspect || time - _time > 3 };
					};
					_suspect addVest _vestPlayer;
					_time = time;
					waituntil {vest _suspect == _vestPlayer || time - _time > 3 };
				}
				else
				{
					if (_vestSuspect != "") then
					{
						removeVest _suspect;
						player addVest _vestSuspect;
						_time = time;
						waituntil {vest player == _vestSuspect || time - _time > 3 };
					};
				};
				
				//weapons
				private ["_nearHolders","_holder"];
				
				_nearHolders = (getpos _suspect nearObjects ["weaponHolderSimulated",3]);

				if (count _wepPlayer > 0) then
				{
					if (count _nearHolders > 0) then
					{
						_wepHolder = _nearHolders select 0;
					}
					else
					{
						_wepHolder = "weaponHolderSimulated" createVehicle getpos _suspect;
						waituntil {!isnil "_wepHolder"};
						_wepHolder setpos getpos _suspect;
					};
					
					{
						_weapon = if (typeName _x == "STRING") then {_x} else {_x select 0};
						player action ["DropWeapon", _wepHolder, _weapon];
					} foreach _wepPlayer;
				};
				
				{
					_holder = _x; 
					{player action ["TakeWeapon", _holder, _x]} foreach (weaponCargo _x);
				} foreach _nearHolders;
				
				{
					player action ["TakeWeapon", _suspect, _x];
				} foreach _wepSuspect;
				
				//Items + mage
				{
					switch (true) do
					{
						case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addMagazine _x};
						case (isClass (configFile >> "CfgWeapons" >> _x)) : {player addItem _x};
					};
				} foreach _itemsSuspect;
				
				
				{
					switch (true) do
					{
						case (isClass (configFile >> "CfgMagazines" >> _x)) : {_suspect addMagazine _x};
						case (isClass (configFile >> "CfgWeapons" >> _x)) : {_suspect addItem _x};
					};
				} foreach _itemsPlayer;
			};
		};
	};
	
	_array = [["zip","Restrain Suspect",""],
			  ["follow","Order Suspect",""],
			  ["pickKit","Pick Up Kit",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];
	

	//Manage array
	if !((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player) && alive _suspect) then {_array set [0,-1]};
	if !((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2)) && alive _suspect) then {_array set [1,-1]};
	if (alive _suspect) then {_array set [2,-1]};
	_array = _array - [-1];
	
	if (count _array == 1) exitWith {}; 
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
	player setVariable ["MCC_interactionActive",false];  
};

//Cant neturalize friendly units
if (((side _suspect != civilian && (side _suspect getFriend  side player)>0.6)) || isPlayer _suspect || (_suspect getVariable ["MCC_neutralize",false]) || (_suspect getVariable ["MCC_disarmed",false]) || !(alive _suspect)) exitWith {player setVariable ["MCC_interactionActive",false]};

//shout
[[[netid _men,_men], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
sleep 1; 

_factor = if (side _suspect == civilian) then {6} else {11};
if (primaryWeapon player == "") then {_factor = _factor*2}; 
_rand= random 20;
		
[[2,getpos _suspect,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _suspect)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

//Stop and look at the player
[[[_suspect, _men], 
  {
	_suspect = _this select 0;
	_men = _this select 1;
	
	(group _suspect) setFormDir ([_suspect,_men] call BIS_fnc_dirTo);
	doStop _suspect;
	_suspect disableAI "MOVE";
  }],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;

//Get courage
_suspectCorage = _suspect getVariable "MCC_courage";
if (isnil "_suspectCorage") then
{
	_suspectCorage = (rankId _suspect + (random 10 + _factor) + count units group _suspect);
	_suspect setVariable ["MCC_courage",_suspectCorage,true];
};
_suspectCorage = _suspectCorage * (1-(getdammage _suspect));

//If comply
if (random 25 > _suspectCorage || (_suspect getVariable ["MCC_Stunned", false])) then 
{
	[[[netid _suspect,_suspect], format ["enough%1",floor random 14]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	[[_suspect,"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"], "MCC_fnc_disarmUnit", _suspect, false] spawn BIS_fnc_MP;

	//if is armed civilian
	if ((_suspect getVariable ["MCC_IEDtype",""]) == "ac") then
	{
		_suspect setvariable ["armed",false,true];
		sleep 1;
		{
		  deleteVehicle _x;
		} forEach attachedObjects _suspect;
	};
	
	//If left unintended for long will break free
	_suspect spawn 
	{
		private ["_escapeChance","_suspect"];
		_suspect		= _this;
		_escapeChance 	= 0.01;
				
		while {alive _suspect && !(_suspect getVariable ["MCC_neutralize",false])} do
		{
			if (random 1 < _escapeChance) exitWith {_suspect setVariable ["MCC_disarmed",false,true]}; 
			_escapeChance = _escapeChance + 0.01;
		};
		
		_suspect setVariable ["MCC_disarmed",false]
	};
} 
else
{
	[[[netid _suspect,_suspect], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	if ((stance _suspect == "STAND") && (side _suspect == civilian)) then 
	{
		[[_suspect,"Acts_Kore_Introducing",true,4], "MCC_fnc_setUnitAnim", true, false] spawn BIS_fnc_MP;
	};
};

[[[_suspect],{(_this select 0) enableAI "MOVE";}],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;
player setVariable ["MCC_interactionActive",false]; 