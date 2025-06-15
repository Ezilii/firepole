-- client.lua (using fire_pole_config from unified fxmanifest)

local usingPole = false
local nearestPole = nil
local originalViewMode = nil
local hasPlayedLandingSound = false
local lastAnimReplay = 0

-- Register interaction zones for each pole start point
CreateThread(function()
    for name, poleEntry in pairs(fire_pole_config.PoleLocations) do
        for i, data in ipairs(poleEntry["Start Locations"]) do
            local coord = data.coords
            local boxSize = data.boxSize or vec3(1.2, 1.2, 1.5)
            local offset = data.boxOffset or vec3(0, 0, 0.0)

            exports.ox_target:addBoxZone({
                coords = coord + offset,
                size = boxSize,
                rotation = poleEntry.Heading or 0.0,
                debug = fire_pole_config.Debug,
                options = {
                    {
                        name = "firepole_" .. name .. "_" .. i,
                        label = "Slide down the pole",
                        icon = "fas fa-fire-extinguisher",
                        onSelect = function()
                            if fire_pole_config.Debug then print("[FirePole] onSelect triggered") end

                            RequestAnimDict("missrappel")
                            while not HasAnimDictLoaded("missrappel") do
                                Wait(0)
                            end

                            local ped = PlayerPedId()
                            originalViewMode = GetFollowPedCamViewMode()
                            SetFollowPedCamViewMode(4) -- First person
                            SetEntityCoords(ped, coord.x, coord.y, coord.z, true, true, true, false)
                            SetEntityHeading(ped, poleEntry.Heading)
                            FreezeEntityPosition(ped, true)
                            TaskPlayAnim(ped, "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
                            nearestPole = poleEntry
                            hasPlayedLandingSound = false
                            lastAnimReplay = GetGameTimer()
                            if fire_pole_config.UseNativeSound then
                                if fire_pole_config.Debug then print("[FirePole] Playing native parachute sound") end -- Debug print
                                PlaySoundFrontend(-1, "Jump", "DLC_Pilot_Chase_Parachute_Sounds", true) -- Slide sound is here if you want to change it.
                            end
                            Wait(200)
                            PoleSlide()
                        end,
                        distance = fire_pole_config.DistanceToPole or 1.5
                    }
                }
            })
        end
    end
end)

-- Slide down the pole
function PoleSlide()
    CreateThread(function()
        usingPole = true
        local ped = PlayerPedId()
        local slideStartTime = GetGameTimer()
        local maxSlideDuration = fire_pole_config.SlideTimeout or 6000 -- default 6 seconds

        while usingPole do
            if not IsEntityPlayingAnim(ped, "missrappel", "rope_idle", 3) and GetGameTimer() - lastAnimReplay > 1500 then
                TaskPlayAnim(ped, "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
                lastAnimReplay = GetGameTimer()
            end

            local pCoords = GetEntityCoords(ped)
            local endZ = nearestPole["End Z Coordinate"]

            -- Always unfreeze to avoid locking state
            FreezeEntityPosition(ped, false)

            if not hasPlayedLandingSound and (pCoords.z - endZ) < 0.6 then -- adjusted trigger height
                hasPlayedLandingSound = true
                if fire_pole_config.Debug then print("[FirePole] Landing sound triggered") end
                PlaySoundFrontend(-1, "Barge_Door_Metal", "DLC_Security_Door_Barge_Sounds", true)
                if fire_pole_config.LandingShake then
                    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.15)
                end
            end

            if (pCoords.z - endZ) < 0.3 or (GetGameTimer() - slideStartTime) > maxSlideDuration then
                if fire_pole_config.Debug then print("[FirePole] Slide finished, forcing landing sound if not yet played") end
                if not hasPlayedLandingSound then
                    PlaySoundFrontend(-1, "Barge_Door_Metal", "DLC_Security_Door_Barge_Sounds", true) -- Landing sound is here if you want to change it.
                    hasPlayedLandingSound = true
                end

                ClearPedTasksImmediately(ped)
                usingPole = false
                nearestPole = nil
                SetEntityCollision(ped, true, true)
                if originalViewMode then
                    SetFollowPedCamViewMode(originalViewMode)
                    originalViewMode = nil
                end
            else
                SetEntityCollision(ped, not hasPlayedLandingSound, true)
                if not hasPlayedLandingSound then
                    SetEntityCoordsNoOffset(ped, pCoords.x, pCoords.y, pCoords.z - fire_pole_config.PoleSpeed, true, true, true)
                end
            end

            Wait(1)
        end
    end)
end
