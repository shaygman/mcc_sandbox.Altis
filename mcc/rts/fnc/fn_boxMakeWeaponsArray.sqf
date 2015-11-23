//=================================================================MCC_fnc_boxMakeWeaponsArray==================================================================================
// _weaponType Integer, type of weapon/item to cut from
// _player Boolean is it a player or a box
//==============================================================================================================================================================================
disableSerialization;
private ["_weaponType","_type","_player","_box","_returnArray","_Cfg"];
_weaponType 	= _this select 0;
_player 		= _this select 1;

if !(_player) then {_box = _this select 2};

_returnArray = [];

_Cfg =if (_weaponType in [0,1,2,3,4,5,6,7,12]) then {
			 configFile >> "CfgWeapons";
		} else {
			 configFile >> "cfgMagazines";
		};

switch (_weaponType) do {
    case 0:			//Binos
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 4096) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 1:			//Items
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 131072 && ((getText(_Cfg >> _x >>"descriptionShort")!="") || (getNumber(_Cfg >> _x >>"mFact")==1))) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {items player} else {[_box] call MCC_fnc_getVirtualItemCargo});
    };

    case 2:			//Uniforms
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 131072 && !((getText(_Cfg >> _x >>"descriptionShort")!="") || (getNumber(_Cfg >> _x >>"mFact")==1))) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {items player} else {[_box] call MCC_fnc_getVirtualItemCargo});
    };

    case 3:			//Launchers
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 4) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 4:			//Machine Guns
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 1 && (getText(_Cfg >>"cursor")=="mg")) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 5:			//Pistols
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 2) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 6:			//Rifles
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 1 && !((getText(_Cfg >>"cursor")) in ["mg","srifle"])) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 7:			//Sniper rifles
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (_type == 1 && (getText(_Cfg >>"cursor")=="srifle")) then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {weapons player} else {[_box] call MCC_fnc_getVirtualWeaponCargo});
    };

    case 8:			//Magazines
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (getNumber(_Cfg>> _x >> "count")>4)  then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {magazines player} else {[_box] call MCC_fnc_getVirtualMagazineCargo});
    };

    case 9:			//Under Barrel
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (getNumber(_Cfg>> _x >> "count")<4 && (_type == 16))  then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {magazines player} else {[_box] call MCC_fnc_getVirtualMagazineCargo});
    };

    case 10:			//Grenade
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (getNumber(_Cfg>> _x >> "count")<4 && (_type == 256))  then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {magazines player} else {[_box] call MCC_fnc_getVirtualMagazineCargo});
    };

    case 11:			//Explosives
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (getNumber(_Cfg>> _x >> "count")<4 && !(_type in [16,256,1111]))  then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {magazines player} else {[_box] call MCC_fnc_getVirtualMagazineCargo});
    };

    case 12:			//survival
    {
    	{
    		_type = getNumber(_Cfg >> _x >> "type");
    		if (getText(_Cfg>> _x >> "mcc_surviveType") != "")  then {
	    		 _returnArray pushback [getText(_Cfg >> _x >> "displayname"), _x, getText(_Cfg >> _x >> "picture"), getNumber(_Cfg >> _x >> "value")];
			};
    	} forEach (if (_player) then {items player} else {[_box] call MCC_fnc_getVirtualItemCargo});
    };
};

_returnArray;