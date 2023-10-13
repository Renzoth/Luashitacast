local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        -- Head = {'Bastokan Circlet'},
        Neck = {'Justice Badge'},
        Ear1 = {'Loquac. Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Energy Earring'},
        Body = {'Vermillion Cloak'},
        Hands = {'Zenith Mitts', 'Savage Gauntlets'},
        Ring1 = {'Astral Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'White Cape +1'},
        Waist = {'Hierarch Belt', 'Ryl.Kgt. Belt', 'Friar\'s Rope'},
        Legs = {'Savage Loincloth'},
        Feet = {'Warlock\'s Boots', 'Bounding Boots'},
    },
    ['IdleNin_Priority'] = {
        Main = {'Ryl.Grd. Fleuret'},   
        Sub = {'Fencing Degen'},
        Head = {'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Loquac. Earring', 'Spike Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Spike Earring', 'Energy Earring'},
        Body = {'Scorpion Harness', 'Savage Separates'},
        Hands = {'Zenith Mitts', 'Savage Gauntlets'},
        Ring1 = {'Woodsman Ring'},
        Ring2 = {'Tamas Ring', 'Astral Ring'},
        Back = {'Amemet Mantle +1', 'White Cape +1'},
        Waist = {'Ryl.Kgt. Belt', 'Friar\'s Rope'},
        Legs = {'Warlock\'s Tights', 'Savage Loincloth'},
        Feet = {'Bounding Boots'},
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
        if (player.SubJob == 'BLM') then
            gFunc.Equip('Back', 'Wizard\'s Mantle')
        end

        gFunc.Equip('Main', 'Dark Staff');
        gFunc.Equip('Legs', 'Baron\'s Slops');
    else
        if (player.SubJob == 'WHM' or player.SubJob == 'BLM') then
            gFunc.EquipSet('Idle');
        elseif (player.SubJob == 'NIN') then
            gFunc.EquipSet('IdleNin');
        end
    end


end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.Equip('Head', 'Warlock\'s Chapeau');
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    if (player.SubJob ~= 'NIN') then
        if (action.Element == "Fire") then
            gFunc.Equip('Main', 'Fire Staff');
        elseif (action.Element == "Ice") then
            gFunc.Equip('Main', 'Ice Staff');
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
            gFunc.Equip('Main', 'Dark Staff');
        end
    end

    if (action.Skill == 'Enhancing Magic') then
        gFunc.Equip('Legs', 'Warlock\'s Tights');
    end

    if (action.Skill == 'Healing Magic') then
        gFunc.Equip('Legs', 'Warlock\'s Tights');
    end

    if (action.Skill == 'Enfeebling Magic') then
        gFunc.Equip('Body', 'Warlock\'s Tabard');
        gFunc.Equip('Neck', 'Enfeebling Torque');
        gFunc.Equip('Ring1', 'Tamas Ring');
        if (player.SubJob ~= 'NIN' and player.MainJobSync < 51) then
            gFunc.Equip('Main', 'Fencing Degen');
        end
        if (action.Type == 'White Magic') then
            gFunc.Equip('Back', 'White Cape +1');
            gFunc.Equip('Legs', 'Warlock\'s Tights');
        elseif (action.Type == 'Black Magic') then
            gFunc.Equip('Back', 'Black Cape +1');
            gFunc.Equip('Waist', 'Mrc.Cpt. Belt');
        end
    end

    if (action.Skill == 'Elemental Magic') then
        gFunc.Equip('Ear1', 'Moldavite Earring');
        gFunc.Equip('Ring1', 'Tamas Ring');
    end

    gFunc.Equip('Head', 'Raven Beret');
    gFunc.Equip('Body', 'Warlock\'s Tabard');
    gFunc.Equip('Feet', 'Warlock\'s Boots');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;