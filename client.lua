local player = PlayerPedId()
local vehicle = GetVehiclePedIsIn(player, false)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterKeyMapping("carmenu", "Open your car menu", "keyboard", "i")

function OpenCarMenu()
    print("Menu was opened")
        lib.registerContext({
            id = 'carmenu_open',
            title = 'Car Control',
            onExit = function()
                print("menu sa zatvorilo")
            end,
            options = {
                {
                    title = 'Turn engine on/off',
                    description = 'Turn engine on/off',
                    event = 'shy_carmenu:turnengineoff'
                },
                {
                    title = 'Open doors menu',
                    description = 'Open doors menu',
                    event = "shy_carmenu:opendoorsmenu"
                },
                {
                    title = 'Windows menu',
                    description = 'Windows menu',
                    event = "shy_carmenu:openwindowsmenu"
                },

            }
        })
    lib.showContext('carmenu_open')
end

RegisterCommand("carmenu", function()
    local user = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(user,false)	
    if IsPedInAnyVehicle(user) then
        OpenCarMenu()
    else
        print("ne")
    end
end)

------------------------------------ ENGINE ------------------------------------ 
local engineoff = true
RegisterNetEvent("shy_carmenu:turnengineoff", function()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    local engineoff = GetIsVehicleEngineRunning(vehicle)
    if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= player then return end
    if GetIsVehicleEngineRunning(vehicle) then
        lib.notify({
            title = 'infotainment',
            description = 'You turn your engine off !',
            type = 'success'
        })
    else
        lib.notify({
            title = 'infotainment',
            description = 'You turn your engine on !',
            type = 'success'
        })
    end
    while (enigneoff == false) do
        SetVehicleUndriveable(vehicle,true)
        Wait(0)
    end
    SetVehicleEngineOn(vehicle, not GetIsVehicleEngineRunning(vehicle), false, true)
end)

------------------------------------ DOORS ------------------------------------ 

RegisterNetEvent('shy_carmenu:opendoorsmenu', function(data)
    lib.registerContext({
        id = 'carmenu_doors',
        title = 'Job center',
        options = {
            {
                title = 'Open doors',
                description = 'Open front left door',
                event = 'shy_carmenu:driversdoors'
            },
            {
                title = 'Open doors',
                description = 'Open front right door',
                event = 'shy_carmenu:passangersdoors'
            },
            {
                title = 'Open doors',
                description = 'Open back left door',
                event = 'shy_carmenu:backleftdoors'
            },
            {
                title = 'Open doors',
                description = 'Open back right door',
                event = 'shy_carmenu:backtrightdoors'
            },
            {
                title = 'Open hood',
                description = 'Open hood',
                event = 'shy_carmenu:hood'
            },
            {
                title = 'Open trunk',
                description = 'Open trunk',
                event = 'shy_carmenu:trunk'
            },
            {
                title = 'Open all doors',
                description = 'Open all doors',
                event = 'shy_carmenu:openall'
            },
            {
                title = 'Close all doors',
                description = 'Close all doors',
                event = 'shy_carmenu:closeall'
            },
        }
    })
    lib.showContext('carmenu_doors')
end)

local fronleftdoors = false
local frontrightdoors = false
local backleftdoors = false
local backrightdoors = false
local trunk = false
local hood = false
RegisterNetEvent("shy_carmenu:driversdoors", function()
    if not fronleftdoors then
        fronleftdoors = true
        SetVehicleDoorOpen(vehicle, 0, false)
        --print("otvoril si predné ľave dvere")
        lib.notify({
            title = 'infotainment',
            description = 'Your´s doors are open !',
            type = 'success'
        })
    elseif fronleftdoors then
        fronleftdoors = false
        SetVehicleDoorShut(vehicle, 0, false)
        --print("zatvoril si predné ľave dvere")
    end
end)

RegisterNetEvent("shy_carmenu:passangersdoors", function()
    if not frontrightdoors then
        frontrightdoors = true
        SetVehicleDoorOpen(vehicle, 1, false)
        --print("otvoril si predne pravé dvere")
        lib.notify({
            title = 'infotainment',
            description = 'Your´s doors are open !',
            type = 'success'
        })
    elseif frontrightdoors then
        frontrightdoors = false
        SetVehicleDoorShut(vehicle, 1, false)
        --print("zatvoril si predne pravé dvere")
    end
end)

RegisterNetEvent("shy_carmenu:backleftdoors", function()
    if not backleftdoors then
        backleftdoors = true
        SetVehicleDoorOpen(vehicle, 2, false)
        --print("otvoril si zadné ľave dvere")
        lib.notify({
            title = 'infotainment',
            description = 'Your´s doors are open !',
            type = 'success'
        })
    elseif backleftdoors then
        backleftdoors = false
        SetVehicleDoorShut(vehicle, 2, false)
        --print("zatvoril si zadné ľave dvere")
    end
end)

RegisterNetEvent("shy_carmenu:backtrightdoors", function()
    if not backrightdoors then
        backrightdoors = true
        SetVehicleDoorOpen(vehicle, 3, false)
        --print("otvoril si zadné pravé dvere")
        lib.notify({
            title = 'infotainment',
            description = 'Your´s doors are open !',
            type = 'success'
        })
    elseif backrightdoors then
        backrightdoors = false
        SetVehicleDoorShut(vehicle, 3, false)
        --print("zatvoril si zadné pravé dvere")
    end
end)

RegisterNetEvent("shy_carmenu:hood", function()
    if not backrightdoors then
        backrightdoors = true
        SetVehicleDoorOpen(vehicle, 4, false)
        --print("otvoril si hood")
    elseif backrightdoors then
        backrightdoors = false
        SetVehicleDoorShut(vehicle, 4, false)
        --print("zatvoril si hood")
    end
end)

RegisterNetEvent("shy_carmenu:openall", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        SetVehicleDoorOpen(vehicle, i, false)
    end
    lib.notify({
        title = 'infotainment',
        description = 'Your´s doors are open !',
        type = 'success'
    })
end)

RegisterNetEvent("shy_carmenu:closeall", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        SetVehicleDoorShut(vehicle, i, false)
    end	
end)

------------------------------------ WINDOWS ------------------------------------ 

RegisterNetEvent('shy_carmenu:openwindowsmenu', function(data)
    print(json.encode(data, {indent=true}))
    lib.registerContext({
        id = 'carmenu_windows',
        title = 'Job center',
        onExit = function()
            print("menu sa zatvorilo")
        end,
        options = {
            {
                title = 'Roll windows',
                description = 'Roll front left window',
                event = 'shy_carmenu:driverswindow'
            },
            {
                title = 'Roll windows',
                description = 'Roll front right window',
                event = 'shy_carmenu:passangerswindow'
            },
            {
                title = 'Roll windows',
                description = 'Roll back left window',
                event = 'shy_carmenu:backleftwindow'
            },
            {
                title = 'Roll windows',
                description = 'Roll back right window',
                event = 'shy_carmenu:backtightwindow'
            },
            {
                title = 'Roll windows',
                description = 'Roll-up all windows',
                event = 'shy_carmenu:openallwindows'
            },
            {
                title = 'Roll window',
                description = 'Roll-down all window',
                event = 'shy_carmenu:closeallwindows'
            },
        }
    })
    lib.showContext('carmenu_windows')
end)

local leftfrontwindows = true
local rightfrontwindows = true
local leftbackwindow = true
local rightbackwindow = true
RegisterNetEvent("shy_carmenu:driverswindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 0, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 0, false)
    end
end)

RegisterNetEvent("shy_carmenu:passangerswindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 1, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 1, false)
    end
end)

RegisterNetEvent("shy_carmenu:backleftwindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 2, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 2, false)
    end
end)

RegisterNetEvent("shy_carmenu:backtightwindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 3, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 3, false)
    end
end)

RegisterNetEvent("shy_carmenu:closeallwindows", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    RollDownWindows(vehicle)
end)

RegisterNetEvent("shy_carmenu:openallwindows", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        RollUpWindow(vehicle, i, false)
    end	
end)

------------------------------------ EXTRAS ------------------------------------ 
