--------------------------------------------------------------------------------------------------------------------------------------------
-- Put this first part into qb-smallresources/client/consumables.lua / anywhere is fine and don't forget to make a back up! 

-- Dirty Water effect

local isSick = false

RegisterNetEvent('qb-dirtywater:client:startSickness', function()
    local ped = PlayerPedId()
    local ticks = 0

    CreateThread(function()
        while isSick and ticks < 10 do
            Wait(3000)
            ticks += 1

            local health = GetEntityHealth(ped)
            if health > 10 then
                SetEntityHealth(ped, math.floor(health * 0.99))
            end

            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.2)
            TriggerScreenblurFadeIn(1000)
            Wait(1000)
            TriggerScreenblurFadeOut(1000)
        end

        isSick = false
        QBCore.Functions.Notify("You start to feel better.", "success")
    end)
end)

local isSick = false

RegisterNetEvent('qb-dirtywater:client:startSickness', function()
    local ped = PlayerPedId()
    local ticks = 0

    CreateThread(function()
        while isSick and ticks < 10 do
            Wait(3000)
            ticks += 1

            -- 1% Health decay
            local health = GetEntityHealth(ped)
            if health > 10 then
                SetEntityHealth(ped, math.floor(health * 0.99))
            end

            -- Screen shake
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.2)

            -- Camera blur
            TriggerScreenblurFadeIn(1000)
            Wait(1000)
            TriggerScreenblurFadeOut(1000)
        end

        isSick = false
        QBCore.Functions.Notify("You start to feel better.", "success") -- This can be adjusted to what ever you want the notification to say! :) 
    end)
end)

--------------------------------------------------------------------------------------------------------------------------------------------

-- Put this second part into qb-smallresources/server/consumables.lua / anywhere is fine and don't forget to make a back up!

QBCore.Functions.CreateUseableItem('dirty_water', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.RemoveItem('dirty_water', 1)
        TriggerClientEvent('qb-dirtywater:client:drink', source)
    end
end)

--------------------------------------------------------------------------------------------------------------------------------------------

-- Put this into your inventory / Image is located in the file, can change the image but make sure you adjust the ['image'] = 'dirtywater.png', to the correct image name

['dirty_water'] = {['name'] = 'dirty_water', ['label'] = 'Dirty Water', ['weight'] = 500, ['type'] = 'item', ['image'] = 'dirtywater.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'contaminated water, some sort of tablet will do the trick!'},

--------------------------------------------------------------------------------------------------------------------------------------------