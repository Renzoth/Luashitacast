local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Viking Axe',
        Sub = 'Barbaroi Axe',
        Head = 'Emperor Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Spike Earring',
        Ear2 = 'Spike Earring',
        Body = 'Haubergeon',
        Hands = 'Alumine Moufles',
        Ring1 = 'Courage Ring',
        Ring2 = 'Balance Ring',
        Back = 'Traveler\'s Mantle',
        Waist = 'Swift Belt',
        Legs = 'Ryl.Kgt. Breeches',
        Feet = 'Alumine Sollerets',
    },
    ['Str'] = {
        Neck = 'Spike Necklace',
        Ring1 = 'Courage Ring',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Savage Gaiters',
    },
    ['Mnd'] = {
        Neck = 'Justice Badge',
        Hands = 'Savage Gauntlets',
        Ring1 = 'Saintly Ring',
        Waist = 'Ryl.Kgt. Belt',
        Legs = 'Savage Loincloth',
    },
    ['Chr'] = {
        Head = 'Noble\'s Ribbon',
        Neck = 'Bird Whistle',
        Waist = 'Ryl.Kgt. Belt',
        Ring1 = 'Hope Ring',
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

    if (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Idle);
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if (ability.Name == "Charm") then
        gFunc.EquipSet(sets.Chr);
    elseif (ability.Name == "Reward") then
        gFunc.EquipSet(sets.Mnd);
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if (spell.Name == "Cure") or (spell.Name == "Cure II") then
        gFunc.EquipSet(sets.Mnd);
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local ws = gData.GetAction();

    if (ws.Name == "Raging Axe") or (ws.Name == "Spinning Axe") or (ws.Name == "Rampage") then
        gFunc.EquipSet(sets.Str);
    end

end

return profile;