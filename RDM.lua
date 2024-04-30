local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Terra\'s Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        Ammo = {'Hedgehog Bomb'},
        Head = {'Duelist\'s Chapeau', 'Bastokan Circlet'},
        Neck = {'Promise Badge', 'Justice Badge'},
        Ear1 = {'Loquac. Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Energy Earring'},
        Body = {'Duelist\'s Tabard', 'Vermillion Cloak'},
        Hands = {'Dst. Mittens +1', 'Duelist\'s Gloves', 'Savage Gauntlets'},
        Ring1 = {'Merman\'s Ring', 'Astral Ring'},
        Ring2 = {'Merman\'s Ring', 'Astral Ring'},
        Back = {'Errant Cape', 'White Cape +1'},
        Waist = {'Penitent\'s Rope', 'Ryl.Kgt. Belt', 'Friar\'s Rope'},
        Legs = {'Dst. Subligar +1', 'Savage Loincloth'},
        Feet = {'Dst. Leggings +1', 'Bounding Boots'},
    },
    ['IdleNin_Priority'] = {
        Main = {'Blau Dolch'},   
        Sub = {'Joyeuse'},
        Head = {'Duelist\'s Chapeau', 'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Brutal Earring', 'Spike Earring', 'Energy Earring'},
        Ear2 = {'Stealth Earring', 'Spike Earring', 'Energy Earring'},
        Body = {'Scp. Harness +1', 'Savage Separates'},
        Hands = {'Nashira Gages', 'Battle Gloves'},
        Ring1 = {'Sniper\'s Ring'},
        Ring2 = {'Sniper\'s Ring', 'Astral Ring'},
        Back = {'Amemet Mantle +1', 'White Cape +1'},
        Waist = {'Swift Belt', 'Friar\'s Rope'},
        Legs = {'Warlock\'s Tights', 'Savage Loincloth'},
        Feet = {'Bounding Boots'},
    },
    ['MND'] = {
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Promise Badge',
        Hands = 'Nashira Gages',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Aqua Ring',
        Legs = 'Errant Slops',
        Waist = 'Penitent\'s Rope',
        Feet = 'Errant Pigaches',
    },
    ['INT'] = {
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Philomath Stole',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Snow Ring',
        Ammo = 'Phtm. Tathlum',
        Legs = 'Errant Slops',
        Waist = 'Penitent\'s Rope',
        Feet = 'Warlock\'s Boots',
    },
    ['EnfeeblingSkill'] = {
        Body = 'Warlock\'s Tabard',
        Neck = 'Enfeebling Torque',
        Head = 'Duelist\'s Chapeau',
        Ring1 = 'Tamas Ring',
    },
    ['HealingSkill'] = {
        Neck = 'Healing Torque',
        Legs = 'Warlock\'s Tights',
    },
    ['EnmityDown'] = {
        Head = 'Raven Beret',
        Back = 'Errant Cape',
        Hands = 'Nashira Gages',
    },
    ['ElementalSkill'] = { -- and MAB
        Legs = 'Duelist\'s Tights',
        Ear1 = 'Moldavite Earring',
        Hands = 'Zenith Mitts',
        Feet = 'Nashira Crackows',
    },
    ['EnhancingSkill'] = {
        Legs = 'Warlock\'s Tights',
        Hands = 'Duelist\'s Gloves',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    nin_mage = false;
    currentLevel = 0;
}

profile.OnLoad = function()
    local player = gData.GetPlayer();

    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mage /lac fwd mage');

    if (player.SubJob == 'WHM' or player.SubJob == 'BLM') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 7');
    elseif (player.SubJob == 'NIN') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    end
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /mage');

end

profile.HandleCommand = function(args)
    if (args[1] == 'mage') then
        if (Settings.nin_mage == true) then
            gFunc.Message('/NIN MAGE OFF');
            Settings.nin_mage = false;
        else
            gFunc.Message('/NIN MAGE ON');
            Settings.nin_mage = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local env = gData.GetEnvironment();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Neck', 'Checkered Scarf');
        gFunc.Equip('Body', 'Errant Hpl.');
        gFunc.Equip('Waist', 'Duelist\'s Belt');
        if (player.SubJob == 'BLM') then
            gFunc.Equip('Back', 'Wizard\'s Mantle')
        end

        if (player.SubJob ~= 'NIN' or Settings.nin_mage == true) then
            gFunc.Equip('Main', 'Pluto\'s Staff');
        end
        
        gFunc.Equip('Legs', 'Baron\'s Slops');
    elseif (player.Status == 'Engaged') then
        gFunc.EquipSet('IdleNin');
        if (player.IsMoving == false) then
            gFunc.Equip('Hands', 'Dusk Gloves');
        end
    else
        if (player.SubJob == 'WHM' or player.SubJob == 'BLM' or player.SubJob == 'DRK') then
            gFunc.EquipSet('Idle');
        elseif (player.SubJob == 'NIN') then
            if (Settings.nin_mage == true) then
                gFunc.EquipSet('Idle');
            else
                gFunc.EquipSet('IdleNin');
            end
        end
    end

    if (string.match(env.Area, 'San d\'Oria') and not string.match(env.Area, 'Airship')) then
        gFunc.Equip('Body', 'Kingdom Aketon');
    end

end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.Equip('Head', 'Warlock\'s Chapeau');
    gFunc.Equip('Body', 'Duelist\'s Tabard');
    gFunc.Equip('Ear1', 'Loquac. Earring');
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();
    local env = gData.GetEnvironment();

    if (player.SubJob ~= 'NIN') then
        if (action.Element == "Fire") then
            gFunc.Equip('Main', 'Fire Staff');
        elseif (action.Element == "Ice") then
            gFunc.Equip('Main', 'Aquilo\'s Staff');
        elseif (action.Element == "Wind") then
            gFunc.Equip('Main', 'Auster\'s Staff');
        elseif (action.Element == "Earth") then
            if (action.Name == 'Stoneskin') then
                gFunc.Equip('Main', 'Water Staff');
            else
                gFunc.Equip('Main', 'Terra\'s Staff');
            end
            
        elseif (action.Element == "Thunder") then
            gFunc.Equip('Main', 'Thunder Staff');
        elseif (action.Element == "Water") then
            gFunc.Equip('Main', 'Water Staff');
        elseif (action.Element == "Light") then
            gFunc.Equip('Main', 'Apollo\'s Staff');
        elseif (action.Element == "Dark") then
            gFunc.Equip('Main', 'Pluto\'s Staff');
        end
    end

    if (action.Skill == 'Enhancing Magic') then
        if (action.Name == 'Stoneskin') then
            gFunc.EquipSet(sets.MND);
        else
            gFunc.EquipSet(sets.EnhancingSkill);
        end
    elseif (action.Skill == 'Healing Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.MND, sets.HealingSkill));
    elseif (action.Skill == 'Enfeebling Magic') then
        if (action.Type == 'White Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.MND, sets.EnfeeblingSkill));
        elseif (action.Type == 'Black Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.INT, sets.EnfeeblingSkill));
        end
    elseif (action.Skill == 'Elemental Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.INT, sets.ElementalSkill));
        if (player.MPP <= 50) then
            gFunc.Equip('Neck', 'Uggalepih Pendant');
        end
    elseif (action.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.INT);
        if (env.RawWeatherElement == 'Dark') then
            gFunc.Equip('Main', 'Diabolos\'s Pole');
        end
    end

    if (action.Skill ~= 'Enfeebling Magic' and action.Skill ~= 'Elemental Magic') then
        gFunc.EquipSet(sets.EnmityDown);
    end

    if (action.Name == 'Sneak') then
        gFunc.Equip('Feet', 'Dream Boots +1');
    elseif (action.Name == 'Invisible') then
        gFunc.Equip('Hands', 'Dream Mittens +1');
    end 
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;