private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class"];
#define boxGen_IDD 2995

#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502
if (! isnil "tempBox") then {deleteVehicle tempBox};
tempBox = "B_supplyCrate_F" createvehicle [0,0,200];
clearMagazineCargo tempBox;
clearWeaponCargo tempBox;
clearItemCargo tempBox;
clearBackpackCargo tempBox;

disableSerialization;
_mccdialog = findDisplay boxGen_IDD;
_comboBox = _mccdialog displayCtrl GEARCLASS_IDD; 
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Binoculars", "Items","Uniforms", "Launchers", "Machine Guns", "Pistols", "Rifles","Sniper Rifles","Rucks","Glasses","Magazines","Under Barrel","Grenades","Explosive"];
_comboBox lbSetCurSel MCC_gearDialogClassIndex;
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

