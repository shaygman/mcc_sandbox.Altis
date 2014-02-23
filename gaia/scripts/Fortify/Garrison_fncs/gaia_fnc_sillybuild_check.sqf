_build = _this select 0;

_sillyarray = switch (typeof _build) do {

	case "Land_vez" : {[true,[2]]};
	case "Land_Misc_Cargo1Ao" : {[true,[1,2]]};
	case "Land_Misc_Cargo1Bo" : {[true,[1,2]]};
	case "Land_Misc_Cargo1Bo_military" : {[true,[1,2]]};
	case "Land_Misc_deerstand" : {[true,[0,1]]};
	case "Land_Vysilac_FM" : {[true,[0,2,4]]};
	case "Land_vysilac_FM2" : {[true,[0,2,4]]};
	case "Land_A_Crane_02a" : {[true,[0,1]]};
	case "Land_A_Crane_02b" : {[true,[]]};
	case "Land_Climbing_Obstacle" : {[true,[]]};
	case "Land_Ind_MalyKomin" : {[true,[0,2,4]]};
	default {[false]};


};

_sillyarray

