private ["_caller","_index", "_groupSide", "_group","_hijackedSide"];
If (!(isPlayer _caller) || !(local player)) exitWith{};

_caller = _this select 0;	//Who activate the script
_index = _this select 2;
_hijackedSide = side _caller;

switch (format ["%1", Prev_Side]) do 
	{
	case "EAST": //East
		{
		_groupSide = east;
		}; 
		
	case "WEST": //West
		{
		_groupSide = west;
		};
		
	case "GUER": //Resistance
		{
		_groupSide = resistance;
		};
	};
	
_group = creategroup _groupSide;
[Prev_Player] joinSilent _group;
[_caller] joinSilent _group;
_caller removeaction MCC_backToplayerIndex; 
_caller removeaction mcc_actionInedx; 
_group selectLeader player;
selectPlayer Prev_Player;
deleteGroup _group;

_group = creategroup _hijackedSide;
[_caller] joinSilent _group;
deleteGroup _group;
player setcaptive false; 
