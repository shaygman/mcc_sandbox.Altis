// F3 - Folk Group Markers
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// JIP CHECK
// Prevents the script executing until the player has synchronised correctly:

#include "f_waitForJIP.sqf"

// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS

private ["_unitfaction"];

// ====================================================================================

// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores
// it in the private variable _unitfaction

_unitfaction = toLower (faction player);

// If the unitfaction is different from the group leader's faction, the latters faction is NOed
if (_unitfaction != toLower (faction (leader group player))) then {_unitfaction = toLower (faction (leader group player))};

// ====================================================================================

// PRECOMPILE
// Prevents the next script to be read by the engine everytime it's ised:

fnc_folk_localGroupMarker = compile preprocessFile "f\common\folk_localGroupMarker.sqf";
fnc_folk_localSpecialistMarker = compile preprocessFile "f\common\folk_localSpecialistMarker.sqf";

// ====================================================================================
switch (_unitfaction) do
{

// ====================================================================================

// MARKERS: NATO
// Markers seen by players in NATO slots.

	case "blu_f":
	{
		if (! isnil "GrpNO_CO") then {["GrpNO_CO", 0, "CO", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_DC") then {["GrpNO_DC", 0, "DC", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_ASL") then {["GrpNO_ASL", 0, "ASL", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_A1") then {["GrpNO_A1", 1, "A1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_A2") then {["GrpNO_A2", 1, "A2", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpNO_A3") then {["GrpNO_A3", 1, "A3", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpNO_BSL") then {["GrpNO_BSL", 0, "BSL", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_B1") then {["GrpNO_B1", 1, "B1", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_B2") then {["GrpNO_B2", 1, "B2", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_B3") then {["GrpNO_B3", 1, "B3", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_CSL") then {["GrpNO_CSL", 0, "CSL", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_C1") then {["GrpNO_C1", 1, "C1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_C2") then {["GrpNO_C2", 1, "C2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_C3") then {["GrpNO_C3", 1, "C3", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_MMG1") then {["GrpNO_MMG1", 2, "MMG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_MAT1") then {["GrpNO_MAT1", 3, "MAT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_MAA1") then {["GrpNO_MAA1", 3, "MAA1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_SF1") then {["GrpNO_SF1", 4, "SF1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_SF2") then {["GrpNO_SF2", 4, "SF2", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_SN1") then {["GrpNO_SN1", 4, "SN1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_SN2") then {["GrpNO_SN2", 4, "SN2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_ART1") then {["GrpNO_ART1", 3, "ART1", "ColorGreen"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpNO_ENG1") then {["GrpNO_ENG1",  6, "ENG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpNO_IFV1") then {["GrpNO_IFV1",  7, "IFV1", "ColorRed"] spawn fnc_folk_localGroupMarker};
 		if (! isnil "GrpNO_IFV2") then {["GrpNO_IFV2",  7, "IFV2", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_IFV3") then {["GrpNO_IFV3",  7, "IFV3", "ColorGreen"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpNO_TH1") then {["GrpNO_TH1",  8, "TH1", "ColorOrange"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpNO_AH1") then {["GrpNO_AH1",  8, "AH1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpNO_DT1") then {["GrpNO_DT1",  4, "DT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};

		if (! isnil "UnitNO_CO_M") then {["UnitNO_CO_M", 0, "COM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitNO_DC_M") then {["UnitNO_DC_M", 0, "DCM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitNO_ASL_M") then {["UnitNO_ASL_M", 0, "AM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};	
		if (! isnil "UnitNO_BSL_M") then {["UnitNO_BSL_M", 0, "BM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitNO_CSL_M") then {["UnitNO_CSL_M", 0, "CM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};

	};

// ====================================================================================
	
// MARKERS: Iran
// Markers seen by players in Iran slots.
	
	case "opf_f":
	{
		if (! isnil "GrpIR_CO") then {["GrpIR_CO", 0, "CO", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_DC") then {["GrpIR_DC", 0, "DC", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_ASL") then {["GrpIR_ASL", 0, "ASL", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_A1") then {["GrpIR_A1", 1, "A1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_A2") then {["GrpIR_A2", 1, "A2", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpIR_A3") then {["GrpIR_A3", 1, "A3", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpIR_BSL") then {["GrpIR_BSL", 0, "BSL", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_B1") then {["GrpIR_B1", 1, "B1", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_B2") then {["GrpIR_B2", 1, "B2", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_B3") then {["GrpIR_B3", 1, "B3", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_CSL") then {["GrpIR_CSL", 0, "CSL", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_C1") then {["GrpIR_C1", 1, "C1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_C2") then {["GrpIR_C2", 1, "C2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_C3") then {["GrpIR_C3", 1, "C3", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_MMG1") then {["GrpIR_MMG1", 2, "MMG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_MAT1") then {["GrpIR_MAT1", 3, "MAT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_MAA1") then {["GrpIR_MAA1", 3, "MAA1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_SF1") then {["GrpIR_SF1", 4, "SF1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_SF2") then {["GrpIR_SF2", 4, "SF2", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_SN1") then {["GrpIR_SN1", 4, "SN1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_SN2") then {["GrpIR_SN2", 4, "SN2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_ART1") then {["GrpIR_ART1", 3, "ART1", "ColorOrange"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpIR_ENG1") then {["GrpIR_ENG1",  6, "ENG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpIR_IFV1") then {["GrpIR_IFV1",  7, "IFV1", "ColorRed"] spawn fnc_folk_localGroupMarker};
 		if (! isnil "GrpIR_IFV2") then {["GrpIR_IFV2",  7, "IFV2", "ColorBlue"] spawn fnc_folk_localGroupMarker};	
 		if (! isnil "GrpIR_IFV3") then {["GrpIR_IFV3",  7, "IFV3", "ColorGreen"] spawn fnc_folk_localGroupMarker};

		if (! isnil "GrpIR_TH1") then {["GrpIR_TH1",  8, "TH1", "ColorOrange"] spawn fnc_folk_localGroupMarker};


		if (! isnil "GrpIR_AH1") then {["GrpIR_AH1",  8, "AH1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpIR_DT1") then {["GrpIR_DT1",  4, "DT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		
		if (! isnil "UnitIR_CO_M") then {["UnitIR_CO_M", 0, "COM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitIR_DC_M") then {["UnitIR_DC_M", 0, "DCM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitIR_ASL_M") then {["UnitIR_ASL_M", 0, "AM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};		
		if (! isnil "UnitIR_BSL_M") then {["UnitIR_BSL_M", 0, "BM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitIR_CSL_M") then {["UnitIR_CSL_M", 0, "CM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
	};
	
	case "ind_f":
	{
		if (! isnil "GrpGR_CO") then {["GrpGR_CO", 0, "CO", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_DC") then {["GrpGR_DC", 0, "DC", "ColorYellow"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_ASL") then {["GrpGR_ASL", 0, "ASL", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_A1") then {["GrpGR_A1", 1, "A1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_A2") then {["GrpGR_A2", 1, "A2", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpGR_A3") then {["GrpGR_A3", 1, "A3", "ColorRed"] spawn fnc_folk_localGroupMarker};		
		if (! isnil "GrpGR_BSL") then {["GrpGR_BSL", 0, "BSL", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_B1") then {["GrpGR_B1", 1, "B1", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_B2") then {["GrpGR_B2", 1, "B2", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_B3") then {["GrpGR_B3", 1, "B3", "ColorBlue"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_CSL") then {["GrpGR_CSL", 0, "CSL", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_C1") then {["GrpGR_C1", 1, "C1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_C2") then {["GrpGR_C2", 1, "C2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_C3") then {["GrpGR_C3", 1, "C3", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_MMG1") then {["GrpGR_MMG1", 2, "MMG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_MAT1") then {["GrpGR_MAT1", 3, "MAT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_MAA1") then {["GrpGR_MAA1", 3, "MAA1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_SF1") then {["GrpGR_SF1", 4, "SF1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_SF2") then {["GrpGR_SF2", 4, "SF2", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_SN1") then {["GrpGR_SN1", 4, "SN1", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_SN2") then {["GrpGR_SN2", 4, "SN2", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_ENG1") then {["GrpGR_ENG1",  6, "ENG1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_TH1") then {["GrpGR_TH1",  8, "TH1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_AH1") then {["GrpGR_AH1",  8, "AH1", "ColorRed"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_DT1") then {["GrpGR_DT1",  4, "DT1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_ART1") then {["GrpGR_ART1", 3, "ART1", "ColorOrange"] spawn fnc_folk_localGroupMarker};
		if (! isnil "GrpGR_IFV1") then {["GrpGR_IFV1",  7, "IFV1", "ColorRed"] spawn fnc_folk_localGroupMarker};
 		if (! isnil "GrpGR_IFV2") then {["GrpGR_IFV2",  7, "IFV2", "ColorBlue"] spawn fnc_folk_localGroupMarker};	
 		if (! isnil "GrpGR_IFV3") then {["GrpGR_IFV3",  7, "IFV3", "ColorGreen"] spawn fnc_folk_localGroupMarker};
		
		if (! isnil "UnitGR_CO_M") then {["UnitGR_CO_M", 0, "COM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitGR_DC_M") then {["UnitGR_DC_M", 0, "DCM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitGR_ASL_M") then {["UnitGR_ASL_M", 0, "AM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};		
		if (! isnil "UnitGR_BSL_M") then {["UnitGR_BSL_M", 0, "BM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
		if (! isnil "UnitGR_CSL_M") then {["UnitGR_CSL_M", 0, "CM", "ColorBlack"] spawn fnc_folk_localSpecialistMarker};
	};
};

// ====================================================================================

if (true) exitWith {};