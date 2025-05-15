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
	atlas = "jokers",
	rarity = 1,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 1,
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
		if G.GAME.talismanb == 0 then
			if context.end_of_round and G.GAME.blind.chips * 2 <= G.GAME.chips then
				bcp.bonus = true
			end
		elseif G.GAME.talismanb == 1 then
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
	rarity = 1,
	cost = 4,
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
			and context.other_card.ability.effect ~= "Stone Card"
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
			elseif bcp.discardused >= bcp.discards + 1 then
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
			vars = { card.ability.extra.xmult, card.ability.extra.xmultg },
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
	atlas = "jokers",
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
			vars = { (G.GAME.probabilities.normal or 1), bcp.odds },
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
			vars = { bcp.mult, bcp.multg },
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
		local bcp = card.ability.extra
		if context.joker_main then
			if G.GAME.talismanb == 0 then
				return {
					mult = math.floor(hand_chips / 10),
				}
			elseif G.GAME.talismanb == 1 then
				return {
					mult = math.floor(to_number(hand_chips / 10)),
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
			chipsg = 15,
			multg = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
			card.ability.extra.chips, 
			card.ability.extra.mult, 
			card.ability.extra.chipsg, 
			card.ability.extra.multg 
			},
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
			vars = { card.ability.extra.chips * bonus(), card.ability.extra.chips },
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
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		return {
			vars = { card.ability.extra.mult * mults(), card.ability.extra.mult },
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
		if mults() > 0 then
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
			xmult = 1,
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
		if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
			return {
				vars = {
					(card.ability.extra.xmult + (G.GAME.consumeable_usage_total.spectral * card.ability.extra.xmultg)),
					card.ability.extra.xmultg
				},
			}
		else
			return {
				vars = { card.ability.extra.xmult,card.ability.extra.xmultg },
			}
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
				return {
					xmult = (
						card.ability.extra.xmult
						+ (G.GAME.consumeable_usage_total.spectral * card.ability.extra.xmultg)
					),
				}
			else
				return {
					xmult = card.ability.extra.xmult,
				}
			end
		end
	end,
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
			mult = 5,
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
			if
				context.other_card.ability.effect == "Base"
				and not context.other_card.edition
				and context.other_card.ability.seal == nil
			then
				if base() >= 52 then
					return {
						chips = card.ability.extra.chips,
						mult = card.ability.extra.mult,
					}
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "lavandascult",
	config = {
		extra = {
			xmult = 1.4,
		},
	},
	rarity = 3,
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
			vars = { bcp.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.effect ~= "Base" then
				return {
					xmult = card.ability.extra.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "partyballoons",
	config = {
		extra = {},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.xmult },
		}
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.selling_card and context.card.ability.set == "Joker" then
				card.ability.extra_value = card.ability.extra_value + context.card.sell_cost
				card:set_cost()
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.MONEY }
				)
			end
		end
	end,
})

SMODS.Joker({
	key = "emergencysquirrel",
	config = {
		extra = {},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 4,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			SMODS.add_card({
				key = "j_bcp_squirrel",
				area = G.jokers,
			})
		end
	end,
})

SMODS.Joker({
	key = "squirrel",
	config = {
		extra = {
			mult = 30,
		},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 1,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.end_of_round and not context.blueprint then
			card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return false
	end,
})

SMODS.Joker({
	key = "lacucaracha",
	config = {
		extra = {
			chips = 80,
		},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 4,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.chips, bcp.unscored },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		local unscored = 0
		if context.cardarea == "unscored" then
			unscored = unscored + 1
			bcp.unscored = unscored
		end
		if context.joker_main and bcp.unscored >= 1 then
			return {
				chips = card.ability.extra.chips,
			}
		end
		if context.after then
			bcp.unscored = 0
		end
	end,
})

SMODS.Joker({
	key = "eclipse",
	config = {
		extra = {},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if not context.blueprint then
			if context.using_consumeable and context.consumeable.ability.set == "Planet" then
				local allhands = {}
				for k, v in pairs(SMODS.PokerHands) do
					table.insert(allhands, k)
				end
				local toadd = pseudorandom_element(allhands, pseudoseed("void"))
				update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
					handname = localize(toadd, "poker_hands"),
					chips = G.GAME.hands[toadd].chips,
					mult = G.GAME.hands[toadd].mult,
					level = G.GAME.hands[toadd].level,
				})
				level_up_hand(card, toadd, nil, 1)
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = "", level = "" }
				)
			end
		end
	end,
})

SMODS.Joker({
	key = "hauntedhouse",
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.1,
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
	cost = 7,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {bcp.xmult, bcp.xmultg},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.joker_main then
			if next(context.poker_hands["Four of a Kind"]) then
				if not context.blueprint then
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
				return {
					xmult = bcp.xmult,
				}
			else
				return {
					xmult = bcp.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "revolution",
	config = {
		extra = {
			xmult = 3,
		},
	},
	rarity = 3,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 9,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.buying_card and context.card.ability.set == "Joker" then
			card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = "Destroyed!", colour = G.C.MULT })
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "dreamjoker",
	config = {
		extra = {
			xmult = 0.5,
		},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
	if G and G.GAME and G.GAME.virussold then
			return {
				vars = {bcp.xmult, bcp.xmult*G.GAME.soldjokers, },
			}
		else
			return{
				vars = {bcp.xmult,bcp.xmult}
			}
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult * G.GAME.soldjokers,
			}
		end
	end,
})

SMODS.Joker({
	key = "virus",
	config = {
		extra = {
			xmult = 0.5,
		},
	},
	rarity = 1,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		if G and G.GAME and G.GAME.virussold then
			return {
				vars = {bcp.xmult, bcp.xmult*G.GAME.virussold, },
			}
		else
			return{
				vars = {bcp.xmult,bcp.xmult}
			}
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = bcp.xmult*G.GAME.virussold,
			}
		end
	end,
})

SMODS.Joker({
	key = "gummyclowns",
	config = {
		extra = {
			hands = 8,
		},
	},
	rarity = 3,
	atlas = "wip",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.hands },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.final_scoring_step then
			if #G.consumeables.cards+1 < G.consumeables.config.card_limit or self.area == G.consumeables then
				bcp.hands = bcp.hands - 1
				for i = 1, 2 do
					SMODS.add_card({
						set = "Tarot",
					})
				end
				if bcp.hands == 0 then
					card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
				end
			else
				return {
					message = "No Room!",
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "betrayal",
	atlas = "wip",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			mult = 15,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult },
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
			if not upgrade then
				return {
					mult = bcp.mult,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "tengumask",
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
			multg = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult,bcp.multg },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.joker_main then
			return {
				mult = bcp.mult
			}
		end
		if context.before then
			hspade = false
			hand = context.scoring_hand
			for _, other_card in ipairs(hand) do
				-- Note: At the time of creating this, other_card:is_suit("Spades") didn't work
				if other_card.base.suit == "Spades" then
					hspade = true
				end
			end
			if hspade then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.MULT }
				)
				bcp.mult = bcp.mult + bcp.multg
			else
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_reset"), colour = G.C.EXTRA }
				)
				bcp.mult = 0
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

function hearts()
	local bb = 0
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Hearts",nil,true) then
				bb = bb + 1
			end
		end
		return bb
	end
	return 0
end

SMODS.Joker({
	key = "chupacabraslegend",
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
			chips = 7
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.chips,(bcp.chips*hearts()) },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if hearts() >= 1 then
			return{
				chips = bcp.chips*hearts()
			}
		else
			return{
				chips = bcp.chips
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "theleprechaun",
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
			xmult = 1,
			xmultg = 0.2,
			odds = 4
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.xmult,bcp.xmultg,bcp.odds,(G.GAME.probabilities.normal or 1) },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.individual and context.other_card:is_suit("Clubs") and pseudorandom("theleprechaun") < bcp.odds / G.GAME.probabilities.normal and not context.blueprint then
			bcp.xmult = bcp.xmult + bcp.xmultg
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_upgrade_ex"), colour = G.C.MULT}
			)
		end
		if context.joker_main then
			return{
				xmult = bcp.xmult
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "shinobi",
	atlas = "wip",
	rarity = 3,
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
			mult = 50,
			mdollars = 1 
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult,(-bcp.mdollars)},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.joker_main then
			return{
				mult = bcp.mult
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			ease_dollars(bcp.mdollars)
		end
		if context.starting_shop and not context.blueprint then
			bcp.mdollars = bcp.mdollars + 1
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "gbathroom",
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
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.pre_discard and next(context.poker_hands["Flush"]) and not context.blueprint then
			SMODS.add_card{
				set = "Tarot"
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "floraltea",
	atlas = "wip",
	rarity = 3,
	cost = 9,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			rounds = 0,
			maxrounds = 3
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {bcp.rounds, bcp.maxrounds},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.end_of_round and bcp.rounds < bcp.maxrounds then
			bcp.rounds = bcp.rounds + 1
		end
		if context.selling_self and bcp.rounds >= bcp.maxrounds then
						local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers > 0 then
				if not context.blueprint then
					local chosen_joker = pseudorandom_element(jokers, pseudoseed("ml"))
					chosen_joker:set_edition({ negative = true }, true)
				end
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "sadness",
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
			rounds = 0,
			maxrounds = 3
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.setting_blind and not G.GAME.blind.boss then
			bcp.card = SMODS.add_card{
				set = "Joker",
			}
		else bcp.card = nil
		end
		if context.end_of_round and bcp.card and not context.blueprint then
			bcp.card:start_dissolve({HEX("57ecab")},nil, 1.6)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

function debuffed()
	local bb = 1
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if v.debuff then
				bb = bb + 0.05
			end
		end
		return bb
	end
	return 1
end

SMODS.Joker({
	key = "happiness",
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
			xmultg = 0.05
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = {debuffed(), bcp.xmultg},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.individual and context.cardarea == G.play then
			SMODS.debuff_card(context.other_card, true, card.config.center.key)
		end
		if context.joker_main then
			return{
				xmult = debuffed()
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "onomatopoeia",
	atlas = "wip",
	rarity = 1,
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
			mult = 30
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult},
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.other_joker and context.other_joker.ability.rarity == 0.97 then
			return{
				chips = bcp.mult,
				card = card
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "sleeper",
	atlas = "wip",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.mult },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.end_of_round and context.main_eval and G.GAME.blind.boss then
			SMODS.add_card({
				set = "Spectral",
			})
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "tetrafobia",
	atlas = "wip",
	rarity = 3,
	cost = 5,
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
			xmultg = 0.4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local bcp = card.ability.extra
		return {
			vars = { bcp.xmult, bcp.xmultg },
		}
	end,
	calculate = function(self, card, context)
		local bcp = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 4 then
				return {
					xmult = bcp.xmult,
				}
			end
		end
		if context.joker_main and next(context.poker_hands["Four of a Kind"]) then
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
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "cupsandpentacles",
	atlas = "wip",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			dollars = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.dollars },
		}
	end,

	calculate = function(self, card, context)
		-- all cards calc
		local all_cards = 0
		if context.joker_main then
			for k, v in ipairs(G.hand.cards) do
				all_cards = all_cards + 1
				card.ability.extra.allcards = all_cards
			end
			-- checks for diamonds
			local redd_suits = 0
			for k, v in ipairs(G.hand.cards) do
				if v:is_suit("Diamonds", nil, true) then
					redd_suits = redd_suits + 1
				end
			end
			-- check for hearts
			local redh_suits = 0
			for k, v in ipairs(G.hand.cards) do
				if v:is_suit("Hearts", nil, true) then
					redh_suits = redh_suits + 1
				end
			end
			if redh_suits + redd_suits >= all_cards then
				return {
					dollars = card.ability.extra.dollars,
				}
			end
		end
	end,
})
