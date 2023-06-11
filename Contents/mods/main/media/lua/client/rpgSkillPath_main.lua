local rpgSkillPath = {}

rpgSkillPath.activatedPerks = {}


function rpgSkillPath.addPrimaryTraitsFromCraftingPerks()
    for i = 0, PerkFactory.PerkList:size() - 1 do
        ---@type PerkFactory.Perk
        local perk = PerkFactory.PerkList:get(i)
        if perk:getParent() == Perks.Crafting then rpgSkillPath.addPrimaryTrait(perk) end
    end
end


---@param char IsoGameCharacter
---@param perk PerkFactory.Perk
function rpgSkillPath.checkIfCharacterHasTraitsFromPerk(char, perk) --Perks.ETC

    --print("PERK: "..perk:getName())

    local validPerk = rpgSkillPath.activatedPerks[perk]
    if validPerk then
        print("VALID PERK: "..tostring(validPerk).."   1:"..validPerk[1].."("..tostring(char:HasTrait(validPerk[1]))..")  2:"..validPerk[2].."("..tostring(char:HasTrait(validPerk[2]))..")")
        return char:HasTrait(validPerk[1]) or char:HasTrait(validPerk[2])
    end
    return true
end


---@param perk PerkFactory.Perk
function rpgSkillPath.addPrimaryTrait(perk)

    local perkName = perk:getName()
    local trait1ID, trait2ID = perkName..1, perkName..2

    local trait1 = TraitFactory.addTrait(trait1ID, getText("UI_trait_PrimarySkill", "1", perkName), -1, getText("UI_trait_PrimarySkillDesc", string.lower(perkName)), false, false)
    local trait2 = TraitFactory.addTrait(trait2ID, getText("UI_trait_PrimarySkill", "2", perkName), -1, getText("UI_trait_PrimarySkillDesc", string.lower(perkName)), false, false)

    TraitFactory.setMutualExclusive(trait1ID, trait2ID)
    for loadedPerk,traitIDs in pairs(rpgSkillPath.activatedPerks) do
        TraitFactory.setMutualExclusive(trait1ID, traitIDs[1])
        TraitFactory.setMutualExclusive(trait2ID, traitIDs[2])
    end

    rpgSkillPath.activatedPerks[perk] = {trait1:getType(), trait2:getType()}

    return trait1, trait2
end

return rpgSkillPath