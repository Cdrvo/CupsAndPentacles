SMODS.load_file("items/jokers.lua")()


SMODS.Atlas{
    key = "wip",
    path = "wip.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true,
        cardareas = {
            unscored = true
        }
    }
end

local igo = Game.init_game_object
Game.init_game_object = function(self)
	local ret = igo(self)
	if next(SMODS.find_mod("Talisman")) then
		ret.talismab = 1
	else
		ret.talismanb = 0
	end
        ret.soldjokers = 1
        ret.soldvirus = 1
	return ret
end

local sell_card_old = Card.sell_card
function Card:sell_card()
	if self.config.center.set == "Joker" then
			G.GAME.soldjokers = G.GAME.soldjokers + 1
		end
        if self.config.center.key == "j_bcp_virus" then
            G.GAME.soldvirus = G.GAME.soldvirus + 0.5
        end
	sell_card_old(self)
end

