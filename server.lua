local serverToken = "NQJJBOHKBWDWH8"
local rewardMoney = 5000

ESX = exports["es_extended"]:getSharedObject()

print("^2[vote_system] ^7Le script de vote est charge avec succes !")

RegisterCommand("vote", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local steamID64 = nil
        local identifiers = GetPlayerIdentifiers(source)

        for _, v in pairs(identifiers) do
            if string.find(v, "steam:") then
                steamID64 = tostring(tonumber(string.sub(v, 7), 16))
                break
            end
        end

        if steamID64 then
            local url = string.format("https://api.top-serveurs.net/v1/votes/claim-steam?server_token=%s&steam_id=%s", serverToken, steamID64)

            PerformHttpRequest(url, function(errorCode, resultData, headers)
                if errorCode == 200 then
                    local data = json.decode(resultData)
                    if data.claimed == 1 then
                        xPlayer.addAccountMoney('bank', rewardMoney)
                        TriggerClientEvent('esx:showNotification', source, "~g~Succes!~s~ Tu as recu ~g~" .. rewardMoney .. "$~s~ pour ton vote.")
                    elseif data.claimed == 2 then
                        TriggerClientEvent('esx:showNotification', source, "~y~Info~s~: Vote deja recuperée.")
                    else
                        TriggerClientEvent('esx:showNotification', source, "~r~Erreur~s~: Aucun vote trouve sur Top-Serveurs.")
                    end
                else
                    print("^1[vote_system] Erreur API : " .. errorCode .. "^7")
                end
            end, "GET")
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Erreur~s~: Ton Steam n'est pas ouvert ou lié à FiveM.")
        end
    end
end, false)