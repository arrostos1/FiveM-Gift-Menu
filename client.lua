RegisterCommand("cadeau", function()
    RageUI.Visible(RMenu:Get("arrostos","arrostos_main"), true)
end)

RMenu.Add("arrostos", "arrostos_main", RageUI.CreateMenu("","Menu Cadeau By Arrostos"))
RMenu:Get("arrostos", "arrostos_main").Closed = function()end

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get("arrostos","arrostos_main"),true,true,true,function()
            RageUI.ButtonWithStyle("Récupèrez votre cadeau", "Offert par le serveur !", {}, true,function(h,a,s)
                if s then
                    RageUI.CloseAll()
                    TriggerServerEvent("arro:demandeausql")
                end
            end)
        end, function()end, 1)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("arro:notifrecup")
AddEventHandler("arro:notifrecup", function(messagerecup, price)
    ShowNotification("~w~" .. messagerecup .. " ~g~$" .. price .. " ~w~!")
end)

RegisterNetEvent("arro:notifdejarecup")
AddEventHandler("arro:notifdejarecup", function(messagedejarecup)
    ShowNotification("".. messagedejarecup .."")
end)

function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end