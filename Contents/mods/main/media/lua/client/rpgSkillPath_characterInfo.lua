require "XpSystem/ISUI/ISCharacterInfo"

local rpgSkillPath = require "rpgSkillPath_main"

--local originalLoadPerk = ISCharacterInfo.loadPerk
ISCharacterInfo.loadPerk = function(self)

    local perks = {}
    local perksDone = {}
    for i = 0, PerkFactory.PerkList:size() - 1 do
        local perk = PerkFactory.PerkList:get(i)
        if not perksDone[perk:getType()] and rpgSkillPath.checkIfCharacterHasTraitsFromPerk(self.char, perk) then
            print("SHOW perk:"..perk:getName())
            if perk:getParent() ~= Perks.None then
                local pixLen = getTextManager():MeasureStringX(UIFont.Small, perk:getName())
                if pixLen > self.txtLen then self.txtLen = pixLen end
                if not perks[perk:getParent()] then perks[perk:getParent()] = {} end
                table.insert(perks[perk:getParent()], perk)
            end
            perksDone[perk:getType()] = true

        end
    end
    return perks
end