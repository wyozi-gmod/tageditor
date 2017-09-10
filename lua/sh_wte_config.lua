
-- Use ULX rank as the default tag if no custom tag was found
wyozite.MakeRanksDefaultTags = true

-- Dont show any tag for normal users. Helps people pick out people with power from the scoreboard
wyozite.DontShowUserRank = true

-- Disables right clicking scoreboard menu. This makes ulx commands the only way to set tags.
wyozite.DontUseContextMenu = false

-- The column title/header for tags
wyozite.TagColumnName = "Tag"

-- How wide the tag column should be. Won't have any effect until future TTT update
wyozite.TagColumnWidth = 150

-- Tag column index. Don't change if you don't know what it does.
wyozite.TagColumnIndex = 5

-- If ranks are used as tags, we can set custom rank colors here. Rank colors can also have glow, see "superadmin" for an example of that.
wyozite.RankColors = {
	superadmin = {Color(108, 108, 252), Color(255, 255, 255)},
	admin = Color(252, 104, 104),
	operator = Color(180, 104, 252)
}

-- By default the first character in rank name is uppercased (for display).
-- If you want to add other kinds of replacements, you can here.
wyozite.RankReplacements = {
	["vip"] = "VIP",
	["vipplus"] = "VIP Plus"
}