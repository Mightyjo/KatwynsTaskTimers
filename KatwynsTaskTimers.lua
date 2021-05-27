KatwynsTaskTimers = {
    displayName = "Katwyn's Task Timers",
    shortName = "KTT",
    name = "KatwynsTaskTimers",
    version = "0.1.0",
    logger = nil,
	variablesVersion = 1,
	Default = {
	  isDebug = false,
	  isHidden = false,
	  offsetX = 200,
	  offsetY = 25,
	  isTitleHidden = false,
	  isWritsHidden = false,
	  isStablesHidden = false,
	  isFenceHidden = false,
	  isScryHidden = false,
	  isResearchHidden = false,
	  customTimers = {}
	},
	TIMER_TYPE = 1,
	
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
	local hiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_HIDDEN)
	local titleHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_TITLE_HIDDEN)
	local writsHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_WRITS_HIDDEN)
	local stablesHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_STABLES_HIDDEN)
	local fenceHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_FENCE_HIDDEN)
	local scryHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_SCRY_HIDDEN)
	local researchHiddenOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_RESEARCH_HIDDEN)
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
        },
		{
            type = "checkbox",
            name = hiddenOptionName,
            getFunc = function()
                return self.savedVariables.isHidden
            end,
            setFunc = function(value)
                self.savedVariables.isHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = titleHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isTitleHidden
            end,
            setFunc = function(value)
                self.savedVariables.isTitleHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = writsHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isWritsHidden
            end,
            setFunc = function(value)
                self.savedVariables.isWritsHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = stablesHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isStablesHidden
            end,
            setFunc = function(value)
                self.savedVariables.isStablesHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = fenceHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isFenceHidden
            end,
            setFunc = function(value)
                self.savedVariables.isFenceHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = scryHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isScryHidden
            end,
            setFunc = function(value)
                self.savedVariables.isScryHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
		{
            type = "checkbox",
            name = researchHiddenOptionName,
            getFunc = function()
                return self.savedVariables.isResearchHidden
            end,
            setFunc = function(value)
                self.savedVariables.isResearchHidden = value
				self:RedrawKttFrame()
            end,
            width = "full",
            default = false,
        },
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

function KatwynsTaskTimers.OnFrameMoveStop()

    KatwynsTaskTimers.savedVariables.offsetX = KttFrame:GetLeft()
    KatwynsTaskTimers.savedVariables.offsetY = KttFrame:GetTop()
	
end

function KatwynsTaskTimers.OnCloseButtonClicked()

    KatwynsTaskTimers.savedVariables.isHidden = true
    KatwynsTaskTimers.RedrawKttFrame()
	
end

function KatwynsTaskTimers.RestorePosition()

    local _offsetX = KatwynsTaskTimers.savedVariables.offsetX
    local _offsetY = KatwynsTaskTimers.savedVariables.offsetY
    
    KttFrame:ClearAnchors()
    KttFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, _offsetX, _offsetY)
	
end

function KatwynsTaskTimers.InitializeTimer(control, data)

    local logger = LibDebugLogger("KatwynsTaskTimers")
    
	control:SetFont("ZoFontWinH4")
    control:SetText(data.key)
    
end

function KatwynsTaskTimers.RedrawKttFrame()
    local logger = LibDebugLogger("KatwynsTaskTimers")
	logger:Debug("RedrawKttFrame: Entered")
    -- Should we show the timers at all?
	KttFrame:SetHidden( KatwynsTaskTimers.savedVariables.isHidden )
	if KatwynsTaskTimers.savedVariables.isHidden then
	  return
	end
	
	-- Are we hiding the title?
	KttFrameLabel:SetHidden( KatwynsTaskTimers.savedVariables.isTitleHidden )
	KttFrameLabel.text = GetString(KATWYNS_TASK_TIMERS_FRAME_TITLE)
	
	-- Redraw the timer list
	local TIMER_TYPE = 1
	local scrollList = KttFrame:GetNamedChild("TimerList")
	
	if scrollList then logger:Debug("RedrawKttFrame: scrollList found") end
	
	ZO_ScrollList_Clear(scrollList)
	
	logger:Debug("RedrawKttFrame: Before List Entry Creation")
	
	local scrollData = ZO_ScrollList_GetDataList(scrollList)
	local timerData = {}
	
	if not KatwynsTaskTimers.savedVariables.isWritsHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Writs"})
	end
	
	if not KatwynsTaskTimers.savedVariables.isStablesHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Stable"})
	end
	
	if not KatwynsTaskTimers.savedVariables.isFenceHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Fence"})
	end
	
	if not KatwynsTaskTimers.savedVariables.isScryHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Scry"})
	end
	
	if not KatwynsTaskTimers.savedVariables.isResearchHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Research"})
	end
	
	if #(KatwynsTaskTimers.savedVariables.customTimers) > 0 then
	  logger:Debug("RedrawKttFrame: Custom entries aren't implemented yet. How did you get here?")
	  --timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Custom"})
	end
	
	for i=1, #timerData do
	  table.insert(scrollData, timerData[i])
	end
		
	logger:Debug("RedrawKttFrame: Before List Commit")
	
	ZO_ScrollList_Commit(scrollList)
	
	logger:Debug("RedrawKttFrame: Leaving")
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
	
	-- Build the timer list
	local scrollList = WINDOW_MANAGER:CreateControlFromVirtual("KttFrameTimerList", KttFrame, "ZO_ScrollList")
	local width, height = KttFrame:GetDimensions()
	scrollList:SetDimensions(width, height)
	scrollList:SetAnchor(LEFT, KttFrame, LEFT)
	ZO_ScrollList_AddDataType(scrollList, KatwynsTaskTimers.TIMER_TYPE, "ZO_SelectableLabel", 20, KatwynsTaskTimers.InitializeTimer)
	
	self:RestorePosition()
	self:RedrawKttFrame()
	
	SLASH_COMMANDS["/ktt"] = function () 
      self.savedVariables.isHidden = not self.savedVariables.isHidden
	  self:RedrawKttFrame()
    end
	
	self:Info(GetString(KATWYNS_TASK_TIMERS_LOADED))

end

EVENT_MANAGER:RegisterForEvent(KatwynsTaskTimers.name, EVENT_ADD_ON_LOADED, function(...) KatwynsTaskTimers:OnAddOnLoaded(...) end)
