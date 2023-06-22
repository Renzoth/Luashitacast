local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Earth Staff',
        Range = 'Horn +1',
        Neck = 'Wind Torque',
        Ear1 = 'Melody Earring +1',
        Ear2 = 'Melody Earring +1',
        Hands = 'Choral Cuffs',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Minstrel\'s Ring',
        Back = 'Jester\'s Cape +1',
        Waist = 'Corsette +1',
        Legs = 'Choral Cannions',
        Feet = 'Crow Gaiters',
    },
    ['MP'] = {
        Ring2 = 'Astral Ring',
        Legs = 'Savage Loincloth',
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
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
    
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();
    
    if (action.Type == 'Bard Song') then
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
            gFunc.Equip('Legs', 'Errant Slops');
            gFunc.Equip('Feet', 'Savage Gaiters');
        elseif (action.Name == 'Foe Lullaby') or (action.Name == 'Horde Lullaby') or (action.Name == 'Magic Finale') or (string.match(action.Name, 'Requiem')) then
            if (action.Name == 'Horde Lullaby') then    
                gFunc.Equip('Range', 'Ebony Harp +1');
            else    
                gFunc.Equip('Range', 'Ryl.Spr. Horn');
            end
            gFunc.Equip('Head', 'Noble\'s Ribbon');
            gFunc.Equip('Body', 'Errant Hpl.');
            gFunc.Equip('Main', 'Light Staff');
            gFunc.Equip('Legs', 'Errant Slops');
            gFunc.Equip('Feet', 'Savage Gaiters');
        elseif (action.Name == 'Chocobo Mazurka') or (string.match(action.Name, 'Paeon')) then
            gFunc.Equip('Range', 'Ebony Harp +1');
        else
            gFunc.Equip('Range', 'Ryl.Spr. Horn');
            -- gFunc.Equip('Range', 'Ebony Harp +1');
        end
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;