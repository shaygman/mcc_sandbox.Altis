private ["_key","_x","_text"];
disableSerialization;
//Show key Binds
for [{_x=8415},{_x<=8421},{_x=_x+1}]  do {
	if (missionNamespace getVariable ["MCC_isCBA",false]) then {

		_text = "Use CBA Controls";
		ctrlEnable [_x, false];
		((findDisplay (_this select 0)) displayCtrl _x) ctrlSetTooltip "";

	} else {

		_index = _x-8415;
		if (_index < count (missionNamespace getVariable ["MCC_keyBinds",[]])) then {
			_key = (missionNamespace getVariable ["MCC_keyBinds",[]]) select (_x-8415);

			_text = "";
			if (_key select 0) then {_text = "Shift + "};
			if (_key select 1) then {_text = _text + "Ctrl + "};
			if (_key select 2) then {_text = _text + "Alt + "};

			_text = format ["%1%2",_text,keyName (_key select 3)];
		};
	};

	ctrlsettext [_x, _text];
};

//Disable cover system client side
ctrlEnable [8499,missionNamespace getVariable ["MCC_cover",false]];