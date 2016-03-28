//===================================================================MCC_fnc_artillery======================================================================================
// Create an artillery shell above the location
// Example:[[_pos, shelltype, shellspread, nshell,simulate],"MCC_fnc_artillery",true,false] spawn BIS_fnc_MP;
// Params:
// 	_pos: array, position
// 	shelltype: string, vehicleClass ["GrenadeHand","Sh_120_HE","Cluster_120mm_AMOS","Mo_cluster_AP","Mine_120mm_AMOS_range","Sh_120mm_AMOS_LG","Sh_82mm_AMOS","Fire_82mm_AMOS","Smoke_120mm_AMOS_White","Smoke_82mm_AMOS_White","G_40mm_SmokeGreen","G_40mm_SmokeRed","F_40mm_White""F_40mm_Green","F_40mm_Red"];
//	shellspread: number, 1st: weapon class 2nd: ammount [["weaponClass1","weaponClass2"],[1,5]]
//	nshell: number, ammount of artillery per salvo
//	simulate: number, shell simulation 0-DPICM, 1- bomb, 2 - flare, 3 - laser guided
//==============================================================================================================================================================================

private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell","_lasertargets","_nul","_x","_simulate","_delay"];
_pos					 = _this select 0;
_shelltype 			     = _this select 1;
_shellspread			 = _this select 2;
_nshell 				 = _this select 3;
_simulate				 = _this select 4;
_delay					 = _this select 5;

_sound = true;

switch (_simulate) do {
	case 0:	//DPICM
    {
		[_pos, _shelltype, _shellspread, _nshell, _sound,_delay] spawn MCC_fnc_artyDPICM;
	};

	case 1:	//Bomb
    {
		[_pos, _shelltype, _shellspread, _nshell, _sound,_delay] spawn MCC_fnc_artyBomb;
	};

	case 2:	//FLare
    {
		[_pos, _shelltype, _shellspread, _nshell, _sound,_delay] spawn MCC_fnc_artyFlare;
	};

	case 3:	// Laser-guided
    {
		_sound = true;
		_lasertargets = [];

		for [{_x = 0},{_x < _nshell},{_x = _x+1}] do
		{
			_lasertargets = nearestObjects[_pos,["LaserTarget"],500];

			//No laser target act as normal barage
			if (count _lasertargets == 0) then
			{
				[_pos, _shelltype, _shellspread, 1, _sound] spawn MCC_fnc_artyBomb;
			};

			//Laser target lock on LT
			if (!isnull (_lasertargets select 0)) then
			{
				_nul=[(_lasertargets select 0), [_pos select 0, _pos select 1, 200],_shelltype,100,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
			};

			sleep _delay;
		};
	};
};
