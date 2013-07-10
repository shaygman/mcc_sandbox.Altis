private['_handled'];

_handled = false;
_button = _this select 1;

if(_button in actionKeys "showMap" || _button in actionKeys "hideMap") then{
	[] spawn {
		WaitUntil{visibleMap};
		hintSilent parseText format["<t size='1.0' font='Zeppelin33' color='#ffffff'><t underline='1'>Your position:</t><br/><br/>x-ray: %1<br/>yankee: %2</t>",round (getPos player select 0), round (getPos player select 1)];
		WaitUntil{not visibleMap};
		hintSilent "";
	};
};

_handled