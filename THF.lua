local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Blau Dolch', 'Trailer\'s Kukri', 'Marauder\'s Knife', 'Mrc.Cpt. Kukri', 'Decurion\'s Dagger'},
        Sub = {'Thief\'s Knife', 'Bone Knife +1', 'Mrc.Cpt. Kukri', 'Decurion\'s Dagger'},
        Range = {'Arbalest +1', 'Zamburak +1', 'Power Crossbow'},
        Head = {'Optical Hat', 'Emperor Hairpin'},
        Neck = {'Peacock Amulet', 'Spike Necklace'},
        Ear1 = {'Brutal Earring', 'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Stealth Earring', 'Spike Earring', 'Beetle Earring +1'},
        Body = {'Rapparee Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1'},
        Hands = {'Assassin\'s Armlets', 'Battle Gloves'},
        Ring1 = {'Sniper\'s Ring', 'Deft Ring', 'Balance Ring'},
        Ring2 = {'Sniper\'s Ring', 'Deft Ring', 'Balance Ring'},
        Back = {'Amemet Mantle +1', 'Traveler\'s Mantle'},
        Waist = {'Swift Belt', 'Mrc.Cpt. Belt', 'Warrior\'s Belt'},
        Legs = {'Homam Cosciales', 'Republic Subligar'},
        Feet = {'Homam Gambieras', 'Dragon Leggings', 'Bounding Boots'},
    },
    ['TreasureHunter'] = {
        Neck = 'Nanaa\'s Charm',
        Hands = 'Assassin\'s Armlets',
    },
    ['Steal'] = {
        Head = 'Rogue\'s Bonnet',
        Feet = 'Rogue\'s Poulaines',
    },
    ['Evasion'] = {
        Head = 'Emperor Hairpin',
        Body = 'Scp. Harness +1',
        Hands = 'War Gloves',
        Back = 'Bat Cape',
        Neck = 'Evasion Torque',
        Waist = 'Scouter\'s Rope',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
    },
    ['RATK'] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Hands = 'Noct Gloves',
        Ring1 = 'Scorpion Ring +1',
        Ring2 = 'Scorpion Ring +1',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
    },
    ['INT'] = {
        Head = 'Rogue\'s Bonnet',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Snow Ring',
    },
    ['SA'] = {
        Head = 'Assassin\'s Bonnet',
        Body = 'Dragon Harness',
        Neck = 'Spike Necklace',
        Ring1 = 'Thunder Ring',
        Ring2 = 'Thunder Ring',
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
    eva = false;
}

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /th /lac fwd th');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /eva /lac fwd eva');

    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /th');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /eva');
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

    if (args[1] == 'eva') then
        if (Settings.eva == true) then
            gFunc.Message('Evasion Off');
            Settings.eva = false;
        else
            gFunc.Message('Evasion On');
            Settings.eva = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local env = gData.GetEnvironment();
    local sneak = gData.GetBuffCount('Sneak Attack');
    local trick = gData.GetBuffCount('Trick Attack');
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (sneak == 1 and trick == 1) then
        gFunc.EquipSet(gFunc.Combine(sets.TA, sets.SA));
        return;
    elseif (sneak == 1 and trick == 0) then
        gFunc.EquipSet(sets.SA);
        return;
    elseif (sneak == 0  and trick == 1) then
        gFunc.EquipSet(sets.TA);
        return;
    else
        if (Settings.TH == false) and (Settings.eva == false) then
            gFunc.EquipSet(sets.Idle);
            if (player.Status == 'Engaged' and player.IsMoving == false) then
                gFunc.Equip('Hands', 'Dusk Gloves');
            end
        elseif (Settings.TH == true) then
            gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.TreasureHunter));
        elseif (Settings.eva == true) then
            gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.Evasion));
        end
    end

    if (string.match(env.Area, 'San d\'Oria') and not string.match(env.Area, 'Airship')) then
        gFunc.Equip('Body', 'Kingdom Aketon');
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if (ability.Name == 'Flee') then
        gFunc.Equip('Feet', 'Rogue\'s Poulaines');
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if (string.match(spell.Name, 'Utsusemi')) then
        gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.Evasion));
    end
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.TreasureHunter);
end

profile.HandleMidshot = function()
    local eq = gData.GetEquipment()

    if (eq.Ammo.Name == 'Bloody Bolt') then
        gFunc.EquipSet(gFunc.Combine(sets.RATK, sets.INT));
    else
        gFunc.EquipSet(sets.RATK);
    end
end

profile.HandleWeaponskill = function()
    local ws = gData.GetAction();

    if (ws.Name == 'Dancing Edge') or (ws.Name == 'Shark Bite') or (ws.Name == 'Evisceration') then
        gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.SA));
    end
end

return profile;