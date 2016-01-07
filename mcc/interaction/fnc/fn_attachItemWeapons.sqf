/*==================================== MCC_fnc_attachItemWeapons ==========================
	Attach items to weapon
	<IN>
		_itemsClass (_this select 0): 	STRING magazine class.
		_attach (_this select 1):		BOOLEAN true - attach/false - detach
		_type (_this select 2):			STRING true attachment config  ["muzzleslot","pointerslot","cowsslot","underbarrelslot"]

	<OUT>
		Nothing
===========================================================================================*/
private ["_ammo","_itemClass","_attach","_type","_index","_gesture","_sleep"];
_itemClass = param [0,"",[""]];
_attach = param [1,true,[true]];
_type = toLower (param [2,"",[""]]);

if (_type == "") exitWith {};

_index = ["muzzleslot","pointerslot","cowsslot","underbarrelslot"] find _type;

//stuck on prone animation make him stand
if (stance player == "PRONE" && _type in ["cowsslot","pointerslot"]) then {
	player playActionNow "PlayerCrouch";
	sleep 1;
};

if (_attach) then {

	switch (_type) do {
	    case "muzzleslot": {
	    	_gesture ="GestureMountMuzzle";
	    	_sleep = 1.5;
	    };
	    case "cowsslot": {
	    	_gesture ="MountOptic";
	    	_sleep = switch toLower (stance player) do {
	    	    case "stand": {2};
	    	     case "crouch": {2.1};
	    	      case "prone": {1.5};
	    	    default {3};
	    	};
	    };
	    case "pointerslot": {
	    	_gesture ="MountSide";
	    	_sleep = switch toLower (stance player) do {
	    	    case "stand": {4};
	    	     case "crouch": {12};
	    	      case "prone": {1.5};
	    	    default {3};
	    	};
	    };
	    default {
	    	_gesture ="GestureMountMuzzle";
	    	_sleep = 1.5;
	    };
	};

	player playAction _gesture;
	sleep _sleep;
	player removeItem _itemClass;
	player addPrimaryWeaponItem _itemClass;
} else {
	_itemClass = (primaryWeaponItems player) select _index;
	switch (_type) do {
	    case "muzzleslot": {
	    	_gesture ="GestureDismountMuzzle";
	    	_sleep = 1.5;
	    };
	    case "cowsslot": {
	    	_gesture ="DismountOptic";
	    	_sleep = switch toLower (stance player) do {
	    	    case "stand": {1.5};
	    	     case "crouch": {2.5};
	    	      case "prone": {1.5};
	    	    default {3};
	    	};
	    };
	    case "pointerslot": {
	    	_gesture ="DismountSide";
	    	_sleep = switch toLower (stance player) do {
	    	    case "stand": {4};
	    	     case "crouch": {14};
	    	      case "prone": {1.5};
	    	    default {3};
	    	};
	    };
	    default {
	    	_gesture ="GestureDismountMuzzle";
	    	_sleep = 1;
	    };
	};

	player playAction _gesture;
	sleep _sleep;
	player removePrimaryWeaponItem _itemClass;
	player addItem _itemClass;
};