/*=================================================================MCC_fnc_surviveUseItemHeadTorch===============================================================================
  Create a water head tourch over the player
  <In>
  		_itemCLass: 		STRING magazine class will not be removed on use.
  		_mod: 				INTEGER 0 - light tourch, 1 - turn off tourch, 2- change battery
*/
private ["_returnItem","_mod","_light"];
_itemClass =  param [0,"",[""]];
_mod =  param [1,0,[0]];

switch _mod do {
    case 0: {
    	_light = "#lightpoint" createVehicle [0,0,0];
		_light setLightIntensity 1000;
		_light setLightAmbient [0.01, 0.01, 0.01];
		_light setLightColor [0.8, 0.8, 0.8];
		_light attachto [player,[0,0.3,2]];
		_light setLightAttenuation [1,2,1,1,3,30];
		player setVariable ["MCC_headTorch",_light];
    };

    case 1: {
    	_light = player getVariable ["MCC_headTorch",objNull];
		deleteVehicle _light;
    };

    case 2: {
      _itemClass = "MCC_battery";
    	switch (true) do {
        case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {player removeMagazine _itemClass;};
        case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {player removeItem _itemClass;};
        case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {player removeItem _itemClass;};
      };
    	player setVariable ['MCC_headTorchBattery',100];
    };
};