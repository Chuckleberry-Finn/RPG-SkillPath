local rpgSkillPath = require "rpgSkillPath_main"

local function initPrimarySkillTraits() rpgSkillPath.addPrimaryTraitsFromCraftingPerks() end

Events.OnGameBoot.Add(initPrimarySkillTraits)