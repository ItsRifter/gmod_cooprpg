local achgroup = {
	Name = "Ach_Group_HL2",
	Index = 1,
	Achievements ={
		["HL2_Subm"] ={
			Name = "Ach_HL2_Subm_N",
			Mat = "vgui/achievements/hl2_put_canintrash.png", 
			Desc = "Ach_HL2_Subm_D",
			Rewards = {
				XP = 120,
				AP = 5
			},
			Secret = true,
			Index = 1
		},
		["HL2_Defi"] ={
			Name = "Ach_HL2_Defi_N",
			Mat = "vgui/achievements/hl2_hit_cancop_withcan.png", 
			Desc = "Ach_HL2_Defi_D",
			Rewards = {
				XP = 120,
				AP = 5
			},
			Secret = true,
			Index = 2
		},
		["HL2_Mal"] ={
			Name = "Ach_HL2_Malc_N",
			Mat = "vgui/achievements/hl2_escape_apartmentraid.png", 
			Desc = "Ach_HL2_Malc_D",
			Rewards = {
				XP = 500,
				AP = 20
			},
			Interval = 99,
			Max = 4,
			Index = 3
		},
		["HL2_WCat"] ={
			Name = "Ach_HL2_WhatC_N",
			Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
			Desc = "Ach_HL2_WhatC_D",
			Rewards = {
				XP = 250,
				AP = 5
			},
			Secret = true,
			Index = 4
		},
		["HL2_WBaby"] ={
			Name = "Ach_HL2_WhatB_N",
			Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
			Desc = "Ach_HL2_WhatB_D",
			Rewards = {
				XP = 450,
				Items = {"HAT_BABY"},
				AP = 15
			},
			Index = 5
		},
		["HL2_Crowbar"] ={
			Name = "Ach_HL2_Hardware_N",
			Mat = "vgui/achievements/hl2_get_crowbar.png", 
			Desc = "Ach_HL2_Hardware_D",
			Rewards = {
				XP = 300,
				AP = 5
			},
			Index = 6
		},
		["HL2_Barnacle"] ={
			Name = "Ach_HL2_BBowling_N",
			Mat = "vgui/achievements/hl2_kill_barnacleswithbarrel.png", 
			Desc = "Ach_HL2_BBowling_D",
			Rewards = {
				XP = 500,
				AP = 5
			},
			Index = 7
		},
		["HL2_Canals"] ={
			Name = "Ach_HL2_Canals_N",
			Mat = "vgui/achievements/hl2_get_airboat.png", 
			Desc = "Ach_HL2_Canals_D",
			Rewards = {
				XP = 3000,
				AP = 65
			},
			Interval = 99,
			Max = 13,
			Index = 8
		},
		["HL2_Gravgun"] ={
			Name = "Ach_HL2_ZeroE_N",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Ach_HL2_ZeroE_D",
			Rewards = {
				XP = 250,
				AP = 10
			},
			Index = 9
		},
		["HL2_HevPlate"] ={
			Name = "Ach_HL2_BlastPast_N",
			Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
			Desc = "Ach_HL2_BlastPast_D",
			Rewards = {
				XP = 200,
				AP = 5
			},
			Secret = true,
			Index = 10
		},
		["HL2_TwoPoint"] ={
			Name = "Ach_HL2_TwoPoint_N",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Ach_HL2_TwoPoint_D",
			Rewards = {
				XP = 250,
				AP = 5
			},
			Secret = true,
			Index = 11
		},
		["HL2_Chopper"] ={
			Name = "Ach_HL2_ZombieChop_N",
			Mat = "vgui/achievements/hl2_beat_ravenholm_noweapons.png", 
			Desc = "Ach_HL2_ZombieChop_D",
			Rewards = {
				XP = 1000,
				Items = {"MELEE_CROWSAW"},
				AP = 30
			},
			Index = 20
		},
		["HL2_Hallow"] ={
			Name = "Ach_HL2_HallowG_N",
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Ach_HL2_HallowG_D",
			Rewards = {
				XP = 300,
				AP = 10
			},
			Index = 21
		},
		["HL2_RavenBall"] ={
			Name = "Ach_HL2_RavenB_N",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Ach_HL2_RavenB_D",
			Rewards = {
				XP = 900,
				Items = {"HAT_BALL"},
				AP = 30
			},
			Interval = 99,	--Dont want it to show till finished anyway
			Max = 8,
			Index = 22
		},
------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_Cubbage"] ={
			Name = "Ach_HL2_Cubbage_N",
			Mat = "vgui/achievements/hl2_kill_odessagunship.png", 
			Desc = "Ach_HL2_Cubbage_D",
			Rewards = {
				XP = 400,
				AP = 15
			},
			Index = 30
		},
		["HL2_Sand"] ={
			Name = "Ach_HL2_OffSand_N",
			Mat = "vgui/achievements/hl2_beat_donttouchsand.png", 
			Desc = "Ach_HL2_OffSand_D",
			Rewards = {
				XP = 400,
				AP = 10
			},
			Index = 31
		},
		["HL2_Coast"] ={
			Name = "Ach_HL2_Coast_N",
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = "Ach_HL2_Coast_D",
			Rewards = {
				XP = 4000,
				AP = 60
			},
			Interval = 99,
			Max = 11,
			Index = 32
		},
		
		["HL2_Warden"] ={
			Name = "Ach_HL2_WardenF_N",
			Mat = "vgui/achievements/hl2_beat_turretstandoff2.jpg", 
			Desc = "Ach_HL2_WardenF_D",
			Rewards = {
				XP = 1200,
				AP = 25
			},
			Index = 33
		},

------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_RadTunnel"] ={
			Name = "Ach_HL2_Radiation_N",
			Mat = "vgui/achievements/hl2_beat_toxictunnel.jpg", 
			Desc = "Ach_HL2_Radiation_D",
			Rewards = {
				XP = 200,
				AP = 5
			},
			Index = 40
		},
		
		["HL2_FollowFree"] ={
			Name = "Ach_HL2_FollowF_N",
			Mat = "vgui/achievements/hl2_followfreeman.jpg", 
			Desc = "Ach_HL2_FollowF_D",
			Rewards = {
				XP = 4000,
				AP = 80
			},
			Interval = 99,
			Max = 16,
			Index = 45
		},
		
		["HL2_BarneyWish"] ={
			Name = "Ach_HL2_BWish_N",
			Mat = "vgui/achievements/hl2_beat_game.jpg", 
			Desc = "Ach_HL2_BWish_D",
			Rewards = {
				XP = 200,
				AP = 10
			},
			Secret = true,
			Index = 46
		},
		
		["HL2_BeatHL2"] ={
			Name = "Ach_HL2_BeatGame_N",
			Mat = "vgui/achievements/hl2_beat_game.jpg", 
			Desc = "Ach_HL2_BeatGame_D",
			Rewards = {
				XP = 10000,
				AP = 200
			},
			Interval = 99,
			Max = 69,
			Index = 50
		},

------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_Lambda"] ={
			Name = "Ach_HL2_Lambda_N",
			Mat = "vgui/achievements/hl2_find_alllambdas.png", 
			Desc = "Ach_HL2_Lambda_D",
			Rewards = {
				XP = 15000,
				AP = 100
			},
			Max = 45,
			Index = 99
		},

	}	
}

HL2C_Ach:AddAchievementSet("HL2",achgroup)