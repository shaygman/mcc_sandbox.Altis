private ["_cmd","_comboBox","_groupName","_groupArray","_group","_array","_groups","_role"];
disableSerialization;

#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD")
#define CP_squadPanelSquadList (uiNamespace getVariable "CP_squadPanelSquadList")
#define CP_squadPanelPlayersList (uiNamespace getVariable "CP_squadPanelPlayersList")
#define CP_squadsPanelActiveSquadTittle (uiNamespace getVariable "CP_squadsPanelActiveSquadTittle")
#define CP_squadPanelJoinButton (uiNamespace getVariable "CP_squadPanelJoinButton")
#define CP_squadPanelCreateSquadText (uiNamespace getVariable "CP_squadPanelCreateSquadText")
#define CP_squadPanelCreateSquadButton (uiNamespace getVariable "CP_squadPanelCreateSquadButton")

_cmd = _this select 0; 

_groups	 = switch (side player) do	
			{
				case west:			{CP_westGroups};
				case east:			{CP_eastGroups};
				case resistance:	{CP_guarGroups};
			};
				
//Build dummy array with only the groups in it
_array = []; 
{
	_array set [count _array, _x select 0]; 
} foreach _groups; 
switch (_cmd) do
{
	case 0:				//LBL change on Squad List
	{ 
		CP_squadListIndex = (lbCurSel CP_squadPanelSquadList);
		deletemarkerlocal "squadSelected";
		CP_activeGroup	 = _groups select (lbCurSel CP_squadPanelSquadList);
		CP_squadsPanelActiveSquadTittle ctrlSetText (CP_activeGroup select 1);
	};
	
	case 1:				//Join/Leave button pressed
	{ 
		if ((ctrlText CP_squadPanelJoinButton) == "Join Squad") then 
		{
			if (!isnull (CP_activeGroup select 0)) then 
			{
				[player] join (CP_activeGroup select 0);
				(CP_activeGroup select 0) setGroupId [(CP_activeGroup select 1),"GroupColor0"];
			};
		} 
		else 
		{
			//Work around for destroying empty groups
			if (count (units (group player)) == 1) then 
			{			
				_groupName 	=  if ((lbCurSel CP_squadPanelSquadList) < (count CP_defaultGroups)) then {(CP_activeGroup select 1)} else {"--Empty Squad--"}; 
				[player] join grpNull;
				_group = creategroup (side player); 
				waituntil {!isnil "_group"};
				_group setVariable ["MCC_CPGroup",true,true]; 
				
				if ((side player)== west) then {CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_westGroups"};
				if ((side player)== east) then {CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_eastGroups"};
				if ((side player)== resistance) then {CP_guarGroups set [(lbCurSel CP_squadPanelSquadList),[_group,_groupName]]; publicVariable "CP_guarGroups"};
			} 
			else
			{
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
		if ((playersNumber (if ((side player)== west) then {east})) >= CP_maxPlayers) exitWith {
			player sidechat "East side is full"; 
			};
			
		//check if there is room in the other side
		if ((playersNumber (if ((side player)== east) then {resistance})) >= CP_maxPlayers) exitWith {
			player sidechat "Resistance side is full"; 
			};
			
		//check if there is room in the other side
		if ((playersNumber (if ((side player)== resistance) then {west})) >= CP_maxPlayers) exitWith {
			player sidechat "West side is full"; 
			};
			
		//Make the switch
		_group = creategroup (switch (side player) do	{
				case west:			{east};
				case east:			{resistance};
				case resistance:	{west};
			});
		[player] join _group;
		_group = grpNull;
		deleteGroup _group;
		player sidechat format["You are now part of the %1 side", side player];
		CP_weaponAttachments =[];		//Reset atachments choice
		CP_playerUniforms =  nil;
		CP_opticsIndex = 0;
		CP_barrelIndex = 0;
		CP_attachsIndex = 0;
		CP_weaponAttachments =[]; 
		[CP_classesIndex,0] call CP_fnc_setGear; 
	};
	
	case 3:				//Create Squad
	{
		if (ctrlText CP_squadPanelCreateSquadText == "") exitWith {player sidechat "Squad name can't be empty"}; 
		if (ctrlText CP_squadPanelCreateSquadButton ==  "Rename Squad") then {
			switch (side player) do	{
				case west:			{CP_westGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,ctrlText CP_squadPanelCreateSquadText]]};
				case east:			{CP_eastGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,ctrlText CP_squadPanelCreateSquadText]]};
				case resistance:	{CP_guarGroups set [(lbCurSel CP_squadPanelSquadList),[CP_activeGroup select 0,ctrlText CP_squadPanelCreateSquadText]]};
				};
			} else {
			
				//check if player in group
				if ((count (units (group player)) > 0) && ((group player) in _array)) exitWith {
					player sidechat "You must leave your squad first"; 
					}; 
					
				//check if there is room to make another squad
				if ((count _groups) >= CP_maxSquads) exitWith {
					player sidechat format ["Max number of squads reached %1/%2", count _groups, CP_maxSquads]; 
					};
					
				//Create a new squad
				_group = creategroup (side player);
				[player] join _group;
				switch (side player) do	{
						case west:			{CP_westGroups set [count CP_westGroups,[_group,ctrlText CP_squadPanelCreateSquadText]];
												publicvariable "CP_westGroups";};
						case east:			{CP_eastGroups set [count CP_eastGroups,[_group,ctrlText CP_squadPanelCreateSquadText]];
												publicvariable "CP_eastGroups";};
						case resistance:	{CP_guarGroups set [count CP_guarGroups,[_group,ctrlText CP_squadPanelCreateSquadText]];
										publicvariable "CP_guarGroups";};
					};
				(CP_activeGroup select 0) setGroupId [(CP_activeGroup select 1),"GroupColor0"];
				player sidechat format ["Squad %1 Created",ctrlText CP_squadPanelCreateSquadText, _group];
			};
	};
};