local profile = {};
local sets = {
    ['HPDOWN'] = {
        Main = 'Terra\'s Staff',
        Range = 'Cornette +1',
        Head = 'Zenith Crown',
        Neck = 'Star Necklace',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Black Cotehardie',
        Hands = 'Zenith Mitts',
        Ring1 = 'Astral Ring',
        Ring2 = 'Astral Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Zenith Slacks',
        Feet = 'Errant Pigaches',
    },
    ['Idle'] = {
        Main = 'Earth Staff',
        Range = 'Cornette +1',
        Neck = 'Wind Torque',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Vermillion Cloak',
        Hands = 'Choral Cuffs',
        Ring2 = 'Bomb Queen Ring',
        Ring1 = 'Tamas Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Corsette +1',
        Legs = 'Bard\'s Cannions',
        Feet = 'Rostrum Pumps'
    },
    ['Song_Precast'] = {
        Body = 'Savage Separates',
        Neck = 'Bloodbead Amulet',
        Ring1 = 'Minstrel\'s Ring',
        Ring2 = 'Bomb Queen Ring',
        Legs = 'Bard\'s Cannions',
        Feet = 'Savage Gaiters',
    },
    ['Debuff'] = {
        Head = 'Errant Hat',
        Body = 'Errant Hpl.',
        Hands = 'Choral Cuffs',
        Ring1 = 'Tamas Ring',
        Legs = 'Bard\'s Cannions',
        Feet = 'Savage Gaiters',
    },
    ['MND'] = {
        Main = 'Apollo\'s Staff',
        Body = 'Errant Hpl.',
        Back = 'Prism Cape',
        Neck = 'Promise Badge',
        Ring1 = 'Tamas Ring',
        Legs = 'Errant Slops',
        Waist = 'Penitent\'s Rope',
        Feet = 'Errant Pigaches',
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 1');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();

    if (player.SubJob == 'NIN') then
        gFunc.Equip('Body', 'Scorpion Harness');
        gFunc.Equip('Head', 'Emperor Hairpin');
    else
        -- gFunc.Equip('Body', 'Vermillion Cloak');
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Main', 'Dark Staff');
        gFunc.Equip('Body', 'Errant Hpl.');
    else
        gFunc.EquipSet(sets.Idle);
    end
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
            gFunc.ForceEquipSet('HPDOWN');
        end

        gFunc.EquipSet('Song_Precast');
    end
    
    
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    if (action.Type == 'Bard Song') then
        gFunc.Equip('Hands', 'Choral Cuffs');
        if (action.Name == 'Valor Minuet') or (action.Name == 'Valor Minuet II') or
            (action.Name == 'Valor Minuet III') or (action.Name == 'Valor Minuet IV') then
            gFunc.Equip('Range', 'Cornette +1');
        elseif (action.Name == 'Advancing March') or (action.Name == 'Victory March') then
            gFunc.Equip('Range', 'Faerie Piccolo');
        elseif (action.Name == 'Sword Madrigal') or (action.Name == 'Blade Madrigal') then
            gFunc.Equip('Range', 'Traversiere +1');
        elseif (action.Name == 'Battlefield Elegy') or (action.Name == 'Carnage Elegy') then
            gFunc.Equip('Range', 'Horn +1');
            gFunc.Equip('Main', 'Terra\'s Staff');
            gFunc.EquipSet('Debuff');
        elseif (string.match(action.Name, 'Lullaby')) or (action.Name == 'Magic Finale') or (string.match(action.Name, 'Requiem')) then
            if (action.Name == 'Horde Lullaby') then    
                gFunc.Equip('Range', 'Ebony Harp +1');
            else    
                gFunc.Equip('Range', 'Ryl.Spr. Horn');
            end
            gFunc.Equip('Main', 'Apollo\'s Staff');
            gFunc.EquipSet('Debuff');
        elseif (action.Name == 'Chocobo Mazurka') or (string.match(action.Name, 'Paeon')) then
            gFunc.Equip('Range', 'Ebony Harp +1');
        else
            gFunc.Equip('Range', 'Ryl.Spr. Horn');
            -- gFunc.Equip('Range', 'Ebony Harp +1');
        end
    end

    if (string.match(action.Name, 'Cure')) then
        gFunc.EquipSet('MND');
    end

    if (string.match(env.Area, 'San d\'Oria')) then
        gFunc.Equip('Body', 'Kingdom Aketon');
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;