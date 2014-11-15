//==================================================================MCC_fnc_interactUtility===============================================================================================
// Interaction with utility object
// Example: [_object] spawn MCC_fnc_interactUtility; 
//=================================================================================================================================================================================
private ["_object","_array","_ok","_ctrl","_class","_displayname","_pic","_index"];
disableSerialization;
_object 	= _this select 0;
if (vehicle player != player) exitWith {};

if (MCC_interactionKey_holding && !(_object getVariable ["MCC_isInteracted",false]) && (player distance  _object < 5) && !dialog) exitWith
{
	MCC_fnc_ManMenuClicked =
	{
		private ["_ctrl","_index","_ctrlData","_object","_objectAmmo"];
		disableSerialization;

		_ctrl 		= _this select 0;
		_index 		= _this select 1;
		_ctrlData	= _ctrl lbdata _index;
		
		_object = (player getVariable ["interactWith",[]]) select 0;
		_objectAmmo = _object getVariable ["ammoLeft",getNumber (configFile / "CfgVehicles" / typeof _object / "ammo")];
		closeDialog 0;
		
		switch (_ctrlData) do
		{	
			case "resupply":		
			{
				//Add magazines
				private ["_magazineCount","_magazineClass","_magazines","_trashHold","_weapon","_cost"];
				player playactionNow "putdown";
				{
					_weapon = _x;
					if (_weapon != "") then
					{
						_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
						_magazineClass = _magazines select (0 min (count _magazines - 1));
						_magazineCount = {_x == _magazineClass} count magazines player; 
						switch _foreachIndex do
						{
							case 0 : {_trashHold = 2; _cost = 30};
							case 1 : {_trashHold = 2; _cost = 5};
							case 2 : {if ((getText((configFile / "CfgWeapons" / _weapon / "cursor")) == "mg")) then {_trashHold = 4; _cost = 20} else {_trashHold = 8; _cost = 10}};
						};

						if (_magazineCount < _trashHold) then
						{
							for "_i" from _magazineCount to (_trashHold-1) do
							{
								player addMagazine _magazineClass;
								_objectAmmo = _objectAmmo - _cost;
								if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
							};
						};
					};
				} foreach [secondaryWeapon player,handgunWeapon player, primaryWeapon player]; 
				if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
				_object setVariable ["ammoLeft",_objectAmmo];
			};
		};
	};
	
	_array = [["resupply","Resupply",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];
	

	//Manage array
	_object setVariable ["MCC_isInteracted",true,true]; 
	_ok = createDialog "MCC_INTERACTION_MENU";
	waituntil {dialog};

	_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
	_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];	
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
	} foreach _array;
	_ctrl lbSetCurSel 0;
	
	player setVariable ["interactWith",[_object]];
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_ManMenuClicked"];
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];  
	_object setVariable ["MCC_isInteracted",false,true]; 
};

player setVariable ["MCC_interactionActive",false]; 