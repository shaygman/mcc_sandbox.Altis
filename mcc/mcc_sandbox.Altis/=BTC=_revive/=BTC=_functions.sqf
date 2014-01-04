/*
Created by =BTC= Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
06/03/2012
*/
//Functions
BTC_assign_actions =
{
	if (BTC_r_new_system == 0) then {if ([player] call BTC_is_class_can_revive) then {player addAction [("<t color=""#ED2744"">") + ("First aid") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_first_aid], 8, true, true, "", "[] call BTC_check_action_first_aid"];};} else {player addAction [("<t color=""#ED2744"">") + ("Medical unit check") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_check_unit_state], 8, true, false, "", "[] call BTC_check_action_unit_state"];player addAction [("<t color=""#ED2744"">") + ("Check yourself") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[player],BTC_check_unit_state], -8, false, false, "", "BTC_r_action_menu && format [""%1"",player getVariable ""BTC_need_revive""] == ""0"" && vehicle player == player"];};
	player addAction [("<t color=""#ED2744"">") + ("Drag") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#ED2744"">") + ("Pull out injured") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check"];
	player addAction [("<t color=""#ED2744"">") + ("Carry") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_carry], 8, true, true, "", "[] call BTC_check_action_drag"];
};
BTC_get_gear =
{
	private ["_array_mag","_id","_display_name","_count","_array_class","_array_bullet","_array_class_x","_array_bullet_x","_r_mag_d","_h_mag_d","_brack"];
	_gear = [];
	_weapons = [];
	_prim_weap = primaryWeapon player;
	_prim_items = primaryWeaponItems player;
	_sec_weap = secondaryWeapon player;
	_sec_items = secondaryWeaponItems player;
	_items_assigned = assignedItems player;
	_handgun = handgunWeapon player;
	_handgun_items = handgunItems player;
	if (_prim_weap != "") then {_weapons = _weapons + [_prim_weap]};
	if (_sec_weap != "") then {_weapons = _weapons + [_sec_weap]};
	if (_handgun != "") then {_weapons = _weapons + [_handgun]};
	_goggles = goggles player;
	_headgear = headgear player;
	_uniform = uniform player;
	_uniform_items = uniformItems player;
	_vest = vest player;
	_vest_items = vestItems player;
	_back_pack = backpack player;
	_back_pack_items = backpackItems player;
	_back_pack_weap = getWeaponCargo (unitBackpack player);
	_weap_sel = currentWeapon player;
	_weap_mode = currentWeaponMode player;
	_fire_mode_array = getArray (configFile >> "cfgWeapons" >> _weap_sel >> "modes");
	_fire_mode = _fire_mode_array find _weap_mode;

	_magazinesAmmoFull = magazinesAmmoFull player;
	_mag_uniform = [];_mag_vest = [];_mag_back = [];_mag_loaded_prim = [];_mag_loaded_sec = [];_mag_loaded_at = [];
	{
		if !(_x select 2) then
		{
			switch (true) do
			{
				case ((_x select 4) == "Vest" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1))     : {_mag_vest = _mag_vest + [[(_x select 0),(_x select 1)]]};
				case ((_x select 4) == "Uniform" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1))  : {_mag_uniform = _mag_uniform + [[(_x select 0),(_x select 1)]]};
				case ((_x select 4) == "Backpack" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1)) : {_mag_back = _mag_back + [[(_x select 0),(_x select 1)]]};
			};
		}
		else
		{
			switch (true) do
			{
				case ((_x select 3) == 1)  : {_mag_loaded_prim = [(_x select 0),(_x select 1)]};
				case ((_x select 3) == 2)  : {_mag_loaded_sec = [(_x select 0),(_x select 1)]};
				case ((_x select 3) == 4) : {_mag_loaded_at = [(_x select 0),(_x select 1)]};
			};			
		};
	} foreach _magazinesAmmoFull;
	_ammo = [_mag_loaded_prim,_mag_loaded_sec,_mag_loaded_at,_mag_uniform,_mag_vest,_mag_back];
	_gear =
	[
		_uniform,
		_vest,
		_goggles,
		_headgear,
		_back_pack,
		_back_pack_items,
		_back_pack_weap,
		_weapons,
		_prim_items,
		_sec_items,
		_handgun_items,
		_items_assigned,
		_uniform_items,
		_vest_items,
		_weap_sel,
		_fire_mode,
		_ammo
	];
	//diag_log text format ["------------------------------------------",""];
	//{diag_log text format ["%1",_x]} foreach _gear;
	//diag_log text format ["------------------------------------------",""];
	_gear
};
BTC_set_gear =
{
	/*_gear =
	[
		_uniform,0
		_vest,1
		_goggles,2
		_headgear,3
		_back_pack,4
		_back_pack_items,5
		_back_pack_weap,6
		_weapons,7
		_prim_items,8
		_sec_items,9
		_handgun_items,10
		_items_assigned,11
		_uniform_items,12
		_vest_items,13
		_weap_sel,14
		_fire_mode,15
		_ammo
	];*/
	_unit = _this select 0;
	_gear = _this select 1;
	_id = 0;
	//{diag_log text format ["Gear (ID: %1) = %2",_id,_x];_id = _id + 1;} foreach _gear;
	removeAllweapons _unit;
	removeuniform _unit;
	removevest _unit;
	removeheadgear _unit;
	removegoggles _unit;
	removeBackPack _unit;
	{_unit removeItem _x} foreach (items _unit);
	{_unit unassignItem _x;_unit removeItem _x} foreach (assignedItems _unit);
	////////////////////////
	if ((_gear select 0) != "") then {_unit addUniform (_gear select 0);};
	if ((_gear select 1) != "") then {_unit addVest (_gear select 1);};
	_unit addBackpack "B_AssaultPack_blk"; 
	if (count (_gear select 11) > 0) then {{if (_x == "Binocular") then {_unit addWeapon _x;};if (_x != "" && _x != "Binocular") then {_unit addItem _x;_unit assignItem _x;sleep 0.01;};} foreach (_gear select 11);};
	removeBackPack _unit;
	if ((_gear select 4) != "") then {_unit addBackPack (_gear select 4);clearAllItemsFromBackpack _unit;};
	
	_ammo = _gear select 16;
	if (count (_ammo select 0) > 0) then {_unit addMagazine (_ammo select 0)};
	if (count (_ammo select 1) > 0) then {_unit addMagazine (_ammo select 1)};
	if (count (_ammo select 2) > 0) then {_unit addMagazine (_ammo select 2)};
	{if (isClass (configFile >> "cfgWeapons" >> _x)) then {_unit addweapon _x;};} foreach (_gear select 7);
	//mags
	{_unit addMagazine _x;} foreach (_ammo select 3);
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 12);
	_watch = 0;
	while {loadUniform _unit < 1} do {_unit addItem "itemWatch";_watch = _watch + 1;};
	{_unit addMagazine _x;} foreach (_ammo select 4);
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 13);
	while {loadVest _unit < 1} do {_unit addItem "itemWatch";_watch = _watch + 1;};
	{_unit addMagazine _x;} foreach (_ammo select 5);
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 5);
	for "_i" from 1 to _watch do {_unit removeItem "ItemWatch";};
	if ((_gear select 2) != "") then {_unit addGoggles (_gear select 2);};
	if ((_gear select 3) != "") then {_unit addHeadgear (_gear select 3);};
	if (count ((_gear select 6) select 0) > 0) then 
	{
		for "_i" from 0 to (count ((_gear select 6) select 0) - 1) do
		{
			(unitBackpack _unit) addweaponCargoGlobal [((_gear select 6) select 0) select _i,((_gear select 6) select 1) select _i];
		};			
	};
	removeAllPrimaryWeaponItems _unit;
	if (count (_gear select 8) > 0) then {{if (_x != "") then {_unit addPrimaryWeaponItem _x;};} foreach (_gear select 8);};
	if (count (_gear select 9) > 0) then {{if (_x != "") then {_unit addSecondaryWeaponItem _x;};} foreach (_gear select 9);};
	if (count (_gear select 10) > 0) then {{if (_x != "") then {_unit addHandgunItem _x;};} foreach (_gear select 10);};
	_unit selectweapon (_gear select 14);
	if ((_gear select 15) != -1) then {player action ["SWITCHWEAPON", player, player, (_gear select 15)];};
};
/*
BTC_r_debug =
{
	_unit = _this;
	[] spawn {BTC_r_debug_c = true;
	while {BTC_r_debug_c} do
	{
		hintSilent format ["STATUS: %1\nISBLEEDING: %2\nDAMAGE: %3 L = %4 H = %5\nUNC: %6",player getVariable "BTC_r_status",BTC_is_bleeding,BTC_r_damage,BTC_r_damage_legs,BTC_r_damage_hands,BTC_r_unc];
		sleep 0.05;
	};};
};*/
BTC_fnc_handledamage_gear =
{
	_player = _this select 0;
	_enemy  = _this select 3;
	_damage = _this select 2;
	_part   = _this select 1;
	if (Alive _player && format ["%1", _player getVariable "BTC_need_revive"] == "0") then
	{
		BTC_gear = [_player] call BTC_get_gear;
	};
	_damage
	//if (format ["%1", _player getVariable "BTC_need_revive"] == "1") then {} else {_damage};
};
BTC_fnc_handledamage =
{
	_this spawn BTC_fnc_handledamage_2;
	0
};
BTC_fnc_handledamage_2 =
{
	_unit = _this select 0;
	_enemy  = _this select 3;
	_damage = _this select 2;
	_part   = _this select 1;
	if (_damage > 0) then
	{
		switch (true) do
		{
			case (_part == "legs")   : {BTC_r_damage_legs = BTC_r_damage_legs + (_damage * 1.5);BTC_r_damage = BTC_r_damage + (_damage / 3);};
			case (_part == "hand_l") : {BTC_r_damage_hands = BTC_r_damage_hands + _damage;BTC_r_damage = BTC_r_damage + (_damage / 3);};
			case (_part == "hand_2") : {BTC_r_damage_hands = BTC_r_damage_hands + _damage;BTC_r_damage = BTC_r_damage + (_damage / 3);};
			case (_part == "body")   : {BTC_r_damage = BTC_r_damage + ((_damage / 3) * 2);};
			case (_part == "head")   : {BTC_r_head = BTC_r_head + _damage;BTC_r_damage = BTC_r_damage + _damage;};
			case (_part == "" && BTC_r_hit != time)       : {BTC_r_damage = BTC_r_damage + (_damage / 2);};//What the hell
		};
	};
	if (Alive _unit && format ["%1", _unit getVariable "BTC_need_revive"] == "0") then
	{
		if (BTC_respawn_gear == 1) then {BTC_gear = [_unit] call BTC_get_gear;};
		if (BTC_r_damage > 1.5 || (BTC_r_head > 1.2)) then {if (BTC_r_wait_for_revive == 1) then {[_unit] spawn BTC_fnc_wait_for_revive;} else {_unit setDamage 1;};};
		if (!BTC_r_bleeding_loop && BTC_r_damage > 0.3) then {[_unit] spawn BTC_fnc_bleeding;};
		if (BTC_r_bleeding_loop && BTC_r_hit != time) then {_unit setVariable ["BTC_r_status",[(_unit getVariable "BTC_r_status" select 0),(((_unit getVariable "BTC_r_status") select 1) + (_damage)),(_unit getVariable "BTC_r_status" select 2),(_unit getVariable "BTC_r_status" select 3),(_unit getVariable "BTC_r_status" select 4)],false]};
	};
	if ((BTC_r_damage > 0.5 && ((_unit getVariable "BTC_r_status" select 2) != 1)) && (BTC_r_damage > 0.7 && ((_unit getVariable "BTC_r_status" select 4) != 1))) then {_unit setVariable ["BTC_r_status",[((_unit getVariable "BTC_r_status") select 0),(_unit getVariable "BTC_r_status" select 1),1,(_unit getVariable "BTC_r_status" select 3),1],true];}
	else
	{
		if (BTC_r_damage > 0.5 && ((_unit getVariable "BTC_r_status" select 2) != 1)) then {_unit setVariable ["BTC_r_status",[((_unit getVariable "BTC_r_status") select 0),(_unit getVariable "BTC_r_status" select 1),1,(_unit getVariable "BTC_r_status" select 3),(_unit getVariable "BTC_r_status" select 4)],true];};
		if (BTC_r_damage > 0.7 && ((_unit getVariable "BTC_r_status" select 3) != 1)) then {_unit setVariable ["BTC_r_status",[((_unit getVariable "BTC_r_status") select 0),(_unit getVariable "BTC_r_status" select 1),(_unit getVariable "BTC_r_status" select 2),(_unit getVariable "BTC_r_status" select 3),1],true];};
	};
	BTC_r_hit = time;
	_unit setDamage 0;
};
BTC_fnc_bleeding =
{
	_unit = _this select 0;
	BTC_r_bleeding_loop = true;
	BTC_r_unc = false;BTC_r_unc_loop = false;
	//titleText ["", "BLACK IN"];
	_timeout_bleed = time;
	_timeout_eff_mor = 0;
	_timeout_eff = time + 10;
	_timeout_mor   = 0;
	_unit setVariable ["BTC_r_status",[1,(_unit getVariable "BTC_r_status" select 1),(_unit getVariable "BTC_r_status" select 2),(_unit getVariable "BTC_r_status" select 3),(_unit getVariable "BTC_r_status" select 4)],true];
	hint "You're bleeding!";
	while {BTC_r_bleeding_loop} do
	{
		sleep 0.1;
		if (((_unit getVariable "BTC_r_status" select 0)) == 0 && ((_unit getVariable "BTC_r_status" select 1)) == 0 && (_unit getVariable "BTC_r_status" select 2) == 0) then {BTC_r_bleeding_loop = false;};
		//Bleeding
		if (((_unit getVariable "BTC_r_status" select 0)) == 1 && time > _timeout_bleed) then 
		{
			private ["_moving_ratio"];
			_moving_ratio = 1;
			if (speed player > 1 && speed player < 3) then {_moving_ratio = 1.01;};
			if (speed player >= 3 && speed player < 14) then {_moving_ratio = 1.02;};
			if (speed player >= 14) then {_moving_ratio = 1.03;};
			_unit setVariable ["BTC_r_status",[(_unit getVariable "BTC_r_status" select 0),((_unit getVariable "BTC_r_status") select 1) + (BTC_r_damage * _moving_ratio),(_unit getVariable "BTC_r_status" select 2),(_unit getVariable "BTC_r_status" select 3),(_unit getVariable "BTC_r_status" select 4)],true];
			_timeout_bleed = _timeout_bleed + 2;
			//SPEED
			// > 1 < 3 striscia
			// < 14 crouch
			// >= 14 corre
			//player sidechat format ["Bleeding: %1",((_unit getVariable "BTC_r_status") select 1)];
		};
		//modifica con appannamento
		if (time > _timeout_eff) then
		{
			private ["_n"];
			//if (((_unit getVariable "BTC_r_status") select 1) > 50 || ((_unit getVariable "BTC_r_status") select 0) == 1 || ((_unit getVariable "BTC_r_status") select 2) == 1) then {};
			if (((_unit getVariable "BTC_r_status") select 1) > 10) then
			{
				_n = 5 + ((100 - ((_unit getVariable "BTC_r_status") select 1))/10);
				//player sideChat "APP" + str(_n);
				titleText ["", "BLACK OUT",_n];
			};
			_timeout_eff = time + 7;
		};
		if (((_unit getVariable "BTC_r_status") select 1) == 0) then {titleText ["", "PLAIN"];};
		if (BTC_r_damage_legs > 0.45 || ((_unit getVariable "BTC_r_status") select 1) > 55) then {player forceWalk true;} else {player forceWalk false;};
		//morphine
		if ((_unit getVariable "BTC_r_status" select 2) == 1 && _timeout_mor == 0) then {_timeout_mor = time + 120;_timeout_eff_mor = time + 3;}; //else {_timeout_mor = 0;_timeout_eff_mor = 0;};
		if ((_unit getVariable "BTC_r_status" select 2) == 1 && time > _timeout_eff_mor) then {addCamShake [2,4,3];_timeout_eff_mor = time + 3;};
		//if ((BTC_r_damage > 1) && ((_unit getVariable "BTC_r_status" select 3) != 1)) then {_unit setVariable ["BTC_r_status",[((_unit getVariable "BTC_r_status") select 0),(_unit getVariable "BTC_r_status" select 1),(_unit getVariable "BTC_r_status" select 2),1],true];_timeout_mor = time + 120;};
		//medikit - perchè in base a BTC_r_damage? Solo se in attesa di revive oppure ferito armi e gambe
		//if ((((_unit getVariable "BTC_r_status") select 0) > 75) && (_unit getVariable "BTC_r_status" select 3) != 1) then {_unit setVariable ["BTC_r_status",[((_unit getVariable "BTC_r_status") select 0),(_unit getVariable "BTC_r_status" select 1),(_unit getVariable "BTC_r_status" select 2),1],true];};
		//Serve un medikit se ferito a gambe o braccia
		if (BTC_r_damage_legs > 0.50 && !BTC_r_med_effect) then
		{
			_unit setHit ["legs", 1];_unit setfatigue 1;_med = [] spawn BTC_r_wait_for_med;
		};
		if (BTC_r_damage_hands > 0.5 && !BTC_r_med_effect) then
		{
			_unit setHit ["hands", 1];_med = [] spawn BTC_r_wait_for_med;//_unit setfatigue 1;
		};
		//Passa al wait for revive o morte
		if (((_unit getVariable "BTC_r_status") select 1) >= 100) then {BTC_r_bleeding_loop = false;};
		//Può svenire se perde troppo sangue o per dolore
		if ((((_unit getVariable "BTC_r_status") select 1) > 65 || (time > _timeout_mor && _timeout_mor != 0)) && !BTC_r_unc) then 
		{
			if (((random 1.5) < (((_unit getVariable "BTC_r_status") select 1) / 100) && !BTC_r_unc) || (time > _timeout_mor)) then
			{
				if ((_unit getVariable "BTC_r_status" select 2) == 1 && !BTC_r_unc) then {_timeout_mor = time + 120;};
				_unit spawn
				{
					if (!BTC_r_unc && !BTC_r_unc_loop) then
					{
						BTC_r_unc = true;
						BTC_r_unc_loop = true;
						//ANIMATION DEAD
						//Placeholder
						if (vehicle _this == _this) then {_this switchMove "AmovPpneMstpSnonWnonDnon_relax";};
						disableUserInput true;
						titleText ["", "BLACK OUT"];
						sleep 1;
						titleText ["", "BLACK FADED"];
						for [{_n = (4 + random 6)}, {_n > 0 && ((_this getVariable "BTC_r_status") select 1) < 100 && BTC_r_bleeding_loop && _this getVariable "BTC_need_revive" == 0}, {_n = _n - 0.5}] do
						{
							//hint format ["Unconscious %1",_n];
							titleText ["", "BLACK FADED"];
							sleep 0.5;
						};
						disableUserInput false;BTC_r_unc_loop = false;
						titleText ["", "BLACK IN"];
						if (_this getVariable "BTC_need_revive" == 0) then
						{
							if (vehicle _this == _this) then {_this playMoveNow "AmovPpneMstpSnonWnonDnon_healed";};
							sleep 0.5;
							titleText ["", "PLAIN"];
							sleep 25;
						};
						BTC_r_unc = false;
					};
				};
			};
		};
	};
	BTC_r_bleeding_loop = false;
	if (((_unit getVariable "BTC_r_status") select 1) >= 100) then
	{
		if (BTC_r_wait_for_revive == 1) then
		{
			[_unit] spawn BTC_fnc_wait_for_revive;
		}
		else
		{
			_unit setDamage 1;
		};
	};
};
BTC_r_wait_for_med =
{
	BTC_r_med_effect = true;
	_state = player getVariable "BTC_r_status";
	player setVariable ["BTC_r_status",[(_state select 0),(_state select 1),(_state select 2),(_state select 3),1],true];	
	while {BTC_r_med_effect} do
	{
		if (BTC_r_damage_legs > 0.5) then
		{
			player setHit ["legs", 1];player forceWalk true;
			if (stance player != "PRONE") then 
			{
				switch (true) do
				{
					case (currentweapon player == "") : {player playmove "AmovPpneMstpSrasWnonDnon";};
					case (currentweapon player == handgunweapon player) : {player playmove "AmovPpneMstpSrasWpstDnon";};
					case (currentweapon player == primaryweapon player) : {player playmove "AmovPpneMstpSrasWrflDnon";};
					case (currentweapon player == secondaryweapon player) : {player playmove "AmovPpneMstpSrasWlnrDnon";};
				};
			};
		};
		if (BTC_r_damage_hands > 0.5) then
		{
			player setHit ["hands", 1];
		};
		if (BTC_r_damage_legs == 0 && BTC_r_damage_hands == 0) then {BTC_r_med_effect = false;};		
		sleep 2;
	};
	player forceWalk false;
};
BTC_eh_killed =
{
	_body = _this select 0;
	_body spawn
	{
		closeDialog 0;
		waitUntil {Alive player};
		deleteVehicle _this;
		player setcaptive false;
		player setVariable ["BTC_r_status",[0,0,0,0,0],true];
		player setVariable ["BTC_r_legs",0,false];
		player setVariable ["BTC_r_hands",0,false];
		closeDialog 0;
		BTC_r_bleeding_loop = false;
		BTC_r_med_effect = false;
		BTC_r_unc = false;
		BTC_r_damage = 0;
		BTC_r_head = 0;
		BTC_r_damage_legs = 0;
		BTC_r_damage_hands = 0;
		player setHit ["hands", 0];
		player setHit ["legs", 0];
		player setfatigue 0;
		player forceWalk false;
		_actions = [] spawn BTC_assign_actions;
		_respawn = [] spawn BTC_player_respawn;
		if (BTC_respawn_gear == 1) then 
		{
			_gear = [player,BTC_gear] spawn BTC_set_gear;
		};
	};
};
BTC_check_action_unit_state =
{
	private ["_injured","_array_item_injured"];
	_cond = false;
	_men = nearestObjects [vehicle player, ["Man"], 3];
	if (count _men > 1) then
	{
		if (!isNil {(_men select 1) getVariable "BTC_r_status"} && !BTC_dragging && format ["%1", (_men select 1) getVariable "BTC_dragged"] == "0") then {_cond = true;};
	};
	if (!BTC_r_action_menu) then {_cond = false;};
	_cond
};
BTC_check_unit_state =
{
	_unit = objNull;
	if (count _this == 0) then
	{
		_men = nearestObjects [vehicle player, ["Man"], 3];
		if (count _men > 1) then {_unit = _men select 1;};
	} else {_unit = player;};
	_var = _unit getVariable "BTC_r_status";
	_is_bleed = _var select 0;
	_bleeding = _var select 1;
	_mor      = _var select 2;
	_epi      = _var select 3;
	_med      = _var select 4;
	_text = format ["%1 ",name _unit];
	if (_is_bleed == 0) then {_text = _text + "is not bleeding. ";} else {_text = _text + "is bleeding and ";};
	if (_mor == 0) then {_text = _text + "He is not in pain. ";} else {_text = _text + "He is in pain and needs morphine. ";};
	if (_epi == 0) then {} else {_text = _text + "He needs epinephrine. ";};
	if (_med == 0) then {} else {_text = _text + "He needs a medikit. ";};
	hint _text;
	if (_is_bleed > 0 || _bleeding > 0 || _mor != 0 || _epi != 0 || _med != 0) then
	{
		BTC_r_unit_dlg = _unit;
		disableSerialization;
		_dlg = createDialog "BTC_state_dialog";
		_ui = uiNamespace getVariable "BTC_r_dialog";
		if (_is_bleed == 0) then {(_ui displayCtrl 91) ctrlShow false;};
		if (_bleeding == 0 || _is_bleed != 0) then {(_ui displayCtrl 96) ctrlShow false;};
		if (_mor == 0) then {(_ui displayCtrl 92) ctrlShow false;};
		if (_epi == 0) then {(_ui displayCtrl 93) ctrlShow false;};		
		if (format ["%1",BTC_r_unit_dlg getVariable "BTC_need_revive"] != "1") then {(_ui displayCtrl 94) ctrlShow false;};
		if (_med == 0 || _epi != 0 || _mor != 0 || _is_bleed != 0 || _bleeding != 0) then {(_ui displayCtrl 95) ctrlShow false;};
		waitUntil {!Alive player || !dialog || !Alive _unit || isNull _unit};
		closeDialog 0;
		BTC_r_unit_dlg = objNull;
	};
};
/*
BTC_check_state =
{
	while {(format ["%1",player getVariable "BTC_need_revive"] == "1") || (format ["%1",player getVariable "BTC_r_status"] != "[0,0,0]")} do
	{
		sleep 1;
	};
	if (player getVariable "BTC_need_revive" == 1) then {player setVariable ["BTC_need_revive",0,true];};
};*/
BTC_r_apply_bandage =
{
	private ["_array"];
	_cond = false;
	_array = (items player);
	switch (true) do
	{
		case (BTC_r_med_fa == 0) : {if (_array find "FirstAidKit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 1) : {if (_array find "FirstAidKit" != -1 || _array find "Medikit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 2) : {if (_array find "Medikit" != -1) then {_cond = true;};};
	};
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg && _cond) then
	{
		private ["_unit","_anim_1","_anim_2"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		if (BTC_r_action == 1) then
		{
		
			_anim_1 = "";_anim_2 = "";
			//AinvPknlMstpSnonWnonDnon_medic2 polvere down
			//AinvPknlMstpSnonWnonDnon_medic4 bendaggio down 
			if (format ["%1",_unit getVariable "BTC_need_revive"] == "1") then {};
			//"AinvPknlMstpSnonWnonDnon_medicUp2" polvere up
			//AinvPknlMstpSnonWnonDnon_medicUp0 non c'è di meglio per il bendaggio
			player playMove "AinvPknlMstpSnonWnonDnon_medic";
			sleep 5;
			if (!isNull _unit && format ["%1",player getVariable "BTC_need_revive"] == "0") then
			{
				if (_unit == player) then
				{

				}
				else 
				{
					private ["_name"];
					_name = name _unit;
					BTC_ban_pveh = [8,_name];publicVariable "BTC_ban_pveh";
				};
			};
		}
		else
		{
			private ["_pos","_timeout","_unc"];
			hint "Applying Bandage, do not move!";
			_pos = getpos _unit;
			_timeout = time + 8;
			_unc = false;
			while {_pos distance getPos _unit < 1 && time < _timeout && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit} do
			{
				if (BTC_r_unc_loop) then {_unc = true;};
				sleep 0.1;
			};
			if (_pos distance getPos _unit < 1 && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit && !_unc) then
			{
				private ["_state","_bleed"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[0,(_state select 1),(_state select 2),(_state select 3),(_state select 4)],true];
				hint "Bandage applied!";
			/*
				TRANSFUTION
				if (_unit == player) then
				{
					private ["_state","_bleed"];
					_state = (_unit getVariable "BTC_r_status");
					_bleed = (_state select 0) - 70;
					if (_bleed < 0) then {_bleed = 0;};
					if (_bleed == 0) then {BTC_is_bleeding = false;};
					_unit setVariable ["BTC_r_status",[(_state select 0),_bleed,(_state select 2),(_state select 3),(_state select 4)],true];
				}
				else 
				{
					private ["_name"];
					_name = name _unit;
					BTC_ban_pveh = [8,_name];publicVariable "BTC_ban_pveh";
				};*/
	
			} else {hint "Bandage could not be applied!";};		
		};
		switch (true) do
		{
			case (BTC_r_med_fa == 0) : {player removeItem "FirstAidKit";};
			case (BTC_r_med_fa == 1) : {if (_array find "Medikit" == -1) then {player removeItem "FirstAidKit";};};
		};
	};
	if (!_cond) then {hint "You don't have a first aid kit!";closeDialog 0;};
	BTC_r_action_menu = true;
};
BTC_r_apply_tra =
{
	_cond = false;
	_array = items player;
	switch (true) do
	{
		case (BTC_r_med_fa == 0) : {if (_array find "FirstAidKit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 1) : {if (_array find "FirstAidKit" != -1 || _array find "Medikit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 2) : {if (_array find "Medikit" != -1) then {_cond = true;};};
	};
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg && _cond) then
	{
		private ["_unit","_anim_1","_anim_2"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		if (BTC_r_action == 1) then
		{
		
		}
		else
		{
			private ["_pos","_timeout","_unc"];
			hint "Transfution, do not move!";
			_pos = getpos _unit;
			_timeout = time + 10;
			_unc = false;
			while {_pos distance getPos _unit < 1 && time < _timeout && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit} do
			{
				if (BTC_r_unc_loop) then {_unc = true;};
				sleep 0.1;
			};
			if (_pos distance getPos _unit < 1 && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit && !_unc) then
			{
				private ["_state","_bleed"];
				_state = (_unit getVariable "BTC_r_status");
				_bleed = (_state select 1) - BTC_r_trans_ratio;
				if (_bleed < 0) then {_bleed = 0;};
				_unit setVariable ["BTC_r_status",[(_state select 0),_bleed,(_state select 2),(_state select 3),(_state select 4)],true];
				hint "Transfution completed!";
			} else {hint "Transfution was not completed!";};		
		};
		switch (true) do
		{
			case (BTC_r_med_fa == 0) : {player removeItem "FirstAidKit";};
			case (BTC_r_med_fa == 1) : {if (_array find "Medikit" == -1) then {player removeItem "FirstAidKit";};};
		};
	};
	if (!_cond) then {hint "You don't have a first aid kit!";closeDialog 0;};
	BTC_r_action_menu = true;
};
BTC_r_apply_mor =
{
	_cond = false;
	_array = items player;
	switch (true) do
	{
		case (BTC_r_med_fa == 0) : {if (_array find "FirstAidKit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 1) : {if (_array find "FirstAidKit" != -1 || _array find "Medikit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 2) : {if (_array find "Medikit" != -1) then {_cond = true;};};
	};
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg && _cond) then
	{
		private ["_unit"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		if (BTC_r_action == 1) then
		{	
			player playMove "AinvPknlMstpSnonWnonDnon_medicUp0";
			//ainvpknlmstpslaywrfldnon_medic self morphine
			//Up AinvPknlMstpSnonWnonDnon_medicUp3
			// morto AinvPknlMstpSnonWnonDnon_medic3
			sleep 5;			
			if (!isNull _unit && format ["%1",player getVariable "BTC_need_revive"] == "0") then
			{
				private ["_state"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),0,(_state select 3),(_state select 4)],true];
			};
		}
		else
		{
			private ["_pos","_timeout","_unc"];
			hint "Applying Morphine, do not move!";
			_pos = getpos _unit;
			_timeout = time + 6;
			_unc = false;
			while {_pos distance getPos _unit < 1 && time < _timeout && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit} do
			{
				if (BTC_r_unc_loop) then {_unc = true;};
				sleep 0.1;
			};
			if (_pos distance getPos _unit < 1 && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit && !_unc) then
			{
				private ["_state"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),0,(_state select 3),(_state select 4)],true];
				hint "Morphine applied!";				
			} else {hint "Morphine could not be applied!";};
		};
		switch (true) do
		{
			case (BTC_r_med_fa == 0) : {player removeItem "FirstAidKit";};
			case (BTC_r_med_fa == 1) : {if (_array find "Medikit" == -1) then {player removeItem "FirstAidKit";};};
		};
	};
	if (!_cond) then {hint "You don't have a first aid kit!";closeDialog 0;};
	BTC_r_action_menu = true;
};
BTC_r_apply_epi =
{
	_cond = false;
	_array = items player;
	switch (true) do
	{
		case (BTC_r_med_fa == 0) : {if (_array find "FirstAidKit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 1) : {if (_array find "FirstAidKit" != -1 || _array find "Medikit" != -1) then {_cond = true;};};
		case (BTC_r_med_fa == 2) : {if (_array find "Medikit" != -1) then {_cond = true;};};
	};
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg && _cond) then
	{
		private ["_unit"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		if (BTC_r_action == 1) then
		{
			player playMove "AinvPknlMstpSnonWnonDnon_medicUp0";
			sleep 5;
			if (!isNull _unit && format ["%1",player getVariable "BTC_need_revive"] == "0") then
			{
				private ["_state"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),(_state select 2),0,(_state select 4)],true];
			};
		}
		else
		{
			private ["_pos","_timeout","_unc"];
			hint "Applying epi, do not move!";
			_pos = getpos _unit;
			_timeout = time + 6;
			_unc = false;
			while {_pos distance getPos _unit < 1 && time < _timeout && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit} do
			{
				if (BTC_r_unc_loop) then {_unc = true;};
				sleep 0.1;
			};
			if (_pos distance getPos _unit < 1 && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit && !_unc) then
			{
				private ["_state"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),(_state select 2),0,(_state select 4)],true];
				hint "Epi applied!";
			} else {hint "Epi could not be applied!";};			
		};
		switch (true) do
		{
			case (BTC_r_med_fa == 0) : {player removeItem "FirstAidKit";};
			case (BTC_r_med_fa == 1) : {if (_array find "Medikit" == -1) then {player removeItem "FirstAidKit";};};
		};
	};
	if (!_cond) then {hint "You don't have a first aid kit!";closeDialog 0;};
	BTC_r_action_menu = true;
};
BTC_r_apply_cpr =
{
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg) then
	{
		private ["_unit","_cpr_bonus","_name"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		player playMove "AinvPknlMstpSnonWnonDr_medic0";//CPR
		_cpr_bonus = BTC_r_cpr_time / 10;
		_name = name _unit;
		BTC_cpr_pveh = [7,_name,_cpr_bonus];publicVariable "BTC_cpr_pveh";
		sleep 7;
		player playMove "AinvPknlMstpSnonWnonDr_medic0";
		sleep 7;
		if (!isNull _unit && _unit getVariable "BTC_need_revive" == 1 && _unit != player && !BTC_r_unc_loop) then
		{
			_cpr_bonus = BTC_r_cpr_time - (BTC_r_cpr_time / 10);
			BTC_cpr_pveh = [7,_name,_cpr_bonus];publicVariable "BTC_cpr_pveh";
		};
	};
	BTC_r_action_menu = true;
};
BTC_r_apply_med =
{
	_cond = false;
	if (BTC_need_first_aid == 1) then
	{
		private ["_array"];
		_array = items player;
		if (_array find "Medikit" != -1) then {_cond = true;};
	} else {_cond = true;};
	//if (getNumber (configFile >> "CfgVehicles" >> (typeOf player) >> "attendant") != 1) then {_cond = false;};
	BTC_r_action_menu = false;
	if (!isNull BTC_r_unit_dlg && _cond) then
	{
		private ["_unit"];
		_unit = BTC_r_unit_dlg;
		closeDialog 0;
		if (BTC_r_action == 1) then
		{
			player playMove "AinvPknlMstpSnonWnonDr_medic0";//CPR
			sleep 5;
			if (!isNull _unit && _unit getVariable "BTC_need_revive" == 1 && _unit != player && format ["%1",player getVariable "BTC_need_revive"] == "0") then
			{
				private ["_state"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),(_state select 2),(_state select 3),0],true];					
			};
		}
		else
		{
			private ["_pos","_timeout","_unc"];
			hint "Applying medikit, do not move!";
			_pos = getpos _unit;
			_timeout = time + 10;
			_unc = false;
			while {_pos distance getPos _unit < 1 && time < _timeout && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit} do
			{
				if (BTC_r_unc_loop) then {_unc = true;};
				sleep 0.1;
			};
			if (_pos distance getPos _unit < 1 && !isNull _unit && player getVariable "BTC_need_revive" == 0 && Alive _unit && !_unc) then
			{
				private ["_state","_name"];
				_state = (_unit getVariable "BTC_r_status");
				_unit setVariable ["BTC_r_status",[(_state select 0),(_state select 1),(_state select 2),(_state select 3),0],true];
				if (_unit == player) then {BTC_r_damage = 0;BTC_r_head = 0;BTC_r_damage_legs = 0;BTC_r_damage_hands = 0;_unit forceWalk false;_unit setHit ["legs", 0];_unit setHit ["hands", 0];BTC_r_med_effect = false;} else {_name = name _unit;BTC_med_pveh = [9,_name];publicVariable "BTC_med_pveh";};
				hint "Medikit applied!";
			} else {hint "Medikit could not be applied!";};			
		};
	};
	if (!_cond) then {hint "You don't have a Medikit!";closeDialog 0;};
	//if (!_cond && getNumber (configFile >> "CfgVehicles" >> (typeOf player) >> "attendant") != 1) then {hint "You are not a medic!";};
	BTC_r_action_menu = true;
};
BTC_fnc_wait_for_revive =
{
	_unit = player;
	BTC_r_bleeding_loop = false;
	_unit setVariable ["BTC_r_status",[1,100,1,1,1],true];
	BTC_r_damage = 0.5;
	_unit setVariable ["BTC_need_revive",1,true];
	[] spawn
	{
		waitUntil {BTC_respawn_cond || ((player getVariable "BTC_r_status") select 0 == 0 && (player getVariable "BTC_r_status") select 1 == 0 && (player getVariable "BTC_r_status") select 2 == 0 && (player getVariable "BTC_r_status") select 3 == 0)};
		player setVariable ["BTC_need_revive",0,true];
		closedialog 0;
		titleText ["", "PLAIN"];
	};
	//DEAD ANIMATION WITH RAGDOLL
	//Placeholder //player switchMove "acts_InjuredAngryRifle01"
	player switchMove "AinjPpneMstpSnonWrflDnon";
	//BTC_killed_pveh = [10,_unit,"AinjPpneMstpSnonWrflDnon"];publicVariable "BTC_killed_pveh";
	player setcaptive true;

	BTC_killed_pveh = [2,_unit];publicVariable "BTC_killed_pveh";	
	sleep 1;
	player switchMove "AinjPpneMstpSnonWrflDnon";
	WaitUntil {animationstate player == "AinjPpneMstpSnonWrflDnon"};
	_pos = getPos player;
	if (BTC_injured_marker == 1) then {BTC_marker_pveh = [0,BTC_side,_pos,_unit];publicVariable "BTC_marker_pveh";};
	BTC_r_timeout = time + BTC_revive_time_max;
	private ["_id","_lifes"];
	BTC_respawn_cond = false;
	//BTC_display_EH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_anim = [] spawn {sleep 1;player switchMove ""AinjPpneMstpSnonWrflDnon"";};"];
	//player enableSimulation false;
	if (BTC_black_screen == 0 && BTC_disable_respawn == 0) then {if (BTC_action_respawn == 0) then {disableSerialization;_dlg = createDialog "BTC_respawn_button_dialog";} else {_id = player addAction [("<t color=""#ED2744"">") + ("Respawn") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_player_respawn], 9, true, true, "", "true"];};};
	if (BTC_black_screen == 1 && BTC_disable_respawn == 0 && !Dialog) then {_dlg = createDialog "BTC_respawn_button_dialog";};
	player switchMove "AinjPpneMstpSnonWrflDnon";
	while {format ["%1", player getVariable "BTC_need_revive"] == "1" && time < BTC_r_timeout && !BTC_respawn_cond} do
	{
		//if (BTC_disable_respawn == 0) then {if (BTC_black_screen == 1 || (BTC_black_screen == 0 && BTC_action_respawn == 0)) then {if (!Dialog && !BTC_respawn_cond) then {_dlg = createDialog "BTC_respawn_button_dialog";};};};
		if (BTC_disable_respawn == 0) then {if (BTC_black_screen == 1 || (BTC_black_screen == 0 && BTC_action_respawn == 0)) then {if (!Dialog && !BTC_respawn_cond) then {_dlg = createDialog "BTC_respawn_button_dialog";};};};
		_healer = call BTC_check_healer;
		_lifes = "";
		if (BTC_active_lifes == 1) then {_lifes = format ["Lifes remaining: %1",BTC_lifes];};
		if (BTC_black_screen == 1) then {titleText [format ["%1\n%2\n%3", round (BTC_r_timeout - time),_healer,_lifes], "BLACK FADED"]} else {hintSilent format ["%1\n%2\n%3", round (BTC_r_timeout - time),_healer,_lifes];};
		if (format ["%1", player getVariable "BTC_need_revive"] == "0") then {closeDialog 0;};
		sleep 0.5;
	};
	//diag_log text format ["WHY!!!",""];diag_log text format ["%1 %2 %3",format ["%1", player getVariable "BTC_need_revive"] == "1" , time < BTC_r_timeout , !BTC_respawn_cond];
	closedialog 0;
	//(findDisplay 46) displayRemoveEventHandler ["KeyDown",BTC_display_EH];
	//player enableSimulation true;
	if (time > BTC_r_timeout && format ["%1", player getVariable "BTC_need_revive"] == "1") then 
	{
		player setDamage 1;
	};
	if (format ["%1", player getVariable "BTC_need_revive"] == "0" && !BTC_respawn_cond) then 
	{
		if (BTC_black_screen == 1) then {titleText ["", "BLACK IN"];} else {hintSilent "";};
		player switchMove "AinjPpneMstpSnonWnonDnon_rolltofront";
		closedialog 0;
		sleep 2;
		player playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		closedialog 0;
	};
	if (BTC_black_screen == 0 && BTC_action_respawn == 1 && BTC_disable_respawn == 0) then {_unit removeAction _id;};
	player setcaptive false;
	hintSilent "";	
};
BTC_fnc_PVEH =
{
	//0 - first aid - create // [0,east,pos]
	//1 - first aid - delete
	_array = _this select 1;
	_type  = _array select 0;
	switch (true) do
	{
		case (_type == 0) : 
		{
			_side = _array select 1;
			_unit = _array select 3;
			if (_side == BTC_side) then 
			{
				_pos = _array select 2;
				_marker = createmarkerLocal [format ["FA_%1", _pos], _pos];
				format ["FA_%1", _pos] setmarkertypelocal "mil_box";
				format ["FA_%1", _pos] setMarkerTextLocal format ["F.A. %1", name _unit];
				format ["FA_%1", _pos] setmarkerColorlocal "ColorGreen";
				format ["FA_%1", _pos] setMarkerSizeLocal [0.3, 0.3];
				[_pos,_unit] spawn
				{
					_pos  = _this select 0;
					_unit = _this select 1;
					while {(!(isNull _unit) && (format ["%1", _unit getVariable "BTC_need_revive"] == "1"))} do
					{
						format ["FA_%1", _pos] setMarkerPosLocal getpos _unit;
						sleep 1;
					};
					deleteMarker format ["FA_%1", _pos];
				};
			};
		};
		case (_type == 1) : {(_array select 1) setDir 180;(_array select 1) playMoveNow "AinjPpneMstpSnonWrflDb_grab";};
		case (_type == 2) : 
		{
			private ["_injured"];
			_injured = (_array select 1);
			[_injured] spawn
			{
				_injured = _this select 0;
				_injured allowDamage false;
				WaitUntil {sleep 1; (isNull _injured) || (format ["%1", _injured getVariable "BTC_need_revive"] == "0")};
				_injured allowDamage true;
			};
		};
		case (_type == 3) : 
		{
			private ["_injured","_veh"];
			_injured = (_array select 1);
			_veh     = (_array select 2);
			if (name _injured == name player) then {_injured moveInCargo _veh};
		};
		case (_type == 4) : 
		{
			private ["_array_injured"];
			_array_injured = (_array select 1);
			{
				if (name player == name _x) then {unAssignVehicle player;player action ["eject", vehicle player];_spawn = [] spawn {sleep 0.5;player switchMove "ainjppnemstpsnonwrfldnon";};};
			} foreach _array_injured;
		};
		case (_type == 5) : 
		{
			private ["_array_injured"];
			_spawn = [(_array select 1),(_array select 2)] spawn
			{
				_injured = _this select 0;
				_healer  = _this select 1;
				_injured setPos (_healer modelToWorld [0,1,0]);				
				_injured setDir (getDir _healer + 180);
				_injured switchMove "AinjPfalMstpSnonWnonDnon_carried_up";
				WaitUntil {!Alive _healer || ((animationstate _healer == "acinpercmstpsraswrfldnon") || (animationstate _healer == "acinpercmrunsraswrfldf") || (animationstate _healer == "acinpercmrunsraswrfldr") || (animationstate _healer == "acinpercmrunsraswrfldl"))};
				_injured switchMove "AinjPfalMstpSnonWnonDf_carried_dead";
				sleep 0.2;
				_injured setDir 180;
			};
		};
		case (_type == 6) : 
		{
			private ["_array_injured"];
			_spawn = [(_array select 1)] spawn
			{
				(_this select 0) switchMove "AinjPfalMstpSnonWrflDnon_carried_down";
				sleep 3;
				if (format ["%1",(_this select 0) getVariable "BTC_need_revive"] == "1") then {(_this select 0) switchMove "ainjppnemstpsnonwrfldnon";};
			};
		};
		case (_type == 7) : 
		{
			private ["_injured","_cpr_bonus"];
			_injured = _array select 1;
			_cpr_bonus = _array select 2;
			if (name player == _injured) then {BTC_r_timeout = BTC_r_timeout + _cpr_bonus;};
		};
		case (_type == 8) : 
		{
			private ["_injured"];
			_injured = _array select 1;
			if (name player == _injured) then 
			{
				private ["_state","_bleed"];
				_state = (_injured getVariable "BTC_r_status");
				_bleed = (_state select 0) - 70;
				if (_bleed < 0) then {_bleed = 0;};
				_injured setVariable ["BTC_r_status",[0,_bleed,(_state select 2),(_state select 3),(_state select 4)],true];			
			};
		};
		case (_type == 9) : 
		{
			private ["_injured"];
			_injured = _array select 1;
			if (name player == _injured) then 
			{
				private ["_state","_bleed"];
				BTC_r_damage = 0;BTC_r_head = 0;BTC_r_damage_legs = 0;BTC_r_damage_hands = 0;player forceWalk false;BTC_r_med_effect = false;player setHit ["legs", 0];player setHit ["hands", 0];
			};
		};
		case (_type == 10) : 
		{
			private ["_injured"];
			_unit = _array select 1;
			_anim = _array select 2;
			_unit switchMove _anim;
		};
	};
};
BTC_first_aid =
{
	private ["_injured","_array_item_injured","_array_item","_cond"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	_array_item = items player;
	_array_item_injured = items _injured;
	_cond = false;
	if (BTC_need_first_aid == 0) then {_cond = true;};
	if ((_array_item_injured find "FirstAidKit" == -1) && (BTC_need_first_aid == 1)) then {_cond = false;} else {_cond = true;};
	if (!_cond && BTC_need_first_aid == 1) then {if ((_array_item find "FirstAidKit" == -1)) then {_cond = false;} else {_cond = true;};};
	if (!_cond) exitWith {hint "Can't revive him";};
	if (BTC_need_first_aid == 1) then {if (_array_item_injured find "FirstAidKit" == -1) then {player removeItem "FirstAidKit";};};
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;
	waitUntil {!Alive player || (animationState player != "AinvPknlMstpSlayWrflDnon_medic" && animationState player != "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon" && animationState player != "amovpknlmstpsraswrfldnon_ainvpknlmstpslaywrfldnon" && animationState player != "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon")};
	if (Alive player && Alive _injured && format ["%1",player getVariable "BTC_need_revive"] == "0") then
	{
		_injured setVariable ["BTC_need_revive",0,true];
		_injured playMoveNow "AinjPpneMstpSnonWrflDnon_rolltoback";
	};
};
BTC_drag =
{
	private ["_injured"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	BTC_dragging = true;
	_injured setVariable ["BTC_dragged",1,true];
	_injured attachTo [player, [0, 1.1, 0.092]];
	player playMoveNow "AcinPknlMstpSrasWrflDnon";
	_id = player addAction [("<t color=""#ED2744"">") + ("Drop") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_release], 9, true, true, "", "true"];
	//_injured playMoveNow "AinjPpneMstpSnonWrflDb_grab";
	BTC_drag_pveh = [1,_injured];publicVariable "BTC_drag_pveh";
	WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))};
	private ["_act","_veh_selected","_array","_array_veh","_name_veh","_text_action","_action_id"];
	_act = 0;_veh_selected = objNull;_array_veh = [];
	while {!isNull player && alive player && !isNull _injured && alive _injured && format ["%1", _injured getVariable "BTC_need_revive"] == "1" && BTC_dragging} do
	{
		_array = nearestObjects [player, ["Air","LandVehicle"], 5];
		_array_veh = [];
		{if (_x emptyPositions "cargo" != 0) then {_array_veh = _array_veh + [_x];};} foreach _array;
		if (count _array_veh == 0) then {_veh_selected = objNull;};
		if (count _array_veh > 0 && _veh_selected != _array_veh select 0) then 
		{
			_veh_selected    = _array_veh select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh_selected >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load wounded in " + (_name_veh) + "</t>");
			_action_id = player addAction [_text_action,"=BTC=_revive\=BTC=_addAction.sqf",[[_injured,_veh_selected],BTC_load_in], 7, true, true];
			_act  = 1;
		};
		if (count _array_veh == 0 && _act == 1) then {player removeAction _action_id;_act = 0;};
		sleep 0.1;
	};
	if (_act == 1) then {player removeAction _action_id;};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";
	_injured setVariable ["BTC_dragged",0,true];
	if (format ["%1",_injured getVariable "BTC_need_revive"] == "1") then {detach _injured;_injured playMoveNow "AinjPpneMstpSnonWrflDb_release";};
	player removeAction _id;
	BTC_dragging = false;
};
BTC_carry =
{
	private ["_injured"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	BTC_dragging = true;
	_healer = player;
	_injured setVariable ["BTC_dragged",1,true];
	detach _injured;
	player playMoveNow "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon";
	_id = player addAction [("<t color=""#ED2744"">") + ("Drop") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_release], 9, true, true, "", "true"];
	BTC_carry_pveh = [5,_injured,_healer];publicVariable "BTC_carry_pveh";
	WaitUntil {!Alive player || ((animationstate player == "acinpercmstpsraswrfldnon") || (animationstate player == "acinpercmrunsraswrfldf") || (animationstate player == "acinpercmrunsraswrfldr") || (animationstate player == "acinpercmrunsraswrfldl"))};
	_injured attachto [player,[0.15, 0.15, 0]];_injured setDir 180;
	private ["_act","_veh_selected","_array","_array_veh","_name_veh","_text_action","_action_id"];
	_act = 0;_veh_selected = objNull;_array_veh = [];
	while {!isNull player && alive player && !isNull _injured && alive _injured && format ["%1", _injured getVariable "BTC_need_revive"] == "1" && BTC_dragging} do
	{
		_array = nearestObjects [player, ["Air","LandVehicle"], 5];
		_array_veh = [];
		{if (_x emptyPositions "cargo" != 0) then {_array_veh = _array_veh + [_x];};} foreach _array;
		if (count _array_veh == 0) then {_veh_selected = objNull;};
		if (count _array_veh > 0 && _veh_selected != _array_veh select 0) then 
		{
			_veh_selected    = _array_veh select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh_selected >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load wounded in " + (_name_veh) + "</t>");
			_action_id = player addAction [_text_action,"=BTC=_revive\=BTC=_addAction.sqf",[[_injured,_veh_selected],BTC_load_in], 7, true, true];
			_act  = 1;
		};
		if (count _array_veh == 0 && _act == 1) then {player removeAction _action_id;_act = 0;};
		sleep 0.1;
	};
	if (_act == 1) then {player removeAction _action_id;};
	player playAction "released";
	_injured switchMove "AinjPfalMstpSnonWrflDnon_carried_down";
	BTC_carry_pveh = [6,_injured];publicVariable "BTC_carry_pveh";
	detach _injured;
	_injured setVariable ["BTC_dragged",0,true];
	player removeAction _id;
	BTC_dragging = false;
};
BTC_release =
{
	BTC_dragging = false;
};
BTC_load_in =
{
	_injured = _this select 0;
	_veh     = _this select 1;
	BTC_dragging = false;
	BTC_load_pveh = [3,_injured,_veh];publicVariable "BTC_load_pveh";
};
BTC_pull_out =
{
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	_array_injured = [];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_array_injured = _array_injured + [_x];};
		} foreach crew (_array select 0);
	};
	BTC_pullout_pveh = [4,_array_injured];publicVariable "BTC_pullout_pveh";
};
BTC_pull_out_check =
{
	_cond = false;
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_cond = true;};
		} foreach crew (_array select 0);
	};
	_cond
};
BTC_player_killed =
{
	private ["_type_backpack","_weapons","_magazines","_weapon_backpack","_ammo_backpack","_score","_score_array","_name","_body_marker","_ui"];
	titleText ["", "BLACK OUT"];
	_body = _this select 0;
	[_body] spawn
	{
		_body = _this select 0;
		_dir = getDir _body;
		_pos = getPosATL vehicle _body;
		if (BTC_lifes != 0 || BTC_active_lifes == 0) then
		{
			WaitUntil {Alive player};
			detach player;
			//player setPos [getMarkerPos BTC_respawn_marker select 0, getMarkerPos BTC_respawn_marker select 1, 5000];
			_body_marker = player;
			player setcaptive true;
			BTC_r_camera_nvg = false;
			BTC_killed_pveh = [2,_body_marker];publicVariable "BTC_killed_pveh";player allowDamage false;
			player setVariable ["BTC_need_revive",1,true];
			player switchMove "AinjPpneMstpSnonWrflDnon";
			_actions = [] spawn BTC_assign_actions;
			if (BTC_respawn_gear == 1) then 
			{
				_gear = [player,BTC_gear] spawn BTC_set_gear;
			};
			WaitUntil {animationstate player == "ainjppnemstpsnonwrfldnon"};
			sleep 2;
			player setDir _dir;
			player setVelocity [0,0,0];
			player setPosATL _pos;
			deletevehicle _body;
			_side = playerSide;
			_injured = player;
			if (BTC_injured_marker == 1) then {BTC_marker_pveh = [0,BTC_side,_pos,_body_marker];publicVariable "BTC_marker_pveh";};
			disableUserInput true;
			for [{_n = BTC_revive_time_min}, {_n != 0 && damage player > 0.2}, {_n = _n - 0.5}] do
			{
				if (BTC_active_lifes == 1) then {titleText [format ["Lifes remaining: %1",BTC_lifes], "BLACK FADED"];} else {titleText ["", "BLACK FADED"];};
				sleep 0.5;
			};
			if (BTC_black_screen == 0) then {titleText ["", "BLACK IN"];};
			disableUserInput false;
			_time = time;
			_timeout = _time + BTC_revive_time_max;
			private ["_id","_lifes"];
			BTC_respawn_cond = false;
			if (BTC_disable_respawn == 1) then {player enableSimulation false;};
			_id = player addAction [("<t color=""#ED2744"">") + ("Respawn") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_player_respawn], 9, true, true, "", "true"];
			if (BTC_camera_unc == 0) then
			{
				if (BTC_black_screen == 0 && BTC_disable_respawn == 0) then {if (BTC_action_respawn == 0) then {disableSerialization;_dlg = createDialog "BTC_respawn_button_dialog";};};
				if (BTC_black_screen == 1 && BTC_disable_respawn == 0 && !Dialog) then {_dlg = createDialog "BTC_respawn_button_dialog";};
				BTC_display_EH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_anim = [] spawn {sleep 1;player switchMove ""AinjPpneMstpSnonWrflDnon"";};"];
			}
			else
			{
				BTC_r_u_camera = "camera" camCreate (position player);
				BTC_r_u_camera camSetTarget player;
				BTC_r_u_camera cameraEffect ["internal", "BACK"];
				BTC_r_u_camera camSetPos [(getpos player select 0) + 15,(getpos player select 1) + 15,10];
				BTC_r_u_camera camCommit 0;
				disableSerialization;
				_r_dlg = createDialog "BTC_spectating_dialog";
				_ui = uiNamespace getVariable "BTC_r_spectating";
				(_ui displayCtrl 120) ctrlShow false;
				BTC_r_camera_EH_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_keydown = _this spawn BTC_r_s_keydown"];
				{_lb = lbAdd [121,_x];if (_x == BTC_camera_unc_type select 0) then {lbSetCurSel [121,_lb];}} foreach BTC_camera_unc_type;
			};
			while {format ["%1", player getVariable "BTC_need_revive"] == "1" && time < _timeout && !BTC_respawn_cond} do
			{
				if (BTC_disable_respawn == 0) then {if (BTC_black_screen == 1 || (BTC_black_screen == 0 && BTC_action_respawn == 0)) then {if (!Dialog && !BTC_respawn_cond) then {_dlg = createDialog "BTC_respawn_button_dialog";};};};
				_healer = call BTC_check_healer;
				_lifes = "";
				if (BTC_active_lifes == 1) then {_lifes = format ["Lifes remaining: %1",BTC_lifes];};
				if (BTC_black_screen == 1 && BTC_camera_unc == 0) then {titleText [format ["%1\n%2\n%3", round (_timeout - time),_healer,_lifes], "BLACK FADED"]} else {hintSilent format ["%1\n%2\n%3", round (_timeout - time),_healer,_lifes];};
				if (BTC_camera_unc == 1) then 
				{
					titleText [format ["%1\n%2\n%3", round (_timeout - time),_healer,_lifes], "PLAIN DOWN"];
					if (!dialog) then {disableSerialization;_r_dlg = createDialog "BTC_spectating_dialog";sleep 0.01;_ui = uiNamespace getVariable "BTC_r_spectating";(_ui displayCtrl 120) ctrlShow false;{_lb = lbAdd [121,_x];if (_x == BTC_camera_unc_type select 0) then {lbSetCurSel [121,_lb];}} foreach BTC_camera_unc_type;};
					BTC_r_u_camera attachTo [player,BTC_r_s_cam_view];
					BTC_r_u_camera camCommit 0;
					if (BTC_r_camera_nvg) then {camusenvg true;} else {camusenvg false;};				
				};
				//sleep 0.5;
			};
			if (BTC_camera_unc == 0) then
			{
				(findDisplay 46) displayRemoveEventHandler ["KeyDown",BTC_display_EH];
			}
			else
			{
				player cameraEffect ["TERMINATE", "BACK"];
				camDestroy BTC_r_u_camera;	
				BTC_r_u_camera = objNull;
				(findDisplay 46) displayRemoveEventHandler ["KeyDown",BTC_r_camera_EH_keydown];
			};
			closedialog 0;
			if (time > _timeout && format ["%1", player getVariable "BTC_need_revive"] == "1") then 
			{
				_respawn = [] spawn BTC_player_respawn;
			};
			if (format ["%1", player getVariable "BTC_need_revive"] == "0" && !BTC_respawn_cond) then 
			{
				if (BTC_black_screen == 1) then {titleText ["", "BLACK IN"];} else {hintSilent "";};
				if (BTC_need_first_aid == 1 && ((items player) find "FirstAidKit" != -1)) then {player removeItem "FirstAidKit";};
				player playMove "amovppnemstpsraswrfldnon";
				player playMove "";
			};
			player removeAction _id;
			player setcaptive false;
			if (BTC_disable_respawn == 1) then {player enableSimulation true;};
			//player setvehicleInit "this allowDamage true;";ProcessInitCommands;
			player switchMove "";
			player allowDamage true;
			hintSilent "";
		};
	};
};
BTC_check_healer =
{
	_pos = getpos player;
	_men = [];_veh = [];_dist = 501;_healer = objNull;_healers = [];
	_msg = "No medics nearby.";
	_men = nearestObjects [_pos, BTC_who_can_revive, 500];
	_veh = nearestObjects [_pos, ["LandVehicle", "Air", "Ship"], 500];
	{
		{private ["_man"];_man = _x;if (isPlayer _man && ({_man isKindOf _x} count BTC_who_can_revive) > 0) then {_men = _men + [_man];};} foreach crew _x;
	} foreach _veh;
	if (count _men > 0) then
	{
		{if (Alive _x && format ["%1",_x getVariable "BTC_need_revive"] != "1" && ([_x,player] call BTC_can_revive) && isPlayer _x && side _x == BTC_side) then {_healers = _healers + [_x];};} foreach _men;
		if (count _healers > 0) then
		{
			{
				if (_x distance _pos < _dist) then {_healer = _x;_dist = _x distance _pos;};
			} foreach _healers;
			if !(isNull _healer) then {_msg = format ["%1 could heal you! He is %2 m away!", name _healer,round(_healer distance _pos)];};
		};
	};
	_msg
};
BTC_player_respawn =
{
	BTC_respawn_cond = true;
	if (BTC_active_lifes == 1) then {BTC_lifes = BTC_lifes - 1;};
	if (BTC_active_lifes == 1 && BTC_lifes == 0) exitWith BTC_out_of_lifes;
	if (BTC_active_lifes != 1 || BTC_lifes != 0) then
	{
		deTach player;
		player setVariable ["BTC_need_revive",0,true];
		closeDialog 0;
		if (BTC_black_screen == 0) then {titleText ["", "BLACK OUT"];};
		sleep 0.2;
		titleText ["", "BLACK FADED"];
		if (vehicle player != player) then {unAssignVehicle player;player action ["eject", vehicle player];};
		player setPos getMarkerPos BTC_respawn_marker;
		sleep 1;
		closeDialog 0;
		player setDamage 0;
		player switchMove "amovpercmstpslowwrfldnon";
		player switchMove "";
		if (BTC_respawn_time > 0) then
		{
			player enableSimulation false;
			player attachTo [BTC_r_base_spawn,[0,0,6000]];
			//player setVelocity [0,0,0];
			sleep 1;
			private ["_n"];
			for [{_n = BTC_respawn_time}, {_n != 0}, {_n = _n - 1}] do
			{
				private ["_msg"];
				//player enableSimulation false;
				//player setpos [0,0,6000];
				//player setVelocity [0,0,0];
				titleText [format ["Respawn in %1",_n], "BLACK FADED"];
				sleep 1;
			};
		};
		player setVariable ["BTC_need_revive",0,true];
		closeDialog 0;
		sleep 0.1;
		BTC_respawn_cond = false;
		if (BTC_dlg_on_respawn != 0) then 
		{
			_dlg = [] spawn BTC_r_create_dialog_mobile;
		} 
		else 
		{
			player attachTo [BTC_r_base_spawn,[0,0,0]];
			sleep 0.1;
			deTach player;
			player setVelocity [0,0,0];
			player setPos getMarkerPos BTC_respawn_marker;
			player enableSimulation true;
			player switchMove "amovpercmstpsraswrfldnon";
			player switchMove "";//amovpercmstpsraswrfldnon		
			if (BTC_black_screen == 1 && BTC_respawn_time == 0) then {titleText ["", "BLACK IN"];sleep 2;titleText ["", "PLAIN"];};
			if (BTC_black_screen == 0 || BTC_respawn_time > 0) then 
			{	
				titleText ["", "BLACK IN"];
				sleep 2;
				titleText ["", "PLAIN"];
			};
		};
	};
};
BTC_check_action_first_aid =
{
	private ["_injured","_array_item_injured"];
	_cond = false;
	_array_item = items player;
	_men = nearestObjects [vehicle player, ["Man"], 2];
	if (count _men > 1 && format ["%1", player getVariable "BTC_need_revive"] == "0") then
	{
		if (format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging && format ["%1", (_men select 1) getVariable "BTC_dragged"] == "0") then {_cond = true;};
		_injured = _men select 1;
	};
	if (_cond && BTC_pvp == 1) then 
	{
		if ((_men select 1) getVariable "BTC_revive_side" == str (BTC_side)) then {_cond = true;} else {_cond = false;};
	};
	if (_cond && BTC_need_first_aid == 1) then
	{
		
		if (_array_item find "FirstAidKit" == -1) then {_cond = false;};
		_array_item_injured = items _injured;
		if (!_cond && _array_item_injured find "FirstAidKit" != -1) then {_cond = true;};
	};
	_cond
};
BTC_check_action_drag =
{
	_cond = false;
	_men = nearestObjects [vehicle player, ["Man"], 2];
	if (count _men > 1) then
	{
		if (BTC_pvp == 1) then
		{
			if (side (_men select 1) == BTC_side && format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging && format ["%1", (_men select 1) getVariable "BTC_dragged"] == "0") then {_cond = true;};
		}
		else
		{
			if (format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging && format ["%1", (_men select 1) getVariable "BTC_dragged"] == "0") then {_cond = true;};
		};
	};
	_cond
};
BTC_is_class_can_revive =
{
	_unit    = _this select 0;
	_cond = false;
	{if (_unit isKindOf _x) then {_cond = true};} foreach BTC_who_can_revive;
	_cond
};
BTC_can_revive =
{
	_unit    = _this select 0;
	_injured = _this select 1;
	_array_item_unit    = items _unit;
	_array_item_injured = items _injured;
	_cond = false;
	{if (_unit isKindOf _x) then {_cond = true};} foreach BTC_who_can_revive;
	if (_cond && BTC_need_first_aid == 1) then
	{
		if (_array_item_unit find "FirstAidKit" == -1) then {_cond = false;};
		if (!_cond && _array_item_injured find "FirstAidKit" != -1) then {_cond = true;};
	};
	_cond
};
//Mobile
BTC_move_to_mobile =
{
	_var = _this select 0;
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	_mobile = objNull;
	{
		if ((typeName (_x getvariable _side)) == "STRING") then
		{
			if ((_x getvariable _side) == _var) then {_mobile = _x;};
		};
	} foreach vehicles;
	if (isNull _mobile) exitWith {};
	if (speed _mobile > 5) exitWith {hint "Mobile respawn is moving! Can't move there!";};
	_pos = getPos _mobile;
	titleText ["Get Ready", "BLACK OUT"];
	sleep 3;
	titleText ["Get Ready", "BLACK FADED"];
	sleep 2;
	titleText ["", "BLACK IN"];
	player setPos [(_pos select 0) + ((random 50) - (random 50)), (_pos select 1) + ((random 50) - (random 50)), 0];
};
BTC_mobile_marker =
{
	_var = _this select 0;
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	while {true} do
	{
		_obj = objNull;
		while {isNull _obj} do 
		{
			{
				if (format ["%1",_x getVariable _side] == _var && Alive _x) then {_obj = _x;};
			} foreach vehicles;
			sleep 1;
		};
		deleteMarkerLocal format ["%1", _var];
		_marker = createmarkerLocal [format ["%1", _var], getPos _obj];
		format ["%1", _var] setmarkertypelocal "mil_dot";
		format ["%1", _var] setMarkerTextLocal format ["%1", _var];
		format ["%1", _var] setmarkerColorlocal "ColorGreen";
		format ["%1", _var] setMarkerSizeLocal [0.5, 0.5];
		hint format ["%1 is available!", _var];
		while {Alive _obj} do
		{
			format ["%1", _var] setMarkerPosLocal (getPos _obj);
			if (speed _obj <= 5 && speed _obj >= -3) then {format ["%1", _var] setMarkerTextLocal format ["%1 deployed", _var];format ["%1", _var] setmarkerColorlocal "ColorGreen";} else {format ["%1", _var] setMarkerTextLocal format ["%1 is moving", _var];format ["%1", _var] setmarkerColorlocal "ColorBlack";};
			sleep 1;
		};
		hint format ["%1 has been destroyed!", _var];
		format ["%1", _var] setMarkerTextLocal format ["%1 destroyed!", _var];
		format ["%1", _var] setmarkerColorlocal "ColorRed";
		if (BTC_mobile_respawn == 0) exitWith {};
	};
};
BTC_mobile_check =
{
	_var = _this select 0;
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	_cond = false;
	{
		if ((typeName (_x getvariable _side)) == "STRING") then
		{
			if ((_x getvariable _side) == _var) then {_cond = true;};
		};
	} foreach vehicles;
	_cond
};
BTC_vehicle_mobile_respawn =
{
	_veh  = _this select 0;
	_var  = _this select 1;
	_set  = _this select 2;
	_type = typeOf _veh;
	_pos  = getPos _veh;
	_dir  = getDir _veh;
	waitUntil {sleep 1; !Alive _veh};
	_veh setVariable [_set,0,true];
	sleep BTC_mobile_respawn_time;
	deleteVehicle _veh;
	_veh = createVehicle [_type, (_pos findEmptyPosition [2,200,_type]),[],0,"NONE"];
	_veh setDir _dir;
	_veh setVelocity [0, 0, -1];
	_veh setVariable [_set,_var,true];
	_resp = [_veh,_var,_set] spawn BTC_vehicle_mobile_respawn;
	_veh setpos _pos;
};
BTC_out_of_lifes =
{
	if (BTC_lifes == 0) then
	{
		closeDialog 0;
		removeAllWeapons player;
		player enableSimulation false;
		titleText ["You have no more lifes", "BLACK FADED"];//BLACK FADED
		sleep 1;
		if (BTC_spectating == 0) then
		{
			while {true} do
			{
				player enableSimulation false;
				player setpos [0,0,6000];
				player setVelocity [0,0,0];
				titleText ["You have no more lifes", "BLACK FADED"];
				sleep 1;
			};
		} else {[] spawn BTC_r_spectator;};
	};
};
BTC_3d_markers =
{
	_3d = addMissionEventHandler ["Draw3D",
	{
		{
			if (((_x distance player) < BTC_3d_distance) && (format ["%1", _x getVariable "BTC_need_revive"] == "1")) then
			{
				drawIcon3D["a3\ui_f\data\map\MapControl\hospital_ca.paa",BTC_3d_icon_color,_x,BTC_3d_icon_size,BTC_3d_icon_size,0,format["%1 (%2m)", name _x, ceil (player distance _x)],0,0.02];
			};
		} foreach playableUnits;//playableUnits
	}];
};
BTC_3d_markers_pvp =
{
	_3d = addMissionEventHandler ["Draw3D",
	{
		{
			if (((_x distance player) < BTC_3d_distance) && (_x getVariable "BTC_revive_side" == str (BTC_side)) && (format ["%1", _x getVariable "BTC_need_revive"] == "1")) then
			{
				drawIcon3D["a3\ui_f\data\map\MapControl\hospital_ca.paa",BTC_3d_icon_color,_x,BTC_3d_icon_size,BTC_3d_icon_size,0,format["%1 (%2m)", name _x, ceil (player distance _x)],0,0.02];
			};
		} foreach playableUnits;//playableUnits
	}];
};
BTC_revive_loop =
{
	while {true} do
	{
		sleep 1;
		if (Alive player && format ["%1",player getVariable "BTC_need_revive"] != "1") then
		{
			//hintsilent format ["%1 %2",currentWeaponMode player,currentMagazineDetail player];
			//diag_log text format ["SAVED %1",dialog];
			BTC_gear = [] call BTC_get_gear;
		};
	};
};
//Dialog
BTC_r_get_list =
{
	private ["_leader"];
	_list_str = ["BASE"];
	_list_name = [BTC_r_base_spawn];
	_side = "";_array = [];
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";_array = BTC_vehs_mobile_west_str;};
		case (BTC_side == east) : {_side = "BTC_mobile_east";_array = BTC_vehs_mobile_east_str;};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";_array = BTC_vehs_mobile_guer_str;};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";_array = BTC_vehs_mobile_civ_str;};
	};
	{
		_var = _x;
		{
			if ((typeName (_x getvariable _side)) == "STRING") then
			{
				if ((_x getvariable _side) == _var) then {_list_name = _list_name + [_x];_list_str = _list_str + [(_x getvariable _side)];};
			};
		} foreach vehicles;
	} foreach _array;
	switch (true) do
	{
		case (BTC_dlg_on_respawn == 2) : 
		{
			_leader = leader group player;
			if (_leader != player && (format ["%1", _leader getVariable "BTC_need_revive"] == "0")) then {_list_name = _list_name + [_leader];_list_str = _list_str + [name _leader];};
		};
		case (BTC_dlg_on_respawn == 3) : 
		{
			{if (_x != player && (format ["%1", _x getVariable "BTC_need_revive"] == "0")) then {_list_name = _list_name + [_x];_list_str = _list_str + [name _x];};} foreach (units group player);
		};
		case (BTC_dlg_on_respawn == 4) : 
		{
			{if (_x != player && side _x == BTC_side && (format ["%1", _x getVariable "BTC_need_revive"] == "0")) then {_list_name = _list_name + [_x];_list_str = _list_str + [name _x];};} foreach allUnits;
		};
	};
	_list = [_list_str,_list_name];
	_list
};
BTC_r_load = 
{
	_list = call BTC_r_get_list;
	_list_name = _list select 0;
	_list_units = _list select 1;
	_n = 0;_side = "";_array = [];
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";_array = BTC_vehs_mobile_west_str;};
		case (BTC_side == east) : {_side = "BTC_mobile_east";_array = BTC_vehs_mobile_east_str;};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";_array = BTC_vehs_mobile_guer_str;};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";_array = BTC_vehs_mobile_civ_str;};
	};
	if (!isNull BTC_r_mobile_selected) then {if ((_list_name find (BTC_r_mobile_selected getVariable _side)) == -1 && (_list_name find (name BTC_r_mobile_selected)) == -1) then {BTC_r_mobile_selected = _list_units select 0;};};
	if (count _list_name != count BTC_r_list) then 
	{
		lbClear 119;
		{
			_lb = lbAdd [119,_x];
			if (!isNull BTC_r_mobile_selected) then {if ((BTC_r_mobile_selected getVariable _side) == _x || name BTC_r_mobile_selected == _x) then {lbSetCurSel [119,_lb];};};
			if (isNull BTC_r_mobile_selected) then {lbSetCurSel [119,_lb];_n = _list_name find _x;BTC_r_mobile_selected = _list_units select _n;};
		} foreach _list_name;BTC_r_list = _list_name;
	} else {};
	true
};
BTC_r_create_dialog_mobile =
{
	if (BTC_active_lifes != 1 || BTC_lifes != 0) then 
	{
		player allowdamage false;
		deTach player;
		player attachTo [BTC_r_base_spawn,[0,0,6000]];
		//player setpos [0,0,6000];
		player setVelocity [0,0,0];
		BTC_r_camera = "camera" camCreate (position BTC_r_base_spawn);
		BTC_r_camera camSetTarget BTC_r_base_spawn;
		BTC_r_camera cameraEffect ["internal", "BACK"];
		BTC_r_camera camSetPos (BTC_r_base_spawn modelToWorld [-15,-15,15]);
		BTC_r_camera camCommit 0;
		BTC_r_chosen = false;
		BTC_r_list = [];
		BTC_r_mobile_selected = objNull;
		titleText ["", "BLACK IN"];
		sleep 0.5;
		disableSerialization;
		closeDialog 0;
		_r_dlg = createDialog "BTC_move_to_mobile_dialog";
		sleep 0.5;
		titleText ["", "PLAIN"];
		waitUntil {dialog};
		player enableSimulation false;
		call BTC_r_load;
		while {!BTC_r_chosen} do
		{
			if (!dialog && !BTC_r_chosen) then {_r_dlg = createDialog "BTC_move_to_mobile_dialog";sleep 0.5;};
			player setpos [0,0,6000];
			//player setVelocity [0,0,0];
			call BTC_r_load;
			if (count BTC_r_list == 0) then {titleText ["NO SPAWN POINTS FOUND", "PLAIN"];};
			sleep 1;
		};
		player allowdamage true;
		closeDialog 0;
	};
};
BTC_r_apply = 
{
	BTC_r_chosen = true;
	closeDialog 0;
	titleText ["", "BLACK OUT"];
	sleep 0.5;
	titleText ["", "BLACK FADED"];
	player cameraEffect ["terminate","back"];
	camDestroy BTC_r_camera;
	if (!isNull BTC_r_mobile_selected) then 
	{
		private ["_mobile"];
		_mobile = BTC_r_mobile_selected;
		if (speed _mobile > 2) then {titleText ["Mobile is moving...", "BLACK FADED"];WaitUntil {speed _mobile > 2 || !Alive _mobile};};
		if (!Alive _mobile) then {_dlg = [] spawn BTC_r_create_dialog_mobile;} else {player attachTo [_mobile,[3,3,0]];sleep 0.1;deTach player;player setVelocity [0,0,0];player setpos [(getpos _mobile select 0) + (random 5),(getpos _mobile select 1) + (random 5),(getpos _mobile select 2)];sleep 0.1;player playMoveNow "amovpercmstpsraswrfldnon";};
	}
	else
	{
		player setPos getMarkerPos BTC_respawn_marker;
	};
	player enableSimulation true;
	titleText ["", "BLACK IN"];sleep 1;titleText ["", "PLAIN"];
};
BTC_r_close = 
{
	BTC_r_chosen = true;
	closeDialog 0;
	titleText ["", "BLACK OUT"];
	player setVelocity [0,0,0];
	player attachTo [BTC_r_base_spawn,[0,0,0]];
	sleep 0.1;
	detach player;
	player setPos getMarkerPos BTC_respawn_marker;
	sleep 0.5;
	player enableSimulation true;
	player switchMove "amovpercmstpsraswrfldnon";
	titleText ["", "BLACK FADED"];
	player cameraEffect ["terminate","back"];
	camDestroy BTC_r_camera;
	titleText ["", "BLACK IN"];
	sleep 1;
	titleText ["", "PLAIN"];
	closeDialog 0;
};
BTC_r_change_target = 
{
	_var = lbText [119,lbCurSel 119];
	_target = objNull;_side = "";_array = [];
	if (_var == "BASE") then {_target = BTC_r_base_spawn;};
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";_array = BTC_vehs_mobile_west_str;};
		case (BTC_side == east) : {_side = "BTC_mobile_east";_array = BTC_vehs_mobile_east_str;};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";_array = BTC_vehs_mobile_guer_str;};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";_array = BTC_vehs_mobile_civ_str;};
	};
	{
		if ((typeName (_x getvariable _side)) == "STRING") then
		{
			if ((_x getvariable _side) == _var) then {_target = _x;};
		};
	} foreach vehicles;
	switch (true) do
	{
		case (BTC_dlg_on_respawn == 2 || BTC_dlg_on_respawn == 3) : 
		{

			{if (_var == name _x) then {_target = _x;};} foreach (units group player);
		};
		case (BTC_dlg_on_respawn == 4) : 
		{
			{if (_var == name _x) then {_target = _x;};} foreach allUnits;
		};
	};
	//if (!isNull _target) then {BTC_r_mobile_selected = _target;};
	//if (isNull _target) then {BTC_r_mobile_selected = player;};
	BTC_r_mobile_selected = _target;
	BTC_r_camera camSetTarget BTC_r_mobile_selected;
	BTC_r_camera cameraEffect ["internal", "BACK"];
	BTC_r_camera camSetPos (BTC_r_mobile_selected modelToWorld [-15,-15,15]);
	BTC_r_camera camCommit 0;
};
//Spectating
BTC_r_s_load = 
{
	_list_name = [];
	_list_units = [];
	switch (true) do
	{
		case (BTC_spectating == 1) : {{if (_x != player) then {_list_name = _list_name + [name _x];_list_units = _list_units + [_x];};} foreach units group player;};
		case (BTC_spectating == 2) : {{if (side _x == BTC_side && _x != player) then {_list_name = _list_name + [name _x];_list_units = _list_units + [_x];};} foreach switchableunits;};//switchableunits
		case (BTC_spectating == 3) : {{if (_x != player) then {_list_name = _list_name + [name _x];_list_units = _list_units + [_x];};} foreach playableUnits;};
	};
	_n = 0;
	if (!isNull BTC_r_s_target && BTC_r_s_target != BTC_r_base_spawn) then {if ((_list_name find (name BTC_r_s_target)) == -1) then {BTC_r_s_target = BTC_r_base_spawn;};};
	if (count _list_name != count BTC_r_s_list) then 
	{
		lbClear 120;
		{
			_lb = lbAdd [120,_x];
			if (!isNull BTC_r_s_target && BTC_r_s_target != BTC_r_base_spawn) then {if (name BTC_r_s_target == _x) then {lbSetCurSel [120,_lb];};};
			if (isNull BTC_r_s_target) then {lbSetCurSel [120,_lb];_n = _list_name find _x;BTC_r_s_target = _list_units select _n;};
		} foreach _list_name;BTC_r_s_list = _list_name;
	} else {};
	if (count _list_name == 0) then {titleText ["No units found!","PLAIN DOWN"];BTC_r_s_target = BTC_r_base_spawn;} else {titleText ["","PLAIN DOWN"];};
	true
};
BTC_r_s_change_target =
{
	_name = lbText [120,lbCurSel 120];
	switch (true) do
	{
		case (BTC_spectating == 1) : {{if (name _x == _name) then {BTC_r_s_target = _x;};} foreach units group player;};
		case (BTC_spectating == 2) : {{if (name _x == _name) then {BTC_r_s_target = _x;};} foreach playableUnits;};//switchableunits
		case (BTC_spectating == 3) : {{if (name _x == _name) then {BTC_r_s_target = _x;};} foreach playableUnits;};
	};
};
BTC_r_s_change_view =
{
	_view = lbText [121,lbCurSel 121];
	switch (true) do
	{
		case (_view == "First person")    : {BTC_r_s_cam_view = [0,0.3,1.55];};
		case (_view == "Behind the back") : {BTC_r_s_cam_view = [0,-2,2];};
		case (_view == "High")            : {BTC_r_s_cam_view = [-15,-15,15];};
	};
};
BTC_r_s_keydown =
{
	private ["_key","_dir","_view","_value"];
	if (count _this > 1) then
	{
		_key = _this select 1;
		_alt = _this select 4;
		_view = BTC_r_s_cam_view;
		_value = if (_alt) then {10} else {1};
		//player globalchat format ["%1 - %2",_key,_this];
		switch (true) do
		{
			case (_key == 30 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0) - _value,(_view select 1),(_view select 2)];};//A
			case (_key == 32 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0) + _value,(_view select 1),(_view select 2)];};//D
			case (_key == 31 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0),(_view select 1) - _value,(_view select 2)];};
			case (_key == 17 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0),(_view select 1) + _value,(_view select 2)];};
			case (_key == 44 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0),(_view select 1),(_view select 2) - _value];};
			case (_key == 16 && (lbText [121,lbCurSel 121] == "Free")) : {BTC_r_s_cam_view = [(_view select 0),(_view select 1),(_view select 2) + _value];};
			case (_key == 49) : {if (BTC_r_camera_nvg) then {BTC_r_camera_nvg = false;} else {BTC_r_camera_nvg = true;};};
		};
	};
};
BTC_r_spectator =
{
	BTC_r_s_list   = [];
	BTC_r_s_target = objNull;
	BTC_r_camera_nvg = false;
	BTC_r_s_camera = "camera" camCreate (position BTC_r_base_spawn);
	BTC_r_s_camera camSetTarget BTC_r_base_spawn;
	BTC_r_s_camera cameraEffect ["internal", "BACK"];
	BTC_r_s_camera camSetPos [(getpos BTC_r_base_spawn select 0) + 15,(getpos BTC_r_base_spawn select 1) + 15,10];
	BTC_r_s_camera camCommit 0;
	player enableSimulation false;
	disableSerialization;
	_r_dlg = createDialog "BTC_spectating_dialog";
	_ui = uiNamespace getVariable "BTC_r_dialog";
	(_ui displayCtrl 122) ctrlShow false;
	BTC_r_camera_EH_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_keydown = _this spawn BTC_r_s_keydown"];
	if ((BTC_spectating_view select 0) == 1) then {_lb = lbAdd [121,(BTC_s_mode_view select (BTC_spectating_view select 1))];} else {{_lb = lbAdd [121,_x];} foreach BTC_s_mode_view};
	sleep 0.5;
	call BTC_r_s_load;
	while {true} do
	{
		if (!dialog) then {_r_dlg = createDialog "BTC_spectating_dialog";sleep 0.5;};
		call BTC_r_s_load;
		player setpos [0,0,6000];
		player setVelocity [0,0,0];
		BTC_r_s_camera camSetTarget BTC_r_s_target;
		//BTC_r_s_camera camSetPos [(getpos BTC_r_s_target select 0) + 15,(getpos BTC_r_s_target select 1) + 15,10];
		/*if (lbText [121,lbCurSel 121] == "First person") then
		{
			deTach BTC_r_s_camera;
			BTC_r_s_camera camSetPos (BTC_r_s_target modelToWorld [0,0.3,1.5]);
		}
		else {*/BTC_r_s_camera attachTo [BTC_r_s_target,BTC_r_s_cam_view];//};
		BTC_r_s_camera camCommit 0;
		if (BTC_r_camera_nvg) then {camusenvg true;} else {camusenvg false;};
		//sleep 0.5;
	};
};