return {
	descriptions = {
		Back = {},
		Blind = {},
		Edition = {},
		Enhanced = {},
		Joker = {
			j_bcp_overkill = {
				name = "¡Overkill!",
				text = {
					"Earn {C:money}$#2#{} at end of round",
					"if chips scored are at least",
					"{C:attention}200%{} of the required chips",
				},
			},
			j_bcp_1steditionjoker = {
				name = "1st Edition Joker",
				text = {
					"{C:dark_edition}Editions{} on {C:attention}Cards{}",
					"and {C:attention}Jokers{} score twice",
				},
			},
			j_bcp_rootber = {
				name = "Root Beer",
				text = {
					"Earn {C:money}$#1#{} at end of round,",
					"reduces by {C:red}-$#2#{} when triggered",
				},
			},
			j_bcp_frienshipispower = {
				name = "Friendship Is Power",
				text = {
					"Scored cards give Chips",
					"equal to {C:attention}double{} the",
					"{C:attention}highest{} ranked card played",
				},
			},
            j_bcp_mathematician = {
				name = "Mathematician",
				text = {
					"{C:attention}Scoring{} number cards give {C:red}half",
                     "their rank as {C:mult}Mult{} when scored",
					"{C:inactive}(2 = +1, 10 = +5, 7 = +3.5)",
				},
			},
            j_bcp_bankruptcy = {
				name = "Bankruptcy",
				text = {
					"+4 discards but costs -$2 each discard past 3",
                    "{C:inactive}(incomplete description)",
				},
			},
			j_bcp_astaroth = {
				name = "Astaroth",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult", 
					"when each played {C:attention}6{} is scored",
					"{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_lasvegas = {
				name = "Las Vegas",
				text = {
					"Retrigger each played {C:attention}7{}",
					"{C:green}#1# in #2#{} to retrigger it a second time"
				},
			},
			j_bcp_candybag = {
				name = "Candy Wrapper"
				text = {
					"When {C:attention}blind{} is selected",
					"gain {C:red}+#1#{} discards",
					"{C:red}-1{} discard per round played",
				},
			},
			j_bcp_gofish = {
				name = "Go Fish"
				text = {
					"{C:chips}+#2#{} Chips if played{C:attention}poker hand{}",
					"is your most played{C:attention}poker hand{}", 
					"This Joker gains {C:chips}+#1#{} Chips if played{C:attention}poker hand{}",
					"is your most played{C:attention}poker hand{}", 
				},
			},
			j_bcp_cardrating = {
				name = "Card Rating"
				text = {
					"This Joker gains {C:mult}+#2#{} Mult",
					"for each {C:attention}10{} discarded",
					"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_bonanza = {
				name = "Bonanza"
				text = {
					"{C:mult}+#1#{} Mult for every",
					"{C:chips}10{} Chips in score",	
				},
			},
			j_bcp_sheen = {
				name = "Sheen"
				text = {
					"After {C:attention}discarding{}",
					"{X:mult,C:white}X#1#{}	m¡Mult in your",
					"next played hand",
				},
			},
			j_bcp_lifebuoy = {
				name = "Lifebuoy"
				text = {
					"{C:chips}+#3#{} Chips and {C:mult}+#4#{} Mult",
					"for every hand played this round",
					"{C:inactive:}(Currently{} {C:chips}+#1#{} Chips and {C:mult}+#2#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_modernjoker = {
				name = "Modern Joker"
				text = {
					"Retrigger all",
					"played {C:attention}wild{} cards",
				},
			},
			j_bcp_auguste = {
				name = "Auguste Joker"
				text = {
					"Played {C:attention}bonus cards{} give {C:chips}+#2#{} Chips",
					"for each {C:attention}bonus card{} in your",
					" {C:attention}full deck{} when scored",
					"{C:inactive:}(Currently{} {C:chips}+#1#{} {C:inactive:}Chips){}",
				},
			},
			j_bcp_harlequin = {
				name = "Harlequin Joker"
				text = {
					"Gives {C:mult}+#2#{} Mult",
					"for each {C:attention}mult card{}",
					" in your {C:attention}full deck{}",
					"{C:inactive:}(Currently{} {C:mult}+#1#{} {C:inactive:}Mult){}",
				},
			},
			j_bcp_spectrometer = {
				name = "Spectrometer"
				text = {
					"{X:mult,C:white}X#2#{} Mult per {C:spectral}spectral{} card",
					" used this run",
					"{C:inactive:}(Currently{} {X:mult,C:white}X#1#{} {C:inactive:}Mult){}"
				},
			},
			j_bcp_primaessentia = {
				name = "Prima Essentia"
				text = {
					"Played {C:attention}Base cards{} give {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
					"when scored if you have at least",
					"{C:attention}50 base cards{} in {C:attention}full deck{}",
					"{C:inactive}(Cards without enhancements seals or editions){}",
				},
			},
			j_bcp_lavandascult = {
				name = "Lavender Cult"
				text = {
					"Played {C:attention}Enhanced{} cards",
					"give {X:mult,C:white}X#1#{} Mult when scored",
				},
			},
			j_bcp_partyballoons = {
				name = "Party Balloons"
				text = {
					"Adds {C:attention}sell value{} of",
					"any sold {C:attention}Joker{} to itself",
					"as {C:attention}sell value{}",
				},
			},
			j_bcp_emergencysquirrel = {
				name = "Emergency Squirrel"
				text = {
					"Sell this Joker in a {C:attention}blind{}",
					"to generate a {C:attention}Squirrel{}",
					"{C:inactive}(Squirrel: +30 Mult, self destructs at the end of round){}",
				},
			},
			j_bcp_squirrel = {
				name = "Squirrel"
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:red,E:2}self destructs{}",
					"at the end of round",
				},
			},
			j_bcp_lacucaracha = {
				name = "La Cucaracha"
				text = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"a {C:attention}non scoring{} card",
				},
			},
			j_bcp_eclipse = {
				name = "Eclipse"
				text = {
					"Levels up another random{C:attention}poker hand{}",
					"each time you use",
					"a {C:planet}planet{} card",
				},
			},
			j_bcp_hauntedhouse = {
				name = "Haunted House"
				text = {
					"This Joker gains{X:mult,C:white}X#2#{} Mult",
					"if played hand contains",
					"a {C:attention}Full House{}",
					"{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_revolution = {
				name = "Revolution"
				text = {
					"+{X:mult,C:white}X#1#{} Mult",
					"{C:red,E:2}self destructs{} when",
					"any {C:attention}Joker{} is purchased",
				},
			},
			j_bcp_gummyclowns = {
				name = "Gummy Clowns"
				text = {
					"Create {C:attention}2{} {C:tarot}tarot{} cards",
					"when playing a hand",
					"for the next {C:attention}#1#{} hands",
				},
			},
			j_bcp_betrayal = {
				name = "Betrayal"
				text = {
					"{C:mult}+#1#{} Mult if",
					"played{C:attention}poker hand{}",
					"is not your",
					"most played {C:attention}poker hand{}",
				},
			},
			j_bcp_tengumask = {
				name = "Tengu Mask"
				text = {
					"This Joker gains {C:mult}+#2#{} Mult",
					"per {C:attention}consecutive{} hand",
					"played with a",
					"scoring {C:spades}spade{} card",
					"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_chupacabraslegend = {
				name = "Chupacabras Legend"
				text = {
					"Gives {C:chips}+#1#{} Chips for each",
					"{C:hearts}heart{} card in your {C:attention}full deck{}",
					"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}",
				},
			},
			j_bcp_theleprechaun = {
				name = "The Leprechaun"
				text = {
					"This Joker has a",
					"{C:green}#4# in #3#{} chance to gain {X:mult,C:white}X#2#{} Mult",
					"when each played {C:clubs}club{} is scored",
					"{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
				},
			},
			j_bcp_shinobi = {
				name = "Shinobi"
				text = {
					"{C:mult}+#1#{} Mult",
					"lose {C:red}$#2#{} at the end of round",
					"{C:inactive}(Payment increases by{} {C:attention}1{} {C:inactive}each round){}",
				},
			},
			j_bcp_gbathroom = {
				name = "G-bAthro0m"
				text = {
					"Creates a {C:tarot}tarot{} card",
					"if {C:attention}discarded{} hand",
					"contains a {C:attention}Flush{}",
				},
			},
			j_bcp_floraltea = {
				name = "Floral Tea"
				text = {
					"After {C:attention}#2#{} rounds",
					"sell this card to",
					"add {C:dark_edition}negative{} to a random {C:attention}Joker{}",
					"(incomplete desc)",
				},
			},
			j_bcp_sadness = {
				name = "Sadness"
				text = {
					"When {C:attention}Small Blind{} or {C:attention}Big Blind{} are selected",
					"Create a random {C:dark_edition}negative{} {C:attention}Joker{}",
					"and {C:red,E:2}destroys{} it at the end of round"
				},
			},
			j_bcp_happiness = {
				name = "Happiness"
				text = {
					"Joker in progress :)",
				},
			},
			j_bcp_onomatopoeia = {
				name = "Onomatopoeia"
				text = {
					"{C:blue}Common{} Jokers",
					"each give {C:chips}+#1#{} Chips",
				},
			},
			j_bcp_sleeper = {
				name = "Sleeper"
				text = {
					"Create a{C:spectral}spectral{} card",
					"When {C:attention}boss blind{} is defeated",
				},
			},
			j_bcp_tetrafobia = {
				name = "Tetraphobia"
				text = {
					"Each played {C:attention}4{}",
					"gives {X:mult,C:white}X#1#{} Mult when scored",
					"increases by {X:mult,C:white}X#2#{} Mult when",
					"a {C:attention}Four of a Kind{} is played",
				},
			},
			j_bcp_cupsandpentacles = {
				name = "Cups & Pentacles"
				text = {
					"Earn {C:money}$#1#{} if all",
					"cards held in hand",
					"are {C:hearts}hearts{} or {C:diamonds}diamonds{}",
				},
			},
		},
		Other = {},
		Planet = {},
		Spectral = {},
		Stake = {},
		Tag = {},
		Tarot = {},
		Voucher = {},
	},
	misc = {
		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},
		dictionary = {},
		high_scores = {},
		labels = {},
		poker_hand_descriptions = {},
		poker_hands = {},
		quips = {},
		ranks = {},
		suits_plural = {},
		suits_singular = {},
		tutorial = {},
		v_dictionary = {},
		v_text = {},
	},
} 
