
if ( isClass (configFile >> "CfgPatches" >> "mcc_sandbox") ) then { mcc_sandbox = true;[] execVM "\mcc_sandbox_mod\init.sqf"};
//if (isNil 'mcc_sandbox') then { mcc_sandbox = true;[] execVM "\mcc_sandbox_mod\init.sqf"};
