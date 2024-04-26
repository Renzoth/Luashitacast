local profile = {};
local sets = {
    ['Idle_Priority'] = {
        -- Main = {'Gae Bolg', 'Gnd.Kgt. Lance', 'Darksteel Lance', 'Holy lance', 'Mythril Lance', 'Peregrine'},
        Head = {'Optical Hat', 'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Brutal Earring', 'Spike Earring', 'Beetle Earring +1'},
        Body = {'Scp. Harness +1', 'Brigandine', 'Savage Separates'},
        Hands = {'Drachen Fng. Gnt.', 'Battle Gloves'},
        Ring1 = {'Sniper\'s Ring'},
        Ring2 = {'Sniper\'s Ring'},
        Back = {'Amemet Mantle +1', 'Traveler\'s Mantle'},
        Waist = {'Swift Belt', 'Brave Belt'},
        Legs = {'Homam Cosciales', 'Drachen Brais', 'Republic Subligar'},
        Feet = {'Homam Gambieras', 'Bounding Boots'},
    },
    ['STR'] = {
        Head = 'Wyvern Helm',
        Hands = 'Pallas\'s Bracelets',
        -- Body = 'Drachen Mail',
        Ring1 = 'Flame Ring',
        Ring2 = 'Flame Ring',
        Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
        Feet = 'Barone Gambieras',
    }
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    currentLevel = 0;
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
    local pet = gData.GetPet();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end
    if (player.Status == 'Idle') then
        gFunc.EquipSet('Idle');
        if (pet ~= nil) then
            if (pet.HPP < 100) then
                gFunc.Equip('Body', 'Drachen Mail')
            end
        end
    elseif (player.Status == 'Engaged') then
        gFunc.EquipSet('Idle');
        if (player.IsMoving == false) then
            gFunc.Equip('Hands', 'Dusk Gloves');
        end
    end
end

profile.HandleAbility = function()
    local action = gData.GetAction();

    if (action.Name == "Jump") then
        gFunc.Equip('Legs', 'Barone Cosciales');
        gFunc.Equip('Feet', 'Drachen Greaves');
    elseif (action.Name == "High Jump") then
        gFunc.Equip('Legs', 'Wyrm Brais');
        gFunc.Equip('Ring1', 'Vaulter\'s Ring');
    end

    if (action.Name == 'Call Wyvern') then
        gFunc.Equip('Body', 'Wyrm Mail');
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    gFunc.Equip('Head', 'Drachen Armet');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.STR);
end

return profile;