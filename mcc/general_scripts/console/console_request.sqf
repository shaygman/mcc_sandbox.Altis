// By: Shay_gman
// Version: 1.1 (May 2012)
#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104

disableSerialization;
private ["_type","_mccdialog","_comboBox","_counter","_displayname","_index","_array","_arrayName","_cost","_selected","_available"];
_type = _this select 0;
_mccdialog = findDisplay mcc_playerConsole_IDD;
_available = false;

switch (_type) do {
	//AirDrop
   	case 0:	{
		_arrayName	= format ["MCC_ConsoleAirdropArray%1",side player];
		_array = missionNameSpace getVariable [_arrayName,[]];

		if (count _array > 0) then {
			_index = lbCurSel MCC_ConsoleAirdropAvailableTextBox_IDD;
			_selected = _array select _index;

			MCC_spawnkind = [(_selected select 0) select 0];
			MCC_planeType = [str (side player)];
			missionNamespace setVariable ["MCC_airdropIsParachute",(_selected select 2)];

			_cost = missionNamespace getVariable [str _selected,[]];

			//a buyable asset
			if (count _cost > 0) then {
				{
					_available = [playerSide, _x] call MCC_fnc_checkRes;
					if (!_available) exitWith {hint "Not Enough Resources"; sleep 5; hintSilent ""};
				} foreach _cost;
			} else {
				//Remove the action we just used
				_array set  [_index,-1];
				_array = _array - [-1];
				missionNameSpace setVariable [_arrayName,_array];
				publicvariable _arrayName;

				_available = true;
			};


			if (_available) exitWith {

				//remove resources
				[_cost] spawn MCC_fnc_baseResourceReduce;

				//supply drop with no helicopter simulation
				if ((toLower (MCC_planeType select 0)) == "") then {
					hint "Left click on the map to call support";
				} else {
					hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
				};

				MCC_CASrequestMarker = true;

				//fill list box for Airdrop Types
				_comboBox = _mccdialog displayCtrl MCC_ConsoleAirdropAvailableTextBox_IDD;
				lbClear _comboBox;
				_counter = 0;
				{
					_counter = _counter + 1;
					_displayname = format ["%1: ",_counter];
					{
						_displayname = format ["%1 %2, ",_displayname, getText(configFile >> "CfgVehicles" >> _x >> "displayname")];
					} foreach ((_x select 0) select 0);
					_displayname = _displayname;
					_pic = if (_x select 2 != 1) then {"\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa"} else {"\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"};
					_index = _comboBox lbAdd _displayname;
					_comboBox lbSetPictureRight [_index, _pic];

					//if we have a cost show the cost
					_cost = missionNamespace getVariable [str _x,[]];
					if (count _cost > 0) then {
						private _str = "";
						{
							_str = _str + (_x select 0) + " x " + str (_x select 1) + " ";
						} forEach _cost;

						_comboBox lbSetTooltip [_index, _str];

						private _available = false;
						{
							_available = [playerSide, _x] call MCC_fnc_checkRes;
							if (!_available) exitWith {_comboBox lbSetColor [_index, [0.311,0.311, 0.311, 0.8]]};
						} foreach _cost;
					};
				} foreach (missionNameSpace getVariable [_arrayName,[]]);
				_comboBox lbSetCurSel 0;

			};
		};
	};

	//CAS
    case 1: {
		_arrayName	= format ["MCC_CASConsoleArray%1",side player];
		_array = missionNameSpace getVariable [_arrayName,[]];

		if (count _array > 0) then {
			_index = lbCurSel MCC_ConsoleCASAvailableTextBox_IDD;
			_selected = _array select _index;

			MCC_spawnkind	= [(_selected select 0) select 0];
			MCC_planeType 	= [(_selected select 1) select 0];

			_cost = missionNamespace getVariable [str _selected,[]];

			//a buyable asset
			if (count _cost > 0) then {
				{
					_available = [playerSide, _x] call MCC_fnc_checkRes;
					if (!_available) exitWith {hint "Not Enough Resources"; sleep 5; hintSilent ""};
				} foreach _cost;
			} else {
				//Remove the action we just used
				_array set  [lbCurSel MCC_ConsoleCASAvailableTextBox_IDD,-1];
				_array = _array - [-1];
				missionNameSpace setVariable [_arrayName,_array];
				publicvariable _arrayName;

				_available = true;
			};

			if (_available) exitWith {
				//remove resources
				[_cost] spawn MCC_fnc_baseResourceReduce;
				if ((toLower (MCC_spawnkind select 0)) in ["cruise missile","uav","ac-130"]) then {
					hint "Left click on the map to call support";
				} else {
					hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
				};

				MCC_CASrequestMarker = true;

				sleep 1;
				//fill list box for CAS Types
				_comboBox = _mccdialog displayCtrl MCC_ConsoleCASAvailableTextBox_IDD;
				lbClear _comboBox;
				{
					_planeName = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "displayname");
					_pic = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "picture");
					_displayname = format [" %1",(_x  select 0) select 0];
					_index = _comboBox lbAdd _displayname;
					_comboBox lbSetPictureRight [_index, _pic];

					_cost = missionNamespace getVariable [str _x,[]];
					if (count _cost > 0) then {
						private _str = "";
						{
							_str = _str + (_x select 0) + " x " + str (_x select 1) + " ";
						} forEach _cost;

						_comboBox lbSetTooltip [_index, _str];

						private _available = false;
						{
							_available = [playerSide, _x] call MCC_fnc_checkRes;
							if (!_available) exitWith {_comboBox lbSetColor [_index, [0.311,0.311, 0.311, 0.8]]};
						} foreach _cost;
					} else {
						_comboBox lbSetTooltip [_index, _planeName];
					};

				} foreach (missionNameSpace getVariable [_arrayName,[]]);
				_comboBox lbSetCurSel 0;
			};
		};
	};
};



