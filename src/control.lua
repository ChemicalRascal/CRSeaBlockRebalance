--script.on_load(handleInit)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function PersistentAutosavesTickHandler ()
    if not settings.global["PersistentAutosaves-Active"].value then
        return
    end
    global.PersistentAutosavesTicker = (global.PersistentAutosavesTicker or 0) - 1
    if global.PersistentAutosavesTicker <= 0 then
        makePersistentAutosave()
        resetPersistentAutosaveTicker()
    end
end

function PersistentAutosavesHandleSettingsChange (event)
    local refreshSettingsTrigger = {"PersistentAutosaves-Active", "PersistentAutosaves-TicksPerAutosave"}
    if has_value(refreshSettingsTrigger, event.setting)  then
        resetPersistentAutosaveTicker()
    end
end

function resetPersistentAutosaveTicker ()
    if not settings.global["PersistentAutosaves-Active"].value then
        return
    end
    global.PersistentAutosavesTicker = settings.global["PersistentAutosaves-TicksPerAutosave"].value
end

function makePersistentAutosave ()
    local suffixString = ""
    if not settings.global["PersistentAutosaves-Active"].value then
        return
    end

    suffixString = suffixString .. "PA"
    suffixString = suffixString .. "_" .. settings.global["PersistentAutosaves-UserSetID"].value
    suffixString = suffixString .. "_" .. tostring((global.PersistentAutosavesCounter or 0))
    if game.is_multiplayer() then
        game.server_save(suffixString)
    else
        game.auto_save(suffixString)
    end
    global.PersistentAutosavesCounter = (global.PersistentAutosavesCounter or 0) + 1
end

--script.on_init(resetPersistentAutosaveTicker)
script.on_event({defines.events.on_runtime_mod_setting_changed}, PersistentAutosavesHandleSettingsChange)
script.on_event(defines.events.on_tick, PersistentAutosavesTickHandler)