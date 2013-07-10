private ["_cmd","_comboBox","_spawnArray","_spawn","_groupName","_groupArray","_group","_array"];
disableSerialization;

#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD")
#define CP_squadPanelSquadList (uiNamespace getVariable "CP_squadPanelSquadList")
#define CP_squadPanelPlayersList (uiNamespace getVariable "CP_squadPanelPlayersList")
#define CP_squadsPanelActiveSquadTittle (uiNamespace getVariable "CP_squadsPanelActiveSquadTittle")
#define CP_squadPanelJoinButton (uiNamespace getVariable "CP_squadPanelJoinButton")
#define CP_squadPanelCreateSquadText (uiNamespace getVariable "CP_squadPanelCreateSquadText")
#define CP_squadPanelCreateSquadButton (uiNamespace getVariable "CP_squadPanelCreateSquadButton")

_cmd = _this select 0; 
//Build dummy array with only the groups in it
_array = []; 
{
	_array set [count _array, _x select 0]; 
} foreach (if ((side player)== west) then {CP_westGroups} else {CP_eastGroups}); 
switch (_cmd) do
	{
		case 0:				//LBL change on Squad List
		{ 
			CP_squadListIndex = (lbCurSel CP_squadPanelSquadList);
			deletemarkerlocal "squadSelected";
			_spawnArray	 = if (side player == west) then {CP_westGroups} else {CP_eastGroups};  
			_spawn		 = _spawnArray select (lbCurSel CP_squadPanelSquadList);
			CP_activeGroup = _spawn; 
			CP_squadsPanelActiveSquadTittle ctrlSetText (CP_activeGroup select 1);
		};
		
		case 1:				//Join/Leave button pressed
		{ 
			if ((ctrlText CP_squadPanelJoinButton) == "Join Squad") then {
				[player] join (CP_activeGroup select 0);
				} else {
						if (count (units (group player)) == 1) then {			//Work around for destroying empty groups
							_groupName 	= (CP_activeGroup select 1); 
							[player] join grpNull;
							_group = creategroup (side player); 
							(if ((side player)== west) then {CP_westGroups} else {CP_eastGroups}) set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]];
							} else	{
									[player] join grpNull;
								};

						}; 
		};
		
		case 2:				//Switch side
		{ 
			//check if player in group
			if ((count (units (group player)) > 0) && ((group player) in _array)) exitWith {
				player sidechat "You must leave your squad before changing sides"; 
				}; 
				
			//check if there is room in the other side
			if ((playersNumber (if ((side player)== west) then {east} else {west})) >= CP_maxPlayers) exitWith {
				player sidechat "Opposite side is full"; 
				};
				
			//Make the switch
			_group = creategroup (if ((side player)== west) then {east} else {west});
			[player] join _group;
			_group = grpNull;
			deleteGroup _group;
			player sidechat format["You are now part of the %1 side", side player]; 
		};
		
		case 3:				//Create Squad
		{ 
			if (ctrlText CP_squadPanelCreateSquadButton ==  "Rename Squad") then {
				if (ctrlText CP_squadPanelCreateSquadText == "") exitWith {player sidechat "Squad name can't be empty"}; 
				if (side player == west) then {CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,ctrlText CP_squadPanelCreateSquadText]]} else	{
					CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,ctrlText CP_squadPanelCreateSquadText]]
					};
				} else {
				
					//check if player in group
					if ((count (units (group player)) > 0) && ((group player) in _array)) exitWith {
						player sidechat "You must leave your squad first"; 
						}; 
						
					//check if there is room to make another squad
					if ((count (if ((side player)== west) then {CP_westGroups} else {CP_eastGroups})) >= CP_maxSquads) exitWith {
						player sidechat format ["Max number of squads reached %1/%2", count (if ((side player)== west) then {CP_westGroups} else {CP_eastGroups}), CP_maxSquads]; 
						};
						
					//Create a new squad
					_group = creategroup (side player);
					if (ctrlText CP_squadPanelCreateSquadText == "") exitWith {player sidechat "Squad name can't be empty"}; 
					[player] join _group;
					if (side player == west) then {
						CP_westGroups set [count CP_westGroups,[_group,ctrlText CP_squadPanelCreateSquadText]];
						publicvariable "CP_westGroups";
						} else {
							CP_eastGroups set [count CP_eastGroups,[_group,ctrlText CP_squadPanelCreateSquadText]];
							publicvariable "CP_eastGroups";
							}; 
					player sidechat format ["Squad %1 Created",ctrlText CP_squadPanelCreateSquadText, _group];
				};
		};
	};
	
//Load active Players
_comboBox = CP_squadPanelPlayersList; 
lbClear _comboBox;
	{
		_displayname = if (_x == leader (CP_activeGroup select 0)) then {format ["(Leader) %1",name _x]} else {name _x};
		_index = _comboBox lbAdd _displayname;
		if (_x == player) then {_comboBox lbSetColor [_index, [0, 1, 0, 0.5]]};
	} foreach units (CP_activeGroup select 0);