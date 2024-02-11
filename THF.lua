local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Blau Dolch', 'Trailer\'s Kukri', 'Marauder\'s Knife', 'Mrc.Cpt. Kukri', 'Decurion\'s Dagger'},
        Sub = {'Thief\'s Knife', 'Bone Knife +1', 'Mrc.Cpt. Kukri', 'Decurion\'s Dagger'},
        Range = {'Arbalest +1', 'Zamburak +1', 'Power Crossbow'},
        -- Ammo = {''},
        Head = {'Optical Hat', 'Emperor Hairpin'},
        Neck = {'Peacock Amulet', 'Spike Necklace'},
        Ear1 = {'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Spike Earring', 'Beetle Earring +1'},
        -- Body = {'Scorpion Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1'},
        Body = {'Rapparee Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1'},
        Hands = {'Battle Gloves'},
        Ring1 = {'Sniper\'s Ring', 'Deft Ring', 'Balance Ring'},
        Ring2 = {'Woodsman Ring', 'Deft Ring', 'Balance Ring'},
        Back = {'Amemet Mantle +1', 'Traveler\'s Mantle'},
        -- Waist = {'Life Belt', 'Mrc.Cpt. Belt', 'Warrior\'s Belt'},
        Waist = {'Swift Belt', 'Mrc.Cpt. Belt', 'Warrior\'s Belt'},
        Legs = {'Republic Subligar'},
        Feet = {'Bounding Boots'},
    },
    ['TreasureHunter'] = {
        Neck = 'Nanaa\'s Charm',
        -- Hands = '',
    },
    ['Evasion'] = {
        Body = 'Scorpion Harness',
    },
    ['RATK'] = {
        Head = 'Optical Hat',
        Hands = 'Noct Gloves',
        Ring1 = 'Scorpion Ring +1',
        Ring2 = 'Scorpion Ring +1',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
    },
    ['SA'] = {
        Head = 'Assassin\'s Bonnet',
        Body = 'Dragon Harness',
        Neck = 'Spike Necklace',
        Ring1 = 'Deft Ring',
        Ring2 = 'Deft Ring',
        Waist = 'Warwolf Belt',
    },
    ['TA'] = {
        Body = 'Dragon Harness',
        Head = 'Emperor Hairpin',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Neck = 'Spike Necklace',
        Waist = 'Warwolf Belt',
    },
    ['WS'] = {

    },
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    currentLevel = 0;
    TH = false;
}

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /th /lac fwd th');

    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /th');
end

profile.HandleCommand = function(args)
    if (args[1] == 'th') then
        if (Settings.TH == true) then
            gFunc.Message('TH Off');
            Settings.TH = false;
        else
            gFunc.Message('TH On');
            Settings.TH = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local sneak = gData.GetBuffCount('Sneak Attack');
    local trick = gData.GetBuffCount('Trick Attack');
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (sneak == 1 and trick == 1) then
        gFunc.EquipSet(gFunc.Combine(sets.SA, sets.TA));
        return;
    elseif (sneak == 1 and trick == 0) then
        gFunc.EquipSet(sets.SA);
        return;
    elseif (sneak == 0  and trick == 1) then
        gFunc.EquipSet(sets.TA);
        return;
    else
        if (Settings.TH == false) then
            gFunc.EquipSet(sets.Idle);
            if (player.Status == 'Engaged' and player.IsMoving == false) then
                gFunc.Equip('Hands', 'Dusk Gloves');
            end
        elseif (Settings.TH == true) then
            gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.TreasureHunter));
        end
    end

    if (string.match(env.Area, 'San d\'Oria')) then
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
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.RATK);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.RATK);
end

profile.HandleWeaponskill = function()
    local ws = gData.GetAction();

    if (ws.Name == 'Dancing Edge') then
        gFunc.EquipSet(sets.SA);
    end
end

return profile;