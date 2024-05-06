local fire_staff = 'Fire Staff'
local earth_staff = 'Terra\'s Staff'
local water_staff = 'Water Staff'
local wind_staff = 'Auster\'s Staff'
local ice_staff = 'Aquilo\'s Staff'
local thunder_staff = 'Thunder Staff'
local light_staff = 'Apollo\'s Staff'
local dark_staff = 'Pluto\'s Staff'

local ElementalStaffTable = {
    ['Fire'] = fire_staff,
    ['Earth'] = earth_staff,
    ['Water'] = water_staff,
    ['Wind'] = wind_staff,
    ['Ice'] = ice_staff,
    ['Thunder'] = thunder_staff,
    ['Light'] = light_staff,
    ['Dark'] = dark_staff
}

local profile = {};

local sets = {
    ['Idle_Priority'] = {
        Main = {'Terra\'s Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        Ammo = {'Phtm. Tathlum', 'Morion Tathlum'},
        Head = {'Demon Helm', 'Wizard\'s Petasos', 'Seer\'s Crown +1'},
        Neck = {'Elemental Torque', 'Philomath Stole', 'Black Neckerchief'},
        Ear1 = {'Loquac. Earring', 'Moldavite Earring'},
        Ear2 = {'Magnetic Earring', 'Morion Earring'},
        Body = {'Sorcerer\'s Coat', 'Vermillion Cloak', 'Wizard\'s Coat', 'Seer\'s Tunic'},
        Hands = {'Zenith Mitts', 'Wizard\'s Gloves', 'Seer\'s Mitts +1'},
        Ring1 = {'Tamas Ring', 'Astral Ring'},
        Ring2 = {'Snow Ring', 'Genius Ring'},
        Back = {'Prism Cape', 'Black Cape +1'},
        Waist = {'Penitent\'s Rope', 'Mrc.Cpt. Belt'},
        Legs = {'Zenith Slacks', 'Druid\'s Slops', 'Seer\'s Slacks'},
        Feet = {'Nashira Crackows', 'Wizard\'s Sabots', 'Seer\'s Pumps +1'},
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
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Philomath Stole',
        Legs = 'Errant Slops',
        Feet = 'Rostrum Pumps',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Snow Ring',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring', 
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
        Body = 'Igqira Weskit',
        Hands = 'Wizard\'s Gloves',
        Ear1 = 'Moldavite Earring',
        -- Legs = 'Druid\'s Slops',
        Hands = 'Zenith Mitts',
        Feet = 'Nashira Crackows',
    },
    ['EnhancingSkill'] = {
    },
    ['DarkSkill'] = {
        Glove = 'Sorcerer\'s Gloves',
        Legs= 'Wizard\'s Tonban',
    },
    ['EnmityDown'] = {
        Head = 'Raven Beret',
        Back = 'Errant Cape',
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
    local pet = gData.GetPet();
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

    if (pet ~= nil) then
        gFunc.Equip('Waist', 'Avatar Belt')
        if (pet.Name == 'Ifrit') then
            gFunc.Equip('Main', 'Fire Staff');
        end
    end


end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.Equip('Ear1', 'Loquac. Earring');
    gFunc.Equip('Feet', 'Rostrum Pumps');
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    local staff = ElementalStaffTable[action.Element]
        if staff ~= '' then
            gFunc.Equip('Main', staff)
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
        if (action.Type == 'White Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.MND, sets.EnfeeblingSkill));
        elseif (action.Type == 'Black Magic') then
            gFunc.EquipSet(gFunc.Combine(sets.INT, sets.EnfeeblingSkill));
        end
        if (env.RawWeatherElement == 'Dark') then
            gfunc.Message(env.RawWeatherElement)
            gFunc.Equip('Ear2', 'Diabolos\'s Earring');
        end
    end

    if (action.Skill == 'Elemental Magic') then
        gFunc.Message(action.Name .. ": " .. action.MpCost .. " MP");
        gFunc.ForceEquipSet(gFunc.Combine(sets.INT, sets.ElementalSkill));
        if (action.MppAftercast <= 50) then
            gFunc.Equip('Neck', 'Uggalepih Pendant');
        end
        
    elseif (action.Skill == 'Dark Magic') then
        gFunc.EquipSet(gFunc.Combine(sets.INT, sets.DarkSkill));
        if (env.RawWeatherElement == 'Dark') then
            gFunc.Equip('Ear2', 'Diabolos\'s Earring');
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