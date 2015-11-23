private ["_selectionBox","_cursel","_comboBox","_tempBox","_array","_displayArray","_displayname","_class","_pic","_index","_valor"];
disableSerialization;
_type			= _this select 0;
_selectionBox 	= (_this select 1) select 0;
_cursel 		= lbCurSel 2;


//Don't have the box exit
_tempBox = missionNamespace getVariable [format ["MCC_rtsMainBox%1",playerSide], objNull];
if (isNull _tempBox) exitWith {};
_playerValor = player getVariable ["MCC_valorPoints",50];
switch (_type) do {
    case (2): //Give
    {
    	_class = lbData [0, (lbCurSel 0)];

    	//Weapon or magazine
    	switch (true) do {
			case (isClass (configFile >> "CfgMagazines" >> _class)) : {_valor = getNumber(configFile >> "CfgMagazines" >> _class >> "value")};
			case (isClass (configFile >> "CfgWeapons" >> _class)) : {_valor = getNumber(configFile >> "CfgWeapons" >> _class >> "value")};
			case (isClass (configFile >> "CfgGlasses" >> _class)) : {_valor = getNumber(configFile >> "CfgGlasses" >> _class >> "value")};
		};

    	//Valor factor
    	_valor = _valor * (switch _cursel  do {
					    case 0: {10};	//Bino
					    case 1: {10};	//Items
					    case 2: {15};	//Uniforms
					    case 3: {40};	//Launchers
					    case 4: {40};	//Machine guns
					    case 5: {20};	//Pistols
					    case 6: {35};	//rifels
					    case 7: {45};	//Sniper rifles
					    case 8: {10};	//Magazines
					    case 9: {5};	//under barrel
					    case 10: {5};	//Grenades
					    case 11: {20};	//Explosives
					    default {1};	//survival
					});

    	//Give it away
    	switch true  do {
		    case (_cursel in [1,2]):		//Items
		    {
		    	[_tempBox, _class] call MCC_fnc_addVirtualItemCargo;
		    	player removeItem _class;
		    };

		    case (_cursel in [0,3,4,5,6,7]):		//weapons
		    {
		    	[_tempBox, _class] call MCC_fnc_addVirtualweaponCargo;
		    	_null = [player,_class] call BIS_fnc_invRemove;
		    };

		    case (_cursel in [8,9,10,11]):		//Magazines
		    {
		    	[_tempBox, _class] call MCC_fnc_addVirtualMagazineCargo;
		    	_null = [player,_class] call BIS_fnc_invRemove;

		    	//add funds
				_value = getNumber(configFile >> "CfgMagazines" >> _class >> "mass");
				_resources = missionNamespace getVariable [format ["MCC_res%1", playerSide],[500,500,200,200,100]];
				_resources set [0, ((_resources select 0)+_value)];
				publicVariable (format ["MCC_res%1", playerSide,_resources]);
		    };

		    case (_cursel == 12):		//Survival
		    {
		    	private ["_resources","_value"];

		    	player removeItem _class;
	    		_null = [_tempBox, _class] call MCC_fnc_addVirtualItemCargo;

		    	//add funds
		    	_index = switch (getText(configFile >> "CfgWeapons" >> _class >> "mcc_surviveType")) do
		    			{
				    	    case "repair":  {1};
				    	    case "fuel":  {2};
				    	    case "food":  {3};
				    	    case "med":  {4};
				    	    default {0};
				    	};
				_value = getNumber(configFile >> "CfgWeapons" >> _class >> "value");
				_resources = missionNamespace getVariable [format ["MCC_res%1", playerSide],[500,500,200,200,100]];
				_resources set [_index, ((_resources select _index)+_value)];
				publicVariable (format ["MCC_res%1", playerSide,_resources]);
		    };
		};

		player setVariable ["MCC_valorPoints",_playerValor + _valor];
    };

    case (3): //Take
    {
    	_class = lbData [1, (lbCurSel 1)];

    	//Weapon or magazine
    	switch (true) do {
			case (isClass (configFile >> "CfgMagazines" >> _class)) : {_valor = getNumber(configFile >> "CfgMagazines" >> _class >> "value")};
			case (isClass (configFile >> "CfgWeapons" >> _class)) : {_valor = getNumber(configFile >> "CfgWeapons" >> _class >> "value")};
			case (isClass (configFile >> "CfgGlasses" >> _class)) : {_valor = getNumber(configFile >> "CfgGlasses" >> _class >> "value")};
		};

    	_valor = _valor * 1.5 * (switch _cursel  do	{
					    case 0: {10};	//Bino
					    case 1: {10};	//Items
					    case 2: {15};	//Uniforms
					    case 3: {40};	//Launchers
					    case 4: {40};	//Machine guns
					    case 5: {20};	//Pistols
					    case 6: {35};	//rifels
					    case 7: {45};	//Sniper rifles
					    case 8: {10};	//Magazines
					    case 9: {5};	//under barrel
					    case 10: {5};	//Grenades
					    case 11: {20};	//Explosives
					    default {1};	//survival
					});

    	if (_playerValor >= _valor) then {
			//Take
	    	switch true  do
			{
			    case (_cursel in [1,2,12]):		//Items
			    {
			    	player addItem _class;
			    	if (_class in (items player)) then {
			    		[_tempBox, _class] call MCC_fnc_removeVirtualItemCargo;
			    	   	player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	};
			    };

			    case (_cursel in [0,3,4,5,6,7]):		//weapons
			    {
			    	if ([player, _class] call BIS_fnc_invAdd) then {
			    		[_tempBox, _class] call MCC_fnc_removeVirtualweaponCargo;
			    		player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	};
			    };

			    case (_cursel in [8,9,10,11]):		//Magazines
			    {
			    	if ([player, _class] call BIS_fnc_invAdd) then {
			    		[_tempBox, _class] call MCC_fnc_removeVirtualMagazineCargo;
			    		player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	} else {
			    		_mags = magazines player;					//BIS functions screw up sometimes
			    		player addMagazine _class;
			    		if (count _mags < count (magazines player)) then {
			    			[_tempBox, _class] call MCC_fnc_removeVirtualMagazineCargo;
			    			player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    		};
			    	};
			    };
			};

		};
    };
};

{
	disableSerialization;
	_ctrl = _x;
	_array = [_cursel, _ctrl==0, _tempBox] call MCC_fnc_boxMakeWeaponsArray;
	_displayArray = [];
	_comboBox		= (ctrlParent _selectionBox) displayCtrl _x;
	lbClear _comboBox;
	{
		_displayname 	= _x select 0;
		_class 			= _x select 1;
		_pic 			= _x select 2;
		_valor			= _x select 3;
		_valor = _valor * (switch _cursel  do
							{
							    case 0: {10};	//Bino
							    case 1: {10};	//Items
							    case 2: {15};	//Uniforms
							    case 3: {40};	//Launchers
							    case 4: {40};	//Machine guns
							    case 5: {20};	//Pistols
							    case 6: {35};	//rifels
							    case 7: {45};	//Sniper rifles
							    case 8: {10};	//Magazines
							    case 9: {5};	//under barrel
							    case 10: {5};	//Grenades
							    case 11: {20};	//Explosives
							    default {1};	//survival
							});
		//If we are taking an item it will cost 50% more
		if (_ctrl == 1) then {_valor = _valor *1.5};

		if !(_displayname in _displayArray) then
		{
			_index 			= _comboBox lbAdd (format ["%1 X %2",_displayname, ({_displayname== (_x select 0)} count _array)]);
			_comboBox lbSetPicture [_index, _pic];
			_comboBox lbSetData [_index, _class];
			_comboBox lbSetTooltip [_index,format ["%1 Valor points", _valor]];
			_displayArray pushback _displayname;
		};

	} foreach _array;

	//_comboBox lbSetCurSel 0;
} foreach [0,1];

//Get valor points
ctrlSetText [4,str (player getVariable ["MCC_valorPoints",50])];