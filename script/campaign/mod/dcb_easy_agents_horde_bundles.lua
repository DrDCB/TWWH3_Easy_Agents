-- Define cultural agent bundles.
local function dcb_easy_agents_coast_bundle(faction_bundle)
    faction_bundle:add_effect("wh2_dlc11_effect_agent_enable_recruitment_champion_cst", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh2_dlc11_effect_agent_enable_recruitment_dignitary_cst", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh2_dlc11_effect_agent_enable_recruitment_engineer_cst", "faction_to_force_own", 1);
end;

local function dcb_easy_agents_ogre_bundle(faction_bundle)
    faction_bundle:add_effect("wh3_main_effect_agent_enable_recruitment_ogr_butcher", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh3_main_effect_agent_enable_recruitment_ogr_firebelly", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh3_main_effect_agent_enable_recruitment_ogr_hunter", "faction_to_force_own", 1);
end;

local function dcb_easy_agents_nakai_bundle(faction_bundle)
    faction_bundle:add_effect("wh2_main_effect_agent_enable_recruitment_lzd_scar_veteran", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh2_main_effect_agent_enable_recruitment_spy_lzd", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh2_main_effect_agent_enable_recruitment_wizard_lzd", "faction_to_force_own", 1);
    faction_bundle:add_effect("wh2_dlc17_effect_agent_enable_recruitment_runesmith_lzd", "faction_to_force_own", 1);
end;

-- Malakai's own army acts as a horde, so needs separate consideration.
local function dcb_easy_agents_malakai_bundle(faction_bundle)
    faction_bundle:add_effect("wh_main_effect_agent_enable_recruitment_champion_dwarfs", "faction_to_force_faction_leader_unseen", 1);
    faction_bundle:add_effect("wh_main_effect_agent_enable_recruitment_runesmith", "faction_to_force_faction_leader_unseen", 1);
    faction_bundle:add_effect("wh_main_effect_agent_enable_recruitment_engineer", "faction_to_force_faction_leader_unseen", 1);
    faction_bundle:add_effect("wh3_dlc25_effect_agent_enable_recruitment_dignitary_dragon_slayer", "faction_to_force_faction_leader_unseen", 1);
end;

-- The Changeling is a horde faction, but recruitment is done via cult buildings (foreign slots) rather than via armies.
local function dcb_easy_agents_changeling_bundle(faction_bundle)
    faction_bundle:add_effect("wh3_dlc24_effect_agent_enable_recruitment_exalted_hero_mtze", "faction_to_foreign_building_unseen", 1);
    faction_bundle:add_effect("wh3_main_effect_agent_enable_recruitment_tze_cultist", "faction_to_foreign_building_unseen", 1);
    faction_bundle:add_effect("wh3_main_effect_agent_enable_recruitment_tze_iridescent_horror", "faction_to_foreign_building_unseen", 1);
    faction_bundle:add_effect("wh3_dlc20_effect_agent_enable_recruitment_sorcerer_mtze", "faction_to_foreign_building_unseen", 1);
end;

-- Parse all factions to identify human players, applying agent bundles to human Vampire Coast, Ogre, Nakai, Malakai, and Changeling factions. Should now also cover VC and Ogre minor factions enabled by faction unlocker mods.
local function dcb_easy_agents_apply_bundle()
    
    local faction_list = cm:model():world():faction_list();
    local coast_bundle = cm:create_new_custom_effect_bundle("dcb_easy_agents_coast_agents");
    local ogre_bundle = cm:create_new_custom_effect_bundle("dcb_easy_agents_ogre_agents");
    local nakai_bundle = cm:create_new_custom_effect_bundle("dcb_easy_agents_nakai_agents");
    local malakai_bundle = cm:create_new_custom_effect_bundle("dcb_easy_agents_malakai_agents");
    local changeling_bundle = cm:create_new_custom_effect_bundle("dcb_easy_agents_changeling_agents");
    local vamp_coast_culture = "wh2_dlc11_cst_vampire_coast"
    local ogres_culture = "wh3_main_ogr_ogre_kingdoms";
    local nakai_faction = "wh2_dlc13_lzd_spirits_of_the_jungle";
    local malakai_faction = "wh3_dlc25_dwf_malakai";
    local changeling_faction = "wh3_dlc24_tze_the_deceivers";
    
    for i = 0, faction_list:num_items() - 1 do
        
        local current_faction = faction_list:item_at(i);
        local current_faction_name = current_faction:name();
        local current_culture = current_faction:culture();
        local save_string = "dcb_easy_agents_" .. current_faction_name .. "_bundle_init";
        
        if current_faction:is_human() then
            
            if current_culture == vamp_coast_culture and not cm:get_saved_value(save_string) then
                
                -- Set a flag in save to prevent reinitialisation on subsequent turns/loads.
                cm:set_saved_value(save_string, true);
                
                out("Faction " .. current_faction_name .. " is human. Save flag " .. save_string .. " not detected.");
                out("Applying Vampire Coast agent bundle.");
                out("");
                
                -- Add the agent effects to the bundle, then apply the bundle to the faction.
                dcb_easy_agents_coast_bundle(coast_bundle);
                cm:apply_custom_effect_bundle_to_faction(coast_bundle, cm:get_faction(current_faction_name));
            
            elseif current_culture == ogres_culture and not cm:get_saved_value(save_string) then
                
                -- Set a flag in save to prevent reinitialisation on subsequent turns/loads.
                cm:set_saved_value(save_string, true);
                
                out("Faction " .. current_faction_name .. " is human. Save flag " .. save_string .. " not detected.");
                out("Applying Ogre Kingdoms agent bundle.");
                out("");
                    
                -- Add the agent effects to the bundle, then apply the bundle to the faction.
                dcb_easy_agents_ogre_bundle(ogre_bundle);
                cm:apply_custom_effect_bundle_to_faction(ogre_bundle, cm:get_faction(current_faction_name));
                
            elseif current_faction_name == nakai_faction and not cm:get_saved_value("dcb_easy_agents_nakai_bundle_init") then
                
                -- Set a flag in save to prevent reinitialisation on subsequent turns/loads.
                cm:set_saved_value("dcb_easy_agents_nakai_bundle_init", true);
                
                out("Faction " .. current_faction_name .. " is human. Save flag dcb_easy_agents_nakai_bundle_init not detected.");
                out("Applying Nakai agent bundle.");
                out("");
                
                -- Add the agent effects to the bundle, then apply the bundle to the faction.
                dcb_easy_agents_nakai_bundle(nakai_bundle);
                cm:apply_custom_effect_bundle_to_faction(nakai_bundle, cm:get_faction(nakai_faction));
            
            elseif current_faction_name == malakai_faction and not cm:get_saved_value("dcb_easy_agents_malakai_bundle_init") then
                
                -- Set a flag in save to prevent reinitialisation on subsequent turns/loads.
                cm:set_saved_value("dcb_easy_agents_malakai_bundle_init", true);
                
                out("Faction " .. current_faction_name .. " is human. Save flag dcb_easy_agents_malakai_bundle_init not detected.");
                out("Applying Malakai agent bundle.");
                out("");
                
                -- Add the agent effects to the bundle, then apply the bundle to the faction.
                dcb_easy_agents_malakai_bundle(malakai_bundle);
                cm:apply_custom_effect_bundle_to_faction(malakai_bundle, cm:get_faction(malakai_faction));
                
            elseif current_faction_name == changeling_faction and not cm:get_saved_value("dcb_easy_agents_changeling_bundle_init") then
                
                -- Set a flag in save to prevent reinitialisation on subsequent turns/loads.
                cm:set_saved_value("dcb_easy_agents_changeling_bundle_init", true);
                
                out("Faction " .. current_faction_name .. " is human. Save flag dcb_easy_agents_changeling_bundle_init not detected.");
                out("Applying Changeling agent bundle.");
                out("");
                
                -- Add the agent effects to the bundle, then apply the bundle to the faction.
                dcb_easy_agents_changeling_bundle(changeling_bundle);
                cm:apply_custom_effect_bundle_to_faction(changeling_bundle, cm:get_faction(changeling_faction));
            end;
        end;
    end;
end;

cm:add_first_tick_callback(
    function()
        
        out("");
        out("======================== DCB EASY AGENTS DEBUG: BEGIN ========================");
        out("");
        
        dcb_easy_agents_apply_bundle();
        
        out("======================== DCB EASY AGENTS DEBUG: END ========================");
        out("");
        
    end
);
