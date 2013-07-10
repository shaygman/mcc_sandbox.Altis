if (MCC_teleportToTeam) then 
	{
		hint "Teleporting";
		if (player == (leader player)) then 
		   { 
			 player setPos (getPos (((units player) - [player]) select 0));
		   }
		else
			{
			player setPos (getPos (leader player)); 
			};
		MCC_teleportToTeam = false;
	} else {hint "Telpeport is N/A"};
