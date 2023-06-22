local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Lgn. Staff',
        Head = 'Silver Hairpin',
        Neck = 'Justice Badge',
        Ear1 = 'Energy Earring',
        Ear2 = 'Energy Earring',
        Body = 'Doublet',
        Hands = 'Savage Gauntlets',
        Ring1 = 'Astral Ring',
        Ring2 = 'Astral Ring',
        Waist = 'Friar\'s Rope',
        Legs = 'Baron\'s Slops',
        Feet = 'San d\'Orian Clogs',
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
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;