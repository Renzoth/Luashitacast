local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Terra\'s Staff', 'Solid Wand'},
        Ammo = {'Hedgehog Bomb'},
        Head = {'Zenith Crown'},
        Neck = {'Promise Badge', 'Justice Badge'},
        Ear1 = {'Loquac. Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Energy Earring'},
        Body = {'Cleric\'s Bliaut', 'Vermillion Cloak', 'Seer\'s Tunic'},
        Hands = {'Zenith Mitts', 'Savage Gauntlets'},
        Ring1 = {'Tamas Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'Errant Cape', 'White Cape +1'},
        Waist = {'Penitent\'s Rope', 'Friar\'s Rope'},
        Legs = {'Zenith Slacks', 'Savage Loincloth'},
        Feet = {'Rostrum Pumps', 'Errant Pigaches', 'Seer\'s Pumps +1'},
    },
    ['MND'] = {
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Promise Badge',
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
        Ring1 = 'Tamas Ring',
        Ring2 = 'Snow Ring',
        Legs = 'Errant Slops',
        Ammo = 'Phtm. Tathlum',
        Waist = 'Penitent\'s Rope',
    },
    ['EnfeeblingSkill'] = {
        Neck = 'Enfeebling Torque',
        Ring1 = 'Tamas Ring',
    },
    ['HealingSkill'] = {
        Body = 'Noble\'s Tunic',
        Hands = 'Healer\'s Mitts',
        Neck = 'Healing Torque',
    },
    ['EnmityDown'] = {
        Head = 'Raven Beret',
        Back = 'Errant Cape',
    },
    ['ElementalSkill'] = { -- and MAB
        Ear1 = 'Moldavite Earring',
        Hands = 'Zenith Mitts',
    },
    ['EnhancingSkill'] = {
        Feet = 'Cleric\'s Duckbills',
    },
    ['DivineSkill'] = {
        Legs = 'Healer\'s Pantaln.',
        Neck = 'Divine Torque',
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
    local env = gData.GetEnvironment();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Neck', 'Checkered Scarf');
        gFunc.Equip('Body', 'Errant Hpl.');
        gFunc.Equip('Main', 'Pluto\'s Staff');
        if (player.SubJob == 'BLM') then
            gFunc.Equip('Back', 'Wizard\'s Mantle')
        end
    else
        gFunc.EquipSet('Idle');
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

    if (player.SubJob ~= 'NIN') then
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
            if (string.match(action.Name, 'Regen')) then
                gFunc.Equip('Main', 'Rucke\'s Rung');
                gFunc.Equip('Body', 'Cleric\'s Bliaut');
            end
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
    elseif (action.Skill == 'Divine Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.MND, sets.DivineSkill));
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