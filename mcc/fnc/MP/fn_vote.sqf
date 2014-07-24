//==================================================================MCC_fnc_vote===============================================================================================
// Start a voting process.
// Example:[_question, _header , _variable] call MCC_fnc_vote;
// _question	 	String, rich Text - question to be shown
// _header  		String, rich text - header to be shown
// _variable		String, varibale name that will be change. 
//==================================================================================================================================================================================
private ["_question","_header","_variable","_answer"];
_question 	=_this select 0;
_header 	=_this select 1;
_variable 	=_this select 2;

_answer = ["<t font='PuristaMedium'>" + _question + "</t>",_header,"yes",true] call BIS_fnc_guiMessage;	
waituntil {!isnil "_answer"};

if (_answer) exitWith
{
	[[[_variable, missionNameSpace],1], "bis_fnc_counter", false, false] spawn BIS_fnc_MP;
};
