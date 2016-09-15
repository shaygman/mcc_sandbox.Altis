//==================================================================MCC_fnc_PDAcreatemarker===============================================================================================
// Example:[_question, _header , _variable] call MCC_fnc_PDAcreatemarker;
//==================================================================================================================================================================================
#define MCC_HELPER "UserTexture1m_F"

private ["_markerName","_mark","_path","_pos","_type","_text","_time","_index","_color","_helpersArray","_helper"];
_markerName =_this select 0;
_path	 	=_this select 1;
_pos	 	=_this select 2;
_type	 	=_this select 3;
_text	 	=_this select 4;
_time	 	=_this select 5;
_color	 	=_this select 6;


_mark = createmarkerlocal [_markerName,_pos];
_markerName setmarkertypelocal format ["%1%2", _path, _type];
_markerName setmarkerTextlocal _text;
_markerName setmarkercolorlocal _color;

_helper = MCC_HELPER createVehicle _pos;
_helper setpos _pos;
_helper setVariable ["icon",format ["%1%2", _path, _type]];

_helpersArray = missionNamespace getVariable ["MCC_knownTargetsTags",[]];
_helpersArray pushBack _helper;
missionNamespace setVariable ["MCC_knownTargetsTags",_helpersArray];


[_markerName, _helper] spawn {
	private ["_helper","_helpersArray"];
	sleep 120;
		//deleteMarker
		deletemarkerlocal (_this select 0);

		//deleteHelper
		_helper = (_this select 1);
		deleteVehicle _helper;
		_helpersArray = missionNamespace getVariable ["MCC_knownTargetsTags",[]];

		for "_i" from 0 to (count _helpersArray)-1 step 1 do {
			if (isNull (_helpersArray select _i)) then {
				_helpersArray set [_i,-1];
			};
		};

		_helpersArray = _helpersArray - [-1];
		missionNamespace setVariable ["MCC_knownTargetsTags",_helpersArray];
};