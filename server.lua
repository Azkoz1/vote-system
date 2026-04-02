-- ==========================================
-- CONFIGURATION (À MODIFIER)
-- ==========================================
local serverToken = "VOTRE_TOKEN_TOP_SERVEUR" -- Remplacez par votre Token API Top-Serveur
local rewardMoney = 5000 -- Montant de la récompense en argent

-- ==========================================
-- LOGIQUE DU SCRIPT
-- ==========================================
ESX = exports["es_extended"]:getSharedObject()

print("^2[vote_system] ^7Le script de vote est charge avec succes !")

RegisterCommand("vote", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local steamID64 = nil
        local identifiers = GetPlayerIdentifiers(source)

        -- Extraction du SteamID64 pour l'API
        for _, v in pairs(identifiers) do
            if string.find(v, "steam:") then
                steamID64 = tostring(tonumber(string.sub(v, 7), 16))
                break
            end
        end

        if steamID64 then
            -- URL de l'API Top-Serveurs
            local url = string.format("https://api.top-serveurs.net/v1/votes/claim-steam?server_token=%s&steam_id=%s", serverToken, steamID64)

            PerformHttpRequest(url, function(errorCode, resultData, headers)
                if errorCode == 200 then
                    local data = json.decode(resultData)
                    
                    if data.claimed == 1 then
                        -- Récompense donnée au joueur
                        xPlayer.addAccountMoney('bank', rewardMoney)
                        TriggerClientEvent('esx:showNotification', source, "~g~Succès !~s~ Tu as reçu ~g~" .. rewardMoney .. "$~s~ pour ton vote.")
                    
                    elseif data.claimed == 2 then
                        TriggerClientEvent('esx:showNotification', source, "~y~Info~s~ : Récompense déjà récupérée pour ce vote.")
                    
                    else
                        TriggerClientEvent('esx:showNotification', source, "~r~Erreur~s~ : Aucun vote trouvé sur Top-Serveurs.")
                    end
                else
                    -- Message d'erreur console si l'API ne répond pas
                    print("^1[vote_system] Erreur API : " .. errorCode .. "^7")
                    TriggerClientEvent('esx:showNotification', source, "~r~Erreur~s~ : Impossible de joindre l'API de vote.")
                end
            end, "GET")
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Erreur~s~ : Steam n'est pas détecté. Vérifiez que votre Steam est lancé.")
        end
    end
end, false)
