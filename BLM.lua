local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        Ammo = {'Morion Tathlum'},
        -- Head = {'Wizard\'s Petasos', 'Seer\'s Crown +1'},
        Neck = {'Philomath Stole', 'Black Neckerchief'},
        Ear1 = {'Loquac. Earring', 'Moldavite Earring'},
        Ear2 = {'Magnetic Earring', 'Morion Earring'},
        Body = {'Vermillion Cloak', 'Wizard\'s Coat', 'Seer\'s Tunic'},
        Hands = {'Zenith Mitts', 'Wizard\'s Gloves', 'Seer\'s Mitts +1'},
        Ring1 = {'Tamas Ring', 'Astral Ring'},
        Ring2 = {'Genius Ring'},
        Back = {'Black Cape +1'},
        Waist = {'Penitent\'s Rope', 'Mrc.Cpt. Belt'},
        Legs = {'Zenith Slacks', 'Seer\'s Slacks'},
        Feet = {'Wizard\'s Sabots', 'Seer\'s Pumps +1'},
    },
    ['MND'] = {
        Body = 'Errant Hpl.',
        Back = 'White Cape +1',
        Neck = 'Promise Badge',
        Ring1 = 'Tamas Ring',
        Legs = 'Errant Slops',
        Waist = 'Penitent\'s Rope',
        Feet = 'Errant Pigaches',
    },
    ['INT'] = {
        Head = 'Wizard\'s Petasos',
        Body = 'Black Cotehardie',
        -- Body = 'Errant Hpl.',
        Back = 'Black Cape +1',
        Neck = 'Philomath Stole',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Snow Ring',
        Ammo = 'Phtm. Tathlum',
        Waist = 'Penitent\'s Rope',
    },
    ['EnfeeblingSkill'] = {
        Body = 'Wizard\'s Coat',
        Neck = 'Enfeebling Torque',
        Ring1 = 'Tamas Ring',
    },
    ['HealingSkill'] = {
        Neck = 'Healing Torque',
    },
    ['ElementalSkill'] = { -- and MAB
        Neck = 'Elemental Torque',
        Hands = 'Wizard\'s Gloves',
        Ear1 = 'Moldavite Earring',
        Hands = 'Zenith Mitts',
    },
    ['EnhancingSkill'] = {
    },
    ['DarkSkill'] = {
        Legs= 'Wizard\'s Tonban',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    currentLevel = 0;
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Neck', 'Checkered Scarf');
        gFunc.Equip('Body', 'Errant Hpl.');
        gFunc.Equip('Main', 'Pluto\'s Staff');
        gFunc.Equip('Legs', 'Baron\'s Slops');
    elseif (player.Status == 'Engaged') then

    else
        gFunc.EquipSet('Idle');
    end


end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.Equip('Head', 'Warlock\'s Chapeau');
    gFunc.Equip('Body', 'Duelist\'s Tabard');
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    if (action.Element == "Fire") then
        gFunc.Equip('Main', 'Fire Staff');
    elseif (action.Element == "Ice") then
        gFunc.Equip('Main', 'Aquilo\'s Staff');
    elseif (action.Element == "Wind") then
        gFunc.Equip('Main', 'Wind Staff');
    elseif (action.Element == "Earth") then
        if (action.Name == 'Stoneskin') then
            gFunc.Equip('Main', 'Water Staff');
        else
            gFunc.Equip('Main', 'Earth Staff');
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

    if (action.Skill == 'Enhancing Magic') then
        if (action.Name == 'Stoneskin') then
            gFunc.EquipSet(sets.MND);
        else
            gFunc.EquipSet(sets.EnhancingSkill);
        end
    end

    if (action.Skill == 'Healing Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.MND, sets.HealingSkill));
    end

    if (action.Skill == 'Enfeebling Magic') then
        if (player.SubJob ~= 'NIN' and player.MainJobSync < 51) then
            gFunc.Equip('Main', 'Fencing Degen');
        end
        if (action.Type == 'White Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.MND, sets.EnfeeblingSkill));
        elseif (action.Type == 'Black Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.INT, sets.EnfeeblingSkill));
        end
    end

    if (action.Skill == 'Elemental Magic') then
        gFunc.ForceEquipSet(gFunc.Combine(sets.INT, sets.ElementalSkill));
        if (player.MPP <= 50) then
            gFunc.Equip('Neck', 'Uggalepih Pendant');
        end
        
    elseif (action.Skill == 'Dark Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.INT, sets.DarkSkill));
    end

    if (action.Skill ~= 'Enfeebling Magic') then
        gFunc.Equip('Head', 'Raven Beret');
    end

    if (action.Name == 'Sneak') then
        gFunc.Message('CASTING SNEAK');
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