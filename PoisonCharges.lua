PoisonCharges1 = CreateFrame("Frame", nil, UIParent) -- frame for main hand
PoisonCharges2 = CreateFrame("Frame", nil, UIParent) -- frame for off hand

PoisonCharges_Btn1 = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate") -- frame for main hand apply poison button
PoisonCharges_Btn2 = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate") -- frame for off hand apply poison button

PoisonCharges_Btn1_Count = CreateFrame("Frame", nil, UIParent) -- frame for main hand poison count
PoisonCharges_Btn2_Count = CreateFrame("Frame", nil, UIParent) -- frame for off hand poison count

PoisonChargesFrameShown = false

-- onLoad function
function PoisonCharges_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
end

-- onEvent function
function PoisonCharges_OnEvent(self, event, ...)
	local addonName = select (1, ...)
	if event == "ADDON_LOADED" and addonName == "PoisonCharges" then

	-- initialize variables if this is the first time this addon loaded
	if PC_State == nil then
		PC_State = 1
	end
	if PC_MH == nil then
		PC_MH = "Not selected"
	end
	if PC_OH == nil then
		PC_OH = "Not selected"
	end
	if PC_MinimapPos == nil then
		print("test")
		PC_MinimapPos = {
			["minimapPos"] = 90,
			["hide"] = false,
		}
	end
	
    local LDB = LibStub("LibDataBroker-1.1", true)
    local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
    if LDB then
        local PC_MinimapBtn = LDB:NewDataObject("PoisonCharges", {
            type = "launcher",
			text = "PoisonCharges",
            icon = "Interface\\AddOns\\PoisonCharges\\media\\PoisonCharges_Icon",
            OnClick = function(_, button)
                if button == "LeftButton" then PC_SettingsToggle() end
            end,
            OnTooltipShow = function(tt)
                tt:AddLine("PoisonCharges")
				tt:AddLine("|cffffff00Left|r-click to show PoisonCharges settings.")
				tt:AddLine("Hold |cffffff00left|r to move this button.")
            end,
        })
        if LDBIcon then
            LDBIcon:Register("PoisonCharges", PC_MinimapBtn, PC_MinimapPos)
        end
    end
	
	-- work only if player is Rogue level 20 and above
	--if UnitClass("player") == "Rogue" and UnitLevel("player") >= 20 then
		if PC_State == 0 then
			PoisonCharges1:Hide()
			PoisonCharges2:Hide()
			PoisonCharges_Btn1:Hide()
			PoisonCharges_Btn2:Hide()
		else
			local _, mht, mh, _, oht, oh = GetWeaponEnchantInfo()
			PoisonCharges1:Show()
			PoisonCharges2:Show()
			if mh == nil and CanApply("MH") then
				PoisonCharges_Btn1:Show()
			end
			if oh == nil and CanApply("OH") then
				PoisonCharges_Btn2:Show()
			end
		end
	--else
	--	PoisonCharges1:Hide()
	--	PoisonCharges2:Hide()
	--end
	
	local _, mht, mh, _, oht, oh = GetWeaponEnchantInfo()
	PoisonCharges1:SetFrameStrata("BACKGROUND")
	PoisonCharges1:SetWidth(128)
	PoisonCharges1:SetHeight(64)
	PoisonCharges1:SetPoint("CENTER", UIParent, "CENTER", -90, -20)
	PoisonMH1 = PoisonCharges1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonMH1:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonMH1:SetPoint("CENTER", PoisonCharges1, "CENTER", 0, 10)
	PoisonMH1:SetTextColor(0, 255, 0)
	PoisonMH1:SetAlpha(0.2)
	PoisonMH2 = PoisonCharges1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonMH2:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonMH2:SetPoint("CENTER", PoisonCharges1, "CENTER", 0, -5)
	PoisonMH2:SetTextColor(255, 255, 0)
	PoisonMH2:SetAlpha(0.2)
	PoisonMH3 = PoisonCharges1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonMH3:SetFont("Fonts\\MORPHEUS.TTF", 9)
	PoisonMH3:SetPoint("CENTER", PoisonCharges1, "CENTER", 0, 25)
	PoisonMH3:SetTextColor(1, 1, 1)
	PoisonMH3:SetText("Main Hand")
	PoisonMH3:SetAlpha(0.2)
	PoisonCharges1:SetScript("OnUpdate", UpdateTime)

	PoisonCharges2:SetFrameStrata("BACKGROUND")
	PoisonCharges2:SetWidth(128)
	PoisonCharges2:SetHeight(64)
	PoisonCharges2:SetPoint("CENTER", UIParent, "CENTER", 90, -20)
	PoisonOH1 = PoisonCharges2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonOH1:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonOH1:SetPoint("CENTER", PoisonCharges2, "CENTER", 0, 10)
	PoisonOH1:SetTextColor(0, 255, 0)
	PoisonOH1:SetAlpha(0.2)
	PoisonOH2 = PoisonCharges2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonOH2:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonOH2:SetPoint("CENTER", PoisonCharges2, "CENTER", 0, -5)
	PoisonOH2:SetTextColor(255, 255, 0)
	PoisonOH2:SetAlpha(0.2)
	PoisonOH3 = PoisonCharges2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonOH3:SetFont("Fonts\\MORPHEUS.TTF", 9)
	PoisonOH3:SetPoint("CENTER", PoisonCharges2, "CENTER", 0, 25)
	PoisonOH3:SetTextColor(1, 1, 1)
	PoisonOH3:SetText("Off Hand")
	PoisonOH3:SetAlpha(0.2)
	PoisonCharges2:SetScript("OnUpdate", UpdateTime)
	
	PoisonCharges_Btn1:SetFrameStrata("BACKGROUND")
	PoisonCharges_Btn1:SetWidth(32)
	PoisonCharges_Btn1:SetHeight(32)
	PoisonCharges_Btn1:SetPoint("CENTER", UIParent, "CENTER", -90, -45)
	PoisonCharges_Tex1 = PoisonCharges_Btn1:CreateTexture(nil,"BACKGROUND")
	if strfind(PC_MH, "Instant") or strfind(PC_MH, "Быстродействующий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Poisons")
	end
	if strfind(PC_MH, "Deadly") or strfind(PC_MH, "Смертельный") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Rogue_Dualweild")
	end
	if strfind(PC_MH, "Mind-numbing") or strfind(PC_MH, "Дурманящий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Spell_Nature_Nullifydisease")
	end
	if strfind(PC_MH, "Crippling") or strfind(PC_MH, "Калечащий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Inv_Potion_19")
	end
	if strfind(PC_MH, "Wound") or strfind(PC_MH, "Нейтрализующий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Poisonsting")
	end
	PoisonCharges_Tex1:SetAllPoints(PoisonCharges_Btn1)
	PoisonCharges_Btn1.texture = PoisonCharges_Tex1
	PoisonCharges_Btn1:SetAttribute("type1", "macro")
	PoisonCharges_Btn1:SetAttribute("macrotext1", "/use "..PC_MH.."\n/use 16\n/click StaticPopup1Button1")
	
	PoisonCharges_Btn2:SetFrameStrata("BACKGROUND")
	PoisonCharges_Btn2:SetWidth(32)
	PoisonCharges_Btn2:SetHeight(32)
	PoisonCharges_Btn2:SetPoint("CENTER", UIParent, "CENTER", 90, -45)
	PoisonCharges_Tex2 = PoisonCharges_Btn2:CreateTexture(nil,"BACKGROUND")
	if strfind(PC_OH, "Instant") or strfind(PC_OH, "Быстродействующий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Poisons")
	end
	if strfind(PC_OH, "Deadly") or strfind(PC_OH, "Смертельный") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Rogue_Dualweild")
	end
	if strfind(PC_OH, "Mind-numbing") or strfind(PC_OH, "Дурманящий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Spell_Nature_Nullifydisease")
	end
	if strfind(PC_OH, "Crippling") or strfind(PC_OH, "Калечащий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Inv_Potion_19")
	end
	if strfind(PC_OH, "Wound") or strfind(PC_OH, "Нейтрализующий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Poisonsting")
	end
	PoisonCharges_Tex2:SetAllPoints(PoisonCharges_Btn2)
	PoisonCharges_Btn2.texture = PoisonCharges_Tex2
	PoisonCharges_Btn2:SetAttribute("type1", "macro")
	PoisonCharges_Btn2:SetAttribute("macrotext1", "/use "..PC_OH.."\n/use 17\n/click StaticPopup1Button1")
	
	PoisonCharges_Btn1_Count:SetFrameStrata("BACKGROUND")
	PoisonCharges_Btn1_Count:SetWidth(128)
	PoisonCharges_Btn1_Count:SetHeight(64)
	PoisonCharges_Btn1_Count:SetPoint("CENTER", PoisonCharges_Btn1, "CENTER", 0, -35)
	PoisonCharges_Btn1_CountText = PoisonCharges_Btn1_Count:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonCharges_Btn1_CountText:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonCharges_Btn1_CountText:SetPoint("CENTER", PoisonCharges_Btn1_Count, "CENTER", 0, 10)
	PoisonCharges_Btn1_CountText:SetTextColor(0, 255, 0)
	PoisonCharges_Btn1_CountText:SetText(GetPoisonCount("MH"))
	PoisonCharges_Btn1_Count:Show()
	
	PoisonCharges_Btn2_Count:SetFrameStrata("BACKGROUND")
	PoisonCharges_Btn2_Count:SetWidth(128)
	PoisonCharges_Btn2_Count:SetHeight(64)
	PoisonCharges_Btn2_Count:SetPoint("CENTER", PoisonCharges_Btn2, "CENTER", 0, -35)
	PoisonCharges_Btn2_CountText = PoisonCharges_Btn2_Count:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	PoisonCharges_Btn2_CountText:SetFont("Fonts\\MORPHEUS.TTF", 15)
	PoisonCharges_Btn2_CountText:SetPoint("CENTER", PoisonCharges_Btn2_Count, "CENTER", 0, 10)
	PoisonCharges_Btn2_CountText:SetTextColor(0, 255, 0)
	PoisonCharges_Btn2_CountText:SetText(GetPoisonCount("OH"))
	PoisonCharges_Btn2_Count:Show()
	
	PoisonChargesSettingsBtn1:SetScript("OnLeave", function(self, button)
		PoisonChargesSettingsBtn1_Tool:Hide()
	end);
	CreateFrame("GameTooltip", "PoisonChargesSettingsBtn1_Tool", nil, "GameTooltipTemplate")
	PoisonChargesSettingsBtn1:SetScript("OnEnter", function()
		PoisonChargesSettingsBtn1_Tool:SetOwner(self, "ANCHOR_CURSOR");
		PoisonChargesSettingsBtn1_Tool:AddLine("Toggle addon On and Off", 1, 1, 1, 1)
		PoisonChargesSettingsBtn1_Tool:Show()
	end)
	
	PoisonChargesSettingsBtn2:SetScript("OnLeave", function(self, button)
		PoisonChargesSettingsBtn2_Tool:Hide()
	end);
	CreateFrame("GameTooltip", "PoisonChargesSettingsBtn2_Tool", nil, "GameTooltipTemplate")
	PoisonChargesSettingsBtn2:SetScript("OnEnter", function()
		PoisonChargesSettingsBtn2_Tool:SetOwner(self, "ANCHOR_CURSOR");
		PoisonChargesSettingsBtn2_Tool:AddLine("Close this window", 1, 1, 1, 1)
		PoisonChargesSettingsBtn2_Tool:Show()
	end)
	
	-- message when addon is loaded
	DEFAULT_CHAT_FRAME:AddMessage("PoisonCharges v1.2 loaded. Type '/poisonchargesinfo' or '/pci' to show help.")
	
	end
end

-- update frames
function UpdateTime()
	local _, mht, mh, _, _, oht, oh, _ = GetWeaponEnchantInfo()
	-- Main Hand
	if mh ~= nil then
		-- calculating remaining time
		local mht1 = ceil(mht / 1000 / 60)
		local mht2 = 60 - floor((mht1 * 60) - (mht / 1000))
		mht2 = mht2 - 1
		if mht2 == 60 then
			mht1 = mht1 + 1
			mht2 = 0
		end
		mht1 = mht1 - 1
		if mht1 < 0 then
			mht1 = 0
			mht2 = 0
		end
		if mht2 < 10 then 
			PoisonMH2:SetText(mht1..":0"..mht2)
		else
			PoisonMH2:SetText(mht1..":"..mht2)
		end
		PoisonMH1:SetText(mh.." charges")
		PoisonCharges_Btn1:Hide()
		PoisonCharges_Btn1_Count:Hide()
	else
		PoisonMH1:SetText("Not applied!")
		PoisonMH2:SetText()
		PoisonCharges_Btn1_Count:Show()
		if CanApply("MH") then
			PoisonCharges_Btn1:Show()
			PoisonCharges_Btn1_CountText:SetText(GetPoisonCount("MH"))
			PoisonCharges_Btn1_Count:Show()
		else
			PoisonCharges_Btn1:Hide()
			PoisonCharges_Btn1_CountText:SetText(GetPoisonCount("MH"))
			PoisonCharges_Btn1_Count:Hide()
		end
	end
	-- Off Hand
	if oh ~= nil then
		local oht1 = ceil(oht / 1000 / 60)
		local oht2 = 60 - floor((oht1 * 60) - (oht / 1000))
		oht2 = oht2 - 1
		if oht2 == 60 then
			oht1 = oht1 + 1
			oht2 = 0
		end
		oht1 = oht1 - 1
		if oht1 < 0 then
			oht1 = 0
			oht2 = 0
		end
		if oht2 < 10 then 
			PoisonOH2:SetText(oht1..":0"..oht2)
		else
			PoisonOH2:SetText(oht1..":"..oht2)
		end
		PoisonOH1:SetText(oh.." charges")
		PoisonCharges_Btn2:Hide()
		PoisonCharges_Btn2_Count:Hide()
	else
		PoisonOH1:SetText("Not applied!")
		PoisonOH2:SetText()
		PoisonCharges_Btn2_Count:Show()
		if CanApply("OH") then
			PoisonCharges_Btn2:Show()
			PoisonCharges_Btn2_CountText:SetText(GetPoisonCount("OH"))
			PoisonCharges_Btn2_Count:Show()
		else
			PoisonCharges_Btn2:Hide()
			PoisonCharges_Btn2_CountText:SetText(GetPoisonCount("OH"))
			PoisonCharges_Btn2_Count:Hide()
		end
	end
	if not (UnitAffectingCombat("player")) then -- reduce transparency while not in combat
		PoisonMH1:SetAlpha(0.2)
		PoisonMH2:SetAlpha(0.2)
		PoisonMH3:SetAlpha(0.2)
		PoisonOH1:SetAlpha(0.2)
		PoisonOH2:SetAlpha(0.2)
		PoisonOH3:SetAlpha(0.2)
		--PoisonCharges_Btn1:SetAlpha(0.2)
		--PoisonCharges_Btn2:SetAlpha(0.2)
	end
	if UnitAffectingCombat("player") then -- increase transparency while in combat
		PoisonMH1:SetAlpha(1)
		PoisonMH2:SetAlpha(1)
		PoisonMH3:SetAlpha(1)
		PoisonOH1:SetAlpha(1)
		PoisonOH2:SetAlpha(1)
		PoisonOH3:SetAlpha(1)
		--PoisonCharges_Btn1:SetAlpha(1)
		--PoisonCharges_Btn2:SetAlpha(1)
	end
end

function PC_Toggle()
	if PC_State == 1 then
		PC_State = 0
		PoisonCharges1:Hide()
		PoisonCharges2:Hide()
		PoisonCharges_Btn1:Hide()
		PoisonCharges_Btn2:Hide()
		PoisonCharges_Btn1_Count:Hide()
		PoisonCharges_Btn2_Count:Hide()
	else
		local _, mht, mh, _, oht, oh = GetWeaponEnchantInfo()
		PC_State = 1
		PoisonCharges1:Show()
		PoisonCharges2:Show()
		if mh == nil and CanApply("MH") then
			PoisonCharges_Btn1:Show()
			PoisonCharges_Btn1_Count:Show()
		else
			PoisonCharges_Btn1:Hide()
			PoisonCharges_Btn1_Count:Hide()
		end
		if oh == nil and CanApply("OH") then
			PoisonCharges_Btn2:Show()
			PoisonCharges_Btn2_Count:Show()
		else
			PoisonCharges_Btn2:Hide()
			PoisonCharges_Btn2_Count:Hide()
		end
	end
end

function PC_SettingsToggle()
	if PoisonChargesFrameShown then 
		PoisonChargesSettingsFrame:Hide()
		PoisonChargesFrameShown = false
	else
		PoisonChargesSettingsFrame:Show()
		PoisonChargesFrameShown = true
	end
end

-- check if can apply poison
function CanApply(hand)
	local isMounted = false;
	local poisonExists = false;
	
	-- if not on taxi
    if (not UnitOnTaxi("player")) then
		if (IsMounted()) then
			isMounted = true;
		end
	end
	
	if hand == "MH" then
		for i = 0, 4 do
			for j = 1, 18 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					itemName, _ = GetItemInfo(h(i, j))
					if itemName == PC_MH then
						poisonExists = true
					end
				end
			end
		end
	else
		for i = 0, 4 do
			for j = 1, 18 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					itemName, _ = GetItemInfo(h(i, j))
					if itemName == PC_OH then
						poisonExists = true
					end
				end
			end
		end
	end
	
	if not (isMounted) and poisonExists then
		return true
	else
		return false
	end
end

function GetPoisonCount(hand)
	local MHCount = 0
	local OHCount = 0
	
	if hand == "MH" then
		for i = 0, 4 do
			for j = 1, 18 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					itemName, _ = GetItemInfo(h(i, j))
					if itemName == PC_MH then
						local _, count = GetContainerItemInfo(i,j)
						poisonExists = true
						MHCount = MHCount + count
					end
				end
			end
		end
		return MHCount
	else
		for i = 0, 4 do
			for j = 1, 18 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					itemName, _ = GetItemInfo(h(i, j))
					if itemName == PC_OH then
						local _, count = GetContainerItemInfo(i,j)
						poisonExists = true
						OHCount = OHCount + count
					end
				end
			end
		end
		return OHCount
	end
end

function PCDropDownMH_Initialize()
	local poisonsList = {}
	poisonsList[1] = "Instant Poison"
	poisonsList[2] = "Deadly Poison"
	poisonsList[3] = "Crippling Poison"
	poisonsList[4] = "Mind-numbing Poison"
	poisonsList[5] = "Wound Poison"
	poisonsList[6] = "Быстродействующий яд"
	poisonsList[7] = "Смертельный яд"
	poisonsList[8] = "Калечащий яд"
	poisonsList[9] = "Дурманящий яд"
	poisonsList[10] = "Нейтрализующий яд"
	local info
	info = {
				text = "Not selected";
				value = "Not selected";
				func = PCDropDownMH_OnClick;
			}
		UIDropDownMenu_AddButton(info)
	local poisonsInInventory = {}
	local hash = {}
	local uniquePoisons = {}
	
	for i = 0, 4 do
		for j = 1, 18 do
			for k = 1, 10 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					if strfind(h(i, j), poisonsList[k]) then
						itemName, _ = GetItemInfo(h(i, j))
						table.insert(poisonsInInventory, itemName)
						break
					end
				end
			end
		end
	end
	
	for _,v in ipairs(poisonsInInventory) do
		if (not hash[v]) then
			uniquePoisons[table.getn(uniquePoisons)+1] = v
			hash[v] = true
		end
	end
	
	for i = 1, table.getn(uniquePoisons) do
		info = {
			text = uniquePoisons[i];
			value = uniquePoisons[i];
			func = PCDropDownMH_OnClick;
			}
		UIDropDownMenu_AddButton(info)
	end
end

function PCDropDownMH_OnShow()
	UIDropDownMenu_Initialize(PCDropDownMH, PCDropDownMH_Initialize)
	UIDropDownMenu_SetSelectedValue(PCDropDownMH, PC_MH)
	UIDropDownMenu_SetWidth(PCDropDownMH, 190)
end

function PCDropDownMH_OnClick(self, arg1, arg2, checked)
	PC_MH = self:GetText()
	UIDropDownMenu_SetSelectedValue(PCDropDownMH, PC_MH)
	PCDropDownMH_OnShow()
	local PoisonCharges_Tex1 = PoisonCharges_Btn1:CreateTexture(nil,"BACKGROUND")
	if strfind(PC_MH, "Instant") or strfind(PC_MH, "Быстродействующий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Poisons")
	end
	if strfind(PC_MH, "Deadly") or strfind(PC_MH, "Смертельный") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Rogue_Dualweild")
	end
	if strfind(PC_MH, "Mind-numbing") or strfind(PC_MH, "Дурманящий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Spell_Nature_Nullifydisease")
	end
	if strfind(PC_MH, "Crippling") or strfind(PC_MH, "Калечащий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Inv_Potion_19")
	end
	if strfind(PC_MH, "Wound") or strfind(PC_MH, "Нейтрализующий") then
		PoisonCharges_Tex1:SetTexture("Interface\\Icons\\Ability_Poisonsting")
	end
	PoisonCharges_Tex1:SetAllPoints(PoisonCharges_Btn1)
	PoisonCharges_Btn1.texture = PoisonCharges_Tex1
end

function PCDropDownOH_Initialize()
	local poisonsList = {}
	poisonsList[1] = "Instant Poison"
	poisonsList[2] = "Deadly Poison"
	poisonsList[3] = "Crippling Poison"
	poisonsList[4] = "Mind-numbing Poison"
	poisonsList[5] = "Wound Poison"
	poisonsList[6] = "Быстродействующий яд"
	poisonsList[7] = "Смертельный яд"
	poisonsList[8] = "Калечащий яд"
	poisonsList[9] = "Дурманящий яд"
	poisonsList[10] = "Нейтрализующий яд"
	local info
	info = {
				text = "Not selected";
				value = "Not selected";
				func = PCDropDownOH_OnClick;
			}
		UIDropDownMenu_AddButton(info)
	local poisonsInInventory = {}
	local hash = {}
	local uniquePoisons = {}
	
	for i = 0, 4 do
		for j = 1, 18 do
			for k = 1, 10 do
				local h=GetContainerItemLink
				if not(h(i, j) == nil) then
					if strfind(h(i, j), poisonsList[k]) then
						itemName, _ = GetItemInfo(h(i, j))
						table.insert(poisonsInInventory, itemName)
						break
					end
				end
			end
		end
	end
	
	for _,v in ipairs(poisonsInInventory) do
		if (not hash[v]) then
			uniquePoisons[table.getn(uniquePoisons)+1] = v
			hash[v] = true
		end
	end
	
	for i = 1, table.getn(uniquePoisons) do
		info = {
			text = uniquePoisons[i];
			value = uniquePoisons[i];
			func = PCDropDownOH_OnClick;
			}
		UIDropDownMenu_AddButton(info)
	end
end

function PCDropDownOH_OnShow()
	UIDropDownMenu_Initialize(PCDropDownOH, PCDropDownOH_Initialize)
	UIDropDownMenu_SetSelectedValue(PCDropDownOH, PC_OH)
	UIDropDownMenu_SetWidth(PCDropDownOH, 190)
end

function PCDropDownOH_OnClick(self, arg1, arg2, checked)
	PC_OH = self:GetText()
	UIDropDownMenu_SetSelectedValue(PCDropDownOH, PC_OH)
	PCDropDownOH_OnShow()
	local PoisonCharges_Tex2 = PoisonCharges_Btn2:CreateTexture(nil,"BACKGROUND")
	if strfind(PC_OH, "Instant") or strfind(PC_OH, "Быстродействующий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Poisons")
	end
	if strfind(PC_OH, "Deadly") or strfind(PC_OH, "Смертельный") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Rogue_Dualweild")
	end
	if strfind(PC_OH, "Mind-numbing") or strfind(PC_OH, "Дурманящий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Spell_Nature_Nullifydisease")
	end
	if strfind(PC_OH, "Crippling") or strfind(PC_OH, "Калечащий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Inv_Potion_19")
	end
	if strfind(PC_OH, "Wound") or strfind(PC_OH, "Нейтрализующий") then
		PoisonCharges_Tex2:SetTexture("Interface\\Icons\\Ability_Poisonsting")
	end
	PoisonCharges_Tex2:SetAllPoints(PoisonCharges_Btn2)
	PoisonCharges_Btn2.texture = PoisonCharges_Tex2
end

SLASH_POISONCHARGES1, SLASH_POISONCHARGES2 = '/poisoncharges', '/pc' -- resister slash commands
function SlashCmdList.POISONCHARGES(msg, editbox) -- toggle frames visibility
	PC_Toggle()
end

SLASH_POISONCHARGESINFO1, SLASH_POISONCHARGESINFO2 = '/poisonchargesinfo', '/pci' -- register slash commands
function SlashCmdList.POISONCHARGESINFO(msg, editbox) -- shows addon info
	DEFAULT_CHAT_FRAME:AddMessage("PoisonCharges addon v1.2 by StafordDev. Type '/poisoncharges' or '/pc' to toggle poisons info.")
end