local profile = {};
local sets = {
    ['HP_DOWN'] = {
        Main = 'Terra\'s Staff',
        Range = 'Cornette +1',
        Head = 'Zenith Crown',
        Neck = 'Star Necklace',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Black Cotehardie',
        Hands = 'Zenith Mitts',
        Ring1 = 'Astral Ring',
        Ring2 = 'Ether Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Scouter\'s Rope',
        Legs = 'Zenith Slacks',
        Feet = 'Errant Pigaches',
    },
    ['Idle'] = {
        Main = 'Terra\'s Staff',
        Range = 'Cornette +1',
        Head = 'Bard\'s Roundlet',
        Neck = 'Wind Torque',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Sha\'ir Manteel',
        Hands = 'Dst. Mittens +1',
        Ring2 = 'Merman\'s Ring',
        Ring1 = 'Minstrel\'s Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Corsette +1',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1'
    },
    ['Refresh'] = {
        Head = 'Remove',
        Body = 'Vermillion Cloak',
    },
    ['HP_UP'] = {
        Head = 'Genbu\'s Kabuto',
        Body = 'Savage Separates',
        Neck = 'Bloodbead Amulet',
        Back = 'Gigant Mantle',
        Ear1 = 'Pigeon Earring',
        Ear2 = 'Pigeon Earring',
        Ring1 = 'Minstrel\'s Ring',
        Ring2 = 'Bomb Queen Ring',
        Legs = 'Sha\'ir Seraweels',
        Feet = 'Savage Gaiters',
    },
    ['Singing'] = {
        Head = 'Bard\'s Roundlet',
        Hands = 'Chl. Cuffs +1',
    },
    ['Wind'] = {
        Neck = 'Wind Torque',
        Legs = 'Choral Cannions',
    },
    ['String'] = {
        Feet = 'Bard\'s Slippers',
    },
    -- 64 + 54
    ['CHR'] = { -- AND MACC
        Head = 'Bard\'s Roundlet', -- +3
        Body = 'Errant Hpl.', -- +10
        Hands = 'Chl. Cuffs +1', -- +7
        Ear1 = 'Melody Earring +1', -- +2
        Ear2 = 'Melody Earring +1', -- +2
        Waist = 'Corsette +1', -- +6
        Ring1 = 'Tamas Ring', -- MACC+5 +10
        Ring2 = 'Luftpause Mark', -- MACC+3 +6
        Legs = 'Bard\'s Cannions', -- +7
        Feet = 'Savage Gaiters', -- +2
        Back = 'Jester\'s Cape +1', -- +10
    },
    ['MND'] = {
        Main = 'Apollo\'s Staff',
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Promise Badge',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Aqua Ring',
        Legs = 'Errant Slops',
        Waist = 'Penitent\'s Rope',
        Feet = 'Suzaku\'s Sune-Ate',
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/lockstyle on');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local env = gData.GetEnvironment();

    if (player.SubJob == 'NIN') then
        gFunc.Equip('Body', 'Scorpion Harness +1');
        gFunc.Equip('Head', 'Emperor Hairpin');
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Main', 'Dark Staff');
        gFunc.Equip('Body', 'Errant Hpl.');
    else
        gFunc.EquipSet(sets.Idle);
        if (player.MPP < 75) then
            gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.Refresh));
        end
    end

    -- if (string.match(env.Area, 'San d\'Oria') and not string.match(env.Area, 'Airship') and not string.match(env.Area, 'Dynamis')) then
    --     gFunc.Equip('Body', 'Kingdom Aketon');
    -- end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.Equip('Legs', 'Byakko\'s Haidate');
    gFunc.Equip('Waist', 'Swift Belt');
    gFunc.Equip('Ear2', 'Loquac. Earring');
    gFunc.Equip('Feet', 'Rostrum Pumps');

    -- WHM 1087 / 75% = 815

    if (spell.Skill == 'Singing') then
        local player = gData.GetPlayer();
        if (player.HPP > 75) then
            gFunc.ForceEquipSet('HP_DOWN');
        end

        gFunc.EquipSet('HP_UP');
    end
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();
    local env = gData.GetEnvironment();

    gFunc.Message(action.Element);
    if (action.Type == 'Bard Song') then
        if (string.match(action.Name, 'Minuet')) then
            gFunc.EquipSet(sets.Wind);
            gFunc.Equip('Range', 'Cornette +1');
        elseif (string.match(action.Name, 'March')) then
            gFunc.EquipSet(sets.Wind);
            gFunc.Equip('Range', 'Faerie Piccolo');
        elseif (string.match(action.Name, 'Madrigal')) then
            gFunc.EquipSet(sets.Wind);
            gFunc.Equip('Range', 'Traversiere +1');
        elseif (string.match(action.Name, 'Carol')) then
            gFunc.EquipSet(sets.Wind);
            gFunc.Equip('Range', 'Crumhorn +1');
        elseif (string.match(action.Name, 'Paeon')) then
            gFunc.EquipSet(sets.String);
            gFunc.Equip('Range', 'Ebony Harp +1');
        elseif (string.match(action.Name, 'Ballad')) then
            gFunc.EquipSet(sets.Wind);
            gFunc.Equip('Range', 'Cornette +1');
            -- gFunc.EquipSet(sets.String);
            -- gFunc.Equip('Range', 'Ebony Harp +1');
        elseif (string.match(action.Name, 'Mazurka')) then
            gFunc.EquipSet(sets.String);
            gFunc.Equip('Range', 'Ebony Harp +1');
        elseif (string.match(action.Name, 'Requiem')) then
            gFunc.EquipSet(gFunc.Combine(sets.CHR, sets.Wind));
            if (env.RawWeatherElement == 'Dark') then
                gFunc.Equip('Ear2', 'Diabolos\'s Earring');
            end
        elseif (string.match(action.Name, 'Elegy')) then
            gFunc.EquipSet(gFunc.Combine(sets.CHR, sets.Wind));
            if (env.RawWeatherElement == 'Dark') then
                gFunc.Equip('Ear2', 'Diabolos\'s Earring');
            end
            gFunc.Equip('Range', 'Horn +1');
            gFunc.Equip('Main', 'Terra\'s Staff');
        elseif (string.match(action.Name, 'Lullaby')) then
            if (action.Name == 'Horde Lullaby') then    
                gFunc.EquipSet(gFunc.Combine(sets.CHR, sets.String));
                gFunc.Equip('Range', 'Ebony Harp +1');
            else    
                gFunc.EquipSet(gFunc.Combine(sets.CHR, sets.Wind));
                gFunc.Equip('Range', 'Ryl.Spr. Horn');
            end
            if (env.RawWeatherElement == 'Dark') then
                gFunc.Equip('Ear2', 'Diabolos\'s Earring');
            end
            gFunc.Equip('Main', 'Apollo\'s Staff');
        end
        gFunc.EquipSet(sets.Singing);
    end

    if (string.match(action.Name, 'Cure')) then
        gFunc.EquipSet('MND');
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;