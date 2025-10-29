#include script_4ccfb58a9443a60b;
#include scripts\core_common\activecamo_shared;
#include scripts\core_common\activecamo_shared_util;
#include scripts\core_common\struct.gsc;
#include scripts\core_common\callbacks_shared.gsc;
#include scripts\core_common\clientfield_shared.gsc;
#include scripts\core_common\math_shared.gsc;
#include scripts\core_common\system_shared.gsc;
#include scripts\core_common\util_shared.gsc;
#include scripts\core_common\item_drop;
#include scripts\core_common\item_world;
#include scripts\core_common\item_inventory;
#include scripts\core_common\hud_util_shared.gsc;
#include scripts\core_common\hud_message_shared.gsc;
#include scripts\core_common\hud_shared.gsc;
#include scripts\core_common\array_shared.gsc;
#include scripts\killstreaks\killstreaks_shared.gsc;
#include scripts\killstreaks\killstreaks_util.gsc;
#include scripts\core_common\flag_shared.gsc;
#include scripts\zm_common\gametypes\dev.gsc;
#include scripts\zm_common\zm_score.gsc;
#include scripts\zm_common\util.gsc;
#include scripts\weapons\weaponobjects.gsc;
#include scripts\zm_common\zm_audio.gsc;
#include scripts\zm_common\zm_crafting.gsc;
#include scripts\zm_common\zm_powerups.gsc;
#include scripts\zm_common\zm_stats.gsc;
#include scripts\zm_common\zm_power.gsc;
#include scripts\zm_common\zm_pack_a_punch_util.gsc;
#include scripts\zm_common\zm_pack_a_punch.gsc;
#include scripts\zm_common\zm_weapons.gsc;
#include scripts\core_common\aat_shared.gsc;
#include scripts\core_common\ai\zombie_utility.gsc;
#include scripts\zm_common\zm_utility.gsc;
#include scripts\zm_common\zm_equipment.gsc;
#include scripts\zm_common\zm_perks.gsc;
#include scripts\zm_common\zm_items.gsc;
#include scripts\zm_common\zm_magicbox.gsc;
#include scripts\core_common\rank_shared.gsc;
#include scripts\zm_common\zm_blockers.gsc;
#include scripts\core_common\exploder_shared.gsc;
#include scripts\core_common\challenges_shared.gsc;
#include scripts\zm_common\zm_game_module.gsc;
#include scripts\zm_common\gametypes\globallogic_score.gsc;
#include scripts\zm_common\gametypes\globallogic.gsc;
#include scripts\core_common\contracts_shared.gsc;
#include scripts\core_common\player\player_stats;
#include scripts\zm_common\zm_loadout.gsc;
#include scripts\core_common\match_record.gsc;
#include scripts\zm_common\zm_laststand.gsc;
#include scripts\zm_common\zm_devgui.gsc;
#include scripts\core_common\laststand_shared.gsc;
#include scripts\zm_common\zm_bgb.gsc;
#include scripts\zm_common\zm_zonemgr.gsc;
#include scripts\zm_common\zm_sq.gsc;
#include scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc;
#include scripts\zm_common\zm_round_logic.gsc;

#namespace synergycw;

autoexec __init__sytem__()
{
	system::register("synergycw", &__init__, undefined, undefined);
    
    //zombies per round
    self.zombies_per_rounds = 999999;
    //remove rank cap
    level.rankcap = undefined;
    //XP Multiplier
    thread get_xp_multiplier_late();
    // disable ee
}

event_handler[gametype_init] gametype_init(*eventstruct) {
        
}
__init__()
{
    callback::on_start_gametype(&init);
    callback::on_spawned(&onPlayerSpawned);
    callback::add_callback(#"on_round_end", &on_round_end, undefined);
}
get_xp_multiplier_late() {
    wait 10;
    level.var_3426461d = &GetXPMultiplier;
    level.var_2f528eb0 = &GetXPMultiplier;//weapon XP Mult
}

on_round_end() {
    level endon(#"hash_3e765c26047c9f54", #"end_game");
    wait 10;
    level flag::set( "rbz_exfil_beacon_active" );//enable exfil radio flag
    level flag::set("rbz_exfil_allowed");//Set Exfil allowed
}
GetXPMultiplier() 
{
    self endon(#"disconnect", #"end_game");
    if(isDefined(level.customXPValue) && level.customXPValue >= 1){ return level.customXPValue;}
    else return 2;//This 100% has a max limit, and we'll keep it manually at 2x to be safe. Manual Editing is supported, with risk of shadowbans.
}
