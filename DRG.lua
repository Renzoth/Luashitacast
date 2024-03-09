local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Gnd.Kgt. Lance', 'Darksteel Lance', 'Holy lance', 'Mythril Lance', 'Peregrine'},
        Head = {'Emperor Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Spike Earring', 'Beetle Earring +1'},
        Body = {'Scorpion Harness', 'Brigandine', 'Savage Separates'},
        Hands = {'Drachen Fng. Gnt.', 'Battle Gloves'},
        Ring1 = {'Sniper\'s Ring'},
        Ring2 = {'Sniper\'s Ring'},
        Back = {'Amemet Mantle +1', 'Traveler\'s Mantle'},
        Waist = {'Swift Belt', 'Brave Belt'},
        Legs = {'Drachen Brais', 'Republic Subligar'},
        Feet = {'Bounding Boots'},
    },
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
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (petAction ~= nil) then
        -- gFunc.Equip('Head', 'Drachen Armet');
        return;
    end
    
    if (player.SubJob == 'WHM' or player.SubJob == 'RDM') then
        gFunc.EquipSet('Idle');
        gFunc.Equip('Ring2', 'Astral Ring');
    else
        gFunc.EquipSet('Idle');
    end

    if (player.HPP <= 50 and player.SubJob == 'RDM') then
        gFunc.Message("HEAL!")
    end
end

profile.HandleAbility = function()
    local action = gData.GetAction();

    if (string.match(action.Name, 'Jump')) then
        gFunc.Equip('Feet', 'Drachen Greaves');
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
    gFunc.Equip('Head', 'Drachen Armet');
    gFunc.Equip('Ring1', 'Courage Ring');
    gFunc.Equip('Ring2', 'Courage Ring');
    gFunc.Equip('Feet', 'Savage Gaiters');
    gFunc.Equip('Body', 'Savage Separates');
    gFunc.Equip('Waist', 'Rly.Kgt. Belt');
end

return profile;