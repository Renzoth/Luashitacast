local profile = {};
local sets = {
    ['Idle_Priority'] = {
        Main = {'Earth Staff', 'Solid Wand'},
        -- Sub = {'Maple Shield'},
        -- Head = {'Bastokan Circlet'},
        Neck = {'Justice Badge'},
        Ear1 = {'Loquac. Earring', 'Energy Earring'},
        Ear2 = {'Magnetic Earring', 'Energy Earring'},
        Body = {'Cleric\'s Bliaut', 'Vermillion Cloak', 'Seer\'s Tunic'},
        Hands = {'Zenith Mitts', 'Savage Gauntlets'},
        Ring1 = {'Tamas Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'White Cape +1'},
        Waist = {'Hierarch Belt', 'Friar\'s Rope'},
        Legs = {'Savage Loincloth'},
        Feet = {'Seer\'s Pumps +1'},
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
    local pet = gData.GetPet();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (player.Status == 'Resting') then
        gFunc.Equip('Neck', 'Checkered Scarf');
        gFunc.Equip('Body', 'Errant Hpl.');
        if (player.SubJob == 'BLM') then
            gFunc.Equip('Back', 'Wizard\'s Mantle')
        end
        if (player.MainJobSync < 51) then
            gFunc.Equip('Main', 'Blessed Hammer');
        else
            gFunc.Equip('Main', 'Dark Staff');
        end

        if (player.MainJobSync < 59) then
            gFunc.Equip('Body', 'Seer\'s Tunic');
        end
        gFunc.Equip('Legs', 'Baron\'s Slops');
    else
        if (player.MainJobSync >= 74) then
            gFunc.Equip('Head', 'Zenith Crown');
        end
        gFunc.EquipSet('Idle');
    end

    

    if (pet ~= nil) then
        -- gFunc.Message(pet.Name)
        gFunc.Equip('Waist', 'Avatar Belt')
        if (pet.Name == 'Ifrit') then
            gFunc.Equip('Main', 'Fire Staff');
        end
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

    gFunc.Equip('Head', 'Errant Hat');

    if (string.match(action.Name, 'Cure')) then
        gFunc.Equip('Main', 'Apollo\'s Staff');
        gFunc.Equip('Hands', 'Healer\'s Mitts');
        -- gFunc.EquipSet('MND');
    end

    if (string.match(action.Name, 'Banish')) or (action.Name == 'Holy') then
        gFunc.Equip('Main', 'Apollo\'s Staff');
        gFunc.Equip('Ear1', 'Moldavite Earring');
        gFunc.Equip('Legs', 'Healer\'s Pantaln.');
        gFunc.Equip('Hands', 'Zenith Mitts');
        gFunc.Equip('Neck', 'Divine Torque');
    end

    if (action.Skill == 'Enfeebling Magic') then
        gFunc.Equip('Neck', 'Enfeebling Torque');
    end

    gFunc.Equip('Head', 'Raven Beret');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;