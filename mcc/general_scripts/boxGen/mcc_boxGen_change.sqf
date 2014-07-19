private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class", "_type", "_magazines", "_muzzles", "_cfg", "_count","_string","_target","_isMCC3D"];
#define MCCCuratorInit_IDD 10000
#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502
#define MCC_INITBOX 8004 

disableSerialization;

_type 		= _this select 0;
_ctrl 		= (_this select 1) select 0;
_mccdialog 	= ctrlParent _ctrl;

//Curator or MCC 3D editor?
if (_mccdialog == findDisplay MCCCuratorInit_IDD) then
{
	_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
	_isMCC3D = false;
}
else
{
	_target = tempBox;
	_isMCC3D = true;
};

MCC_gearDialogClassIndex = lbCurSel GEARCLASS_IDD;

if (_type == 0) exitWith 	//Change class
{
	if (isnil "MCC_boxChange") then {MCC_boxChange = false};
	
	if (MCC_boxChange) exitWith {}; 
	MCC_boxChange = !MCC_boxChange;
	
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
	sleep 0.5;
	MCC_boxChange = false; 
};

if (_type == 1) then //Add weapon + mags
{
	_class = lbData [ALLGEAR_IDD, (lbCurSel ALLGEAR_IDD)];
	if (MCC_gearDialogClassIndex > 9) then	{_target addMagazineCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 1  || MCC_gearDialogClassIndex == 9 || MCC_gearDialogClassIndex == 2) then	{_target addItemCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 8) then	{_target addBackpackCargo [_class,1]};
	if ((MCC_gearDialogClassIndex != 1)&& (MCC_gearDialogClassIndex != 2) && (MCC_gearDialogClassIndex < 8))  then
	{
		_target addWeaponCargo [_class,1];
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
		_target addmagazineCargo [_magazines select 0,6];
	};
};

if (_type == 2) then //Add weapon/mag without mags
{
	_class = lbData [ALLGEAR_IDD, (lbCurSel ALLGEAR_IDD)];
	if (MCC_gearDialogClassIndex > 9) then	{_target addMagazineCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 1  || MCC_gearDialogClassIndex == 9 || MCC_gearDialogClassIndex == 2) then	{_target addItemCargo [_class,1]};
	if (MCC_gearDialogClassIndex == 8) then	{_target addBackpackCargo [_class,1]};
	if ((MCC_gearDialogClassIndex != 1)&& (MCC_gearDialogClassIndex != 2) && (MCC_gearDialogClassIndex < 8))  then	{_target addWeaponCargo [_class,1]};
};

if (_type == 3) then //Clear
{
	clearMagazineCargo _target;
	clearWeaponCargo _target;
	clearItemCargo _target;
	clearBackpackCargo _target;
};	
	
_targetWeapons 	= getWeaponCargo _target;	//Update box
_targetMagazine = getMagazineCargo _target;
_targetItems	= getItemCargo _target;
_targetRucks	= getBackpackCargo _target;

_count = 0;
_comboBox = _mccdialog displayCtrl BOXGEAR_IDD; 
lbClear _comboBox;
{
	_cfg = configFile >> "CfgWeapons" >> _x;
	_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (_targetWeapons select 1) select _count];
	_pic = getText(_cfg >> "picture");
	_index = _comboBox lbAdd _displayname;
	_comboBox lbSetPicture [_index, _pic];
	_count = _count+ 1;
} foreach (_targetWeapons select 0);

_count = 0;
{
	_cfg = configFile >> "CfgMagazines" >> _x;
	_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (_targetMagazine select 1) select _count];
	_pic = getText(_cfg >> "picture");
	_index = _comboBox lbAdd _displayname;
	_comboBox lbSetPicture [_index, _pic];
	_count = _count+ 1;
} foreach (_targetMagazine select 0);
_comboBox lbSetCurSel 0;

_count = 0;
{
	_cfg = configFile >> "CfgWeapons" >> _x;
	_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (_targetItems select 1) select _count];
	_pic = getText(_cfg >> "picture");
	_index = _comboBox lbAdd _displayname;
	_comboBox lbSetPicture [_index, _pic];
	_count = _count+ 1;
} foreach (_targetItems select 0);
_comboBox lbSetCurSel 0;

_count = 0;
{
	_cfg = configFile >> "CfgVehicles" >> _x;
	_displayname = format ["%2 X %1 ", getText(_cfg >> "displayname"), (_targetRucks select 1) select _count];
	_pic = getText(_cfg >> "picture");
	_index = _comboBox lbAdd _displayname;
	_comboBox lbSetPicture [_index, _pic];
	_count = _count+ 1;
} foreach (_targetRucks select 0);
_comboBox lbSetCurSel 0;
	

if (_type == 4) then //Generate
{
	_string = ctrlText MCC_INITBOX;
	_string = _string + format [';if (isServer) then {clearMagazineCargoGlobal _this; clearWeaponCargoGlobal _this;	clearItemCargoGlobal _this; clearBackpackCargoGlobal _this;[[_this, %1, %2, %3, %4],"MCC_fnc_boxGenerator",_this,false] spawn BIS_fnc_MP};',_targetWeapons, _targetMagazine, _targetItems, _targetRucks];
	ctrlSetText [MCC_INITBOX,_string];
	
	if (_isMCC3D) then
	{
		_null = [1] execVM format["%1mcc\pop_menu\spawn_group3d.sqf",MCC_path];
	};
};
	
