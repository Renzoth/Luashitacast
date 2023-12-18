local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Solid Wand', 'Yew Wand +1'},   
        -- Sub = {'Maple Shield'},
        Ammo = {'Morion Tathlum'},
        Head = {'Seer\'s Crown +1'},
        Neck = {'Black Neckerchief'},
        Ear1 = {'Loquac. Earring', 'Moldavite Earring'},
        Ear2 = {'Magnetic Earring', 'Morion Earring'},
        Body = {'Seer\'s Tunic'},
        Hands = {'Zenith Mitts', 'Seer\'s Mitts +1'},
        Ring1 = {'Tamas Ring', 'Astral Ring'},
        Ring2 = {'Wisdom Ring'},
        Back = {'Black Cape +1'},
        Waist = {'Penitent\'s Rope', 'Mrc.Cpt.Belt'},
        Legs = {'Zenith Slacks', 'Seer\'s Slacks'},
        Feet = {'Seer\'s Pumps +1'},
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

    -- if (player.SubJob == 'WHM' or player.SubJob == 'BLM') then
    --     AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
    --     AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    --     AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 7');
    -- elseif (player.SubJob == 'NIN') then
    --     AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
    --     AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    --     AshitaCore:GetChatManager():QueueCommand(1, '/lockstyle on');
    -- end
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
        gFunc.Equip('Legs', 'Baron\'s Slops');
        gFunc.Equip('Main', 'Pluto\'s Staff');
    else
        gFunc.EquipSet('Idle');
    end


end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
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
    end

    if (action.Skill == 'Healing Magic') then
    end

    if (action.Skill == 'Enfeebling Magic') then
        if (action.Type == 'White Magic') then
            gFunc.Equip('Back', 'White Cape +1');
        elseif (action.Type == 'Black Magic') then
            gFunc.Equip('Back', 'Black Cape +1');
            gFunc.Equip('Waist', 'Mrc.Cpt. Belt');
            gFunc.Equip('Ammo', 'Phtm. Tathlum');
        end
        gFunc.Equip('Neck', 'Enfeebling Torque');
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
    gFunc.Equip('Legs', 'Errant Slops');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;