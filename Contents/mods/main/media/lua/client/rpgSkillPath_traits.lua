local rpgSkillPath = require "rpgSkillPath_main"

local function initPrimarySkillTraits() rpgSkillPath.addPrimaryTraitsFromCraftingPerks() end

---TEMP DISABLE
--Events.OnGameBoot.Add(initPrimarySkillTraits)