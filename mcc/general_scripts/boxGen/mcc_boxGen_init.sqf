private ["_display","_comboBox","_displayname","_pic", "_index", "_array", "_class","_null","_ctrl","_target","_isMCC3D","_ctrlButtton"];
#define MCC3D_IDD 8000
#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502
#define MCC_3dTasksControlsIDC 8020
#define MCCCuratorInit_IDD 10000
#define MCC_3DCargoGen 8018

disableSerialization;

_ctrlButtton 	= _this select 0;
_display 		= ctrlParent _ctrlButtton;
_ctrl			= _display displayCtrl MCC_3DCargoGen;

//Curator or MCC 3D editor?
if (_display != findDisplay MCC3D_IDD) then
{
	_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
	_isMCC3D = false;
}
else
{
	if (!isnil "Object3D") then {_target = Object3D};
	_isMCC3D = true;
};

if (isnil "_target") exitWith {}; 
if !(_target isKindof "CAR" || _target isKindof "TANK" || _target isKindof "Air" || _target isKindof "ReammoBox_F") exitWith {};
_ctrl ctrlShow !(ctrlShown _ctrl);

//Align it for the Curator interface
if !(_isMCC3D) then
{
	private ["_ctrlPos"];
	_ctrlPos = ctrlposition _ctrl;
	_ctrlPos set [0,safezoneW - ((safezoneW)+(safezoneW/5))];
	_ctrl ctrlsetposition _ctrlPos;
	_ctrl ctrlcommit 0; 
};

if (ctrlShown _ctrl) then 
{
	if (_isMCC3D) then
	{
		if (ctrlShown (_display displayCtrl 8017)) then {_null = [0] execVM MCC_path + "mcc\general_scripts\docobject\compositionManager.sqf"};
		ctrlShow [MCC_3dTasksControlsIDC,false];
	};
	
	(_this select 0) ctrlSetText "<-- Cargo";
} 
else 
{
	(_this select 0) ctrlSetText "Cargo -->";
};

if !(ctrlShown _ctrl) exitWith {};

_comboBox = _display displayCtrl GEARCLASS_IDD; 
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Weapons", "Items","Uniforms", "Launchers", "Machine Guns", "Pistols", "Rifles","Sniper Rifles","Rucks","Glasses","Magazines","Under Barrel","Grenades","Explosive"];
_comboBox lbSetCurSel MCC_gearDialogClassIndex;

_array = switch (MCC_gearDialogClassIndex) do 
			{
				//Binos
				case 0: {W_BINOS}; 
				
				//Items
				case 1: {W_ITEMS};
				
				//Uniforms
				case 2: {U_UNIFORM};
				
				//Launchers
				case 3: {W_LAUNCHERS};
				
				//MG
				case 4: {W_MG};
				
				//Pistols
				case 5: {W_PISTOLS};
	
				//Rifles		
				case 6: {W_RIFLES};
	
				//Sniper Rifles	
				case 7: {W_SNIPER};
	
				//Rucks	
				case 8: {W_RUCKS};
	
				//Glasses		
				case 9: {U_GLASSES};
				
				//Magazines		
				case 10: {U_MAGAZINES};
	
				//Under Barrel		
				case 11: {U_UNDERBARREL};
	
				//Grenades			
				case 12: {U_GRENADE};
				
				//Explosive	
				case 13: {U_EXPLOSIVE};
		};

_comboBox = _display displayCtrl ALLGEAR_IDD; 
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

tempBox = _target;
tempBoxWeapons 	= getWeaponCargo tempBox;	//Update box
tempBoxMagazine = getMagazineCargo tempBox;
tempBoxItems	= getItemCargo tempBox;
tempBoxRucks	= getBackpackCargo tempBox;

_count = 0;
_comboBox = _display displayCtrl BOXGEAR_IDD; 
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
	
