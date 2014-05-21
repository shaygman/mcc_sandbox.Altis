//===================================================================MCC_fnc_keyToName=========================================================================================
// get idkKey and return string with his name
// Example: [19] call MCC_fnc_keyToName
// Params:
// 	idkKey
// Returns:
//     <_text>
//==============================================================================================================================================================================	
 private ["_dikCode","_text"];

 _dikCode 	= _this select 0;
 
_text = switch (_dikCode) do	
{
	case 2:{"1"};
	case 3:{"2"};
	case 4:{"3"};
	case 5:{"4"};
	case 6:{"5"};
	case 7:{"6"};
	case 8:{"7"};
	case 9:{"8"};
	case 10:{"9"};
	case 11:{"10"};
	case 12:{"-"};
	case 13:{"="};
	case 14:{"Backspace"};
	case 15:{"Tab"};
	case 16:{"Q"};
	case 17:{"W"};
	case 18:{"E"};
	case 19:{"R"};
	case 20:{"T"};
	case 21:{"Y"};
	case 22:{"U"};
	case 23:{"I"};
	case 24:{"O"};
	case 25:{"P"};
	case 26:{"["};
	case 27:{"]"};
	case 58:{"Caps"};
	case 30:{"A"};
	case 31:{"S"};
	case 32:{"D"};
	case 33:{"F"};
	case 34:{"G"};
	case 35:{"H"};
	case 36:{"J"};
	case 37:{"K"};
	case 38:{"L"};
	case 39:{";"};
	case 40:{"'"};
	case 41:{"`"};
	case 43:{"\"};
	case 44:{"Z"};
	case 45:{"X"};
	case 46:{"C"};
	case 47:{"V"};
	case 48:{"B"};
	case 49:{"N"};
	case 50:{"M"};
	case 51:{"<"};
	case 52:{">"};
	case 53:{"/"};
	case 51:{"<"};
	case 57:{"Space"};
	case 210:{"Insert"};
	case 199:{"Home"};
	case 201:{"PageUp"};
	case 209:{"PageDown"};
	case 207:{"End"};
	case 211:{"Delete"};
	case 183:{"PrtScn"};
	case 70:{"ScrLk"};
	case 197:{"Pause"};
	case 69:{"NumLock"};
	case 181:{"/"};
	case 55:{"*"};
	case 74:{"-(NL)"};
	case 78:{"+(NL)"};
	case 156:{"Enter(NL)"};
	case 71:{"7(NL)"};
	case 72:{"8(NL)"};
	case 73:{"9(NL)"};
	case 75:{"4(NL)"};
	case 76:{"5(NL)"};
	case 77:{"6(NL)"};
	case 79:{"1(NL)"};
	case 80:{"2(NL)"};
	case 81:{"3(NL)"};
	case 82:{"0(NL)"};
	case 83:{".(NL)"};
	case 200:{"Up"};
	case 203:{"Left"};
	case 208:{"Down"};
	case 205:{"Right"};
	default {""};
};

_text
