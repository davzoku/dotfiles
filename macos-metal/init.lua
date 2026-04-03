-- https://github.com/mix1009/macos_productivity_tips_for_developers/blob/master/init.lua

local hyper = {"cmd", "alt", "ctrl"}
local hypershift = {"cmd", "alt", "ctrl", "shift"}

hs.loadSpoon('ReloadConfiguration'):start()

-- hs.hotkey.bind(hyper, "w", function()
--    hs.alert.show("Hello World!")
-- end)

function h_bind(key, func)
    hs.hotkey.bind(hyper, key, func)
end

function hs_bind(key, func)
    hs.hotkey.bind(hypershift, key, func)
end


h_bind("r", hs.reload)
hs_bind("r", hs.toggleConsole)


hs.alert.show("Hammerspoon started")

function file_exists(path)
    local f=io.open(path,"r")
    if f~=nil then io.close(f) return true else return false end
    -- ~= is != in other languages
end

-- Working Function to launch, focus, or rotate through application windows
-- https://rakhesh.com/coding/using-hammerspoon-to-switch-apps/
-- local function launchOrFocusOrRotate(appName, appPath)
--     -- hs.alert.show(appName)
--     -- get current focus window app
--     local focusedWindow = hs.window.focusedWindow()
--     local focusedWindowApp = focusedWindow:application()
--     local focusedWindowAppName = focusedWindowApp:name()
--     local focusedWindowPath = focusedWindowApp:path()
--     -- hs.alert.show(focusedWindowAppName)

--     -- hs.alert.show(focusedWindowPath)

--     local appNameOnDisk = string.gsub(focusedWindowPath,"/Applications/", "")
--     local appNameOnDisk = string.gsub(appNameOnDisk,".app", "")
--     -- Finder has this as its path
--     local appNameOnDisk = string.gsub(appNameOnDisk,"/System/Library/CoreServices/","")

--     -- hs.alert.show(appNameOnDisk)
--     -- If already focused, try to find the next window
--     if appName == appNameOnDisk then
--       -- hs.application.get needs the name as per hs.application:name() and not the name on disk
--       -- It can also take pid or bundle, but that doesn't help here
--       -- Since I have the name already from above, I can use that though
--       local appWindows = hs.application.get(focusedWindowAppName):allWindows()
--     --   hs.alert.show(appWindows)
--       -- https://www.hammerspoon.org/docs/hs.application.html#allWindows
--       -- A table of zero or more hs.window objects owned by the application. From the current space.

--       if #appWindows > 0 then
--           -- It seems that this list order changes after one window get focused,
--           -- Let's directly bring the last one to focus every time
--           -- https://www.hammerspoon.org/docs/hs.window.html#focus
--           if app == "Finder" then
--             -- If the app is Finder the window count returned is one more than the actual count, so I subtract
--             appWindows[#appWindows-1]:focus()
--           else
--             appWindows[#appWindows]:focus()
--           end
--       else
--           -- this should not happen, but just in case
--           hs.application.launchOrFocus(app)
--       end
--     else -- if not focused
--       hs.application.launchOrFocus(appPath)
--     end
--   end

function showSingleAlert(message, duration)
    -- Close all existing alerts
    hs.alert.closeAll(0.0)  -- 0.0 specifies immediate closure without fade out
    -- Show the new alert
    hs.alert.show(message, duration or 2)  -- Default duration is 2 seconds if not specified
end


local function rotateCurrentAppWindow()
    local focusedWindow = hs.window.focusedWindow()
    local focusedWindowApp = focusedWindow:application()
    local focusedWindowAppName = focusedWindowApp:name()
    local focusedWindowPath = focusedWindowApp:path()
    local appWindows = hs.application.get(focusedWindowAppName):allWindows()
    -- for _, window in ipairs(appWindows) do
    --     local windowTitle = window:title()
    --     hs.alert.show(#appWindows)
    --     hs.alert.show(windowTitle)
    -- end
    -- Initialize a table to hold window titles
    local windowCount = #appWindows

    local windowTitles = {}

    table.insert(windowTitles, 1, string.format("%d window", windowCount))
    -- Iterate over each window and append its title to the table
    for i = windowCount, 1, -1 do
        table.insert(windowTitles, appWindows[i]:title())
    end


    -- Concatenate all titles into a single string with newlines
    local alertMessage = table.concat(windowTitles, "\n")

    -- Display the concatenated string in an alert
    -- hs.alert.show(alertMessage)
    showSingleAlert(alertMessage)

    if #appWindows > 0 then
        -- It seems that this list order changes after one window get focused,
        -- Let's directly bring the last one to focus every time
        -- https://www.hammerspoon.org/docs/hs.window.html#focus
        if app == "Finder" then
          -- If the app is Finder the window count returned is one more than the actual count, so I subtract
          appWindows[#appWindows-1]:focus()
        else
          appWindows[#appWindows]:focus()
        end
    end
end
-- Example usage: Bind the function to a hotkey
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, "C", function()
--     launchOrFocusOrRotate("Google Chrome")
-- end)

function launchOrCycleApp(name)
    -- .. is concat string operator
    return function()
        -- Check if the app is already focused
        local focusedWindow = hs.window.focusedWindow()
        local targetApp = hs.application.get(name)

        if focusedWindow and targetApp and focusedWindow:application():name() == targetApp:name() then
            -- App is already focused, cycle through its windows
            local appWindows = targetApp:allWindows()

            if #appWindows > 1 then
                -- Show window titles
                -- local windowCount = #appWindows
                -- local windowTitles = {}
                -- table.insert(windowTitles, 1, string.format("%d windows", windowCount))
                -- for i = windowCount, 1, -1 do
                --     table.insert(windowTitles, appWindows[i]:title())
                -- end
                -- local alertMessage = table.concat(windowTitles, "\n")
                -- showSingleAlert(alertMessage, 1.5)

                -- Focus the last window (cycles through)
                if name == "Finder" then
                    appWindows[#appWindows-1]:focus()
                else
                    appWindows[#appWindows]:focus()
                end
            end
            return
        end

        -- App is not focused, launch or focus it
        path = "/Applications/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
        -- finder
        path = "/System/Library/CoreServices/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
        path = "/System/Applications/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
        path = "/Applications/".. name .. "/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end

        -- change default chrome apps name
        path = os.getenv("HOME") .. "/Applications/Chrome Apps.localized/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
    end
end

-- Legacy function name for backwards compatibility
function launchApp(name)
    return launchOrCycleApp(name)
end

function toggleFullScreen()
    local win = hs.window.focusedWindow()
    if win then
        win:toggleFullScreen()
    else
        hs.alert.show("No focused window")
    end
end

h_bind("f", toggleFullScreen)

hs_bind("1", launchApp("ChatGPT"))
hs_bind("2", launchApp("Claude"))

hs_bind("8", launchApp("Cursor"))

hs_bind("a", launchApp("Android Studio"))
hs_bind("b", launchApp("Google Chrome"))
-- chrome app
hs_bind("c", launchApp("Google Calendar"))
hs_bind("d", launchApp("Docker"))
hs_bind("e", launchApp("Finder"))
-- hs_bind("f", launchApp("Tasksboard"))
-- chrome app
hs_bind("g", launchApp("Gmail"))
hs_bind("i", launchApp("iTerm"))
hs_bind("m", launchApp("TextMate"))
hs_bind("n", launchApp("Notion"))
hs_bind("o", launchApp("Microsoft OneNote"))
hs_bind("p", launchApp("Postman"))
hs_bind("r", launchApp("RStudio"))
-- chrome app
hs_bind("s", launchApp("Slack"))
-- hs_bind("s", launchApp("Spotify"))
hs_bind("t", launchApp("Telegram"))
hs_bind("u", launchApp("YouTube Music"))
hs_bind("v", launchApp("Visual Studio Code"))
hs_bind("w", launchApp("Bitwarden"))
hs_bind("x", launchApp("Xcode"))
hs_bind("y", launchApp("Zotero"))
hs_bind("z", launchApp("Obsidian"))

-- hs_bind("q", launchApp("App Store"))
hs_bind("q", launchApp("MySQLWorkbench"))
hs_bind("l", launchApp("Launchpad"))


h_bind("`", rotateCurrentAppWindow)


-- window functions

-- function positionWindow(x, y, w, h)
--     return function()
--         local win = hs.window.focusedWindow()
--         if win == nil then return end
--         local f = win:frame()
--         local s = win:screen():frame()
--         f.x = s.x + s.w * x
--         f.y = s.y + s.h * y
--         f.w = s.w * w
--         f.h = s.h * h
--         -- hs.alert.show(s)
--         win:setFrame(f)
--     end
-- end

-- hs.window.animationDuration = 0

-- h_bind("1", positionWindow(0, 0, 1/2, 1))
-- h_bind("2", positionWindow(1/2, 0, 1/2, 1))

-- h_bind("3", positionWindow(0, 0, 1/2, 1/2))
-- h_bind("4", positionWindow(1/2, 0, 1/2, 1/2))
-- h_bind("5", positionWindow(0, 1/2, 1/2, 1/2))
-- h_bind("6", positionWindow(1/2, 1/2, 1/2, 1/2))

-- h_bind("q", positionWindow(0, 0, 2/3, 1))
-- h_bind("w", positionWindow(2/3, 0, 1/3, 1))

-- -- grid based window functions

-- hs.grid.setGrid('12x6')
-- hs.grid.setMargins('0x0')

-- h_bind("right", function()
--     local win = hs.window.focusedWindow()
--     if win == nil then return end
--     local screen = win:screen()
--     local sg = hs.grid.getGrid(screen)
--     local g = hs.grid.get(win)
--     if g.x + g.w == sg.w then
--         g.x = g.x + 1
--         g.w = g.w - 1
--         hs.grid.set(win, g)
--     else
--         g.w = g.w + 1
--         hs.grid.set(win, g)
--     end
-- end)

-- h_bind("left", function()
--     local win = hs.window.focusedWindow()
--     if win == nil then return end
--     local screen = win:screen()
--     local sg = hs.grid.getGrid(screen)
--     local g = hs.grid.get(win)
--     if g.x + g.w >= sg.w and g.x ~= 0 then
--         g.x = g.x - 1
--         g.w = g.w + 1
--         hs.grid.set(win, g)
--     else
--         g.w = g.w - 1
--         hs.grid.set(win, g)
--     end
-- end)

-- h_bind("down", function()
--     local win = hs.window.focusedWindow()
--     if win == nil then return end
--     local screen = win:screen()
--     local sg = hs.grid.getGrid(screen)
--     local g = hs.grid.get(win)
--     if g.y + g.h == sg.h then
--         g.y = g.y + 1
--         g.h = g.h - 1
--         hs.grid.set(win, g)
--     else
--         g.h = g.h + 1
--         hs.grid.set(win, g)
--     end
-- end)

-- h_bind("up", function()
--     local win = hs.window.focusedWindow()
--     if win == nil then return end
--     local screen = win:screen()
--     local sg = hs.grid.getGrid(screen)
--     local g = hs.grid.get(win)
--     if g.y + g.h >= sg.h and g.y ~= 0 then
--         g.y = g.y - 1
--         g.h = g.h + 1
--         hs.grid.set(win, g)
--     else
--         g.h = g.h - 1
--         hs.grid.set(win, g)
--     end
-- end)


-- hs_bind("right", hs.grid.pushWindowRight)
-- hs_bind("left", hs.grid.pushWindowLeft)
-- hs_bind("down", hs.grid.pushWindowDown)
-- hs_bind("up", hs.grid.pushWindowUp)


-- -- Spoon
-- -- install from https://www.hammerspoon.org/Spoons/

-- clipboardTool = hs.loadSpoon("ClipboardTool")
-- clipboardTool.paste_on_select = true
-- clipboardTool.show_in_menubar = false
-- clipboardTool:start()
-- h_bind("v", function() clipboardTool:toggleClipboard() end)
-- -- hs_bind("v", function() clipboardTool:clearAll() end)

-- mouseCircle = hs.loadSpoon("MouseCircle")
-- -- mouseCircle:show()
-- mouseCircle.color = hs.drawing.color.hammerspoon.white
-- mouseCircle:bindHotkeys({show={hyper, 'm'}})


-- -- vi like cursor movements
-- keyDelay = 100
-- h_bind("h", function() hs.eventtap.keyStroke({}, "left", keyDelay) end, true)
-- h_bind("j", function() hs.eventtap.keyStroke({}, "down", keyDelay) end, true)
-- h_bind("k", function() hs.eventtap.keyStroke({}, "up", keyDelay) end, true)
-- h_bind("l", function() hs.eventtap.keyStroke({}, "right", keyDelay) end, true)

-- h_bind("f", function() hs.eventtap.keyStroke({}, "pagedown", keyDelay) end, true)
-- h_bind("b", function() hs.eventtap.keyStroke({}, "pageup", keyDelay) end, true)
-- hs_bind("a", function() hs.eventtap.keyStroke({}, "home", keyDelay) end, true)
-- hs_bind("e", function() hs.eventtap.keyStroke({}, "end", keyDelay) end, true)