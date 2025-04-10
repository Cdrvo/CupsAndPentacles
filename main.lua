SMODS.load_file("items/jokers.lua")()


SMODS.Atlas{
    key = "wip",
    path = "wip.png",
    px = 71,
    py = 95,
}

SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true
    }
end

local igo = Game.init_game_object
Game.init_game_object = function(self)
	local ret = igo(self)
	if next(SMODS.find_mod("Talisman")) then
		ret.talismanb = 1
	else
		ret.talismanb = 0
	end
	return ret
end