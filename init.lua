hs.ipc.cliInstall()
require("hs.ipc")

emacs = hs.menubar.new()

local function emacsWatcher(appName, eventType, appObject)
    if (appName == "Emacs") then
        if (eventType == hs.application.watcher.launched) then
            setWindowWatcher(_,_,_,appObject)
        end
    end
end

ewatcher = hs.application.watcher.new(emacsWatcher)
ewatcher:start()

function setWindowWatcher(element, event, watcher, emacsApp)
    local ewin = emacsApp:mainWindow()
    while ewin == nil do
        sleep(1)
        ewin = emacsApp:mainWindow()
    end
    setTitle(_,_,_,ewin)
    local watcher = ewin:newWatcher(setTitle, ewin)
    watcher:start({watcher.titleChanged})
end

function setTitle(_,_,_,window)
    local title = window:title()
    if string.find(title, "Emacs", 1) then
        emacs:setTitle("Whatcha Doin'?")
    else
        emacs:setTitle(title)
    end
end


emacsApp = hs.application.get("Emacs")
if emacsApp then
    setWindowWatcher(_,_,_,emacsApp)
else
    emacs:setTitle("Whatcha Doin'?")
end

local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
