//==================================================================MCC_fnc_unlock===============================================================================================
// Check for gear unlocks and notify the player
// Example:[_newLevel] call MCC_fnc_unlock;
// _newLevel: integer, the current level of the player
//==================================================================================================================================================================================
private ["_string","_name","_rank","_displayname","_pic","_weapon","_wepArray","_wep","_weaponName","_weaponPic","_newLevel","_unlockLayer","_levelingLayer"];
_newLevel = _this select 0;

//refister layers
_unlockLayer = ["MCC_unlock"] call BIS_fnc_rscLayer;
_levelingLayer = ["MCC_unlock"] call BIS_fnc_rscLayer;

							
//Level notification
_name = name player;
_rank = [(floor (_newLevel/10)) min 6,"texture"] call BIS_fnc_rankParams;
playmusic "EventTrack01_F_Curator";
_string = format ["<t font='puristaMedium' size='1' color='#FFFFFF '><img size='2' image='%1'/><br/> Level %2 </t>",_rank, _newLevel];
[_string,0,-0.2,7,1,0,_levelingLayer] spawn BIS_fnc_dynamicText;


waituntil {!isnil "CP_currentWeaponArray"};
//New Gear notification
{
	for [{_i = 0},{_i < count _x},{_i = _i+1}] do 
	{
		_wep = _x select _i;
		if (_newLevel ==  _wep select 0) then 
		{
			sleep 10;
			_displayname 	= getText(configFile >> "CfgWeapons">> (_wep select 1) >> "displayname");
			_pic 			= getText(configFile >> "CfgWeapons">> (_wep select 1) >> "picture");

			playmusic "EventTrack01_F_Curator";
			_string = format ["<t font='puristaMedium' size='1' color='#FFFFFF '><img size='2' image='%1'/><br/>%2</t>",_pic, _displayname];
			[_string,0,-0.2,7,1,0,_unlockLayer] spawn BIS_fnc_dynamicText;
		};
	};
} foreach [CP_currentWeaponArray, CP_currentWeaponSecArray, CP_handguns, CP_currentItmes1, CP_currentUniforms select 0, CP_currentUniforms select 1, CP_currentUniforms select 3, CP_currentUniforms select 5];

//New Mag notification
{
	for [{_i = 0},{_i < count _x},{_i = _i+1}] do 
	{
		_wep = _x select _i;
		if (_newLevel ==  _wep select 0) then 
		{
			sleep 10;
			_displayname 	= getText(configFile >> "CfgMagazines">> (_wep select 1) >> "displayname");
			_pic 			= getText(configFile >> "CfgMagazines">> (_wep select 1) >> "picture");

			playmusic "EventTrack01_F_Curator";
			_string = format ["<t font='puristaMedium' size='1' color='#FFFFFF '><img size='2' image='%1'/><br/>%2<br/></t>",_pic, _displayname];
			[_string,0,-0.2,7,1,0,_unlockLayer] spawn BIS_fnc_dynamicText;
		};
	};
} foreach [CP_currentItmes2, CP_currentItmes3];

//New accessories notification
_weapon = primaryWeapon player;

if (!isnil "_weapon") then
{
	_weaponName = getText(configFile >> "CfgWeapons">> _weapon >> "displayname");
	_weaponPic	= getText(configFile >> "CfgWeapons">> _weapon >> "picture");
	
	_wepArray = call compile format ["CP_%1",_weapon]; 
	{
		for [{_i = 0},{_i < count _x},{_i = _i+1}] do 
		{
			_wep = _x select _i;
			if (_newLevel ==  _wep select 0) then 
			{
				sleep 10;
				_displayname 	= getText(configFile >> "CfgWeapons">> (_wep select 1) >> "displayname");
				_pic 			= getText(configFile >> "CfgWeapons">> (_wep select 1) >> "picture");

				playmusic "EventTrack01_F_Curator";
				_string = format ["<t font='puristaMedium' size='1' color='#FFFFFF '><img size='2' image='%1'/><br/>%2<br/></t><t font='puristaMedium' size='0.5' color='#FFFFFF '>(%4)</t>",_pic, _displayname, _weaponPic, _weaponName];
				[_string,0,-0.2,7,1,0,_unlockLayer] spawn BIS_fnc_dynamicText;
			};
		};
	} foreach _wepArray;
};