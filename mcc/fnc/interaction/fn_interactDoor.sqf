//==================================================================MCC_fnc_interactDoor===============================================================================================
// Interaction with Door type
// Example: [_object] spawn MCC_fnc_interactMan; 
//=================================================================================================================================================================================
private ["_object","_door","_optionalDoors","_suspectCorage","_typeOfSelected","_animation","_phase","_doorTypes","_isHouse","_loadName"];
#define MCC_CHARGE "DemoCharge_Remote_Mag"
disableSerialization;
_object 	= _this select 0;
_isHouse 	= _object isKindof "house";

if (_isHouse) then
{
	_doorTypes	= ["door", "hatch"];
	_loadName	= "GEOM";
}
else
{
	_doorTypes	= ["door", "ramps"];
	_loadName	= "FIRE"; 
};

_optionalDoors = [_object, _loadName] intersect [asltoatl (eyepos player),(player modelToworld [0, 3, 0])];
_door = "";
{
	_typeOfSelected = _x select 0;
	{
		if ([_x,_typeOfSelected] call BIS_fnc_inString) exitWith {_door = _typeOfSelected};
	} foreach _doorTypes;
	
} forEach _optionalDoors;

if (isnil "_door") exitWith {};

if (_isHouse) then
{
	_animation = _door + "_rot";
	_phase = if ((_object animationPhase _animation) > 0) then {0} else {1};
	
	//Open dialog
	if (MCC_interactionKey_holding && !dialog && _phase > 0) exitWith
	{
		MCC_fnc_DoorMenuClicked = 
		{
			private ["_ctrl","_index","_ctrlData","_object","_animation","_phase"];
			disableSerialization;
			#define MCC_CHARGE "DemoCharge_Remote_Mag"
			_ctrl 		= _this select 0;
			_index 		= _this select 1;
			_ctrlData	= _ctrl lbdata _index;
			
			_object = (player getVariable ["interactWith",[]]) select 0;
			_animation = (player getVariable ["interactWith",[]]) select 1;
			_phase = (player getVariable ["interactWith",[]]) select 2;
			
			//player sidechat getpos _door;
			switch (_ctrlData) do
			{	
				case "charge":		
				{
					closedialog 0;
					player removeMagazine MCC_CHARGE;
					player playMove "AinvPknlMstpSlayWrflDnon_medic";
					(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutRsc ["MCC_interactionPB", "PLAIN"];
					_ctrl = ((uiNamespace getVariable "MCC_interactionPB") displayCtrl 2);
					_ctrl ctrlSetText "Placing Charge";
					_ctrl = ((uiNamespace getVariable "MCC_interactionPB") displayCtrl 1);
					
					for [{_x=1},{_x<2},{_x=_x+0.1}]  do 
					{
						_ctrl progressSetPosition (_x/2); 
						if ((animationState player)!="AinvPknlMstpSlayWrflDnon_medic") then {player playMove "AinvPknlMstpSlayWrflDnon_medic"};
						sleep 0.1;
					};
					
					(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
					//player switchMove "AmovPknlMstpSlowWrflDnon";	
					player playMoveNow "AmovPknlMstpSlowWrflDnon";	
					
					_n = 2; 
					_position = ATLtoASL(player modelToworld [0,_n,1.5]);
					while {!lineIntersects [ATLtoASL(player modelToworld [0,0,1.5]), _position]} do
					{
						_n = _n - 0.1;
						_position = ATLtoASL(player modelToworld [0,_n,1.5]);
					};	
					_position = ATLtoASL(player modelToworld [0,_n-0.7,1.5]);
					_c4 = "ClaymoreDirectionalMine_Remote_Ammo_Scripted" createVehicle ATLtoASL _position;
					_c4 setpos aslToAtl _position;
					_c4 setdir (getdir player);
					//_c4 setVectorDirAndUp [[1,0,0],[0,-1,0]];
					player addAction ["<t color=""#FF0000"">Detonate Charge</t>", {
													player removeAction (_this select 2);
													((_this select 3) select 1) animate [((_this select 3) select 2), ((_this select 3) select 3)];
													sleep 1;
													((_this select 3) select 0) setDamage 1;
												}, [_c4,_object,_animation,_phase]];
				};
				
				case "close":		
				{
					closedialog 0;
				};
			};
		};
		
		_ok = createDialog "MCC_INTERACTION_MENU";
		waituntil {dialog};
		
		_ctrl = ((uiNamespace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
		_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.09* safezoneH];	
		_ctrl ctrlCommit 0;
		
		_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";
		
		lbClear _ctrl;
		{
			_class			= _x select 0;
			_displayname 	= _x select 1;
			_pic 			= _x select 2;
			_index 			= _ctrl lbAdd _displayname;
			_ctrl lbSetPicture [_index, _pic];
			_ctrl lbSetData [_index, _class];
		} foreach [["charge",format ["Place Breaching Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")],["camera","Mirror under the door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],["lock","Pick Lock","\A3\ui_f\data\map\groupicons\waypoint.paa"],["close","Close Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];
		_ctrl lbSetCurSel 0;
		
		player setVariable ["interactWith",[_object, _animation, _phase]];
		_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_DoorMenuClicked"];
	};
	
	_object animate [_animation, _phase];
}
else
{
	_phase = if ((_object doorPhase _door) > 0) then {0} else {1};
	player sidechat str _door;
	_object animateDoor [_door, _phase, false];
};