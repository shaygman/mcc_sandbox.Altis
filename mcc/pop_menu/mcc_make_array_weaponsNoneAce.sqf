private 
["_CfgWeapons", "_type",  "_i",  "_CfgWeapon", "_weaponDisplayName","_cfgclass","_picture", "_bino_index", "_item_index","_displayArray",
	"_launchers_index","_mg_index","_pistol_index", "_rifle_index", "_ammo_index","_glasses_index"];

_launchers_index = 0;
_mg_index 		= 0;
_pistol_index 	= 0;
_rifle_index 	= 0;
_bino_index 	= 0;
_item_index 	= 0;
_ammo_index 	= 0;
_glasses_index 	= 0;
_displayArray = []; 

W_ATTACHMENTS = [];

_CfgWeapons 		= configFile >> "CfgWeapons" ;
for "_i" from 1 to (count _CfgWeapons - 1) do
	{
	_CfgWeapon = _CfgWeapons select _i;
	_weaponDisplayName 	= getText(_CfgWeapon >> "displayname");
	_cfgclass 			= (configName (_CfgWeapon));  
	_picture			= getText(_CfgWeapon >> "picture");
	_type				= getNumber(_CfgWeapon >> "type");
	if (isClass _CfgWeapon && !(_picture=="") && !(_weaponDisplayName=="") && !(_weaponDisplayName in _displayArray) && (getNumber(_CfgWeapon>>"scope")==2)) then 
		{
		if (_type == 1) then	//Rifle
			{  
				switch (true) do
					{
						case ((getText(_CfgWeapon>>"cursor")=="mg")) : 
							{
								W_MG set [count W_MG,[_cfgclass,_weaponDisplayName,_picture]];
								_displayArray set [count _displayArray,_weaponDisplayName];
							};
						case ((getText(_CfgWeapon>>"cursor")=="srifle")) : 
							{
								W_SNIPER set [count W_SNIPER,[_cfgclass,_weaponDisplayName,_picture]];
								_displayArray set [count _displayArray,_weaponDisplayName];
							};
						default 
							{
							W_RIFLES set [count W_RIFLES,[_cfgclass,_weaponDisplayName,_picture]];
							_displayArray set [count _displayArray,_weaponDisplayName];
							};
					};
			};
		
		if (_type == 2) then	//Pistols
			{
				W_PISTOLS set [_pistol_index,[_cfgclass,_weaponDisplayName,_picture]];
				_displayArray set [count _displayArray,_weaponDisplayName];
				_pistol_index = _pistol_index + 1;
			};
		
		if (_type == 5) then	//MG
			{
				W_MG set [count W_MG,[_cfgclass,_weaponDisplayName,_picture]];
				_displayArray set [count _displayArray,_weaponDisplayName];
			};
			
		if (_type == 4) then	//Launchers
			{
				W_LAUNCHERS set [_launchers_index,[_cfgclass,_weaponDisplayName,_picture]];
				_displayArray set [count _displayArray,_weaponDisplayName];
				_launchers_index = _launchers_index + 1;
			};
		
		if (_type == 131072) then	//Item
			{
				if ((getnumber(configFile >> "CfgWeapons" >> _cfgclass >> "itemInfo" >>"type")) == 201) then {W_ATTACHMENTS set [count W_ATTACHMENTS,[_cfgclass,_weaponDisplayName,_picture]]};
				if ((getText(_CfgWeapon>>"descriptionShort")!="") || (getNumber(_CfgWeapon>>"mFact")==1)) then {						//Uniform
						W_ITEMS set [_item_index,[_cfgclass,_weaponDisplayName,_picture]];
						_displayArray set [count _displayArray,_weaponDisplayName];
						_item_index = _item_index + 1;
					} else	{
							U_UNIFORM set [count U_UNIFORM,[_cfgclass,_weaponDisplayName,_picture]];
							_displayArray set [count _displayArray,_weaponDisplayName];
						};
			};	
			
		if (_type == 4096) then	//binos
			{
				W_BINOS set[_bino_index,[_cfgclass,_weaponDisplayName,_picture]];
				_displayArray set [count _displayArray,_weaponDisplayName];
				_bino_index = _bino_index + 1;
			};
		};
	};
	
_CfgWeapons 	= configFile >> "CfgMagazines" ;		//Build Magazine Array
for "_i" from 0 to (count _CfgWeapons - 1) do
	{
	_CfgWeapon = _CfgWeapons select _i;
	_weaponDisplayName 	= getText(_CfgWeapon >> "displayname");
	_cfgclass 			= (configName (_CfgWeapon));  
	_picture			= getText(_CfgWeapon >> "picture");
	if (isClass _CfgWeapon && (getNumber(_CfgWeapon>>"scope")==2) && (_picture!="")&& !(_weaponDisplayName=="")) then	{	
		if(getNumber(_CfgWeapon>>"count")>4) then {
				U_MAGAZINES set [_ammo_index,[_cfgclass,_weaponDisplayName,_picture]];
				_ammo_index = _ammo_index + 1;
			} else {
			switch (getNumber(_CfgWeapon>>"Type")) do { 
					case 16: {
						U_UNDERBARREL set [count U_UNDERBARREL,[_cfgclass,_weaponDisplayName,_picture]];
					};
					case 256: {
						U_GRENADE set [count U_GRENADE,[_cfgclass,_weaponDisplayName,_picture]];
					};
					default {
						U_EXPLOSIVE set [count U_EXPLOSIVE,[_cfgclass,_weaponDisplayName,_picture]];
					};
				};
			};
		};
	};
	
_CfgWeapons 	= configFile >> "CfgGlasses" ;			//Build glasses array
for "_i" from 1 to (count _CfgWeapons - 1) do
	{
	_CfgWeapon = _CfgWeapons select _i;
	_weaponDisplayName 	= getText(_CfgWeapon >> "displayname");
	_cfgclass 			= (configName (_CfgWeapon));  
	_picture			= getText(_CfgWeapon >> "picture");
	if (isClass _CfgWeapon && !(_picture=="") && !(_weaponDisplayName=="")) then 
		{	
		U_GLASSES set[_glasses_index,[_cfgclass,_weaponDisplayName,_picture]];
		_glasses_index = _glasses_index + 1;
		};
	};