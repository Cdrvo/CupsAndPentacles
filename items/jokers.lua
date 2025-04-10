SMODS.Joker({
	key = "1steditionjoker",
	config = {
		extra = {
			poly = 1.5,
			foil = 50,
			holo = 10,
		},
	},
	rarity = 2,
	atlas = "wip",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 8,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.poly, bcp.foil, bcp.holo },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.other_joker then
			if context.other_joker.edition ~= nil then
				if context.other_joker.edition.polychrome then
					return {
						xmult = bcp.poly,
						card = context.other_joker,
					}
				elseif context.other_joker.edition.foil then
					return {
						chips = bcp.foil,
						card = context.other_joker,
					}
				elseif context.other_joker.edition.holo then
					return {
						mult = bcp.holo,
						card = context.other_joker,
					}
				end
			end
		end
		if context.individual and not context.blueprint and context.cardarea == G.play then
			if context.other_card.edition ~= nil then
				if context.other_card.edition.polychrome then
					return {
						xmult = bcp.poly,
					}
				elseif context.other_card.edition.foil then
					return {
						chips = bcp.foil,
					}
				elseif context.other_card.edition.holo then
					return {
						mult = bcp.holo,
					}
				end
			end
		end
	end,

	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "rootber",
	atlas = "wip",
	rarity = 1,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			dollars = 9,
			dollarsm = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.dollars, card.ability.extra.dollarsm },
		}
	end,
	calculate = function(self, card, context)
		if
			context.starting_shop
			and card.ability.extra.dollars <= card.ability.extra.dollarsm
			and not context.blueprint
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return {
				message = "Destroyed",
				colour = G.C.RED,
			}
		elseif context.starting_shop and not context.blueprint then
			card.ability.extra.dollars = card.ability.extra.dollars - card.ability.extra.dollarsm
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
})

SMODS.Joker({
	key = "overkill",
	atlas = "wip",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			bonus = false,
			dollars = 8,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.bonus, card.ability.extra.dollars },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if G.GAME.talismanb == 1 then
			if context.end_of_round and G.GAME.blind.chips * 2 <= G.GAME.chips then
				bcp.bonus = true
			end
		elseif G.GAME.talismanb == 0 then
			if context.end_of_round and to_number(G.GAME.blind.chips * 2) <= to_number(G.GAME.chips) then
				bcp.bonus = true
			end
		end
		if context.starting_shop then
			bcp.bonus = false
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
	calc_dollar_bonus = function(self, card)
		local bcp = card.ability.extra
		if bcp.bonus then
			return card.ability.extra.dollars
		end
	end,
})

SMODS.Joker({
	key = "frienshipispower",
	atlas = "wip",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			bonus = false,
			dollars = 8,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.bonus, card.ability.extra.dollars },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.individual and not context.blueprint and context.cardarea == G.play then
			local temp_Mult, temp_ID = 2, 2
			for i = 1, #G.play.cards do
				if temp_ID <= G.play.cards[i].base.id and G.play.cards[i].ability.effect ~= "Stone Card" then
					temp_Mult = G.play.cards[i].base.nominal
					temp_ID = G.play.cards[i].base.id
				end
			end
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					chips = 2 * temp_Mult,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "mathematician",
	atlas = "wip",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			bonus = false,
			dollars = 8,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.bonus, card.ability.extra.dollars },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if
			context.individual
			and not context.blueprint
			and context.cardarea == G.play
			and not context.other_card:is_face()
			and context.other_card:get_id() ~= 14
			and not context.other_card.ability.effect ~= "Stone Card"
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					mult = context.other_card.base.nominal / 2,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "bankruptcy",
	atlas = "wip",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			discardused = 0,
			discards = 4,
			moneym = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { card.ability.extra.discards },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		local bcp = card.ability.extra
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + bcp.discards
		ease_discard(bcp.discards)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local bcp = card.ability.extra
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - bcp.discards
		ease_discard(-bcp.discards)
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.setting_blind and not context.blueprint then
		end
		if context.discard and not context.blueprint then
			if bcp.discardused <= bcp.discards then
				bcp.discardused = bcp.discardused + 1
			elseif bcp.discardused >= bcp.discards - 2 then
				ease_dollars(-bcp.moneym)
			end
		end
		if context.end_of_round then
			bcp.discardused = 0
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "astaroth",
	atlas = "wip",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.06,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == 6 then
				bcp.xmult = bcp.xmult + bcp.xmultg
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.MULT }
				)
			end
		end
		if context.joker_main then
			return {
				xmult = bcp.xmult,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "lasvegas",
	atlas = "wip",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			odds = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { card.ability.extra.odds },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.repetition and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == 7 then
				if pseudorandom("lasvegas") < G.GAME.probabilities.normal / bcp.odds then
					return {
						repetitions = 2,
					}
				else
					return {
						repetitions = 1,
					}
				end
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "candybag",
	atlas = "wip",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			discards = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.discards },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.setting_blind then
			ease_discard(bcp.discards)
		end
		if context.end_of_round and context.main_eval and bcp.discards > 1 and not context.blueprint then
			bcp.discards = bcp.discards - 1
		elseif context.end_of_round and context.main_eval and bcp.discards <= 1 and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return {
				message = "Destroyed",
				colour = G.C.RED,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "gofish",
	atlas = "wip",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			chips = 0,
			chipsg = 6,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.chips, bcp.chipsg },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.joker_main then
			local upgrade = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
					upgrade = false
				end
			end
			if upgrade then
				bcp.chips = bcp.chips + bcp.chipsg
				return {
					chips = bcp.chips,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "cardrating",
	atlas = "wip",
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			mult = 0,
			multg = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.chips, bcp.chipsg },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.discard and not context.blueprint then
			if context.other_card:get_id() == 10 then
				bcp.mult = bcp.mult + bcp.multg
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.MULT }
				)
			end
		end
		if context.joker_main then
			return {
				mult = bcp.mult,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "bonanza",
	atlas = "wip",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			mult = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mult },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			local all_cards = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() == 10 then
					all_cards = all_cards + 1
					print(all_cards)
				end
			end
			if all_cards >= 1 then
				return {
					mult = card.ability.extra.mult * all_cards,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "sheen",
	atlas = "wip",
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			xmult = 1.5,
			status = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.status },
		}
	end,

	calculate = function(self, card, context)
		if context.discard then
			card.ability.extra.status = true
		end
		if context.joker_main and card.ability.extra.status then
			card.ability.extra.status = false
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "lifebuoy",
	atlas = "wip",
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			chips = 0,
			mult = 0,
			chipsg = 20,
			multg = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.status },
		}
	end,

	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.joker_main and not context.blueprint and not context.repetition and not context.individual then
			bcp.chips = bcp.chips + bcp.chipsg
			bcp.mult = bcp.mult + bcp.multg
			return {
				chips = bcp.chips,
				mult = bcp.mult,
			}
		end
		if context.end_of_round then
			bcp.chips = 0
			bcp.mult = 0
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "modernjoker",
	atlas = "wip",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			repetitions = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.repetitions },
		}
	end,

	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.repetition then
			if context.other_card.ability.effect == "Wild Card" then
				return {
					repetitions = bcp.repetitions,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

function bonus()
	local bb = 0
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_bonus") then
				bb = bb + 1
			end
		end
		return bb
	end
	return 0
end

SMODS.Joker({
	key = "auguste",
	config = {
		extra = {
			chips = 5,
			bonus(),
		},
	},
	rarity = 2,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		return {
			vars = { card.ability.extra.chips * bonus() },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card.ability.effect == "Bonus Card" then
			if bonus() > 0 then
				return {
					chips = bonus() * card.ability.extra.chips,
				}
			end
		end
	end,

	in_pool = function(self, wawa, wawa2)
		if bonus() > 0 then
			return true
		end
		return false
	end,
})

function mults()
	local bb = 0
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_mult") then
				bb = bb + 1
			end
		end
		return bb
	end
	return 0
end

SMODS.Joker({
	key = "harlequin",
	config = {
		extra = {
			mult = 3,
			mults(),
		},
	},
	rarity = 2,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		return {
			vars = { card.ability.extra.mult * mults() },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if mults() > 0 then
				return {
					mult = mults() * card.ability.extra.mult,
				}
			end
		end
	end,

	in_pool = function(self, wawa, wawa2)
		if bonus() > 0 then
			return true
		end
		return false
	end,
})

SMODS.Joker({
	key = "spectrometer",
	config = {
		extra = {
			xmultg = 0.25,
			xmult = 1
		},
	},
	rarity = 2,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
	if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
		return {
			vars = { (card.ability.extra.xmult+(G.GAME.consumeable_usage_total.spectral*card.ability.extra.xmultg)) },
		}
	else
		return {
			vars = { card.ability.extra.xmult },
		}
	end
end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
			return {
				xmult = (card.ability.extra.xmult+(G.GAME.consumeable_usage_total.spectral*card.ability.extra.xmultg))
			}
		else
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
end
})

function base()
	local bb = 0
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if v.ability.effect == "Base" and not v.edition and v.ability.seal == nil then
				bb = bb + 1
			end
		end
		return bb
	end
	return 0
end

SMODS.Joker({
	key = "primaessentia",
	config = {
		extra = {
			chips = 30,
			mult = 5
		},
	},
	rarity = 2,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 8,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.chips, bcp.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.effect == "Base" and not context.other_card.edition and context.other_card.ability.seal == nil then
				if base() >= 52 then
					return {
						chips = card.ability.extra.chips,
						mult = card.ability.extra.mult,
					}
				end
			end
		end
	end

})
