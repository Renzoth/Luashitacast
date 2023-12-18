local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Kukulcan\'s Staff', 'Lgn. Staff' },
        -- Head = {' ', 'Silver Hairpin'},
        Neck = {'Smn. Torque', 'Justice Badge'},
        Ear1 = {'Magnetic Earring', 'Energy Earring'},
        Ear2 = {'Loquac. Earring', 'Energy Earring'},
        Body = {'Vermillion Cloak', 'Seer\'s Tunic', 'Doublet'},
        Hands = {'Zenith Mitts', 'Savage Gauntlets', 'Zealot\'s Mitts'},
        Ring1 = {'Tamas Ring', 'Astral Ring'},
        Ring2 = {'Evoker\'s Ring', 'Astral Ring'},
        Back = {'Summoner\'s Cape', 'White Cape'},
        Waist = {'Hierarch Belt', 'Friar\'s Rope'},
        Legs = {'Zenith Slacks', 'Savage Loincloth', 'Baron\'s Slops'},
        Feet = {'Evoker\'s Pigaches', 'San d\'Orian Clogs'},
    },
    ['MND'] = {
        Body = 'Errant Hpl.',
        Neck = 'Justice Badge',
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
        gFunc.Equip('Main', 'Pluto\'s Staff');
        gFunc.Equip('Neck', 'Checkered Scarf');
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
        gFunc.Equip('Legs', 'Evoker\'s Spats');
        gFunc.Equip('Hands', 'Summoner\'s Brcr.');
        gFunc.Equip('Ear2', 'Beastly Earring');

        if (pet.Name == 'Carbuncle') then
            -- CARBUNCLE
            gFunc.Equip('Main', 'Apollo\'s Staff');
            gFunc.Equip('Body', 'Vermillion Cloak');
            gFunc.Equip('Hands', 'Carbuncle Mitts');
            -- END CARBUNCLE
        else
            gFunc.Equip('Head', 'Summoner\'s Horn');
            gFunc.Equip('Body', 'Austere Robe');
            
            if (pet.Name == 'Garuda') then
                -- GARUDA
                if (env.Day == 'Windsday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Wind') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Wind Staff');
                -- END GARUDA
            elseif (pet.Name == 'Titan') then
                -- EARTH
                if (env.Day == 'Earthsday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Earth') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Earth Staff');
                -- END EARTH
            elseif (pet.Name == 'Ifrit') then
                -- IFRIT
                if (env.Day == 'Firesday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Fire') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Fire Staff');
                -- END IFRIT
            elseif (pet.Name == 'Fenrir') or (pet.Name == 'Diabolos') then
                -- FENRIR DIABOLOS
                if (env.Day == 'Darksday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Dark') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Pluto\'s Staff');
                -- END FENRIR DIABOLOS
            elseif (pet.Name == 'Shiva') then
                -- SHIVA
                if (env.Day == 'Iceday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Ice') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Aquilo\'s Staff');
                -- END SHIVA
            elseif (pet.Name == 'Leviathan') then
                -- LEVIATHAN
                if (env.Day == 'Watersday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Water') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Water Staff');
                -- END LEVIATHAN
            elseif (pet.Name == 'Ramuh') then
                -- RAMUH
                if (env.Day == 'Lightningday') then
                    gFunc.Equip('Body', 'Summoner\'s Dblt.');
                end
                if (env.RawWeatherElement == 'Thunder') then
                    gFunc.Equip('Head', 'Summoner\'s Horn');
                end
                gFunc.Equip('Main', 'Lightning Staff');
                -- END RAMUH
            elseif (pet.Name == 'LightSpirit') then
                gFunc.Equip('Main', 'Apollo\'s Staff');
            end
        end
    end

    -- SANDY IS THE BEST FUCK WINDY FUCK MIMI
    -- gFunc.Message(env.Area);
    if (string.match(env.Area, 'San d\'Oria')) then
        gFunc.Equip('Head', 'Summoner\'s Horn');
        gFunc.Equip('Body', 'Kingdom Aketon');
    end
end

profile.HandleAbility = function()
    gFunc.Equip('Head', 'Summoner\'s Horn'); -- -3
    gFunc.Equip('Legs', 'Summoner\'s Spats'); -- -2
    gFunc.Equip('Hands', 'Summoner\'s Brcr.'); -- -2
    gFunc.Equip('Body', 'Austere Robe'); -- -3
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    if (string.match(action.Name, 'Cure')) then
        gFunc.Equip('Main', 'Apollo\'s Staff');
        gFunc.EquipSet('MND');
    end

    if (action.Type == 'Summoning') then
        gFunc.Equip('Head', 'Evoker\'s Horn');
        gFunc.Equip('Neck', 'Smn. Torque');
        gFunc.Equip('Hands', 'Summoner\'s Brcr.');
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