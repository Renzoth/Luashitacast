local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        Ammo = {'Hedgehog Bomb'},
        Head = {'Duelist\'s Chapeau', 'Bastokan Circlet'},
        Neck = {'Promise Badge', 'Justice Badge'},
        Ear1 = {'Loquac. Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Energy Earring'},
        Body = {'Duelist\'s Tabard', 'Vermillion Cloak'},
        Hands = {'Zenith Mitts', 'Duelist\'s Gloves', 'Savage Gauntlets'},
        Ring1 = {'Tamas Ring', 'Astral Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'White Cape +1'},
        Waist = {'Penitent\'s Rope', 'Ryl.Kgt. Belt', 'Friar\'s Rope'},
        Legs = {'Zenith Slacks', 'Savage Loincloth'},
        Feet = {'Warlock\'s Boots', 'Bounding Boots'},
    },
    ['IdleNin_Priority'] = {
        Main = {'Sapara of Trials'},   
        Sub = {'Joyeuse'},
        Head = {'Duelist\'s Chapeau', 'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Loquac. Earring', 'Spike Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Spike Earring', 'Energy Earring'},
        Body = {'Scorpion Harness', 'Savage Separates'},
        Hands = {'Battle Gloves'},
        Ring1 = {'Woodsman Ring'},
        Ring2 = {'Sniper\'s Ring', 'Astral Ring'},
        Back = {'Amemet Mantle +1', 'White Cape +1'},
        Waist = {'Swift Belt', 'Friar\'s Rope'},
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
    local player = gData.GetPlayer();

    gSettings.AllowAddSet = true;

    if (player.SubJob == 'WHM' or player.SubJob == 'BLM') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 7');
    elseif (player.SubJob == 'NIN') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyle on');
    end
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
        gFunc.Equip('Waist', 'Hierarch Belt');
        if (player.SubJob == 'BLM') then
            gFunc.Equip('Back', 'Wizard\'s Mantle')
        end

        if (player.SubJob ~= 'NIN') then
            gFunc.Equip('Main', 'Pluto\'s Staff');
        end
        
        gFunc.Equip('Legs', 'Baron\'s Slops');
    elseif (player.Status == 'Engaged') then
        gFunc.EquipSet('IdleNin');
        if (player.IsMoving == false) then
            gFunc.Equip('Hands', 'Dusk Gloves');
        end
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
    gFunc.Equip('Body', 'Duelist\'s Tabard');
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
    end

    if (action.Skill == 'Enhancing Magic') then
        gFunc.Equip('Legs', 'Warlock\'s Tights');
        gFunc.Equip('Hands', 'Duelist\'s Gloves');
    end

    if (action.Skill == 'Healing Magic') then
        gFunc.Equip('Neck', 'Healing Torque');
        gFunc.Equip('Legs', 'Warlock\'s Tights');
    end

    if (action.Skill == 'Enfeebling Magic') then
        if (player.SubJob ~= 'NIN' and player.MainJobSync < 51) then
            gFunc.Equip('Main', 'Fencing Degen');
        end
        if (action.Type == 'White Magic') then
            gFunc.Equip('Back', 'White Cape +1');
            gFunc.Equip('Legs', 'Warlock\'s Tights');
        elseif (action.Type == 'Black Magic') then
            gFunc.Equip('Back', 'Black Cape +1');
            gFunc.Equip('Hands', 'Duelist\'s Gloves');
            gFunc.Equip('Waist', 'Mrc.Cpt. Belt');
            gFunc.Equip('Ammo', 'Phtm. Tathlum');
        end

        gFunc.Equip('Body', 'Warlock\'s Tabard');
        gFunc.Equip('Neck', 'Enfeebling Torque');
        gFunc.Equip('Head', 'Duelist\'s Chapeau');
        gFunc.Equip('Ring1', 'Tamas Ring');
    end

    if (action.Skill == 'Elemental Magic' or action.Skill == 'Dark Magic') then
        gFunc.Equip('Ear1', 'Moldavite Earring');
        gFunc.Equip('Ring1', 'Tamas Ring');
        gFunc.Equip('Back', 'Black Cape +1');
        gFunc.Equip('Hands', 'Duelist\'s Gloves');
        gFunc.Equip('Waist', 'Mrc.Cpt. Belt');
        gFunc.Equip('Ammo', 'Phtm. Tathlum');
        if (player.MPP <= 50) then
            gFunc.Equip('Neck', 'Uggalepih Pendant');
        else
            gFunc.Equip('Neck', 'Philomath Stole');
        end
        
    end

    gFunc.Equip('Head', 'Raven Beret');
    gFunc.Equip('Body', 'Warlock\'s Tabard');
    gFunc.Equip('Legs', 'Errant Slops');
    gFunc.Equip('Feet', 'Warlock\'s Boots');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;