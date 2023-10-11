local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Earth Staff',
        Range = 'Horn +1',
        Neck = 'Wind Torque',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Hands = 'Zenith Mitts', 'Choral Cuffs',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Minstrel\'s Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Corsette +1',
        Legs = 'Bard\'s Cannions',
        Feet = 'Crow Gaiters',
    },
    ['MP'] = {
        Ring2 = 'Astral Ring',
        Legs = 'Bard\'s Cannions',
    },
    ['MND'] = {
        Body = 'Errant Hpl.',
        Main = 'Apollo\'s Staff',
        Legs = 'Bard\'s Cannions',
    }
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
        gFunc.Equip('Body', 'Vermillion Cloak');
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
    gFunc.Equip('Body', 'Sha\'ir Manteel');ok
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