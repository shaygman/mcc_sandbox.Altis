/*==================================== MCC_fnc_attachItemUniform ==========================
	Attach items to players uniforms such as chemlights
	<IN>
		_itemsClass (_this select 0): 	STRING magazine class.
		_attach (_this select 1):		BOOLEAN true - attach/false - detach

	<OUT>
		Nothing
===========================================================================================*/
private ["_ammo","_item","_itemClass","_attach"];
_itemClass = param [0,"",[""]];
_attach = param [1,true,[true]];

if (_attach) then {
	player removeMagazine _itemClass;
	_ammo = getText(configFile >> "cfgMagazines" >> _itemClass >> "ammo");
	_item = _ammo createVehicle [0,0,0];
	_item attachTo [player, [-0.05, 0, .09], "rightshoulder"];
	player setVariable ["MCC_playerAttachedGearItem",_item];
	player setVariable ["MCC_playerAttachedGearItemClass",_itemClass];
} else {
	_item = (player getVariable ["MCC_playerAttachedGearItem",objNull]);
	detach _item;
	_item setPos [-999,-999,-999];
	sleep 1;
	deleteVehicle _item;
	player addMagazine (player getVariable ["MCC_playerAttachedGearItemClass",""]);
};