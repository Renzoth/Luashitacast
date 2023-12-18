local profile = {};
local sets = {
    ['HPDOWN'] = {
        Main = 'Earth Staff',
        Range = 'Cornette +1',
        Head = 'Zenith Crown',
        Neck = 'Star Necklace',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Black Cotehardie',
        Hands = 'Zenith Mitts',
        Ring1 = 'Minstrel\'s Ring',
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
        Ring2 = 'Tamas Ring',
        Ring1 = 'Minstrel\'s Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Corsette +1',
        Legs = 'Bard\'s Cannions',
        Feet = 'Rostrum Pumps'
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
        gFunc.Equip('Body', 'Crow Jupon');
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
    gFunc.EquipSet('HPDOWN');
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();
    
    gFunc.EquipSet('Idle');
    gFunc.Equip('Ring2', 'Bomb Queen Ring')

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
            gFunc.Equip('Main', 'Earth Staff');
            gFunc.Equip('Head', 'Noble\'s Ribbon');
            gFunc.Equip('Body', 'Errant Hpl.');
            gFunc.Equip('Legs', 'Bard\'s Cannions');
            gFunc.Equip('Feet', 'Savage Gaiters');
        elseif (action.Name == 'Foe Lullaby') or (action.Name == 'Horde Lullaby') or (action.Name == 'Magic Finale') or (string.match(action.Name, 'Requiem')) then
            if (action.Name == 'Horde Lullaby') then    
                gFunc.Equip('Range', 'Ebony Harp +1');
            else    
                gFunc.Equip('Range', 'Ryl.Spr. Horn');
            end
            gFunc.Equip('Head', 'Noble\'s Ribbon');
            gFunc.Equip('Body', 'Errant Hpl.');
            gFunc.Equip('Main', 'Apollo\'s Staff');
            gFunc.Equip('Legs', 'Bard\'s Cannions');
            gFunc.Equip('Feet', 'Savage Gaiters');
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
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;