local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Kukulcan\'s Staff', 'Lgn. Staff' },
        -- Head = {'', 'Silver Hairpin'},
        Neck = {'Smn. Torque', 'Justice Badge'},
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
    ['Fishing'] = {
        Range = 'Halcyon Rod',
    }
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    currentLevel = 0;
    fishing = false;
}

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /fishing /lac fwd fishing');


    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 3');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /fishing');

end

profile.HandleCommand = function(args)
    if (args[1] == 'fishing') then
        if (Settings.fishing == true) then
            gFunc.Message('Fishing Off');
            Settings.fishing = false;
        else
            gFunc.Message('Fishing On');
            Settings.fishing = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local pet = gData.GetPet();
    local env = gData.GetEnvironment();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    -- gFunc.Message(env.Area)

    if (player.Status == 'Resting') then
        gFunc.Equip('Main', 'Dark Staff');
        if (player.MainJobSync < 59) then
            gFunc.Equip('Body', 'Seer\'s Tunic');
        end
        gFunc.Equip('Legs', 'Baron\'s Slops');
    else
        if (Settings.fishing == false) then
            gFunc.EquipSet('Idle');

            if (player.MainJobSync < 59) then
                gFunc.Equip('Head', 'Silver Hairpin');
            end
        elseif (Settings.fishing == true) then
            gFunc.EquipSet('Fishing');
        end
    end

    if (pet ~= nil) then
        -- gFunc.Message(pet.Name)
        gFunc.Equip('Legs', 'Evoker\'s Spats');

        if (pet.Name == 'Carbuncle') then
            if (env.Day == 'Lightsday') then
                -- gFunc.Equip('Body', )
            end
            gFunc.Equip('Main', 'Light Staff');
            gFunc.Equip('Body', 'Vermillion Cloak');
            gFunc.Equip('Hands', 'Carbuncle Mitts');
        else
            gFunc.Equip('Head', 'Evoker\'s Horn');
            gFunc.Equip('Body', 'Austere Robe');
            if (pet.Name == 'Garuda') then
                if (env.Day == 'Windsday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Wind Staff');
            elseif (pet.Name == 'Titan') then
                if (env.Day == 'Earthsday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Earth Staff');
            elseif (pet.Name == 'Ifrit') then
                if (env.Day == 'Firesday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Fire Staff');
            elseif (pet.Name == 'Fenrir') or (pet.Name == 'Diabolos') then
                if (env.Day == 'Darksday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Dark Staff');
            elseif (pet.Name == 'Shiva') then
                if (env.Day == 'Iceday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Ice Staff');
            elseif (pet.Name == 'Leviathan') then
                if (env.Day == 'Watersday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Water Staff');
            elseif (pet.Name == 'Ramuh') then
                if (env.Day == 'Lightningday') then
                    -- gFunc.Equip('Body', )
                end
                gFunc.Equip('Main', 'Ice Staff');
            elseif (pet.Name == 'LightSpirit') then
                gFunc.Equip('Main', 'Light Staff');
            end
        end
    end

    -- SANDY IS THE BEST FUCK WINDY FUCK MIMI
    -- gFunc.Message(env.Area);
    if (string.match(env.Area, 'San d\'Oria')) then
        gFunc.Equip('Head', 'Evoker\'s Horn');
        gFunc.Equip('Body', 'Kingdom Aketon');
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

    if (action.Type == 'Summoning') then
        gFunc.Equip('Head', 'Evoker\'s Horn');
        gFunc.Equip('Neck', 'Smn. Torque');
        gFunc.Equip('Body', 'Evoker\'s Doublet');
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;