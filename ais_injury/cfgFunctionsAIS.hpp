#define addf(fname) class fname {headerType = -1;}

createShortcuts = 1;
class tcb_ais {
	tag = "tcb";
	class ais {
		file = "ais_injury\func";
		addf(handleDamage);
		addf(keyUnbind);
		addf(firstAid);
		addf(isHealable);
		addf(progressBar);
		addf(isMedic);
		addf(drag);
		addf(carry);
		addf(drop);
		addf(injuredEffects);
		addf(progressBarInit);
		addf(sendaihealer);
		addf(delbody);
		addf(quote);
		addf(deadcam);
		addf(lookingForWoundedMates);
		addf(checklauncher);
	};
};