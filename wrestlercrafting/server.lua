QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('custom:checkCraftingRequirements', function(source, cb, location)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name ~= location.job then
        cb(false)
        return
    end

    if Player.Functions.GetMoney("cash") < Config.CraftingCost then
        cb(false)
        return
    end

    for _, item in pairs(Config.RequiredItems) do
        local playerItem = Player.Functions.GetItemByName(item.name)
        if not playerItem or playerItem.amount < item.amount then
            print("Eksik malzeme: " .. item.name)
            cb(false)
            return
        end
    end
    cb(true)
end)


RegisterServerEvent("custom:craftWeapon")
AddEventHandler("custom:craftWeapon", function(location)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name ~= location.job then
        TriggerClientEvent('QBCore:Notify', src, "Bu üretim alanını kullanma yetkiniz yok!", "error", 5000)
        return
    end

    if Player.Functions.GetMoney("cash") < Config.CraftingCost then
        TriggerClientEvent('QBCore:Notify', src, "Yeterli paranız yok!", "error", 5000)
        return
    end

    for _, item in pairs(Config.RequiredItems) do
        local playerItem = Player.Functions.GetItemByName(item.name)
        if not playerItem or playerItem.amount < item.amount then
            TriggerClientEvent('QBCore:Notify', src, item.name .. " eksik!", "error", 5000)
            return
        end
    end

    Player.Functions.RemoveMoney("cash", Config.CraftingCost)
    for _, item in pairs(Config.RequiredItems) do
        Player.Functions.RemoveItem(item.name, item.amount)
    end

    local totalChance = 0
    for _, weapon in pairs(Config.WeaponRewards) do
        totalChance = totalChance + weapon.chance
    end

    local randomChance = math.random(0, totalChance)
    local selectedWeapon
    local cumulativeChance = 0
    for _, weapon in pairs(Config.WeaponRewards) do
        cumulativeChance = cumulativeChance + weapon.chance
        if randomChance <= cumulativeChance then
            selectedWeapon = weapon.name
            break
        end
    end

    Player.Functions.AddItem(selectedWeapon, 1)
    TriggerClientEvent('QBCore:Notify', src, "Silah başarıyla üretildi: " .. selectedWeapon, "success")
end)
