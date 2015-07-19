function UpdateTime()
	local _, mht, mh, _, oht, oh = GetWeaponEnchantInfo()
	if mh ~= nil then
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
	else
		PoisonMH1:SetText("Not applied!")
		PoisonMH2:SetText()
	end
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
	else
		PoisonOH1:SetText("Not applied!")
		PoisonOH2:SetText()
	end
	if not (UnitAffectingCombat("player")) then
		PoisonMH1:SetAlpha(0.2)
		PoisonMH2:SetAlpha(0.2)
		PoisonMH3:SetAlpha(0.2)
		PoisonOH1:SetAlpha(0.2)
		PoisonOH2:SetAlpha(0.2)
		PoisonOH3:SetAlpha(0.2)
	end
	if UnitAffectingCombat("player") then
		PoisonMH1:SetAlpha(1)
		PoisonMH2:SetAlpha(1)
		PoisonMH3:SetAlpha(1)
		PoisonOH1:SetAlpha(1)
		PoisonOH2:SetAlpha(1)
		PoisonOH3:SetAlpha(1)
	end
end

PoisonChargesVisible = 1

SLASH_POISONCHARGES1, SLASH_POISONCHARGES2 = '/poisoncharges', '/pc'
function SlashCmdList.POISONCHARGES(msg, editbox)
	if PoisonChargesVisible == 1 then
		PoisonChargesVisible = 0
		PoisonCharges1:Hide()
		PoisonCharges2:Hide()
	else
		PoisonChargesVisible = 1
		PoisonCharges1:Show()
		PoisonCharges2:Show()
	end
end

SLASH_POISONCHARGESINFO1, SLASH_POISONCHARGESINFO2 = '/poisonchargesinfo', '/pci'
function SlashCmdList.POISONCHARGESINFO(msg, editbox)
	DEFAULT_CHAT_FRAME:AddMessage("PoisonCharges addon v1.0 by StafordDev. Type '/poisoncharges' or '/pc' to toggle poisons info.")
end

DEFAULT_CHAT_FRAME:AddMessage("PoisonCharges v1.0 loaded. Type '/poisonchargesinfo' or '/pci' to show help.")
local _, mht, mh, _, oht, oh = GetWeaponEnchantInfo()
PoisonCharges1 = CreateFrame("Frame", nil, UIParent)
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
PoisonCharges1:Show()

PoisonCharges2 = CreateFrame("Frame", nil, UIParent)
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
PoisonCharges2:Show()