RegisterNetEvent("arro:demandeausql")
AddEventHandler("arro:demandeausql", function()
    local _src = source
    MySQL.Async.fetchAll("SELECT * FROM cadeau WHERE identifier = @a", {["a"] = GetPlayerIdentifier(_src)}, function(result)
        if result[1] then
            --print("Déjà Recup")
            local messagedejarecup = Config.Messagedejarecup
            TriggerClientEvent("arro:notifdejarecup", _src, messagedejarecup)
        else
            MySQL.Async.execute("INSERT INTO cadeau (identifier,name) VALUES (@a,@b)", {["a"] = GetPlayerIdentifier(_src), ["b"] = GetPlayerName(_src)}, function()
                --print("Recup")
                local price = Config.Price
                local messagerecup = Config.Messagerecup
                local xPlayer = ESX.GetPlayerFromId(_src)
                xPlayer.addAccountMoney('bank', price)
                TriggerClientEvent("arro:notifrecup", _src, messagerecup, price)
            end)
        end
    end)
end)