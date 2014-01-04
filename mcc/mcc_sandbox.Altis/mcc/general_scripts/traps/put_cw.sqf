private ["_pos", "_iedside","_trapkind","_group","_sb","_weaponList","_randWeapon","_weapon","_mag"];
_pos = _this select 0; 
_iedside = _this select 1; 
_trapkind = _this select 2;

_weaponList = [["Makarov", "8Rnd_9x18_Makarov"],["Colt1911", "7Rnd_45ACP_1911"],["M9", "15Rnd_9x19_M9"],["Sa61_EP1", "20Rnd_B_765x17_Ball"],["UZI_EP1", "30Rnd_9x19_UZI"],["glock17_EP1", "17Rnd_9x19_glock17"],["revolver_EP1", "6Rnd_45ACP"]];
_randWeapon = floor random (count _weaponList);
_weapon = (_weaponList select _randWeapon) select 0;
_mag = (_weaponList select _randWeapon) select 1;

_group = creategroup civilian;
_sb = _trapkind createunit [_pos, _group,";removeallweapons this;_null = [this,_iedside,25,_weapon,_mag] execVM '\mcc_sandbox_mod\mcc\general_scripts\traps\cw.sqf';removeallweapons this; this setbehaviour 'CARELESS'; this allowfleeing 0; this addaction ['Neutralize Suspect','\mcc_sandbox_mod\mcc\general_scripts\traps\neutralize.sqf'];",0.5];
_sb addrating -1;
publicvariable "disarm";
_sb setposatl _pos;
_sb setdir random 360;

