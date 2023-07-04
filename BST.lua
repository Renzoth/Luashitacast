local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Darksteel Pick', 'Viking Axe'},
        Sub = {'Darksteel Pick', 'Barbaroi Axe'},
        Head = {'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Spike Earring'},
        Ear2 = {'Spike Earring'},
        Body = {'Haubergeon', 'Alumine Haubert'},
        Hands = {'Alumine Moufles'},
        Ring1 = {'Victory Ring', 'Courage Ring'},
        Ring2 = {'Woodsman Ring', 'Balance Ring'},
        Back = {'Amemet Mantle', 'Traveler\'s Mantle'},
        Waist = {'Swift Belt'},
        Legs = {'Ryl.Kgt. Breeches', 'Republic Subligar'},
        Feet = {'Alumine Sollerets'},
    },
    ['Str'] = {
        Neck = 'Spike Necklace',
        Ring2 = 'Courage Ring',
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

local Settings = {
    currentLevel = 0,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
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
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Idle);
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();
    local player = gData.GetPlayer();

    if (ability.Name == "Charm") then
        gFunc.EquipSet(sets.Chr);
    elseif (ability.Name == "Reward") then
        if (player.MainJobSync < 48) then
            gFunc.Equip('Ammo', 'Pet Food Beta')
        elseif (player.MainJobSync < 60) then
            gFunc.Equip('Ammo', 'Pet Food Delta')
        else 
            gFunc.Equip('Ammo', 'Pet Fd. Epsilon')
        end
        gFunc.EquipSet(sets.Mnd);
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local action = gData.GetAction();

    if (string.match(action.Name, 'Cure')) then
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