/*
###########################################
Basic Modifications
###########################################
*/

Godmode()//works fine
{
    self.godmode = isDefined(self.godmode) ? undefined : true;
 
    if(isDefined(self.godmode))
    {
        self endon("disconnect");
        self PrintToLevel("^5God Mode ^2ON");
        while(isDefined(self.godmode)) 
        {
            self EnableInvulnerability();
            wait 0.1;
        }
    }
    else
    {
        self PrintToLevel("^5God Mode ^1OFF");
        self DisableInvulnerability();
    }
}

ToggleNoClip(player)
{
    player.Noclip = isDefined(player.Noclip) ? undefined : true;
    
    if(isDefined(player.Noclip))
    {
        player endon("disconnect");
        self iPrintLn("Noclip ^2Enabled");
        if(player hasMenu() && player isInMenu())
            player closeMenu1();
        player DisableWeapons();
        player DisableOffHandWeapons();
        player.nocliplinker = spawnSM(player.origin, "tag_origin");
        player PlayerLinkTo(player.nocliplinker, "tag_origin");
        
        while(isDefined(player.Noclip) && isAlive(player))
        {
            if(player AttackButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin + (AnglesToForward(player GetPlayerAngles()) * 60));
            else if(player AdsButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin - (AnglesToForward(player GetPlayerAngles()) * 60));
            if(player MeleeButtonPressed())
                break;
            
            wait 0.01;
        }

        if(isDefined(player.Noclip))
            player ToggleNoClip(player);
    }
    else
    {
        player Unlink();
        player.nocliplinker delete();
        player EnableWeapons();
        player EnableOffHandWeapons();
        self PrintToLevel("Noclip ^1Disabled");
    }
}

EditPlayerScore(val, player, which)//works fine
{
    switch (which)
    {
        case 1: self zm_score::add_to_player_score(400000000);self.var_595a11bc = 9999; self.var_72d64cfd = 9999;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("^5Score Maxed Out");break;
        case 2: self zm_score::minus_to_player_score(self.score); oldcommon = self.var_595a11bc; oldrare = self.var_72d64cfd; self.var_595a11bc = 0; self.var_72d64cfd = 0;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc); self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Set To ^10"); break;
        case 3: self zm_score::add_to_player_score(val); self.var_595a11bc += val; self.var_72d64cfd += val; self PrintToLevel("^5Added ^2"+val+" ^5To Score"); break;
        case 4: self zm_score::minus_to_player_score(val); if(self.var_595a11bc >= val) self.var_595a11bc -= val; if(self.var_72d64cfd >= val)self.var_72d64cfd -= val; self PrintToLevel("^5Taken ^2"+val+" ^5from Score"); break;
    }
}

UnlimitedAmmo()
{
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;
    if(isDefined(self.UnlimitedAmmo))
    {
        self PrintToLevel("^5Unlimited Ammo ^2On");   
        self endon("disconnect");

        while(isDefined(self.UnlimitedAmmo))
        {
            weapons = self getweaponslist();
            foreach(weapon in weapons)
            {
                if(weapon.isgadget){
                    slot = self gadgetgetslot(weapon);
                    if(self gadgetpowerget(slot) < 100 && !self getcurrentweapon().isgadget || self gadgetpowerget(slot) < 10){
                        self gadgetpowerset(slot,100);
                    }
                }
                else{
                    self givemaxammo(weapon);
                    self setweaponammoclip(weapon,weapon.clipsize);
                }
            }
            self thread zm_powerup_hero_weapon_power::hero_weapon_power(self);
            wait .05;
        }
    }
    else self PrintToLevel("^5Unlimited Ammo ^1Off");
}

GivePowerup(Powerup)//works
{
    self zm_powerups::specific_powerup_drop(Powerup, get_lookat_origin(self), undefined, undefined, undefined, 1);
    self PrintToLevel("^5Spawned Powerup: "+powerup);
}

GiveAllPerksZM()//works
{
	a_str_perks = getarraykeys( level._custom_perks );
	foreach(str_perk in a_str_perks)
	{
		if(!self hasperk(str_perk))
		{
			self zm_perks::wait_give_perk(str_perk);
			if(isdefined(level.perk_bought_func))
			{
				self [[level.perk_bought_func]](str_perk);
			}
		}
        wait .1;
	}
    self PrintToLevel("All Perks ^2Given");
}