/*================================================================MCC_fnc_supressionEffects================================================================================
  Effects of being supressed
  IN <>
    hit
*/
private ["_blurEffects"];
params ["_ratio","_dir"];

//Hit direction
if (missionNamespace getVariable ["MCC_hitRadar",false]) then {
	switch (true) do
	{
		case (_dir > 315 || _dir <= 45):
		{
			(["MCC_rssHitUp"] call BIS_fnc_rscLayer) cutRsc ["MCC_rssHitUp", "PLAIN"];
		};

		case (_dir > 45 && _dir <= 135):
		{
			(["MCC_rssHitRight"] call BIS_fnc_rscLayer) cutRsc ["MCC_rssHitRight", "PLAIN"];
		};

		case (_dir > 135 && _dir <= 225):
		{
			(["MCC_rssHitDown"] call BIS_fnc_rscLayer) cutRsc ["MCC_rssHitDown", "PLAIN"];
		};

		default
		{
			(["MCC_rssHitLeft"] call BIS_fnc_rscLayer) cutRsc ["MCC_rssHitLeft", "PLAIN"];
		};
	};
};

// RBlur
_blurEffects = ppEffectCreate ["DynamicBlur", 440];
_blurEffects ppEffectAdjust [_ratio];
_blurEffects ppEffectEnable true;

_blurEffects ppEffectCommit 0;

enableCamShake true;
resetCamShake;
addCamShake [(_ratio * 5),_ratio, _ratio*80];

sleep 0.5;
ppEffectDestroy [_blurEffects];