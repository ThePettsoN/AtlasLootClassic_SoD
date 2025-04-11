-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
	local d = C_Map.GetAreaInfo(id)
	return d or "GetAreaInfo"..id
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, 0)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local SOD_DIFF = data:AddDifficulty("SoD")
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH")
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH")

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local SOD_CONTENT = data:AddContentType(AL["SoD Exclusives"], ATLASLOOT_RAID20_COLOR)
local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
--local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local CLASSIC_CONTENT = data:AddContentType(AL["Classic"], ATLASLOOT_RAID40_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_PVP_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)


-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

data["SoD Collections"] = {
	name = AL["Tier & Sets"],
	ContentType = SOD_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{
			name = AL["Level 60 Tier 4"],
			[NORMAL_DIFF] = {
				-- Druid
				{ 1, 1945 },
				{ 2, 1946 },
				{ 3, 1947 },
				{ 4, 1948 },

				-- Hunter
				{ 6, 1936 },
				{ 7, 1937 },

				-- Mage
				{ 9,  1943 },
				{ 10, 1944 },

				-- Shaman
				{ 12, 1952 },
				{ 13, 1950 },
				{ 14, 1951 },
				{ 15, 1949 },

				-- Paladin
				{ 16, 1940 },
				{ 17, 1941 },
				{ 18, 1942 },

				-- Priest
				{ 20, 1938 },
				{ 21, 1939 },

				-- Rogue
				{ 23, 1934 },
				{ 24, 1935 },

				-- Warlock
				{ 26, 1953 },
				{ 27, 1954 },

				-- Warrior
				{ 29, 1932 },
				{ 30, 1933 },
			},
		},
		{
			name = AL["Phase 8 Non-Tier sets"],
			[NORMAL_DIFF] = {
				{ 1, 1955 }, -- Fallen Regality
				{ 2, 1956 }, -- Tools of the Nathrezim
			},
		},
		{
			name = AL["Level 60 Tier 3"],
			[NORMAL_DIFF] = {
				{ 1, 1904 }, --Balance
				{ 2, 1903 }, --Feral
				{ 3, 1901 }, --Tank
				{ 4, 1902 }, --Resto

				{ 6, 1899 }, --Ranged Hunter
				{ 7, 1900 }, --Melee Hunter

				{ 9, 1898 }, --Damage Mage
				{ 10, 1897 }, --Healer Mage

				{ 12, 1887 }, -- Healer Sham
				{ 13, 1889 }, -- Ele Sham
				{ 14, 1886 }, -- Tank Sham
				{ 15, 1888 }, -- Melee Sham

				{ 16, 1895 }, -- Holy Pally
				{ 17, 1894 }, -- Tank Pally
				{ 18, 1896 }, -- Ret Pally

				{ 20, 1892 }, -- Healer Priest
				{ 21, 1893 }, -- DPS Priest

				{ 23, 1891 }, -- DPS Rogue
				{ 24, 1890 }, -- Tank Rogue

				{ 26, 1885 }, -- DPS Lock
				{ 27, 1884 }, -- Tank Lock

				{ 29, 1882 }, -- Tank Warr
				{ 30, 1883 }, -- Dps Warr
			},
		},
		{
			name = AL["Level 60 Tier 2.5"],
			[NORMAL_DIFF] = {
				{ 1, 1835 }, --Balance
				{ 2, 1836 }, --Feral
				{ 3, 1837 }, --Tank
				{ 4, 1838 }, --Resto
				{ 6, 1839 }, --Ranged Hunter
				{ 7, 1840 }, --Melee Hunter
				{ 9, 1841 }, --Damage Mage
				{ 10, 1842 }, --Healer Mage
				{ 12, 1850 }, -- Healer Sham
				{ 13, 1851 }, -- Ele Sham
				{ 14, 1852 }, -- Tank Sham
				{ 15, 1853 }, -- Melee Sham
				{ 16, 1843 }, -- Holy Pally
				{ 17, 1844 }, -- Tank Pally
				{ 18, 1845 }, -- Ret Pally
				{ 20, 1846 }, -- Healer Priest
				{ 21, 1847 }, -- DPS Priest
				{ 23, 1848 }, -- DPS Rogue
				{ 24, 1849 }, -- Tank Rogue
				{ 26, 1854 }, -- DPS Lock
				{ 27, 1855 }, -- Tank Lock
				{ 29, 1856 }, -- Tank Warr
				{ 30, 1857 }, -- Dps Warr
			},
		},
		{
			name = AL["Level 60 Tier 2"],
			[NORMAL_DIFF] = {
				{ 1, 1801 }, --Balance
				{ 2, 1803 }, --Feral
				{ 3, 1804 }, --Tank
				{ 4, 1802 }, --Resto
				{ 6, 1805 }, --Ranged Hunter
				{ 7, 1806 }, --Melee Hunter
				{ 9, 1807 }, --Damage Mage
				{ 10, 1808 }, --Healer Mage
				{ 12, 1816 }, -- Healer Sham
				{ 13, 1818 }, -- Melee Sham
				{ 14, 1817 }, -- Ranged Sham
				{ 15, 1819 }, -- Tank Sham
				{ 16, 1809 }, -- Holy Pally
				{ 17, 1810 }, -- Ret Pally
				{ 18, 1811 }, -- Tank Pally -
				{ 20, 1812 }, -- Healer Priest
				{ 21, 1813 }, -- DPS Priest -
				{ 23, 1814 }, -- DPS Rogue
				{ 24, 1815 }, -- Tank Rogue -
				{ 26, 1820 }, -- DPS Lock
				{ 27, 1821 }, -- Tank Lock
				{ 29, 1822 }, -- Tank Warr
				{ 30, 1823 }, -- Dps Warr
			},
		},
		{
			name = AL["Level 60 Tier 1"],
			[NORMAL_DIFF] = {
				{ 1, 1698 }, --Balance
				{ 2, 1699 }, --Feral
				{ 3, 1701 }, --Tank
				{ 4, 1700 }, --Resto
				{ 6, 1702 }, --Ranged Hunter
				{ 7, 1703 }, --Melee Hunter
				{ 9, 1704 }, --Damage Mage
				{ 10, 1705 }, --Healer Mage
				{ 12, 1713 }, -- Healer Sham
				{ 13, 1715 }, -- Melee Sham
				{ 14, 1714 }, -- Ranged Sham
				{ 15, 1716 }, -- Tank Sham
				{ 16, 1706 }, -- Holy Pally
				{ 17, 1707 }, -- Ret Pally
				{ 18, 1708 }, -- Tank Pally
				{ 20, 1709 }, -- Healer Priest
				{ 21, 1710 }, -- DPS Priest
				{ 23, 1711 }, -- DPS Rogue
				{ 24, 1712 }, -- Tank Rogue
				{ 26, 1717 }, -- DPS Lock
				{ 27, 1718 }, -- Tank Lock
				{ 29, 1719 }, -- Tank Warr
				{ 30, 1720 }, -- Dps Warr
			},
		},
		{
			name = AL["Ahn'Qiraj Ruins Sets"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Mage"], nil },
				{ 2, 1860 },
				{ 4, "INV_Box_01", nil, AL["Priest"], nil },
				{ 5, 1862 },
				{ 7, "INV_Box_01", nil, AL["Warlock"], nil },
				{ 8, 1865 },
				{ 10, "INV_Box_01", nil, AL["Druid"], nil },
				{ 11, 1858 },
				{ 13, "INV_Box_01", nil, AL["Rogue"], nil },
				{ 14, 1863 },
				{ 16, "INV_Box_01", nil, AL["Hunter"], nil },
				{ 17, 1859 },
				{ 19, "INV_Box_01", nil, AL["Shaman"], nil },
				{ 20, 1864 },
				{ 22, "INV_Box_01", nil, AL["Paladin"], nil },
				{ 23, 1861 },
				{ 25, "INV_Box_01", nil, AL["Warrior"], nil },
				{ 26, 1866 },

			},
		},
		{
			name = AL["Zul-Gurub Sets"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Druid"], nil },
				{ 2, 1824 },
				{ 4, "INV_Box_01", nil, AL["Hunter"], nil },
				{ 5, 1825 },
				{ 7, "INV_Box_01", nil, AL["Mage"], nil },
				{ 8, 1826 },
				{ 10, "INV_Box_01", nil, AL["Paladin"], nil },
				{ 11, 1827 },
				{ 15, "INV_Box_01", nil, AL["*Click sets for details*"], nil },
				{ 16, "INV_Box_01", nil, AL["Priest"], nil },
				{ 17, 1828 },
				{ 19, "INV_Box_01", nil, AL["Rogue"], nil },
				{ 20, 1829 },
				{ 22, "INV_Box_01", nil, AL["Shaman"], nil },
				{ 23, 1830 },
				{ 25, "INV_Box_01", nil, AL["Warlock"], nil },
				{ 26, 1831 },
				{ 28, "INV_Box_01", nil, AL["Warrior"], nil },
				{ 29, 1832 },
			},
		},
		{
			name = AL["Level 60 Dungeon Set 0.5"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Druid"], nil },
				{ 2, 1667 },
				{ 4, "INV_Box_01", nil, AL["Hunter"], nil },
				{ 5, 1669 },
				{ 7, "INV_Box_01", nil, AL["Mage"], nil },
				{ 8, 1671 },
				{ 10, "INV_Box_01", nil, AL["Paladin"], nil },
				{ 11, 1673 },
				{ 15, "INV_Box_01", nil, AL["*Click sets for details*"], nil },
				{ 16, "INV_Box_01", nil, AL["Priest"], nil },
				{ 17, 1675 },
				{ 19, "INV_Box_01", nil, AL["Rogue"], nil },
				{ 20, 1676 },
				{ 22, "INV_Box_01", nil, AL["Shaman"], nil },
				{ 23, 1679 },
				{ 25, "INV_Box_01", nil, AL["Warlock"], nil },
				{ 26, 1681 },
				{ 28, "INV_Box_01", nil, AL["Warrior"], nil },
				{ 29, 1778 },
			},
		},
		{
			name = AL["Level 60 Dungeon Set 0"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Druid"], nil },
				{ 2, 1666 },
				{ 4, "INV_Box_01", nil, AL["Hunter"], nil },
				{ 5, 1668 },
				{ 7, "INV_Box_01", nil, AL["Mage"], nil },
				{ 8, 1670 },
				{ 10, "INV_Box_01", nil, AL["Paladin"], nil },
				{ 11, 1672 },
				{ 16, "INV_Box_01", nil, AL["Priest"], nil },
				{ 17, 1674 },
				{ 19, "INV_Box_01", nil, AL["Rogue"], nil },
				{ 20, 1677 },
				{ 22, "INV_Box_01", nil, AL["Shaman"], nil },
				{ 23, 1678 },
				{ 25, "INV_Box_01", nil, AL["Warlock"], nil },
				{ 26, 1680 },
				{ 28, "INV_Box_01", nil, AL["Warrior"], nil },
				{ 29, 1682 },
			},
		},
		{
			name = AL["Level 50 Emerald Sets"],
			[NORMAL_DIFF] = {
				{ 1, 1652 },
				{ 2, 1653 },
				{ 4, 1654 },
				{ 5, 1655 },
				{ 6, 1656 },
				{ 8, 1657 },
				{ 9, 1658 },
				{ 10, 1659 },
				{ 12, 1660 },
				{ 13, 1661 },
			},
		},
		{
			name = AL["Level 50 Raid"],
			[NORMAL_DIFF] = {
				{ 1, 1637 },
				{ 2, 1638 },
				{ 3, 1639 },
				{ 5, 1640 },
				{ 6, 1641 },
				{ 7, 1642 },
				{ 8, 1643 },
				{ 10, 1644 },
				{ 11, 1645 },
				{ 12, 1646 },
				{ 13, 1647 },
				{ 16, 1648 },
				{ 17, 1649 },
				{ 18, 1650 },
			},
		},
		{
			name = AL["Level 40 Raid"],
			[NORMAL_DIFF] = {
				{ 1, 1584 },
				{ 2, 1587 },
				{ 3, 1588 },
				{ 5, 1585 },
				{ 6, 1586 },
				{ 8, 1590 },
				{ 9, 1591 },
				{ 11, 1589 },
				{ 12, 1592 },
			},
		},
		{
			name = AL["Level 25 Raid"],
			[NORMAL_DIFF] = {
				{ 1, 1570 }, -- Twilight Invoker's Vestments
				{ 3, 1578 }, --
				{ 4, 1579 }, --
				{ 6, 1577 }, --
			},
		},
	},
}

data["SoD Currency"] = {
	name = AL["Currency Rewards"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Tarnished Undermine Real Rewards"],
			[NORMAL_DIFF] = {
				{ 1, 231814 }, -- Chromatic Heart
				{ 2, 231882 }, -- Suppression Device Receipt
				{ 3, 230904 }, -- Scroll: SEENECS FO RIEF
				{ 4, 231452 }, -- Blood of the Lightbringer
				{ 5, 229906 }, -- Tarnished Bronze Scale
				{ 6, 229352 }, -- Intelligence Findings
				{ 7, 231995 }, -- Hardened Elementium Slag
				{ 8, 231722 }, -- Depleted Scythe of Chaos
				{ 9, 231378 }, -- Shimmering Golden Disk

				{ 11, 231707 }, -- Draconian Bindings
				{ 12, 231708 }, -- Draconian Belt
				{ 13, 231712 }, -- Draconian Gloves
				{ 14, 231713 }, -- Draconian Boots

				{ 16, 231715 }, -- Primeval Bindings
				{ 17, 231716 }, -- Primeval Belt
				{ 18, 231720 }, -- Primeval Gloves
				{ 19, 231721 }, -- Primeval Boots

				{ 21, 231724 }, -- Ancient Bindings
				{ 22, 231725 }, -- Ancient Belt
				{ 23, 231729 }, -- Ancient Gloves
				{ 24, 231730 }, -- Ancient Boots

				{ 29, "INV_Box_01", nil, AL["Continued -->"], nil },

				{ 101, 232390 }, -- Idol of Celestial Focus
				{ 102, 232391 }, -- Idol of Feline Focus
				{ 103, 232423 }, -- Idol of Nurture
				{ 104, 232424 }, -- Idol of Cruelty

				{ 106, 231811 }, -- Libram of Awe
				{ 107, 232389 }, -- Libram of Plenty
				{ 108, 232420 }, -- Libram of Wrath
				{ 109, 232421 }, -- Libram of Avenging

				{ 111, 232392 }, -- Totem of Relentless Thunder
				{ 112, 232409 }, -- Totem of the Elements
				{ 113, 232416 }, -- Totem of Astral Flow
				{ 114, 232419 }, -- Totem of Conductive Elements

				{ 116, 227532 }, -- Incandescent Hood
				{ 117, 227534 }, -- Incandescent Leggings
				{ 118, 227535 }, -- Incandescent Robe
				{ 119, 227537 }, -- Incandescent Shoulderpads
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227530 }, -- Incandescent Belt
				{ 122, 227531 }, -- Incandescent Bindings
				{ 123, 227533 }, -- Incandescent Gloves

				{ 130, "INV_Box_01", nil, AL["Continued -->"], nil },

				{ 201, 227755 }, -- Molten Scaled Helm
				{ 202, 227754 }, -- Molten Scaled Leggings
				{ 203, 227758 }, -- Molten Scaled Chest
				{ 204, 227752 }, -- Molten Scaled Boots
				{ 205, 227757 }, -- Molten Scaled Shoulderpads
				{ 206, 227751 }, -- Molten Scaled Belt
				{ 207, 227750 }, -- Molten Scaled Bindings
				{ 208, 227756 }, -- Molten Scaled Gloves

				{ 210, 227764 }, -- Scorched Core Helm
				{ 211, 227763 }, -- Scorched Core Leggings
				{ 212, 227766 }, -- Scorched Core Chest
				{ 213, 227762 }, -- Scorched Core Shoulderpads
				{ 214, 227765 }, -- Scorched Core Boots
				{ 215, 227761 }, -- Scorched Core Belt
				{ 216, 227760 }, -- Scorched Core Bindings
				{ 217, 227759 }, -- Scorched Core Gloves

				{ 219, 227284 }, -- Band of the Beast 50
				{ 220, 227279 }, -- Loop of the Magister 50
				{ 221, 227280 }, -- Craft of the Shadows 50
				{ 222, 227282 }, -- Ring of the Dreaded Mist 50
				{ 223, 228432 }, -- Whistle of the Beast 50
				{ 224, 228168 }, -- Goblin Gear Grinder 50
				{ 225, 228169 }, -- The Attitude Adjustor 50
				{ 226, 228170 }, -- Makeshift South Sea Oar 50
				{ 227, 228185 }, -- Broken Bottle of Goblino Noir 50
				{ 228, 228184 }, -- Goblin Clothesline 25

				{ 230, "INV_Box_01", nil, AL["Continued -->"], nil },

				{ 301, 228186 }, -- Abandoned Wedding Band 25
				{ 302, 228187 }, -- Stick of the South Sea 50

				{ 304, 227990 }, -- Hand of Injustice 50
				{ 305, 228171 }, -- Kezan Cash Carrier 25

				{ 307, 220597 }, -- Drakestone of the Dream Harbinger
				{ 308, 220598 }, -- Drakestone of the Nightmare Harbinger
				{ 309, 220599 }, -- Drakestone of the Blood Prophet

				{ 311, 228173 }, -- Libram of the Consecrated 15
				{ 312, 228174 }, -- Libram of the Devoted 15
				{ 313, 228175 }, -- Libram of Holy Alacrity 15

				{ 316, 228176 }, -- Totem of Thunder 15
				{ 317, 228177 }, -- Totem of Raging Fire 15
				{ 318, 228178 }, -- Totem of Earthen Vitality 15
				{ 319, 228179 }, -- Totem of the Plains 15

				{ 321, 228180 }, -- Idol of the Swarm 15
				{ 322, 228181 }, -- Idol of Exsanguination (Cat) 15
				{ 323, 228182 }, -- Idol of Exsanguination (Bear) 15
				{ 324, 228183 }, -- Idol of the Grove 15

				{ 326, "INV_Box_01", nil, AL["Dungeon Sets:"], nil },
				{ 327, "INV_Box_01", nil, AL["Bracers: 15 Reals"], nil },
				{ 328, "INV_Box_01", nil, AL["Boots, Gloves: 25 Reals"], nil },
				{ 329, "INV_Box_01", nil, AL["Shoulders, Belt: 25 Reals"], nil },
				{ 330, "INV_Box_01", nil, AL["Helm, Chest, Legs: 50 Reals"], nil },
			},
		},
		{
			name = AL["Trade Goods"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 7"], nil },
				{ 2, 237386 }, -- Wartorn Undermine Supply Crate
				{ 3, 236414 }, -- Damaged Undermine Supply Crate Phase 7

				{ 16, 17011 }, -- Lava Core 15
				{ 17, 17010 }, -- Fiery Core 15
				{ 18, 17012 }, -- Core Leather 10
			},

		},
		{
			name = AL["Recipes"],
			[NORMAL_DIFF] = {
				{ 1, 228121 }, -- Pattern: Leather-Reinforced Runecloth Bag 50
				{ 2, 13518 }, -- Recipe: Flask of Petrification 50
				{ 3, 13519 }, -- Recipe: Flask of the Titans 50
				{ 4, 13520 }, -- Recipe: Flask of Distilled Wisdom 50
				{ 5, 13521 }, -- Recipe: Flask of Supreme Power 50
				{ 6, 13522 }, -- Recipe: Flask of Chromatic Resistance 50
			},
		},
		{
			name = AL["Toys"],
			[NORMAL_DIFF] = {
				-- Phase 7
				{ 1, "INV_Box_01", nil, AL["Phase 7"], nil },
				{ 2, 236657 }, -- Bubbles' Rotting Branch
				{ 3, 236658 }, -- Bubbles' Spine Trophy
				{ 4, 236660 }, -- Bubbles' Troll Tusk
				{ 5, 236661 }, -- Bubbles' Ribcage of Ribaldy

				-- Phase 6
				{ 7, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 8, 234143 }, -- Globe of Deception
				{ 9, 234144 }, -- Censer of the False Prophet
				{ 10, 234447 }, -- Bubbles' Rod of Transformation
				{ 11, 234467 }, -- Bubbles' Rod of Dragons
				{ 12, 234464 }, -- Bubbles' Rod of Bubbles
				{ 13, 234142 }, -- Bottomless Noggenfogger Elixir

				{ 16, "INV_Box_01", nil, AL["Phase 5-2"], nil },
				-- Phase 5
				{ 17, 231996 }, -- Supercharged Gobmogrifier
				-- Phase 4
				{ 18, 228189 }, -- Gift of Gob 25
				-- Phase 3
				{ 19, 220619 }, -- Atal'ai Blood Ceremony
				{ 20, 220635 }, -- Atal'alarion's Enchanted Boulder
				{ 21, 220638 }, -- Unorthodox Hex Stick
				{ 22, 220639 }, -- Lledra's Inanimator
				{ 23, 221484 }, -- Witch Doctor's Hex Stick
				{ 24, 223160 }, -- Bargain Bush
				{ 25, 223161 }, -- Empty Supply Crate
				-- Phase 2
				{ 26, 215437 }, -- Trogg Transfigurator 3000
				{ 27, 215449 }, -- World Shrinker
				{ 28, 216494 }, -- Aragriar's Whimsical World Warper
				{ 29, 216608 }, -- Radiant Ray Reflectors

			},
		},
		{
			name = AL["Wild Offering Rewards"],
			[NORMAL_DIFF] = {
				{ 1, 223194 }, -- Band of the Wilds
				{ 2, 223195 }, -- Breadth of the Beast
				{ 3, 223197 }, -- Defender of the Wilds
				{ 4, 223192 }, -- Cord of the Untamed
				{ 5, 223193 }, -- Crown of the Dreamweaver
				{ 6, 223196 }, -- Godslayer's Greaves
				{ 7, 221491 }, -- Shadowtooth Bag
			},
		},
		{
			name = AL["Firelands Embers"],
			[NORMAL_DIFF] = {
				{ 1, 7076 }, -- Essence of Earth
				{ 2, 7080 }, -- Essence of Water
				{ 3, 7082 }, -- Essence of Air
				{ 4, 7078 }, -- Essence of Fire
				{ 5, 11382 }, -- Blood of the Mountain
			},
		},
		{
			name = AL["Runes"],
			[NORMAL_DIFF] = {
				{ 1, 232454 }, -- Emblem of the Wild Gods
				{ 2, 232455 }, -- Emblem of Dishonor
				{ 3, 232456 }, -- Emblem of the Violet Eye
				{ 4, 232457 }, -- Emblem of the Worldcore
			},
		},
	},
}

data["SoD Shoulder Enchants"] = {
	name = AL["Shoulder Tier Enchants"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Druid
			name = AL["Druid"],
			[NORMAL_DIFF] = {
				{ 1,   236589 },
				{ 2,   236590 },
				{ 3,   236591 },
				{ 4,   236592 },
				{ 5,   236593 },
				{ 6,   236594 },
				{ 7,   236595 },
				{ 8,   236596 },
				{ 9,   236597 },
				{ 16,  236598 },
				{ 17,  236599 },
				{ 18,  236600 },
				{ 19,  236601 },
				{ 20,  236602 },
				{ 21,  236603 },
				{ 22,  236604 },
				{ 23,  236605 },
				{ 24,  236606 },
				{ 101, 236607 },
				{ 102, 236608 },
				{ 103, 236609 },
				{ 104, 236610 },
				{ 105, 236611 },
				{ 106, 236612 },
				{ 107, 236613 },
				{ 108, 236614 },
				{ 109, 236615 },
				{ 116, 236616 },
				{ 117, 236617 },
				{ 118, 236618 },
				{ 119, 236619 },
				{ 120, 236620 },
				{ 121, 236621 },
				{ 122, 236622 },
				{ 123, 236623 },
			},
		},
		{ -- Hunter
			name = AL["Hunter"],
			[NORMAL_DIFF] = {
				{ 1,  236474 },
				{ 2,  236475 },
				{ 3,  236476 },
				{ 4,  236477 },
				{ 5,  236478 },
				{ 6,  236479 },
				{ 7,  236480 },
				{ 8,  236481 },
				{ 9,  236482 },
				{ 10, 236483 },
				{ 16, 236484 },
				{ 17, 236485 },
				{ 18, 236487 },
				{ 19, 236488 },
				{ 20, 236489 },
				{ 21, 236490 },
				{ 22, 236491 },
				{ 23, 236492 },
			},
		},
		{ -- Mage
			name = AL["Mage"],
			[NORMAL_DIFF] = {
				{ 1,  236511 },
				{ 2,  236512 },
				{ 3,  236513 },
				{ 4,  236514 },
				{ 5,  236515 },
				{ 6,  236516 },
				{ 7,  236517 },
				{ 8,  236518 },
				{ 9,  236519 },
				{ 10, 236520 },
				{ 16, 236521 },
				{ 17, 236522 },
				{ 18, 236523 },
				{ 19, 236524 },
				{ 20, 236525 },
				{ 21, 236526 },
				{ 22, 236527 },
				{ 23, 236528 },
				{ 24, 236529 },
			},
		},
		{ -- Paladin
			name = AL["Paladin"],
			[NORMAL_DIFF] = {
				{ 1,  236530 },
				{ 2,  236531 },
				{ 3,  236532 },
				{ 4,  236533 },
				{ 5,  236534 },
				{ 6,  236535 },
				{ 7,  236536 },
				{ 8,  236537 },
				{ 9,  236538 },
				{ 10, 236539 },
				{ 11, 236540 },
				{ 12, 236541 },
				{ 13, 236542 },

				{ 16, 236544 },
				{ 17, 236545 },
				{ 18, 236546 },
				{ 19, 236547 },
				{ 20, 236548 },
				{ 21, 236549 },
				{ 22, 236550 },
				{ 23, 236551 },
				{ 24, 236552 },
				{ 25, 236553 },
				{ 26, 236554 },
				{ 27, 236555 },
			},
		},
		{ -- Priest
			name = AL["Priest"],
			[NORMAL_DIFF] = {
				{ 1,  236493 },
				{ 2,  236494 },
				{ 3,  236495 },
				{ 4,  236496 },
				{ 5,  236497 },
				{ 6,  236498 },
				{ 7,  236499 },
				{ 8,  236500 },
				{ 9,  236501 },
				{ 10, 236502 },

				{ 16, 236503 },
				{ 17, 236504 },
				{ 18, 236505 },
				{ 19, 236506 },
				{ 20, 236507 },
				{ 21, 236508 },
				{ 22, 236509 },
				{ 23, 236510 },
			},
		},
		{ -- Rogue
			name = AL["Rogue"],
			[NORMAL_DIFF] = {
				{ 1, 236436 },
				{ 2, 236437 },
				{ 3, 236438 },
				{ 4, 236440 },
				{ 5, 236441 },
				{ 6, 236442 },
				{ 7, 236443 },
				{ 8, 236444 },
				{ 9, 236445 },
				{ 10, 236446 },

				{ 16, 236447 },
				{ 17, 236448 },
				{ 18, 236449 },
				{ 19, 236450 },
				{ 20, 236451 },
				{ 21, 236452 },
				{ 22, 236453 },
				{ 23, 236454 },
			},
		},
		{ -- Shaman
			name = AL["Shaman"],
			[NORMAL_DIFF] = {
				{ 1, 236556 },
				{ 2, 236557 },
				{ 3, 236558 },
				{ 4, 236559 },
				{ 5, 236560 },
				{ 6, 236561 },
				{ 7, 236562 },
				{ 8, 236563 },
				{ 9, 236564 },

				{ 16, 236565 },
				{ 17, 236566 },
				{ 18, 236567 },
				{ 19, 236568 },
				{ 20, 236569 },
				{ 21, 236570 },
				{ 22, 236571 },
				{ 23, 236572 },

				{ 101, 236573 },
				{ 102, 236574 },
				{ 103, 236575 },
				{ 104, 236576 },
				{ 105, 236577 },
				{ 106, 236578 },
				{ 107, 236579 },
				{ 108, 236580 },

				{ 116, 236581 },
				{ 117, 236582 },
				{ 118, 236583 },
				{ 119, 236584 },
				{ 120, 236585 },
				{ 121, 236586 },
				{ 122, 236587 },
				{ 123, 236588 },
			},
		},
		{ -- Warlock
			name = AL["Warlock"],
			[NORMAL_DIFF] = {
				{ 1, 236455 },
				{ 2, 236456 },
				{ 3, 236457 },
				{ 4, 236458 },
				{ 5, 236459 },
				{ 6, 236460 },
				{ 7, 236461 },
				{ 8, 236462 },
				{ 9, 236463 },
				{ 10, 236464 },

				{ 16, 236465 },
				{ 17, 236466 },
				{ 18, 236467 },
				{ 19, 236468 },
				{ 20, 236469 },
				{ 21, 236470 },
				{ 22, 236471 },
				{ 23, 236472 },
				{ 24, 236473 },
			},
		},
		{ -- Warrior
			name = AL["Warrior"],
			[NORMAL_DIFF] = {
				{ 1, 236417 },
				{ 2, 236418 },
				{ 3, 236419 },
				{ 4, 236420 },
				{ 5, 236421 },
				{ 6, 236422 },
				{ 7, 236423 },
				{ 8, 236424 },
				{ 9, 236425 },
				{ 10, 236426 },

				{ 16, 236427 },
				{ 17, 236428 },
				{ 18, 236429 },
				{ 19, 236430 },
				{ 20, 236431 },
				{ 21, 236432 },
				{ 22, 236433 },
				{ 23, 236434 },
				{ 24, 236435 },
			},
		},
	},
}

data["SoD DarkMoon Cards"] = {
	name = AL["Darkmoon Cards"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Darkmoon Cards"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Level 50"], nil },
				{ 2, 221272 }, -- Wilds Deck
				{ 3, 221280 }, -- Plagues Deck
				{ 4, 221289 }, -- Dunes Deck
				{ 5, 221299 }, -- Nightmares Deck
			},
		},
	},
}

data["SoD PvP"] = {
	name = AL["PvP"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- PVPWeapons
		name = AL["Level 60 Rank 14 Sets"],
		TableType = NORMAL_ITTYPE,
		[ALLIANCE_DIFF] = {
			{ 1, 234580 }, -- Grand Marshal's Handaxe
			{ 2, 234566 }, -- Grand Marshal's Sunderer
			{ 3, 234582 }, -- Grand Marshal's Dirk
			{ 4, 235479 }, -- Grand Marshal's Shiv
			{ 5, 234574 }, -- Grand Marshal's Mageblade
			{ 6, 234583 }, -- Grand Marshal's Right Hand Blade
			{ 7, 234584 }, -- Grand Marshal's Left Hand Blade
			{ 8, 234581 }, -- Grand Marshal's Punisher
			{ 9, 235481 }, -- Grand Marshal's Hacker
			{ 10, 235480 }, -- Grand Marshal's Bonecracker
			{ 11, 234576 }, -- Grand Marshal's Warhammer
			{ 12, 234568 }, -- Grand Marshal's Demolisher
			{ 13, 234567 }, -- Grand Marshal's Battle Hammer
			{ 14, 234578 }, -- Grand Marshal's Longsword
			{ 15, 234579 }, -- Grand Marshal's Swiftblade
			{ 16, 234565 }, -- Grand Marshal's Claymore
			{ 17, 234569 }, -- Grand Marshal's Glaive
			{ 18, 234570 }, -- Grand Marshal's Polearm
			{ 19, 234571 }, -- Grand Marshal's Stave
			{ 20, 234585 }, -- Grand Marshal's Bullseye
			{ 21, 234586 }, -- Grand Marshal's Repeater
			{ 22, 234587 }, -- Grand Marshal's Hand Cannon
			{ 23, 234588 }, -- Grand Marshal's Aegis
			{ 24, 235473 }, -- Grand Marshal's Barricade
			{ 25, 234589 }, -- Grand Marshal's Tome of Power
			{ 26, 234590 }, -- Grand Marshal's Tome of Restoration
		},
		[HORDE_DIFF] = {
			{ 1, 234554 }, -- High Warlord's Cleaver
			{ 2, 234543 }, -- High Warlord's Battle Axe
			{ 3, 235476 }, -- High Warlord's Hacker
			{ 4, 234556 }, -- High Warlord's Razor
			{ 5, 235478 }, -- High Warlord's Razor
			{ 6, 234550 }, -- High Warlord's Spellblade
			{ 7, 234557 }, -- High Warlord's Right Claw
			{ 8, 234558 }, -- High Warlord's Left Claw
			{ 9, 234555 }, -- High Warlord's Bludgeon
			{ 10, 234551 }, -- High Warlord's Battle Mace
			{ 11, 235477 }, -- High Warlord's Bonecracker
			{ 12, 234546 }, -- High Warlord's Destroyer
			{ 13, 234545 }, -- High Warlord's Pulverizer
			{ 14, 234552 }, -- High Warlord's Blade
			{ 15, 234553 }, -- High Warlord's Quickblade
			{ 16, 234542 }, -- High Warlord's Greatsword
			{ 17, 234547 }, -- High Warlord's Pig Sticker
			{ 18, 234548 }, -- High Warlord's Pig Poker
			{ 19, 234549 }, -- High Warlord's War Staff
			{ 20, 234559 }, -- High Warlord's Recurve
			{ 21, 234560 }, -- High Warlord's Crossbow
			{ 22, 234561 }, -- High Warlord's Street Sweeper
			{ 23, 234562 }, -- High Warlord's Shield Wall
			{ 24, 235474 }, -- High Warlord's Barricade
			{ 25, 234563 }, -- High Warlord's Tome of Destruction
			{ 26, 234563 }, -- High Warlord's Tome of Mending
		},
	},
	{
		name = AL["Level 60 Rank 12 Sets"],
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Alliance"], nil },
			{ 2, 1740 }, --Mage
			{ 3, 1741 }, --Priest caster
			{ 4, 1742 }, --Priest healer
			{ 5, 1746 }, --Warlock
			{ 6, 1735 }, --Druid caster
			{ 7, 1736 }, --Druid healer
			{ 8, 1737 }, --Druid melee
			{ 9, 1743 }, -- Rogue
			{ 10, 1738 }, --Hunter melee
			{ 11, 1739 }, --Hunter ranged
			{ 12, 1747 }, --Warrior
			{ 13, 1745 }, --Paladin healer
			{ 14, 1744 }, --Paladin melee
			{ 16, "INV_Box_01", nil, AL["Horde"], nil },
			{ 17, 1727 }, --Mage
			{ 18, 1728 }, --Priest caster
			{ 19, 1729 }, --Priest healer
			{ 20, 1734 }, --Warlock
			{ 21, 1723 }, --Druid caster
			{ 22, 1724 }, --Druid healer
			{ 23, 1722 }, --Druid melee
			{ 24, 1730 }, --Rogue
			{ 25, 1726 }, --Hunter melee
			{ 26, 1725 }, --Hunter ranged
			{ 27, 1732 }, --Shaman caster
			{ 28, 1733 }, --Shaman healer
			{ 29, 1731 }, --Shaman melee
			{ 30, 1721 }, --Warrior
		},
	},
	{
		name = AL["Level 60 Rank 10 Sets"],
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Alliance"], nil },
			{ 2, 1767 }, --mage
			{ 3, 1768 }, --priest
			{ 4, 1769 }, --priest
			{ 5, 1774 }, --warlock
			{ 6, 1762 }, --Druid
			{ 7, 1763 }, --Druid
			{ 8, 1764 }, --Druid
			{ 9, 1770 }, -- Rogue
			{ 10, 1765 }, --Hunter
			{ 11, 1766 }, --Hunter
			{ 12, 1775 }, --Warr
			{ 13, 1776 }, --Paladin
			{ 14, 1777 }, --Paladin
			{ 16, "INV_Box_01", nil, AL["Horde"], nil },
			{ 17, 1753 }, --Mage
			{ 18, 1754 }, --priest
			{ 19, 1755 }, --priest
			{ 20, 1760 }, --Warlock
			{ 21, 1748 }, --Druid
			{ 22, 1749 }, --Druid
			{ 23, 1750 }, --Druid
			{ 24, 1756 }, --Rogue
			{ 25, 1751 }, --Hunter
			{ 26, 1752 }, --Hunter
			{ 27, 1757 }, --shaman
			{ 28, 1758 }, --Shaman
			{ 29, 1759 }, --Shaman
			{ 30, 1761 }, --Warrior
		},
	},
	{
		name = AL["Level 60 Blood Moon"],
		TableType = NORMAL_ITTYPE,
		[NORMAL_DIFF] = {
			{ 1, 235144 }, -- Satchel of Blood-Caked Copper Coins
			{ 2, 235145 }, -- Satchel of Blood-Caked Silver Coins
			{ 3, 234145 }, -- Blood-Caked Hakkari Bijou
			{ 5, 233728 }, -- Blood-Caked Insignia
			{ 7, 233740 }, -- Blood-Caked Shroud
			{ 8, 233739 }, -- Blood-Caked Drape
			{ 9, 233738 }, -- Blood-Caked Cape
			{ 10, 233737 }, -- Blood-Caked Cloak
			{ 12, 233736 }, -- Blood-Caked Band
			{ 13, 233735 }, -- Blood-Caked Loop
			{ 14, 233734 }, -- Blood-Caked Circle
			{ 15, 233733 }, -- Blood-Caked Ring
			{ 16, 233732 }, -- Blood-Caked Necklace
			{ 17, 233731 }, -- Blood-Caked Amulet
			{ 18, 233730 }, -- Blood-Caked Talisman
			{ 19, 233729 }, -- Blood-Caked Choker
			{ 21, 233781 }, -- Battle Hardened Satin Wrists
			{ 22, 233780 }, -- Battle Hardened Satin Bracers
			{ 23, 233783 }, -- Battle Hardened Satin Sash
			{ 24, 233786 }, -- Battle Hardened Satin Cinch
			{ 26, 234960 }, -- Reins of the Blood-Caked Tiger
			{ 27, 234961 }, -- Whistle of the Blood-Caked Raptor
		},
	},
	{
		name = AL["Level 50 Blood Moon"],
		TableType = NORMAL_ITTYPE,
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Druid"], nil },
			{ 2, 221447 }, -- Ritualist's Bloodmoon Grimoire
			{ 3, 221446 }, -- Ritualist's Hammer
			{ 4, 221448 }, -- Talisman of the Corrupted Grove
			{ 6, "INV_Box_01", nil, AL["Hunter"], nil },
			{ 7, 221451 }, -- Bloodthirst Crossbow
			{ 8, 221450 }, -- Gurubashi Pit Fighter's Bow
			{ 10, "INV_Box_01", nil, AL["Mage"], nil },
			{ 11, 221452 }, -- Bloodfocused Arcane Band
			{ 12, 221453 }, -- Band of Boiling Blood
			{ 13, 221454 }, -- Glacial Blood Band
			{ 16, "INV_Box_01", nil, AL["Paladin"], nil },
			{ 17, 221457 }, -- Libram of Draconic Destruction
			{ 18, 221455 }, -- Bloodlight Reverence
			{ 19, 221456 }, -- Eclipsed Sanguine Saber
			{ 20, 220173 }, -- Parasomnia
			{ 22, "INV_Box_01", nil, AL["Priest"], nil },
			{ 23, 221459 }, -- Seal of the Sacrificed
			{ 24, 221458 }, -- Shadowy Band of Victory
			{ 26, "INV_Box_01", nil, AL["Rogue"], nil },
			{ 27, 221460 }, -- Gurubashi Backstabber
			{ 28, 221462 }, -- Bloodied Sword of Speed
			{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
			{ 101, "INV_Box_01", nil, AL["Shaman"], nil },
			{ 102, 221464 }, -- Totem of Fiery Precision
			{ 103, 221463 }, -- Ancestral Voodoo Doll
			{ 104, 221465 }, -- Corrupted Smashbringer
			{ 106, "INV_Box_01", nil, AL["Warlock"], nil },
			{ 107, 221466 }, -- Loop of Burning Blood
			{ 108, 221467 }, -- Eye of the Bloodmoon
			{ 110, "INV_Box_01", nil, AL["Warrior"], nil },
			{ 111, 221469 }, -- Headhunter's Barbed Spear
			{ 112, 221468 }, -- Wall of Whispers
			{ 113, 220173 }, -- Parasomnia
		},
	},
	{
		name = AL["Level 40 Blood Moon"],
		TableType = NORMAL_ITTYPE,
		[NORMAL_DIFF] = {
			{ 1, 216621 }, -- Blooddrenched Drape
			{ 2, 216620 }, -- Bloodrot Cloak
			{ 3, 216623 }, -- Cape of Hemostasis
			{ 4, 216622 }, -- Coagulated Cloak
			{ 5, 216570 }, -- Reins of the Golden Sabercat
			{ 6, 216492 }, -- Whistle of the Mottled Blood Raptor
			{ 8, "INV_Box_01", nil, AL["Druid"], nil },
			{ 9, 216498 }, -- Enchanted Sanguine Grimoire
			{ 10, 216499 }, -- Bloodbark Crusher
			{ 11, 216500 }, -- Bloodbonded Grove Talisman
			{ 16, "INV_Box_01", nil, AL["Hunter"], nil },
			{ 17, 216513 }, -- Tigerblood Talisman
			{ 18, 216514 }, -- Sanguine Quiver
			{ 19, 216515 }, -- Sanguine Ammo Pouch
			{ 20, 216516 }, -- Bloodlash Bow
			{ 22, "INV_Box_01", nil, AL["Mage"], nil },
			{ 23, 216510 }, -- Blood Resonance Circle
			{ 24, 216511 }, -- Emberblood Seal
			{ 25, 216512 }, -- Loop of Chilled Veins
			{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
			{ 101, "INV_Box_01", nil, AL["Paladin"], nil },
			{ 102, 216504 }, -- Eclipsed Bloodlight Saber
			{ 103, 216505 }, -- Bloodlight Crusader's Radiance
			{ 104, 216506 }, -- Bloodlight Avenger's Edge
			{ 105, 216607 }, -- Bloodlight Offering
			{ 107, "INV_Box_01", nil, AL["Priest"], nil },
			{ 108, 216517 }, -- Sanguine Sanctuary
			{ 109, 216518 }, -- Blood Covenant Seal
			{ 110, 216519 }, -- Sanguine Shadow Band
			{ 112, "INV_Box_01", nil, AL["Rogue"], nil },
			{ 113, 216520 }, -- Bloodharvest Blade
			{ 114, 216521 }, -- Swift Sanguine Strikers
			{ 115, 216522 }, -- Blood Spattered Stiletto
			{ 116, "INV_Box_01", nil, AL["Shaman"], nil },
			{ 117, 216501 }, -- Bloodstorm Barrier
			{ 118, 216502 }, -- Bloodstorm War Totem
			{ 119, 216503 }, -- Bloodstorm Jewel
			{ 120, 216615 }, -- Ancestral Bloodstorm Beacon
			{ 122, "INV_Box_01", nil, AL["Warlock"], nil },
			{ 123, 216507 }, -- Umbral Bloodseal
			{ 124, 216508 }, -- Infernal Bloodcoil Band
			{ 125, 216509 }, -- Infernal Pact Essence
			{ 127, "INV_Box_01", nil, AL["Warrior"], nil },
			{ 128, 216495 }, -- Sanguine Crusher
			{ 129, 216496 }, -- Sanguine Skullcrusher
			{ 130, 216497 }, -- Exsanguinar
		},
	},
	{
		name = AL["Level 50 PvP Sets"],
		TableType = SET_ITTYPE,
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Horde"], nil },
			{ 2, 1618 }, --Blood Guard's Plate
			{ 4, 1624 },
			{ 5, 1623 },
			{ 6, 1622 },
			{ 7, 1625 },
			{ 9, 1627 },
			{ 10, 1631 },
			{ 11, 1629 },
			{ 13, 1633 },
			{ 14, 1635 },
			{ 16, "INV_Box_01", nil, AL["Alliance"], nil },
			{ 17, 1619 },
			{ 18, 1620 },
			{ 19, 1621 },
			{ 21, 1665 },
			{ 22, 1626 },
			{ 24, 1628 },
			{ 25, 1630 },
			{ 26, 1632 },
			{ 28, 1634 },
			{ 29, 1636 },
		},
	},
	{
		name = AL["Level 25 PvP Gear"],
		TableType = NORMAL_ITTYPE,
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Alliance"], nil },
			{ 2, "f890rep5" },
			{ 3,  211500 }, --Resilient Cloth Headband
			{ 4,  211857 }, --Resilient Leather Mask
			{ 5,  211856 }, --Resilient Mail Coif
			{ 6,  211498 }, --Trainee's Sentinel Nightsaber
			{ 8, "f890rep7" },
			{ 9,  212580 }, --Lorekeeper's Staff
			{ 10,  212581 }, --Outrunner's Bow
			{ 11,  212582 }, --Protector's Sword
			{ 12,  212583 }, --Sentinel's Blade
			{ 13,  213087 }, --Sergeant's Cloak
			{ 16, "INV_Box_01", nil, AL["Horde"], nil },
			{ 17, "f889rep5" },
			{ 18,  211500 }, --Resilient Cloth Headband
			{ 19,  211857 }, --Resilient Leather Mask
			{ 20,  211856 }, --Resilient Mail Coif
			{ 21,  211499 }, --Trainee's Outrider Wolf
			{ 23, "f889rep7" },
			{ 24,  212584 }, --Advisor's Gnarled Staff
			{ 25,  212585 }, --Outrider's Bow
			{ 26,  212586 }, --Legionnaire's Sword
			{ 27,  212587 }, --Scout's Blade
			{ 28,  213088 }, --Sergeant's Cloak
		},
	},
},
}

data["SoD Factions"] = {
	name = AL["Factions"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Argent Dawn"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Revered"], nil },
				{ 2, 227888 }, -- Argent Elite Shoulders
				{ 2,  19217 }, -- Pattern: Argent Shoulders
				{ 3, 227818 }, -- Glowing Mantle of the Dawn
				{ 3,  19329 }, -- Pattern: Golden Mantle of the Dawn
				{ 4, 227817 }, -- Radiant Gloves of the Dawn
				{ 4,  19205 }, -- Plans: Gloves of the Dawn
				{ 5, 227859 }, -- Shimmering Dawnbringer Shoulders
				{ 5, 12698 }, -- Plans: Dawnbringer Shoulders
				{ 7, 227819}, -- Blessed Flame Mantle of the Dawn
				{ 9, "INV_Box_01", nil, AL["Honored"], nil },
				{ 10,  227816 }, -- Argent Elite Boots
				{ 10,  19216 }, -- Pattern: Argent Boots
				{ 11,  227815 }, -- Fine Dawn Treaders
				{ 11,  19328 }, -- Pattern: Dawn Treaders
				{ 12,  227814 }, -- Radiant Girdle of the Dawn
				{ 12,  19203 }, -- Plans: Girdle of the Dawn
			},
		},
		{
			name = AL["Timbermaw Hold"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Revered"], nil },
				{ 2, 227808 }, -- Rugged Mantle of the Timbermaw
				{ 3, 227809 }, -- Studded Timbermaw Brawlers
				{ 4, 227810 }, -- Dense Timbermaw Boots
				{ 2, 19218 }, -- Pattern: Mantle of the Timbermaw
				{ 3, 19327 }, -- Pattern: Timbermaw Brawlers
				{ 4, 19204 }, -- Plans: Heavy Timbermaw Boots
				{ 6, "INV_Box_01", nil, AL["Honored"], nil },
				{ 7, 227807 }, -- Dense Timbermaw Belt
				{ 8, 227805 }, -- Ferocity of the Timbermaw
				{ 9, 228190 }, -- Knowledge of the Timbermaw
				{ 7, 19202 }, -- Plans: Heavy Timbermaw Belt
				{ 8, 19326 }, -- Pattern: Might of the Timbermaw
				{ 9, 19215 }, -- Pattern: Wisdom of the Timbermaw
				{ 11, "INV_Box_01", nil, AL["Friendly"], nil },
				{ 12,  227804 }, -- Dire Warbear Woolies
				{ 13,  227803 }, -- Dire Warbear Harness
				{ 14,  227862 }, -- Incandescent Mooncloth Boots
				{ 12,  15754 }, -- Pattern: Warbear Woolies
				{ 13,  15742 }, -- Pattern: Warbear Harness
				{ 14,  15802 }, -- Mooncloth Boots
			},
		},
		{
			name = AL["Thorium Brotherhood"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Exalted"], nil },
				{ 2, 227842 }, -- Ebon Fist
				{ 3, 227840 }, -- Implacable Blackguard
				{ 2,  19210 }, -- Plans: Ebon Hand
				{ 3,  19211 }, -- Plans: Blackguard
				--{ 19, 227843 }, -- Reaving Nightfall (removed?)
				{ 4, 228929 }, -- Tempered Dark Iron Boots
				{ 5, 228924 }, -- Tempered Dark Iron Boots
				{ 6, 228927 }, -- Tempered Dark Iron Boots
				{ 7, 228926 }, -- Tempered Dark Iron Boots
				{ 8, 228925 }, -- Tempered Dark Iron Boots
				{ 9, 228928 }, -- Tempered Dark Iron Boots
				{ 4,  20040 }, -- Plans: Dark Iron Boots
				{ 5,  20040 }, -- Plans: Dark Iron Boots
				{ 6,  20040 }, -- Plans: Dark Iron Boots
				{ 7,  20040 }, -- Plans: Dark Iron Boots
				{ 8,  20040 }, -- Plans: Dark Iron Boots
				{ 9,  20040 }, -- Plans: Dark Iron Boots
				{ 11, "INV_Box_01", nil, AL["Revered"], nil },
				{ 12, 227839 }, -- Fine Flarecore Leggings
				{ 13, 227837 }, -- Thick Corehound Belt
				{ 14, 227834 }, -- Molten Chain Shoulders
				{ 15, 227838 }, -- Shining Chromatic Gauntlets
				{ 16, "INV_Box_01", nil, AL["Revered (Cont.)"], nil },
				{ 17, 227835 }, -- Tempered Dark Iron Gauntlets
				{ 18, 227836 }, -- Tempered Dark Iron Leggings
				{ 19, 227832 }, -- Tempered Black Amnesty
				{ 20, 227833 }, -- Glaive of Obsidian Fury
				{ 12,  19220 }, -- Pattern: Flarecore Leggings
				{ 13,  19332 }, -- Pattern: Corehound Belt
				{ 14,  17053 }, -- Plans: Fiery Chain Shoulders
				{ 15,  19331 }, -- Pattern: Chromatic Gauntlets
				{ 17,  19207 }, -- Plans: Dark Iron Gauntlets
				{ 18,  17052 }, -- Plans: Dark Iron Leggings
				{ 19,  19208 }, -- Plans: Black Amnesty
				{ 20,  19209 }, -- Plans: Blackfury
				{ 22, "INV_Box_01", nil, AL["Honored"], nil },
				{ 23, 227830 }, -- Fine Flarecore Mantle
				{ 24, 227831 }, -- Fine Flarecore Robe
				{ 25, 227828 }, -- Lavawalker Belt
				{ 26, 227827 }, -- Molten Chain Girdle
				{ 27, 227829 }, -- Hardened Black Dragonscale Boots
				{ 28, 227824 }, -- Tempered Dark Iron Helm
				{ 29, 227826 }, -- Dark Iron Flame Reaver
				{ 23,  17017 }, -- Pattern: Flarecore Mantle
				{ 24,  19219 }, -- Pattern: Flarecore Robe
				{ 25,  19330 }, -- Pattern: Lava Belt
				{ 26,  17049 }, -- Plans: Fiery Chain Girdle
				{ 27,  17025 }, -- Pattern: Black Dragonscale Boots
				{ 28,  19206 }, -- Plans: Dark Iron Helm
				{ 29,  17059 }, -- Plans: Dark Iron Reaver
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, "INV_Box_01", nil, AL["Honored (Cont.)"], nil },
				{ 102, 227825 }, -- Molten Dark Iron Destroyer
				{ 102,  17060 }, -- Plans: Dark Iron Destroyer
				{ 104, "INV_Box_01", nil, AL["Friendly"], nil },
				{ 105, 227823 }, -- Fine Flarecore Gloves
				{ 106, 227821 }, -- Flamekissed Molten Helm
				{ 107, 227822 }, -- Thick Corehound Boots
				{ 108, 227820 }, -- Tempered Dark Iron Bracers
				{ 105,  17018 }, -- Pattern: Flarecore Gloves
				{ 106,  17023 }, -- Pattern: Molten Helm
				{ 107,  17022 }, -- Pattern: Corehound Boots
				{ 108,  17051 }, -- Plans: Dark Iron Bracers
			},
		},
		{
			name = AL["Hydraxian Waterlords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Exalted"], nil },
				{ 2, 227915}, -- Duke's Domain
				{ 3, 227927}, -- Oath of the Sea
				{ 5, "INV_Box_01", nil, AL["Revered"], nil },
				{ 6, 228979}, -- Enchanted Sigil: Flowing Waters
				{ 8, "INV_Box_01", nil, AL["Honored"], nil },
				{ 9, 227923}, -- Water Treads
				{ 10, 227926}, -- Hydraxian Coronation
			},
		},
		{
			name = AL["Emerald Wardens"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Exalted"], nil },
				{ 2, 221442 }, -- Roar of the Guardian
				{ 3, 220621 }, -- Nightmare Resonance Crystal
				{ 4, 221440 }, -- Roar of the Dream
				{ 5, 221443 }, -- Roar of the Grove
				{ 7, "INV_Box_01", nil, AL["Revered"], nil },
				{ 8, 221441 }, -- Warden of the Dream
				{ 9, 220649 }, -- Merithra's Inheritence
				{ 10, 221439 }, -- Armor of the Emerald Slumber
				{ 12, "INV_Box_01", nil, AL["Honored (Mail)"], nil },
				{ 13, 221391 }, --Emerald Scalemail Helmet
				{ 14, 221390 }, --Emerald Scalemail Breastplate
				{ 15, 221388 }, --Emerald Scalemail Leggings
				{ 17, 221402 }, --Emerald Chain Helmet
				{ 18, 221404 }, --Emerald Chain Breastplate
				{ 19, 221401 }, --Emerald Chain Leggings
				{ 20, 221397 }, --Emerald Laden Helmet
				{ 21, 221395 }, --Emerald Laden Breastplate
				{ 22, 221398 }, --Emerald Laden Leggings
				{ 24, "INV_Box_01", nil, AL["Honored (Plate)"], nil },
				{ 25, 221376 }, --Emerald Dream Helm
				{ 26, 221380 }, --Emerald Dream Breastplate
				{ 27, 221377 }, --Emerald Dream Legplates
				{ 28, 221384 }, --Emerald Encrusted Helmet
				{ 29, 221382 }, --Emerald Encrusted Battleplate
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, "INV_Box_01", nil, AL["Honored (Plate)Cont."], nil },
				{ 102, 221385 }, --Emerald Encrusted Legplates
				{ 104, "INV_Box_01", nil, AL["Honored (Cloth)"], nil },
				{ 105, 221425 }, --Emerald Enchanted Circlet
				{ 106, 221430 }, --Emerald Enchanted Robes
				{ 107, 221429 }, --Emerald Enchanted Pants
				{ 108, 221437 }, --Emerald Woven Circlet
				{ 109, 221434 }, --Emerald Woven Robes
				{ 110, 221435 }, --Emerald Woven Pants
				{ 112, "INV_Box_01", nil, AL["Honored (Leather)"], nil },
				{ 113, 221408 }, --Emerald Leather Helm
				{ 114, 221406 }, --Emerald Leather Vest
				{ 115, 221410 }, --Emerald Leather Pants
				{ 116, "INV_Box_01", nil, AL["Honored (Leather)Cont."], nil },
				{ 117, 221413 }, --Emerald Dreamkeeper Helm
				{ 118, 221417 }, --Emerald Dreamkeeper Chest
				{ 119, 221414 }, --Emerald Dreamkeeper Pants
				{ 120, 221422 }, --Emerald Watcher Helm
				{ 121, 221419 }, --Emerald Watcher Vest
				{ 122, 221423 }, --Emerald Watcher Leggings
				{ 124, "INV_Box_01", nil, AL["Honored"], nil },
				{ 125, 213407 }, -- Catnip
				{ 126, 221193 }, --Emerald Ring
				{ 127, 224006 }, --Emerald Ring
				{ 130, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 201, "INV_Box_01", nil, AL["Friendly (Mail)"], nil },
				{ 202, 221392 }, --Emerald Scalemail Shoudlers
				{ 203, 221389 }, --Emerald Scalemail Gauntlets
				{ 204, 221393 }, --Emerald Scalemail Boots
				{ 205, 221399 }, --Emerald Laden Shoulders
				{ 206, 221396 }, --Emerald Laden Gauntlets
				{ 207, 221394 }, --Emerald Laden Boots
				{ 208, 221400 }, --Emerald Chain Shoudlers
				{ 209, 221403 }, --Emerald Chain Gauntlets
				{ 210, 221405 }, --Emerald Chain Boots
				{ 212, "INV_Box_01", nil, AL["Friendly (Plate)"], nil },
				{ 213, 221386 }, --Emerald Encrusted Spaulders
				{ 214, 221383 }, --Emerald Encrusted Handguards
				{ 215, 221387 }, --Emerald Encrusted Plate Boots
				{ 216, "INV_Box_01", nil, AL["Friendly (Plate)Cont."], nil },
				{ 217, 221381 }, --Emerald Dream Pauldrons
				{ 218, 221378 }, --Emerald Dream Gauntlets
				{ 219, 221379 }, --Emerald Dream Sabatons
				{ 221, "INV_Box_01", nil, AL["Friendly (Cloth)"], nil },
				{ 222, 221431 }, --Emerald Enchanted Shoulders
				{ 223, 221427 }, --Emerald Enchanted Gloves
				{ 224, 221426 }, --Emerald Enchanted Boots
				{ 225, 221432 }, --Emerald Woven Mantle
				{ 226, 221436 }, --Emerald Woven Gloves
				{ 227, 221438 }, --Emerald Woven Boots
				{ 230, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 301, "INV_Box_01", nil, AL["Friendly (Leather)"], nil },
				{ 302, 221411 }, --Emerald Leather Shoulders
				{ 303, 221407 }, --Emerald Leather Gloves
				{ 304, 221409 }, --Emerald Leather Sabatons
				{ 305, 221416 }, --Emerald Dreamkeeper Shoulders
				{ 306, 221412 }, --Emerald Dreamkeeper Gloves
				{ 307, 221415 }, --Emerald Dreamkeeper Boots
				{ 308, 221424 }, --Emerald Watcher Shoulders
				{ 309, 221421 }, --Emerald Watcher Gloves
				{ 310, 221420 }, --Emerald Watcher Boots
				{ 312, "INV_Box_01", nil, AL["Friendly"], nil },
				{ 313, 221369 }, -- Nightmare Siphon
				{ 314, 221374 }, -- Anguish of the Dream
				{ 315, 221362 }, -- Weapon Cleaning Cloth
				{ 317, 223648 }, -- Dream Imbued Arrow
				{ 318, 224005 }, -- Emerald Ring
				{ 319, 224004 }, -- Emerald Ring
				{ 330, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 401, "INV_Box_01", nil, AL["Neutral"], nil },
				{ 402, 212568 }, -- Wolfshead Trophy
				{ 403, 223912 }, -- Purification Potion
				{ 404, 223913 }, -- Major Healing Potion
				{ 405, 223914 }, -- Greater Healing Potion
				{ 416, 221480 }, -- Spell Notes: Molten Armor
				{ 417, 221481 }, -- 	Nihilist Epiphany
				{ 418, 221482 }, -- 	Rune of Affliction
				{ 419, 221483 }, -- 	Rune of Burn
				{ 420, 221511 }, -- 	Rune of the Protector
				{ 421, 221512 }, -- 	Rune of Alacrity
				{ 422, 221515 }, -- 	Rune of Detonation
				{ 423, 221517 }, -- 	Rune of Bloodshed
				{ 424, 223288 }, -- 	Rune of the Hammer
			},
		},
		{
			name = AL["Durotar Supply and Logistics"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Exalted"], nil },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 5, 223186 }, -- Supply Expediter
				{ 6, 223162 }, -- Handy Courier Haversack
				{ 7, 220639 }, -- Lledra's Inanimator
				{ 9, "INV_Box_01", nil, AL["Revered"], nil },
				{ 10, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 11, 219021 }, -- Hefty Courier Pack
				{ 12, 223161 }, -- Empty Supply Crate
				{ 13, 219135 }, -- Curiosity Pendant
				{ 14, 219136 }, -- Tenacity Pendant
				{ 15, 219137 }, -- Initiative Pendant
				{ 16, "INV_Box_01", nil, AL["Honored"], nil },
				{ 17, 211384 }, -- Sturdy Courier Bag
				{ 18, 210779 }, -- Plans: Mantle of the Second War
				{ 19, 211247 }, -- Pattern: Phoenix Bindings
				{ 20, 212230 }, -- Schematic: Soul Vessel
				{ 21, 223160 }, -- Bargain Bush
				{ 22, 219022 }, -- Hauler's Ring
				{ 23, 219023 }, -- Clerk's Ring
				{ 24, 219024 }, -- Messenger's Ring
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, "INV_Box_01", nil, AL["Friendly"], nil },
				{ 102, 211382 }, -- Small Courier Satchel
				{ 103, 212588 }, -- Provisioner's Gloves
				{ 104, 212589 }, -- Courier Treads
				{ 105, 212590 }, -- Hoist Strap
				{ 107, 211386 }, -- Spell Notes: Arcane Surge
				{ 108, 211387 }, -- Rune of Beckoning Light
				{ 109, 211392 }, -- Rune of Everlasting Affliction
				{ 110, 211391 }, -- Rune of Healing Rain
				{ 111, 211385 }, -- Rune of Serpent Spread
				{ 112, 211393 }, -- Rune of Single-Minded Fury
				{ 113, 206992 }, -- Rune of Skull Bash
				{ 114, 211390 }, -- Rune of Teasing
				{ 115, 205950 }, -- Tenebrous Epiphany
			},
		},
		{
			name = AL["Azeroth Commerce Authority"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Exalted"], nil },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 5, 223186 }, -- Supply Expediter
				{ 6, 223162 }, -- Handy Courier Haversack
				{ 7, 220639 }, -- Lledra's Inanimator
				{ 9, "INV_Box_01", nil, AL["Revered"], nil },
				{ 10, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 11, 219021 }, -- Hefty Courier Pack
				{ 12, 223161 }, -- Empty Supply Crate
				{ 13, 219135 }, -- Curiosity Pendant
				{ 14, 219136 }, -- Tenacity Pendant
				{ 15, 219137 }, -- Initiative Pendant
				{ 16, "INV_Box_01", nil, AL["Honored"], nil },
				{ 17, 211384 }, -- Sturdy Courier Bag
				{ 18, 210779 }, -- Plans: Mantle of the Second War
				{ 19, 211247 }, -- Pattern: Phoenix Bindings
				{ 20, 212230 }, -- Schematic: Soul Vessel
				{ 21, 223160 }, -- Bargain Bush
				{ 22, 219022 }, -- Hauler's Ring
				{ 23, 219023 }, -- Clerk's Ring
				{ 24, 219024 }, -- Messenger's Ring
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, "INV_Box_01", nil, AL["Friendly"], nil },
				{ 102, 211382 }, -- Small Courier Satchel
				{ 103, 212588 }, -- Provisioner's Gloves
				{ 104, 212589 }, -- Courier Treads
				{ 105, 212590 }, -- Hoist Strap
				{ 107, 211386 }, -- Spell Notes: Arcane Surge
				{ 108, 211387 }, -- Rune of Beckoning Light
				{ 109, 211392 }, -- Rune of Everlasting Affliction
				{ 110, 211391 }, -- Rune of Healing Rain
				{ 111, 211385 }, -- Rune of Serpent Spread
				{ 112, 211393 }, -- Rune of Single-Minded Fury
				{ 113, 206992 }, -- Rune of Skull Bash
				{ 114, 211390 }, -- Rune of Teasing
				{ 115, 205950 }, -- Tenebrous Epiphany
			},
		},
	},
}

data["Sod Exclusives"] = {
	name = AL["Waylaid Supplies"],
	ContentType = SOD_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Level 50: Phase 3"],
			[NORMAL_DIFF] = {
				{ 1, 220927 }, -- Waylaid Supplies: Thick Hide
				{ 2, 220926 }, --Waylaid Supplies: Rugged Leather
				{ 3, 220925 }, --Waylaid Supplies: Thorium Bars
				{ 4, 220924 }, --Waylaid Supplies: Truesilver Bars
				{ 5, 220923 }, --Waylaid Supplies: Dreamfoil
				{ 6, 220922 }, --Waylaid Supplies: Sungrass
				{ 7, 220921 }, --Waylaid Supplies: Heavy Mageweave Bandages
				{ 8, 220920 }, --Waylaid Supplies: Tender Wolf Steaks
				{ 9, 220919 }, --Waylaid Supplies: Nightfin Soup
				{ 10, 220918 }, --Waylaid Supplies: Undermine Clam Chowder
				{ 11, 220942 }, --Waylaid Supplies: Tuxedo Shirts
				{ 12, 220941 }, --Waylaid Supplies: Runecloth Belts
				{ 13, 220940 }, --Waylaid Supplies: Black Mageweave Headbands
				{ 14, 220939 }, --Waylaid Supplies: Runic Leather Bracers
				{ 15, 220938 }, --Waylaid Supplies: Wicked Leather Bracers
				{ 16, 220937 }, --Waylaid Supplies: Rugged Armor Kits
				{ 17, 220936 }, --Waylaid Supplies: Truesilver Gauntlets
				{ 18, 220935 }, --Waylaid Supplies: Thorium Belts
				{ 19, 220934 }, --Waylaid Supplies: Mithril Coifs
				{ 20, 220933 }, --Waylaid Supplies: Thorium Rifles
				{ 21, 220932 }, --Waylaid Supplies: Thorium Grenades
				{ 22, 220931 }, --Waylaid Supplies: Hi-Explosive Bombs
				{ 23, 220930 }, --Waylaid Supplies: Major Healing Potions
				{ 24, 220929 }, -- Waylaid Supplies: Superior Mana Potions
				{ 25, 220928 }, -- Waylaid Supplies: Enchanted Thorium Bars
			},
		},
		{
			name = AL["Level 40: Phase 2"],
			[NORMAL_DIFF] = {
				{ 1, 215403 }, -- Waylaid Supplies: Deadly Scopes
				{ 2, 215400 },
				{ 3, 215402 },
				{ 4, 215389 },
				{ 5, 215391 },
				{ 6, 215411 }, -- Waylaid Supplies: Frost Leather Cloaks
				{ 7, 215398 },
				{ 8, 215387 },
				{ 9, 215420 },
				{ 10, 215421 },
				{ 11, 215413 },
				{ 12, 215408 }, -- Waylaid Supplies: Frost Leather Cloaks
				{ 13, 215392 },
				{ 14, 215386 },
				{ 15, 215390 },
				{ 16, 215399 },
				{ 17, 215395 }, -- Waylaid Supplies: Elixirs of Agility
				{ 18, 215388 },
				{ 19, 215393 },
				{ 20, 215401 }, -- Waylaid Supplies: Compact Harvest Reaper Kits
				{ 21, 215419 },
				{ 22, 215414 },
				{ 23, 215385 },
				{ 24, 215417 },
				{ 25, 215415 },
				{ 26, 215407 },
				{ 27, 215418 }, -- Waylaid Supplies: Spider Sausages
				{ 28, 215404 },
				{ 29, 215396 },
				{ 30, "INV_Box_01", nil, AL["Continued on next page ->"], nil },
				{ 101, 215397 },
				{ 102, 215409 },
				{ 103, 215416 }, -- Waylaid Supplies: White Bandit Masks
			},
		},
		{
			name = AL["Level 25: Phase 1"],
			[NORMAL_DIFF] = {
				{ 1, 211322 }, -- Waylaid Supplies: Minor Wizard Oil
				{ 2, 211321 }, -- Waylaid Supplies: Lesser Magic Wands
				{ 3, 211318 }, -- Waylaid Supplies: Minor Healing Potions
				{ 4, 211320 }, -- Waylaid Supplies: Runed Copper Pants
				{ 5, 211323 }, -- Waylaid Supplies: Rough Copper Bombs
				{ 6, 211329 }, -- Waylaid Supplies: Herb Baked Eggs
				{ 7, 211326 }, -- Waylaid Supplies: Embossed Leather Vests
				{ 8, 211332 }, -- Waylaid Supplies: Heavy Linen Bandages
				{ 9, 211319 }, -- Waylaid Supplies: Copper Shortswords
				{ 10, 211330 }, -- Waylaid Supplies: Spiced Wolf Meat
				{ 11, 211324 }, -- Waylaid Supplies: Rough Boomsticks
				{ 12, 211327 }, -- Waylaid Supplies: Brown Linen Pants
				{ 13, 211317 }, -- Waylaid Supplies: Silverleaf
				{ 14, 211325 }, -- Waylaid Supplies: Handstitched Leather Belts
				{ 15, 211328 }, -- Waylaid Supplies: Brown Linen Robes
				{ 16, 211934 }, -- Waylaid Supplies: Healing Potions
				{ 17, 211315 }, -- Waylaid Supplies: Light Leather
				{ 18, 211331 }, -- Waylaid Supplies: Brilliant Smallfish
				{ 19, 210771 }, -- Waylaid Supplies: Copper Bars
				{ 20, 211933 }, -- Waylaid Supplies: Rough Stone
				{ 21, 211316 }, -- Waylaid Supplies: Peacebloom
				{ 22, 211828 }, -- Waylaid Supplies: Minor Mana Oil
				{ 23, 211824 }, -- Waylaid Supplies: Lesser Mana Potions
				{ 24, 211835 }, -- Waylaid Supplies: Smoked Sagefish
				{ 25, 211829 }, -- Waylaid Supplies: Small Bronze Bombs
				{ 26, 211822 }, -- Waylaid Supplies: Bruiseweed
				{ 27, 211838 }, -- Waylaid Supplies: Heavy Wool Bandages
				{ 28, 211825 }, -- Waylaid Supplies: Rough Bronze Boots
				{ 29, 211836 }, -- Waylaid Supplies: Smoked Bear Meat
				{ 30, "INV_Box_01", nil, AL["Continued on next page ->"], nil },
				{ 101, 211831 }, -- Waylaid Supplies: Dark Leather Cloaks
				{ 102, 211837 }, -- Waylaid Supplies: Goblin Deviled Clams
				{ 103, 211820 }, -- Waylaid Supplies: Silver Bars
				{ 104, 211821 }, -- Waylaid Supplies: Medium Leather
				{ 105, 211833 }, -- Waylaid Supplies: Gray Woolen Shirts
				{ 106, 211827 }, -- Waylaid Supplies: Runed Silver Rods
				{ 107, 211819 }, -- Waylaid Supplies: Bronze Bars
				{ 108, 211830 }, -- Waylaid Supplies: Ornate Spyglasses
				{ 109, 211826 }, -- Waylaid Supplies: Silver Skeleton Keys
				{ 110, 211935 }, -- Waylaid Supplies: Elixir of Firepower
				{ 111, 211834 }, -- Waylaid Supplies: Pearl-clasped Cloaks
				{ 112, 211823 }, -- Waylaid Supplies: Swiftthistle
				{ 113, 211832 }, -- Waylaid Supplies: Hillman's Shoulders
			},
		},
	},
}

data["TierSets"] = {
	name = AL["Tier & Sets"],
	ContentType = CLASSIC_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- T1
		name = format(AL["Tier %s Sets"], "1"),
		CoinTexture = "CLASSIC",
		[NORMAL_DIFF] = {
			{ 1, 203 }, -- Warlock
			{ 3, 202 }, -- Priest
			{ 16, 201 }, -- Mage
			{ 5, 204 }, -- Rogue
			{ 20, 205 }, -- Druid
			{ 7, 206 }, -- Hunter
			{ 9, 209 }, -- Warrior
			{ 22, 207 }, -- Shaman
			{ 24, 208 }, -- Paladin
		},
	},
	{ -- T2
	name = format(AL["Tier %s Sets"], "2"),
	CoinTexture = "CLASSIC",
	[NORMAL_DIFF] = {
		{ 1, 212 }, -- Warlock
		{ 3, 211 }, -- Priest
		{ 16, 210 }, -- Mage
		{ 5, 213 }, -- Rogue
		{ 20, 214 }, -- Druid
		{ 7, 215 }, -- Hunter
		{ 9, 218 }, -- Warrior
		{ 22, 216 }, -- Shaman
		{ 24, 217 }, -- Paladin
	},
},
{ -- T2.5
name = format(AL["Tier %s Sets"], "2.5"),
CoinTexture = "CLASSIC",
[NORMAL_DIFF] = {
	{ 1, 499 }, -- Warlock
	{ 3, 507 }, -- Priest
	{ 16, 503 }, -- Mage
	{ 5, 497 }, -- Rogue
	{ 20, 493 }, -- Druid
	{ 7, 509 }, -- Hunter
	{ 9, 496 }, -- Warrior
	{ 22, 501 }, -- Shaman
	{ 24, 505 }, -- Paladin
},
},
{ -- T3
name = format(AL["Tier %s Sets"], "3"),
CoinTexture = "CLASSIC",
[NORMAL_DIFF] = {
	{ 1, 529 }, -- Warlock
	{ 3, 525 }, -- Priest
	{ 16, 526 }, -- Mage
	{ 5, 524 }, -- Rogue
	{ 20, 521 }, -- Druid
	{ 7, 530 }, -- Hunter
	{ 9, 523 }, -- Warrior
	{ 22, 527 }, -- Shaman
	{ 24, 528 }, -- Paladin
},
},
{ -- T0 / D1
name = format(AL["Dungeon Set %s"], "1"),
CoinTexture = "CLASSIC",
[NORMAL_DIFF] = {
	{ 1, 183 }, -- Warlock
	{ 3, 182 }, -- Priest
	{ 16, 181 }, -- Mage
	{ 5, 184 }, -- Rogue
	{ 20, 185 }, -- Druid
	{ 7, 186 }, -- Hunter
	{ 9, 189 }, -- Warrior
	{ 22, 187 }, -- Shaman
	{ 24, 188 }, -- Paladin
},
},
{ -- T0.5 / D2
name = format(AL["Dungeon Set %s"], "2"),
CoinTexture = "CLASSIC",
[NORMAL_DIFF] = {
	{ 1, 518 }, -- Warlock
	{ 3, 514 }, -- Priest
	{ 16, 517 }, -- Mage
	{ 5, 512 }, -- Rogue
	{ 20, 513 }, -- Druid
	{ 7, 515 }, -- Hunter
	{ 9, 511 }, -- Warrior
	{ 22, 519 }, -- Shaman
	{ 24, 516 }, -- Paladin
},
},
{
	name = format(AL["%s Sets"], C_Map_GetAreaInfo(1977)),
	[ALLIANCE_DIFF] = {
		{ 1,  481 }, -- Warlock
		{ 3,  480 }, -- Priest
		{ 16, 482 }, -- Mage
		{ 5,  478 }, -- Rogue
		{ 20, 479 }, -- Druid
		{ 7,  477 }, -- Hunter
		{ 9,  474 }, -- Warrior
		{ 24, 475 }, -- Paladin
	},
	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 476 }, -- Shaman
		{ 24 }, -- Paladin
	},
},
{ -- Misc
name = format(AL["%s Sets"], AL["Misc"]),
[NORMAL_DIFF] = {
	-- Swords
	{ 1,  461 }, -- Warblade of the Hakkari
	{ 3,  463 }, -- Primal Blessing
	-- Rings
	{ 16,  466 }, -- Major Mojo Infusion
	{ 17,  462 }, -- Zanzil's Concentration
	{ 18,  465 }, -- Prayer of the Primal
	{ 19,  464 }, -- Overlord's Resolution
	-- Fist weapons
	{ 5,  261 }, -- Spirit of Eskhandar
	-- Swords
	{ 7,  41 }, -- Dal'Rend's Arms
	-- Dagger / Mace
	{ 9,  65 }, -- Spider's Kiss
	-- Trinket
	{ 11,  241 }, -- Shard of the Gods / 60
},
},
{ -- AQ20
name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 20"),
[ALLIANCE_DIFF] = {
	{ 1,  500 }, -- Warlock
	{ 3,  508 }, -- Priest
	{ 16, 504 }, -- Mage
	{ 5,  498 }, -- Rogue
	{ 20, 494 }, -- Druid
	{ 7,  510 }, -- Hunter
	{ 9,  495 }, -- Warrior
	{ 24, 506 }, -- Paladin
},
[HORDE_DIFF] = {
	GetItemsFromDiff = ALLIANCE_DIFF,
	{ 22, 502 }, -- Shaman
	{ 24 }, -- Paladin
},
},
{ -- AQ40
name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 40"),
[ALLIANCE_DIFF] = {
	{ 1,  499 }, -- Warlock
	{ 3,  507 }, -- Priest
	{ 16, 503 }, -- Mage
	{ 5,  497 }, -- Rogue
	{ 20, 493 }, -- Druid
	{ 7,  509 }, -- Hunter
	{ 9,  496 }, -- Warrior
	{ 24, 505 }, -- Paladin
},
[HORDE_DIFF] = {
	GetItemsFromDiff = ALLIANCE_DIFF,
	{ 22, 501 }, -- Shaman
	{ 24 }, -- Paladin
},
},
{ -- Cloth
name = ALIL["Cloth"],
[NORMAL_DIFF] = {
	{ 1,  421 }, -- Bloodvine Garb / 65
	{ 2,  520 }, -- Ironweave Battlesuit / 61-63
	{ 3,  122 }, -- Necropile Raiment / 61
	{ 4,  81 }, -- Twilight Trappings / 61
	{ 5,  492 }, -- Twilight Trappings / 60
	{ 16,  536 }, -- Regalia of Undead Cleansing / 63
},
},
{ -- Leather
name = ALIL["Leather"],
[NORMAL_DIFF] = {
	{ 1,  442 }, -- Blood Tiger Harness / 65
	{ 2,  441 }, -- Primal Batskin / 65
	{ 3,  121 }, -- Cadaverous Garb / 61
	{ 4,  142 }, -- Stormshroud Armor / 55-62
	{ 5,  141 }, -- Volcanic Armor / 54-61
	{ 6,  143 }, -- Devilsaur Armor / 58-60
	{ 7,  144 }, -- Ironfeather Armor / 54-58
	{ 8,  534 }, -- Undead Slayer's Armor / 63
	{ 9,  161 }, -- Defias Leather / 18-24
	{ 10,  162 }, -- Embrace of the Viper / 19-23
	{ 16,  221 }, -- Garb of Thero-shan / 32-42
},
},
{ -- Mail
name = ALIL["Mail"],
[NORMAL_DIFF] = {
	{ 1,  443 }, -- Bloodsoul Embrace / 65
	{ 2,  123 }, -- Bloodmail Regalia / 61
	{ 3,  489 }, -- Black Dragon Mail / 58-62
	{ 4,  491 }, -- Blue Dragon Mail / 57-60
	{ 5,  1 }, -- The Gladiator / 57
	{ 6,  490 }, -- Green Dragon Mail / 52-56
	{ 7,  163 }, -- Chain of the Scarlet Crusade / 35-43
	{ 16,  535 }, -- Garb of the Undead Slayer / 63
},
},
{ -- Plate
name = ALIL["Plate"],
[NORMAL_DIFF] = {
	{ 1,  444 }, -- The Darksoul / 65
	{ 2,  124 }, -- Deathbone Guardian / 61
	{ 3,  321 }, -- Imperial Plate / 53-61
	{ 16,  533 }, -- Battlegear of Undead Slaying / 63
},
},
},
}

data["WorldEpics"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["One-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Mace
				{ 1, 2243 }, -- Hand of Edward the Odd
				{ 2, 810 }, -- Hammer of the Northern Wind
				{ 3, 868 }, -- Ardent Custodian
				-- Axe
				{ 7, 811 }, -- Axe of the Deep Woods
				{ 8, 871 }, -- Flurry Axe
				-- Sword
				{ 16, 1728 }, -- Teebu's Blazing Longsword
				{ 17, 20698 }, -- Elemental Attuned Blade
				{ 18, 2244 }, -- Krol Blade
				{ 19, 809 }, -- Bloodrazor
				{ 20, 869 }, -- Dazzling Longsword
				-- Dagger
				{ 22, 14555 }, -- Alcor's Sunrazor
				{ 23, 2163 }, -- Shadowblade
				{ 24, 2164 }, -- Gut Ripper
			},
		},
		{
			name = AL["Two-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Axe
				{ 1, 2801 }, -- Blade of Hanna
				{ 2, 647 }, -- Destiny
				{ 3, 2291 }, -- Kang the Decapitator
				{ 4, 870 }, -- Fiery War Axe
				-- Mace
				{ 6, 2915 }, -- Taran Icebreaker
				-- Sword
				{ 16, 1263 }, -- Brain Hacker
				{ 17, 1982 }, -- Nightblade
				-- Staff
				{ 21, 944 }, -- Elemental Mage Staff
				{ 22, 812 }, -- Glowing Brightwood Staff
				{ 23, 943 }, -- Warden Staff
				{ 24, 873 }, -- Staff of Jordan
			},
		},
		{
			name = AL["Ranged Weapons"].." & "..ALIL["Shield"],
			[NORMAL_ITTYPE] = {
				-- Bow
				{ 1, 2824 }, -- Hurricane
				{ 2, 2825 }, -- Bow of Searing Arrows
				-- Gun
				{ 4, 2099 }, -- Dwarven Hand Cannon
				{ 5, 2100 }, -- Precisely Calibrated Boomstick
				-- Shield
				{ 16, 1168 }, -- Skullflame Shield
				{ 17, 1979 }, -- Wall of the Dead
				{ 18, 1169 }, -- Blackskull Shield
				{ 19, 1204 }, -- The Green Tower
			},
		},
		{
			name = ALIL["Trinket"].." & "..ALIL["Finger"].." & "..ALIL["Neck"],
			[NORMAL_ITTYPE] = {
				-- Trinket
				{ 1, 14557 }, -- The Lion Horn of Stormwind
				{ 2, 833 }, -- Lifestone
				-- Neck
				{ 6,  14558 }, -- Lady Maye's Pendant
				{ 7,  1443 }, -- Jeweled Amulet of Cainwyn
				{ 8,  1315 }, -- Lei of Lilies
				--Finger
				{ 16,  2246 }, -- Myrmidon's Signet
				{ 17,  942 }, -- Freezing Band
				{ 18,  1447 }, -- Ring of Saviors
				{ 19,  1980 }, -- Underworld Band
			},
		},
		{
			name = AL["Equip"],
			[NORMAL_ITTYPE] = {
				-- Cloth
				{ 1,  3075 }, -- Eye of Flame
				{ 2,  940 }, -- Robes of Insight
				-- Mail
				{ 4,  2245 }, -- Helm of Narv
				{ 5,  17007 }, -- Stonerender Gauntlets
				{ 6,  14551 }, -- Edgemaster's Handguards
				{ 7,  1981 }, -- Icemail Jerkin
				-- Back
				{ 9,  3475 }, -- Cloak of Flames
				-- Leather
				{ 16,  14553 }, -- Sash of Mercy
				{ 17,  867 }, -- Gloves of Holy Might
				-- Plate
				{ 19,  14554 }, -- Cloudkeeper Legplates
				{ 20,  14552 }, -- Stockade Pauldrons
				{ 21,  14549 }, -- Boots of Avoidance
			},
		},
	},
}

data["Mounts"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["Faction Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,  18785 }, -- Swift White Ram
				{ 2,  18786 }, -- Swift Brown Ram
				{ 3,  18787 }, -- Swift Gray Ram
				{ 16,  5873 }, -- White Ram
				{ 17,  5872 }, -- Brown Ram
				{ 18,  5864 }, -- Gray Ram
				{ 5,  18772 }, -- Swift Green Mechanostrider
				{ 6,  18773 }, -- Swift White Mechanostrider
				{ 7,  18774 }, -- Swift Yellow Mechanostrider
				{ 20,  13321 }, -- Green Mechanostrider
				{ 21,  13322 }, -- Unpainted Mechanostrider
				{ 22,  8563 }, -- Red Mechanostrider
				{ 23,  8595 }, -- Blue Mechanostrider
				{ 10,  18776 }, -- Swift Palomino
				{ 11,  18777 }, -- Swift Brown Steed
				{ 12,  18778 }, -- Swift White Steed
				{ 25,  2414 }, -- Pinto Bridle
				{ 26,  5656 }, -- Brown Horse Bridle
				{ 27,  5655 }, -- Chestnut Mare Bridle
				{ 28,  2411 }, -- Black Stallion Bridle
				{ 101,  18902 }, -- Reins of the Swift Stormsaber
				{ 102,  18767 }, -- Reins of the Swift Mistsaber
				{ 103,  18766 }, -- Reins of the Swift Frostsaber
				{ 116,  8632 }, -- Reins of the Spotted Frostsaber
				{ 117,  8631 }, -- Reins of the Striped Frostsaber
				{ 118,  8629 }, -- Reins of the Striped Nightsaber
			},
			[HORDE_DIFF] = {
				{ 1,  18798 }, -- Horn of the Swift Gray Wolf
				{ 2,  18797 }, -- Horn of the Swift Timber Wolf
				{ 3,  18796 }, -- Horn of the Swift Brown Wolf
				{ 16,  5668 }, -- Horn of the Brown Wolf
				{ 17,  5665 }, -- Horn of the Dire Wolf
				{ 18,  1132 }, -- Horn of the Timber Wolf
				{ 5,  18795 }, -- Great Gray Kodo
				{ 6,  18794 }, -- Great Brown Kodo
				{ 7,  18793 }, -- Great White Kodo
				{ 20,  15290 }, -- Brown Kodo
				{ 21,  15277 }, -- Gray Kodo
				{ 9,  18790 }, -- Swift Orange Raptor
				{ 10,  18789 }, -- Swift Olive Raptor
				{ 11,  18788 }, -- Swift Blue Raptor
				{ 24,  8592 }, -- Whistle of the Violet Raptor
				{ 25,  8591 }, -- Whistle of the Turquoise Raptor
				{ 26,  8588 }, -- Whistle of the Emerald Raptor
				{ 13,  18791 }, -- Purple Skeletal Warhorse
				{ 14,  13334 }, -- Green Skeletal Warhorse
				{ 28,  13333 }, -- Brown Skeletal Horse
				{ 29,  13332 }, -- Blue Skeletal Horse
				{ 30,  13331 }, -- Red Skeletal Horse
			},
		},
		{ -- PvPMountsPvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1,  19030 }, -- Stormpike Battle Charger
				{ 3,  GetForVersion(18244,29467) }, -- Black War Ram
				{ 4,  GetForVersion(18243,29465) }, -- Black Battlestrider
				{ 5,  GetForVersion(18241,29468) }, -- Black War Steed Bridle
				{ 6,  GetForVersion(18242,29471) }, -- Reins of the Black War Tiger

				{ 8, 234960 }, -- Reins of the Blood-Caked Tiger
				{ 9, 234961 }, -- Whistle of the Blood-Caked Raptor
			},
			[HORDE_DIFF] = {
				{ 1, 19029 }, -- Horn of the Frostwolf Howler
				{ 3, GetForVersion(18245,29469) }, -- Horn of the Black War Wolf
				{ 4, GetForVersion(18247,29466) }, -- Black War Kodo
				{ 5, GetForVersion(18246,29472) }, -- Whistle of the Black War Raptor
				{ 6, GetForVersion(18248,29470) }, -- Red Skeletal Warhorse
				{ 8, 234960 }, -- Reins of the Blood-Caked Tiger
				{ 9, 234961 }, -- Whistle of the Blood-Caked Raptor

			},
		},
		{ -- Drops
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 13335 }, -- Deathcharger's Reins
				{ 3, 19872 }, -- Swift Razzashi Raptor
				{ 5, 19902 }, -- Swift Zulian Tiger
			},
		},
		{ -- Reputation
			name = AL["Reputation"],
			[ALLIANCE_DIFF] = {
				{ 1, 13086 }, -- Reins of the Winterspring Frostsaber
			}
		},
		{
				name = ALIL["Special"],
				[NORMAL_DIFF] = {
					{ 1, 21176 }, -- Black Qiraji Resonating Crystal
					{ 3, 23720 }, -- Riding Turtle
				},
		},
		{ -- AQ40
			MapID = 3428,
			[NORMAL_DIFF] = {
				{ 1, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 2, 21323 }, -- Green Qiraji Resonating Crystal
				{ 3, 21321 }, -- Red Qiraji Resonating Crystal
				{ 4, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 16, "INV_Box_01", nil, AL["Hardmode"], nil },
				{ 17, 233352}, -- Dark Blue Qiraji Resonating Crystal
				{ 18, 233353}, -- Light Blue Qiraji Resonating Crystal
				{ 19, 233351}, -- Light Green Qiraji Resonating Crystal
				{ 20, 233356}, -- Orange Qiraji Resonating Crystal
				{ 21, 233357}, -- Twilight Qiraji Resonating Crystal
			},
		},
		{ -- Naxx
			MapID = 3456,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Mythic"], nil },
				{ 2, 236662 }, -- Reins of War
				{ 3, 236663 }, -- Reins of Conquest
				{ 4, 236664 }, -- Reins of Death
				{ 5, 236665 }, -- Reins of Famine
			},
		},
		{ -- Scarlet Enclave
			MapID = -1,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Hardmode?"], nil },
				{ 2, 239695 }, -- Scarlet Steed
				{ 3, 239694 }, -- Covenant of Light
			}
		}
	},
}

data["Companions"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1, 15996 }, -- Lifelike Mechanical Toad
				{ 2, 11826 }, -- Lil' Smoky
				{ 3, 4401 }, -- Mechanical Squirrel Box
				{ 4, 11825 }, -- Pet Bombling
				{ 5, 21277 }, -- Tranquil Mechanical Yeti
			},
		},
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 8494 }, -- Parrot Cage (Hyacinth Macaw)
				{ 2, 8492 }, -- Parrot Cage (Green Wing Macaw)
				{ 4, 8498 }, -- Tiny Emerald Whelpling
				{ 5, 8499 }, -- Tiny Crimson Whelpling
				{ 6, 10822 }, -- Dark Whelpling
				{ 8, 8490 }, -- Cat Carrier (Siamese)
				{ 9, 8491 }, -- Cat Carrier (Black Tabby)
				{ 16, 20769 }, -- Disgusting Oozeling
				{ 17, 11110 }, -- Chicken Egg
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
				{ 1, 12264 }, -- Worg Carrier
				{ 2, 11474 }, -- Sprite Darter Egg
				{ 3, 12529 }, -- Smolderweb Carrier
				{ 4, 10398 }, -- Mechanical Chicken
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 11023 }, -- Ancona Chicken
				{ 2, 10393 }, -- Cockroach
				{ 3, 10394 }, -- Prairie Dog Whistle
				{ 4, 10392 }, -- Crimson Snake
				{ 5, 8497 }, -- Rabbit Crate (Snowshoe)
				{ 7, 10360 }, -- Black Kingsnake
				{ 8, 10361 }, -- Brown Snake
				{ 10, 8500 }, -- Great Horned Owl
				{ 11, 8501 }, -- Hawk Owl
				{ 16, 8485 }, -- Cat Carrier (Bombay)
				{ 17, 8486 }, -- Cat Carrier (Cornish Rex)
				{ 18, 8487 }, -- Cat Carrier (Orange Tabby)
				{ 19, 8490 }, -- Cat Carrier (Siamese)
				{ 20, 8488 }, -- Cat Carrier (Silver Tabby)
				{ 21, 8489 }, -- Cat Carrier (White Kitten)
				{ 23, 8496 }, -- Parrot Cage (Cockatiel)
				{ 24, 8495 }, -- Parrot Cage (Senegal)
				{ 26, 11026 }, -- Tree Frog Box
				{ 27, 11027 }, -- Wood Frog Box
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
				{ 1, 21305 }, -- Red Helper Box
				{ 2, 21301 }, -- Green Helper Box
				{ 3, 21308 }, -- Jingling Bell
				{ 4, 21309 }, -- Snowman Kit
				{ 16, 22235 }, -- Truesilver Shafted Arrow
				{ 18, 23083 }, -- Captured Flame
				{ 20, 23015 }, -- Rat Cage
				{ 21, 22781 }, -- Polar Bear Collar
				{ 22, 23007 }, -- Piglet's Collar
				{ 23, 23002 }, -- Turtle Box
			},
		},
		{ -- Unobtainable
		name = AL["Unobtainable"],
		[NORMAL_DIFF] = {
			{ 1, 13582 }, -- Zergling Leash
			{ 2, 13584 }, -- Diablo Stone
			{ 3, 13583 }, -- Panda Collar
			{ 16, 22780 }, -- White Murloc Egg
			{ 17, 22114 }, -- Pink Murloc Egg
			{ 18, 20651 }, -- Orange Murloc Egg
			{ 19, 20371 }, -- Blue Murloc Egg
		},
	},
},
}

data["Tabards"] = {
	name = ALIL["Tabard"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.TABARDS,
	items = {
		{
			name = ALIL["Tabard"],
			[NORMAL_DIFF] = {
				{ 1, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		{ -- Faction
		name = AL["Capitals"],
		CoinTexture = "Reputation",
		[ALLIANCE_DIFF] = {
			{ 1, 45579 },	-- Darnassus Tabard
			{ 2, 45577 },	-- Ironforge Tabard
			{ 3, 45578 },	-- Gnomeregan Tabard
			{ 4, 45574 },	-- Stormwind Tabard
			{ 16, 45580 },	-- Exodar Tabard
			AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 17, 64882 }),	-- Gilneas Tabard
		},
		[HORDE_DIFF] = {
			{ 1, 45582 },	-- Darkspear Tabard
			{ 2, 45581 },	-- Orgrimmar Tabard
			{ 3, 45584 },	-- Thunder Bluff Tabard
			{ 4, 45583 },	-- Undercity Tabard
			AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 16, 45585 }),	-- Silvermoon City Tabard
		},
	},
	{
		name = format("%s - %s", AL["Factions"], AL["Classic"]),
		CoinTexture = "Reputation",
		[NORMAL_DIFF] = {
			{ 1, 43154 }, -- Tabard of the Argent Crusade
		},
	},
	{ -- PvP
	name = AL["PvP"],
	[ALLIANCE_DIFF] = {
		{ 1, 15196 },	-- Private's Tabard
		{ 2, 15198 },	-- Knight's Colors
		{ 16, 19506 },	-- Silverwing Battle Tabard
		{ 17, 19032 },	-- Stormpike Battle Tabard
		{ 18, 20132 },	-- Arathor Battle Tabard
	},
	[HORDE_DIFF] = {
		{ 1, 15197 },	-- Scout's Tabard
		{ 2, 15199 },	-- Stone Guard's Herald
		{ 16, 19505 },	-- Warsong Battle Tabard
		{ 17, 19031 },	-- Frostwolf Battle Tabard
		{ 18, 20131 },	-- Battle Tabard of the Defilers
	},
},
{ -- PvP
name = AL["Arena"],
[NORMAL_DIFF] = {
	{ 1, 45983 },	-- Furious Gladiator's Tabard
	{ 2, 49086, },	-- Relentless Gladiator's Tabard
	{ 3, 51534 },	-- Wrathful Gladiator's Tabard
},
},
{ -- Unobtainable Tabards
name = AL["Unobtainable"],
[NORMAL_DIFF] = {
	{ 1, 19160 },	-- Contest Winner's Tabard
	AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 3, 36941 }), -- Competitor's Tabard
	AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 5, 28788 }), -- Tabard of the Protector
	{ 16, "INV_Box_01", nil, AL["Card Game Tabards"], nil },
	{ 17, 38312 },	-- Tabard of Brilliance
	{ 18, 23705 },	-- Tabard of Flame
	{ 19, 23709 },	-- Tabard of Frost
	{ 20, 38313 },	-- Tabard of Fury
	{ 21, 38309 },	-- Tabard of Nature
	{ 22, 38310 },	-- Tabard of the Arcane
	{ 23, 38314 },	-- Tabard of the Defender
	{ 24, 38311 },	-- Tabard of the Void
},
},
},
}

data["Legendarys"] = {
	name = AL["Legendarys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Legendarys"],
			[NORMAL_ITTYPE] = {
				{ 1,  230224 }, -- Thunderfury, Blessed Blade of the Windseeker

				{ 3,  236399 }, -- Atiesh, Greatstaff of the Guardian / Priest
				{ 4,  236400 }, -- Atiesh, Greatstaff of the Guardian / Mage
				{ 5,  236398 }, -- Atiesh, Greatstaff of the Guardian / Warlock
				{ 6,  236401 }, -- Atiesh, Greatstaff of the Guardian / Druid

				{ 16,  227683 }, -- Sulfuras, Hand of Ragnaros

				{ 18,  21176 }, -- Black Qiraji Resonating Crystal
			},
		},
		{
			name = ALIL["Quest Item"],
			[NORMAL_ITTYPE] = {
				{ 1,  19018 }, -- Dormant Wind Kissed Blade
				{ 2,  19017 }, -- Essence of the Firelord
				{ 3,  19016 }, -- Vessel of Rebirth
				{ 4,  18564 }, -- Bindings of the Windseeker / Right
				{ 5,  18563 }, -- Bindings of the Windseeker / Left
				{ 7,  17204 }, -- Eye of Sulfuras
				{ 9,  17771 }, -- Elementium Bar
				{ 16,  22736 }, -- Andonisus, Reaper of Souls
				{ 17,  22737 }, -- Atiesh, Greatstaff of the Guardian
				{ 18,  22733 }, -- Staff Head of Atiesh
				{ 19,  22734 }, -- Base of Atiesh
				{ 20,  22727 }, -- Frame of Atiesh
				{ 21,  22726 }, -- Splinter of Atiesh
			},
		},
		{
			name = AL["Unobtainable"],
			[NORMAL_ITTYPE] = {
				{ 1,  17782 }, -- Talisman of Binding Shard
				{ 16,  20221 }, -- Foror's Fabled Steed
			},
		},
	},
}

data["Darkmoon"] = {
	FactionID = 909,
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 3,
	items = {
		{ -- Exalted
		name = GetFactionInfoByID(909),
		[NORMAL_DIFF] = {
			{ 1,  19491, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Amulet of the Darkmoon
			{ 2,  19426, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Orb of the Darkmoon
			{ 4,  19293, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Last Year's Mutton
			{ 5,  19291, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Darkmoon Storage Box
			{ 7,  9249, 19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Schematic: Steam Tonk Controller
			{ 8,  19296, 19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Greater Darkmoon Prize
			{ 10,  19297, 19182, [ATLASLOOT_IT_AMOUNT2] = 12 }, -- Lesser Darkmoon Prize
			{ 12,  19292, 19182, [ATLASLOOT_IT_AMOUNT2] = 10 }, -- Last Month's Mutton
			{ 14,  19298, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Minor Darkmoon Prize
			{ 15,  19295, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Darkmoon Flower
		},
	},
	{
		name = AL["Classic"],
		[NORMAL_DIFF] = {
			{ 1,  19228 }, -- Darkmoon Card: Blue Dragon
			{ 2,  19267 }, -- Darkmoon Card: Maelstrom
			{ 3,  19257 }, -- Darkmoon Card: Heroism
			{ 4,  19277 }, -- Darkmoon Card: Twisting Nether
		},
	},
	AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, {
		name = AL["BC"],
		[NORMAL_DIFF] = {
			{ 1,  31907 }, -- Darkmoon Card: Vengeance
			{ 2,  31890 }, -- Darkmoon Card: Crusade
			{ 3,  31891 }, -- Darkmoon Card: Wrath
			{ 4,  31914 }, -- Darkmoon Card: Madness
		},
	}),
	AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
		name = AL["Wrath"],
		[NORMAL_DIFF] = {
			{ 1, 44276 },	-- Chaos Deck
			{ 2, 44259 },	-- Prisms Deck
			{ 3, 44294 },	-- Undeath Deck
			{ 4, 44326 },	-- Nobles Deck
		},
	}),
},
}

data["GurubashiArena"] = {
	name = AL["Gurubashi Arena"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- GurubashiArena
		name = AL["Gurubashi Arena"],
		[NORMAL_DIFF] = {
			{ 1,  18709 }, -- Arena Wristguards
			{ 2,  18710 }, -- Arena Bracers
			{ 3,  18711 }, -- Arena Bands
			{ 4,  18712 }, -- Arena Vambraces
			{ 16, 18706 }, -- Arena Master
		},
	},
},
}

data["FishingExtravaganza"] = {
	name = AL["Stranglethorn Fishing Extravaganza"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- FishingExtravaganza
		name = AL["Stranglethorn Fishing Extravaganza"],
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["First Prize"] },
			{ 2,  19970 }, -- Arcanite Fishing Pole
			{ 3,  19979 }, -- Hook of the Master Angler
			{ 5, "INV_Box_01", nil, AL["Rare Fish"] },
			{ 6,  19805 }, -- Keefer's Angelfish
			{ 7,  19803 }, -- Brownell's Blue Striped Racer
			{ 8,  19806 }, -- Dezian Queenfish
			{ 9,  19808 }, -- Rockhide Strongfish
			{ 20, "INV_Box_01", nil, AL["Rare Fish Rewards"] },
			{ 21, 19972 }, -- Lucky Fishing Hat
			{ 22, 19969 }, -- Nat Pagle's Extreme Anglin' Boots
			{ 23, 19971 }, -- High Test Eternium Fishing Line
		},
	},
},
}

data["LunarFestival"] = {
	name = AL["Lunar Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- LunarFestival1
		name = AL["Lunar Festival"],
		[NORMAL_DIFF] = {
			{ 1,  21100 }, -- Coin of Ancestry
			{ 3,  21157 }, -- Festive Green Dress
			{ 4,  21538 }, -- Festive Pink Dress
			{ 5,  21539 }, -- Festive Purple Dress
			{ 6,  21541 }, -- Festive Black Pant Suit
			{ 7,  21544 }, -- Festive Blue Pant Suit
			{ 8,  21543 }, -- Festive Teal Pant Suit
		},
	},
	{
		name = AL["Lunar Festival Fireworks Pack"],
		[NORMAL_DIFF] = {
			{ 1, 21558 }, -- Small Blue Rocket
			{ 2, 21559 }, -- Small Green Rocket
			{ 3, 21557 }, -- Small Red Rocket
			{ 4, 21561 }, -- Small White Rocket
			{ 5, 21562 }, -- Small Yellow Rocket
			{ 7, 21537 }, -- Festival Dumplings
			{ 8, 21713 }, -- Elune's Candle
			{ 16, 21589 }, -- Large Blue Rocket
			{ 17, 21590 }, -- Large Green Rocket
			{ 18, 21592 }, -- Large Red Rocket
			{ 19, 21593 }, -- Large White Rocket
			{ 20, 21595 }, -- Large Yellow Rocket
		}
	},
	{
		name = AL["Lucky Red Envelope"],
		[NORMAL_DIFF] = {
			{ 1, 21540 }, -- Elune's Lantern
			{ 2, 21536 }, -- Elune Stone
			{ 16, 21744 }, -- Lucky Rocket Cluster
			{ 17, 21745 }, -- Elder's Moonstone
		}
	},
	{ -- LunarFestival2
	name = AL["Plans"],
	[NORMAL_DIFF] = {
		{ 1,  21722 }, -- Pattern: Festival Dress
		{ 3,  21738 }, -- Schematic: Firework Launcher
		{ 5,  21724 }, -- Schematic: Small Blue Rocket
		{ 6,  21725 }, -- Schematic: Small Green Rocket
		{ 7,  21726 }, -- Schematic: Small Red Rocket
		{ 9, 21727 }, -- Schematic: Large Blue Rocket
		{ 10, 21728 }, -- Schematic: Large Green Rocket
		{ 11, 21729 }, -- Schematic: Large Red Rocket
		{ 16, 21723 }, -- Pattern: Festive Red Pant Suit
		{ 18, 21737 }, -- Schematic: Cluster Launcher
		{ 20, 21730 }, -- Schematic: Blue Rocket Cluster
		{ 21, 21731 }, -- Schematic: Green Rocket Cluster
		{ 22, 21732 }, -- Schematic: Red Rocket Cluster
		{ 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
		{ 25, 21734 }, -- Schematic: Large Green Rocket Cluster
		{ 26, 21735 }, -- Schematic: Large Red Rocket Cluster
	},
},
},
}

data["Valentineday"] = {
	name = AL["Love is in the Air"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Valentineday
		name = AL["Love is in the Air"],
		[NORMAL_DIFF] = {
			{ 1,  22206 }, -- Bouquet of Red Roses
			{ 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
			{ 4,  22279 }, -- Lovely Black Dress
			{ 5,  22235 }, -- Truesilver Shafted Arrow
			{ 6,  22200 }, -- Silver Shafted Arrow
			{ 7,  22261 }, -- Love Fool
			{ 8,  22218 }, -- Handful of Rose Petals
			{ 9,  21813 }, -- Bag of Candies
			{ 11, "INV_Box_02", nil, AL["Box of Chocolates"] },
			{ 12, 22237 }, -- Dark Desire
			{ 13, 22238 }, -- Very Berry Cream
			{ 14, 22236 }, -- Buttermilk Delight
			{ 15, 22239 }, -- Sweet Surprise
			{ 16, 22276 }, -- Lovely Red Dress
			{ 17, 22278 }, -- Lovely Blue Dress
			{ 18, 22280 }, -- Lovely Purple Dress
			{ 19, 22277 }, -- Red Dinner Suit
			{ 20, 22281 }, -- Blue Dinner Suit
			{ 21, 22282 }, -- Purple Dinner Suit
		},
	},
},
}
data["Noblegarden"] = {
	name = AL["Noblegarden"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Noblegarden
		name = AL["Brightly Colored Egg"],
		[NORMAL_DIFF] = {
			{ 1,  19028 }, -- Elegant Dress
			{ 2,  6833 }, -- White Tuxedo Shirt
			{ 3,  6835 }, -- Black Tuxedo Pants
			{ 16,  7807 }, -- Candy Bar
			{ 17,  7808 }, -- Chocolate Square
			{ 18,  7806 }, -- Lollipop
		},
	},
},
}

data["ChildrensWeek"] = {
	name = AL["Childrens Week"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ChildrensWeek
		name = AL["Childrens Week"],
		[NORMAL_DIFF] = {
			{ 1,  23007 }, -- Piglet's Collar
			{ 2,  23015 }, -- Rat Cage
			{ 3,  23002 }, -- Turtle Box
			{ 4,  23022 }, -- Curmudgeon's Payoff
		},
	},
},
}

data["MidsummerFestival"] = {
	name = AL["Midsummer Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- MidsummerFestival
		name = AL["Midsummer Festival"],
		[NORMAL_DIFF] = {
			{ 1,  23379 }, -- Cinder Bracers
			{ 3,  23323 }, -- Crown of the Fire Festival
			{ 4,  23324 }, -- Mantle of the Fire Festival
			{ 6,  23083 }, -- Captured Flame
			{ 7,  23247 }, -- Burning Blossom
			{ 8,  23246 }, -- Fiery Festival Brew
			{ 9,  23435 }, -- Elderberry Pie
			{ 10, 23327 }, -- Fire-toasted Bun
			{ 11, 23326 }, -- Midsummer Sausage
			{ 12, 23211 }, -- Toasted Smorc
		},
	},
},
}

data["HarvestFestival"] = {
	name = AL["Harvest Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- HarvestFestival
		name = AL["Harvest Festival"],
		[NORMAL_DIFF] = {
			{ 1,  19697 }, -- Bounty of the Harvest
			{ 2,  20009 }, -- For the Light!
			{ 3,  20010 }, -- The Horde's Hellscream
			{ 16,  19995 }, -- Harvest Boar
			{ 17,  19996 }, -- Harvest Fish
			{ 18,  19994 }, -- Harvest Fruit
			{ 19,  19997 }, -- Harvest Nectar
		},
	},
},
}

data["Halloween"] = {
	name = AL["Hallow's End"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.HALLOWEEN,
	items = {
		{ -- Halloween1
		name = AL["Hallow's End"].." - "..AL["Misc"],
		[NORMAL_DIFF] = {
			{ 1,  20400 }, -- Pumpkin Bag
			{ 3,  18633 }, -- Styleen's Sour Suckerpop
			{ 4,  18632 }, -- Moonbrook Riot Taffy
			{ 5,  18635 }, -- Bellara's Nutterbar
			{ 6,  20557 }, -- Hallow's End Pumpkin Treat
			{ 8,  20389 }, -- Candy Corn
			{ 9,  20388 }, -- Lollipop
			{ 10, 20390 }, -- Candy Bar
		},
	},
	{ -- Halloween1
	name = AL["Hallow's End"].." - "..AL["Wands"],
	[NORMAL_DIFF] = {
		{ 1, 20410 }, -- Hallowed Wand - Bat
		{ 2, 20409 }, -- Hallowed Wand - Ghost
		{ 3, 20399 }, -- Hallowed Wand - Leper Gnome
		{ 4, 20398 }, -- Hallowed Wand - Ninja
		{ 5, 20397 }, -- Hallowed Wand - Pirate
		{ 6, 20413 }, -- Hallowed Wand - Random
		{ 7, 20411 }, -- Hallowed Wand - Skeleton
		{ 8, 20414 }, -- Hallowed Wand - Wisp
	},
},
{ -- Halloween3
name = AL["Hallow's End"].." - "..AL["Masks"],
[NORMAL_DIFF] = {
	{ 1,  20561 }, -- Flimsy Male Dwarf Mask
	{ 2,  20391 }, -- Flimsy Male Gnome Mask
	{ 3,  20566 }, -- Flimsy Male Human Mask
	{ 4,  20564 }, -- Flimsy Male Nightelf Mask
	{ 5,  20570 }, -- Flimsy Male Orc Mask
	{ 6,  20572 }, -- Flimsy Male Tauren Mask
	{ 7,  20568 }, -- Flimsy Male Troll Mask
	{ 8,  20573 }, -- Flimsy Male Undead Mask
	{ 16, 20562 }, -- Flimsy Female Dwarf Mask
	{ 17, 20392 }, -- Flimsy Female Gnome Mask
	{ 18, 20565 }, -- Flimsy Female Human Mask
	{ 19, 20563 }, -- Flimsy Female Nightelf Mask
	{ 20, 20569 }, -- Flimsy Female Orc Mask
	{ 21, 20571 }, -- Flimsy Female Tauren Mask
	{ 22, 20567 }, -- Flimsy Female Troll Mask
	{ 23, 20574 }, -- Flimsy Female Undead Mask
},
},
},
}

data["WinterVeil"] = {
	name = AL["Feast of Winter Veil"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Winterviel1
		name = AL["Misc"],
		[NORMAL_DIFF] = {
			{ 1,  21525 }, -- Green Winter Hat
			{ 2,  21524 }, -- Red Winter Hat
			{ 16,  17712 }, -- Winter Veil Disguise Kit
			{ 17,  17202 }, -- Snowball
			{ 18,  21212 }, -- Fresh Holly
			{ 19,  21519 }, -- Mistletoe
		},
	},
	{
		name = AL["Gaily Wrapped Present"],
		[NORMAL_DIFF] = {
			{ 1, 21301 }, -- Green Helper Box
			{ 2, 21308 }, -- Jingling Bell
			{ 3, 21305 }, -- Red Helper Box
			{ 4, 21309 }, -- Snowman Kit
		},
	},
	{
		name = AL["Festive Gift"],
		[NORMAL_DIFF] = {
			{ 1, 21328 }, -- Wand of Holiday Cheer
		},
	},
	{
		name = AL["Smokywood Pastures Special Gift"],
		[NORMAL_DIFF] = {
			{ 1, 17706 }, -- Plans: Edge of Winter
			{ 2, 17725 }, -- Formula: Enchant Weapon - Winter's Might
			{ 3, 17720 }, -- Schematic: Snowmaster 9000
			{ 4, 17722 }, -- Pattern: Gloves of the Greatfather
			{ 5, 17709 }, -- Recipe: Elixir of Frost Power
			{ 6, 17724 }, -- Pattern: Green Holiday Shirt
			{ 16, 21325 }, -- Mechanical Greench
			{ 17, 21213 }, -- Preserved Holly
		},
	},
	{
		name = AL["Gently Shaken Gift"],
		[NORMAL_DIFF] = {
			{ 1, 21235 }, -- Winter Veil Roast
			{ 2, 21241 }, -- Winter Veil Eggnog
		},
	},
	{
		name = AL["Smokywood Pastures"],
		[NORMAL_DIFF] = {
			{ 1,  17201 }, -- Recipe: Egg Nog
			{ 2,  17200 }, -- Recipe: Gingerbread Cookie
			{ 3,  17344 }, -- Candy Cane
			{ 4,  17406 }, -- Holiday Cheesewheel
			{ 5,  17407 }, -- Graccu's Homemade Meat Pie
			{ 6,  17408 }, -- Spicy Beefstick
			{ 7,  17404 }, -- Blended Bean Brew
			{ 8,  17405 }, -- Green Garden Tea
			{ 9, 17196 }, -- Holiday Spirits
			{ 10, 17403 }, -- Steamwheedle Fizzy Spirits
			{ 11, 17402 }, -- Greatfather's Winter Ale
			{ 12, 17194 }, -- Holiday Spices
			{ 16, 17303 }, -- Blue Ribboned Wrapping Paper
			{ 17, 17304 }, -- Green Ribboned Wrapping Paper
			{ 18, 17307 }, -- Purple Ribboned Wrapping Paper
		},
	},
},
}

data["ElementalInvasions"] = {
	name = AL["Elemental Invasions"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 2.5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ElementalInvasion
		name = AL["Elemental Invasions"],
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Baron Charr"] },
			{ 2,  18671 }, -- Baron Charr's Sceptre
			{ 3,  19268 }, -- Ace of Elementals
			{ 4,  18672 }, -- Elemental Ember
			{ 6, "INV_Box_01", nil, AL["Princess Tempestria"] },
			{ 7,  18678 }, -- Tempestria's Frozen Necklace
			{ 8,  19268 }, -- Ace of Elementals
			{ 9,  21548 }, -- Pattern: Stormshroud Gloves
			{ 10, 18679 }, -- Frigid Ring
			{ 16, "INV_Box_01", nil, AL["Avalanchion"] },
			{ 17, 18673 }, -- Avalanchion's Stony Hide
			{ 18, 19268 }, -- Ace of Elementals
			{ 19, 18674 }, -- Hardened Stone Band
			{ 21, "INV_Box_01", nil, AL["The Windreaver"] },
			{ 22, 18676 }, -- Sash of the Windreaver
			{ 23, 19268 }, -- Ace of Elementals
			{ 24, 21548 }, -- Pattern: Stormshroud Gloves
			{ 25, 18677 }, -- Zephyr Cloak
		},
	},
},
}

data["SilithusAbyssal"] = {
	name = AL["Silithus Abyssal"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 4,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- AbyssalDukes
		name = AL["Abyssal Dukes"],
		[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["The Duke of Cynders"] },
			{ 2,  20665 }, -- Abyssal Leather Leggings
			{ 3,  20666 }, -- Hardened Steel Warhammer
			{ 4,  20514 }, -- Abyssal Signet
			{ 5,  20664 }, -- Abyssal Cloth Sash
			{ 8, "INV_Box_01", nil, AL["The Duke of Fathoms"] },
			{ 9,  20668 }, -- Abyssal Mail Legguards
			{ 10, 20669 }, -- Darkstone Claymore
			{ 11, 20514 }, -- Abyssal Signet
			{ 12, 20667 }, -- Abyssal Leather Belt
			{ 16, "INV_Box_01", nil, AL["The Duke of Zephyrs"] },
			{ 17, 20674 }, -- Abyssal Cloth Pants
			{ 18, 20675 }, -- Soulrender
			{ 19, 20514 }, -- Abyssal Signet
			{ 20, 20673 }, -- Abyssal Plate Girdle
			{ 23, "INV_Box_01", nil, AL["The Duke of Shards"] },
			{ 24, 20671 }, -- Abyssal Plate Legplates
			{ 25, 20672 }, -- Sparkling Crystal Wand
			{ 26, 20514 }, -- Abyssal Signet
			{ 27, 20670 }, -- Abyssal Mail Clutch
		},
	},
	{ -- AbyssalLords
	name = AL["Abyssal Lords"],
	[NORMAL_DIFF] = {
		{ 1, "INV_Box_01", nil, AL["Prince Skaldrenox"] },
		{ 2,  20682 }, -- Elemental Focus Band
		{ 3,  20515 }, -- Abyssal Scepter
		{ 4,  20681 }, -- Abyssal Leather Bracers
		{ 5,  20680 }, -- Abyssal Mail Pauldrons
		{ 7, "INV_Box_01", nil, AL["Lord Skwol"] },
		{ 8,  20685 }, -- Wavefront Necklace
		{ 9,  20515 }, -- Abyssal Scepter
		{ 10, 20684 }, -- Abyssal Mail Armguards
		{ 11, 20683 }, -- Abyssal Plate Epaulets
		{ 16, "INV_Box_01", nil, AL["High Marshal Whirlaxis"] },
		{ 17, 20691 }, -- Windshear Cape
		{ 18, 20515 }, -- Abyssal Scepter
		{ 19, 20690 }, -- Abyssal Cloth Wristbands
		{ 20, 20689 }, -- Abyssal Leather Shoulders
		{ 22, "INV_Box_01", nil, AL["Baron Kazum"] },
		{ 23, 20688 }, -- Earthen Guard
		{ 24, 20515 }, -- Abyssal Scepter
		{ 25, 20686 }, -- Abyssal Cloth Amice
		{ 26, 20687 }, -- Abyssal Plate Vambraces
	},
},
{ -- AbyssalTemplars
name = AL["Abyssal Templars"],
[NORMAL_DIFF] = {
	{ 1, "INV_Box_01", nil, AL["Crimson Templar"] },
	{ 2,  20657 }, -- Crystal Tipped Stiletto
	{ 3,  20655 }, -- Abyssal Cloth Handwraps
	{ 4,  20656 }, -- Abyssal Mail Sabatons
	{ 5,  20513 }, -- Abyssal Crest
	{ 7, "INV_Box_01", nil, AL["Azure Templar"] },
	{ 8,  20654 }, -- Amethyst War Staff
	{ 9,  20653 }, -- Abyssal Plate Gauntlets
	{ 10, 20652 }, -- Abyssal Cloth Slippers
	{ 11, 20513 }, -- Abyssal Crest
	{ 16, "INV_Box_01", nil, AL["Hoary Templar"] },
	{ 17, 20660 }, -- Stonecutting Glaive
	{ 18, 20659 }, -- Abyssal Mail Handguards
	{ 19, 20658 }, -- Abyssal Leather Boots
	{ 20, 20513 }, -- Abyssal Crest
	{ 22, "INV_Box_01", nil, AL["Earthen Templar"] },
	{ 23, 20663 }, -- Deep Strike Bow
	{ 24, 20661 }, -- Abyssal Leather Gloves
	{ 25, 20662 }, -- Abyssal Plate Greaves
	{ 26, 20513 }, -- Abyssal Crest
},
},
},
}

data["AQOpening"] = {
	name = AL["AQ opening"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["AQ opening"],
			[NORMAL_DIFF] = {
				{ 1,  21138 }, -- Red Scepter Shard
				{ 2,  21529 }, -- Amulet of Shadow Shielding
				{ 3,  21530 }, -- Onyx Embedded Leggings
				{ 5,  21139 }, -- Green Scepter Shard
				{ 6,  21531 }, -- Drake Tooth Necklace
				{ 7,  21532 }, -- Drudge Boots
				{ 9,  21137 }, -- Blue Scepter Shard
				{ 10, 21517 }, -- Gnomish Turban of Psychic Might
				{ 11, 21527 }, -- Darkwater Robes
				{ 12, 21526 }, -- Band of Icy Depths
				{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
				{ 16, 21175 }, -- The Scepter of the Shifting Sands
				{ 17, 21176 }, -- Black Qiraji Resonating Crystal
				{ 18, 21523 }, -- Fang of Korialstrasz
				{ 19, 21521 }, -- Runesword of the Red
				{ 20, 21522 }, -- Shadowsong's Sorrow
				{ 21, 21520 }, -- Ravencrest's Legacy
			},
		},
	},
}

data["ScourgeInvasion"] = {
	name = AL["Scourge Invasion"],
	ContentType = WORLD_EVENT_CONTENT,
	-- LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 6,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.SCOURGE_INVASION,
	items = {
		{ -- ScourgeInvasionEvent1
		name = AL["Scourge Invasion - Equipment"],
		[SOD_DIFF] = {
			-- Cloth
			{ 1,  236718 }, -- Robe of Undead Cleansing
			{ 2,  236716 }, -- Bracers of Undead Cleansing
			{ 3,  236717 }, -- Gloves of Undead Cleansing

			{ 5, 236721 }, -- Robe of Undead Purification
			{ 6, 236719 }, -- Bracers of Undead Purification
			{ 7, 236720 }, -- Gloves of Undead Purification

			{ 9, 236724 }, -- Robe of Undead Warding
			{ 10, 236722 }, -- Bracers of Undead Warding
			{ 11, 236723 }, -- Gloves of Undead Warding

			-- Leather
			{ 13, 236707 }, -- Tunic of Undead Slaying
			{ 14, 236711 }, -- Wristwraps of Undead Slaying
			{ 15, 236713 }, -- Handwraps of Undead Slaying

			{ 16, 236730 }, -- Tunic of Undead Purification
			{ 17, 236728 }, -- Wristwraps of Undead Purification
			{ 18, 236729 }, -- Handwraps of Undead Purification

			{ 20, 236733 },  -- Tunic of Undead Warding
			{ 21, 236731 },  -- Wristwraps of Undead Warding
			{ 22, 236732 },  -- Handwraps of Undead Warding

			{ 24, 236727 }, -- Tunic of Undead Cleansing
			{ 25, 236725 }, -- Wristwraps of Undead Cleansing
			{ 26, 236726 }, -- Handwraps of Undead Cleansing

			{ 30, "INV_Box_01", nil, AL["Continued -->"], nil },

			-- Mail
			{ 101, 236709 }, -- Chestguard of Undead Slaying
			{ 102, 236710 }, -- Wristguards of Undead Slaying
			{ 103, 236715 }, -- Handguards of Undead Slaying

			{ 105, 236736 }, -- Chestguard of Undead Cleansing
			{ 106, 236734 }, -- Wristguards of Undead Cleansing
			{ 107, 236735 }, -- Handguards of Undead Cleansing

			{ 109, 236739 }, -- Chestguard of Undead Warding
			{ 110, 236737 }, -- Wristguards of Undead Warding
			{ 111, 236738 }, -- Handguards of Undead Warding

			{ 113, 236742 }, -- Chestguard of Undead Purification
			{ 114, 236741 }, -- Handguards of Undead Purification
			{ 115, 236740 }, -- Wristguards of Undead Purification

			-- Plate
			{ 116, 236708 }, -- Breastplate of Undead Slaying
			{ 117, 236712 }, -- Bracers of Undead Slaying
			{ 118, 236714 }, -- Gauntlets of Undead Slaying

			{ 120, 236748 }, -- Breastplate of Undead Warding
			{ 121, 236746 }, -- Bracers of Undead Warding
			{ 122, 236747 }, -- Gauntlets of Undead Warding

			{ 124, 236745 }, -- Breastplate of Undead Purification
			{ 125, 236743 }, -- Bracers of Undead Purification
			{ 126, 236744 }, -- Gauntlets of Undead Purification
		},
		[NORMAL_DIFF] = {
			{ 1,  23085 }, -- Robe of Undead Cleansing
			{ 2,  23091 }, -- Bracers of Undead Cleansing
			{ 3,  23084 }, -- Gloves of Undead Cleansing

			{ 5, 23089 }, -- Tunic of Undead Slaying
			{ 6, 23093 }, -- Wristwraps of Undead Slaying
			{ 7, 23081 }, -- Handwraps of Undead Slaying

			{ 16, 23088 }, -- Chestguard of Undead Slaying
			{ 17, 23092 }, -- Wristguards of Undead Slaying
			{ 18, 23082 }, -- Handguards of Undead Slaying

			{ 20, 23087 }, -- Breastplate of Undead Slaying
			{ 21, 23090 }, -- Bracers of Undead Slaying
			{ 22, 23078 }, -- Gauntlets of Undead Slaying
		},
	},
	{
		name = AL["Scourge Invasion - Misc"],
		[SOD_DIFF] = {
			{ 1,  238234 }, -- Blessed Wizard Oil
			{ 2,  238241 }, -- Consecrated Sharpening Stone
			{ 3,  22484 }, -- Necrotic Rune

			{ 5,  22999 }, -- Tabard of the Argent Dawn

			{ 16, 23194 }, -- Lesser Mark of the Dawn
			{ 17, 23195 }, -- Mark of the Dawn
			{ 18, 23196 }, -- Greater Mark of the Dawn
		},
		[NORMAL_DIFF] = {
			{ 1,  23123 }, -- Blessed Wizard Oil
			{ 2,  23122 }, -- Consecrated Sharpening Stone
			{ 3,  22484 }, -- Necrotic Rune

			{ 5,  22999 }, -- Tabard of the Argent Dawn

			{ 16, 23194 }, -- Lesser Mark of the Dawn
			{ 17, 23195 }, -- Mark of the Dawn
			{ 18, 23196 }, -- Greater Mark of the Dawn
		},
	},
	{
		name = C_Map_GetAreaInfo(2017).." - "..AL["Balzaphon"],
		[SOD_DIFF] = {
			{ 1,  238356 }, -- Waistband of Balzaphon
			{ 2,  238355 }, -- Chains of the Lich
			{ 3,  238357 }, -- Staff of Balzaphon
		},
		[NORMAL_DIFF] = {
			{ 1,  23126 }, -- Waistband of Balzaphon
			{ 2,  23125 }, -- Chains of the Lich
			{ 3,  23124 }, -- Staff of Balzaphon
		}
	},
	{
		name = C_Map_GetAreaInfo(2057).." - "..AL["Lord Blackwood"],
		[SOD_DIFF] = {
			{ 1,  238361 }, -- Lord Blackwood's Blade
			{ 2,  238358 }, -- Blackwood's Thigh
			{ 3,  238360 }, -- Lord Blackwood's Buckler
		},
		[NORMAL_DIFF] = {
			{ 1,  23132 }, -- Lord Blackwood's Blade
			{ 2,  23156 }, -- Blackwood's Thigh
			{ 3,  23139 }, -- Lord Blackwood's Buckler
		}
	},
	{
		name = C_Map_GetAreaInfo(2557).." - "..AL["Revanchion"],
		[SOD_DIFF] = {
			{ 1, 238364 }, -- Cloak of Revanchion
			{ 2, 238362 }, -- Bracers of Mending
			{ 3, 238363 }, -- The Shadow's Grasp
		},
		[NORMAL_DIFF] = {
			{ 1, 23127 }, -- Cloak of Revanchion
			{ 2, 23129 }, -- Bracers of Mending
			{ 3, 23128 }, -- The Shadow's Grasp
		}
	},
	{
		name = AL["Scarlet Monastery - Graveyard"].." - "..AL["Scorn"],
		[SOD_DIFF] = {
			{ 1, 238352 }, -- Scorn's Icy Choker
			{ 2, 238351 }, -- The Frozen Clutch
			{ 3, 238350 }, -- Scorn's Focal Dagger
		},
		[NORMAL_DIFF] = {
			{ 1, 23169 }, -- Scorn's Icy Choker
			{ 2, 23170 }, -- The Frozen Clutch
			{ 3, 23168 }, -- Scorn's Focal Dagger
		}
	},
	{
		name = C_Map_GetAreaInfo(209).." - "..AL["Sever"],
		[SOD_DIFF] = {
			{ 1, 238349 }, -- Abomination Skin Leggings
			{ 2, 238348 }, -- The Axe of Severing
		},
		[NORMAL_DIFF] = {
			{ 1, 23173 }, -- Abomination Skin Leggings
			{ 2, 23171 }, -- The Axe of Severing
		}
	},
	{
		name = C_Map_GetAreaInfo(722).." - "..AL["Lady Falther'ess"],
		[SOD_DIFF] = {
			{ 1, 238353 }, -- Mantle of Lady Falther'ess
			{ 2, 238354 }, -- Lady Falther'ess' Finger
		},
		[NORMAL_DIFF] = {
			{ 1, 23178 }, -- Mantle of Lady Falther'ess
			{ 2, 23177 }, -- Lady Falther'ess' Finger
		}
	},
},
}
