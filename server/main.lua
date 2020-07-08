Inventory = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('poke_medic:getjob')
AddEventHandler('poke_medic:getjob', function(type)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local job = user.job
        if job == 'medic' then
            TriggerClientEvent('poke_medic:auth', _source, type)
        end
    end)
end)

RegisterServerEvent('poke_medic:revivePlayer')
AddEventHandler('poke_medic:revivePlayer', function(closestPlayer)
    local _source = source
    local count = Inventory.getItemCount(_source, "syringe")
    if count > 0 then
        Inventory.subItem(_source, "syringe", 1)
        TriggerClientEvent('poke_medic:revive', closestPlayer)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('syringe')), 3000)
    end
end)

RegisterServerEvent('poke_medic:healPlayer')
AddEventHandler('poke_medic:healPlayer', function(closestPlayer)
    local _source = source
    local count = Inventory.getItemCount(_source, "bandage")
    if count > 0 then
        Inventory.subItem(_source, "bandage", 1)
        TriggerClientEvent('poke_medic:heal', closestPlayer)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('bandage')), 3000)
    end
end)

RegisterServerEvent('poke_medic:takeItems')
AddEventHandler('poke_medic:takeItems', function()
    local _source = source
    local count = Inventory.getItemCount(_source, "bandage")
    local count2 = Inventory.getItemCount(_source, "syringe")
    if count >= 5 and count2 >= 5 then
        TriggerClientEvent("vorp:TipRight", _source, _U('you_full'), 3000)
    else
        Inventory.addItem(_source, "bandage", 5)
        Inventory.addItem(_source, "syringe", 5)
        TriggerClientEvent("vorp:TipRight", _source, _U('you_take'), 3000)
    end
end)