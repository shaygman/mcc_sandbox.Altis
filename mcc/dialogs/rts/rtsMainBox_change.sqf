private ["_selectionBox","_cursel","_comboBox","_tempBox","_array","_displayArray","_displayname","_class","_pic","_index","_valor"];
disableSerialization;
_type			= _this select 0;
_selectionBox 	= (_this select 1) select 0;
_cursel 		= lbCurSel 2;


//Don't have the box exit
_tempBox = missionNamespace getVariable [format ["MCC_rtsMainBox%1",playerSide], objNull];
if (isNull _tempBox) exitWith {};
_playerValor = player getVariable ["MCC_valorPoints",50];
switch (_type) do
{
    case (2): //Give
    {
    	_class = lbData [0, (lbCurSel 0)];

    	//Weapon or magazine
    	if (_cursel <8) then
    	{
    		_valor = getNumber(configFile >> "CfgWeapons" >> _class >> "value");
    	}
    	else
    	{
    		_valor = getNumber(configFile >> "CfgMagazines" >> _class >> "value");
    	};

    	//Valor factor
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

    	//Give it away
    	switch true  do
		{
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

		    	_null = [player,_class] call BIS_fnc_invRemove;

		    	//save only the medical stuff the rest ditch
		    	if (_class in ["MCC_bandage","MCC_epipen","MCC_salineBag","MCC_firstAidKit"]) then {
		    		[_tempBox, _class] call MCC_fnc_addVirtualMagazineCargo;
		    	} else {
			    	//add funds
			    	_index = switch (getText(configFile >> "CfgMagazines" >> _class >> "mcc_surviveType")) do
			    			{
					    	    case "repair":  {1};
					    	    case "fuel":  {2};
					    	    case "food":  {3};
					    	    case "med":  {4};
					    	    default {0};
					    	};
					_value = getNumber(configFile >> "CfgMagazines" >> _class >> "value");
					_resources = missionNamespace getVariable [format ["MCC_res%1", playerSide],[500,500,200,200,100]];
					_resources set [_index, ((_resources select _index)+_value)];
					publicVariable (format ["MCC_res%1", playerSide,_resources]);
				};
		    };
		};


		player setVariable ["MCC_valorPoints",_playerValor + _valor];
    };

    case (3): //Take
    {
    	_class = lbData [1, (lbCurSel 1)];

    	//Weapon or magazine
    	if (_cursel <8) then
    	{
    		_valor = getNumber(configFile >> "CfgWeapons" >> _class >> "value");
    	}
    	else
    	{
    		_valor = getNumber(configFile >> "CfgMagazines" >> _class >> "value");
    	};

    	_valor = _valor * 1.5 * (switch _cursel  do
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

    	if (_playerValor >= _valor) then
		{
			//Take
	    	switch true  do
			{
			    case (_cursel in [1,2]):		//Items
			    {
			    	player addItem _class;
			    	if (_class in (items player)) then
			    	{
			    		[_tempBox, _class] call MCC_fnc_removeVirtualItemCargo;
			    	   	player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	};
			    };

			    case (_cursel in [0,3,4,5,6,7]):		//weapons
			    {
			    	if ([player, _class] call BIS_fnc_invAdd) then
			    	{
			    		[_tempBox, _class] call MCC_fnc_removeVirtualweaponCargo;
			    		player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	};
			    };

			    case (_cursel in [8,9,10,11,12]):		//Magazines
			    {
			    	if ([player, _class] call BIS_fnc_invAdd) then
			    	{
			    		[_tempBox, _class] call MCC_fnc_removeVirtualMagazineCargo;
			    		player setVariable ["MCC_valorPoints",_playerValor - _valor];
			    	}
			    	else
			    	{
			    		_mags = magazines player;					//BIS functions screw up sometimes
			    		player addMagazine _class;
			    		if (count _mags < count (magazines player)) then
			    		{
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

/*
#define boxGen_IDD 2995

#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502

_type = _this select 0;
MCC_gearDialogClassIndex = lbCurSel GEARCLASS_IDD;
disableSerialization;
_mccdialog = findDisplay boxGen_IDD;
if (_type == 0) then 	//Change class
	{
	switch (MCC_gearDialogClassIndex) do
		{
		case 0: //Binos
			{
			_array = W_BINOS;
			};

		case 1: //Items
			{
			_array = W_ITEMS;
			};

		case 2: //Uniforms
			{
			_array = U_UNIFORM;
			};

		case 3: //Launchers
			{
			_array = W_LAUNCHERS;
			};

		case 4: //MG
			{
			_array = W_MG;
			};

		case 5: //Pistols
			{
			_array = W_PISTOLS;
			};

		case 6: //Rifles
			{
			_array = W_RIFLES;
			};

		case 7: //Sniper Rifles
			{
			_array = W_SNIPER;
			};

		case 8: //Rucks
			{
			_array = W_RUCKS;
			};
		case 9: //Glasses
			{
			_array = U_GLASSES;
			};
		case 10: //Magazines
			{
			_array = U_MAGAZINES;
			};
		case 11: //Under Barrel
			{
			_array = U_UNDERBARREL;
			};
		case 12: //Grenades
			{
			_array = U_GRENADE;
			};
		case 13: //Explosive
			{
			_array = U_EXPLOSIVE;
			};
		};

	_comboBox = _mccdialog displayCtrl ALLGEAR_IDD;
		lbClear _comboBox;
		{
			_class = _x select 0;
			_displayname = _x select 1;
			_pic = _x select 2;
			_index = _comboBox lbAdd _displayname;
			_comboBox lbSetPicture [_index, _pic];
			_comboBox lbSetData [_index, _class];
		} foreach _array;
	_comboBox lbSetCurSel 0;
	};

if (_type == 1) then //Add weapon + mags
	{
	_class = lbData [ALLGEAR_IDD, (lbCurSel ALLGEAR_IDD)];
	if (MCC_gearDialogClassIndex > 9) then	{tempBox addMagazineCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 1  || MCC_gearDialogClassIndex == 9 || MCC_gearDialogClassIndex == 2) then	{tempBox addItemCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 8) then	{tempBox addBackpackCargo [_class,1]};
	if ((MCC_gearDialogClassIndex != 1)&& (MCC_gearDialogClassIndex != 2) && (MCC_gearDialogClassIndex < 8))  then
		{
		tempBox addWeaponCargo [_class,1];
		_cfg = configFile >> "CfgWeapons" >> _class;
		_muzzles = getArray (_cfg >> "muzzles");
		_magazines = [];
		if (count _muzzles == 1) then
			{
			_magazines = getArray(_cfg >> "magazines");
			} else
			{
				{
				if (_x == "this") then
					{
					_magazines = _magazines + getArray(_cfg >> "magazines");
					} else
					{
					_magazines = _magazines + getArray(_cfg >> _x >> "magazines");
					};
				} forEach _muzzles;
			};
		tempBox addmagazineCargo [_magazines select 0,6];
		};
	};

if (_type == 2) then //Add weapon/mag without mags
	{
	_class = lbData [ALLGEAR_IDD, (lbCurSel ALLGEAR_IDD)];
	if (MCC_gearDialogClassIndex > 9) then	{tempBox addMagazineCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 1  || MCC_gearDialogClassIndex == 9 || MCC_gearDialogClassIndex == 2) then	{tempBox addItemCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 8) then	{tempBox addBackpackCargo [_class,1]};
	if ((MCC_gearDialogClassIndex != 1)&& (MCC_gearDialogClassIndex != 2) && (MCC_gearDialogClassIndex < 8))  then	{tempBox addWeaponCargo [_class,1]};
	};

if (_type == 3) then //Clear
	{
	clearMagazineCargo tempBox;
	clearWeaponCargo tempBox;
	clearItemCargo tempBox;
	clearBackpackCargo tempBox;
	};

tempBoxWeapons 	= getWeaponCargo tempBox;	//Update box
tempBoxMagazine = getMagazineCargo tempBox;
tempBoxItems	= getItemCargo tempBox;
tempBoxRucks	= getBackpackCargo tempBox;

_count = 0;
_comboBox = _mccdialog displayCtrl BOXGEAR_IDD;
	lbClear _comboBox;
	{
		_cfg = configFile >> "CfgWeapons" >> _x;
		_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (tempBoxWeapons select 1) select _count];
		_pic = getText(_cfg >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_count = _count+ 1;
	} foreach (tempBoxWeapons select 0);
_count = 0;
	{
		_cfg = configFile >> "CfgMagazines" >> _x;
		_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (tempBoxMagazine select 1) select _count];
		_pic = getText(_cfg >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_count = _count+ 1;
	} foreach (tempBoxMagazine select 0);
_comboBox lbSetCurSel 0;
_count = 0;
	{
		_cfg = configFile >> "CfgWeapons" >> _x;
		_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (tempBoxItems select 1) select _count];
		_pic = getText(_cfg >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_count = _count+ 1;
	} foreach (tempBoxItems select 0);
_comboBox lbSetCurSel 0;
_count = 0;
	{
		_cfg = configFile >> "CfgVehicles" >> _x;
		_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (tempBoxRucks select 1) select _count];
		_pic = getText(_cfg >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_count = _count+ 1;
	} foreach (tempBoxRucks select 0);
_comboBox lbSetCurSel 0;


if (_type == 4) then //Generate
	{
	closedialog 0;
	hint "click on map";
	onMapSingleClick "_nul=[""B_supplyCrate_F"",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";";
	if (! isnil "Object3D") then {deletevehicle Object3D};
	Object3D = "B_supplyCrate_F" createvehicle [0,0,0];
	Object3D enableSimulation false;
	MCC3DRuning = true;
	while {MCC3DRuning} do
		{
		MCC3DgotValue = false;
		while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};
		if (MCC3DRuning) then
			{
			 mcc_safe = mcc_safe + FORMAT ["[[%1, %2, %3, %4,%5,%6],'MCC_fnc_boxGenerator',true,false] spawn BIS_fnc_MP;
						sleep 1;"
						,MCC3DValue select 0
						,MCC3DValue select 1
						,tempBoxWeapons
						,tempBoxMagazine
						,tempBoxItems
						,tempBoxRucks
						];
			[[MCC3DValue select 0, MCC3DValue select 1, tempBoxWeapons, tempBoxMagazine,tempBoxItems,tempBoxRucks],"MCC_fnc_boxGenerator",true,false] spawn BIS_fnc_MP;
			MCC_3Dterminate = true;
			};
		sleep 0.1;
		};
	};

