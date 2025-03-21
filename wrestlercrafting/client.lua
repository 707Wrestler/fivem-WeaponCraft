QBCore = exports['qb-core']:GetCoreObject()

local playerJob = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local playerData = QBCore.Functions.GetPlayerData()
    playerJob = playerData.job.name
    print("Oyuncu Mesleği: " .. playerJob) 
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    playerJob = job.name
    print("Meslek Güncellendi: " .. playerJob) 
end)

local function CanCraft(location)
    local canCraft = false
    local reason = nil
    local finished = false

    QBCore.Functions.TriggerCallback('custom:checkCraftingRequirements', function(result, reasonMessage)
        canCraft = result
        reason = reasonMessage or "Üretim için yeterli malzeme veya paranız yok!"
        finished = true
    end, location)

    while not finished do
        Wait(0)
    end

    return canCraft, reason
end

local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

RegisterNetEvent("custom:startCrafting")
AddEventHandler("custom:startCrafting", function(location)
    local ped = PlayerPedId()
    local canCraft, reason = CanCraft(location)

    if canCraft then
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
        QBCore.Functions.Progressbar("craft_weapon", "Silah Üretiliyor...", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            ClearPedTasksImmediately(ped)
            TriggerServerEvent("custom:craftWeapon", location)
        end, function()
            ClearPedTasksImmediately(ped)
            QBCore.Functions.Notify("Üretim iptal edildi.", "error")
        end)
    else
        QBCore.Functions.Notify(reason, "error")
    end
end)

CreateThread(function()
    while true do
        local sleep = 0
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        if not playerJob then
            local playerData = QBCore.Functions.GetPlayerData()
            playerJob = playerData.job.name
        end

        for _, location in pairs(Config.CraftingLocations) do
            local dist = #(pedCoords - location.coords)

            if playerJob == location.job and dist < 2.0 then
                sleep = 0
                DrawText3D(location.coords.x, location.coords.y, location.coords.z, "[E] Silah Üret")

                if IsControlJustReleased(0, 38) then
                    TriggerEvent("custom:startCrafting", location)
                end
            end
        end

        Wait(sleep)
    end
end)
