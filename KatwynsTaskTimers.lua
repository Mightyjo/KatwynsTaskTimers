KatwynsTaskTimers = {
    displayName = "Katwyn's Task Timers",
    shortName = "KTT",
    name = "KatwynsTaskTimers",
    version = "0.1.0",
    logger = nil,
	variablesVersion = 1,
	Default = {
	  isDebug = false,
	  offsetX = 200,
	  offsetY = 25,
	},
	
}

function KatwynsTaskTimers:CreateMenu()

    local panelData = {
        type = "panel",
        name = self.displayName,
        displayName = self.displayName,
        author = "Mightyjo",
        version = self.version,
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LibAddonMenu2:RegisterAddonPanel(self.displayName, panelData)
    
    
    local debugOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_DEBUG)
    local optionsTable = {
        {
            type = "checkbox",
            name = debugOptionName,
            getFunc = function()
                return self.savedVariables.isDebug
            end,
            setFunc = function(value)
                self.savedVariables.isDebug = value
            end,
            width = "full",
            default = false,
        }
    }
    LibAddonMenu2:RegisterOptionControls(self.displayName, optionsTable)
end

function KatwynsTaskTimers:Info(text, ...)
    
	if self.logger then
	  self:Log(LibDebugLogger.LOG_LEVEL_INFO, text, ...)
	else
	  if ... ~= nil then
	    text = zo_strformat(text, unpack({...}))
	  end
	  d( string.format("%s: %s", self.name, text) )
	end
	
end

function KatwynsTaskTimers:Debug(text, ...)
    
	if self.logger == nil then
	  return
	end
	
	if self.savedVariables.isDebug == false then
	  return
	end
	  
	self:Log(LibDebugLogger.LOG_LEVEL_DEBUG, text, ...)
	
end

function KatwynsTaskTimers:Warn(text, ...)
    
	if self.logger == nil then
	  return
	end
	  
	self:Log(LibDebugLogger.LOG_LEVEL_WARNING, text, ...)
	
end

function KatwynsTaskTimers:Error(text, ...)
    
	if self.logger == nil then
	  return
	end
	  
	self:Log(LibDebugLogger.LOG_LEVEL_ERROR, text, ...)
	
end

function KatwynsTaskTimers:Log(level, text, ...)
    if self.logger == nil then
	  return
	end
	
	local _logger = self.logger
	
	local switch = {
	  [LibDebugLogger.LOG_LEVEL_DEBUG] = function (text) _logger:Debug(text) end,
	  [LibDebugLogger.LOG_LEVEL_INFO] = function (text) _logger:Info(text) end,
	  [LibDebugLogger.LOG_LEVEL_WARNING] = function (text) _logger:Warn(text) end,
	  [LibDebugLogger.LOG_LEVEL_ERROR] = function (text) _logger:Error(text) end,
	  default = nil,
	}
	
	local case = switch[level] or switch.default
	if case then
	  if ... ~= nil then
	    text = zo_strformat(text, unpack({...}))
	  end
	  case(text)
	end

end

function KatwynsTaskTimers:OnFrameMoveStop()

    KatwynsTaskTimers.savedVariables.offsetX = KttFrame:GetLeft()
    KatwynsTaskTimers.savedVariables.offsetY = KttFrame:GetTop()
	
end

function KatwynsTaskTimers:RestorePosition()

    local _offsetX = self.savedVariables.offsetX
    local _offsetY = self.savedVariables.offsetY
    
    KttFrame:ClearAnchors()
    KttFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, _offsetX, _offsetY)
	
end

function KatwynsTaskTimers:RedrawKttFrame()

    KttFrameLabel.text = self.displayName
	
end

function KatwynsTaskTimers:OnAddOnLoaded(event, addonName)

    if addonName ~= self.name then
        return
    end
    EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_ADD_ON_LOADED)
    
	if LibDebugLogger then
	  self.logger = LibDebugLogger(self.name)
	end

    self.savedVariables = ZO_SavedVars:NewAccountWide("KatwynsTaskTimersVariables", self.variablesVersion, nil, self.Default)
	--self.savedCharVariables  = ZO_SavedVars:NewCharacterIdSettings("KatwynsTaskTimersVariables", self.variablesVersion, nil, self.CharDefault)
	self:CreateMenu()

    LibCustomMenu:RegisterContextMenu(function(...) self:ShowContextMenu(...) end, LibCustomMenu.CATEGORY_LATE)
	
	self:RestorePosition()
	self:RedrawKttFrame()
	
	self:Info(GetString(KATWYNS_TASK_TIMERS_LOADED))

end

EVENT_MANAGER:RegisterForEvent(KatwynsTaskTimers.name, EVENT_ADD_ON_LOADED, function(...) KatwynsTaskTimers:OnAddOnLoaded(...) end)
