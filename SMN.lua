local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Kukulcan\'s Staff', 'Lgn. Staff' },
        Head = {'Silver Hairpin'},
        Neck = {'Justice Badge'},
        Ear1 = {'Energy Earring'},
        Ear2 = {'Energy Earring'},
        Body = {'Vermillion Cloak', 'Seer\'s Tunic', 'Doublet'},
        Hands = {'Savage Gauntlets', 'Zealot\'s Mitts'},
        Ring1 = {'Astral Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'White Cape'},
        Waist = {'Friar\'s Rope'},
        Legs = {'Savage Loincloth', 'Baron\'s Slops'},
        Feet = {'Evoker\'s Pigaches', 'San d\'Orian Clogs'},
    },
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    currentLevel = 0,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 3');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
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
        gFunc.Equip('Main', 'Dark Staff');
        gFunc.Equip('Body', 'Seer\'s Tunic');
        gFunc.Equip('Legs', 'Baron\'s Slops');
    else
        gFunc.EquipSet('Idle');
    end

    if (pet ~= nil) then
        -- gFunc.Message(pet.Name)
        if (pet.Name == 'Carbuncle') then
            gFunc.Equip('Main', 'Light Staff');
            gFunc.Equip('Hands', 'Carbuncle Mitts');
        elseif (pet.Name == 'Garuda') then
            gFunc.Equip('Main', 'Wind Staff');
        elseif (pet.Name == 'Titan') then
            gFunc.Equip('Main', 'Earth Staff');
        elseif (pet.Name == 'Fenrir') or (pet.Name == 'Diabolos') then
            gFunc.Equip('Main', 'Dark Staff');
        end
        gFunc.Equip('Body', 'Austere Robe');
        gFunc.Equip('Legs', 'Evoker\'s Spatsa');
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
    if (string.match(action.Name, 'Cure')) then
        gFunc.Equip('Main', 'Light Staff');
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;