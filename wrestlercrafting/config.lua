Config = {}

Config.CraftingLocations = {
    {
        coords = vector3(-1309.47, -390.85, 36.7), 
        job = "tuccar1", 
        label = "Silah Üretim Alanı 1"
    },
    {
        coords = vector3(6.59, -1100.18, 29.8), 
        job = "tuccar2", 
        label = "Silah Üretim Alanı 2"
    },
    {
        coords = vector3(323.4, 656.7, 789.0), 
        job = "tuccar3", -- Üçüncü meslek
        label = "Silah Üretim Alanı 3"
    }
    -- DAHA EKLEMEK ISTERSENIZ BURAYA EKLEYEBILIRSINIZ
}

Config.RequiredItems = {
    {name = "kaydirak", amount = 1},
    {name = "namlu", amount = 1},
    {name = "sarjor", amount = 1},
    {name = "tetik", amount = 1},
    {name = "yay", amount = 1},
    {name = "tutamac", amount = 1},
}


Config.WeaponRewards = {
    {name = "WEAPON_dp9", chance = 75}, -- %75 şans ZIGZAG
    {name = "WEAPON_g17", chance = 45}, -- %45 şans
    {name = "WEAPON_g19", chance = 35}, -- %35 şans
--    {name = "WEAPON_g19", chance = 35}, -- %35 şans
--    {name = "WEAPON_g19", chance = 35}, -- %35 şans
--    {name = "WEAPON_g19", chance = 35}, -- %35 şans
-- EKLEMEYE DEVAM EDEBILIRSINIZ
}

Config.CraftingCost = 1000000 -- NAKIT PARA MIKTARI

-- PARAYI KAPATMAK ISTERSENIZ SIFIR YAPMANIZ YETERLI