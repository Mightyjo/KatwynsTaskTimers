KatwynsTaskTimers = {
    displayName = "Katwyn's Task Timers",
    shortName = "KTT",
    name = "KatwynsTaskTimers",
    version = "0.1.0",
	variablesVersion = 1,
	logger = nil,
	nextUpdateId = nil,
	updateFrequency = 15000,
	Default = {
	  isDebug = false,
	  isHidden = false,
	  offsetX = 200,
	  offsetY = 25,
	  alpha = 0.6,
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
	local opacityOptionName = GetString(KATWYNS_TASK_TIMERS_OPTION_OPACITY)
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
		    type = "slider",
			name = opacityOptionName,
			min = 0,
			max = 100,
			step = 1,
			clampInput = true,
			getFunc = function()
			    return 100 * self.savedVariables.alpha
			end,
			setFunc = function(value)
			    self.savedVariables.alpha = value / 100
				self:RedrawKttFrame()
			end,
			width = "full",
			default = 60,
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

function KatwynsTaskTimers:Verbose(text, ...)
    
	if self.logger == nil then
	  return
	end
	
	if self.savedVariables.isDebug == false then
	  return
	end
	  
	self:Log(LibDebugLogger.LOG_LEVEL_VERBOSE, text, ...)
	
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
    return KatwynsTaskTimers:_OnFrameMoveStop()
end

function KatwynsTaskTimers:_OnFrameMoveStop()

    self.savedVariables.offsetX = KttFrame:GetLeft()
    self.savedVariables.offsetY = KttFrame:GetTop()
	
end

function KatwynsTaskTimers.OnCloseButtonClicked()
    return KatwynsTaskTimers:_OnCloseButtonClicked()
end

function KatwynsTaskTimers:_OnCloseButtonClicked()

    self.savedVariables.isHidden = true
    self:RedrawKttFrame()
	
end

function KatwynsTaskTimers:RestorePosition()

    local _offsetX = self.savedVariables.offsetX
    local _offsetY = self.savedVariables.offsetY
    
    KttFrame:ClearAnchors()
    KttFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, _offsetX, _offsetY)
	
end

function KatwynsTaskTimers.InitializeTimer(control, data)
    return KatwynsTaskTimers:_InitializeTimer(control, data)
end

function KatwynsTaskTimers:_InitializeTimer(control, data)

    self:Verbose("_InitializeTimer(self): Entered")

	control:SetFont("ZoFontWinT2")
	if data.text then
      control:SetText(string.format("%s: %s", data.key, data.text))
	else
	  control:SetText(string.format("%s: ", data.key))
	end
	if data.color then
	  ZO_SelectableLabel_SetNormalColor(control, data.color)
	end
    
end

function KatwynsTaskTimers._RedrawKttFrame(id)
    return KatwynsTaskTimers:RedrawKttFrame()
end

function KatwynsTaskTimers:RedrawKttFrame()
    
	self:Verbose("RedrawKttFrame: Entered")
    -- Should we show the timers at all?
	KttFrame:SetHidden( self.savedVariables.isHidden )
	if self.savedVariables.isHidden then
	  return
	end
	
	KttFrame:SetAlpha( self.savedVariables.alpha )
	
	-- Are we hiding the title?
	KttFrameLabel:SetHidden( self.savedVariables.isTitleHidden )
	KttFrameLabel.text = GetString(KATWYNS_TASK_TIMERS_FRAME_TITLE)
	
	-- Redraw the timer list
	local TIMER_TYPE = 1
	local scrollList = KttFrame:GetNamedChild("TimerList")
	
	if scrollList then self.logger:Verbose("RedrawKttFrame: scrollList found") end
	
	ZO_ScrollList_Clear(scrollList)
	
	self:Verbose("RedrawKttFrame: Before List Entry Creation")
	
	local scrollData = ZO_ScrollList_GetDataList(scrollList)
	local timerData = {}
	
	if not self.savedVariables.isWritsHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, self:GetWritsData())
	end
	
	if not self.savedVariables.isStablesHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, self:GetStablesData())
	end
	
	if not self.savedVariables.isFenceHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, self:GetFenceData())
	end
	
	if not self.savedVariables.isScryHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, self:GetScryData())
	end
	
	if not self.savedVariables.isResearchHidden then
	  timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, self:GetResearchData())
	end
	
	if #(self.savedVariables.customTimers) > 0 then
	  self:Debug("RedrawKttFrame: Custom entries aren't implemented yet. How did you get here?")
	  --timerData[#timerData + 1] =  ZO_ScrollList_CreateDataEntry(TIMER_TYPE, {key = "Custom"})
	end
	
	for i=1, #timerData do
	  table.insert(scrollData, timerData[i])
	end
		
	self:Verbose("RedrawKttFrame: Before List Commit")
	
	ZO_ScrollList_Commit(scrollList)
	
	self.nextUpdateId = zo_callLater(self._RedrawKttFrame, self.updateFrequency)
	
	self:Verbose("RedrawKttFrame: Leaving")
end

function KatwynsTaskTimers:GetDailyReset()

    local now = os.time()
	local tz = os.difftime(now, os.time(os.date("!*t",now)))
	
	local resetTimestamp = os.date("!*t", now)
	if resetTimestamp.hour >= 7 then
	    resetTimestamp.day = resetTimestamp.day + 1
	end
	resetTimestamp.hour = 7
	resetTimestamp.min = 0
	resetTimestamp.sec = 0
	
	local nowTimestamp = os.date("*t", now)
	nowTimestamp.isdst = false
	
	return nowTimestamp, resetTimestamp, tz
	
end

function KatwynsTaskTimers:GetWritsData()

	self:Verbose("GetWritsData: Entered")
	
	local nowTimestamp, resetTimestamp, timezone = self:GetDailyReset()
	
	local resetTime = (os.time(resetTimestamp) + timezone) - (os.time(nowTimestamp))
	local resetTimeString = FormatTimeSeconds(resetTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS, TIME_FORMAT_DIRECTION_DESCENDING)
	
    local timerDatum = {}
	timerDatum.key = "Writs"
	timerDatum.text = resetTimeString
	timerDatum.color = self.Colors.normal
	
	self:Debug("GetWritsData: Returning {key:<<1>>, text:'<<2>>', color:<<3>>", timerDatum.key, timerDatum.text, timerDatum.color:ToHex())
	
	return timerDatum

end

function KatwynsTaskTimers:GetStablesData()

	self:Verbose("GetStablesData: Entered")
	
    local trainTime = (GetTimeUntilCanBeTrained()/ZO_ONE_SECOND_IN_MILLISECONDS)
	
	self:Verbose("GetStablesData: GetTimeUntilCanBeTrained = <<1>>", trainTime)
	
	local durationString, nextUpdate = FormatTimeSeconds(trainTime , TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS, TIME_FORMAT_DIRECTION_DESCENDING)
	
	self:Verbose("GetStablesData: durationString: '<<1>>', nextUpdate: <<2>>", durationString, nextUpdate)
	
    local timerDatum = {}
	timerDatum.key = "Stable"
	timerDatum.text = durationString
	timerDatum.color = self.Colors.red
	if trainTime > 0 then
	  timerDatum.color = self.Colors.green
	end
	
	self:Debug("GetStablesData: Returning {key:<<1>>, text:'<<2>>', color:<<3>>", timerDatum.key, timerDatum.text, timerDatum.color:ToHex())
	
	return timerDatum

end

function KatwynsTaskTimers:GetFenceData()

	self:Verbose("GetFenceData: Entered")
	
	local totalLaunders, laundersUsed, launderResetTimeSeconds = GetFenceLaunderTransactionInfo()
	local totalSells, sellsUsed, sellResetTimeSeconds = GetFenceSellTransactionInfo()
	
	local resetTimeString = FormatTimeSeconds(launderResetTimeSeconds, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS, TIME_FORMAT_DIRECTION_DESCENDING)
	
    local timerDatum = {}
	timerDatum.key = "Fence"
	timerDatum.text = zo_strformat("<<1>>/<<2>>; Launder: <<3>>/<<4>>: <<5>>", sellsUsed, totalSells, laundersUsed, totalLaunders, resetTimeString)
	timerDatum.color = self.Colors.normal
	
	self:Debug("GetFenceData: Returning {key:<<1>>, text:'<<2>>', color:<<3>>", timerDatum.key, timerDatum.text, timerDatum.color:ToHex())
	
	return timerDatum

end

function KatwynsTaskTimers:GetScryData()

	self:Verbose("GetScryData: Entered")
	
    local timerDatum = {}
	timerDatum.key = "Scry"
	timerDatum.text = ""
	timerDatum.color = self.Colors.normal
	
	self:Debug("GetScryData: Returning {key:<<1>>, text:'<<2>>', color:<<3>>", timerDatum.key, timerDatum.text, timerDatum.color:ToHex())
	
	return timerDatum

end

function KatwynsTaskTimers:GetResearchData()

	self:Verbose("GetResearchData: Entered")
		
    local timerDatum = {}
	timerDatum.key = "Research"
	timerDatum.text = ""
	timerDatum.color = self.Colors.normal
	
	self:Debug("GetResearchData: Returning {key:<<1>>, text:'<<2>>', color:<<3>>", timerDatum.key, timerDatum.text, timerDatum.color:ToHex())
	
	return timerDatum

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
	
	self.Colors = {}
	self.Colors.red = ZO_ColorDef:New(0.8, 0, 0, 1)
	self.Colors.green = ZO_ColorDef:New(0, 0.8, 0, 1)
	self.Colors.normal = ZO_NORMAL_TEXT
	
	-- Build the timer list
	local scrollList = WINDOW_MANAGER:CreateControlFromVirtual("KttFrameTimerList", KttFrame, "ZO_ScrollList")
	local width, height = KttFrame:GetDimensions()
	scrollList:SetDimensions(width-10, height-10)
	scrollList:SetAnchor(LEFT, KttFrame, LEFT, 5, 5)
	ZO_ScrollList_AddDataType(scrollList, KatwynsTaskTimers.TIMER_TYPE, "KttTimerTemplate", 20, KatwynsTaskTimers.InitializeTimer)
	
	self:RestorePosition()
	self:RedrawKttFrame()
	
	SLASH_COMMANDS["/ktt"] = function () 
      self.savedVariables.isHidden = not self.savedVariables.isHidden
	  self:RedrawKttFrame()
    end
	
	self:Info(GetString(KATWYNS_TASK_TIMERS_LOADED))

end

EVENT_MANAGER:RegisterForEvent(KatwynsTaskTimers.name, EVENT_ADD_ON_LOADED, function(...) KatwynsTaskTimers:OnAddOnLoaded(...) end)
