-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  COMPATIBLE: DELTA | CODEX | FLUXUS | ARCEUS X | PC & MOBILE EXECUTORS
--  PART 1 / 15 : BOOTSTRAP, EXECUTOR COMPAT LAYER, CONFIG, CONSTANTS & STATE
-- ========================================================================= --

print("👑 [ZAYN SOCIAL V100] Booting Titanguard Ultimate (Universal Executor Edition)...")

local ENV = (type(getgenv) == "function" and getgenv()) or _G

-- Clean unload of any prior V100 / V80 / V70 instance (prevents duplicate GUIs & leaks)
if type(ENV) == "table" then
	if ENV.ZaynV100_Loaded then
		ENV.ZaynV100_Unloading = true
		if type(ENV.ZaynV100_Cleanup) == "function" then
			pcall(ENV.ZaynV100_Cleanup)
		end
		task.wait(0.25)
		pcall(function()
			local roots = {}
			if type(gethui) == "function" then
				local ok, h = pcall(gethui)
				if ok and h then table.insert(roots, h) end
			end
			pcall(function() table.insert(roots, game:GetService("CoreGui")) end)
			local lp = game:GetService("Players").LocalPlayer
			if lp then
				local pg = lp:FindFirstChildOfClass("PlayerGui")
				if pg then table.insert(roots, pg) end
			end
			for _, root in ipairs(roots) do
				for _, child in ipairs(root:GetChildren()) do
					if child.Name:match("^ZaynV100_") or child.Name:match("^ZaynSocialV80_") or child.Name:match("^MatrixUI_") then
						child:Destroy()
					end
				end
			end
		end)
	end
	ENV.ZaynV100_Loaded = true
	ENV.ZaynV100_Unloading = false
end

-- ========================================================================= --
-- [SECTION A : ROBLOX SERVICES (TIMEOUT-SAFE)]
-- ========================================================================= --
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")
local UserService = pcall(function() return game:GetService("UserService") end) and game:GetService("UserService") or nil

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	local t0 = os.clock()
	repeat
		task.wait(0.1)
		LocalPlayer = Players.LocalPlayer
	until LocalPlayer or (os.clock() - t0 > 15)
end
if not LocalPlayer then
	warn("[ZAYN V100] LocalPlayer not available. Aborting boot.")
	return
end

-- ========================================================================= --
-- [SECTION B : UNIVERSAL EXECUTOR COMPATIBILITY LAYER (DELTA / CODEX / FLUXUS)]
-- ========================================================================= --
local Exec = {}

Exec.Name = (type(identifyexecutor) == "function" and pcall(identifyexecutor) and identifyexecutor())
	or (type(getexecutorname) == "function" and pcall(getexecutorname) and getexecutorname())
	or "Universal_Executor"

Exec.Request = (syn and syn.request)
	or (http and http.request)
	or http_request
	or (fluxus and fluxus.request)
	or (type(getgenv) == "function" and (getgenv().request or getgenv().http_request))
	or request

if type(Exec.Request) ~= "function" then
	warn("[ZAYN V100] Fatal: This executor does not expose an HTTP request() function!")
	return
end

Exec.HasFiles = (type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function")
Exec.WriteFile = type(writefile) == "function" and writefile or nil
Exec.ReadFile = type(readfile) == "function" and readfile or nil
Exec.IsFile = type(isfile) == "function" and isfile or nil
Exec.DelFile = type(delfile) == "function" and delfile or nil
Exec.MakeFolder = type(makefolder) == "function" and makefolder or nil
Exec.IsFolder = type(isfolder) == "function" and isfolder or nil
Exec.GetCustomAsset = (type(getcustomasset) == "function" and getcustomasset)
	or (type(getsynasset) == "function" and getsynasset)
	or nil
Exec.SetClipboard = (type(setclipboard) == "function" and setclipboard)
	or (type(toclipboard) == "function" and toclipboard)
	or nil

function Exec.GetGuiRoot()
	if type(gethui) == "function" then
		local ok, hui = pcall(gethui)
		if ok and hui then return hui end
	end
	local okCG, cg = pcall(function() return game:GetService("CoreGui") end)
	if okCG and cg then
		local testOk = pcall(function()
			local probe = Instance.new("Folder")
			probe.Parent = cg
			probe:Destroy()
		end)
		if testOk then return cg end
	end
	return LocalPlayer:WaitForChild("PlayerGui", 10)
end

function Exec.GetHWID()
	local hw = ""
	if type(gethwid) == "function" then pcall(function() hw = tostring(gethwid()) end) end
	if hw == "" and type(getgenv) == "function" and type(getgenv().gethwid) == "function" then
		pcall(function() hw = tostring(getgenv().gethwid()) end)
	end
	if hw == "" then
		pcall(function() hw = tostring(game:GetService("RbxAnalyticsService"):GetClientId()) end)
	end
	if hw == "" or hw == "nil" then
		hw = "UID_FALLBACK_" .. tostring(LocalPlayer.UserId)
	end
	return hw:gsub("[^%w_]", "")
end

-- Create organized local cache folder on executors that support folders
Exec.CacheDir = "ZaynSocialV100_Cache"
if Exec.MakeFolder and Exec.IsFolder then
	pcall(function()
		if not Exec.IsFolder(Exec.CacheDir) then
			Exec.MakeFolder(Exec.CacheDir)
		end
	end)
end

-- ========================================================================= --
-- [SECTION C : MASTER NAMESPACE (Z100) — CLEAN MODULAR ARCHITECTURE]
-- ========================================================================= --
local Z100 = {
	Version = "V100.0 TITANGUARD ULTIMATE",
	Exec = Exec,
	Services = {
		Players = Players,
		Http = HttpService,
		Tween = TweenService,
		Run = RunService,
		UIS = UserInputService,
		Lighting = Lighting,
		Sound = SoundService,
		Gui = GuiService,
		User = UserService,
	},
	Player = LocalPlayer,
	MyUid = tostring(LocalPlayer.UserId),
	MyName = LocalPlayer.Name,
	MyNameLower = LocalPlayer.Name:lower(),
	HWID = Exec.GetHWID(),

	-- Configuration (Direct Firebase RTDB + Online RapidAPI YT MP3 + Paid Store)
	Config = {
		FirebaseURL = "https://maybe-c8f31-ugswub-swnnkwn-wj-default-rtdb.asia-southeast1.firebasedatabase.app",
		AdminUIDs = {
			["10432865434"] = true, -- Primary Owner
		},
		AdminUsernames = {
			["erennn0779"] = true,
			["izayn"] = true,
		},
		Store = {
			DecorationPriceINR = 300,
			ThemePriceINR = 300,
			BundlePriceINR = 300,
			MusicStudioPriceINR = 1500,
			DiscordContact = "official_zayn",
			DiscordServer = "ZAYN UI LAB (@official_zayn)",
			DiscordURL = "",
			StrictPaid = true, -- Zero free cosmetics
		},
		MusicAPI = {
			RapidAPIKey = "fa93ec4e71msh947ba16ba8432ffp1e591ejsn4cf16a0f0dca",
			SearchHost = "youtube-search-and-download.p.rapidapi.com",
			Mp3Host = "youtube-mp36.p.rapidapi.com",
			AltMp3Host = "yt-search-and-download-mp3.p.rapidapi.com",
			MaxResults = 10,
		},
		Limits = {
			DisplayNameMax = 28,
			BioMax = 150,
			MessageMax = 360,
			StoryCaptionMax = 160,
			StoryOverlayMax = 80,
			StoryTTL = 86400, -- 24 hours
			ServerChatTTL = 600,
			DMTTL = 259200, -- 72 hours
			ChatCooldown = 2.0,
			SearchCooldown = 2.0,
		},
		Breakpoints = {
			MobileMax = 650,
			TabletMax = 940,
		},
	},

	-- Database Node Paths (Preserves V70 Chat + Clean V100 Social Nodes)
	Nodes = {
		ServerChat = "LOGISTICS_PIPELINE_CENTRAL_SRV",
		DMs = "SECURE_TELEMETRY_DMS_CORE",
		ReadReceipts = "READ_RECEIPTS_METLOCK",
		Blacklist = "ACCESS_CONTROL_BLACKLIST_DB",
		Locks = "SUSPENSION_STATE_CONTAINERS",
		Broadcasts = "EMERGENCY_OVERLAY_BROADCASTS",
		Forensics = "THREAT_ANALYSIS_FORENSIC_LOGS",

		Profiles = "ZAYN_V100_PROFILES",
		Followers = "ZAYN_V100_FOLLOWERS",
		Following = "ZAYN_V100_FOLLOWING",
		FollowRequests = "ZAYN_V100_FOLLOW_REQUESTS",
		Blocks = "ZAYN_V100_BLOCKS",
		Reports = "ZAYN_V100_REPORTS",
		Notifs = "ZAYN_V100_NOTIFS",
		Presence = "ZAYN_V100_PRESENCE",
		UserIndex = "ZAYN_V100_USER_INDEX",
		Stories = "ZAYN_V100_STORIES",
		StoryViews = "ZAYN_V100_STORY_VIEWS",
		StoryReports = "ZAYN_V100_STORY_REPORTS",
		MusicLib = "ZAYN_V100_MUSIC_LIB",
		Entitlements = "ZAYN_V100_ENTITLEMENTS",
		PurchaseTickets = "ZAYN_V100_TICKETS",
		StoreConfig = "ZAYN_V100_STORE_CONFIG",
		AdminLogs = "ZAYN_V100_ADMIN_LOGS",
	},

	-- Constants & Screen Enums
	Const = {
		Screens = {
			Home = "Home",
			Messages = "Messages",
			Notifications = "Notifications",
			Stories = "Stories",
			Profile = "Profile",
			ProfileEditor = "ProfileEditor",
			StoryEditor = "StoryEditor",
			MusicStudio = "MusicStudio",
			PremiumStore = "PremiumStore",
			Settings = "Settings",
			Admin = "Admin",
		},
		NavItems = {
			{ Id = "Home",          Label = "Home",    Icon = "⌂" },
			{ Id = "Messages",      Label = "Chat",    Icon = "✉" },
			{ Id = "Notifications", Label = "Alerts",  Icon = "🔔" },
			{ Id = "Stories",       Label = "Stories", Icon = "◎" },
			{ Id = "Profile",       Label = "Profile", Icon = "◉" },
			{ Id = "MusicStudio",   Label = "Music",   Icon = "♫" },
			{ Id = "PremiumStore",  Label = "Store",   Icon = "♛" },
			{ Id = "Settings",      Label = "Settings",Icon = "⚙" },
		},
	},

	-- Sub-module containers populated across Parts 2 to 15
	Util = {},
	Crypto = {},
	DB = {},
	Security = {},
	Theme = {},
	Components = {},
	Catalog = {},
	Anim = {},
	Backend = {},
	Stories = {},
	Music = {},
	Chat = {},
	UI = {},
	Screens = {},
	Admin = {},
	Router = {},

	-- Reactive Runtime State
	State = {
		ActiveScreen = "Home",
		ScreenHistory = {},
		DeviceClass = "Desktop", -- Desktop | Tablet | Mobile
		ChatSubMode = "Server",  -- Server | DM_Inbox | DM | CloseFriends
		ActiveDM = nil,
		ViewingProfileUid = tostring(LocalPlayer.UserId),
		StoreTab = "Decorations",
		AdminTab = "Tickets",

		-- User Preferences (Saved locally & synced to profile settings)
		Prefs = {
			DesignMode = "Standard",        -- Standard | Premium (if owned)
			AnimIntensity = "High",         -- High | Medium | Low
			ReduceMotion = false,
			ParticlesEnabled = true,
			UIScale = 1.0,
			MusicVolume = 0.7,
			StoryAudioEnabled = true,
			MuteAllAudio = false,
			NotifyMessages = true,
			NotifyFollows = true,
			NotifyStories = true,
		},

		-- Live Caches
		IsLocked = false,
		LastSendClock = 0,
		LastMusicSearchClock = 0,
		ReplyingTo = nil,
		EditingMsgID = nil,
		JobId = (game.JobId ~= "" and game.JobId or "STUDIO_SESSION_100"):gsub("[^%w_]", ""),
		SeenMsgIds = {},
		ActiveBubbles = {},
		Cache = { Server = {}, DMs = {} },
		CloseFriends = {},
		Vault = {},

		-- Social & Store Caches
		Profiles = {},
		Followers = {},
		Following = {},
		Requests = {},
		SentRequests = {},
		Blocks = {},
		BlockedBy = {},
		Presence = {},
		Notifs = {},
		SeenNotifIds = {},
		UnreadNotifs = 0,
		StoriesByUid = {},
		SeenStoryIds = {},
		MusicLibrary = {},
		MusicSearchResults = {},
		Entitlements = {},
		StoreConfig = {
			decorationPriceINR = 300,
			themePriceINR = 300,
			bundlePriceINR = 300,
			musicPassPriceINR = 1500,
			discordContact = "official_zayn",
			discordServer = "ZAYN UI LAB (@official_zayn)",
			discordURL = "",
			disabledDecorations = {},
			disabledThemes = {},
			priceOverrides = {},
		},

		-- Live Preview Overrides (Store / Editor)
		PreviewDecoration = nil,
		PreviewTheme = nil,
	},

	-- Internal connection & animation registries
	_conns = {},
	_anims = {},
	_animIdSeq = 0,
	_screenCleanup = {},
	_burst = { Count = 0, Window = 0 },
}

-- Master Cleanup Hook (Zero Memory Leaks on Re-Execute or Destroy)
ENV.ZaynV100_Cleanup = function()
	ENV.ZaynV100_Unloading = true
	for _, conn in ipairs(Z100._conns) do
		pcall(function() conn:Disconnect() end)
	end
	table.clear(Z100._conns)
	table.clear(Z100._anims)
	for _, fn in ipairs(Z100._screenCleanup) do
		pcall(fn)
	end
	table.clear(Z100._screenCleanup)
	pcall(function()
		for _, sName in ipairs({ "ZaynV100_MusicAudio", "ZaynV100_StoryAudio" }) do
			local s = SoundService:FindFirstChild(sName)
			if s then s:Stop(); s:Destroy() end
		end
	end)
	pcall(function()
		local bl = Lighting:FindFirstChild("ZaynV100_Blur")
		if bl then bl:Destroy() end
	end)
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 2 / 15 : UTILS, CRYPTO, DIRECT FIREBASE RTDB, MEDIA CACHE & SCHEDULER
-- ========================================================================= --

do
	local Players = Z100.Services.Players
	local HttpService = Z100.Services.Http
	local RunService = Z100.Services.Run
	local UserService = Z100.Services.User
	local Exec = Z100.Exec
	local LocalPlayer = Z100.Player

	-- ===================================================================== --
	-- [SECTION A : CORE UTILITIES & LOCAL EXECUTOR STORAGE]
	-- ===================================================================== --
	function Z100.Util.TrackConn(conn)
		if conn then
			table.insert(Z100._conns, conn)
		end
		return conn
	end

	function Z100.Util.TrackScreenCleanup(fn)
		if type(fn) == "function" then
			table.insert(Z100._screenCleanup, fn)
		end
	end

	function Z100.Util.RunScreenCleanup()
		for _, fn in ipairs(Z100._screenCleanup) do
			pcall(fn)
		end
		table.clear(Z100._screenCleanup)
	end

	function Z100.Util.Now()
		return os.time()
	end

	function Z100.Util.RandomGuiName()
		local chars = {}
		for i = 1, 12 do
			chars[i] = string.char(math.random(65, 90))
		end
		return "ZaynV100_" .. table.concat(chars)
	end

	function Z100.Util.NormalizeUid(uid)
		local str = tostring(uid or ""):gsub("[^%d]", "")
		local num = tonumber(str)
		if str == "" or not num or num <= 0 then
			return nil
		end
		return str
	end

	function Z100.Util.CountKeys(tbl)
		if type(tbl) ~= "table" then return 0 end
		local count = 0
		for _, v in pairs(tbl) do
			if v ~= nil and v ~= false then
				count = count + 1
			end
		end
		return count
	end

	function Z100.Util.DeepEqual(a, b)
		local ta, tb = type(a), type(b)
		if ta ~= tb then return false end
		if ta ~= "table" then return a == b end
		for k, v in pairs(a) do
			if b[k] == nil or not Z100.Util.DeepEqual(v, b[k]) then return false end
		end
		for k, v in pairs(b) do
			if a[k] == nil or not Z100.Util.DeepEqual(v, a[k]) then return false end
		end
		return true
	end

	function Z100.Util.FormatNumber(n)
		local num = math.floor(tonumber(n) or 0)
		local s = tostring(num)
		while true do
			local k
			s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
			if k == 0 then break end
		end
		return s
	end

	function Z100.Util.FormatDuration(seconds)
		local s = math.max(0, math.floor(tonumber(seconds) or 0))
		local m = math.floor(s / 60)
		local rem = s % 60
		return string.format("%d:%02d", m, rem)
	end

	function Z100.Util.TimeAgo(ts)
		local diff = math.max(0, Z100.Util.Now() - (tonumber(ts) or Z100.Util.Now()))
		if diff < 60 then
			return "Just now"
		elseif diff < 3600 then
			return tostring(math.floor(diff / 60)) .. "m ago"
		elseif diff < 86400 then
			return tostring(math.floor(diff / 3600)) .. "h ago"
		else
			return tostring(math.floor(diff / 86400)) .. "d ago"
		end
	end

	function Z100.Util.GenerateKey(len)
		local pool = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		local out = {}
		for i = 1, (len or 16) do
			local r = math.random(1, #pool)
			out[i] = pool:sub(r, r)
		end
		return table.concat(out)
	end

	function Z100.Util.URLEncode(str)
		local ok, encoded = pcall(function() return HttpService:UrlEncode(tostring(str or "")) end)
		if ok and type(encoded) == "string" then
			return encoded
		end
		return (tostring(str or ""):gsub("([^%w%-_%.~])", function(c)
			return string.format("%%%02X", string.byte(c))
		end))
	end

	function Z100.Util.IsAdmin(uid, username)
		local uStr = Z100.Util.NormalizeUid(uid or LocalPlayer.UserId)
		local uLow = tostring(username or LocalPlayer.Name):lower()
		return (uStr ~= nil and Z100.Config.AdminUIDs[uStr] == true)
			or (Z100.Config.AdminUsernames[uLow] == true)
	end

	function Z100.Util.CopyText(str)
		if not Exec.SetClipboard then return false end
		local ok = pcall(Exec.SetClipboard, tostring(str or ""))
		return ok
	end

	function Z100.Util.EscapeRichText(str)
		return tostring(str or "")
			:gsub("&", "&amp;")
			:gsub("<", "&lt;")
			:gsub(">", "&gt;")
	end

	function Z100.Util.SanitizePreviewText(txt)
		if not txt then return "" end
		local _, _, inner = tostring(txt):match("^%[RPL::(.-)::(.-)::RPL%]%s*(.*)")
		local clean = inner or tostring(txt)
		if clean:sub(1, 5) == "[EDT]" then clean = clean:sub(6) end
		if clean:match("^%[MEDIA::") then return "🖼️ Image" end
		if clean:match("^%[STICKER://") then return "🏵️ Sticker" end
		if clean:match("^%[STORY_RPL::") then return "📸 Story Reply" end
		return clean:gsub("<[^>]+>", "")
	end

	-- Local File Paths inside executor workspace
	local prefix = (Exec.IsFolder and Exec.MakeFolder) and (Exec.CacheDir .. "/") or "ZaynV100_"
	Z100.LocalFiles = {
		Prefs = prefix .. "prefs_" .. Z100.MyNameLower .. ".json",
		CloseFriends = prefix .. "cf_" .. Z100.MyNameLower .. ".json",
		Vault = prefix .. "vault_" .. Z100.MyNameLower .. ".json",
		LastRead = prefix .. "read_" .. Z100.MyNameLower .. ".json",
		BanLock = prefix .. "titan_lock.sys",
		MediaPrefix = prefix .. "media_",
		AudioPrefix = prefix .. "audio_",
	}

	function Z100.Util.ReadLocalJSON(path, defaultVal)
		if not Exec.HasFiles then return defaultVal end
		local okExists, exists = pcall(Exec.IsFile, path)
		if not okExists or not exists then return defaultVal end
		local okRead, raw = pcall(Exec.ReadFile, path)
		if not okRead or type(raw) ~= "string" or raw == "" then return defaultVal end
		local okDec, tbl = pcall(function() return HttpService:JSONDecode(raw) end)
		if okDec and type(tbl) == "table" then return tbl end
		return defaultVal
	end

	function Z100.Util.WriteLocalJSON(path, tbl)
		if not Exec.WriteFile then return false end
		local ok = pcall(function()
			Exec.WriteFile(path, HttpService:JSONEncode(tbl))
		end)
		return ok
	end

	function Z100.Util.SavePrefs()
		Z100.Util.WriteLocalJSON(Z100.LocalFiles.Prefs, Z100.State.Prefs)
	end

	-- Hydrate saved preferences immediately
	do
		local savedPrefs = Z100.Util.ReadLocalJSON(Z100.LocalFiles.Prefs, nil)
		if type(savedPrefs) == "table" then
			for k, v in pairs(savedPrefs) do
				if Z100.State.Prefs[k] ~= nil and type(Z100.State.Prefs[k]) == type(v) then
					Z100.State.Prefs[k] = v
				end
			end
		end
		Z100.State.CloseFriends = Z100.Util.ReadLocalJSON(Z100.LocalFiles.CloseFriends, {})
		Z100.State.Vault = Z100.Util.ReadLocalJSON(Z100.LocalFiles.Vault, {})
	end

	-- ===================================================================== --
	-- [SECTION B : E2E CRYPTO ENGINE (PRESERVES V70 CHAT COMPATIBILITY)]
	-- ===================================================================== --
	local B64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	Z100.Crypto.ServerSalt = "MATRIX_QUANTUM_CORE_CIPHER_SHIELD_V59_"
	local DM_SALT = "A7D9E4B2C1F03E5D8A91624B5C3D2E7F8A9B1C3D4E6F8A2B5C7D9E1F0A2B4C6D"

	function Z100.Crypto.B64Encode(str)
		return (str:gsub(".", function(c)
			local r, b = "", c:byte()
			for idx = 8, 1, -1 do
				r = r .. (b % 2^idx - b % 2^(idx - 1) > 0 and "1" or "0")
			end
			return r
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(bits)
			if #bits < 6 then return "" end
			local val = 0
			for idx = 1, 6 do
				val = val + (bits:sub(idx, idx) == "1" and 2^(6 - idx) or 0)
			end
			return B64_CHARS:sub(val + 1, val + 1)
		end) .. ({ "", "==", "=" })[#str % 3 + 1]
	end

	function Z100.Crypto.B64Decode(str)
		local clean = tostring(str or ""):gsub("[^" .. B64_CHARS .. "=]", "")
		return clean:gsub(".", function(c)
			if c == "=" then return "" end
			local r, f = "", (B64_CHARS:find(c) - 1)
			for idx = 6, 1, -1 do
				r = r .. (f % 2^idx - f % 2^(idx - 1) > 0 and "1" or "0")
			end
			return r
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(bits)
			if #bits ~= 8 then return "" end
			local val = 0
			for idx = 1, 8 do
				val = val + (bits:sub(idx, idx) == "1" and 2^(8 - idx) or 0)
			end
			return string.char(val)
		end)
	end

	function Z100.Crypto.HexEncode(str)
		return (tostring(str or ""):gsub(".", function(c)
			return string.format("%02X", string.byte(c))
		end))
	end

	function Z100.Crypto.HexDecode(hex)
		return (tostring(hex or ""):gsub("..", function(cc)
			return string.char(tonumber(cc, 16) or 32)
		end))
	end

	function Z100.Crypto.Hash(str)
		local h1, h2 = 5381, 2166136261
		local s = tostring(str or "")
		for idx = 1, #s do
			local b = string.byte(s, idx)
			h1 = (h1 * 33 + b) % 4294967296
			h2 = bit32.bxor(h2, b) * 16777619 % 4294967296
		end
		return string.format("%08x%08x", h1, h2)
	end

	function Z100.Crypto.Sign(key, payload)
		return Z100.Crypto.Hash(key .. "::V100_SIGN::" .. payload .. "::" .. key)
	end

	function Z100.Crypto.SignLegacyV80(key, payload)
		return Z100.Crypto.Hash(key .. "::V80_SIGN::" .. payload .. "::" .. key)
	end

	function Z100.Crypto.GetDMKey(u1, u2)
		local a, b = tostring(u1):lower(), tostring(u2):lower()
		return (a < b) and (a .. "_" .. b .. "_" .. DM_SALT) or (b .. "_" .. a .. "_" .. DM_SALT)
	end

	local function xorStream(key, text)
		local out = {}
		local kLen = #key
		for idx = 1, #text do
			out[idx] = string.char(bit32.bxor(string.byte(text, idx), string.byte(key, (idx - 1) % kLen + 1)))
		end
		return table.concat(out)
	end

	function Z100.Crypto.Encrypt(key, plainText)
		local enc = Z100.Crypto.B64Encode(xorStream(key, tostring(plainText or "")))
		return enc, Z100.Crypto.Sign(key, enc)
	end

	function Z100.Crypto.Decrypt(key, encText, sig)
		if not encText or not sig then return nil end
		local validSig = (Z100.Crypto.Sign(key, encText) == sig) or (Z100.Crypto.SignLegacyV80(key, encText) == sig)
		if not validSig then return nil end
		local ok, raw = pcall(Z100.Crypto.B64Decode, encText)
		if not ok or not raw then return nil end
		return xorStream(key, raw)
	end

	-- ===================================================================== --
	-- [SECTION C : DIRECT FIREBASE RTDB ENGINE (NO APPS SCRIPT REQUIRED)]
	-- ===================================================================== --
	local function parseDbError(bodyStr)
		if type(bodyStr) ~= "string" or bodyStr == "" then
			return true, "Empty network response"
		end
		if bodyStr:match("^%s*<") then
			return true, "Database returned unexpected HTML response"
		end
		local ok, dec = pcall(function() return HttpService:JSONDecode(bodyStr) end)
		if ok and type(dec) == "table" and dec.error ~= nil then
			return true, tostring(dec.error)
		end
		return false, nil
	end

	function Z100.DB.FormatError(errMsg)
		local msg = tostring(errMsg or "Network error")
		if msg:lower():find("permission") then
			return "Firebase Permission Denied — publish the V100 Rules from Part 15 in Firebase Console."
		end
		return msg
	end

	function Z100.DB.RawRequest(fullUrl, method, body, extraHeaders, timeoutSec)
		local upperMethod = string.upper(method or "GET")
		local headers = {
			["Content-Type"] = "application/json",
		}
		if type(extraHeaders) == "table" then
			for k, v in pairs(extraHeaders) do
				headers[k] = v
			end
		end

		local req = {
			Url = fullUrl,
			Method = upperMethod,
			Timeout = timeoutSec or 14,
			Headers = headers,
		}
		if body ~= nil and upperMethod ~= "GET" and upperMethod ~= "DELETE" then
			req.Body = type(body) == "string" and body or HttpService:JSONEncode(body)
		end

		local ok, res = pcall(Exec.Request, req)
		if ok and type(res) == "table" then
			local status = tonumber(res.StatusCode) or (res.Success == false and 500 or 200)
			return {
				StatusCode = status,
				Body = tostring(res.Body or ""),
				Headers = type(res.Headers) == "table" and res.Headers or {},
			}
		end
		return {
			StatusCode = 500,
			Body = '{"error":"Executor HTTP request failed"}',
			Headers = {},
		}
	end

	function Z100.DB.BuildUrl(nodePath, bustCache)
		local clean = tostring(nodePath or ""):gsub("^/+", ""):gsub("%.json$", "")
		local base = Z100.Config.FirebaseURL:gsub("/+$", "")
		local url = base .. "/" .. clean .. ".json"
		if bustCache then
			url = url .. "?bust=" .. tostring(os.clock()):gsub("%.", "") .. "_" .. tostring(math.random(1000, 9999))
		end
		return url
	end

	function Z100.DB.Get(nodePath)
		local res = Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, true), "GET")
		if (res.StatusCode == 200 or res.StatusCode == 304) and res.Body ~= "null" and res.Body ~= "" and not res.Body:match("^%s*<") then
			local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
			if ok then
				if type(data) == "table" and data.error ~= nil then
					return nil, Z100.DB.FormatError(data.error)
				end
				return data, nil
			end
		end
		if res.StatusCode >= 400 then
			local _, errText = parseDbError(res.Body)
			return nil, Z100.DB.FormatError(errText or ("HTTP " .. tostring(res.StatusCode)))
		end
		return nil, nil
	end

	function Z100.DB.Put(nodePath, dataValue)
		local encoded = type(dataValue) == "string" and dataValue or HttpService:JSONEncode(dataValue)
		local res = Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, false), "PUT", encoded)
		if res.StatusCode >= 400 then
			local _, errText = parseDbError(res.Body)
			return false, Z100.DB.FormatError(errText or ("HTTP " .. tostring(res.StatusCode)))
		end
		local hasErr, errMsg = parseDbError(res.Body)
		if hasErr then
			return false, Z100.DB.FormatError(errMsg)
		end
		return true, nil
	end

	function Z100.DB.PutAsync(nodePath, dataValue)
		local now = os.clock()
		if now - Z100._burst.Window < 1.0 then
			Z100._burst.Count = Z100._burst.Count + 1
			if Z100._burst.Count > 20 then return end
		else
			Z100._burst.Count = 1
			Z100._burst.Window = now
		end

		local encoded = type(dataValue) == "string" and dataValue or HttpService:JSONEncode(dataValue)
		task.spawn(function()
			local res = Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, false), "PUT", encoded)
			if res.StatusCode >= 400 then
				task.wait(0.8)
				Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, false), "PUT", encoded)
			end
		end)
	end

	function Z100.DB.Delete(nodePath)
		local res = Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, false), "DELETE")
		if res.StatusCode >= 400 then
			local _, errText = parseDbError(res.Body)
			return false, Z100.DB.FormatError(errText or ("HTTP " .. tostring(res.StatusCode)))
		end
		return true, nil
	end

	function Z100.DB.DeleteAsync(nodePath)
		task.spawn(function()
			Z100.DB.RawRequest(Z100.DB.BuildUrl(nodePath, false), "DELETE")
		end)
	end

	-- ===================================================================== --
	-- [SECTION D : TITANGUARD ACCESS & BLACKLIST SECURITY]
	-- ===================================================================== --
	function Z100.Security.ForceBanKick()
		task.spawn(function()
			local env = (type(getgenv) == "function" and getgenv()) or _G
			if type(env) == "table" and type(env.ZaynV100_Cleanup) == "function" then
				pcall(env.ZaynV100_Cleanup)
			end
		end)
		LocalPlayer:Kick("\n⛔ ZAYN V100 TITANGUARD ENGINE ⛔\nAccount permanently restricted from ZAYN SOCIAL.")
		task.wait(0.5)
		while true do task.wait(9e9) end
	end

	function Z100.Security.CheckBlacklist()
		task.spawn(function()
			local hasLocalFlag = Exec.IsFile and pcall(Exec.IsFile, Z100.LocalFiles.BanLock) and Exec.IsFile(Z100.LocalFiles.BanLock)
			local accBan = Z100.DB.Get(Z100.Nodes.Blacklist .. "/Accs/" .. Z100.MyNameLower)
			local hwBan = Z100.DB.Get(Z100.Nodes.Blacklist .. "/HWs/" .. Z100.HWID)
			local isBanned = (accBan ~= nil and accBan ~= false) or (hwBan == true or hwBan == "true")

			if isBanned then
				if Exec.WriteFile then pcall(Exec.WriteFile, Z100.LocalFiles.BanLock, "RESTRICTED") end
				Z100.DB.PutAsync(Z100.Nodes.Blacklist .. "/HWs/" .. Z100.HWID, true)
				Z100.DB.PutAsync(Z100.Nodes.Blacklist .. "/Accs/" .. Z100.MyNameLower, Z100.HWID)
				Z100.Security.ForceBanKick()
			elseif hasLocalFlag and not isBanned and Exec.DelFile then
				pcall(Exec.DelFile, Z100.LocalFiles.BanLock)
			end
		end)
	end

	function Z100.Security.LogViolation(code, reason)
		task.spawn(function()
			Z100.DB.PutAsync(Z100.Nodes.Forensics .. "/LOG_" .. tostring(Z100.Util.Now()) .. "_" .. Z100.MyUid, {
				PlayerName = Z100.MyName,
				PlayerID = LocalPlayer.UserId,
				HWID = Z100.HWID,
				Executor = Exec.Name,
				ViolationCode = tostring(code),
				Reason = tostring(reason),
				Timestamp = Z100.Util.Now(),
			})
		end)
	end

	Z100.Security.CheckBlacklist()

	-- ===================================================================== --
	-- [SECTION E : ACCOUNT RESOLVER & UNIVERSAL IMAGE / MP3 ASSET CACHE]
	-- ===================================================================== --
	Z100.AccountRegistry = {}
	Z100.IdToUsername = {}
	Z100.IdToDisplay = {}

	function Z100.Util.RegisterAccount(username, displayName, userId)
		if type(username) ~= "string" or username == "" then return end
		local low = username:lower()
		local uidNum = tonumber(userId) or 1
		local existing = Z100.AccountRegistry[low]

		if not existing then
			Z100.AccountRegistry[low] = {
				Username = username,
				DisplayName = (displayName and displayName ~= "") and displayName or username,
				UserId = uidNum,
				Verified = false,
			}
		else
			if uidNum > 1 then existing.UserId = uidNum end
			if displayName and displayName ~= "" then existing.DisplayName = displayName end
		end

		if uidNum > 1 then
			local uStr = tostring(uidNum)
			Z100.IdToUsername[uStr] = Z100.AccountRegistry[low].Username
			Z100.IdToDisplay[uStr] = Z100.AccountRegistry[low].DisplayName
		end
	end

	function Z100.Util.GetAccount(username)
		if type(username) ~= "string" or username == "" then
			return { Username = "Unknown", DisplayName = "Unknown", UserId = 1, Verified = false }
		end
		local low = username:lower()
		if Z100.AccountRegistry[low] then
			return Z100.AccountRegistry[low]
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Name:lower() == low then
				Z100.Util.RegisterAccount(plr.Name, plr.DisplayName, plr.UserId)
				return Z100.AccountRegistry[low]
			end
		end
		return { Username = username, DisplayName = username, UserId = 1, Verified = false }
	end

	function Z100.Util.GetAccountByUid(uid)
		local uStr = Z100.Util.NormalizeUid(uid)
		if not uStr then
			return { Username = "Unknown", DisplayName = "Unknown", UserId = 0, Verified = false }
		end
		local uNum = tonumber(uStr)
		local live = Players:GetPlayerByUserId(uNum)
		if live then
			Z100.Util.RegisterAccount(live.Name, live.DisplayName, live.UserId)
			return Z100.AccountRegistry[live.Name:lower()]
		end
		local prof = Z100.State.Profiles[uStr]
		if prof and prof.username then
			Z100.Util.RegisterAccount(prof.username, prof.displayName or prof.username, uNum)
			return { Username = prof.username, DisplayName = prof.displayName or prof.username, UserId = uNum, Verified = true }
		end
		if Z100.IdToUsername[uStr] then
			local u = Z100.IdToUsername[uStr]
			return { Username = u, DisplayName = Z100.IdToDisplay[uStr] or u, UserId = uNum, Verified = true }
		end
		return { Username = "User_" .. uStr, DisplayName = "User " .. uStr, UserId = uNum, Verified = false }
	end

	function Z100.Util.ResolveUser(query)
		local clean = tostring(query or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("^@", "")
		if clean == "" then return nil end

		if clean:match("^%d+$") then
			local uidNum = tonumber(clean)
			if not uidNum or uidNum <= 0 then return nil end
			local live = Players:GetPlayerByUserId(uidNum)
			if live then
				Z100.Util.RegisterAccount(live.Name, live.DisplayName, live.UserId)
				return { UserId = live.UserId, Username = live.Name, DisplayName = live.DisplayName }
			end
			if Z100.IdToUsername[clean] then
				return { UserId = uidNum, Username = Z100.IdToUsername[clean], DisplayName = Z100.IdToDisplay[clean] or Z100.IdToUsername[clean] }
			end
			if UserService then
				local ok, arr = pcall(function() return UserService:GetUserInfosByUserIdsAsync({ uidNum }) end)
				if ok and type(arr) == "table" and arr[1] and arr[1].Username then
					Z100.Util.RegisterAccount(arr[1].Username, arr[1].DisplayName or arr[1].Username, uidNum)
					return { UserId = uidNum, Username = arr[1].Username, DisplayName = arr[1].DisplayName or arr[1].Username }
				end
			end
			local okN, uname = pcall(function() return Players:GetNameFromUserIdAsync(uidNum) end)
			if okN and uname then
				Z100.Util.RegisterAccount(uname, uname, uidNum)
				return { UserId = uidNum, Username = uname, DisplayName = uname }
			end
			return nil
		end

		local low = clean:lower()
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Name:lower() == low or plr.DisplayName:lower() == low then
				Z100.Util.RegisterAccount(plr.Name, plr.DisplayName, plr.UserId)
				return { UserId = plr.UserId, Username = plr.Name, DisplayName = plr.DisplayName }
			end
		end

		local idxHit = Z100.DB.Get(Z100.Nodes.UserIndex .. "/" .. low)
		if type(idxHit) == "table" and tonumber(idxHit.uid) then
			local uidNum = tonumber(idxHit.uid)
			local u = tostring(idxHit.username or clean)
			local d = tostring(idxHit.displayName or u)
			Z100.Util.RegisterAccount(u, d, uidNum)
			return { UserId = uidNum, Username = u, DisplayName = d }
		end

		local okId, foundUid = pcall(function() return Players:GetUserIdFromNameAsync(clean) end)
		if okId and foundUid and foundUid > 0 then
			local uname, dname = clean, clean
			if UserService then
				pcall(function()
					local arr = UserService:GetUserInfosByUserIdsAsync({ foundUid })
					if arr and arr[1] then
						uname = arr[1].Username or clean
						dname = arr[1].DisplayName or uname
					end
				end)
			end
			Z100.Util.RegisterAccount(uname, dname, foundUid)
			return { UserId = foundUid, Username = uname, DisplayName = dname }
		end

		return nil
	end

	-- Safe Image Loader (Roblox Asset IDs, rbxthumb, and HTTP image URLs via getcustomasset)
	function Z100.Util.LoadImageSafe(imgObj, src, fallbackUid)
		if not imgObj or not imgObj.Parent then return end
		local s = tostring(src or ""):gsub("^%s+", ""):gsub("%s+$", "")

		if s == "" then
			local uidNum = tonumber(fallbackUid)
			if uidNum and uidNum > 0 then
				imgObj.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(uidNum) .. "&w=150&h=150"
			else
				imgObj.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
			end
			return
		end

		if s:match("^%d+$") then
			imgObj.Image = "rbxthumb://type=Asset&id=" .. s .. "&w=420&h=420"
			return
		end

		local low = s:lower()
		if low:sub(1, 13) == "rbxassetid://" or low:sub(1, 11) == "rbxthumb://" then
			imgObj.Image = s
			return
		end

		if s:match("^https?://") then
			if not Exec.GetCustomAsset or not Exec.WriteFile or not Exec.IsFile then
				imgObj.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
				return
			end
			local fileKey = Z100.LocalFiles.MediaPrefix .. Z100.Crypto.Hash(s) .. ".png"
			local okEx, exists = pcall(Exec.IsFile, fileKey)
			if okEx and exists then
				pcall(function() imgObj.Image = Exec.GetCustomAsset(fileKey) end)
				return
			end
			task.spawn(function()
				local res = Z100.DB.RawRequest(s, "GET", nil, { ["Accept"] = "image/*" }, 12)
				if res.StatusCode == 200 and #res.Body > 120 then
					pcall(function()
						Exec.WriteFile(fileKey, res.Body)
						if imgObj and imgObj.Parent then
							imgObj.Image = Exec.GetCustomAsset(fileKey)
						end
					end)
				end
			end)
		end
	end

	function Z100.Util.LoadAvatarHeadshot(imgObj, uid, customAvatar)
		if not imgObj then return end
		if type(customAvatar) == "string" and customAvatar ~= "" then
			Z100.Util.LoadImageSafe(imgObj, customAvatar, uid)
			return
		end
		local n = tonumber(uid)
		if n and n > 0 then
			imgObj.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(n) .. "&w=150&h=150"
		else
			imgObj.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
		end
	end

	-- Online MP3 Downloader -> Local File -> getcustomasset SoundId (Delta / Codex / Fluxus)
	function Z100.Util.DownloadAudioToAsset(mp3Url, trackKey, extraHeaders)
		if not Exec.GetCustomAsset or not Exec.WriteFile or not Exec.IsFile then
			return false, nil, "This executor (" .. Exec.Name .. ") does not support getcustomasset() for online MP3 playback."
		end

		local url = tostring(mp3Url or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if not url:match("^https?://") then
			return false, nil, "Invalid MP3 download URL received from online Music API."
		end

		local hashKey = Z100.Crypto.Hash(tostring(trackKey or url))
		local filePath = Z100.LocalFiles.AudioPrefix .. hashKey .. ".mp3"

		local okEx, exists = pcall(Exec.IsFile, filePath)
		if okEx and exists then
			local okAsset, assetUrl = pcall(Exec.GetCustomAsset, filePath)
			if okAsset and type(assetUrl) == "string" and assetUrl ~= "" then
				return true, assetUrl, nil
			end
		end

		local reqHeaders = {
			["Accept"] = "audio/mpeg, audio/*, */*",
			["User-Agent"] = "Mozilla/5.0",
		}
		if type(extraHeaders) == "table" then
			for k, v in pairs(extraHeaders) do
				reqHeaders[k] = v
			end
		end

		local res = Z100.DB.RawRequest(url, "GET", nil, reqHeaders, 25)
		if res.StatusCode ~= 200 or #res.Body < 2048 then
			return false, nil, "Failed to download MP3 stream (HTTP " .. tostring(res.StatusCode) .. ", bytes=" .. tostring(#res.Body) .. ")."
		end

		-- Basic guard against HTML error pages saved as .mp3
		local head = res.Body:sub(1, 32):lower()
		if head:find("<html") or head:find("<!doctype") then
			return false, nil, "Online MP3 link expired or returned HTML instead of audio."
		end

		local okW = pcall(Exec.WriteFile, filePath, res.Body)
		if not okW then
			return false, nil, "Executor writefile() failed while caching MP3."
		end

		local okA, assetUrl = pcall(Exec.GetCustomAsset, filePath)
		if not okA or type(assetUrl) ~= "string" or assetUrl == "" then
			return false, nil, "Executor getcustomasset() failed to load cached MP3."
		end

		return true, assetUrl, nil
	end

	-- ===================================================================== --
	-- [SECTION F : CENTRALIZED ZERO-LAG ANIMATION SCHEDULER]
	-- ===================================================================== --
	function Z100.Anim.Register(guiObj, callbackFn, isHeavy)
		Z100._animIdSeq = Z100._animIdSeq + 1
		local id = Z100._animIdSeq
		Z100._anims[id] = {
			obj = guiObj,
			fn = callbackFn,
			heavy = isHeavy == true,
		}
		return id
	end

	function Z100.Anim.Unregister(id)
		if id then
			Z100._anims[id] = nil
		end
	end

	do
		local lastTick = 0
		local envRef = (type(getgenv) == "function" and getgenv()) or _G
		Z100.Util.TrackConn(RunService.Heartbeat:Connect(function()
			if type(envRef) == "table" and envRef.ZaynV100_Unloading then
				return
			end
			local prefs = Z100.State.Prefs
			local interval = 0.04 -- High (~25 Hz UI motion, 0 game lag)
			if prefs.ReduceMotion or prefs.AnimIntensity == "Low" then
				interval = 0.11
			elseif prefs.AnimIntensity == "Medium" then
				interval = 0.065
			end

			local now = os.clock()
			if now - lastTick < interval then return end
			lastTick = now

			local skipHeavy = prefs.ReduceMotion or (not prefs.ParticlesEnabled) or prefs.AnimIntensity == "Low"
			for id, entry in pairs(Z100._anims) do
				if not entry.obj or not entry.obj.Parent then
					Z100._anims[id] = nil
				elseif not (skipHeavy and entry.heavy) then
					pcall(entry.fn, now)
				end
			end
		end))
	end

	-- Register local player immediately
	Z100.Util.RegisterAccount(LocalPlayer.Name, LocalPlayer.DisplayName, LocalPlayer.UserId)
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 3 / 15 : DESIGN SYSTEM, RESPONSIVE ENGINE & REUSABLE UI COMPONENTS
-- ========================================================================= --

do
	local TweenService = Z100.Services.Tween
	local UserInputService = Z100.Services.UIS
	local Lighting = Z100.Services.Lighting

	-- ===================================================================== --
	-- [SECTION A : V100 UNIFIED DESIGN SYSTEM (STANDARD & ROYAL PREMIUM)]
	-- ===================================================================== --
	Z100.Theme.Tokens = {
		Radius = {
			XS = UDim.new(0, 6),
			SM = UDim.new(0, 8),
			MD = UDim.new(0, 12),
			LG = UDim.new(0, 16),
			XL = UDim.new(0, 20),
			Pill = UDim.new(1, 0),
		},
		Space = {
			XS = 4,
			SM = 8,
			MD = 12,
			LG = 16,
			XL = 20,
		},
		Fonts = {
			Heading = Enum.Font.GothamBold,
			Title = Enum.Font.GothamBold,
			Body = Enum.Font.GothamMedium,
			Regular = Enum.Font.Gotham,
			Mono = Enum.Font.RobotoMono,
		},
		Timing = {
			Fast = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Base = TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
			Pop = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			Smooth = TweenInfo.new(0.36, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		},
	}

	Z100.Theme.Palettes = {
		Standard = {
			Mode = "Standard",
			BgRoot = Color3.fromRGB(8, 8, 14),
			BgGradA = Color3.fromRGB(8, 8, 14),
			BgGradB = Color3.fromRGB(16, 12, 28),
			Surface = Color3.fromRGB(14, 14, 24),
			SurfaceElev = Color3.fromRGB(19, 18, 32),
			Card = Color3.fromRGB(22, 21, 36),
			CardHover = Color3.fromRGB(28, 26, 46),
			InputBg = Color3.fromRGB(11, 11, 20),
			Border = Color3.fromRGB(58, 50, 92),
			BorderGlow = Color3.fromRGB(168, 85, 255),
			Accent = Color3.fromRGB(157, 78, 255),
			Accent2 = Color3.fromRGB(108, 92, 255),
			AccentText = Color3.fromRGB(255, 255, 255),
			Gold = Color3.fromRGB(255, 208, 64),
			GoldDark = Color3.fromRGB(18, 14, 6),
			TextPrimary = Color3.fromRGB(246, 247, 253),
			TextSecondary = Color3.fromRGB(162, 165, 194),
			TextMuted = Color3.fromRGB(112, 115, 144),
			Success = Color3.fromRGB(16, 212, 142),
			Warning = Color3.fromRGB(255, 184, 48),
			Danger = Color3.fromRGB(235, 62, 84),
			Info = Color3.fromRGB(48, 198, 255),
			BubbleMe = Color3.fromRGB(98, 46, 196),
			BubbleOther = Color3.fromRGB(24, 23, 39),
			Skeleton = Color3.fromRGB(30, 29, 48),
		},
		Premium = {
			Mode = "Premium",
			BgRoot = Color3.fromRGB(9, 8, 7),
			BgGradA = Color3.fromRGB(10, 9, 8),
			BgGradB = Color3.fromRGB(36, 26, 10),
			Surface = Color3.fromRGB(16, 14, 12),
			SurfaceElev = Color3.fromRGB(22, 19, 15),
			Card = Color3.fromRGB(26, 22, 17),
			CardHover = Color3.fromRGB(34, 28, 20),
			InputBg = Color3.fromRGB(12, 11, 9),
			Border = Color3.fromRGB(110, 86, 36),
			BorderGlow = Color3.fromRGB(255, 212, 72),
			Accent = Color3.fromRGB(245, 192, 48),
			Accent2 = Color3.fromRGB(255, 148, 28),
			AccentText = Color3.fromRGB(16, 12, 6),
			Gold = Color3.fromRGB(255, 220, 88),
			GoldDark = Color3.fromRGB(16, 12, 5),
			TextPrimary = Color3.fromRGB(255, 250, 238),
			TextSecondary = Color3.fromRGB(198, 182, 144),
			TextMuted = Color3.fromRGB(142, 128, 98),
			Success = Color3.fromRGB(28, 214, 142),
			Warning = Color3.fromRGB(255, 196, 62),
			Danger = Color3.fromRGB(232, 66, 82),
			Info = Color3.fromRGB(92, 206, 255),
			BubbleMe = Color3.fromRGB(128, 92, 22),
			BubbleOther = Color3.fromRGB(26, 22, 18),
			Skeleton = Color3.fromRGB(38, 32, 24),
		},
	}

	function Z100.Theme.Get()
		local mode = Z100.State.Prefs.DesignMode
		if mode == "Premium" then
			local ownsBundle = Z100.Backend.HasCosmeticsBundle and Z100.Backend.HasCosmeticsBundle(Z100.MyUid)
			if ownsBundle or Z100.Util.IsAdmin() then
				return Z100.Theme.Palettes.Premium
			end
		end
		return Z100.Theme.Palettes.Standard
	end

	function Z100.Theme.Tween(obj, info, props)
		if not obj or not obj.Parent then return nil end
		if Z100.State.Prefs.ReduceMotion then
			for k, v in pairs(props) do
				pcall(function() obj[k] = v end)
			end
			return nil
		end
		local tw = TweenService:Create(obj, info or Z100.Theme.Tokens.Timing.Base, props)
		tw:Play()
		return tw
	end

	-- ===================================================================== --
	-- [SECTION B : RESPONSIVE ENGINE (DESKTOP / TABLET / MOBILE)]
	-- ===================================================================== --
	Z100.UI.ResponsiveListeners = {}

	function Z100.UI.GetViewportSize()
		local cam = workspace.CurrentCamera
		if cam and cam.ViewportSize and cam.ViewportSize.X > 0 then
			return cam.ViewportSize
		end
		return Vector2.new(1280, 720)
	end

	function Z100.UI.ComputeDeviceClass(vpSize)
		local vp = vpSize or Z100.UI.GetViewportSize()
		local w = vp.X
		local isTouchOnly = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
		if w <= Z100.Config.Breakpoints.MobileMax or (isTouchOnly and w < 820) then
			return "Mobile"
		elseif w <= Z100.Config.Breakpoints.TabletMax then
			return "Tablet"
		end
		return "Desktop"
	end

	function Z100.UI.ComputeWindowBounds()
		local vp = Z100.UI.GetViewportSize()
		local dev = Z100.UI.ComputeDeviceClass(vp)
		Z100.State.DeviceClass = dev
		local userScale = math.clamp(tonumber(Z100.State.Prefs.UIScale) or 1.0, 0.85, 1.15)

		if dev == "Mobile" then
			local w = math.clamp(math.floor(vp.X * 0.94), 320, 560)
			local h = math.clamp(math.floor(vp.Y * 0.84), 340, 680)
			return dev, w, h
		elseif dev == "Tablet" then
			local w = math.clamp(math.floor(vp.X * 0.80 * userScale), 580, 760)
			local h = math.clamp(math.floor(vp.Y * 0.78 * userScale), 420, 580)
			return dev, w, h
		else
			local w = math.clamp(math.floor(vp.X * 0.64 * userScale), 720, 920)
			local h = math.clamp(math.floor(vp.Y * 0.74 * userScale), 460, 620)
			return dev, w, h
		end
	end

	function Z100.UI.OnResponsiveChange(cb)
		if type(cb) == "function" then
			table.insert(Z100.UI.ResponsiveListeners, cb)
		end
	end

	function Z100.UI.NotifyResponsive()
		local dev, w, h = Z100.UI.ComputeWindowBounds()
		for _, fn in ipairs(Z100.UI.ResponsiveListeners) do
			pcall(fn, dev, w, h)
		end
	end

	-- ===================================================================== --
	-- [SECTION C : REUSABLE UI COMPONENT LIBRARY (Z100.Components)]
	-- ===================================================================== --
	local C = Z100.Components

	function C.Corner(parent, radius)
		local cr = Instance.new("UICorner")
		cr.CornerRadius = radius or Z100.Theme.Tokens.Radius.MD
		cr.Parent = parent
		return cr
	end

	function C.Stroke(parent, color, thickness, transparency)
		local st = Instance.new("UIStroke")
		st.Color = color or Z100.Theme.Get().Border
		st.Thickness = thickness or 1.2
		st.Transparency = transparency or 0.25
		st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		st.Parent = parent
		return st
	end

	function C.Padding(parent, top, right, bottom, left)
		local p = Instance.new("UIPadding")
		p.PaddingTop = UDim.new(0, top or 10)
		p.PaddingRight = UDim.new(0, right or top or 10)
		p.PaddingBottom = UDim.new(0, bottom or top or 10)
		p.PaddingLeft = UDim.new(0, left or right or top or 10)
		p.Parent = parent
		return p
	end

	function C.ListLayout(parent, paddingPx, direction, hAlign, vAlign)
		local lay = Instance.new("UIListLayout")
		lay.Padding = UDim.new(0, paddingPx or 8)
		lay.FillDirection = direction or Enum.FillDirection.Vertical
		lay.HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Left
		lay.VerticalAlignment = vAlign or Enum.VerticalAlignment.Top
		lay.SortOrder = Enum.SortOrder.LayoutOrder
		lay.Parent = parent
		return lay
	end

	function C.AttachAutoCanvas(scrollFrame, listLayout, extraPadding)
		local pad = extraPadding or 24
		local function update()
			if scrollFrame and scrollFrame.Parent and listLayout then
				scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + pad)
			end
		end
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
		task.defer(update)
	end

	function C.AttachButtonFeedback(btn, hoverScale)
		if not btn or not btn:IsA("GuiObject") then return end
		local sc = btn:FindFirstChild("V100BtnScale") or Instance.new("UIScale")
		sc.Name = "V100BtnScale"
		sc.Scale = 1.0
		sc.Parent = btn

		local targetHover = hoverScale or 1.03
		btn.MouseEnter:Connect(function()
			if Z100.State.Prefs.ReduceMotion then return end
			Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Pop, { Scale = targetHover })
		end)
		btn.MouseLeave:Connect(function()
			Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Fast, { Scale = 1.0 })
		end)
		if btn:IsA("TextButton") or btn:IsA("ImageButton") then
			btn.MouseButton1Down:Connect(function()
				if Z100.State.Prefs.ReduceMotion then return end
				Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Fast, { Scale = 0.95 })
			end)
			btn.MouseButton1Up:Connect(function()
				Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Pop, { Scale = targetHover })
			end)
		end
	end

	-- Unified Styled Button (variants: primary | secondary | gold | danger | success | ghost)
	function C.Button(parent, props)
		local p = Z100.Theme.Get()
		local variant = props.Variant or "primary"
		local bg, fg, strokeCol = p.Accent, p.AccentText, p.Accent

		if variant == "secondary" then
			bg, fg, strokeCol = p.Card, p.TextPrimary, p.Border
		elseif variant == "gold" then
			bg, fg, strokeCol = p.Gold, p.GoldDark, p.Gold
		elseif variant == "danger" then
			bg, fg, strokeCol = p.Danger, Color3.fromRGB(255, 255, 255), p.Danger
		elseif variant == "success" then
			bg, fg, strokeCol = p.Success, Color3.fromRGB(8, 20, 16), p.Success
		elseif variant == "ghost" then
			bg, fg, strokeCol = p.SurfaceElev, p.TextSecondary, p.Border
		elseif variant == "discord" then
			bg, fg, strokeCol = Color3.fromRGB(88, 101, 242), Color3.fromRGB(255, 255, 255), Color3.fromRGB(114, 127, 255)
		end

		local btn = Instance.new("TextButton")
		btn.Name = props.Name or "V100Button"
		btn.Size = props.Size or UDim2.new(1, 0, 0, props.Height or 36)
		btn.Position = props.Position or UDim2.new(0, 0, 0, 0)
		btn.BackgroundColor3 = props.BackgroundColor3 or bg
		btn.BackgroundTransparency = props.BackgroundTransparency or (variant == "ghost" and 0.45 or 0)
		btn.AutoButtonColor = false
		btn.BorderSizePixel = 0
		btn.Font = props.Font or Z100.Theme.Tokens.Fonts.Title
		btn.TextSize = props.TextSize or 11.5
		btn.TextColor3 = props.TextColor3 or fg
		btn.Text = tostring(props.Text or "Button")
		btn.LayoutOrder = props.LayoutOrder or 0
		btn.ZIndex = props.ZIndex or ((parent.ZIndex or 10) + 2)
		btn.Parent = parent

		C.Corner(btn, props.Radius or Z100.Theme.Tokens.Radius.SM)
		C.Stroke(btn, props.StrokeColor or strokeCol, 1.1, variant == "secondary" and 0.35 or 0.55)
		C.AttachButtonFeedback(btn, props.HoverScale or 1.03)

		if type(props.OnClick) == "function" then
			btn.MouseButton1Click:Connect(props.OnClick)
		end
		return btn
	end

	-- Unified Elevated Surface Card
	function C.Card(parent, props)
		local p = Z100.Theme.Get()
		local card = Instance.new("Frame")
		card.Name = props.Name or "V100Card"
		card.Size = props.Size or UDim2.new(1, 0, 0, 0)
		if not props.FixedHeight then
			card.AutomaticSize = Enum.AutomaticSize.Y
		end
		card.BackgroundColor3 = props.BackgroundColor3 or p.Card
		card.BackgroundTransparency = props.BackgroundTransparency or 0
		card.BorderSizePixel = 0
		card.LayoutOrder = props.LayoutOrder or 0
		card.ZIndex = props.ZIndex or ((parent.ZIndex or 10) + 1)
		card.Parent = parent

		C.Corner(card, props.Radius or Z100.Theme.Tokens.Radius.MD)
		C.Stroke(card, props.StrokeColor or p.Border, props.StrokeThickness or 1.2, props.StrokeTransparency or 0.35)

		if props.Padding ~= false then
			C.Padding(card, props.PadY or 12, props.PadX or 14, props.PadY or 12, props.PadX or 14)
		end
		if props.UseList ~= false then
			C.ListLayout(card, props.ListGap or 8, Enum.FillDirection.Vertical, props.HAlign or Enum.HorizontalAlignment.Left)
		end
		return card
	end

	-- Section Header Row (Title + optional right action)
	function C.SectionHeader(parent, titleText, subtitleText, order, rightActionText, onRightClick)
		local p = Z100.Theme.Get()
		local wrap = Instance.new("Frame", parent)
		wrap.Name = "SectionHeader"
		wrap.Size = UDim2.new(1, 0, 0, subtitleText and 36 or 22)
		wrap.BackgroundTransparency = 1
		wrap.LayoutOrder = order or 1
		wrap.ZIndex = (parent.ZIndex or 10) + 1

		local title = Instance.new("TextLabel", wrap)
		title.Size = UDim2.new(1, rightActionText and -95 or 0, 0, 20)
		title.BackgroundTransparency = 1
		title.Font = Z100.Theme.Tokens.Fonts.Heading
		title.TextSize = 12.5
		title.TextColor3 = p.TextPrimary
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.Text = tostring(titleText or "")
		title.ZIndex = wrap.ZIndex + 1

		if subtitleText then
			local sub = Instance.new("TextLabel", wrap)
			sub.Size = UDim2.new(1, rightActionText and -95 or 0, 0, 14)
			sub.Position = UDim2.new(0, 0, 0, 20)
			sub.BackgroundTransparency = 1
			sub.Font = Z100.Theme.Tokens.Fonts.Body
			sub.TextSize = 10
			sub.TextColor3 = p.TextSecondary
			sub.TextXAlignment = Enum.TextXAlignment.Left
			sub.Text = tostring(subtitleText)
			sub.ZIndex = wrap.ZIndex + 1
		end

		if rightActionText and type(onRightClick) == "function" then
			C.Button(wrap, {
				Size = UDim2.new(0, 88, 0, 24),
				Position = UDim2.new(1, -88, 0.5, -12),
				Variant = "ghost",
				Text = rightActionText,
				TextSize = 10,
				ZIndex = wrap.ZIndex + 2,
				OnClick = onRightClick,
			})
		end
		return wrap
	end

	-- Styled Input Field
	function C.TextInput(parent, props)
		local p = Z100.Theme.Get()
		local wrap = Instance.new("Frame", parent)
		wrap.Name = props.Name or "V100InputWrap"
		wrap.Size = props.Size or UDim2.new(1, 0, 0, props.Height or 36)
		wrap.BackgroundColor3 = p.InputBg
		wrap.BorderSizePixel = 0
		wrap.LayoutOrder = props.LayoutOrder or 0
		wrap.ZIndex = props.ZIndex or ((parent.ZIndex or 10) + 1)
		C.Corner(wrap, Z100.Theme.Tokens.Radius.SM)
		local st = C.Stroke(wrap, p.Border, 1.2, 0.3)

		local box = Instance.new("TextBox", wrap)
		box.Name = "InputBox"
		box.Size = UDim2.new(1, -20, 1, 0)
		box.Position = UDim2.new(0, 10, 0, 0)
		box.BackgroundTransparency = 1
		box.Font = Z100.Theme.Tokens.Fonts.Body
		box.TextSize = props.TextSize or 11.5
		box.TextColor3 = p.TextPrimary
		box.PlaceholderColor3 = p.TextMuted
		box.PlaceholderText = tostring(props.Placeholder or "Type here...")
		box.Text = tostring(props.Text or "")
		box.ClearTextOnFocus = props.ClearOnFocus == true
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.MultiLine = props.MultiLine == true
		box.TextWrapped = props.MultiLine == true
		box.ZIndex = wrap.ZIndex + 1

		box.Focused:Connect(function()
			Z100.Theme.Tween(st, Z100.Theme.Tokens.Timing.Fast, { Color = p.BorderGlow, Transparency = 0 })
		end)
		box.FocusLost:Connect(function(enterPressed)
			Z100.Theme.Tween(st, Z100.Theme.Tokens.Timing.Fast, { Color = p.Border, Transparency = 0.3 })
			if enterPressed and type(props.OnSubmit) == "function" then
				props.OnSubmit(box.Text)
			end
		end)
		if type(props.OnChange) == "function" then
			box:GetPropertyChangedSignal("Text"):Connect(function()
				props.OnChange(box.Text)
			end)
		end

		return wrap, box
	end

	-- Toggle Switch Row (Used in Settings & Profile Editor)
	function C.ToggleRow(parent, label, description, initialVal, order, onToggle)
		local p = Z100.Theme.Get()
		local val = initialVal == true

		local row = Instance.new("TextButton", parent)
		row.Name = "ToggleRow"
		row.Size = UDim2.new(1, 0, 0, description and 48 or 38)
		row.BackgroundColor3 = p.SurfaceElev
		row.AutoButtonColor = false
		row.Text = ""
		row.LayoutOrder = order or 0
		row.ZIndex = (parent.ZIndex or 10) + 1
		C.Corner(row, Z100.Theme.Tokens.Radius.SM)
		C.Stroke(row, p.Border, 1, 0.45)

		local lbl = Instance.new("TextLabel", row)
		lbl.Size = UDim2.new(1, -70, 0, 18)
		lbl.Position = UDim2.new(0, 12, 0, description and 6 or 10)
		lbl.BackgroundTransparency = 1
		lbl.Font = Z100.Theme.Tokens.Fonts.Title
		lbl.TextSize = 11.5
		lbl.TextColor3 = p.TextPrimary
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Text = tostring(label)
		lbl.ZIndex = row.ZIndex + 1

		if description then
			local sub = Instance.new("TextLabel", row)
			sub.Size = UDim2.new(1, -70, 0, 14)
			sub.Position = UDim2.new(0, 12, 0, 26)
			sub.BackgroundTransparency = 1
			sub.Font = Z100.Theme.Tokens.Fonts.Body
			sub.TextSize = 9.5
			sub.TextColor3 = p.TextSecondary
			sub.TextXAlignment = Enum.TextXAlignment.Left
			sub.Text = tostring(description)
			sub.ZIndex = row.ZIndex + 1
		end

		local track = Instance.new("Frame", row)
		track.Size = UDim2.new(0, 42, 0, 22)
		track.Position = UDim2.new(1, -54, 0.5, -11)
		track.BorderSizePixel = 0
		track.ZIndex = row.ZIndex + 1
		C.Corner(track, Z100.Theme.Tokens.Radius.Pill)

		local knob = Instance.new("Frame", track)
		knob.Size = UDim2.new(0, 16, 0, 16)
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		knob.BorderSizePixel = 0
		knob.ZIndex = track.ZIndex + 1
		C.Corner(knob, Z100.Theme.Tokens.Radius.Pill)

		local function sync(instant)
			local col = val and p.Accent or Color3.fromRGB(54, 54, 72)
			local pos = val and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
			if instant then
				track.BackgroundColor3 = col
				knob.Position = pos
			else
				Z100.Theme.Tween(track, Z100.Theme.Tokens.Timing.Fast, { BackgroundColor3 = col })
				Z100.Theme.Tween(knob, Z100.Theme.Tokens.Timing.Pop, { Position = pos })
			end
		end
		sync(true)

		row.MouseButton1Click:Connect(function()
			val = not val
			sync(false)
			if type(onToggle) == "function" then
				onToggle(val)
			end
		end)
		return row
	end

	-- Horizontal Segmented Tab Bar
	function C.TabBar(parent, tabs, activeId, order, onSelect)
		local p = Z100.Theme.Get()
		local bar = Instance.new("Frame", parent)
		bar.Name = "V100TabBar"
		bar.Size = UDim2.new(1, 0, 0, 38)
		bar.BackgroundColor3 = p.Surface
		bar.LayoutOrder = order or 1
		bar.ZIndex = (parent.ZIndex or 10) + 1
		C.Corner(bar, Z100.Theme.Tokens.Radius.MD)
		C.Stroke(bar, p.Border, 1.1, 0.35)
		C.Padding(bar, 4, 4, 4, 4)

		local lay = C.ListLayout(bar, 4, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
		local tabWidth = (1 / math.max(1, #tabs))

		for idx, td in ipairs(tabs) do
			local isAct = (td.Id == activeId)
			local tb = Instance.new("TextButton", bar)
			tb.Size = UDim2.new(tabWidth, -4, 1, 0)
			tb.BackgroundColor3 = isAct and (td.Color or p.Accent) or p.Card
			tb.BackgroundTransparency = isAct and 0 or 0.4
			tb.AutoButtonColor = false
			tb.BorderSizePixel = 0
			tb.Font = Z100.Theme.Tokens.Fonts.Title
			tb.TextSize = 10
			tb.TextColor3 = isAct and (td.ActiveText or p.AccentText) or p.TextSecondary
			tb.Text = tostring(td.Label)
			tb.LayoutOrder = idx
			tb.ZIndex = bar.ZIndex + 1
			C.Corner(tb, Z100.Theme.Tokens.Radius.SM)
			C.AttachButtonFeedback(tb, 1.03)
			tb.MouseButton1Click:Connect(function()
				if type(onSelect) == "function" then
					onSelect(td.Id)
				end
			end)
		end

		return bar
	end

	-- Animated Shimmer Loading Skeleton
	function C.LoadingSkeleton(parent, rowsCount, heightEach, order)
		local p = Z100.Theme.Get()
		local wrap = Instance.new("Frame", parent)
		wrap.Name = "V100LoadingSkeleton"
		wrap.Size = UDim2.new(1, 0, 0, 0)
		wrap.AutomaticSize = Enum.AutomaticSize.Y
		wrap.BackgroundTransparency = 1
		wrap.LayoutOrder = order or 1
		wrap.ZIndex = (parent.ZIndex or 10) + 1
		C.ListLayout(wrap, 8)

		local bars = {}
		for i = 1, (rowsCount or 3) do
			local row = Instance.new("Frame", wrap)
			row.Size = UDim2.new(1, 0, 0, heightEach or 54)
			row.BackgroundColor3 = p.Skeleton
			row.BorderSizePixel = 0
			row.LayoutOrder = i
			row.ZIndex = wrap.ZIndex + 1
			C.Corner(row, Z100.Theme.Tokens.Radius.MD)
			table.insert(bars, row)
		end

		Z100.Anim.Register(wrap, function(now)
			local pulse = 0.25 + ((math.sin(now * 3.8) + 1) * 0.22)
			for _, bar in ipairs(bars) do
				if bar and bar.Parent then
					bar.BackgroundTransparency = pulse
				end
			end
		end, false)

		return wrap
	end

	-- Clean Empty State Card
	function C.EmptyState(parent, icon, title, subtitle, ctaText, onCta, order)
		local p = Z100.Theme.Get()
		local card = C.Card(parent, {
			Name = "V100EmptyState",
			LayoutOrder = order or 1,
			HAlign = Enum.HorizontalAlignment.Center,
			PadY = 20,
			PadX = 18,
			ListGap = 6,
		})

		local ic = Instance.new("TextLabel", card)
		ic.Size = UDim2.new(1, 0, 0, 30)
		ic.BackgroundTransparency = 1
		ic.Font = Z100.Theme.Tokens.Fonts.Heading
		ic.TextSize = 24
		ic.TextColor3 = p.Accent
		ic.Text = tostring(icon or "✦")
		ic.LayoutOrder = 1
		ic.ZIndex = card.ZIndex + 1

		local tl = Instance.new("TextLabel", card)
		tl.Size = UDim2.new(1, 0, 0, 20)
		tl.BackgroundTransparency = 1
		tl.Font = Z100.Theme.Tokens.Fonts.Heading
		tl.TextSize = 13
		tl.TextColor3 = p.TextPrimary
		tl.Text = tostring(title or "Nothing here yet")
		tl.LayoutOrder = 2
		tl.ZIndex = card.ZIndex + 1

		local sl = Instance.new("TextLabel", card)
		sl.Size = UDim2.new(1, 0, 0, 0)
		sl.AutomaticSize = Enum.AutomaticSize.Y
		sl.BackgroundTransparency = 1
		sl.Font = Z100.Theme.Tokens.Fonts.Body
		sl.TextSize = 10.5
		sl.TextColor3 = p.TextSecondary
		sl.TextWrapped = true
		sl.Text = tostring(subtitle or "")
		sl.LayoutOrder = 3
		sl.ZIndex = card.ZIndex + 1

		if ctaText and type(onCta) == "function" then
			C.Button(card, {
				Size = UDim2.new(0, 190, 0, 34),
				Variant = "primary",
				Text = ctaText,
				LayoutOrder = 4,
				ZIndex = card.ZIndex + 1,
				OnClick = onCta,
			})
		end
		return card
	end

	-- Clean Error State Card with Retry Action
	function C.ErrorState(parent, message, onRetry, order)
		local p = Z100.Theme.Get()
		local card = C.Card(parent, {
			Name = "V100ErrorState",
			LayoutOrder = order or 1,
			StrokeColor = p.Danger,
			HAlign = Enum.HorizontalAlignment.Center,
			PadY = 18,
			ListGap = 8,
		})

		local tl = Instance.new("TextLabel", card)
		tl.Size = UDim2.new(1, 0, 0, 20)
		tl.BackgroundTransparency = 1
		tl.Font = Z100.Theme.Tokens.Fonts.Heading
		tl.TextSize = 12.5
		tl.TextColor3 = p.Danger
		tl.Text = "⚠️ Something went wrong"
		tl.LayoutOrder = 1
		tl.ZIndex = card.ZIndex + 1

		local msg = Instance.new("TextLabel", card)
		msg.Size = UDim2.new(1, 0, 0, 0)
		msg.AutomaticSize = Enum.AutomaticSize.Y
		msg.BackgroundTransparency = 1
		msg.Font = Z100.Theme.Tokens.Fonts.Body
		msg.TextSize = 10.5
		msg.TextColor3 = p.TextSecondary
		msg.TextWrapped = true
		msg.Text = tostring(message or "Network request failed.")
		msg.LayoutOrder = 2
		msg.ZIndex = card.ZIndex + 1

		if type(onRetry) == "function" then
			C.Button(card, {
				Size = UDim2.new(0, 140, 0, 32),
				Variant = "danger",
				Text = "🔄 Retry",
				LayoutOrder = 3,
				ZIndex = card.ZIndex + 1,
				OnClick = onRetry,
			})
		end
		return card
	end

	-- ===================================================================== --
	-- [SECTION D : REUSABLE MODAL, CONFIRM DIALOG & INPUT PROMPT]
	-- ===================================================================== --
	function C.OpenModal(props)
		local host = Z100.UI.ModalLayer or Z100.UI.MainFrame
		if not host then return nil, nil end

		local modalName = props.Name or "ZaynV100_ActiveModal"
		local old = host:FindFirstChild(modalName)
		if old then old:Destroy() end

		local p = Z100.Theme.Get()
		local dev = Z100.State.DeviceClass

		local backdrop = Instance.new("Frame", host)
		backdrop.Name = modalName
		backdrop.Size = UDim2.new(1, 0, 1, 0)
		backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		backdrop.BackgroundTransparency = 1
		backdrop.Active = true
		backdrop.ZIndex = props.ZIndex or 300

		local catcher = Instance.new("TextButton", backdrop)
		catcher.Size = UDim2.new(1, 0, 1, 0)
		catcher.BackgroundTransparency = 1
		catcher.Text = ""
		catcher.ZIndex = backdrop.ZIndex + 1

		local w = props.Width or (dev == "Mobile" and 310 or 410)
		local box = Instance.new("Frame", backdrop)
		box.Name = "ModalCard"
		if props.FixedHeight then
			box.Size = UDim2.new(0, math.min(w, host.AbsoluteSize.X - 24), 0, math.min(props.FixedHeight, host.AbsoluteSize.Y - 36))
		else
			box.Size = UDim2.new(0, math.min(w, host.AbsoluteSize.X - 24), 0, 0)
			box.AutomaticSize = Enum.AutomaticSize.Y
		end
		box.Position = UDim2.new(0.5, 0, 0.5, 0)
		box.AnchorPoint = Vector2.new(0.5, 0.5)
		box.BackgroundColor3 = p.Surface
		box.BorderSizePixel = 0
		box.ZIndex = backdrop.ZIndex + 2
		C.Corner(box, Z100.Theme.Tokens.Radius.LG)
		C.Stroke(box, props.AccentColor or p.BorderGlow, 1.5, 0.15)

		local sc = Instance.new("UIScale", box)
		sc.Scale = Z100.State.Prefs.ReduceMotion and 1.0 or 0.88
		Z100.Theme.Tween(backdrop, Z100.Theme.Tokens.Timing.Fast, { BackgroundTransparency = 0.45 })
		Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Pop, { Scale = 1.0 })

		local function closeFn()
			if not backdrop or not backdrop.Parent then return end
			if type(props.OnClose) == "function" then pcall(props.OnClose) end
			if Z100.State.Prefs.ReduceMotion then
				backdrop:Destroy()
				return
			end
			Z100.Theme.Tween(backdrop, Z100.Theme.Tokens.Timing.Fast, { BackgroundTransparency = 1 })
			Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Fast, { Scale = 0.9 })
			task.delay(0.15, function()
				if backdrop and backdrop.Parent then backdrop:Destroy() end
			end)
		end

		if props.CloseOnBackdrop ~= false then
			catcher.MouseButton1Click:Connect(closeFn)
		end

		-- Header
		local hdr = Instance.new("Frame", box)
		hdr.Size = UDim2.new(1, 0, 0, 42)
		hdr.BackgroundColor3 = p.SurfaceElev
		hdr.BorderSizePixel = 0
		hdr.ZIndex = box.ZIndex + 1
		C.Corner(hdr, Z100.Theme.Tokens.Radius.LG)

		local titleLbl = Instance.new("TextLabel", hdr)
		titleLbl.Size = UDim2.new(1, -52, 1, 0)
		titleLbl.Position = UDim2.new(0, 14, 0, 0)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Font = Z100.Theme.Tokens.Fonts.Heading
		titleLbl.TextSize = 13
		titleLbl.TextColor3 = props.AccentColor or p.TextPrimary
		titleLbl.TextXAlignment = Enum.TextXAlignment.Left
		titleLbl.ClipsDescendants = true
		titleLbl.Text = tostring(props.Title or "Modal")
		titleLbl.ZIndex = hdr.ZIndex + 1

		local closeBtn = Instance.new("TextButton", hdr)
		closeBtn.Size = UDim2.new(0, 26, 0, 26)
		closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
		closeBtn.BackgroundColor3 = p.Card
		closeBtn.Font = Z100.Theme.Tokens.Fonts.Heading
		closeBtn.TextSize = 12
		closeBtn.TextColor3 = p.TextSecondary
		closeBtn.Text = "✕"
		closeBtn.ZIndex = hdr.ZIndex + 1
		C.Corner(closeBtn, Z100.Theme.Tokens.Radius.SM)
		C.AttachButtonFeedback(closeBtn, 1.08)
		closeBtn.MouseButton1Click:Connect(closeFn)

		local body = Instance.new("Frame", box)
		body.Name = "ModalBody"
		if props.FixedHeight then
			body.Size = UDim2.new(1, 0, 1, -42)
		else
			body.Size = UDim2.new(1, 0, 0, 0)
			body.AutomaticSize = Enum.AutomaticSize.Y
		end
		body.Position = UDim2.new(0, 0, 0, 42)
		body.BackgroundTransparency = 1
		body.ZIndex = box.ZIndex + 1
		C.Padding(body, 12, 14, 14, 14)
		if props.UseList ~= false then
			C.ListLayout(body, 10)
		end

		return {
			Backdrop = backdrop,
			Card = box,
			Body = body,
			Close = closeFn,
		}
	end

	function C.ConfirmDialog(title, message, confirmLabel, variant, onConfirm)
		local p = Z100.Theme.Get()
		local modal = C.OpenModal({
			Name = "ZaynV100_ConfirmDialog",
			Title = title or "Confirm Action",
			Width = 340,
			AccentColor = variant == "danger" and p.Danger or p.Accent,
		})
		if not modal then return end

		local msg = Instance.new("TextLabel", modal.Body)
		msg.Size = UDim2.new(1, 0, 0, 0)
		msg.AutomaticSize = Enum.AutomaticSize.Y
		msg.BackgroundTransparency = 1
		msg.Font = Z100.Theme.Tokens.Fonts.Body
		msg.TextSize = 11.5
		msg.TextColor3 = p.TextSecondary
		msg.TextWrapped = true
		msg.TextXAlignment = Enum.TextXAlignment.Left
		msg.Text = tostring(message or "Are you sure?")
		msg.LayoutOrder = 1
		msg.ZIndex = modal.Body.ZIndex + 1

		local row = Instance.new("Frame", modal.Body)
		row.Size = UDim2.new(1, 0, 0, 34)
		row.BackgroundTransparency = 1
		row.LayoutOrder = 2
		row.ZIndex = modal.Body.ZIndex + 1

		C.Button(row, {
			Size = UDim2.new(0.48, 0, 1, 0),
			Variant = "secondary",
			Text = "Cancel",
			ZIndex = row.ZIndex + 1,
			OnClick = modal.Close,
		})
		C.Button(row, {
			Size = UDim2.new(0.48, 0, 1, 0),
			Position = UDim2.new(0.52, 0, 0, 0),
			Variant = variant or "primary",
			Text = confirmLabel or "Confirm",
			ZIndex = row.ZIndex + 1,
			OnClick = function()
				modal.Close()
				if type(onConfirm) == "function" then
					task.spawn(onConfirm)
				end
			end,
		})
	end

	function C.PromptDialog(title, placeholder, confirmLabel, onConfirm)
		local p = Z100.Theme.Get()
		local modal = C.OpenModal({
			Name = "ZaynV100_PromptDialog",
			Title = title or "Enter Details",
			Width = 360,
		})
		if not modal then return end

		local _, box = C.TextInput(modal.Body, {
			Placeholder = placeholder or "Type here...",
			LayoutOrder = 1,
			ZIndex = modal.Body.ZIndex + 1,
		})

		local row = Instance.new("Frame", modal.Body)
		row.Size = UDim2.new(1, 0, 0, 34)
		row.BackgroundTransparency = 1
		row.LayoutOrder = 2
		row.ZIndex = modal.Body.ZIndex + 1

		C.Button(row, {
			Size = UDim2.new(0.48, 0, 1, 0),
			Variant = "secondary",
			Text = "Cancel",
			ZIndex = row.ZIndex + 1,
			OnClick = modal.Close,
		})
		C.Button(row, {
			Size = UDim2.new(0.48, 0, 1, 0),
			Position = UDim2.new(0.52, 0, 0, 0),
			Variant = "primary",
			Text = confirmLabel or "Submit",
			ZIndex = row.ZIndex + 1,
			OnClick = function()
				local val = box.Text:match("^%s*(.-)%s*$") or ""
				if val ~= "" then
					modal.Close()
					if type(onConfirm) == "function" then
						task.spawn(onConfirm, val)
					end
				end
			end,
		})
	end

	-- ===================================================================== --
	-- [SECTION E : PREMIUM TOAST NOTIFICATION SYSTEM]
	-- ===================================================================== --
	function Z100.UI.ShowToast(titleText, bodyText, accentColor, avatarUidOrName, onClickFn)
		local container = Z100.UI.ToastContainer
		if not container then return end
		local p = Z100.Theme.Get()

		local toast = Instance.new("Frame")
		toast.Name = "V100Toast"
		toast.Size = UDim2.new(1, 0, 0, 58)
		toast.BackgroundColor3 = p.SurfaceElev
		toast.BackgroundTransparency = 1
		toast.BorderSizePixel = 0
		toast.ZIndex = 2001
		C.Corner(toast, Z100.Theme.Tokens.Radius.MD)

		local st = C.Stroke(toast, accentColor or p.Accent, 1.5, 1)

		local accentBar = Instance.new("Frame", toast)
		accentBar.Size = UDim2.new(0, 4, 1, -14)
		accentBar.Position = UDim2.new(0, 6, 0, 7)
		accentBar.BackgroundColor3 = accentColor or p.Accent
		accentBar.BorderSizePixel = 0
		accentBar.ZIndex = 2002
		C.Corner(accentBar, Z100.Theme.Tokens.Radius.Pill)

		local txt = Instance.new("TextLabel", toast)
		txt.Size = UDim2.new(1, -24, 1, -8)
		txt.Position = UDim2.new(0, 16, 0, 4)
		txt.BackgroundTransparency = 1
		txt.Font = Z100.Theme.Tokens.Fonts.Body
		txt.TextSize = 11
		txt.TextColor3 = p.TextPrimary
		txt.TextXAlignment = Enum.TextXAlignment.Left
		txt.TextWrapped = true
		txt.ClipsDescendants = true
		txt.RichText = true
		txt.TextTransparency = 1
		txt.ZIndex = 2002
		txt.Text = string.format("<b>%s</b>\n<font color='#%s'>%s</font>",
			Z100.Util.EscapeRichText(tostring(titleText or "ZAYN V100")),
			p.TextSecondary:ToHex(),
			Z100.Util.EscapeRichText(Z100.Util.SanitizePreviewText(tostring(bodyText or "")):sub(1, 76)))

		local av = nil
		if avatarUidOrName then
			txt.Size = UDim2.new(1, -64, 1, -8)
			txt.Position = UDim2.new(0, 56, 0, 4)
			av = Instance.new("ImageLabel", toast)
			av.Size = UDim2.new(0, 34, 0, 34)
			av.Position = UDim2.new(0, 14, 0.5, -17)
			av.BackgroundColor3 = p.Card
			av.ScaleType = Enum.ScaleType.Crop
			av.ImageTransparency = 1
			av.ZIndex = 2002
			C.Corner(av, Z100.Theme.Tokens.Radius.Pill)

			local uidNum = tonumber(avatarUidOrName)
			if uidNum and uidNum > 0 then
				Z100.Util.LoadAvatarHeadshot(av, uidNum)
			else
				local acc = Z100.Util.GetAccount(tostring(avatarUidOrName))
				Z100.Util.LoadAvatarHeadshot(av, acc.UserId)
			end
		end

		toast.Parent = container
		Z100.Theme.Tween(toast, Z100.Theme.Tokens.Timing.Pop, { BackgroundTransparency = 0.05 })
		Z100.Theme.Tween(st, Z100.Theme.Tokens.Timing.Base, { Transparency = 0.1 })
		Z100.Theme.Tween(txt, Z100.Theme.Tokens.Timing.Base, { TextTransparency = 0 })
		if av then Z100.Theme.Tween(av, Z100.Theme.Tokens.Timing.Base, { ImageTransparency = 0 }) end

		if type(onClickFn) == "function" then
			local hit = Instance.new("TextButton", toast)
			hit.Size = UDim2.new(1, 0, 1, 0)
			hit.BackgroundTransparency = 1
			hit.Text = ""
			hit.ZIndex = 2004
			hit.MouseButton1Click:Connect(function()
				if Z100.UI.MainFrame and not Z100.UI.MainFrame.Visible then
					Z100.UI.MainFrame.Visible = true
				end
				pcall(onClickFn)
				if toast and toast.Parent then toast:Destroy() end
			end)
		end

		task.delay(4.2, function()
			if toast and toast.Parent then
				Z100.Theme.Tween(toast, Z100.Theme.Tokens.Timing.Fast, { BackgroundTransparency = 1 })
				Z100.Theme.Tween(st, Z100.Theme.Tokens.Timing.Fast, { Transparency = 1 })
				Z100.Theme.Tween(txt, Z100.Theme.Tokens.Timing.Fast, { TextTransparency = 1 })
				if av then Z100.Theme.Tween(av, Z100.Theme.Tokens.Timing.Fast, { ImageTransparency = 1 }) end
				task.delay(0.18, function()
					if toast and toast.Parent then toast:Destroy() end
				end)
			end
		end)
	end

	function Z100.UI.ShowGlobalBanner(msg)
		local root = Z100.UI.ScreenGui
		if not root then return end
		local p = Z100.Theme.Get()

		local banner = Instance.new("Frame", root)
		banner.Name = "ZaynV100_GlobalBanner"
		banner.Size = UDim2.new(0, 420, 0, 44)
		banner.AnchorPoint = Vector2.new(0.5, 0)
		banner.Position = UDim2.new(0.5, 0, 0, -52)
		banner.BackgroundColor3 = p.SurfaceElev
		banner.ZIndex = 3000
		C.Corner(banner, Z100.Theme.Tokens.Radius.MD)
		C.Stroke(banner, p.Gold, 1.8, 0)

		local lbl = Instance.new("TextLabel", banner)
		lbl.Size = UDim2.new(1, -24, 1, 0)
		lbl.Position = UDim2.new(0, 12, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Font = Z100.Theme.Tokens.Fonts.Heading
		lbl.TextSize = 12.5
		lbl.TextColor3 = p.Gold
		lbl.TextWrapped = true
		lbl.Text = "📢 ANNOUNCEMENT: " .. tostring(msg)
		lbl.ZIndex = 3001

		Z100.Theme.Tween(banner, Z100.Theme.Tokens.Timing.Pop, { Position = UDim2.new(0.5, 0, 0, 16) })
		task.delay(7.0, function()
			if banner and banner.Parent then
				Z100.Theme.Tween(banner, Z100.Theme.Tokens.Timing.Base, { Position = UDim2.new(0.5, 0, 0, -52) })
				task.delay(0.3, function()
					if banner and banner.Parent then banner:Destroy() end
				end)
			end
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 4 / 15 : PAID CATALOGS (₹300 / ₹1500) & FULL PROFILE ANIMATION ENGINE
-- ========================================================================= --

do
	local TweenService = Z100.Services.Tween

	-- ===================================================================== --
	-- [SECTION A : BASE STANDARD PROFILE APPEARANCE (NON-STORE DEFAULT)]
	-- ===================================================================== --
	Z100.Catalog.BaseProfileTheme = {
		id = "default_base",
		name = "Standard Obsidian",
		isBase = true,
		priceINR = 0,
		tag = "STANDARD",
		bg1 = Color3.fromRGB(9, 9, 15),
		bg2 = Color3.fromRGB(20, 13, 34),
		cardBg = Color3.fromRGB(16, 15, 26),
		border1 = Color3.fromRGB(157, 78, 255),
		border2 = Color3.fromRGB(108, 62, 235),
		accent = Color3.fromRGB(168, 88, 255),
		accent2 = Color3.fromRGB(118, 95, 255),
		buttonBg = Color3.fromRGB(142, 62, 245),
		buttonText = Color3.fromRGB(255, 255, 255),
		textColor = Color3.fromRGB(246, 247, 253),
		subText = Color3.fromRGB(160, 162, 192),
		particleColor = Color3.fromRGB(168, 88, 255),
		sparkleColor = Color3.fromRGB(218, 185, 255),
		animStyle = "standard_subtle",
		description = "Default V100 dark obsidian profile with smooth violet accent border.",
	}

	-- ===================================================================== --
	-- [SECTION B : 16 PREMIUM AVATAR DECORATIONS (100% PAID — ₹300 EACH)]
	-- ===================================================================== --
	Z100.Catalog.Decorations = {
		{
			id = "royal_gold_ring",
			name = "Royal Gold Ring",
			priceINR = 300,
			tag = "ROYAL",
			fxType = "ring_crown",
			accent = Color3.fromRGB(255, 214, 62),
			secondary = Color3.fromRGB(255, 146, 22),
			description = "24K molten gold rotating halo with orbiting royal crown sparks.",
		},
		{
			id = "purple_neon_ring",
			name = "Purple Neon Ring",
			priceINR = 300,
			tag = "NEON",
			fxType = "neon_dual",
			accent = Color3.fromRGB(185, 58, 255),
			secondary = Color3.fromRGB(255, 48, 198),
			description = "High-voltage cyber violet neon ring with pulsing outer glow.",
		},
		{
			id = "diamond_frame",
			name = "Diamond Frame",
			priceINR = 300,
			tag = "LUXURY",
			fxType = "diamond_glint",
			accent = Color3.fromRGB(228, 248, 255),
			secondary = Color3.fromRGB(130, 198, 255),
			description = "Faceted platinum-diamond avatar frame with flashing luxury glints.",
		},
		{
			id = "fire_aura",
			name = "Fire Aura",
			priceINR = 300,
			tag = "ELEMENTAL",
			fxType = "fire_embers",
			accent = Color3.fromRGB(255, 92, 20),
			secondary = Color3.fromRGB(255, 224, 60),
			description = "Blazing solar flame ring surrounded by rising live ember sparks.",
		},
		{
			id = "electric_aura",
			name = "Electric Aura",
			priceINR = 300,
			tag = "ELEMENTAL",
			fxType = "electric_bolts",
			accent = Color3.fromRGB(68, 222, 255),
			secondary = Color3.fromRGB(242, 252, 255),
			description = "Crackling plasma surge ring with orbiting lightning arcs.",
		},
		{
			id = "galaxy_aura",
			name = "Galaxy Aura",
			priceINR = 300,
			tag = "COSMIC",
			fxType = "galaxy_nebula",
			accent = Color3.fromRGB(168, 68, 255),
			secondary = Color3.fromRGB(0, 222, 255),
			description = "Deep astral nebula vortex with counter-orbiting stardust spheres.",
		},
		{
			id = "shadow_aura",
			name = "Shadow Aura",
			priceINR = 300,
			tag = "MYTHIC",
			fxType = "shadow_eclipse",
			accent = Color3.fromRGB(138, 32, 228),
			secondary = Color3.fromRGB(255, 30, 80),
			description = "Obsidian void eclipse halo emitting crimson-violet shadow wisps.",
		},
		{
			id = "angel_halo",
			name = "Angel Halo",
			priceINR = 300,
			tag = "DIVINE",
			fxType = "angel_halo",
			accent = Color3.fromRGB(255, 245, 175),
			secondary = Color3.fromRGB(210, 246, 255),
			description = "Levitating golden celestial halo hovering smoothly above your avatar.",
		},
		{
			id = "demon_horns",
			name = "Demon Horns",
			priceINR = 300,
			tag = "MYTHIC",
			fxType = "demon_horns",
			accent = Color3.fromRGB(255, 34, 68),
			secondary = Color3.fromRGB(168, 18, 46),
			description = "Pulsing crimson infernal horns paired with a dark ruby flame ring.",
		},
		{
			id = "floating_diamonds",
			name = "Floating Diamonds",
			priceINR = 300,
			tag = "LUXURY",
			fxType = "floating_gems",
			accent = Color3.fromRGB(148, 240, 255),
			secondary = Color3.fromRGB(255, 255, 255),
			description = "Four crystal-cut floating diamonds orbiting smoothly in 3D rhythm.",
		},
		{
			id = "neon_particles",
			name = "Neon Particles",
			priceINR = 300,
			tag = "CYBER",
			fxType = "neon_swarm",
			accent = Color3.fromRGB(0, 255, 215),
			secondary = Color3.fromRGB(255, 0, 178),
			description = "High-energy cyberpunk photon swarm orbiting your profile avatar.",
		},
		{
			id = "animated_wings",
			name = "Animated Wings",
			priceINR = 300,
			tag = "LEGENDARY",
			fxType = "animated_wings",
			accent = Color3.fromRGB(255, 226, 122),
			secondary = Color3.fromRGB(188, 118, 255),
			description = "Twin radiant seraphic wings gently flapping beside your avatar frame.",
		},
		{
			id = "crystal_frame",
			name = "Crystal Frame",
			priceINR = 300,
			tag = "ELEMENTAL",
			fxType = "crystal_frost",
			accent = Color3.fromRGB(135, 236, 255),
			secondary = Color3.fromRGB(205, 168, 255),
			description = "Prismatic frost crystal frame rotating with glacial snowflake nodes.",
		},
		{
			id = "holographic_frame",
			name = "Holographic Frame",
			priceINR = 300,
			tag = "PRISM",
			fxType = "chroma_pulse",
			accent = Color3.fromRGB(0, 245, 255),
			secondary = Color3.fromRGB(255, 62, 198),
			description = "Full-spectrum liquid holographic prism border with expanding pulse waves.",
		},
		{
			id = "premium_badges_frame",
			name = "Premium Badges",
			priceINR = 300,
			tag = "ELITE",
			fxType = "badge_crest",
			accent = Color3.fromRGB(255, 198, 48),
			secondary = Color3.fromRGB(185, 68, 255),
			description = "Prestige VIP crest emblem ring with animated royal crown markers.",
		},
		{
			id = "animated_avatar_fx",
			name = "Animated Avatar Effects",
			priceINR = 300,
			tag = "ULTIMATE",
			fxType = "ornate_frame",
			accent = Color3.fromRGB(255, 205, 60),
			secondary = Color3.fromRGB(0, 232, 255),
			description = "Double-ringed orbital luxury spotlight with multi-layer jewel glow.",
		},
	}

	Z100.Catalog.DecorationMap = {}
	for _, dItem in ipairs(Z100.Catalog.Decorations) do
		Z100.Catalog.DecorationMap[dItem.id] = dItem
	end

	-- ===================================================================== --
	-- [SECTION C : 15 FULL PROFILE THEME PACKS (100% PAID — ₹300 EACH)]
	-- ===================================================================== --
	Z100.Catalog.ProfileThemes = {
		{
			id = "royal_gold",
			name = "Royal Gold",
			priceINR = 300,
			tag = "FLAGSHIP",
			bg1 = Color3.fromRGB(12, 10, 7),
			bg2 = Color3.fromRGB(52, 36, 10),
			cardBg = Color3.fromRGB(20, 17, 12),
			border1 = Color3.fromRGB(255, 224, 88),
			border2 = Color3.fromRGB(198, 134, 18),
			accent = Color3.fromRGB(255, 212, 65),
			accent2 = Color3.fromRGB(255, 154, 28),
			buttonBg = Color3.fromRGB(240, 182, 32),
			buttonText = Color3.fromRGB(16, 12, 6),
			textColor = Color3.fromRGB(255, 250, 238),
			subText = Color3.fromRGB(206, 184, 134),
			particleColor = Color3.fromRGB(255, 218, 78),
			sparkleColor = Color3.fromRGB(255, 246, 188),
			animStyle = "royal_shimmer",
			description = "24K obsidian-gold luxury theme with golden shimmer sweeps & particles.",
		},
		{
			id = "dark_emperor",
			name = "Dark Emperor",
			priceINR = 300,
			tag = "IMPERIAL",
			bg1 = Color3.fromRGB(6, 6, 9),
			bg2 = Color3.fromRGB(38, 12, 24),
			cardBg = Color3.fromRGB(14, 11, 18),
			border1 = Color3.fromRGB(224, 38, 78),
			border2 = Color3.fromRGB(255, 186, 56),
			accent = Color3.fromRGB(242, 52, 92),
			accent2 = Color3.fromRGB(255, 194, 68),
			buttonBg = Color3.fromRGB(192, 28, 64),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(248, 242, 246),
			subText = Color3.fromRGB(180, 146, 160),
			particleColor = Color3.fromRGB(246, 56, 96),
			sparkleColor = Color3.fromRGB(255, 206, 96),
			animStyle = "imperial_pulse",
			description = "Matte obsidian imperial canvas lined with crimson-gold energy streaks.",
		},
		{
			id = "purple_galaxy",
			name = "Purple Galaxy",
			priceINR = 300,
			tag = "COSMIC",
			bg1 = Color3.fromRGB(10, 6, 26),
			bg2 = Color3.fromRGB(50, 16, 90),
			cardBg = Color3.fromRGB(19, 12, 42),
			border1 = Color3.fromRGB(188, 76, 255),
			border2 = Color3.fromRGB(70, 188, 255),
			accent = Color3.fromRGB(198, 90, 255),
			accent2 = Color3.fromRGB(85, 208, 255),
			buttonBg = Color3.fromRGB(148, 54, 240),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(248, 244, 255),
			subText = Color3.fromRGB(178, 164, 220),
			particleColor = Color3.fromRGB(208, 132, 255),
			sparkleColor = Color3.fromRGB(178, 236, 255),
			animStyle = "nebula_drift",
			description = "Swirling amethyst galaxy backdrop with drifting astral stardust.",
		},
		{
			id = "cyber_neon",
			name = "Cyber Neon",
			priceINR = 300,
			tag = "CYBER",
			bg1 = Color3.fromRGB(10, 6, 22),
			bg2 = Color3.fromRGB(48, 8, 52),
			cardBg = Color3.fromRGB(18, 11, 34),
			border1 = Color3.fromRGB(0, 248, 255),
			border2 = Color3.fromRGB(255, 26, 162),
			accent = Color3.fromRGB(0, 248, 255),
			accent2 = Color3.fromRGB(255, 36, 168),
			buttonBg = Color3.fromRGB(224, 26, 142),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(242, 252, 255),
			subText = Color3.fromRGB(172, 158, 210),
			particleColor = Color3.fromRGB(0, 248, 255),
			sparkleColor = Color3.fromRGB(255, 72, 198),
			animStyle = "cyber_scan",
			description = "High-contrast neon pink & cyan cyberpunk showcase with scanner sheen.",
		},
		{
			id = "diamond_luxury",
			name = "Diamond Luxury",
			priceINR = 300,
			tag = "LUXURY",
			bg1 = Color3.fromRGB(13, 16, 24),
			bg2 = Color3.fromRGB(40, 50, 74),
			cardBg = Color3.fromRGB(21, 26, 40),
			border1 = Color3.fromRGB(238, 250, 255),
			border2 = Color3.fromRGB(136, 196, 255),
			accent = Color3.fromRGB(234, 248, 255),
			accent2 = Color3.fromRGB(146, 206, 255),
			buttonBg = Color3.fromRGB(198, 234, 255),
			buttonText = Color3.fromRGB(12, 16, 28),
			textColor = Color3.fromRGB(255, 255, 255),
			subText = Color3.fromRGB(180, 198, 224),
			particleColor = Color3.fromRGB(236, 248, 255),
			sparkleColor = Color3.fromRGB(255, 255, 255),
			animStyle = "diamond_sparkle",
			description = "Brushed platinum & diamond-white luxury profile with bright glints.",
		},
		{
			id = "crimson_fire",
			name = "Crimson Fire",
			priceINR = 300,
			tag = "ELEMENTAL",
			bg1 = Color3.fromRGB(18, 5, 6),
			bg2 = Color3.fromRGB(68, 16, 10),
			cardBg = Color3.fromRGB(28, 10, 12),
			border1 = Color3.fromRGB(255, 86, 20),
			border2 = Color3.fromRGB(255, 216, 46),
			accent = Color3.fromRGB(255, 96, 28),
			accent2 = Color3.fromRGB(255, 216, 56),
			buttonBg = Color3.fromRGB(224, 52, 20),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(255, 244, 238),
			subText = Color3.fromRGB(208, 152, 140),
			particleColor = Color3.fromRGB(255, 116, 30),
			sparkleColor = Color3.fromRGB(255, 226, 82),
			animStyle = "fire_rise",
			description = "Volcanic crimson inferno with rising glowing embers & lava borders.",
		},
		{
			id = "ice_crystal",
			name = "Ice Crystal",
			priceINR = 300,
			tag = "ELEMENTAL",
			bg1 = Color3.fromRGB(6, 15, 26),
			bg2 = Color3.fromRGB(16, 50, 80),
			cardBg = Color3.fromRGB(11, 26, 44),
			border1 = Color3.fromRGB(132, 240, 255),
			border2 = Color3.fromRGB(236, 252, 255),
			accent = Color3.fromRGB(136, 240, 255),
			accent2 = Color3.fromRGB(226, 250, 255),
			buttonBg = Color3.fromRGB(46, 186, 238),
			buttonText = Color3.fromRGB(8, 16, 26),
			textColor = Color3.fromRGB(242, 252, 255),
			subText = Color3.fromRGB(154, 206, 230),
			particleColor = Color3.fromRGB(186, 246, 255),
			sparkleColor = Color3.fromRGB(255, 255, 255),
			animStyle = "frost_drift",
			description = "Frosted arctic crystal glassmorphism with icy prismatic glimmers.",
		},
		{
			id = "shadow_lord",
			name = "Shadow Lord",
			priceINR = 300,
			tag = "MYTHIC",
			bg1 = Color3.fromRGB(5, 5, 8),
			bg2 = Color3.fromRGB(26, 9, 36),
			cardBg = Color3.fromRGB(11, 10, 18),
			border1 = Color3.fromRGB(148, 36, 238),
			border2 = Color3.fromRGB(238, 26, 76),
			accent = Color3.fromRGB(168, 56, 255),
			accent2 = Color3.fromRGB(246, 36, 86),
			buttonBg = Color3.fromRGB(118, 28, 198),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(240, 236, 248),
			subText = Color3.fromRGB(146, 138, 172),
			particleColor = Color3.fromRGB(158, 46, 246),
			sparkleColor = Color3.fromRGB(255, 46, 96),
			animStyle = "shadow_pulse",
			description = "Pitch-black eclipse sanctuary pulsing with dark violet-crimson energy.",
		},
		{
			id = "angelic_heaven",
			name = "Angelic Heaven",
			priceINR = 300,
			tag = "DIVINE",
			bg1 = Color3.fromRGB(18, 20, 32),
			bg2 = Color3.fromRGB(56, 50, 68),
			cardBg = Color3.fromRGB(26, 27, 42),
			border1 = Color3.fromRGB(255, 244, 186),
			border2 = Color3.fromRGB(186, 236, 255),
			accent = Color3.fromRGB(255, 242, 176),
			accent2 = Color3.fromRGB(192, 238, 255),
			buttonBg = Color3.fromRGB(246, 224, 126),
			buttonText = Color3.fromRGB(20, 18, 26),
			textColor = Color3.fromRGB(255, 253, 246),
			subText = Color3.fromRGB(204, 206, 226),
			particleColor = Color3.fromRGB(255, 248, 206),
			sparkleColor = Color3.fromRGB(255, 255, 255),
			animStyle = "divine_glow",
			description = "Celestial pearl-gold sanctuary with floating ethereal light motes.",
		},
		{
			id = "toxic_green",
			name = "Toxic Green",
			priceINR = 300,
			tag = "CYBER",
			bg1 = Color3.fromRGB(5, 14, 9),
			bg2 = Color3.fromRGB(12, 50, 24),
			cardBg = Color3.fromRGB(10, 24, 16),
			border1 = Color3.fromRGB(46, 255, 112),
			border2 = Color3.fromRGB(186, 255, 42),
			accent = Color3.fromRGB(50, 255, 120),
			accent2 = Color3.fromRGB(192, 255, 56),
			buttonBg = Color3.fromRGB(22, 198, 90),
			buttonText = Color3.fromRGB(6, 16, 10),
			textColor = Color3.fromRGB(238, 255, 242),
			subText = Color3.fromRGB(144, 200, 160),
			particleColor = Color3.fromRGB(56, 255, 122),
			sparkleColor = Color3.fromRGB(216, 255, 102),
			animStyle = "toxic_surge",
			description = "Radioactive emerald-lime bio-glow with rising neon plasma motes.",
		},
		{
			id = "ocean_blue",
			name = "Ocean Blue",
			priceINR = 300,
			tag = "ELEMENTAL",
			bg1 = Color3.fromRGB(5, 12, 26),
			bg2 = Color3.fromRGB(10, 44, 86),
			cardBg = Color3.fromRGB(10, 22, 46),
			border1 = Color3.fromRGB(0, 198, 255),
			border2 = Color3.fromRGB(46, 112, 255),
			accent = Color3.fromRGB(26, 206, 255),
			accent2 = Color3.fromRGB(66, 132, 255),
			buttonBg = Color3.fromRGB(18, 138, 238),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(240, 248, 255),
			subText = Color3.fromRGB(146, 190, 228),
			particleColor = Color3.fromRGB(66, 216, 255),
			sparkleColor = Color3.fromRGB(196, 242, 255),
			animStyle = "ocean_wave",
			description = "Deep abyssal sapphire waves with bioluminescent aqua shimmer.",
		},
		{
			id = "cosmic_universe",
			name = "Cosmic Universe",
			priceINR = 300,
			tag = "LEGENDARY",
			bg1 = Color3.fromRGB(8, 6, 20),
			bg2 = Color3.fromRGB(42, 14, 66),
			cardBg = Color3.fromRGB(16, 12, 34),
			border1 = Color3.fromRGB(255, 62, 196),
			border2 = Color3.fromRGB(0, 236, 255),
			accent = Color3.fromRGB(255, 76, 206),
			accent2 = Color3.fromRGB(0, 236, 255),
			buttonBg = Color3.fromRGB(182, 42, 228),
			buttonText = Color3.fromRGB(255, 255, 255),
			textColor = Color3.fromRGB(250, 246, 255),
			subText = Color3.fromRGB(180, 168, 214),
			particleColor = Color3.fromRGB(255, 116, 222),
			sparkleColor = Color3.fromRGB(112, 246, 255),
			animStyle = "cosmic_spin",
			description = "Multi-color supernova universe canvas with dual-tone starfield.",
		},
		{
			id = "holographic",
			name = "Holographic",
			priceINR = 300,
			tag = "PRISM",
			bg1 = Color3.fromRGB(12, 16, 28),
			bg2 = Color3.fromRGB(38, 24, 64),
			cardBg = Color3.fromRGB(18, 22, 40),
			border1 = Color3.fromRGB(112, 255, 236),
			border2 = Color3.fromRGB(236, 126, 255),
			accent = Color3.fromRGB(116, 255, 238),
			accent2 = Color3.fromRGB(236, 132, 255),
			buttonBg = Color3.fromRGB(96, 218, 218),
			buttonText = Color3.fromRGB(12, 16, 26),
			textColor = Color3.fromRGB(248, 252, 255),
			subText = Color3.fromRGB(176, 194, 224),
			particleColor = Color3.fromRGB(152, 250, 246),
			sparkleColor = Color3.fromRGB(246, 186, 255),
			animStyle = "holo_prism",
			description = "Iridescent liquid-prism glass with live shifting chroma borders.",
		},
		{
			id = "black_diamond",
			name = "Black Diamond",
			priceINR = 300,
			tag = "LUXURY",
			bg1 = Color3.fromRGB(4, 4, 6),
			bg2 = Color3.fromRGB(24, 26, 34),
			cardBg = Color3.fromRGB(11, 12, 16),
			border1 = Color3.fromRGB(246, 248, 255),
			border2 = Color3.fromRGB(96, 106, 128),
			accent = Color3.fromRGB(236, 240, 250),
			accent2 = Color3.fromRGB(146, 158, 184),
			buttonBg = Color3.fromRGB(234, 238, 246),
			buttonText = Color3.fromRGB(10, 10, 14),
			textColor = Color3.fromRGB(250, 250, 255),
			subText = Color3.fromRGB(154, 160, 178),
			particleColor = Color3.fromRGB(222, 230, 244),
			sparkleColor = Color3.fromRGB(255, 255, 255),
			animStyle = "stealth_sheen",
			description = "Ultra-minimalist jet-black carbon diamond finish with silver glints.",
		},
		{
			id = "electric_storm",
			name = "Electric Storm",
			priceINR = 300,
			tag = "ELEMENTAL",
			bg1 = Color3.fromRGB(6, 10, 24),
			bg2 = Color3.fromRGB(18, 30, 76),
			cardBg = Color3.fromRGB(12, 18, 40),
			border1 = Color3.fromRGB(72, 218, 255),
			border2 = Color3.fromRGB(148, 86, 255),
			accent = Color3.fromRGB(86, 226, 255),
			accent2 = Color3.fromRGB(168, 106, 255),
			buttonBg = Color3.fromRGB(46, 168, 255),
			buttonText = Color3.fromRGB(8, 12, 24),
			textColor = Color3.fromRGB(242, 250, 255),
			subText = Color3.fromRGB(156, 188, 230),
			particleColor = Color3.fromRGB(112, 232, 255),
			sparkleColor = Color3.fromRGB(255, 255, 255),
			animStyle = "storm_flash",
			description = "High-voltage thundercloud atmosphere with crackling plasma flashes.",
		},
	}

	Z100.Catalog.ProfileThemeMap = {}
	for _, tItem in ipairs(Z100.Catalog.ProfileThemes) do
		Z100.Catalog.ProfileThemeMap[tItem.id] = tItem
	end

	function Z100.Catalog.ResolveProfileTheme(themeId)
		if themeId and Z100.Catalog.ProfileThemeMap[themeId] then
			return Z100.Catalog.ProfileThemeMap[themeId]
		end
		return Z100.Catalog.BaseProfileTheme
	end

	-- ===================================================================== --
	-- [SECTION D : ANIMATED PROFILE BADGES & STICKERS]
	-- ===================================================================== --
	Z100.Catalog.Badges = {
		CREATOR = { label = "👑 OWNER",   c1 = Color3.fromRGB(0, 235, 255),   c2 = Color3.fromRGB(255, 52, 192),  bg = Color3.fromRGB(26, 12, 44) },
		VIP     = { label = "💎 VIP",     c1 = Color3.fromRGB(255, 216, 66),  c2 = Color3.fromRGB(255, 142, 22),  bg = Color3.fromRGB(40, 26, 10) },
		MUSIC   = { label = "♫ STUDIO",   c1 = Color3.fromRGB(0, 245, 185),   c2 = Color3.fromRGB(0, 168, 255),   bg = Color3.fromRGB(10, 32, 38) },
		LEGEND  = { label = "🌌 LEGEND",  c1 = Color3.fromRGB(188, 72, 255),  c2 = Color3.fromRGB(255, 62, 178),  bg = Color3.fromRGB(30, 12, 46) },
		ELITE   = { label = "⚡ ELITE",   c1 = Color3.fromRGB(0, 222, 255),   c2 = Color3.fromRGB(58, 118, 255),  bg = Color3.fromRGB(10, 26, 48) },
		OG      = { label = "🔥 OG",      c1 = Color3.fromRGB(255, 106, 42),  c2 = Color3.fromRGB(255, 46, 96),   bg = Color3.fromRGB(42, 14, 18) },
	}

	Z100.Catalog.Stickers = {
		"81131373496932", "87270658272764", "88879794421294", "76603582829185",
		"12323660650", "12623721060", "11419713314", "11419709766",
		"11419703493", "11419707443", "11419719540", "11419717830",
	}

	-- ===================================================================== --
	-- [SECTION E : FULL PROFILE ANIMATION ENGINE (ENTRANCE, AVATAR, BG, RINGS)]
	-- ===================================================================== --
	function Z100.Anim.PlaySequentialEntrance(rootCard, orderedChildren)
		if not rootCard or not rootCard.Parent then return end
		if Z100.State.Prefs.ReduceMotion then return end

		local sc = rootCard:FindFirstChild("V100EntranceScale") or Instance.new("UIScale", rootCard)
		sc.Name = "V100EntranceScale"
		sc.Scale = 0.93
		Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Pop, { Scale = 1.0 })

		if type(orderedChildren) == "table" then
			for idx, child in ipairs(orderedChildren) do
				if child and child:IsA("GuiObject") then
					local cScale = child:FindFirstChild("V100SeqScale") or Instance.new("UIScale", child)
					cScale.Name = "V100SeqScale"
					cScale.Scale = 0.92
					task.delay(idx * 0.045, function()
						if cScale and cScale.Parent then
							Z100.Theme.Tween(cScale, Z100.Theme.Tokens.Timing.Pop, { Scale = 1.0 })
						end
					end)
				end
			end
		end
	end

	function Z100.Anim.ClearAvatarDecoration(container)
		if not container then return end
		local oldId = container:GetAttribute("V100DecorAnimId")
		if oldId then
			Z100.Anim.Unregister(oldId)
			container:SetAttribute("V100DecorAnimId", nil)
		end
		local oldFx = container:FindFirstChild("V100AvatarDecorFX")
		if oldFx then oldFx:Destroy() end
	end

	function Z100.Anim.ApplyAvatarDecoration(container, decorId, compactMode)
		if not container or not container:IsA("GuiObject") then return end
		Z100.Anim.ClearAvatarDecoration(container)

		if not decorId or decorId == "" or decorId == "none" then return end
		local decor = Z100.Catalog.DecorationMap[decorId]
		if not decor then return end

		local isCompact = compactMode == true
		local baseZ = (container.ZIndex or 10) + 2

		local fxRoot = Instance.new("Frame")
		fxRoot.Name = "V100AvatarDecorFX"
		fxRoot.Size = UDim2.new(1, 0, 1, 0)
		fxRoot.Position = UDim2.new(0.5, 0, 0.5, 0)
		fxRoot.AnchorPoint = Vector2.new(0.5, 0.5)
		fxRoot.BackgroundTransparency = 1
		fxRoot.ZIndex = baseZ
		fxRoot.Parent = container

		-- Primary Rotating Light Ring
		local mainRing = Instance.new("Frame", fxRoot)
		mainRing.Size = UDim2.new(1, isCompact and 4 or 8, 1, isCompact and 4 or 8)
		mainRing.Position = UDim2.new(0.5, 0, 0.5, 0)
		mainRing.AnchorPoint = Vector2.new(0.5, 0.5)
		mainRing.BackgroundTransparency = 1
		mainRing.ZIndex = baseZ + 1
		Instance.new("UICorner", mainRing).CornerRadius = UDim.new(1, 0)

		local mainStroke = Instance.new("UIStroke", mainRing)
		mainStroke.Thickness = isCompact and 1.8 or 3.0
		mainStroke.Color = Color3.fromRGB(255, 255, 255)
		local mainGrad = Instance.new("UIGradient", mainStroke)
		mainGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.0, decor.accent),
			ColorSequenceKeypoint.new(0.5, decor.secondary),
			ColorSequenceKeypoint.new(1.0, decor.accent),
		})

		-- Outer Ambient Halo
		local haloRing = Instance.new("Frame", fxRoot)
		haloRing.Size = UDim2.new(1, isCompact and 8 or 16, 1, isCompact and 8 or 16)
		haloRing.Position = UDim2.new(0.5, 0, 0.5, 0)
		haloRing.AnchorPoint = Vector2.new(0.5, 0.5)
		haloRing.BackgroundTransparency = 1
		haloRing.ZIndex = baseZ
		Instance.new("UICorner", haloRing).CornerRadius = UDim.new(1, 0)

		local haloStroke = Instance.new("UIStroke", haloRing)
		haloStroke.Thickness = isCompact and 1.0 or 1.8
		haloStroke.Color = decor.accent
		haloStroke.Transparency = 0.45
		local haloGrad = Instance.new("UIGradient", haloStroke)
		haloGrad.Color = ColorSequence.new(decor.accent, decor.secondary)

		local function spawnOrbiters(count, sz, glyph, c1, c2)
			if isCompact then return {} end
			local list = {}
			for idx = 1, count do
				local obj
				if glyph then
					obj = Instance.new("TextLabel", fxRoot)
					obj.Size = UDim2.new(0, sz + 6, 0, sz + 6)
					obj.BackgroundTransparency = 1
					obj.Font = Enum.Font.GothamBold
					obj.TextSize = sz + 2
					obj.Text = glyph
					obj.TextColor3 = (idx % 2 == 0) and c2 or c1
				else
					obj = Instance.new("Frame", fxRoot)
					obj.Size = UDim2.new(0, sz, 0, sz)
					obj.BackgroundColor3 = (idx % 2 == 0) and c2 or c1
					obj.BorderSizePixel = 0
					Instance.new("UICorner", obj).CornerRadius = UDim.new(1, 0)
				end
				obj.AnchorPoint = Vector2.new(0.5, 0.5)
				obj.ZIndex = baseZ + 4
				table.insert(list, { obj = obj, phase = (idx - 1) * (math.pi * 2 / count), idx = idx })
			end
			return list
		end

		local fx = decor.fxType
		local animId = nil

		if fx == "angel_halo" then
			local haloOval = nil
			if not isCompact then
				haloOval = Instance.new("Frame", fxRoot)
				haloOval.Size = UDim2.new(0.88, 0, 0, 14)
				haloOval.Position = UDim2.new(0.5, 0, 0, -10)
				haloOval.AnchorPoint = Vector2.new(0.5, 0.5)
				haloOval.BackgroundTransparency = 1
				haloOval.ZIndex = baseZ + 5
				Instance.new("UICorner", haloOval).CornerRadius = UDim.new(1, 0)
				local hs = Instance.new("UIStroke", haloOval)
				hs.Thickness = 2.6
				hs.Color = Color3.fromRGB(255, 245, 168)
			end
			local glints = spawnOrbiters(3, 6, "✦", decor.accent, decor.secondary)
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 75) % 360
				haloStroke.Transparency = 0.34 + math.sin(now * 2.5) * 0.2
				if haloOval then
					haloOval.Position = UDim2.new(0.5, 0, 0, -10 + math.sin(now * 3.0) * 2.5)
				end
				for _, g in ipairs(glints) do
					local a = now * 1.1 + g.phase
					g.obj.Position = UDim2.new(0.5 + math.cos(a) * 0.58, 0, 0.5 + math.sin(a) * 0.58, 0)
				end
			end, false)

		elseif fx == "demon_horns" then
			local leftH, rightH = nil, nil
			if not isCompact then
				leftH = Instance.new("TextLabel", fxRoot)
				leftH.Size = UDim2.new(0, 22, 0, 22)
				leftH.Position = UDim2.new(0.16, 0, -0.08, 0)
				leftH.AnchorPoint = Vector2.new(0.5, 0.5)
				leftH.BackgroundTransparency = 1
				leftH.Font = Enum.Font.GothamBold
				leftH.TextSize = 18
				leftH.Text = "▲"
				leftH.Rotation = -28
				leftH.TextColor3 = Color3.fromRGB(255, 34, 68)
				leftH.ZIndex = baseZ + 5

				rightH = leftH:Clone()
				rightH.Position = UDim2.new(0.84, 0, -0.08, 0)
				rightH.Rotation = 28
				rightH.Parent = fxRoot
			end
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (-now * 145) % 360
				local p = (math.sin(now * 4.5) + 1) * 0.5
				haloStroke.Transparency = 0.2 + p * 0.45
				if leftH and rightH then
					local col = Color3.fromRGB(255, math.floor(25 + p * 60), math.floor(45 + p * 35))
					leftH.TextColor3 = col
					rightH.TextColor3 = col
				end
			end, false)

		elseif fx == "animated_wings" then
			local wL, wR = nil, nil
			if not isCompact then
				wL = Instance.new("TextLabel", fxRoot)
				wL.Size = UDim2.new(0, 26, 0, 26)
				wL.Position = UDim2.new(-0.18, 0, 0.45, 0)
				wL.AnchorPoint = Vector2.new(0.5, 0.5)
				wL.BackgroundTransparency = 1
				wL.Font = Enum.Font.GothamBold
				wL.TextSize = 20
				wL.Text = "🪽"
				wL.TextColor3 = decor.accent
				wL.ZIndex = baseZ + 5

				wR = wL:Clone()
				wR.Position = UDim2.new(1.18, 0, 0.45, 0)
				wR.Parent = fxRoot
			end
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 90) % 360
				haloStroke.Transparency = 0.3 + math.sin(now * 2.8) * 0.2
				if wL and wR then
					local flap = math.sin(now * 4.2) * 14
					wL.Rotation = -12 + flap
					wR.Rotation = 12 - flap
				end
			end, false)

		elseif fx == "fire_embers" then
			local embers = spawnOrbiters(5, 4, nil, Color3.fromRGB(255, 218, 56), Color3.fromRGB(255, 72, 18))
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 185) % 360
				local fl = (math.sin(now * 14) + math.cos(now * 8)) * 0.25 + 0.5
				mainStroke.Thickness = (isCompact and 1.8 or 2.8) + fl * 1.1
				haloStroke.Transparency = 0.22 + (1 - fl) * 0.45
				for _, em in ipairs(embers) do
					local life = (now * 0.9 + em.idx * 0.22) % 1
					em.obj.Position = UDim2.new(0.5 + math.sin(now * 3 + em.idx) * 0.44, 0, 0.95 - life * 1.15, 0)
					em.obj.BackgroundTransparency = life
				end
			end, false)

		elseif fx == "electric_bolts" then
			local bolts = spawnOrbiters(4, 7, "⚡", Color3.fromRGB(115, 238, 255), Color3.fromRGB(255, 255, 255))
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 310) % 360
				local zap = math.sin(now * 22) > 0.48
				mainStroke.Thickness = (isCompact and 1.8 or 2.8) + (zap and 1.2 or 0)
				haloStroke.Transparency = zap and 0.12 or 0.62
				for _, b in ipairs(bolts) do
					local a = now * 3.0 + b.phase
					b.obj.Position = UDim2.new(0.5 + math.cos(a) * 0.58, 0, 0.5 + math.sin(a) * 0.58, 0)
					b.obj.TextTransparency = zap and 0 or 0.42
				end
			end, false)

		elseif fx == "chroma_pulse" then
			animId = Z100.Anim.Register(fxRoot, function(now)
				local h1 = (now * 0.26) % 1
				local c1 = Color3.fromHSV(h1, 0.9, 1)
				local c2 = Color3.fromHSV((h1 + 0.33) % 1, 0.9, 1)
				local c3 = Color3.fromHSV((h1 + 0.66) % 1, 0.9, 1)
				mainGrad.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, c1),
					ColorSequenceKeypoint.new(0.5, c2),
					ColorSequenceKeypoint.new(1, c3),
				})
				mainGrad.Rotation = (now * 140) % 360
				local wave = (now * 1.05) % 1
				local pad = (isCompact and 4 or 8) + math.floor(wave * (isCompact and 8 or 18))
				haloRing.Size = UDim2.new(1, pad, 1, pad)
				haloStroke.Color = c1
				haloStroke.Transparency = wave
			end, false)

		elseif fx == "floating_gems" or fx == "diamond_glint" or fx == "crystal_frost" then
			local glyph = fx == "crystal_frost" and "❄" or (fx == "floating_gems" and "◆" or "✦")
			local orbs = spawnOrbiters(4, 7, glyph, decor.accent, decor.secondary)
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 115) % 360
				haloGrad.Rotation = (-now * 95) % 360
				haloStroke.Transparency = 0.25 + math.abs(math.sin(now * 3.0)) * 0.42
				for _, ob in ipairs(orbs) do
					local a = now * 1.35 + ob.phase
					ob.obj.Position = UDim2.new(0.5 + math.cos(a) * 0.58, 0, 0.5 + math.sin(a) * 0.58, 0)
					ob.obj.Rotation = (now * 90) % 360
				end
			end, false)

		elseif fx == "badge_crest" or fx == "ring_crown" or fx == "ornate_frame" then
			local glyph = fx == "badge_crest" and "👑" or "✦"
			local orbs = spawnOrbiters(4, 6, glyph, decor.accent, decor.secondary)
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 100) % 360
				haloGrad.Rotation = (-now * 75) % 360
				haloStroke.Transparency = 0.26 + ((math.sin(now * 2.8) + 1) * 0.22)
				for _, ob in ipairs(orbs) do
					local a = now * 1.2 + ob.phase
					ob.obj.Position = UDim2.new(0.5 + math.cos(a) * 0.58, 0, 0.5 + math.sin(a) * 0.58, 0)
				end
			end, false)

		else
			local orbs = spawnOrbiters(5, 5, nil, decor.accent, decor.secondary)
			animId = Z100.Anim.Register(fxRoot, function(now)
				mainGrad.Rotation = (now * 135) % 360
				haloGrad.Rotation = (-now * 110) % 360
				haloStroke.Transparency = 0.26 + ((math.sin(now * 3.2) + 1) * 0.24)
				for _, ob in ipairs(orbs) do
					local dir = (ob.idx % 2 == 0) and 1 or -1
					local a = now * (1.75 * dir) + ob.phase
					local rad = 0.56 + math.sin(now * 2.5 + ob.idx) * 0.04
					ob.obj.Position = UDim2.new(0.5 + math.cos(a) * rad, 0, 0.5 + math.sin(a) * rad, 0)
				end
			end, false)
		end

		if animId then
			container:SetAttribute("V100DecorAnimId", animId)
		end
	end

	-- Full Coordinated Profile Background, Border, Particles, Shapes & Light Streaks
	function Z100.Anim.ApplyFullProfileEffects(heroCard, bgGrad, themeObj, isPremiumVisual)
		if not heroCard or not themeObj then return end

		for _, oldName in ipairs({ "V100Particles", "V100Sparkles", "V100LightSweep", "V100GeoShapes" }) do
			local oldObj = heroCard:FindFirstChild(oldName)
			if oldObj then
				local aId = oldObj:GetAttribute("AnimId")
				if aId then Z100.Anim.Unregister(aId) end
				oldObj:Destroy()
			end
		end
		local oldBorderId = heroCard:GetAttribute("V100BorderAnimId")
		if oldBorderId then Z100.Anim.Unregister(oldBorderId) end

		-- Smooth color transition on background card
		Z100.Theme.Tween(heroCard, Z100.Theme.Tokens.Timing.Smooth, { BackgroundColor3 = themeObj.cardBg })
		if bgGrad then
			bgGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)
		end

		-- 1. Glowing Animated Border + Subtle Moving Gradient
		local stroke = heroCard:FindFirstChild("V100ProfileBorder") or Instance.new("UIStroke", heroCard)
		stroke.Name = "V100ProfileBorder"
		stroke.Thickness = isPremiumVisual and 2.2 or 1.5
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Transparency = 0.1

		local sGrad = stroke:FindFirstChild("BorderGrad") or Instance.new("UIGradient", stroke)
		sGrad.Name = "BorderGrad"
		sGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.0, themeObj.border1),
			ColorSequenceKeypoint.new(0.5, themeObj.border2),
			ColorSequenceKeypoint.new(1.0, themeObj.border1),
		})

		local borderAnimId = Z100.Anim.Register(heroCard, function(now)
			if themeObj.animStyle == "holo_prism" then
				local h = (now * 0.22) % 1
				sGrad.Color = ColorSequence.new(Color3.fromHSV(h, 0.85, 1), Color3.fromHSV((h + 0.4) % 1, 0.85, 1))
			end
			sGrad.Rotation = (now * (isPremiumVisual and 85 or 40)) % 360
			if bgGrad and not Z100.State.Prefs.ReduceMotion then
				bgGrad.Rotation = 132 + math.sin(now * 0.65) * 26
			end
		end, false)
		heroCard:SetAttribute("V100BorderAnimId", borderAnimId)

		-- Respect ReduceMotion / ParticlesEnabled / Low Intensity
		local prefs = Z100.State.Prefs
		if prefs.ReduceMotion or not prefs.ParticlesEnabled or prefs.AnimIntensity == "Low" then
			return
		end

		local baseZ = (heroCard.ZIndex or 30) + 1
		local densityMult = (prefs.AnimIntensity == "High") and 1.0 or 0.55

		-- 2. Subtle Animated Ambient Orbs / Shapes
		local shapeLayer = Instance.new("Frame", heroCard)
		shapeLayer.Name = "V100GeoShapes"
		shapeLayer.Size = UDim2.new(1, 0, 1, 0)
		shapeLayer.BackgroundTransparency = 1
		shapeLayer.ClipsDescendants = true
		shapeLayer.ZIndex = baseZ

		local orbA = Instance.new("Frame", shapeLayer)
		orbA.Size = UDim2.new(0, 120, 0, 120)
		orbA.BackgroundColor3 = themeObj.accent
		orbA.BackgroundTransparency = 0.90
		orbA.BorderSizePixel = 0
		orbA.ZIndex = baseZ
		Instance.new("UICorner", orbA).CornerRadius = UDim.new(1, 0)

		local orbB = Instance.new("Frame", shapeLayer)
		orbB.Size = UDim2.new(0, 96, 0, 96)
		orbB.BackgroundColor3 = themeObj.accent2
		orbB.BackgroundTransparency = 0.91
		orbB.BorderSizePixel = 0
		orbB.ZIndex = baseZ
		Instance.new("UICorner", orbB).CornerRadius = UDim.new(1, 0)

		local shapeAnimId = Z100.Anim.Register(shapeLayer, function(now)
			orbA.Position = UDim2.new(0.05 + math.sin(now * 0.45) * 0.08, 0, -0.15 + math.cos(now * 0.35) * 0.1, 0)
			orbB.Position = UDim2.new(0.75 + math.cos(now * 0.4) * 0.08, 0, 0.55 + math.sin(now * 0.5) * 0.12, 0)
		end, true)
		shapeLayer:SetAttribute("AnimId", shapeAnimId)

		-- 3. Floating Particles Layer
		local pLayer = Instance.new("Frame", heroCard)
		pLayer.Name = "V100Particles"
		pLayer.Size = UDim2.new(1, 0, 1, 0)
		pLayer.BackgroundTransparency = 1
		pLayer.ClipsDescendants = true
		pLayer.ZIndex = baseZ + 1

		local pCount = math.max(4, math.floor((isPremiumVisual and 12 or 6) * densityMult))
		local dots = {}
		for idx = 1, pCount do
			local dot = Instance.new("Frame", pLayer)
			local sz = math.random(2, 5)
			dot.Size = UDim2.new(0, sz, 0, sz)
			dot.BackgroundColor3 = themeObj.particleColor
			dot.BorderSizePixel = 0
			dot.ZIndex = baseZ + 1
			Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
			table.insert(dots, {
				obj = dot,
				x = math.random(5, 95) / 100,
				spd = 0.07 + math.random(1, 9) / 90,
				off = math.random(0, 100) / 100,
				sway = math.random(2, 5) / 100,
			})
		end

		local pAnimId = Z100.Anim.Register(pLayer, function(now)
			for idx, pt in ipairs(dots) do
				local prog = (now * pt.spd + pt.off) % 1
				pt.obj.Position = UDim2.new(pt.x + math.sin(now * 1.6 + idx) * pt.sway, 0, 1.05 - prog * 1.15, 0)
				pt.obj.BackgroundTransparency = 1 - (math.sin(prog * math.pi) * 0.65)
			end
		end, true)
		pLayer:SetAttribute("AnimId", pAnimId)

		-- 4. Twinkling Sparkles Layer
		local spLayer = Instance.new("Frame", heroCard)
		spLayer.Name = "V100Sparkles"
		spLayer.Size = UDim2.new(1, 0, 1, 0)
		spLayer.BackgroundTransparency = 1
		spLayer.ClipsDescendants = true
		spLayer.ZIndex = baseZ + 2

		local spCount = math.max(2, math.floor((isPremiumVisual and 6 or 3) * densityMult))
		local sparkles = {}
		for idx = 1, spCount do
			local sp = Instance.new("TextLabel", spLayer)
			sp.Size = UDim2.new(0, 12, 0, 12)
			sp.Position = UDim2.new(math.random(8, 92) / 100, 0, math.random(10, 88) / 100, 0)
			sp.BackgroundTransparency = 1
			sp.Font = Enum.Font.GothamBold
			sp.TextSize = math.random(8, 12)
			sp.TextColor3 = themeObj.sparkleColor
			sp.Text = "✦"
			sp.ZIndex = baseZ + 2
			table.insert(sparkles, { obj = sp, phase = idx * 1.4, rate = 2.2 + (idx % 3) * 0.7 })
		end

		local spAnimId = Z100.Anim.Register(spLayer, function(now)
			for _, s in ipairs(sparkles) do
				local glow = (math.sin(now * s.rate + s.phase) + 1) * 0.5
				s.obj.TextTransparency = 1 - (glow * 0.85)
				s.obj.Rotation = (now * 45 + s.phase * 20) % 360
			end
		end, true)
		spLayer:SetAttribute("AnimId", spAnimId)

		-- 5. Moving Light Streak Sweep (Premium Themes)
		if isPremiumVisual then
			local sweepWrap = Instance.new("Frame", heroCard)
			sweepWrap.Name = "V100LightSweep"
			sweepWrap.Size = UDim2.new(1, 0, 1, 0)
			sweepWrap.BackgroundTransparency = 1
			sweepWrap.ClipsDescendants = true
			sweepWrap.ZIndex = baseZ + 1

			local beam = Instance.new("Frame", sweepWrap)
			beam.Size = UDim2.new(0.28, 0, 1.9, 0)
			beam.Position = UDim2.new(-0.4, 0, -0.45, 0)
			beam.Rotation = 22
			beam.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			beam.BackgroundTransparency = 0.88
			beam.BorderSizePixel = 0
			beam.ZIndex = baseZ + 1

			local bGrad = Instance.new("UIGradient", beam)
			bGrad.Color = ColorSequence.new(themeObj.accent, themeObj.accent2)
			bGrad.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0.76),
				NumberSequenceKeypoint.new(1, 1),
			})

			local swId = Z100.Anim.Register(sweepWrap, function(now)
				local prog = (now * 0.24) % 1
				beam.Position = UDim2.new(-0.45 + prog * 1.9, 0, -0.45, 0)
			end, true)
			sweepWrap:SetAttribute("AnimId", swId)
		end
	end

	-- Animated Story Ring (Unseen = bright Instagram gradient | Seen = muted | None = hidden)
	function Z100.Anim.ApplyStoryRing(avatarHolder, storyState)
		if not avatarHolder then return end
		local oldRing = avatarHolder:FindFirstChild("V100StoryRing")
		if oldRing then
			local oldId = oldRing:GetAttribute("AnimId")
			if oldId then Z100.Anim.Unregister(oldId) end
			oldRing:Destroy()
		end

		if storyState ~= "unseen" and storyState ~= "seen" then return end

		local ring = Instance.new("Frame", avatarHolder)
		ring.Name = "V100StoryRing"
		ring.Size = UDim2.new(1, 12, 1, 12)
		ring.Position = UDim2.new(0.5, 0, 0.5, 0)
		ring.AnchorPoint = Vector2.new(0.5, 0.5)
		ring.BackgroundTransparency = 1
		ring.ZIndex = (avatarHolder.ZIndex or 35) + 6
		Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)

		local st = Instance.new("UIStroke", ring)
		st.Thickness = storyState == "unseen" and 3.0 or 2.0

		if storyState == "unseen" then
			st.Color = Color3.fromRGB(255, 255, 255)
			local grad = Instance.new("UIGradient", st)
			grad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 200, 45)),
				ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 45, 132)),
				ColorSequenceKeypoint.new(0.7, Color3.fromRGB(165, 50, 255)),
				ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 232, 255)),
			})
			local id = Z100.Anim.Register(ring, function(now)
				grad.Rotation = (now * 145) % 360
			end, false)
			ring:SetAttribute("AnimId", id)
		else
			st.Color = Color3.fromRGB(115, 115, 140)
			st.Transparency = 0.42
		end
	end

	function Z100.Anim.ApplyGradientText(lbl, c1, c2)
		if not lbl then return end
		local oldGrad = lbl:FindFirstChild("V100TextGrad")
		if oldGrad then oldGrad:Destroy() end
		local oldId = lbl:GetAttribute("V100TextAnimId")
		if oldId then Z100.Anim.Unregister(oldId) end

		lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		local grad = Instance.new("UIGradient", lbl)
		grad.Name = "V100TextGrad"
		grad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, c1 or Color3.fromRGB(165, 78, 255)),
			ColorSequenceKeypoint.new(0.5, c2 or Color3.fromRGB(255, 212, 68)),
			ColorSequenceKeypoint.new(1, c1 or Color3.fromRGB(165, 78, 255)),
		})

		local id = Z100.Anim.Register(lbl, function(now)
			grad.Offset = Vector2.new(math.sin(now * 1.5) * 0.55, 0)
		end, false)
		lbl:SetAttribute("V100TextAnimId", id)
	end

	function Z100.Anim.CreateAnimatedBadge(parent, badgeKey)
		local info = Z100.Catalog.Badges[tostring(badgeKey or ""):upper()]
		if not info then return nil end

		local pill = Instance.new("Frame", parent)
		pill.Name = "Badge_" .. badgeKey
		pill.Size = UDim2.new(0, 0, 0, 20)
		pill.AutomaticSize = Enum.AutomaticSize.X
		pill.BackgroundColor3 = info.bg
		pill.ZIndex = (parent.ZIndex or 30) + 2
		Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

		local pad = Instance.new("UIPadding", pill)
		pad.PaddingLeft = UDim.new(0, 8)
		pad.PaddingRight = UDim.new(0, 8)

		local st = Instance.new("UIStroke", pill)
		st.Thickness = 1.2
		st.Color = Color3.fromRGB(255, 255, 255)
		local stGrad = Instance.new("UIGradient", st)
		stGrad.Color = ColorSequence.new(info.c1, info.c2)

		local lbl = Instance.new("TextLabel", pill)
		lbl.Size = UDim2.new(0, 0, 1, 0)
		lbl.AutomaticSize = Enum.AutomaticSize.X
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.GothamBold
		lbl.TextSize = 9.5
		lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		lbl.Text = info.label
		lbl.ZIndex = pill.ZIndex + 1

		Z100.Anim.Register(pill, function(now)
			stGrad.Rotation = (now * 110) % 360
		end, false)

		return pill
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 5 / 15 : PERSISTENT BACKEND (SOCIAL, PAID STORE, TICKETS & ADMIN)
-- ========================================================================= --

do
	local Players = Z100.Services.Players
	local Nodes = Z100.Nodes
	local State = Z100.State
	local Util = Z100.Util
	local DB = Z100.DB

	local rateTimestamps = {
		follow = 0,
		profile = 0,
		ticket = 0,
		report = 0,
	}

	local function checkRate(bucket, cooldownSec)
		if Util.IsAdmin() then return true, 0 end
		local now = os.clock()
		local prev = rateTimestamps[bucket] or 0
		if now - prev < cooldownSec then
			return false, math.ceil(cooldownSec - (now - prev))
		end
		rateTimestamps[bucket] = now
		return true, 0
	end

	-- ===================================================================== --
	-- [SECTION A : STORE CONFIG & STRICT 100%-PAID PRICING ENGINE]
	-- ===================================================================== --
	function Z100.Backend.FetchStoreConfig()
		local raw = DB.Get(Nodes.StoreConfig)
		if type(raw) == "table" then
			local cfg = State.StoreConfig
			if tonumber(raw.decorationPriceINR) then
				cfg.decorationPriceINR = math.max(1, math.floor(tonumber(raw.decorationPriceINR)))
			end
			if tonumber(raw.themePriceINR) then
				cfg.themePriceINR = math.max(1, math.floor(tonumber(raw.themePriceINR)))
			end
			if tonumber(raw.bundlePriceINR) then
				cfg.bundlePriceINR = math.max(1, math.floor(tonumber(raw.bundlePriceINR)))
			end
			if tonumber(raw.musicPassPriceINR) then
				cfg.musicPassPriceINR = math.max(1, math.floor(tonumber(raw.musicPassPriceINR)))
			end
			if type(raw.discordContact) == "string" and raw.discordContact ~= "" then
				cfg.discordContact = raw.discordContact
			end
			if type(raw.discordServer) == "string" and raw.discordServer ~= "" then
				cfg.discordServer = raw.discordServer
			end
			if type(raw.discordURL) == "string" then
				cfg.discordURL = raw.discordURL
			end
			cfg.disabledDecorations = type(raw.disabledDecorations) == "table" and raw.disabledDecorations or {}
			cfg.disabledThemes = type(raw.disabledThemes) == "table" and raw.disabledThemes or {}
			cfg.priceOverrides = type(raw.priceOverrides) == "table" and raw.priceOverrides or {}
		end
		return State.StoreConfig
	end

	function Z100.Backend.GetBundlePrice()
		return math.max(1, tonumber(State.StoreConfig.bundlePriceINR) or Z100.Config.Store.BundlePriceINR)
	end

	function Z100.Backend.GetMusicPassPrice()
		return math.max(1, tonumber(State.StoreConfig.musicPassPriceINR) or Z100.Config.Store.MusicStudioPriceINR)
	end

	function Z100.Backend.GetDecorationPrice(decorId)
		local ov = State.StoreConfig.priceOverrides
		if type(ov) == "table" and tonumber(ov["dec_" .. tostring(decorId)]) then
			return math.max(1, math.floor(tonumber(ov["dec_" .. tostring(decorId)])))
		end
		return math.max(1, tonumber(State.StoreConfig.decorationPriceINR) or Z100.Config.Store.DecorationPriceINR)
	end

	function Z100.Backend.GetThemePrice(themeId)
		local ov = State.StoreConfig.priceOverrides
		if type(ov) == "table" and tonumber(ov["thm_" .. tostring(themeId)]) then
			return math.max(1, math.floor(tonumber(ov["thm_" .. tostring(themeId)])))
		end
		return math.max(1, tonumber(State.StoreConfig.themePriceINR) or Z100.Config.Store.ThemePriceINR)
	end

	function Z100.Backend.IsDecorationEnabled(decorId)
		local dis = State.StoreConfig.disabledDecorations
		return not (type(dis) == "table" and dis[decorId] == true)
	end

	function Z100.Backend.IsThemeEnabled(themeId)
		local dis = State.StoreConfig.disabledThemes
		return not (type(dis) == "table" and dis[themeId] == true)
	end

	-- ===================================================================== --
	-- [SECTION B : STRICT PAID ENTITLEMENTS (ZERO FREE STORE ITEMS)]
	-- ===================================================================== --
	function Z100.Backend.EmptyEntitlement()
		return {
			cosmeticsBundle = false, -- ₹300 ZAYN PREMIUM PACKAGE
			musicStudioPass = false, -- ₹1500 ONLINE MUSIC STUDIO PRO PASS
			ownedDecorations = {},
			ownedThemes = {},
			badges = {},
			grantedBy = "",
			grantedAt = 0,
			history = {},
		}
	end

	function Z100.Backend.FetchEntitlements(uid, forceRefresh)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return Z100.Backend.EmptyEntitlement() end

		if not forceRefresh and State.Entitlements[uidStr] then
			return State.Entitlements[uidStr]
		end

		local raw = DB.Get(Nodes.Entitlements .. "/" .. uidStr)
		local ent = Z100.Backend.EmptyEntitlement()
		if type(raw) == "table" then
			ent.cosmeticsBundle = raw.cosmeticsBundle == true
			ent.musicStudioPass = raw.musicStudioPass == true
			ent.ownedDecorations = type(raw.ownedDecorations) == "table" and raw.ownedDecorations or {}
			ent.ownedThemes = type(raw.ownedThemes) == "table" and raw.ownedThemes or {}
			ent.badges = type(raw.badges) == "table" and raw.badges or {}
			ent.grantedBy = tostring(raw.grantedBy or "")
			ent.grantedAt = tonumber(raw.grantedAt) or 0
			ent.history = type(raw.history) == "table" and raw.history or {}
		end

		-- Authorized Owner automatically has full entitlements
		if Util.IsAdmin(uidStr, "") then
			ent.cosmeticsBundle = true
			ent.musicStudioPass = true
		end

		State.Entitlements[uidStr] = ent
		return ent
	end

	function Z100.Backend.HasCosmeticsBundle(uid)
		local uidStr = Util.NormalizeUid(uid) or Z100.MyUid
		if Util.IsAdmin(uidStr, "") then return true end
		local ent = State.Entitlements[uidStr]
		return type(ent) == "table" and ent.cosmeticsBundle == true
	end

	function Z100.Backend.HasMusicStudioPass(uid)
		local uidStr = Util.NormalizeUid(uid) or Z100.MyUid
		if Util.IsAdmin(uidStr, "") then return true end
		local ent = State.Entitlements[uidStr]
		return type(ent) == "table" and ent.musicStudioPass == true
	end

	-- Strict Paid Check: Only "none" (unequipped) is available without purchase
	function Z100.Backend.OwnsDecoration(uid, decorId)
		if not decorId or decorId == "" or decorId == "none" then return true end
		local uidStr = Util.NormalizeUid(uid) or Z100.MyUid
		if Z100.Backend.HasCosmeticsBundle(uidStr) then return true end
		local ent = State.Entitlements[uidStr]
		return type(ent) == "table" and type(ent.ownedDecorations) == "table" and ent.ownedDecorations[decorId] == true
	end

	-- Strict Paid Check: Only "default_base" (Standard Obsidian) is available without purchase
	function Z100.Backend.OwnsTheme(uid, themeId)
		if not themeId or themeId == "" or themeId == "default_base" then return true end
		local uidStr = Util.NormalizeUid(uid) or Z100.MyUid
		if Z100.Backend.HasCosmeticsBundle(uidStr) then return true end
		local ent = State.Entitlements[uidStr]
		return type(ent) == "table" and type(ent.ownedThemes) == "table" and ent.ownedThemes[themeId] == true
	end

	-- ===================================================================== --
	-- [SECTION C : PROFILES PERSISTENCE & VALIDATION]
	-- ===================================================================== --
	function Z100.Backend.DefaultPrivacy()
		return {
			isPrivate = false,
			allowFollows = true,
			hideLists = false,
			dmPermission = "Everyone", -- Everyone | Followers | Mutuals | None
			storyPrivacy = "Public",   -- Public | Followers | Private
		}
	end

	function Z100.Backend.BuildDefaultProfile(uidStr, username, displayName)
		local acc = Util.GetAccountByUid(uidStr)
		local uName = (username and username ~= "") and username or acc.Username
		local dName = (displayName and displayName ~= "") and displayName or acc.DisplayName
		return {
			uid = uidStr,
			username = uName,
			displayName = dName,
			customAvatar = "",
			bio = "",
			theme = "default_base",
			decoration = "none",
			badges = {},
			privacy = Z100.Backend.DefaultPrivacy(),
			createdAt = Util.Now(),
			updatedAt = Util.Now(),
		}
	end

	function Z100.Backend.NormalizeProfile(uidStr, raw)
		local base = Z100.Backend.BuildDefaultProfile(uidStr)
		local ent = Z100.Backend.FetchEntitlements(uidStr, false)
		local tbl = type(raw) == "table" and raw or {}

		local themeId = tostring(tbl.theme or "default_base")
		local decorId = tostring(tbl.decoration or "none")

		-- Enforce paid ownership on profile hydration
		if themeId ~= "default_base" and not Z100.Backend.OwnsTheme(uidStr, themeId) then
			themeId = "default_base"
		end
		if decorId ~= "none" and not Z100.Backend.OwnsDecoration(uidStr, decorId) then
			decorId = "none"
		end

		local prof = {
			uid = uidStr,
			username = (type(tbl.username) == "string" and tbl.username ~= "") and tbl.username or base.username,
			displayName = (type(tbl.displayName) == "string" and tbl.displayName ~= "") and tbl.displayName or base.displayName,
			customAvatar = type(tbl.customAvatar) == "string" and tbl.customAvatar or "",
			bio = type(tbl.bio) == "string" and tbl.bio or "",
			theme = themeId,
			decoration = decorId,
			badges = {},
			privacy = Z100.Backend.DefaultPrivacy(),
			createdAt = tonumber(tbl.createdAt) or base.createdAt,
			updatedAt = tonumber(tbl.updatedAt) or Util.Now(),
		}

		local seenB = {}
		local function pushBadge(key)
			local k = tostring(key or ""):upper()
			if Z100.Catalog.Badges[k] and not seenB[k] then
				seenB[k] = true
				table.insert(prof.badges, k)
			end
		end

		if Util.IsAdmin(uidStr, prof.username) then
			pushBadge("CREATOR"); pushBadge("VIP"); pushBadge("LEGEND"); pushBadge("OG")
		end
		if ent.cosmeticsBundle then
			pushBadge("VIP"); pushBadge("ELITE")
		end
		if ent.musicStudioPass then
			pushBadge("MUSIC")
		end
		if type(ent.badges) == "table" then
			for k, v in pairs(ent.badges) do
				if type(k) == "number" and type(v) == "string" then
					pushBadge(v)
				elseif v == true then
					pushBadge(k)
				end
			end
		end

		if type(tbl.privacy) == "table" then
			prof.privacy.isPrivate = tbl.privacy.isPrivate == true
			prof.privacy.allowFollows = tbl.privacy.allowFollows ~= false
			prof.privacy.hideLists = tbl.privacy.hideLists == true
			local dmP = tostring(tbl.privacy.dmPermission or "Everyone")
			if dmP == "Everyone" or dmP == "Followers" or dmP == "Mutuals" or dmP == "None" then
				prof.privacy.dmPermission = dmP
			end
			local stP = tostring(tbl.privacy.storyPrivacy or "Public")
			if stP == "Public" or stP == "Followers" or stP == "Private" then
				prof.privacy.storyPrivacy = stP
			end
		end

		Util.RegisterAccount(prof.username, prof.displayName, tonumber(uidStr) or 1)
		return prof
	end

	function Z100.Backend.FetchProfile(uid, forceRefresh)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return nil end

		if not forceRefresh and State.Profiles[uidStr] then
			return State.Profiles[uidStr]
		end

		Z100.Backend.FetchEntitlements(uidStr, forceRefresh == true)
		local raw = DB.Get(Nodes.Profiles .. "/" .. uidStr)
		local prof = Z100.Backend.NormalizeProfile(uidStr, raw)
		State.Profiles[uidStr] = prof

		-- Auto-initialize own profile & searchable directory entry on first run
		if uidStr == Z100.MyUid and type(raw) ~= "table" then
			prof.username = Z100.MyName
			prof.displayName = Z100.Player.DisplayName
			State.Profiles[uidStr] = prof
			DB.PutAsync(Nodes.Profiles .. "/" .. uidStr, prof)
			DB.PutAsync(Nodes.UserIndex .. "/" .. Z100.MyNameLower, {
				uid = uidStr,
				username = Z100.MyName,
				displayName = prof.displayName,
				updatedAt = Util.Now(),
			})
		end
		return prof
	end

	function Z100.Backend.SaveMyProfile(updates)
		local okRate, waitSec = checkRate("profile", 1.5)
		if not okRate then
			return false, "Please wait " .. tostring(waitSec) .. "s before saving again."
		end

		local myUid = Z100.MyUid
		local current = Z100.Backend.FetchProfile(myUid, false)
		if not current then return false, "Could not load your profile." end

		-- Re-verify entitlements directly from DB before allowing any paid cosmetic equip
		Z100.Backend.FetchEntitlements(myUid, true)

		if type(updates.displayName) == "string" then
			local clean = updates.displayName:gsub("^%s+", ""):gsub("%s+$", ""):sub(1, Z100.Config.Limits.DisplayNameMax)
			if clean ~= "" then current.displayName = clean end
		end

		if type(updates.bio) == "string" then
			current.bio = updates.bio:gsub("[\r\n]+", " "):sub(1, Z100.Config.Limits.BioMax)
		end

		if type(updates.customAvatar) == "string" then
			local av = updates.customAvatar:gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 240)
			if av == "" or av:match("^%d+$") or av:match("^rbxassetid://%d+$") or av:match("^rbxthumb://") or av:match("^https?://") then
				current.customAvatar = av
			else
				return false, "Invalid image format. Use a Roblox Asset ID or direct image URL."
			end
		end

		if type(updates.theme) == "string" then
			local tId = updates.theme
			if tId ~= "default_base" then
				if not Z100.Catalog.ProfileThemeMap[tId] then
					return false, "Unknown profile theme."
				end
				if not Z100.Backend.IsThemeEnabled(tId) then
					return false, "This theme is currently disabled by Admin."
				end
				if not Z100.Backend.OwnsTheme(myUid, tId) then
					return false, "Theme locked! Purchase for ₹" .. tostring(Z100.Backend.GetThemePrice(tId)) .. " in Paid Store."
				end
			end
			current.theme = tId
		end

		if type(updates.decoration) == "string" then
			local dId = updates.decoration
			if dId ~= "none" then
				if not Z100.Catalog.DecorationMap[dId] then
					return false, "Unknown avatar decoration."
				end
				if not Z100.Backend.IsDecorationEnabled(dId) then
					return false, "This decoration is currently disabled by Admin."
				end
				if not Z100.Backend.OwnsDecoration(myUid, dId) then
					return false, "Decoration locked! Purchase for ₹" .. tostring(Z100.Backend.GetDecorationPrice(dId)) .. " in Paid Store."
				end
			end
			current.decoration = dId
		end

		if type(updates.privacy) == "table" then
			local pr = updates.privacy
			if pr.isPrivate ~= nil then current.privacy.isPrivate = pr.isPrivate == true end
			if pr.allowFollows ~= nil then current.privacy.allowFollows = pr.allowFollows == true end
			if pr.hideLists ~= nil then current.privacy.hideLists = pr.hideLists == true end
			if pr.dmPermission == "Everyone" or pr.dmPermission == "Followers" or pr.dmPermission == "Mutuals" or pr.dmPermission == "None" then
				current.privacy.dmPermission = pr.dmPermission
			end
			if pr.storyPrivacy == "Public" or pr.storyPrivacy == "Followers" or pr.storyPrivacy == "Private" then
				current.privacy.storyPrivacy = pr.storyPrivacy
			end
		end

		-- Username is strictly locked to Roblox account identity
		current.username = Z100.MyName
		current.updatedAt = Util.Now()
		State.Profiles[myUid] = current

		local ok, errMsg = DB.Put(Nodes.Profiles .. "/" .. myUid, current)
		if not ok then
			return false, errMsg or "Failed to save profile to database."
		end

		DB.PutAsync(Nodes.UserIndex .. "/" .. Z100.MyNameLower, {
			uid = myUid,
			username = Z100.MyName,
			displayName = current.displayName,
			updatedAt = current.updatedAt,
		})

		return true, "Profile changes saved permanently!"
	end

	-- ===================================================================== --
	-- [SECTION D : PRESENCE, NOTIFICATIONS, BLOCKS & FOLLOW GRAPH]
	-- ===================================================================== --
	function Z100.Backend.HeartbeatPresence()
		local ts = Util.Now()
		State.Presence[Z100.MyUid] = { online = true, lastSeen = ts, jobId = State.JobId }
		DB.PutAsync(Nodes.Presence .. "/" .. Z100.MyUid, {
			online = true,
			lastSeen = ts,
			username = Z100.MyName,
			displayName = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName,
			jobId = State.JobId,
		})
	end

	function Z100.Backend.FetchPresence(uid)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return false, 0 end
		if Players:GetPlayerByUserId(tonumber(uidStr)) then
			State.Presence[uidStr] = { online = true, lastSeen = Util.Now() }
			return true, Util.Now()
		end
		local raw = DB.Get(Nodes.Presence .. "/" .. uidStr)
		if type(raw) == "table" then
			local ls = tonumber(raw.lastSeen) or 0
			local on = (raw.online == true) and ((Util.Now() - ls) <= 80)
			State.Presence[uidStr] = { online = on, lastSeen = ls }
			return on, ls
		end
		State.Presence[uidStr] = { online = false, lastSeen = 0 }
		return false, 0
	end

	function Z100.Backend.IsOnlineCached(uid)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return false end
		if Players:GetPlayerByUserId(tonumber(uidStr)) then return true end
		local p = State.Presence[uidStr]
		return p ~= nil and p.online == true and (Util.Now() - (p.lastSeen or 0)) <= 80
	end

	function Z100.Backend.PushNotif(targetUid, nType, title, msg, fromUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return end
		local ts = Util.Now()
		local nId = "N_" .. tostring(ts) .. "_" .. tostring(math.random(1000, 9999))
		DB.PutAsync(Nodes.Notifs .. "/" .. tUid .. "/" .. nId, {
			id = nId,
			type = tostring(nType or "social"),
			title = tostring(title or "Notification"):sub(1, 80),
			message = tostring(msg or ""):sub(1, 180),
			fromUid = Util.NormalizeUid(fromUid) or Z100.MyUid,
			read = false,
			timestamp = ts,
		})
	end

	local function shouldShowToastForNotif(nType)
		local prefs = State.Prefs
		if nType == "follow" or nType == "follow_request" or nType == "request_accepted" then
			return prefs.NotifyFollows ~= false
		elseif nType == "story_reaction" or nType == "story_reply" then
			return prefs.NotifyStories ~= false
		elseif nType == "new_message" then
			return prefs.NotifyMessages ~= false
		end
		return true
	end

	function Z100.Backend.FetchMyNotifs(silentInitial)
		local raw = DB.Get(Nodes.Notifs .. "/" .. Z100.MyUid)
		if type(raw) ~= "table" then return State.Notifs end

		local list, unread = {}, 0
		for nId, item in pairs(raw) do
			if type(item) == "table" and item.title then
				item.id = item.id or nId
				table.insert(list, item)
				if item.read ~= true then unread = unread + 1 end
				if not State.SeenNotifIds[item.id] then
					State.SeenNotifIds[item.id] = true
					if not silentInitial and item.read ~= true and shouldShowToastForNotif(item.type) and Z100.UI.ShowToast then
						local p = Z100.Theme.Get()
						local col = (item.type == "purchase_approved") and p.Gold or p.Accent
						Z100.UI.ShowToast(item.title, item.message, col, item.fromUid, function()
							if Z100.Router.Navigate then
								Z100.Router.Navigate("Notifications")
							end
						end)
					end
				end
			end
		end

		table.sort(list, function(a, b) return (tonumber(a.timestamp) or 0) > (tonumber(b.timestamp) or 0) end)
		while #list > 50 do
			local old = table.remove(list)
			if old and old.id then
				DB.DeleteAsync(Nodes.Notifs .. "/" .. Z100.MyUid .. "/" .. old.id)
			end
		end

		State.Notifs = list
		State.UnreadNotifs = unread
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
		return list
	end

	function Z100.Backend.MarkNotifRead(notifId)
		if not notifId then return end
		for _, item in ipairs(State.Notifs) do
			if item.id == notifId and item.read ~= true then
				item.read = true
				DB.PutAsync(Nodes.Notifs .. "/" .. Z100.MyUid .. "/" .. notifId .. "/read", true)
				State.UnreadNotifs = math.max(0, (State.UnreadNotifs or 1) - 1)
				if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
				break
			end
		end
	end

	function Z100.Backend.MarkAllNotifsRead()
		for _, item in ipairs(State.Notifs) do
			if item.read ~= true and item.id then
				item.read = true
				DB.PutAsync(Nodes.Notifs .. "/" .. Z100.MyUid .. "/" .. item.id .. "/read", true)
			end
		end
		State.UnreadNotifs = 0
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
	end

	function Z100.Backend.FetchMyBlocks()
		local raw = DB.Get(Nodes.Blocks .. "/" .. Z100.MyUid)
		State.Blocks = type(raw) == "table" and raw or {}
		return State.Blocks
	end

	function Z100.Backend.IsBlocked(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		return tUid ~= nil and State.Blocks[tUid] == true
	end

	function Z100.Backend.IsBlockedBy(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false end
		if State.BlockedBy[tUid] ~= nil then return State.BlockedBy[tUid] == true end
		local res = DB.Get(Nodes.Blocks .. "/" .. tUid .. "/" .. Z100.MyUid)
		local blocked = (res == true or res == "true")
		State.BlockedBy[tUid] = blocked
		return blocked
	end

	function Z100.Backend.BlockUser(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid or tUid == Z100.MyUid then return false, "You cannot block yourself." end
		local ok, errMsg = DB.Put(Nodes.Blocks .. "/" .. Z100.MyUid .. "/" .. tUid, true)
		if not ok then return false, errMsg end
		State.Blocks[tUid] = true

		-- Clean follow relationships & requests in both directions
		DB.DeleteAsync(Nodes.Following .. "/" .. Z100.MyUid .. "/" .. tUid)
		DB.DeleteAsync(Nodes.Followers .. "/" .. tUid .. "/" .. Z100.MyUid)
		DB.DeleteAsync(Nodes.Following .. "/" .. tUid .. "/" .. Z100.MyUid)
		DB.DeleteAsync(Nodes.Followers .. "/" .. Z100.MyUid .. "/" .. tUid)
		DB.DeleteAsync(Nodes.FollowRequests .. "/" .. Z100.MyUid .. "/" .. tUid)
		DB.DeleteAsync(Nodes.FollowRequests .. "/" .. tUid .. "/" .. Z100.MyUid)

		if State.Following[Z100.MyUid] then State.Following[Z100.MyUid][tUid] = nil end
		if State.Followers[tUid] then State.Followers[tUid][Z100.MyUid] = nil end
		if State.Followers[Z100.MyUid] then State.Followers[Z100.MyUid][tUid] = nil end
		if State.Following[tUid] then State.Following[tUid][Z100.MyUid] = nil end
		State.Requests[tUid] = nil
		State.SentRequests[tUid] = nil

		return true, "User blocked."
	end

	function Z100.Backend.UnblockUser(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid user." end
		State.Blocks[tUid] = nil
		local ok, errMsg = DB.Delete(Nodes.Blocks .. "/" .. Z100.MyUid .. "/" .. tUid)
		return ok, ok and "User unblocked." or errMsg
	end

	function Z100.Backend.FetchGraph(uid, forceRefresh)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return {}, {} end
		if forceRefresh or not State.Followers[uidStr] then
			local f = DB.Get(Nodes.Followers .. "/" .. uidStr)
			State.Followers[uidStr] = type(f) == "table" and f or {}
		end
		if forceRefresh or not State.Following[uidStr] then
			local g = DB.Get(Nodes.Following .. "/" .. uidStr)
			State.Following[uidStr] = type(g) == "table" and g or {}
		end
		return State.Followers[uidStr], State.Following[uidStr]
	end

	function Z100.Backend.FetchMyRequests()
		local raw = DB.Get(Nodes.FollowRequests .. "/" .. Z100.MyUid)
		State.Requests = type(raw) == "table" and raw or {}
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
		return State.Requests
	end

	function Z100.Backend.GetFollowerCount(uid)
		local uidStr = Util.NormalizeUid(uid)
		return uidStr and Util.CountKeys(State.Followers[uidStr]) or 0
	end

	function Z100.Backend.GetFollowingCount(uid)
		local uidStr = Util.NormalizeUid(uid)
		return uidStr and Util.CountKeys(State.Following[uidStr]) or 0
	end

	function Z100.Backend.IsFollowing(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		local myF = State.Following[Z100.MyUid]
		return tUid ~= nil and type(myF) == "table" and myF[tUid] ~= nil and myF[tUid] ~= false
	end

	function Z100.Backend.IsFollowedBy(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		local myF = State.Followers[Z100.MyUid]
		return tUid ~= nil and type(myF) == "table" and myF[tUid] ~= nil and myF[tUid] ~= false
	end

	function Z100.Backend.IsMutual(targetUid)
		return Z100.Backend.IsFollowing(targetUid) and Z100.Backend.IsFollowedBy(targetUid)
	end

	function Z100.Backend.HasSentRequestTo(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false end
		if State.SentRequests[tUid] then return true end
		local raw = DB.Get(Nodes.FollowRequests .. "/" .. tUid .. "/" .. Z100.MyUid)
		if type(raw) == "table" then
			State.SentRequests[tUid] = true
			return true
		end
		return false
	end

	function Z100.Backend.FollowUser(targetUid)
		local okRate, waitSec = checkRate("follow", 0.8)
		if not okRate then return false, "Slow down (" .. tostring(waitSec) .. "s)." end

		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid user ID." end
		if tUid == Z100.MyUid then return false, "You cannot follow yourself." end
		if Z100.Backend.IsBlocked(tUid) then return false, "Unblock this user before following." end
		if Z100.Backend.IsBlockedBy(tUid) then return false, "You cannot follow this account." end
		if Z100.Backend.IsFollowing(tUid) then return false, "You are already following this user." end

		local tProf = Z100.Backend.FetchProfile(tUid, true)
		if tProf and tProf.privacy and tProf.privacy.allowFollows == false then
			return false, "This user has disabled new followers."
		end

		local ts = Util.Now()
		local myDisp = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName

		if tProf and tProf.privacy and tProf.privacy.isPrivate == true then
			if Z100.Backend.HasSentRequestTo(tUid) then return false, "Follow request already pending." end
			local ok, errMsg = DB.Put(Nodes.FollowRequests .. "/" .. tUid .. "/" .. Z100.MyUid, {
				uid = Z100.MyUid,
				username = Z100.MyName,
				displayName = myDisp,
				time = ts,
			})
			if not ok then return false, errMsg end
			State.SentRequests[tUid] = true
			Z100.Backend.PushNotif(tUid, "follow_request", "📩 Follow Request", myDisp .. " (@" .. Z100.MyName .. ") requested to follow you.", Z100.MyUid)
			return true, "Follow request sent!"
		end

		local ok1, err1 = DB.Put(Nodes.Following .. "/" .. Z100.MyUid .. "/" .. tUid, ts)
		if not ok1 then return false, err1 end
		local ok2, err2 = DB.Put(Nodes.Followers .. "/" .. tUid .. "/" .. Z100.MyUid, ts)
		if not ok2 then return false, err2 end

		State.Following[Z100.MyUid] = State.Following[Z100.MyUid] or {}
		State.Following[Z100.MyUid][tUid] = ts
		State.Followers[tUid] = State.Followers[tUid] or {}
		State.Followers[tUid][Z100.MyUid] = ts

		Z100.Backend.PushNotif(tUid, "follow", "👤 New Follower", myDisp .. " (@" .. Z100.MyName .. ") started following you!", Z100.MyUid)
		return true, "Now following!"
	end

	function Z100.Backend.UnfollowUser(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid user." end
		DB.Delete(Nodes.Following .. "/" .. Z100.MyUid .. "/" .. tUid)
		DB.Delete(Nodes.Followers .. "/" .. tUid .. "/" .. Z100.MyUid)
		if State.Following[Z100.MyUid] then State.Following[Z100.MyUid][tUid] = nil end
		if State.Followers[tUid] then State.Followers[tUid][Z100.MyUid] = nil end
		return true, "Unfollowed."
	end

	function Z100.Backend.CancelFollowRequest(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid user." end
		DB.Delete(Nodes.FollowRequests .. "/" .. tUid .. "/" .. Z100.MyUid)
		State.SentRequests[tUid] = nil
		return true, "Follow request cancelled."
	end

	function Z100.Backend.AcceptFollowRequest(requesterUid)
		local rUid = Util.NormalizeUid(requesterUid)
		if not rUid or rUid == Z100.MyUid then return false, "Invalid requester." end
		local ts = Util.Now()
		DB.Delete(Nodes.FollowRequests .. "/" .. Z100.MyUid .. "/" .. rUid)
		DB.Put(Nodes.Followers .. "/" .. Z100.MyUid .. "/" .. rUid, ts)
		DB.Put(Nodes.Following .. "/" .. rUid .. "/" .. Z100.MyUid, ts)

		State.Requests[rUid] = nil
		State.Followers[Z100.MyUid] = State.Followers[Z100.MyUid] or {}
		State.Followers[Z100.MyUid][rUid] = ts
		State.Following[rUid] = State.Following[rUid] or {}
		State.Following[rUid][Z100.MyUid] = ts

		local myDisp = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName
		Z100.Backend.PushNotif(rUid, "request_accepted", "✅ Request Accepted", myDisp .. " accepted your follow request!", Z100.MyUid)
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
		return true, "Follow request accepted!"
	end

	function Z100.Backend.DeclineFollowRequest(requesterUid)
		local rUid = Util.NormalizeUid(requesterUid)
		if not rUid then return false, "Invalid requester." end
		DB.Delete(Nodes.FollowRequests .. "/" .. Z100.MyUid .. "/" .. rUid)
		State.Requests[rUid] = nil
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
		return true, "Follow request declined."
	end

	function Z100.Backend.RemoveFollower(followerUid)
		local fUid = Util.NormalizeUid(followerUid)
		if not fUid then return false, "Invalid user." end
		DB.Delete(Nodes.Followers .. "/" .. Z100.MyUid .. "/" .. fUid)
		DB.Delete(Nodes.Following .. "/" .. fUid .. "/" .. Z100.MyUid)
		if State.Followers[Z100.MyUid] then State.Followers[Z100.MyUid][fUid] = nil end
		if State.Following[fUid] then State.Following[fUid][Z100.MyUid] = nil end
		return true, "Follower removed."
	end

	function Z100.Backend.CanMessageUser(targetUid)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid or tUid == Z100.MyUid then return false, "You cannot message yourself." end
		if Z100.Backend.IsBlocked(tUid) then return false, "You blocked this user." end
		if Z100.Backend.IsBlockedBy(tUid) then return false, "You cannot message this account." end
		local prof = Z100.Backend.FetchProfile(tUid, false)
		local perm = (prof and prof.privacy and prof.privacy.dmPermission) or "Everyone"
		if perm == "None" then
			return false, "This user has disabled direct messages."
		elseif perm == "Followers" and not Z100.Backend.IsFollowing(tUid) then
			return false, "Only followers can message this user."
		elseif perm == "Mutuals" and not Z100.Backend.IsMutual(tUid) then
			return false, "Only mutual followers can message this user."
		end
		return true, "Allowed"
	end

	function Z100.Backend.ReportUser(targetUid, reason)
		local okRate, waitSec = checkRate("report", 8)
		if not okRate then return false, "Wait " .. tostring(waitSec) .. "s before submitting another report." end
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid or tUid == Z100.MyUid then return false, "Invalid target." end
		local clean = tostring(reason or "Inappropriate behavior"):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 200)
		if clean == "" then clean = "Inappropriate behavior" end
		local repId = "REP_" .. tostring(Util.Now()) .. "_" .. tostring(math.random(1000, 9999))
		return DB.Put(Nodes.Reports .. "/" .. repId, {
			id = repId,
			reporterUid = Z100.MyUid,
			reporterName = Z100.MyName,
			targetUid = tUid,
			reason = clean,
			timestamp = Util.Now(),
		})
	end

	-- Suggested Users for Home Screen (Live server players + recent directory accounts)
	function Z100.Backend.FetchSuggestedUsers(maxCount)
		local limit = maxCount or 8
		local seen = { [Z100.MyUid] = true }
		local results = {}

		-- 1. Live server players first
		for _, plr in ipairs(Players:GetPlayers()) do
			local uStr = tostring(plr.UserId)
			if not seen[uStr] and not Z100.Backend.IsBlocked(uStr) then
				seen[uStr] = true
				Util.RegisterAccount(plr.Name, plr.DisplayName, plr.UserId)
				table.insert(results, {
					uid = uStr,
					username = plr.Name,
					displayName = plr.DisplayName,
					inServer = true,
				})
				if #results >= limit then return results end
			end
		end

		-- 2. Recent registered V100 directory users
		local rawIdx = DB.Get(Nodes.UserIndex)
		if type(rawIdx) == "table" then
			local dir = {}
			for _, u in pairs(rawIdx) do
				if type(u) == "table" and u.uid and not seen[tostring(u.uid)] and not Z100.Backend.IsBlocked(u.uid) then
					table.insert(dir, u)
				end
			end
			table.sort(dir, function(a, b) return (tonumber(a.updatedAt) or 0) > (tonumber(b.updatedAt) or 0) end)
			for _, u in ipairs(dir) do
				local uStr = tostring(u.uid)
				if not seen[uStr] then
					seen[uStr] = true
					Util.RegisterAccount(tostring(u.username or "User"), tostring(u.displayName or u.username or "User"), tonumber(uStr) or 1)
					table.insert(results, {
						uid = uStr,
						username = tostring(u.username or ("User_" .. uStr)),
						displayName = tostring(u.displayName or u.username or ("User " .. uStr)),
						inServer = false,
					})
					if #results >= limit then break end
				end
			end
		end

		return results
	end

	-- ===================================================================== --
	-- [SECTION E : PAID STORE VERIFICATION TICKETS (NO FAKE UNLOCKS)]
	-- ===================================================================== --
	function Z100.Backend.SubmitPurchaseTicket(itemType, itemId, itemName, priceINR, discordUser, note)
		local okRate, waitSec = checkRate("ticket", 10)
		if not okRate then
			return false, "Please wait " .. tostring(waitSec) .. "s before submitting another ticket."
		end

		local cleanDisc = tostring(discordUser or ""):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 50)
		if cleanDisc == "" then
			return false, "Enter your Discord username so Admin can verify your payment."
		end

		local ts = Util.Now()
		local ticketId = "PAY100_" .. Z100.MyUid .. "_" .. tostring(ts)
		local payload = {
			id = ticketId,
			uid = Z100.MyUid,
			username = Z100.MyName,
			displayName = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName,
			itemType = tostring(itemType or "cosmetics_bundle"), -- cosmetics_bundle | music_studio | decoration | theme
			itemId = tostring(itemId or "zayn_premium_300"),
			itemName = tostring(itemName or "ZAYN Premium Package"):sub(1, 64),
			priceINR = math.max(1, math.floor(tonumber(priceINR) or 300)),
			discordUser = cleanDisc,
			note = tostring(note or ""):gsub("[\r\n]+", " "):sub(1, 140),
			status = "pending_verification",
			createdAt = ts,
		}

		local ok, errMsg = DB.Put(Nodes.PurchaseTickets .. "/" .. ticketId, payload)
		if not ok then return false, errMsg end

		return true, ticketId
	end

	function Z100.Backend.FetchMyPurchaseTickets()
		local raw = DB.Get(Nodes.PurchaseTickets)
		local mine = {}
		if type(raw) == "table" then
			for id, item in pairs(raw) do
				if type(item) == "table" and tostring(item.uid) == Z100.MyUid then
					item.id = item.id or id
					table.insert(mine, item)
				end
			end
		end
		table.sort(mine, function(a, b) return (tonumber(a.createdAt) or 0) > (tonumber(b.createdAt) or 0) end)
		return mine
	end

	-- ===================================================================== --
	-- [SECTION F : AUTHORIZED OWNER ADMIN APIs & AUDIT LOGGING]
	-- ===================================================================== --
	function Z100.Backend.AdminLogAction(action, targetUid, details)
		if not Util.IsAdmin() then return end
		local ts = Util.Now()
		local logId = "ALOG_" .. tostring(ts) .. "_" .. tostring(math.random(100, 999))
		DB.PutAsync(Nodes.AdminLogs .. "/" .. logId, {
			id = logId,
			adminUid = Z100.MyUid,
			adminName = Z100.MyName,
			action = tostring(action or "admin_action"),
			targetUid = tostring(targetUid or ""),
			details = tostring(details or ""):sub(1, 160),
			timestamp = ts,
		})
	end

	function Z100.Backend.AdminFetchLogs()
		if not Util.IsAdmin() then return {} end
		local raw = DB.Get(Nodes.AdminLogs)
		local list = {}
		if type(raw) == "table" then
			for id, item in pairs(raw) do
				if type(item) == "table" and item.action then
					item.id = item.id or id
					table.insert(list, item)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.timestamp) or 0) > (tonumber(b.timestamp) or 0) end)
		return list
	end

	function Z100.Backend.AdminFetchPurchaseTickets()
		if not Util.IsAdmin() then return {} end
		local raw = DB.Get(Nodes.PurchaseTickets)
		local list = {}
		if type(raw) == "table" then
			for id, item in pairs(raw) do
				if type(item) == "table" and item.uid then
					item.id = item.id or id
					table.insert(list, item)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.createdAt) or 0) > (tonumber(b.createdAt) or 0) end)
		return list
	end

	function Z100.Backend.AdminSaveEntitlement(targetUid, ent, logAction)
		if not Util.IsAdmin() then return false, "Unauthorized: Admin only." end
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid target UID." end

		ent.grantedBy = Z100.MyName
		ent.grantedAt = Util.Now()
		ent.history = type(ent.history) == "table" and ent.history or {}
		table.insert(ent.history, 1, {
			action = tostring(logAction or "update"),
			by = Z100.MyName,
			at = ent.grantedAt,
		})
		while #ent.history > 15 do table.remove(ent.history) end

		local ok, errMsg = DB.Put(Nodes.Entitlements .. "/" .. tUid, ent)
		if not ok then return false, errMsg end

		State.Entitlements[tUid] = ent
		Z100.Backend.AdminLogAction(logAction, tUid, "Entitlement updated by @" .. Z100.MyName)
		return true, "Updated entitlements for UID " .. tUid
	end

	function Z100.Backend.AdminSetCosmeticsBundle(targetUid, grantBool)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid User ID." end
		local ent = Z100.Backend.FetchEntitlements(tUid, true)
		ent.cosmeticsBundle = grantBool == true
		ent.badges.VIP = grantBool == true
		ent.badges.ELITE = grantBool == true
		local ok, msg = Z100.Backend.AdminSaveEntitlement(tUid, ent, grantBool and "grant_bundle_300" or "revoke_bundle_300")
		if ok then
			Z100.Backend.PushNotif(
				tUid,
				"purchase_approved",
				grantBool and "👑 ₹300 PREMIUM PACKAGE UNLOCKED!" or "⚠️ Premium Package Revoked",
				grantBool and "Payment verified! All 16 Avatar Decorations, 15 Profile Themes & Royal Gold UI unlocked permanently." or "Your Premium Cosmetics Bundle was revoked by Admin.",
				Z100.MyUid
			)
		end
		return ok, msg
	end

	function Z100.Backend.AdminSetMusicStudioPass(targetUid, grantBool)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid then return false, "Invalid User ID." end
		local ent = Z100.Backend.FetchEntitlements(tUid, true)
		ent.musicStudioPass = grantBool == true
		ent.badges.MUSIC = grantBool == true
		local ok, msg = Z100.Backend.AdminSaveEntitlement(tUid, ent, grantBool and "grant_music_1500" or "revoke_music_1500")
		if ok then
			Z100.Backend.PushNotif(
				tUid,
				"purchase_approved",
				grantBool and "♫ ₹1500 MUSIC STUDIO PRO UNLOCKED!" or "⚠️ Music Studio Pass Revoked",
				grantBool and "Payment verified! Online YouTube Search, MP3 Player & Story Music unlocked permanently." or "Your Music Studio Pass was revoked by Admin.",
				Z100.MyUid
			)
		end
		return ok, msg
	end

	function Z100.Backend.AdminSetSingleItem(targetUid, itemType, itemId, grantBool)
		local tUid = Util.NormalizeUid(targetUid)
		if not tUid or not itemId or itemId == "" then return false, "Invalid User ID or Item ID." end
		local ent = Z100.Backend.FetchEntitlements(tUid, true)
		if itemType == "decoration" then
			ent.ownedDecorations[itemId] = grantBool and true or nil
		elseif itemType == "theme" then
			ent.ownedThemes[itemId] = grantBool and true or nil
		elseif itemType == "badge" then
			ent.badges[tostring(itemId):upper()] = grantBool and true or nil
		else
			return false, "Invalid item type (decoration / theme / badge)."
		end
		local ok, msg = Z100.Backend.AdminSaveEntitlement(tUid, ent, (grantBool and "grant_" or "revoke_") .. itemType .. ":" .. itemId)
		if ok and grantBool then
			Z100.Backend.PushNotif(tUid, "purchase_approved", "🎁 Cosmetic Unlocked!", "Admin granted you " .. itemId .. " (" .. itemType .. ").", Z100.MyUid)
		end
		return ok, msg
	end

	function Z100.Backend.AdminVerifyTicket(ticketObj, approveBool)
		if not Util.IsAdmin() then return false, "Admin only." end
		if type(ticketObj) ~= "table" or not ticketObj.id or not ticketObj.uid then
			return false, "Invalid ticket."
		end

		if approveBool then
			local ok, msg
			if ticketObj.itemType == "cosmetics_bundle" then
				ok, msg = Z100.Backend.AdminSetCosmeticsBundle(ticketObj.uid, true)
			elseif ticketObj.itemType == "music_studio" then
				ok, msg = Z100.Backend.AdminSetMusicStudioPass(ticketObj.uid, true)
			elseif ticketObj.itemType == "decoration" or ticketObj.itemType == "theme" then
				ok, msg = Z100.Backend.AdminSetSingleItem(ticketObj.uid, ticketObj.itemType, ticketObj.itemId, true)
			else
				return false, "Unknown ticket itemType."
			end
			if not ok then return false, msg end

			DB.Put(Nodes.PurchaseTickets .. "/" .. ticketObj.id .. "/status", '"approved"')
			DB.PutAsync(Nodes.PurchaseTickets .. "/" .. ticketObj.id .. "/verifiedBy", '"' .. Z100.MyName .. '"')
			Z100.Backend.AdminLogAction("approve_ticket", ticketObj.uid, ticketObj.id .. " (" .. tostring(ticketObj.itemName) .. ")")
			return true, "Approved & unlocked for @" .. tostring(ticketObj.username)
		else
			DB.Put(Nodes.PurchaseTickets .. "/" .. ticketObj.id .. "/status", '"rejected"')
			DB.PutAsync(Nodes.PurchaseTickets .. "/" .. ticketObj.id .. "/verifiedBy", '"' .. Z100.MyName .. '"')
			Z100.Backend.PushNotif(ticketObj.uid, "purchase_rejected", "❌ Ticket Rejected", "Ticket " .. ticketObj.id .. " could not be verified. Contact @" .. State.StoreConfig.discordContact .. " on Discord.", Z100.MyUid)
			Z100.Backend.AdminLogAction("reject_ticket", ticketObj.uid, ticketObj.id)
			return true, "Ticket marked rejected."
		end
	end

	function Z100.Backend.AdminSaveStoreConfig()
		if not Util.IsAdmin() then return false, "Admin only." end
		local ok, err = DB.Put(Nodes.StoreConfig, State.StoreConfig)
		if ok then
			Z100.Backend.AdminLogAction("update_store_config", Z100.MyUid, "Updated store pricing/config")
		end
		return ok, err
	end

	function Z100.Backend.AdminFetchUsersList()
		if not Util.IsAdmin() then return {} end
		local raw = DB.Get(Nodes.UserIndex)
		local list = {}
		if type(raw) == "table" then
			for _, u in pairs(raw) do
				if type(u) == "table" and u.uid then
					table.insert(list, u)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.updatedAt) or 0) > (tonumber(b.updatedAt) or 0) end)
		return list
	end

	function Z100.Backend.AdminFetchUserReports()
		if not Util.IsAdmin() then return {} end
		local raw = DB.Get(Nodes.Reports)
		local list = {}
		if type(raw) == "table" then
			for id, r in pairs(raw) do
				if type(r) == "table" and r.targetUid then
					r.id = r.id or id
					table.insert(list, r)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.timestamp) or 0) > (tonumber(b.timestamp) or 0) end)
		return list
	end

	function Z100.Backend.AdminDismissUserReport(repId)
		if not Util.IsAdmin() or not repId then return false, "Unauthorized." end
		local ok, err = DB.Delete(Nodes.Reports .. "/" .. tostring(repId))
		if ok then Z100.Backend.AdminLogAction("dismiss_user_report", "", tostring(repId)) end
		return ok, ok and "Report dismissed." or err
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 6 / 15 : 24H STORIES BACKEND & ONLINE YOUTUBE MUSIC API ENGINE
-- ========================================================================= --

do
	local Players = Z100.Services.Players
	local HttpService = Z100.Services.Http
	local SoundService = Z100.Services.Sound
	local Nodes = Z100.Nodes
	local State = Z100.State
	local Util = Z100.Util
	local DB = Z100.DB

	local storyPublishClock = 0

	-- ===================================================================== --
	-- [SECTION A : 24-HOUR PHOTO STORIES BACKEND]
	-- ===================================================================== --
	Z100.Stories.Backgrounds = {
		{ id = "obsidian",   name = "Obsidian",   c1 = Color3.fromRGB(10, 10, 18), c2 = Color3.fromRGB(38, 16, 70) },
		{ id = "royal_gold", name = "Royal Gold", c1 = Color3.fromRGB(18, 14, 8),  c2 = Color3.fromRGB(78, 54, 12) },
		{ id = "cyber_neon", name = "Cyber Neon", c1 = Color3.fromRGB(10, 8, 30),  c2 = Color3.fromRGB(72, 12, 76) },
		{ id = "crimson",    name = "Crimson",    c1 = Color3.fromRGB(24, 6, 10),  c2 = Color3.fromRGB(90, 18, 22) },
		{ id = "ocean_glow", name = "Ocean",      c1 = Color3.fromRGB(6, 16, 36),  c2 = Color3.fromRGB(12, 68, 112) },
		{ id = "emerald",    name = "Emerald",    c1 = Color3.fromRGB(6, 22, 14),  c2 = Color3.fromRGB(14, 74, 44) },
	}

	Z100.Stories.BackgroundMap = {}
	for _, bg in ipairs(Z100.Stories.Backgrounds) do
		Z100.Stories.BackgroundMap[bg.id] = bg
	end

	Z100.Stories.QuickStickers = { "", "🔥", "👑", "💎", "⚡", "❤️", "✨", "♫", "😈", "🦋", "🌙", "💯" }
	Z100.Stories.DraftMusic = nil

	function Z100.Stories.SetDraftMusic(trackObj)
		if type(trackObj) == "table" and tostring(trackObj.videoId or "") ~= "" then
			Z100.Stories.DraftMusic = {
				videoId = tostring(trackObj.videoId),
				title = tostring(trackObj.title or "Online Track"):sub(1, 64),
				artist = tostring(trackObj.artist or "YouTube Music"):sub(1, 44),
				duration = tonumber(trackObj.duration) or 0,
				thumbnail = tostring(trackObj.thumbnail or ""),
				mp3Url = tostring(trackObj.mp3Url or ""),
				startTime = math.max(0, tonumber(trackObj.startTime) or 0),
				volume = math.clamp(tonumber(trackObj.volume) or 0.7, 0, 1),
			}
		else
			Z100.Stories.DraftMusic = nil
		end
	end

	function Z100.Backend.CanViewStory(story)
		if type(story) ~= "table" or not story.ownerUid then return false end
		local ownerUid = tostring(story.ownerUid)
		if ownerUid == Z100.MyUid or Util.IsAdmin() then return true end
		if Z100.Backend.IsBlocked(ownerUid) or Z100.Backend.IsBlockedBy(ownerUid) then return false end
		local priv = tostring(story.privacy or "Public")
		if priv == "Private" then return false end
		if priv == "Followers" then return Z100.Backend.IsFollowing(ownerUid) end
		return true
	end

	function Z100.Backend.FetchUserStories(uid, forceRefresh)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return {} end

		if not forceRefresh and State.StoriesByUid[uidStr] then
			local cached, nowTs = {}, Util.Now()
			for _, st in ipairs(State.StoriesByUid[uidStr]) do
				if (tonumber(st.expiresAt) or 0) > nowTs and Z100.Backend.CanViewStory(st) then
					table.insert(cached, st)
				end
			end
			return cached
		end

		local raw = DB.Get(Nodes.Stories .. "/" .. uidStr)
		local active, nowTs = {}, Util.Now()
		if type(raw) == "table" then
			for sId, st in pairs(raw) do
				if type(st) == "table" and st.imageRef then
					st.id = st.id or sId
					st.ownerUid = tostring(st.ownerUid or uidStr)
					local exp = tonumber(st.expiresAt) or ((tonumber(st.createdAt) or 0) + Z100.Config.Limits.StoryTTL)
					if exp <= nowTs then
						DB.DeleteAsync(Nodes.Stories .. "/" .. uidStr .. "/" .. st.id)
						DB.DeleteAsync(Nodes.StoryViews .. "/" .. st.id)
					elseif Z100.Backend.CanViewStory(st) then
						table.insert(active, st)
					end
				end
			end
		end

		table.sort(active, function(a, b) return (tonumber(a.createdAt) or 0) < (tonumber(b.createdAt) or 0) end)
		State.StoriesByUid[uidStr] = active
		return active
	end

	function Z100.Backend.GetStoryRingState(uid)
		local uidStr = Util.NormalizeUid(uid)
		if not uidStr then return "none" end
		local stories = State.StoriesByUid[uidStr]
		if type(stories) ~= "table" or #stories == 0 then return "none" end
		local nowTs, hasActive, hasUnseen = Util.Now(), false, false
		for _, st in ipairs(stories) do
			if (tonumber(st.expiresAt) or 0) > nowTs and Z100.Backend.CanViewStory(st) then
				hasActive = true
				if not State.SeenStoryIds[st.id] then
					hasUnseen = true
				end
			end
		end
		if not hasActive then return "none" end
		return hasUnseen and "unseen" or "seen"
	end

	function Z100.Backend.FetchStoriesFeed()
		Z100.Backend.FetchGraph(Z100.MyUid, false)
		local candidates = { [Z100.MyUid] = true }
		for fUid, val in pairs(State.Following[Z100.MyUid] or {}) do
			if val then candidates[tostring(fUid)] = true end
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			candidates[tostring(plr.UserId)] = true
		end

		local buckets = {}
		local myStories = {}
		for uId in pairs(candidates) do
			local stList = Z100.Backend.FetchUserStories(uId, true)
			if #stList > 0 then
				if uId == Z100.MyUid then myStories = stList end
				table.insert(buckets, {
					uid = uId,
					stories = stList,
					latest = tonumber(stList[#stList].createdAt) or 0,
					ring = Z100.Backend.GetStoryRingState(uId),
				})
			end
		end

		table.sort(buckets, function(a, b)
			if a.uid == Z100.MyUid then return true end
			if b.uid == Z100.MyUid then return false end
			if a.ring ~= b.ring then return a.ring == "unseen" end
			return a.latest > b.latest
		end)
		return buckets, myStories
	end

	function Z100.Backend.PublishStory(draft)
		if not Util.IsAdmin() and (os.clock() - storyPublishClock < 6) then
			return false, "Please wait a few seconds before posting another story."
		end

		local img = tostring(draft.imageRef or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if img == "" then
			return false, "Add a photo (Roblox Image Asset ID or direct image URL) first."
		end
		if not (img:match("^%d+$") or img:match("^rbxassetid://%d+$") or img:match("^rbxthumb://") or img:match("^https?://")) then
			return false, "Unsupported image format. Use a numeric Asset ID or direct image URL."
		end

		local musicData = nil
		if type(draft.music) == "table" and tostring(draft.music.videoId or "") ~= "" then
			Z100.Backend.FetchEntitlements(Z100.MyUid, true)
			if not Z100.Backend.HasMusicStudioPass(Z100.MyUid) then
				return false, "Story Music requires the ₹" .. tostring(Z100.Backend.GetMusicPassPrice()) .. " Music Studio Pro Pass."
			end
			musicData = {
				videoId = tostring(draft.music.videoId),
				title = tostring(draft.music.title or "Online Track"):sub(1, 64),
				artist = tostring(draft.music.artist or "YouTube Music"):sub(1, 44),
				duration = tonumber(draft.music.duration) or 0,
				thumbnail = tostring(draft.music.thumbnail or ""):sub(1, 220),
				startTime = math.max(0, tonumber(draft.music.startTime) or 0),
				volume = math.clamp(tonumber(draft.music.volume) or 0.7, 0, 1),
			}
		end

		local ts = Util.Now()
		local sId = "ST100_" .. Z100.MyUid .. "_" .. tostring(ts) .. "_" .. tostring(math.random(100, 999))
		local priv = tostring(draft.privacy or "Public")
		if priv ~= "Public" and priv ~= "Followers" and priv ~= "Private" then priv = "Public" end

		local myDisp = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName
		local storyObj = {
			id = sId,
			ownerUid = Z100.MyUid,
			ownerName = Z100.MyName,
			ownerDisplay = myDisp,
			imageRef = img:sub(1, 240),
			caption = tostring(draft.caption or ""):gsub("[\r\n]+", " "):sub(1, Z100.Config.Limits.StoryCaptionMax),
			overlayText = tostring(draft.overlayText or ""):gsub("[\r\n]+", " "):sub(1, Z100.Config.Limits.StoryOverlayMax),
			sticker = tostring(draft.sticker or ""):sub(1, 20),
			bgHex = tostring(draft.bgHex or "obsidian"),
			music = musicData,
			privacy = priv,
			createdAt = ts,
			expiresAt = ts + Z100.Config.Limits.StoryTTL,
			reactions = {},
		}

		local ok, errMsg = DB.Put(Nodes.Stories .. "/" .. Z100.MyUid .. "/" .. sId, storyObj)
		if not ok then return false, errMsg end

		storyPublishClock = os.clock()
		State.StoriesByUid[Z100.MyUid] = State.StoriesByUid[Z100.MyUid] or {}
		table.insert(State.StoriesByUid[Z100.MyUid], storyObj)
		return true, storyObj
	end

	function Z100.Backend.RecordStoryView(storyId)
		if not storyId or storyId == "" then return end
		State.SeenStoryIds[storyId] = true
		DB.PutAsync(Nodes.StoryViews .. "/" .. storyId .. "/" .. Z100.MyUid, {
			uid = Z100.MyUid,
			username = Z100.MyName,
			displayName = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName,
			viewedAt = Util.Now(),
		})
	end

	function Z100.Backend.FetchStoryViewers(storyId)
		local raw = DB.Get(Nodes.StoryViews .. "/" .. tostring(storyId))
		local list = {}
		if type(raw) == "table" then
			for uKey, v in pairs(raw) do
				if type(v) == "table" then
					table.insert(list, {
						uid = tostring(v.uid or uKey),
						username = tostring(v.username or "User"),
						displayName = tostring(v.displayName or v.username or "User"),
						viewedAt = tonumber(v.viewedAt) or 0,
					})
				end
			end
		end
		table.sort(list, function(a, b) return a.viewedAt > b.viewedAt end)
		return list
	end

	function Z100.Backend.ReactToStory(storyObj, emoji)
		if type(storyObj) ~= "table" or not storyObj.id then return end
		local hex = Z100.Crypto.HexEncode(emoji)
		DB.PutAsync(Nodes.Stories .. "/" .. storyObj.ownerUid .. "/" .. storyObj.id .. "/reactions/" .. hex .. "/" .. Z100.MyUid, true)
		if tostring(storyObj.ownerUid) ~= Z100.MyUid then
			local myDisp = (State.Profiles[Z100.MyUid] and State.Profiles[Z100.MyUid].displayName) or Z100.Player.DisplayName
			Z100.Backend.PushNotif(storyObj.ownerUid, "story_reaction", "🔥 Story Reaction", myDisp .. " reacted " .. emoji .. " to your story!", Z100.MyUid)
		end
	end

	function Z100.Backend.DeleteStory(ownerUid, storyId)
		local oUid = Util.NormalizeUid(ownerUid)
		if not oUid or not storyId then return false, "Invalid story." end
		if oUid ~= Z100.MyUid and not Util.IsAdmin() then
			return false, "Unauthorized: Only story owner or Admin can delete."
		end
		local ok, errMsg = DB.Delete(Nodes.Stories .. "/" .. oUid .. "/" .. storyId)
		if ok then
			DB.DeleteAsync(Nodes.StoryViews .. "/" .. storyId)
			if State.StoriesByUid[oUid] then
				for idx, st in ipairs(State.StoriesByUid[oUid]) do
					if st.id == storyId then table.remove(State.StoriesByUid[oUid], idx); break end
				end
			end
		end
		return ok, ok and "Story deleted." or errMsg
	end

	function Z100.Backend.ReportStory(storyObj, reason)
		if type(storyObj) ~= "table" or not storyObj.id then return false, "Invalid story." end
		local rId = "SREP_" .. tostring(Util.Now()) .. "_" .. tostring(math.random(1000, 9999))
		return DB.Put(Nodes.StoryReports .. "/" .. rId, {
			id = rId,
			storyId = storyObj.id,
			ownerUid = tostring(storyObj.ownerUid),
			ownerName = tostring(storyObj.ownerName or "Unknown"),
			caption = tostring(storyObj.caption or ""),
			reporterUid = Z100.MyUid,
			reporterName = Z100.MyName,
			reason = tostring(reason or "Inappropriate content"):sub(1, 200),
			timestamp = Util.Now(),
		})
	end

	function Z100.Backend.AdminFetchReportedStories()
		if not Util.IsAdmin() then return {} end
		local raw = DB.Get(Nodes.StoryReports)
		local list = {}
		if type(raw) == "table" then
			for id, rep in pairs(raw) do
				if type(rep) == "table" and rep.storyId then
					rep.id = rep.id or id
					table.insert(list, rep)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.timestamp) or 0) > (tonumber(b.timestamp) or 0) end)
		return list
	end

	function Z100.Backend.AdminResolveStoryReport(reportObj, deleteStoryBool)
		if not Util.IsAdmin() then return false, "Admin only." end
		if deleteStoryBool and reportObj.ownerUid and reportObj.storyId then
			Z100.Backend.DeleteStory(reportObj.ownerUid, reportObj.storyId)
			Z100.Backend.AdminLogAction("delete_reported_story", reportObj.ownerUid, tostring(reportObj.storyId))
		end
		if reportObj.id then
			DB.Delete(Nodes.StoryReports .. "/" .. reportObj.id)
		end
		return true, deleteStoryBool and "Story removed & report closed." or "Report dismissed."
	end

	-- ===================================================================== --
	-- [SECTION B : ONLINE YOUTUBE MUSIC API ENGINE (LIVE SEARCH + MP3 PLAY)]
	-- ===================================================================== --
	Z100.Music.ActiveSound = nil
	Z100.Music.ActiveTrack = nil
	Z100.Music.PlaySession = 0

	local function parseDurationSeconds(rawDur)
		if type(rawDur) == "number" then return math.floor(rawDur) end
		local s = tostring(rawDur or "")
		local m, sec = s:match("(%d+):(%d+)")
		if m and sec then
			return (tonumber(m) or 0) * 60 + (tonumber(sec) or 0)
		end
		return tonumber(s) or 0
	end

	-- 1. Live Online YouTube Song Search via RapidAPI
	function Z100.Music.SearchOnline(query)
		local cleanQ = tostring(query or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if cleanQ == "" then
			return false, {}, "Enter a song name or artist to search online."
		end

		if not Util.IsAdmin() and (os.clock() - State.LastMusicSearchClock < Z100.Config.Limits.SearchCooldown) then
			return false, State.MusicSearchResults, "Please wait 2s between online searches."
		end
		State.LastMusicSearchClock = os.clock()

		local apiKey = Z100.Config.MusicAPI.RapidAPIKey
		local encodedQ = Util.URLEncode(cleanQ)
		local results = {}

		-- Primary Endpoint: youtube-search-and-download.p.rapidapi.com
		local searchUrl = "https://" .. Z100.Config.MusicAPI.SearchHost .. "/search?query=" .. encodedQ .. "&type=v"
		local res = DB.RawRequest(searchUrl, "GET", nil, {
			["x-rapidapi-key"] = apiKey,
			["x-rapidapi-host"] = Z100.Config.MusicAPI.SearchHost,
		}, 16)

		if res.StatusCode == 200 and res.Body ~= "" then
			local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
			if ok and type(data) == "table" then
				local items = data.contents or data.items or data.videos or data.results or data
				if type(items) == "table" then
					for _, entry in ipairs(items) do
						local v = (type(entry) == "table" and entry.video) or entry
						if type(v) == "table" then
							local vid = tostring(v.videoId or v.id or "")
							if vid ~= "" and #vid >= 6 then
								local thumb = ""
								if type(v.thumbnails) == "table" and v.thumbnails[1] and v.thumbnails[1].url then
									thumb = tostring(v.thumbnails[1].url)
								elseif type(v.thumbnail) == "string" then
									thumb = v.thumbnail
								else
									thumb = "https://i.ytimg.com/vi/" .. vid .. "/hqdefault.jpg"
								end
								table.insert(results, {
									videoId = vid,
									title = tostring(v.title or "Untitled Song"):sub(1, 68),
									artist = tostring(v.channelName or v.author or v.artist or "YouTube"):sub(1, 44),
									duration = parseDurationSeconds(v.lengthText or v.duration or 0),
									thumbnail = thumb,
									mp3Url = tostring(v.link or v.mp3 or ""),
								})
								if #results >= Z100.Config.MusicAPI.MaxResults then break end
							end
						end
					end
				end
			end
		end

		-- Secondary Endpoint Fallback: yt-search-and-download-mp3.p.rapidapi.com
		if #results == 0 then
			local altUrl = "https://" .. Z100.Config.MusicAPI.AltMp3Host .. "/search?q=" .. encodedQ
			local res2 = DB.RawRequest(altUrl, "GET", nil, {
				["x-rapidapi-key"] = apiKey,
				["x-rapidapi-host"] = Z100.Config.MusicAPI.AltMp3Host,
			}, 16)
			if res2.StatusCode == 200 and res2.Body ~= "" then
				local ok2, data2 = pcall(function() return HttpService:JSONDecode(res2.Body) end)
				if ok2 and type(data2) == "table" then
					local items = data2.items or data2.results or data2.data or data2
					if type(items) == "table" then
						for _, v in ipairs(items) do
							if type(v) == "table" then
								local vid = tostring(v.videoId or v.id or "")
								if vid ~= "" then
									table.insert(results, {
										videoId = vid,
										title = tostring(v.title or "Untitled Song"):sub(1, 68),
										artist = tostring(v.author or v.channel or v.artist or "YouTube"):sub(1, 44),
										duration = parseDurationSeconds(v.duration or 0),
										thumbnail = tostring(v.thumbnail or ("https://i.ytimg.com/vi/" .. vid .. "/hqdefault.jpg")),
										mp3Url = tostring(v.link or v.downloadUrl or ""),
									})
									if #results >= Z100.Config.MusicAPI.MaxResults then break end
								end
							end
						end
					end
				end
			end
		end

		if #results == 0 then
			return false, {}, "No online songs found (HTTP " .. tostring(res.StatusCode) .. "). Try a different song title or check RapidAPI quota."
		end

		State.MusicSearchResults = results
		return true, results, nil
	end

	-- 2. Resolve Direct MP3 Download Link for a YouTube videoId
	function Z100.Music.ResolveMP3Link(videoId)
		local vid = tostring(videoId or ""):gsub("[^%w_%-]", "")
		if vid == "" then
			return false, nil, "Missing YouTube videoId."
		end

		local apiKey = Z100.Config.MusicAPI.RapidAPIKey

		-- Try Primary MP3 Converter Host (youtube-mp36.p.rapidapi.com)
		local url1 = "https://" .. Z100.Config.MusicAPI.Mp3Host .. "/dl?id=" .. vid
		local res1 = DB.RawRequest(url1, "GET", nil, {
			["x-rapidapi-key"] = apiKey,
			["x-rapidapi-host"] = Z100.Config.MusicAPI.Mp3Host,
		}, 18)

		if res1.StatusCode == 200 and res1.Body ~= "" then
			local ok, d = pcall(function() return HttpService:JSONDecode(res1.Body) end)
			if ok and type(d) == "table" and type(d.link) == "string" and d.link:match("^https?://") then
				return true, {
					link = d.link,
					title = tostring(d.title or ""),
					duration = tonumber(d.duration) or 0,
					filesize = tonumber(d.filesize) or 0,
				}, nil
			end
		end

		-- Try Alternate MP3 Endpoint (yt-search-and-download-mp3.p.rapidapi.com)
		local url2 = "https://" .. Z100.Config.MusicAPI.AltMp3Host .. "/mp3?id=" .. vid
		local res2 = DB.RawRequest(url2, "GET", nil, {
			["x-rapidapi-key"] = apiKey,
			["x-rapidapi-host"] = Z100.Config.MusicAPI.AltMp3Host,
		}, 18)

		if res2.StatusCode == 200 and res2.Body ~= "" then
			local ok2, d2 = pcall(function() return HttpService:JSONDecode(res2.Body) end)
			if ok2 and type(d2) == "table" then
				local link = tostring(d2.link or d2.downloadUrl or d2.url or "")
				if link:match("^https?://") then
					return true, {
						link = link,
						title = tostring(d2.title or ""),
						duration = tonumber(d2.duration) or 0,
						filesize = tonumber(d2.filesize) or 0,
					}, nil
				end
			end
		end

		return false, nil, "Could not resolve MP3 stream from RapidAPI (HTTP " .. tostring(res1.StatusCode) .. ")."
	end

	-- 3. Universal Executor MP3 Playback Engine (SoundService + getcustomasset)
	function Z100.Music.StopAudio(soundName)
		Z100.Music.PlaySession = Z100.Music.PlaySession + 1
		local targets = soundName and { soundName } or { "ZaynV100_MusicAudio", "ZaynV100_StoryAudio" }
		for _, sName in ipairs(targets) do
			pcall(function()
				local existing = SoundService:FindFirstChild(sName)
				if existing then
					existing:Stop()
					existing:Destroy()
				end
			end)
		end
		if not soundName or soundName == "ZaynV100_MusicAudio" then
			Z100.Music.ActiveSound = nil
			Z100.Music.ActiveTrack = nil
		end
	end

	function Z100.Music.PlayOnlineTrack(trackObj, soundName, onStateChange)
		local sName = soundName or "ZaynV100_MusicAudio"
		Z100.Music.StopAudio()

		if State.Prefs.MuteAllAudio then
			if type(onStateChange) == "function" then
				onStateChange("muted", "Audio is muted in Settings.")
			end
			return
		end

		if type(trackObj) ~= "table" or tostring(trackObj.videoId or "") == "" then
			if type(onStateChange) == "function" then
				onStateChange("error", "Invalid online track.")
			end
			return
		end

		local mySession = Z100.Music.PlaySession
		if type(onStateChange) == "function" then
			onStateChange("loading", "Fetching online MP3 stream...")
		end

		task.spawn(function()
			local mp3Link = tostring(trackObj.mp3Url or "")
			if not mp3Link:match("^https?://") then
				local okRes, meta, errRes = Z100.Music.ResolveMP3Link(trackObj.videoId)
				if Z100.Music.PlaySession ~= mySession then return end
				if not okRes or not meta then
					if type(onStateChange) == "function" then
						onStateChange("error", tostring(errRes or "MP3 link unavailable"))
					end
					return
				end
				mp3Link = meta.link
				trackObj.mp3Url = mp3Link
				if meta.duration and meta.duration > 0 then
					trackObj.duration = meta.duration
				end
			end

			if type(onStateChange) == "function" then
				onStateChange("loading", "Caching MP3 for executor playback...")
			end

			local okAsset, assetUrl, errAsset = Util.DownloadAudioToAsset(mp3Link, trackObj.videoId)
			if Z100.Music.PlaySession ~= mySession then return end

			if not okAsset or not assetUrl then
				if type(onStateChange) == "function" then
					onStateChange("error", tostring(errAsset or "Audio cache failed"))
				end
				return
			end

			local snd = Instance.new("Sound")
			snd.Name = sName
			snd.SoundId = assetUrl
			local baseVol = tonumber(trackObj.volume) or tonumber(State.Prefs.MusicVolume) or 0.7
			snd.Volume = math.clamp(baseVol, 0, 1)
			snd.Looped = true
			snd.Parent = SoundService

			if sName == "ZaynV100_MusicAudio" then
				Z100.Music.ActiveSound = snd
				Z100.Music.ActiveTrack = trackObj
			end

			local t0 = os.clock()
			while snd and snd.Parent and Z100.Music.PlaySession == mySession and os.clock() - t0 < 4.0 do
				if snd.IsLoaded or snd.TimeLength > 0 then break end
				task.wait(0.1)
			end
			if Z100.Music.PlaySession ~= mySession or not snd or not snd.Parent then return end

			local stPos = math.max(0, tonumber(trackObj.startTime) or 0)
			if snd.TimeLength > 0 and stPos >= snd.TimeLength then stPos = 0 end
			pcall(function()
				snd.TimePosition = stPos
				snd:Play()
			end)

			if type(onStateChange) == "function" then
				onStateChange("playing", snd.TimeLength > 0 and snd.TimeLength or (tonumber(trackObj.duration) or 0))
			end
		end)
	end

	-- 4. Cloud "My Music Library" (Strictly Gated Behind ₹1500 Music Studio Pass)
	function Z100.Backend.FetchMyMusicLibrary(forceRefresh)
		if not forceRefresh and #State.MusicLibrary > 0 then
			return State.MusicLibrary
		end
		local raw = DB.Get(Nodes.MusicLib .. "/" .. Z100.MyUid)
		local list = {}
		if type(raw) == "table" then
			for tId, tr in pairs(raw) do
				if type(tr) == "table" and tr.videoId then
					tr.id = tr.id or tId
					table.insert(list, tr)
				end
			end
		end
		table.sort(list, function(a, b) return (tonumber(a.savedAt) or 0) > (tonumber(b.savedAt) or 0) end)
		State.MusicLibrary = list
		return list
	end

	function Z100.Backend.SaveTrackToLibrary(trackObj, startTime, volume)
		Z100.Backend.FetchEntitlements(Z100.MyUid, true)
		if not Z100.Backend.HasMusicStudioPass(Z100.MyUid) then
			return false, "Music Studio Pro requires the ₹" .. tostring(Z100.Backend.GetMusicPassPrice()) .. " Paid Pass."
		end
		if type(trackObj) ~= "table" or tostring(trackObj.videoId or "") == "" then
			return false, "Invalid song selection."
		end

		local tId = "TRK_" .. tostring(Util.Now()) .. "_" .. tostring(math.random(100, 999))
		local record = {
			id = tId,
			videoId = tostring(trackObj.videoId),
			title = tostring(trackObj.title or "Online Song"):sub(1, 68),
			artist = tostring(trackObj.artist or "YouTube"):sub(1, 44),
			duration = tonumber(trackObj.duration) or 0,
			thumbnail = tostring(trackObj.thumbnail or ""):sub(1, 220),
			startTime = math.max(0, tonumber(startTime) or tonumber(trackObj.startTime) or 0),
			volume = math.clamp(tonumber(volume) or tonumber(trackObj.volume) or 0.7, 0, 1),
			savedAt = Util.Now(),
		}

		local ok, err = DB.Put(Nodes.MusicLib .. "/" .. Z100.MyUid .. "/" .. tId, record)
		if not ok then return false, err end

		table.insert(State.MusicLibrary, 1, record)
		return true, record
	end

	function Z100.Backend.RemoveTrackFromLibrary(trackId)
		if not trackId then return false, "Invalid track." end
		local ok, err = DB.Delete(Nodes.MusicLib .. "/" .. Z100.MyUid .. "/" .. tostring(trackId))
		if ok then
			for idx, tr in ipairs(State.MusicLibrary) do
				if tr.id == trackId then table.remove(State.MusicLibrary, idx); break end
			end
		end
		return ok, ok and "Removed from My Music." or err
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 7 / 15 : RESPONSIVE MASTER SHELL, SIDEBAR, MOBILE NAV & THEME SYNC
-- ========================================================================= --

do
	local TweenService = Z100.Services.Tween
	local UserInputService = Z100.Services.UIS
	local Lighting = Z100.Services.Lighting
	local C = Z100.Components
	local State = Z100.State

	Z100.UI.NavButtons = {
		Side = {},
		Bottom = {},
	}
	Z100.UI.BadgeLabels = {}

	-- ===================================================================== --
	-- [SECTION A : BADGE UPDATER & ACTIVE NAV HIGHLIGHT]
	-- ===================================================================== --
	function Z100.UI.UpdateBadges()
		local notifCount = (State.UnreadNotifs or 0) + Z100.Util.CountKeys(State.Requests)
		local dmUnread = 0
		if Z100.Chat.GetTotalUnreadDMs then
			dmUnread = Z100.Chat.GetTotalUnreadDMs()
		end

		for _, entry in ipairs(Z100.UI.BadgeLabels) do
			if entry.Label and entry.Label.Parent then
				local cnt = 0
				if entry.Id == "Notifications" then
					cnt = notifCount
				elseif entry.Id == "Messages" then
					cnt = dmUnread
				end
				if cnt > 0 then
					entry.Label.Visible = true
					entry.Label.Text = cnt > 9 and "9+" or tostring(cnt)
				else
					entry.Label.Visible = false
				end
			end
		end
	end

	function Z100.UI.UpdateNavActive(screenId)
		local p = Z100.Theme.Get()
		local activeId = screenId or State.ActiveScreen or "Home"
		if activeId == "ProfileEditor" then activeId = "Profile" end
		if activeId == "StoryEditor" then activeId = "Stories" end

		for id, btn in pairs(Z100.UI.NavButtons.Side) do
			if btn and btn.Parent then
				local isAct = (id == activeId)
				local accentCol = (id == "PremiumStore") and p.Gold or p.Accent
				local bar = btn:FindFirstChild("ActiveBar")
				local ico = btn:FindFirstChild("Ico")
				local lbl = btn:FindFirstChild("Lbl")

				Z100.Theme.Tween(btn, Z100.Theme.Tokens.Timing.Fast, {
					BackgroundColor3 = isAct and p.CardHover or p.Surface,
					BackgroundTransparency = isAct and 0 or 1,
				})
				if bar then
					bar.Visible = isAct
					bar.BackgroundColor3 = accentCol
				end
				if ico then
					ico.TextColor3 = isAct and accentCol or p.TextSecondary
				end
				if lbl then
					lbl.TextColor3 = isAct and p.TextPrimary or p.TextSecondary
				end
			end
		end

		for id, btn in pairs(Z100.UI.NavButtons.Bottom) do
			if btn and btn.Parent then
				local isAct = (id == activeId)
				local accentCol = (id == "PremiumStore") and p.Gold or p.Accent
				local bar = btn:FindFirstChild("ActiveBar")
				local ico = btn:FindFirstChild("Ico")
				local lbl = btn:FindFirstChild("Lbl")

				Z100.Theme.Tween(btn, Z100.Theme.Tokens.Timing.Fast, {
					BackgroundColor3 = isAct and p.CardHover or p.Surface,
					BackgroundTransparency = isAct and 0.15 or 1,
				})
				if bar then
					bar.Visible = isAct
					bar.BackgroundColor3 = accentCol
				end
				if ico then
					ico.TextColor3 = isAct and accentCol or p.TextSecondary
				end
				if lbl then
					lbl.TextColor3 = isAct and accentCol or p.TextMuted
				end
			end
		end
	end

	-- ===================================================================== --
	-- [SECTION B : LIVE SHELL THEME SYNC (STANDARD <-> ROYAL GOLD PREMIUM)]
	-- ===================================================================== --
	function Z100.UI.ApplyDesignTheme()
		local p = Z100.Theme.Get()
		local tw = Z100.Theme.Tokens.Timing.Smooth

		if Z100.UI.MainFrame then
			Z100.Theme.Tween(Z100.UI.MainFrame, tw, { BackgroundColor3 = p.BgRoot })
		end
		if Z100.UI.MainGrad then
			Z100.UI.MainGrad.Color = ColorSequence.new(p.BgGradA, p.BgGradB)
		end
		if Z100.UI.MainStroke then
			Z100.Theme.Tween(Z100.UI.MainStroke, tw, { Color = p.BorderGlow })
		end
		if Z100.UI.Header then
			Z100.Theme.Tween(Z100.UI.Header, tw, { BackgroundColor3 = p.Surface })
		end
		if Z100.UI.Sidebar then
			Z100.Theme.Tween(Z100.UI.Sidebar, tw, { BackgroundColor3 = p.Surface })
		end
		if Z100.UI.BottomNav then
			Z100.Theme.Tween(Z100.UI.BottomNav, tw, { BackgroundColor3 = p.Surface })
		end
		if Z100.UI.ToggleStroke then
			Z100.Theme.Tween(Z100.UI.ToggleStroke, tw, { Color = p.BorderGlow })
		end

		Z100.UI.UpdateNavActive(State.ActiveScreen)
	end

	-- ===================================================================== --
	-- [SECTION C : BUILD MASTER RESPONSIVE SHELL]
	-- ===================================================================== --
	function Z100.UI.BuildMasterShell()
		local p = Z100.Theme.Get()

		-- 1. Root ScreenGui
		local gui = Instance.new("ScreenGui")
		gui.Name = Z100.Util.RandomGuiName()
		gui.ResetOnSpawn = false
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		gui.IgnoreGuiInset = true

		local okParent = pcall(function() gui.Parent = Z100.Exec.GetGuiRoot() end)
		if not okParent or not gui.Parent then
			gui.Parent = Z100.Player:WaitForChild("PlayerGui", 10)
		end
		Z100.UI.ScreenGui = gui

		Z100.Util.TrackConn(gui.Destroying:Connect(function()
			if Lighting:FindFirstChild("ZaynV100_Blur") then
				Lighting.ZaynV100_Blur:Destroy()
			end
			local env = (type(getgenv) == "function" and getgenv()) or _G
			if type(env) == "table" and type(env.ZaynV100_Cleanup) == "function" then
				pcall(env.ZaynV100_Cleanup)
			end
		end))

		-- 2. Toast Notification Stack (Top-Right / Bottom-Right safe)
		local toastWrap = Instance.new("Frame", gui)
		toastWrap.Name = "ZaynV100_ToastContainer"
		toastWrap.Size = UDim2.new(0, 300, 0.72, 0)
		toastWrap.AnchorPoint = Vector2.new(1, 1)
		toastWrap.Position = UDim2.new(1, -14, 1, -14)
		toastWrap.BackgroundTransparency = 1
		toastWrap.ZIndex = 2000
		local tLay = Instance.new("UIListLayout", toastWrap)
		tLay.Padding = UDim.new(0, 8)
		tLay.VerticalAlignment = Enum.VerticalAlignment.Bottom
		tLay.HorizontalAlignment = Enum.HorizontalAlignment.Right
		tLay.SortOrder = Enum.SortOrder.LayoutOrder
		Z100.UI.ToastContainer = toastWrap

		-- 3. Floating Draggable Toggle Button
		local toggleBtn = Instance.new("ImageButton", gui)
		toggleBtn.Name = "ZaynV100_ToggleBtn"
		toggleBtn.Size = UDim2.new(0, 50, 0, 50)
		toggleBtn.Position = UDim2.new(0, 16, 0.44, -25)
		toggleBtn.BackgroundColor3 = p.Surface
		toggleBtn.Image = "rbxthumb://type=Asset&id=88879794421294&w=150&h=150"
		toggleBtn.ScaleType = Enum.ScaleType.Crop
		toggleBtn.Active = true
		toggleBtn.Draggable = true
		toggleBtn.ZIndex = 1800
		C.Corner(toggleBtn, Z100.Theme.Tokens.Radius.Pill)
		local tSt = C.Stroke(toggleBtn, p.BorderGlow, 2.0, 0)
		C.AttachButtonFeedback(toggleBtn, 1.08)
		Z100.UI.ToggleBtn = toggleBtn
		Z100.UI.ToggleStroke = tSt

		-- 4. Main Responsive Window (Standard Frame — 100% Mobile/Delta/Codex Safe)
		local dev, winW, winH = Z100.UI.ComputeWindowBounds()

		local main = Instance.new("Frame", gui)
		main.Name = "ZaynV100_MainWindow"
		main.Size = UDim2.new(0, winW, 0, winH)
		main.AnchorPoint = Vector2.new(0.5, 0.5)
		main.Position = UDim2.new(0.5, 0, 0.5, 0)
		main.BackgroundColor3 = p.BgRoot
		main.BorderSizePixel = 0
		main.ClipsDescendants = true
		main.Visible = true
		main.Active = true
		main.ZIndex = 10
		C.Corner(main, Z100.Theme.Tokens.Radius.LG)

		local mainScale = Instance.new("UIScale", main)
		mainScale.Name = "MainWinScale"
		mainScale.Scale = 1.0

		local mGrad = Instance.new("UIGradient", main)
		mGrad.Rotation = 135
		mGrad.Color = ColorSequence.new(p.BgGradA, p.BgGradB)
		local mStroke = C.Stroke(main, p.BorderGlow, 1.8, 0.15)

		Z100.UI.MainFrame = main
		Z100.UI.MainGrad = mGrad
		Z100.UI.MainStroke = mStroke

		-- Smooth Open / Close Toggle (UIScale — Zero Black Screen Bug)
		local toggling = false
		toggleBtn.MouseButton1Click:Connect(function()
			if toggling then return end
			toggling = true
			if main.Visible then
				Z100.Theme.Tween(mainScale, Z100.Theme.Tokens.Timing.Fast, { Scale = 0.88 })
				task.delay(0.15, function()
					main.Visible = false
					mainScale.Scale = 1.0
					toggling = false
				end)
			else
				mainScale.Scale = 0.88
				main.Visible = true
				Z100.Theme.Tween(mainScale, Z100.Theme.Tokens.Timing.Pop, { Scale = 1.0 })
				task.delay(0.24, function() toggling = false end)
			end
		end)
		-- 5. Dedicated Modal Overlay Layer (Inside Main Window)
		local modalLayer = Instance.new("Frame", main)
		modalLayer.Name = "ZaynV100_ModalLayer"
		modalLayer.Size = UDim2.new(1, 0, 1, 0)
		modalLayer.BackgroundTransparency = 1
		modalLayer.ZIndex = 290
		Z100.UI.ModalLayer = modalLayer

		-- 6. Top Header Bar (Draggable on PC & Mobile)
		local HEADER_H = 44
		local header = Instance.new("Frame", main)
		header.Name = "TopHeader"
		header.Size = UDim2.new(1, 0, 0, HEADER_H)
		header.BackgroundColor3 = p.Surface
		header.BorderSizePixel = 0
		header.ZIndex = 50
		Z100.UI.Header = header

		local hDivider = Instance.new("Frame", header)
		hDivider.Size = UDim2.new(1, 0, 0, 1)
		hDivider.Position = UDim2.new(0, 0, 1, -1)
		hDivider.BackgroundColor3 = p.Border
		hDivider.BackgroundTransparency = 0.45
		hDivider.BorderSizePixel = 0
		hDivider.ZIndex = 51

		-- Smooth Header Dragging
		do
			local dragging, startPos, origPos = false, nil, nil
			header.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					startPos = inp.Position
					origPos = main.Position
					inp.Changed:Connect(function()
						if inp.UserInputState == Enum.UserInputState.End then dragging = false end
					end)
				end
			end)
			Z100.Util.TrackConn(UserInputService.InputChanged:Connect(function(inp)
				if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
					local d = inp.Position - startPos
					main.Position = UDim2.new(origPos.X.Scale, origPos.X.Offset + d.X, origPos.Y.Scale, origPos.Y.Offset + d.Y)
				end
			end))
		end

		local backBtn = Instance.new("TextButton", header)
		backBtn.Name = "BackBtn"
		backBtn.Size = UDim2.new(0, 30, 0, 28)
		backBtn.Position = UDim2.new(0, 10, 0.5, -14)
		backBtn.BackgroundColor3 = p.Card
		backBtn.Font = Z100.Theme.Tokens.Fonts.Heading
		backBtn.TextSize = 14
		backBtn.TextColor3 = p.Accent
		backBtn.Text = "‹"
		backBtn.Visible = false
		backBtn.ZIndex = 52
		C.Corner(backBtn, Z100.Theme.Tokens.Radius.SM)
		C.AttachButtonFeedback(backBtn, 1.08)
		backBtn.MouseButton1Click:Connect(function()
			if Z100.Router.GoBack then Z100.Router.GoBack() end
		end)
		Z100.UI.BackBtn = backBtn

		local titleLbl = Instance.new("TextLabel", header)
		titleLbl.Name = "HeaderTitle"
		titleLbl.Size = UDim2.new(0, 260, 0, 22)
		titleLbl.Position = UDim2.new(0, 14, 0, 5)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Font = Z100.Theme.Tokens.Fonts.Heading
		titleLbl.TextSize = 14
		titleLbl.TextColor3 = p.TextPrimary
		titleLbl.TextXAlignment = Enum.TextXAlignment.Left
		titleLbl.ClipsDescendants = true
		titleLbl.Text = "ZAYN SOCIAL V100"
		titleLbl.ZIndex = 52
		Z100.UI.HeaderTitle = titleLbl

		local subLbl = Instance.new("TextLabel", header)
		subLbl.Name = "HeaderSub"
		subLbl.Size = UDim2.new(0, 260, 0, 13)
		subLbl.Position = UDim2.new(0, 14, 0, 26)
		subLbl.BackgroundTransparency = 1
		subLbl.Font = Z100.Theme.Tokens.Fonts.Body
		subLbl.TextSize = 9.5
		subLbl.TextColor3 = p.TextSecondary
		subLbl.TextXAlignment = Enum.TextXAlignment.Left
		subLbl.ClipsDescendants = true
		subLbl.Text = "TITANGUARD ULTIMATE"
		subLbl.ZIndex = 52
		Z100.UI.HeaderSub = subLbl

		-- Header Right Quick Buttons (Admin Shield if owner, Minimize)
		local rightRow = Instance.new("Frame", header)
		rightRow.Size = UDim2.new(0, 120, 1, 0)
		rightRow.Position = UDim2.new(1, -130, 0, 0)
		rightRow.BackgroundTransparency = 1
		rightRow.ZIndex = 52
		C.ListLayout(rightRow, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)

		if Z100.Util.IsAdmin() then
			local admBtn = Instance.new("TextButton", rightRow)
			admBtn.Size = UDim2.new(0, 30, 0, 28)
			admBtn.BackgroundColor3 = Color3.fromRGB(48, 18, 30)
			admBtn.Font = Z100.Theme.Tokens.Fonts.Heading
			admBtn.TextSize = 13
			admBtn.TextColor3 = Color3.fromRGB(255, 110, 140)
			admBtn.Text = "🛡️"
			admBtn.LayoutOrder = 1
			admBtn.ZIndex = 53
			C.Corner(admBtn, Z100.Theme.Tokens.Radius.SM)
			C.Stroke(admBtn, Color3.fromRGB(220, 52, 88), 1, 0.3)
			C.AttachButtonFeedback(admBtn, 1.08)
			admBtn.MouseButton1Click:Connect(function()
				if Z100.Router.Navigate then Z100.Router.Navigate("Admin") end
			end)
		end

		local minBtn = Instance.new("TextButton", rightRow)
		minBtn.Size = UDim2.new(0, 30, 0, 28)
		minBtn.BackgroundColor3 = p.Card
		minBtn.Font = Z100.Theme.Tokens.Fonts.Heading
		minBtn.TextSize = 13
		minBtn.TextColor3 = p.TextSecondary
		minBtn.Text = "—"
		minBtn.LayoutOrder = 2
		minBtn.ZIndex = 53
		C.Corner(minBtn, Z100.Theme.Tokens.Radius.SM)
		C.AttachButtonFeedback(minBtn, 1.08)
		minBtn.MouseButton1Click:Connect(function()
			main.Visible = false
		end)

		-- 7. Desktop / Tablet Left Sidebar
		local sidebar = Instance.new("Frame", main)
		sidebar.Name = "LeftSidebar"
		sidebar.Size = UDim2.new(0, 176, 1, -HEADER_H)
		sidebar.Position = UDim2.new(0, 0, 0, HEADER_H)
		sidebar.BackgroundColor3 = p.Surface
		sidebar.BorderSizePixel = 0
		sidebar.ZIndex = 40
		Z100.UI.Sidebar = sidebar

		local sDiv = Instance.new("Frame", sidebar)
		sDiv.Size = UDim2.new(0, 1, 1, 0)
		sDiv.Position = UDim2.new(1, -1, 0, 0)
		sDiv.BackgroundColor3 = p.Border
		sDiv.BackgroundTransparency = 0.45
		sDiv.BorderSizePixel = 0
		sDiv.ZIndex = 41

		local sideList = Instance.new("ScrollingFrame", sidebar)
		sideList.Size = UDim2.new(1, -10, 1, -14)
		sideList.Position = UDim2.new(0, 5, 0, 7)
		sideList.BackgroundTransparency = 1
		sideList.ScrollBarThickness = 0
		sideList.ZIndex = 41
		local sLay = C.ListLayout(sideList, 4)
		C.AttachAutoCanvas(sideList, sLay, 12)

		for idx, item in ipairs(Z100.Const.NavItems) do
			local b = Instance.new("TextButton", sideList)
			b.Name = "SideNav_" .. item.Id
			b.Size = UDim2.new(1, -2, 0, 38)
			b.BackgroundColor3 = p.Surface
			b.BackgroundTransparency = 1
			b.AutoButtonColor = false
			b.Text = ""
			b.LayoutOrder = idx
			b.ZIndex = 42
			C.Corner(b, Z100.Theme.Tokens.Radius.SM)
			C.AttachButtonFeedback(b, 1.02)

			local bar = Instance.new("Frame", b)
			bar.Name = "ActiveBar"
			bar.Size = UDim2.new(0, 3, 0.56, 0)
			bar.Position = UDim2.new(0, 2, 0.22, 0)
			bar.BackgroundColor3 = p.Accent
			bar.BorderSizePixel = 0
			bar.Visible = (item.Id == "Home")
			bar.ZIndex = 43
			C.Corner(bar, Z100.Theme.Tokens.Radius.Pill)

			local ico = Instance.new("TextLabel", b)
			ico.Name = "Ico"
			ico.Size = UDim2.new(0, 34, 1, 0)
			ico.Position = UDim2.new(0, 8, 0, 0)
			ico.BackgroundTransparency = 1
			ico.Font = Z100.Theme.Tokens.Fonts.Heading
			ico.TextSize = 15
			ico.TextColor3 = p.TextSecondary
			ico.Text = item.Icon
			ico.ZIndex = 43

			local lbl = Instance.new("TextLabel", b)
			lbl.Name = "Lbl"
			lbl.Size = UDim2.new(1, -54, 1, 0)
			lbl.Position = UDim2.new(0, 44, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Font = Z100.Theme.Tokens.Fonts.Title
			lbl.TextSize = 11.5
			lbl.TextColor3 = p.TextSecondary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Text = item.Label
			lbl.ZIndex = 43

			if item.Id == "Notifications" or item.Id == "Messages" then
				local badge = Instance.new("TextLabel", b)
				badge.Name = "CountBadge"
				badge.Size = UDim2.new(0, 20, 0, 16)
				badge.Position = UDim2.new(1, -26, 0.5, -8)
				badge.BackgroundColor3 = p.Danger
				badge.Font = Z100.Theme.Tokens.Fonts.Heading
				badge.TextSize = 9
				badge.TextColor3 = Color3.fromRGB(255, 255, 255)
				badge.Text = "0"
				badge.Visible = false
				badge.ZIndex = 44
				C.Corner(badge, Z100.Theme.Tokens.Radius.Pill)
				table.insert(Z100.UI.BadgeLabels, { Id = item.Id, Label = badge })
			end

			b.MouseButton1Click:Connect(function()
				if item.Id == "Profile" then
					Z100.Router.OpenProfile(Z100.MyUid)
				elseif Z100.Router.Navigate then
					Z100.Router.Navigate(item.Id)
				end
			end)
			Z100.UI.NavButtons.Side[item.Id] = b
		end

		-- 8. Mobile Compact Bottom Navigation Bar (Horizontally Scrollable for All 8 Items)
		local BOTTOM_H = 54
		local bottomNav = Instance.new("Frame", main)
		bottomNav.Name = "MobileBottomNav"
		bottomNav.Size = UDim2.new(1, 0, 0, BOTTOM_H)
		bottomNav.Position = UDim2.new(0, 0, 1, -BOTTOM_H)
		bottomNav.BackgroundColor3 = p.Surface
		bottomNav.BorderSizePixel = 0
		bottomNav.Visible = false
		bottomNav.ZIndex = 45
		Z100.UI.BottomNav = bottomNav

		local bDiv = Instance.new("Frame", bottomNav)
		bDiv.Size = UDim2.new(1, 0, 0, 1)
		bDiv.BackgroundColor3 = p.Border
		bDiv.BackgroundTransparency = 0.45
		bDiv.BorderSizePixel = 0
		bDiv.ZIndex = 46

		local botScroll = Instance.new("ScrollingFrame", bottomNav)
		botScroll.Size = UDim2.new(1, -8, 1, -4)
		botScroll.Position = UDim2.new(0, 4, 0, 3)
		botScroll.BackgroundTransparency = 1
		botScroll.ScrollBarThickness = 0
		botScroll.ScrollingDirection = Enum.ScrollingDirection.X
		botScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
		botScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		botScroll.ZIndex = 46

		C.ListLayout(botScroll, 4, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

		for idx, item in ipairs(Z100.Const.NavItems) do
			local b = Instance.new("TextButton", botScroll)
			b.Name = "BotNav_" .. item.Id
			b.Size = UDim2.new(0, 58, 0, 44)
			b.BackgroundColor3 = p.Surface
			b.BackgroundTransparency = 1
			b.AutoButtonColor = false
			b.Text = ""
			b.LayoutOrder = idx
			b.ZIndex = 47
			C.Corner(b, Z100.Theme.Tokens.Radius.SM)
			C.AttachButtonFeedback(b, 1.05)

			local bar = Instance.new("Frame", b)
			bar.Name = "ActiveBar"
			bar.Size = UDim2.new(0.55, 0, 0, 2)
			bar.Position = UDim2.new(0.225, 0, 0, 1)
			bar.BackgroundColor3 = p.Accent
			bar.BorderSizePixel = 0
			bar.Visible = (item.Id == "Home")
			bar.ZIndex = 48
			C.Corner(bar, Z100.Theme.Tokens.Radius.Pill)

			local ico = Instance.new("TextLabel", b)
			ico.Name = "Ico"
			ico.Size = UDim2.new(1, 0, 0, 22)
			ico.Position = UDim2.new(0, 0, 0, 4)
			ico.BackgroundTransparency = 1
			ico.Font = Z100.Theme.Tokens.Fonts.Heading
			ico.TextSize = 15
			ico.TextColor3 = p.TextSecondary
			ico.Text = item.Icon
			ico.ZIndex = 48

			local lbl = Instance.new("TextLabel", b)
			lbl.Name = "Lbl"
			lbl.Size = UDim2.new(1, 0, 0, 12)
			lbl.Position = UDim2.new(0, 0, 0, 27)
			lbl.BackgroundTransparency = 1
			lbl.Font = Z100.Theme.Tokens.Fonts.Title
			lbl.TextSize = 9
			lbl.TextColor3 = p.TextMuted
			lbl.Text = item.Label
			lbl.ZIndex = 48

			if item.Id == "Notifications" or item.Id == "Messages" then
				local badge = Instance.new("TextLabel", b)
				badge.Name = "CountBadge"
				badge.Size = UDim2.new(0, 16, 0, 14)
				badge.Position = UDim2.new(1, -18, 0, 2)
				badge.BackgroundColor3 = p.Danger
				badge.Font = Z100.Theme.Tokens.Fonts.Heading
				badge.TextSize = 8
				badge.TextColor3 = Color3.fromRGB(255, 255, 255)
				badge.Text = "0"
				badge.Visible = false
				badge.ZIndex = 49
				C.Corner(badge, Z100.Theme.Tokens.Radius.Pill)
				table.insert(Z100.UI.BadgeLabels, { Id = item.Id, Label = badge })
			end

			b.MouseButton1Click:Connect(function()
				if item.Id == "Profile" then
					Z100.Router.OpenProfile(Z100.MyUid)
				elseif Z100.Router.Navigate then
					Z100.Router.Navigate(item.Id)
				end
			end)
			Z100.UI.NavButtons.Bottom[item.Id] = b
		end

		-- 9. Primary Screen Content Host
		local contentHost = Instance.new("Frame", main)
		contentHost.Name = "ContentHost"
		contentHost.BackgroundTransparency = 1
		contentHost.ClipsDescendants = true
		contentHost.ZIndex = 20
		Z100.UI.ContentHost = contentHost

		-- 10. Responsive Layout Adapter (Desktop / Tablet / Mobile)
		local function applyResponsiveLayout(deviceClass, w, h)
			main.Size = UDim2.new(0, w, 0, h)
			if deviceClass == "Mobile" then
				sidebar.Visible = false
				bottomNav.Visible = true
				contentHost.Position = UDim2.new(0, 0, 0, HEADER_H)
				contentHost.Size = UDim2.new(1, 0, 1, -(HEADER_H + BOTTOM_H))
				toastWrap.Size = UDim2.new(0, 255, 0.55, 0)
			elseif deviceClass == "Tablet" then
				sidebar.Visible = true
				bottomNav.Visible = false
				sidebar.Size = UDim2.new(0, 62, 1, -HEADER_H)
				contentHost.Position = UDim2.new(0, 62, 0, HEADER_H)
				contentHost.Size = UDim2.new(1, -62, 1, -HEADER_H)
				for _, btn in pairs(Z100.UI.NavButtons.Side) do
					local l = btn:FindFirstChild("Lbl")
					if l then l.Visible = false end
				end
				toastWrap.Size = UDim2.new(0, 290, 0.65, 0)
			else
				sidebar.Visible = true
				bottomNav.Visible = false
				sidebar.Size = UDim2.new(0, 176, 1, -HEADER_H)
				contentHost.Position = UDim2.new(0, 176, 0, HEADER_H)
				contentHost.Size = UDim2.new(1, -176, 1, -HEADER_H)
				for _, btn in pairs(Z100.UI.NavButtons.Side) do
					local l = btn:FindFirstChild("Lbl")
					if l then l.Visible = true end
				end
				toastWrap.Size = UDim2.new(0, 300, 0.72, 0)
			end
		end

		Z100.UI.OnResponsiveChange(applyResponsiveLayout)
		applyResponsiveLayout(dev, winW, winH)

		-- Listen for viewport resize / orientation changes safely
		local cam = workspace.CurrentCamera
		if cam then
			Z100.Util.TrackConn(cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				Z100.UI.NotifyResponsive()
			end))
		end

		Z100.UI.UpdateNavActive("Home")
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 8 / 15 : BRAND-NEW HOME SCREEN (HERO, STORIES, CHATS, SUGGESTED, PROMO)
-- ========================================================================= --

do
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend

	local homeRenderSeq = 0

	function Z100.Screens.RenderHome(host)
		if not host or not host.Parent then return end

		homeRenderSeq = homeRenderSeq + 1
		local mySeq = homeRenderSeq
		local p = Z100.Theme.Get()

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_HomeScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 20, 14)
		C.AttachAutoCanvas(scroll, list, 28)

		-- Immediate Loading Skeleton while hydrating fresh data
		local skel = C.LoadingSkeleton(scroll, 4, 72, 1)

		task.spawn(function()
			local myProf = Backend.FetchProfile(Z100.MyUid, false)
			local storyBuckets = Backend.FetchStoriesFeed()
			local suggested = Backend.FetchSuggestedUsers(6)
			local notifs = Backend.FetchMyNotifs(true)
			local hasBundle = Backend.HasCosmeticsBundle(Z100.MyUid)
			local hasMusic = Backend.HasMusicStudioPass(Z100.MyUid)
			local bundlePrice = Backend.GetBundlePrice()
			local musicPrice = Backend.GetMusicPassPrice()

			if homeRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			local animTargets = {}
			local ord = 1

			-- ============================================================= --
			-- 1. WELCOME HERO CARD (Avatar, Username, Quick Profile)
			-- ============================================================= --
			local hero = C.Card(scroll, {
				Name = "HomeWelcomeHero",
				LayoutOrder = ord,
				FixedHeight = true,
				Size = UDim2.new(1, 0, 0, 88),
				BackgroundColor3 = p.SurfaceElev,
				StrokeColor = p.BorderGlow,
				StrokeThickness = 1.4,
				Padding = false,
				UseList = false,
				ZIndex = 24,
			})
			ord = ord + 1
			table.insert(animTargets, hero)

			local hGrad = Instance.new("UIGradient", hero)
			hGrad.Rotation = 135
			hGrad.Color = ColorSequence.new(p.SurfaceElev, p.Card)

			local avWrap = Instance.new("Frame", hero)
			avWrap.Size = UDim2.new(0, 56, 0, 56)
			avWrap.Position = UDim2.new(0, 14, 0.5, -28)
			avWrap.BackgroundColor3 = p.BgRoot
			avWrap.ZIndex = 26
			C.Corner(avWrap, Z100.Theme.Tokens.Radius.Pill)

			local avImg = Instance.new("ImageButton", avWrap)
			avImg.Size = UDim2.new(1, -4, 1, -4)
			avImg.Position = UDim2.new(0.5, 0, 0.5, 0)
			avImg.AnchorPoint = Vector2.new(0.5, 0.5)
			avImg.BackgroundTransparency = 1
			avImg.ScaleType = Enum.ScaleType.Crop
			avImg.ZIndex = 27
			C.Corner(avImg, Z100.Theme.Tokens.Radius.Pill)
			Util.LoadAvatarHeadshot(avImg, Z100.MyUid, myProf and myProf.customAvatar)
			if myProf and myProf.decoration and myProf.decoration ~= "none" then
				Z100.Anim.ApplyAvatarDecoration(avWrap, myProf.decoration, true)
			else
				C.Stroke(avWrap, p.Accent, 2, 0.1)
			end
			avImg.MouseButton1Click:Connect(function()
				Z100.Router.OpenProfile(Z100.MyUid)
			end)

			local wText = Instance.new("TextLabel", hero)
			wText.Size = UDim2.new(1, -190, 0, 44)
			wText.Position = UDim2.new(0, 82, 0.5, -22)
			wText.BackgroundTransparency = 1
			wText.Font = Z100.Theme.Tokens.Fonts.Body
			wText.TextSize = 11.5
			wText.TextColor3 = p.TextPrimary
			wText.TextXAlignment = Enum.TextXAlignment.Left
			wText.ClipsDescendants = true
			wText.RichText = true
			wText.ZIndex = 26
			local dispName = (myProf and myProf.displayName) or Z100.Player.DisplayName
			wText.Text = string.format(
				"<font size='10' color='#%s'>Welcome back,</font>\n<b><font size='15'>%s</font></b>  <font size='10' color='#%s'>@%s</font>",
				p.TextSecondary:ToHex(),
				Util.EscapeRichText(dispName),
				p.TextMuted:ToHex(),
				Util.EscapeRichText(Z100.MyName)
			)

			C.Button(hero, {
				Size = UDim2.new(0, 96, 0, 32),
				Position = UDim2.new(1, -108, 0.5, -16),
				Variant = "primary",
				Text = "My Profile ›",
				TextSize = 10.5,
				ZIndex = 27,
				OnClick = function() Z100.Router.OpenProfile(Z100.MyUid) end,
			})

			-- ============================================================= --
			-- 2. HORIZONTAL STORIES CAROUSEL (Add Story + Active Rings)
			-- ============================================================= --
			local storyCard = C.Card(scroll, {
				Name = "HomeStoriesCarousel",
				LayoutOrder = ord,
				PadY = 10,
				PadX = 12,
				ListGap = 6,
				ZIndex = 24,
			})
			ord = ord + 1
			table.insert(animTargets, storyCard)

			C.SectionHeader(storyCard, "◎ Stories", "24-hour photo & music stories", 1, "See All ›", function()
				Z100.Router.Navigate("Stories")
			end)

			local stScroll = Instance.new("ScrollingFrame", storyCard)
			stScroll.Size = UDim2.new(1, 0, 0, 82)
			stScroll.BackgroundTransparency = 1
			stScroll.ScrollBarThickness = 2
			stScroll.ScrollBarImageColor3 = p.Accent
			stScroll.ScrollingDirection = Enum.ScrollingDirection.X
			stScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
			stScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
			stScroll.LayoutOrder = 2
			stScroll.ZIndex = 25
			C.ListLayout(stScroll, 10, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
			C.Padding(stScroll, 2, 4, 2, 4)

			-- "Add Story" Button
			local addItem = Instance.new("TextButton", stScroll)
			addItem.Size = UDim2.new(0, 64, 0, 74)
			addItem.BackgroundTransparency = 1
			addItem.Text = ""
			addItem.LayoutOrder = 1
			addItem.ZIndex = 26
			C.AttachButtonFeedback(addItem, 1.06)

			local addRing = Instance.new("Frame", addItem)
			addRing.Size = UDim2.new(0, 48, 0, 48)
			addRing.Position = UDim2.new(0.5, -24, 0, 4)
			addRing.BackgroundColor3 = p.SurfaceElev
			addRing.ZIndex = 27
			C.Corner(addRing, Z100.Theme.Tokens.Radius.Pill)
			C.Stroke(addRing, p.Accent, 2, 0.15)

			local addPlus = Instance.new("TextLabel", addRing)
			addPlus.Size = UDim2.new(1, 0, 1, 0)
			addPlus.BackgroundTransparency = 1
			addPlus.Font = Z100.Theme.Tokens.Fonts.Heading
			addPlus.TextSize = 22
			addPlus.TextColor3 = p.Accent
			addPlus.Text = "+"
			addPlus.ZIndex = 28

			local addLbl = Instance.new("TextLabel", addItem)
			addLbl.Size = UDim2.new(1, 0, 0, 14)
			addLbl.Position = UDim2.new(0, 0, 1, -15)
			addLbl.BackgroundTransparency = 1
			addLbl.Font = Z100.Theme.Tokens.Fonts.Title
			addLbl.TextSize = 9.5
			addLbl.TextColor3 = p.TextSecondary
			addLbl.Text = "Add Story"
			addLbl.ZIndex = 27

			addItem.MouseButton1Click:Connect(function()
				Z100.Router.Navigate("StoryEditor")
			end)

			for idx, bucket in ipairs(storyBuckets) do
				local acc = Util.GetAccountByUid(bucket.uid)
				local prof = State.Profiles[bucket.uid]

				local item = Instance.new("TextButton", stScroll)
				item.Size = UDim2.new(0, 64, 0, 74)
				item.BackgroundTransparency = 1
				item.Text = ""
				item.LayoutOrder = idx + 1
				item.ZIndex = 26
				C.AttachButtonFeedback(item, 1.06)

				local avHold = Instance.new("Frame", item)
				avHold.Size = UDim2.new(0, 48, 0, 48)
				avHold.Position = UDim2.new(0.5, -24, 0, 4)
				avHold.BackgroundColor3 = p.BgRoot
				avHold.ZIndex = 27
				C.Corner(avHold, Z100.Theme.Tokens.Radius.Pill)

				local img = Instance.new("ImageLabel", avHold)
				img.Size = UDim2.new(1, -4, 1, -4)
				img.Position = UDim2.new(0.5, 0, 0.5, 0)
				img.AnchorPoint = Vector2.new(0.5, 0.5)
				img.BackgroundTransparency = 1
				img.ScaleType = Enum.ScaleType.Crop
				img.ZIndex = 28
				C.Corner(img, Z100.Theme.Tokens.Radius.Pill)
				Util.LoadAvatarHeadshot(img, bucket.uid, prof and prof.customAvatar)
				Z100.Anim.ApplyStoryRing(avHold, bucket.ring)

				local uLbl = Instance.new("TextLabel", item)
				uLbl.Size = UDim2.new(1, 0, 0, 14)
				uLbl.Position = UDim2.new(0, 0, 1, -15)
				uLbl.BackgroundTransparency = 1
				uLbl.Font = Z100.Theme.Tokens.Fonts.Title
				uLbl.TextSize = 9.5
				uLbl.TextColor3 = p.TextPrimary
				uLbl.ClipsDescendants = true
				uLbl.Text = (bucket.uid == Z100.MyUid) and "Your Story" or acc.DisplayName
				uLbl.ZIndex = 27

				item.MouseButton1Click:Connect(function()
					if Z100.Stories.OpenViewer then
						Z100.Stories.OpenViewer(bucket.uid, bucket.stories, 1)
					end
				end)
			end

			-- ============================================================= --
			-- 3. QUICK ACTIONS ROW
			-- ============================================================= --
			local qaWrap = Instance.new("Frame", scroll)
			qaWrap.Name = "HomeQuickActions"
			qaWrap.Size = UDim2.new(1, 0, 0, 38)
			qaWrap.BackgroundTransparency = 1
			qaWrap.LayoutOrder = ord
			qaWrap.ZIndex = 24
			ord = ord + 1
			table.insert(animTargets, qaWrap)

			C.ListLayout(qaWrap, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

			local actions = {
				{ Text = "✉ Messages",   Variant = "secondary", Fn = function() Z100.Router.Navigate("Messages") end },
				{ Text = "♫ Music",      Variant = "secondary", Fn = function() Z100.Router.Navigate("MusicStudio") end },
				{ Text = "✎ Edit",       Variant = "secondary", Fn = function() Z100.Router.Navigate("ProfileEditor") end },
				{ Text = "♛ Store",      Variant = "gold",      Fn = function() Z100.Router.OpenStore("Decorations") end },
			}
			for i, act in ipairs(actions) do
				C.Button(qaWrap, {
					Size = UDim2.new(0.242, 0, 1, 0),
					Variant = act.Variant,
					Text = act.Text,
					TextSize = 10,
					LayoutOrder = i,
					ZIndex = 25,
					OnClick = act.Fn,
				})
			end

			-- ============================================================= --
			-- 4. RECENT CONVERSATIONS PREVIEW
			-- ============================================================= --
			local dmCard = C.Card(scroll, {
				Name = "HomeRecentChats",
				LayoutOrder = ord,
				ZIndex = 24,
			})
			ord = ord + 1
			table.insert(animTargets, dmCard)

			C.SectionHeader(dmCard, "✉ Recent Conversations", nil, 1, "Inbox ›", function()
				State.ChatSubMode = "DM_Inbox"
				Z100.Router.Navigate("Messages")
			end)

			local dmRows = {}
			for partnerKey, msgs in pairs(State.Cache.DMs) do
				local last = msgs[#msgs]
				if last then
					table.insert(dmRows, { key = partnerKey, msg = last })
				end
			end
			table.sort(dmRows, function(a, b) return (a.msg.Time or 0) > (b.msg.Time or 0) end)

			if #dmRows == 0 then
				local em = Instance.new("TextLabel", dmCard)
				em.Size = UDim2.new(1, 0, 0, 26)
				em.BackgroundTransparency = 1
				em.Font = Z100.Theme.Tokens.Fonts.Body
				em.TextSize = 10.5
				em.TextColor3 = p.TextMuted
				em.TextXAlignment = Enum.TextXAlignment.Left
				em.Text = "No recent DMs yet. Message someone from their profile or Server Chat!"
				em.LayoutOrder = 2
				em.ZIndex = 25
			else
				for idx = 1, math.min(3, #dmRows) do
					local entry = dmRows[idx]
					local acc = Util.GetAccount(entry.key)
					local row = Instance.new("TextButton", dmCard)
					row.Size = UDim2.new(1, 0, 0, 46)
					row.BackgroundColor3 = p.SurfaceElev
					row.AutoButtonColor = false
					row.Text = ""
					row.LayoutOrder = idx + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)
					C.AttachButtonFeedback(row, 1.01)

					local av = Instance.new("ImageLabel", row)
					av.Size = UDim2.new(0, 32, 0, 32)
					av.Position = UDim2.new(0, 8, 0.5, -16)
					av.BackgroundColor3 = p.BgRoot
					av.ScaleType = Enum.ScaleType.Crop
					av.ZIndex = 26
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, acc.UserId)

					local lbl = Instance.new("TextLabel", row)
					lbl.Size = UDim2.new(1, -104, 1, -6)
					lbl.Position = UDim2.new(0, 48, 0, 3)
					lbl.BackgroundTransparency = 1
					lbl.Font = Z100.Theme.Tokens.Fonts.Body
					lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary
					lbl.TextXAlignment = Enum.TextXAlignment.Left
					lbl.ClipsDescendants = true
					lbl.RichText = true
					lbl.ZIndex = 26
					lbl.Text = string.format("<b>%s</b>\n<font color='#%s' size='9.5'>%s</font>",
						Util.EscapeRichText(acc.DisplayName),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(Util.SanitizePreviewText(entry.msg.Msg):sub(1, 42)))

					local tLbl = Instance.new("TextLabel", row)
					tLbl.Size = UDim2.new(0, 48, 1, 0)
					tLbl.Position = UDim2.new(1, -54, 0, 0)
					tLbl.BackgroundTransparency = 1
					tLbl.Font = Z100.Theme.Tokens.Fonts.Body
					tLbl.TextSize = 9
					tLbl.TextColor3 = p.TextMuted
					tLbl.TextXAlignment = Enum.TextXAlignment.Right
					tLbl.Text = Util.TimeAgo(entry.msg.Time)
					tLbl.ZIndex = 26

					row.MouseButton1Click:Connect(function()
						State.ChatSubMode = "DM"
						State.ActiveDM = entry.key
						Z100.Router.Navigate("Messages")
					end)
				end
			end

			-- ============================================================= --
			-- 5. SUGGESTED USERS (Live Server + Directory)
			-- ============================================================= --
			local sugCard = C.Card(scroll, {
				Name = "HomeSuggestedUsers",
				LayoutOrder = ord,
				ZIndex = 24,
			})
			ord = ord + 1
			table.insert(animTargets, sugCard)

			C.SectionHeader(sugCard, "✦ Suggested People", "Connect with players online & on ZAYN", 1)

			if #suggested == 0 then
				local em = Instance.new("TextLabel", sugCard)
				em.Size = UDim2.new(1, 0, 0, 24)
				em.BackgroundTransparency = 1
				em.Font = Z100.Theme.Tokens.Fonts.Body
				em.TextSize = 10.5
				em.TextColor3 = p.TextMuted
				em.TextXAlignment = Enum.TextXAlignment.Left
				em.Text = "No suggestions right now. Search users in Profile or Messages!"
				em.LayoutOrder = 2
				em.ZIndex = 25
			else
				for idx, u in ipairs(suggested) do
					local isFol = Backend.IsFollowing(u.uid)
					local row = Instance.new("Frame", sugCard)
					row.Size = UDim2.new(1, 0, 0, 46)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = idx + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local av = Instance.new("ImageButton", row)
					av.Size = UDim2.new(0, 32, 0, 32)
					av.Position = UDim2.new(0, 8, 0.5, -16)
					av.BackgroundColor3 = p.BgRoot
					av.ScaleType = Enum.ScaleType.Crop
					av.ZIndex = 26
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, u.uid)
					av.MouseButton1Click:Connect(function() Z100.Router.OpenProfile(u.uid) end)

					local lbl = Instance.new("TextButton", row)
					lbl.Size = UDim2.new(1, -138, 1, -4)
					lbl.Position = UDim2.new(0, 48, 0, 2)
					lbl.BackgroundTransparency = 1
					lbl.Font = Z100.Theme.Tokens.Fonts.Body
					lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary
					lbl.TextXAlignment = Enum.TextXAlignment.Left
					lbl.ClipsDescendants = true
					lbl.RichText = true
					lbl.ZIndex = 26
					local badgeTxt = u.inServer and " <font color='#10D48E' size='9'>● Online</font>" or ""
					lbl.Text = string.format("<b>%s</b>%s\n<font color='#%s' size='9.5'>@%s</font>",
						Util.EscapeRichText(u.displayName), badgeTxt, p.TextMuted:ToHex(), Util.EscapeRichText(u.username))
					lbl.MouseButton1Click:Connect(function() Z100.Router.OpenProfile(u.uid) end)

					local fBtn
					fBtn = C.Button(row, {
						Size = UDim2.new(0, 76, 0, 28),
						Position = UDim2.new(1, -84, 0.5, -14),
						Variant = isFol and "secondary" or "primary",
						Text = isFol and "Following" or "+ Follow",
						TextSize = 9.5,
						ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								local ok, msg = isFol and Backend.UnfollowUser(u.uid) or Backend.FollowUser(u.uid)
								if ok then
									isFol = not isFol
									if fBtn and fBtn.Parent then
										fBtn.Text = isFol and "Following" or "+ Follow"
										fBtn.BackgroundColor3 = isFol and p.Card or p.Accent
									end
								end
								Z100.UI.ShowToast(ok and "👥 Social" or "⚠️ Notice", msg, p.Accent, u.uid)
							end)
						end,
					})
				end
			end

			-- ============================================================= --
			-- 6. NOTIFICATIONS PREVIEW
			-- ============================================================= --
			if #notifs > 0 then
				local nCard = C.Card(scroll, {
					Name = "HomeNotifsPreview",
					LayoutOrder = ord,
					ZIndex = 24,
				})
				ord = ord + 1
				table.insert(animTargets, nCard)

				C.SectionHeader(nCard, "🔔 Recent Alerts", nil, 1, "View All ›", function()
					Z100.Router.Navigate("Notifications")
				end)

				for idx = 1, math.min(2, #notifs) do
					local it = notifs[idx]
					local r = Instance.new("TextLabel", nCard)
					r.Size = UDim2.new(1, 0, 0, 34)
					r.BackgroundColor3 = p.SurfaceElev
					r.Font = Z100.Theme.Tokens.Fonts.Body
					r.TextSize = 10
					r.TextColor3 = p.TextPrimary
					r.TextXAlignment = Enum.TextXAlignment.Left
					r.ClipsDescendants = true
					r.RichText = true
					r.LayoutOrder = idx + 1
					r.ZIndex = 25
					C.Corner(r, Z100.Theme.Tokens.Radius.SM)
					C.Padding(r, 4, 8, 4, 10)
					r.Text = string.format("<b>%s</b> • <font color='#%s'>%s</font>\n<font color='#%s' size='9'>%s</font>",
						Util.EscapeRichText(it.title),
						p.TextMuted:ToHex(),
						Util.TimeAgo(it.timestamp),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(tostring(it.message or ""):sub(1, 64)))
				end
			end

			-- ============================================================= --
			-- 7. PREMIUM PROMOTION BANNER (₹300 Bundle & ₹1500 Music Studio)
			-- ============================================================= --
			if not (hasBundle and hasMusic) then
				local promo = C.Card(scroll, {
					Name = "HomePremiumPromo",
					LayoutOrder = ord,
					BackgroundColor3 = Color3.fromRGB(22, 17, 10),
					StrokeColor = p.Gold,
					StrokeThickness = 1.6,
					ZIndex = 24,
				})
				table.insert(animTargets, promo)

				local pTitle = Instance.new("TextLabel", promo)
				pTitle.Size = UDim2.new(1, 0, 0, 22)
				pTitle.BackgroundTransparency = 1
				pTitle.Font = Z100.Theme.Tokens.Fonts.Heading
				pTitle.TextSize = 13.5
				pTitle.TextXAlignment = Enum.TextXAlignment.Left
				pTitle.Text = "👑 UPGRADE TO ZAYN PREMIUM & MUSIC STUDIO PRO"
				pTitle.LayoutOrder = 1
				pTitle.ZIndex = 25
				Z100.Anim.ApplyGradientText(pTitle, Color3.fromRGB(255, 228, 95), Color3.fromRGB(255, 148, 30))

				local pSub = Instance.new("TextLabel", promo)
				pSub.Size = UDim2.new(1, 0, 0, 0)
				pSub.AutomaticSize = Enum.AutomaticSize.Y
				pSub.BackgroundTransparency = 1
				pSub.Font = Z100.Theme.Tokens.Fonts.Body
				pSub.TextSize = 10.5
				pSub.TextColor3 = Color3.fromRGB(222, 206, 170)
				pSub.TextWrapped = true
				pSub.TextXAlignment = Enum.TextXAlignment.Left
				pSub.LayoutOrder = 2
				pSub.ZIndex = 25
				pSub.Text = string.format(
					"Unlock all 16 Avatar Decorations, 15 Animated Profile Themes & Royal Gold UI for ₹%d ONE-TIME, or Online YouTube Music Studio for ₹%d.",
					bundlePrice, musicPrice
				)

				local btnRow = Instance.new("Frame", promo)
				btnRow.Size = UDim2.new(1, 0, 0, 34)
				btnRow.BackgroundTransparency = 1
				btnRow.LayoutOrder = 3
				btnRow.ZIndex = 25

				C.Button(btnRow, {
					Size = UDim2.new(0.49, 0, 1, 0),
					Variant = "gold",
					Text = "👑 Cosmetics ₹" .. tostring(bundlePrice),
					TextSize = 10.5,
					ZIndex = 26,
					OnClick = function() Z100.Router.OpenStore("Bundle") end,
				})
				C.Button(btnRow, {
					Size = UDim2.new(0.49, 0, 1, 0),
					Position = UDim2.new(0.51, 0, 0, 0),
					Variant = "primary",
					Text = "♫ Music Studio ₹" .. tostring(musicPrice),
					TextSize = 10.5,
					ZIndex = 26,
					OnClick = function() Z100.Router.OpenStore("MusicPass") end,
				})
			end

			Z100.Anim.PlaySequentialEntrance(scroll, animTargets)
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 9 / 15 : INSTAGRAM-STYLE PROFILE SCREEN & FOLLOWERS/FOLLOWING POPUPS
-- ========================================================================= --

do
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend

	local profileRenderSeq = 0
	local followModalSeq = 0

	-- ===================================================================== --
	-- [SECTION A : COMPACT FOLLOWERS / FOLLOWING / REQUESTS POPUP OVERLAY]
	-- ===================================================================== --
	local function renderFollowModalRow(scroll, uidStr, modeTab, isMyProf, themeObj, orderIdx, onRefresh)
		local acc = Util.GetAccountByUid(uidStr)
		local isMeRow = (uidStr == Z100.MyUid)
		local isFollowing = (not isMeRow) and Backend.IsFollowing(uidStr)
		local isMutual = (not isMeRow) and Backend.IsMutual(uidStr)
		local isOnline = Backend.IsOnlineCached(uidStr)

		local row = Instance.new("Frame", scroll)
		row.Name = "FollowRow_" .. uidStr
		row.Size = UDim2.new(1, -4, 0, 52)
		row.BackgroundColor3 = themeObj.cardBg
		row.BorderSizePixel = 0
		row.LayoutOrder = orderIdx
		row.ZIndex = scroll.ZIndex + 1
		C.Corner(row, Z100.Theme.Tokens.Radius.SM)
		C.Stroke(row, isMutual and themeObj.accent or Color3.fromRGB(56, 52, 82), 1.1, isMutual and 0.25 or 0.55)

		local avWrap = Instance.new("Frame", row)
		avWrap.Size = UDim2.new(0, 36, 0, 36)
		avWrap.Position = UDim2.new(0, 8, 0.5, -18)
		avWrap.BackgroundColor3 = themeObj.bg1
		avWrap.ZIndex = row.ZIndex + 1
		C.Corner(avWrap, Z100.Theme.Tokens.Radius.Pill)

		local avImg = Instance.new("ImageLabel", avWrap)
		avImg.Size = UDim2.new(1, -2, 1, -2)
		avImg.Position = UDim2.new(0.5, 0, 0.5, 0)
		avImg.AnchorPoint = Vector2.new(0.5, 0.5)
		avImg.BackgroundTransparency = 1
		avImg.ScaleType = Enum.ScaleType.Crop
		avImg.ZIndex = avWrap.ZIndex + 1
		C.Corner(avImg, Z100.Theme.Tokens.Radius.Pill)

		local cachedProf = State.Profiles[uidStr]
		Util.LoadAvatarHeadshot(avImg, uidStr, cachedProf and cachedProf.customAvatar)
		if cachedProf and cachedProf.decoration and cachedProf.decoration ~= "none" then
			Z100.Anim.ApplyAvatarDecoration(avWrap, cachedProf.decoration, true)
		end

		local dot = Instance.new("Frame", avWrap)
		dot.Size = UDim2.new(0, 9, 0, 9)
		dot.Position = UDim2.new(1, -8, 1, -8)
		dot.BackgroundColor3 = isOnline and Color3.fromRGB(16, 212, 142) or Color3.fromRGB(110, 114, 134)
		dot.BorderSizePixel = 0
		dot.ZIndex = avWrap.ZIndex + 4
		C.Corner(dot, Z100.Theme.Tokens.Radius.Pill)

		local openBtn = Instance.new("TextButton", row)
		openBtn.Size = UDim2.new(1, -162, 1, 0)
		openBtn.Position = UDim2.new(0, 52, 0, 0)
		openBtn.BackgroundTransparency = 1
		openBtn.Text = ""
		openBtn.ZIndex = row.ZIndex + 1
		openBtn.MouseButton1Click:Connect(function()
			local host = Z100.UI.ModalLayer or Z100.UI.MainFrame
			if host and host:FindFirstChild("ZaynV100_FollowModal") then
				host.ZaynV100_FollowModal:Destroy()
			end
			Z100.Router.OpenProfile(uidStr)
		end)

		local nLbl = Instance.new("TextLabel", openBtn)
		nLbl.Size = UDim2.new(1, 0, 0, 18)
		nLbl.Position = UDim2.new(0, 0, 0, 7)
		nLbl.BackgroundTransparency = 1
		nLbl.Font = Z100.Theme.Tokens.Fonts.Title
		nLbl.TextSize = 11.5
		nLbl.TextColor3 = themeObj.textColor
		nLbl.TextXAlignment = Enum.TextXAlignment.Left
		nLbl.ClipsDescendants = true
		nLbl.Text = acc.DisplayName .. (isMutual and " ✦" or "")
		nLbl.ZIndex = openBtn.ZIndex + 1

		local uLbl = Instance.new("TextLabel", openBtn)
		uLbl.Size = UDim2.new(1, 0, 0, 14)
		uLbl.Position = UDim2.new(0, 0, 0, 27)
		uLbl.BackgroundTransparency = 1
		uLbl.Font = Z100.Theme.Tokens.Fonts.Body
		uLbl.TextSize = 9.5
		uLbl.TextColor3 = themeObj.subText
		uLbl.TextXAlignment = Enum.TextXAlignment.Left
		uLbl.ClipsDescendants = true
		uLbl.Text = "@" .. acc.Username
		uLbl.ZIndex = openBtn.ZIndex + 1

		if not acc.Verified then
			task.spawn(function()
				local res = Util.ResolveUser(uidStr)
				if res and nLbl and nLbl.Parent then
					nLbl.Text = res.DisplayName .. (isMutual and " ✦" or "")
					uLbl.Text = "@" .. res.Username
				end
			end)
		end

		local actWrap = Instance.new("Frame", row)
		actWrap.Size = UDim2.new(0, 104, 1, 0)
		actWrap.Position = UDim2.new(1, -110, 0, 0)
		actWrap.BackgroundTransparency = 1
		actWrap.ZIndex = row.ZIndex + 1
		C.ListLayout(actWrap, 4, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)

		local function miniBtn(txt, w, col, txtCol, cb)
			return C.Button(actWrap, {
				Size = UDim2.new(0, w, 0, 26),
				BackgroundColor3 = col,
				TextColor3 = txtCol or Color3.fromRGB(255, 255, 255),
				Text = txt,
				TextSize = 9.5,
				ZIndex = actWrap.ZIndex + 1,
				OnClick = cb,
			})
		end

		if modeTab == "Requests" and isMyProf then
			miniBtn("✓ Accept", 56, Color3.fromRGB(16, 185, 125), nil, function()
				task.spawn(function()
					local ok, msg = Backend.AcceptFollowRequest(uidStr)
					Z100.UI.ShowToast(ok and "✅ Accepted" or "⚠️ Notice", msg, themeObj.accent, uidStr)
					onRefresh()
				end)
			end)
			miniBtn("✕", 28, Color3.fromRGB(190, 44, 58), nil, function()
				task.spawn(function()
					Backend.DeclineFollowRequest(uidStr)
					onRefresh()
				end)
			end)
		elseif modeTab == "Followers" and isMyProf then
			if not isFollowing then
				miniBtn("+ Back", 46, themeObj.buttonBg, themeObj.buttonText, function()
					task.spawn(function()
						local ok, msg = Backend.FollowUser(uidStr)
						Z100.UI.ShowToast(ok and "👥 Followed" or "⚠️ Notice", msg, themeObj.accent, uidStr)
						onRefresh()
					end)
				end)
			end
			miniBtn("Remove", 50, Color3.fromRGB(175, 42, 58), nil, function()
				task.spawn(function()
					local _, msg = Backend.RemoveFollower(uidStr)
					Z100.UI.ShowToast("🗑️ Removed", msg, Color3.fromRGB(235, 65, 80), uidStr)
					onRefresh()
				end)
			end)
		elseif modeTab == "Following" and isMyProf then
			miniBtn("Unfollow", 68, Color3.fromRGB(170, 44, 58), nil, function()
				task.spawn(function()
					Backend.UnfollowUser(uidStr)
					onRefresh()
				end)
			end)
		elseif not isMeRow then
			miniBtn(
				isFollowing and "Following" or "+ Follow",
				68,
				isFollowing and Color3.fromRGB(56, 54, 78) or themeObj.buttonBg,
				isFollowing and Color3.fromRGB(240, 240, 250) or themeObj.buttonText,
				function()
					task.spawn(function()
						local ok, msg = isFollowing and Backend.UnfollowUser(uidStr) or Backend.FollowUser(uidStr)
						Z100.UI.ShowToast(ok and "👥 Social" or "⚠️ Notice", msg, themeObj.accent, uidStr)
						onRefresh()
					end)
				end
			)
		end
	end

	function Z100.UI.OpenFollowModal(targetUid, initialTab)
		local uidStr = Util.NormalizeUid(targetUid or State.ViewingProfileUid) or Z100.MyUid
		local isMyProf = (uidStr == Z100.MyUid)
		local prof = State.Profiles[uidStr]
		local themeObj = Z100.Catalog.ResolveProfileTheme(prof and prof.theme)
		local activeTab = initialTab or "Followers"

		local modal = C.OpenModal({
			Name = "ZaynV100_FollowModal",
			Title = "@" .. tostring(prof and prof.username or Util.GetAccountByUid(uidStr).Username) .. " • Connections",
			Width = 400,
			FixedHeight = 360,
			AccentColor = themeObj.accent,
			UseList = false,
			OnClose = function()
				if State.ActiveScreen == "Profile" and Z100.Router.RefreshCurrent then
					Z100.Router.RefreshCurrent()
				end
			end,
		})
		if not modal then return end

		local tabHost = Instance.new("Frame", modal.Body)
		tabHost.Size = UDim2.new(1, 0, 0, 36)
		tabHost.BackgroundTransparency = 1
		tabHost.ZIndex = modal.Body.ZIndex + 1

		local scroll = Instance.new("ScrollingFrame", modal.Body)
		scroll.Size = UDim2.new(1, 0, 1, -44)
		scroll.Position = UDim2.new(0, 0, 0, 44)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 2
		scroll.ScrollBarImageColor3 = themeObj.accent
		scroll.ZIndex = modal.Body.ZIndex + 1
		local sLay = C.ListLayout(scroll, 6)
		C.AttachAutoCanvas(scroll, sLay, 12)

		local function populate()
			followModalSeq = followModalSeq + 1
			local tok = followModalSeq

			for _, ch in ipairs(tabHost:GetChildren()) do ch:Destroy() end
			local rCnt = Util.CountKeys(State.Requests)
			local tabs = isMyProf and {
				{ Id = "Followers", Label = "Followers", Color = themeObj.accent, ActiveText = Color3.fromRGB(12, 12, 18) },
				{ Id = "Following", Label = "Following", Color = themeObj.accent, ActiveText = Color3.fromRGB(12, 12, 18) },
				{ Id = "Requests",  Label = rCnt > 0 and ("Requests (" .. rCnt .. ")") or "Requests", Color = themeObj.accent, ActiveText = Color3.fromRGB(12, 12, 18) },
			} or {
				{ Id = "Followers", Label = "Followers", Color = themeObj.accent, ActiveText = Color3.fromRGB(12, 12, 18) },
				{ Id = "Following", Label = "Following", Color = themeObj.accent, ActiveText = Color3.fromRGB(12, 12, 18) },
			}

			C.TabBar(tabHost, tabs, activeTab, 1, function(newTab)
				activeTab = newTab
				populate()
			end)

			for _, ch in ipairs(scroll:GetChildren()) do
				if not ch:IsA("UIListLayout") then ch:Destroy() end
			end
			local skel = C.LoadingSkeleton(scroll, 3, 48, 1)

			task.spawn(function()
				Backend.FetchGraph(Z100.MyUid, true)
				if not isMyProf then Backend.FetchGraph(uidStr, true) end

				local uids = {}
				if activeTab == "Followers" then
					for k, v in pairs(State.Followers[uidStr] or {}) do if v then table.insert(uids, tostring(k)) end end
				elseif activeTab == "Following" then
					for k, v in pairs(State.Following[uidStr] or {}) do if v then table.insert(uids, tostring(k)) end end
				elseif activeTab == "Requests" and isMyProf then
					local reqs = Backend.FetchMyRequests()
					for k, v in pairs(reqs) do
						if type(v) == "table" then
							if v.username then Util.RegisterAccount(v.username, v.displayName or v.username, tonumber(k) or 1) end
							table.insert(uids, tostring(k))
						end
					end
				end

				if followModalSeq ~= tok or not scroll or not scroll.Parent then return end
				if skel and skel.Parent then skel:Destroy() end

				if #uids == 0 then
					C.EmptyState(scroll, "👥", "No " .. activeTab, activeTab == "Requests" and "No pending follow requests." or ("No users in " .. activeTab .. " yet."), nil, nil, 1)
					return
				end

				for idx, uId in ipairs(uids) do
					renderFollowModalRow(scroll, uId, activeTab, isMyProf, themeObj, idx, populate)
				end
			end)
		end

		populate()
	end

	-- ===================================================================== --
	-- [SECTION B : INSTAGRAM-STYLE PROFILE SCREEN RENDERER]
	-- ===================================================================== --
	function Z100.Screens.RenderProfile(host, targetUid)
		if not host or not host.Parent then return end

		profileRenderSeq = profileRenderSeq + 1
		local mySeq = profileRenderSeq
		local uidStr = Util.NormalizeUid(targetUid or State.ViewingProfileUid) or Z100.MyUid
		State.ViewingProfileUid = uidStr

		local p = Z100.Theme.Get()
		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_ProfileScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundColor3 = p.BgRoot
		scroll.BackgroundTransparency = 0
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local pageBgGrad = Instance.new("UIGradient", scroll)
		pageBgGrad.Rotation = 135
		pageBgGrad.Color = ColorSequence.new(p.BgGradA, p.BgGradB)

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 22, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		local skel = C.LoadingSkeleton(scroll, 3, 84, 1)

		task.spawn(function()
			local isMe = (uidStr == Z100.MyUid)
			local prof = Backend.FetchProfile(uidStr, true)
			Backend.FetchGraph(uidStr, true)
			if not isMe then
				Backend.FetchGraph(Z100.MyUid, false)
			else
				Backend.FetchMyRequests()
			end
			local isOnline = Backend.FetchPresence(uidStr)
			local userStories = Backend.FetchUserStories(uidStr, true)
			local storyRingState = Backend.GetStoryRingState(uidStr)

			local isBlocked = (not isMe) and Backend.IsBlocked(uidStr)
			local isBlockedBy = (not isMe) and Backend.IsBlockedBy(uidStr)
			local isFollowing = (not isMe) and Backend.IsFollowing(uidStr)
			local isFollowedBy = (not isMe) and Backend.IsFollowedBy(uidStr)
			local hasPending = (not isMe) and (not isFollowing) and Backend.HasSentRequestTo(uidStr)

			if profileRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			if not prof then
				C.ErrorState(scroll, "Could not load this user's profile.", function()
					Z100.Router.OpenProfile(uidStr)
				end, 1)
				return
			end

			local themeObj = Z100.Catalog.ResolveProfileTheme(prof.theme)
			local isPaidTheme = (themeObj.id ~= "default_base")
			local followerCnt = Backend.GetFollowerCount(uidStr)
			local followingCnt = Backend.GetFollowingCount(uidStr)
			local isPrivateLocked = (not isMe) and prof.privacy and prof.privacy.isPrivate and (not isFollowing)
			local canViewLists = isMe or (not isPrivateLocked and not (prof.privacy and prof.privacy.hideLists))

			-- Transform complete Profile Screen canvas to user's equipped Theme
			Z100.Theme.Tween(scroll, Z100.Theme.Tokens.Timing.Smooth, { BackgroundColor3 = themeObj.bg1 })
			scroll.ScrollBarImageColor3 = themeObj.accent
			pageBgGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)

			if Z100.UI.HeaderTitle then
				Z100.UI.HeaderTitle.Text = isMe and "MY PROFILE" or ("@" .. tostring(prof.username))
			end
			if Z100.UI.HeaderSub then
				Z100.UI.HeaderSub.Text = isOnline and "● Online Now" or "Offline"
			end

			local animTargets = {}

			-- 1. QUICK USER LOOKUP BAR
			local findCard = Instance.new("Frame", scroll)
			findCard.Size = UDim2.new(1, 0, 0, 36)
			findCard.BackgroundColor3 = themeObj.cardBg
			findCard.BorderSizePixel = 0
			findCard.LayoutOrder = 1
			findCard.ZIndex = 25
			C.Corner(findCard, Z100.Theme.Tokens.Radius.SM)
			C.Stroke(findCard, themeObj.border1, 1.1, 0.5)

			local findBox = Instance.new("TextBox", findCard)
			findBox.Size = UDim2.new(1, -76, 1, 0)
			findBox.Position = UDim2.new(0, 12, 0, 0)
			findBox.BackgroundTransparency = 1
			findBox.Font = Z100.Theme.Tokens.Fonts.Body
			findBox.TextSize = 11
			findBox.TextColor3 = themeObj.textColor
			findBox.PlaceholderText = "Search any profile by Username or UserId..."
			findBox.PlaceholderColor3 = themeObj.subText
			findBox.TextXAlignment = Enum.TextXAlignment.Left
			findBox.ClearTextOnFocus = false
			findBox.Text = ""
			findBox.ZIndex = 26

			local goBtn
			local function doLookup()
				local q = findBox.Text:match("^%s*(.-)%s*$") or ""
				if q == "" then return end
				goBtn.Text = "..."
				task.spawn(function()
					local res = Util.ResolveUser(q)
					if goBtn and goBtn.Parent then goBtn.Text = "🔍 GO" end
					if res and res.UserId then
						Z100.Router.OpenProfile(res.UserId)
					else
						Z100.UI.ShowToast("⚠️ Not Found", "No Roblox account matches '" .. q .. "'", Color3.fromRGB(235, 65, 80))
					end
				end)
			end

			goBtn = C.Button(findCard, {
				Size = UDim2.new(0, 62, 0, 26),
				Position = UDim2.new(1, -67, 0.5, -13),
				BackgroundColor3 = themeObj.buttonBg,
				TextColor3 = themeObj.buttonText,
				Text = "🔍 GO",
				TextSize = 10,
				ZIndex = 26,
				OnClick = doLookup,
			})
			findBox.FocusLost:Connect(function(enter) if enter then doLookup() end end)

			-- 2. INSTAGRAM-STYLE ANIMATED HERO CARD (CLEAN IDENTITY)
			local hero = Instance.new("Frame", scroll)
			hero.Name = "InstagramHeroCard"
			hero.Size = UDim2.new(1, 0, 0, 0)
			hero.AutomaticSize = Enum.AutomaticSize.Y
			hero.BackgroundColor3 = themeObj.cardBg
			hero.BorderSizePixel = 0
			hero.LayoutOrder = 2
			hero.ZIndex = 24
			C.Corner(hero, Z100.Theme.Tokens.Radius.LG)
			table.insert(animTargets, hero)

			local hGrad = Instance.new("UIGradient", hero)
			hGrad.Rotation = 135
			hGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)

			-- Full Coordinated Profile Animations (Border, Particles, Sparkles, Shapes, Sweep)
			Z100.Anim.ApplyFullProfileEffects(hero, hGrad, themeObj, isPaidTheme)

			local content = Instance.new("Frame", hero)
			content.Size = UDim2.new(1, 0, 0, 0)
			content.AutomaticSize = Enum.AutomaticSize.Y
			content.BackgroundTransparency = 1
			content.ZIndex = 30
			C.ListLayout(content, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
			C.Padding(content, 16, 16, 16, 16)

			-- Identity Row: Large Avatar + Story Ring + Display Name + @Username + Badges
			local idRow = Instance.new("Frame", content)
			idRow.Size = UDim2.new(1, 0, 0, 88)
			idRow.BackgroundTransparency = 1
			idRow.LayoutOrder = 1
			idRow.ZIndex = 31

			local avHolder = Instance.new("Frame", idRow)
			avHolder.Name = "ProfileAvatarHolder"
			avHolder.Size = UDim2.new(0, 78, 0, 78)
			avHolder.Position = UDim2.new(0, 4, 0.5, -39)
			avHolder.BackgroundColor3 = themeObj.bg1
			avHolder.ZIndex = 32
			C.Corner(avHolder, Z100.Theme.Tokens.Radius.Pill)

			local avBtn = Instance.new("ImageButton", avHolder)
			avBtn.Size = UDim2.new(1, -4, 1, -4)
			avBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
			avBtn.AnchorPoint = Vector2.new(0.5, 0.5)
			avBtn.BackgroundTransparency = 1
			avBtn.ScaleType = Enum.ScaleType.Crop
			avBtn.ZIndex = 33
			C.Corner(avBtn, Z100.Theme.Tokens.Radius.Pill)
			Util.LoadAvatarHeadshot(avBtn, uidStr, prof.customAvatar)

			if prof.decoration and prof.decoration ~= "none" then
				Z100.Anim.ApplyAvatarDecoration(avHolder, prof.decoration, false)
			else
				C.Stroke(avHolder, themeObj.border1, 2.2, 0.08)
			end

			if storyRingState ~= "none" then
				Z100.Anim.ApplyStoryRing(avHolder, storyRingState)
			end

			avBtn.MouseButton1Click:Connect(function()
				if #userStories > 0 and Z100.Stories.OpenViewer then
					Z100.Stories.OpenViewer(uidStr, userStories, 1)
				elseif isMe then
					Z100.Router.Navigate("StoryEditor")
				else
					Z100.UI.ShowToast("◎ No Active Story", "@" .. prof.username .. " has no active 24h story.", themeObj.accent, uidStr)
				end
			end)

			local oDot = Instance.new("Frame", avHolder)
			oDot.Size = UDim2.new(0, 14, 0, 14)
			oDot.Position = UDim2.new(1, -11, 1, -11)
			oDot.BackgroundColor3 = isOnline and Color3.fromRGB(16, 212, 142) or Color3.fromRGB(110, 114, 134)
			oDot.BorderSizePixel = 0
			oDot.ZIndex = 42
			C.Corner(oDot, Z100.Theme.Tokens.Radius.Pill)
			C.Stroke(oDot, themeObj.bg1, 2, 0)

			local textCol = Instance.new("Frame", idRow)
			textCol.Size = UDim2.new(1, -98, 1, 0)
			textCol.Position = UDim2.new(0, 96, 0, 0)
			textCol.BackgroundTransparency = 1
			textCol.ZIndex = 32

			local dispLbl = Instance.new("TextLabel", textCol)
			dispLbl.Size = UDim2.new(1, 0, 0, 26)
			dispLbl.Position = UDim2.new(0, 0, 0, 6)
			dispLbl.BackgroundTransparency = 1
			dispLbl.Font = Z100.Theme.Tokens.Fonts.Heading
			dispLbl.TextSize = 18
			dispLbl.TextXAlignment = Enum.TextXAlignment.Left
			dispLbl.ClipsDescendants = true
			dispLbl.Text = prof.displayName or prof.username
			dispLbl.ZIndex = 33
			if isPaidTheme then
				Z100.Anim.ApplyGradientText(dispLbl, themeObj.accent, themeObj.accent2)
			else
				dispLbl.TextColor3 = themeObj.textColor
			end

			local userLbl = Instance.new("TextLabel", textCol)
			userLbl.Size = UDim2.new(1, 0, 0, 16)
			userLbl.Position = UDim2.new(0, 0, 0, 34)
			userLbl.BackgroundTransparency = 1
			userLbl.Font = Z100.Theme.Tokens.Fonts.Body
			userLbl.TextSize = 11.5
			userLbl.TextColor3 = themeObj.subText
			userLbl.TextXAlignment = Enum.TextXAlignment.Left
			userLbl.ClipsDescendants = true
			userLbl.Text = "@" .. tostring(prof.username) .. (#userStories > 0 and "  •  ◎ Story Active" or "")
			userLbl.ZIndex = 33

			local badgeRow = Instance.new("Frame", textCol)
			badgeRow.Size = UDim2.new(1, 0, 0, 22)
			badgeRow.Position = UDim2.new(0, 0, 0, 56)
			badgeRow.BackgroundTransparency = 1
			badgeRow.ZIndex = 33
			C.ListLayout(badgeRow, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

			if type(prof.badges) == "table" then
				for idx, bKey in ipairs(prof.badges) do
					if idx <= 3 then Z100.Anim.CreateAnimatedBadge(badgeRow, bKey) end
				end
			end

			-- CLICKABLE FOLLOWERS & FOLLOWING COUNTERS (Open Compact Overlay)
			local statsRow = Instance.new("Frame", content)
			statsRow.Size = UDim2.new(1, 0, 0, 48)
			statsRow.BackgroundTransparency = 1
			statsRow.LayoutOrder = 2
			statsRow.ZIndex = 31
			C.ListLayout(statsRow, 8, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

			local function makeCounterBox(lblTxt, countVal, modalTab, ord)
				local box = Instance.new("TextButton", statsRow)
				box.Size = UDim2.new(0.49, 0, 1, 0)
				box.BackgroundColor3 = themeObj.bg1
				box.BackgroundTransparency = 0.22
				box.AutoButtonColor = false
				box.Text = ""
				box.LayoutOrder = ord
				box.ZIndex = 32
				C.Corner(box, Z100.Theme.Tokens.Radius.SM)
				C.Stroke(box, themeObj.border1, 1.2, 0.45)
				C.AttachButtonFeedback(box, 1.03)

				local t = Instance.new("TextLabel", box)
				t.Size = UDim2.new(1, -12, 1, 0)
				t.Position = UDim2.new(0, 6, 0, 0)
				t.BackgroundTransparency = 1
				t.Font = Z100.Theme.Tokens.Fonts.Heading
				t.TextSize = 12
				t.TextColor3 = themeObj.textColor
				t.RichText = true
				t.Text = string.format("<font color='#%s'>%s:</font>  %s",
					themeObj.accent:ToHex(), lblTxt, Util.FormatNumber(countVal))
				t.ZIndex = 33

				box.MouseButton1Click:Connect(function()
					if not canViewLists then
						Z100.UI.ShowToast("🔒 Private List", "This user's connection list is private.", Color3.fromRGB(255, 184, 48), uidStr)
						return
					end
					Z100.UI.OpenFollowModal(uidStr, modalTab)
				end)
			end

			makeCounterBox("FOLLOWERS", followerCnt, "Followers", 1)
			makeCounterBox("FOLLOWING", followingCnt, "Following", 2)

			-- PRIMARY ACTION BUTTONS ROW
			local actRow = Instance.new("Frame", content)
			actRow.Size = UDim2.new(1, 0, 0, 36)
			actRow.BackgroundTransparency = 1
			actRow.LayoutOrder = 3
			actRow.ZIndex = 31
			C.ListLayout(actRow, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

			if isMe then
				C.Button(actRow, {
					Size = UDim2.new(0.34, -4, 1, 0),
					BackgroundColor3 = themeObj.cardBg,
					TextColor3 = themeObj.textColor,
					Text = "✎ Edit Profile",
					TextSize = 10.5,
					LayoutOrder = 1,
					ZIndex = 32,
					OnClick = function() Z100.Router.Navigate("ProfileEditor") end,
				})
				C.Button(actRow, {
					Size = UDim2.new(0.36, -4, 1, 0),
					BackgroundColor3 = themeObj.buttonBg,
					TextColor3 = themeObj.buttonText,
					Text = "♛ Themes & Store",
					TextSize = 10.5,
					LayoutOrder = 2,
					ZIndex = 32,
					OnClick = function() Z100.Router.OpenStore("Themes") end,
				})
				local rCnt = Util.CountKeys(State.Requests)
				C.Button(actRow, {
					Size = UDim2.new(0.28, -4, 1, 0),
					BackgroundColor3 = Color3.fromRGB(48, 42, 78),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = "📩 Reqs (" .. rCnt .. ")",
					TextSize = 10,
					LayoutOrder = 3,
					ZIndex = 32,
					OnClick = function() Z100.UI.OpenFollowModal(uidStr, "Requests") end,
				})
			else
				local fTxt, fBg, fTc = "+ Follow", themeObj.buttonBg, themeObj.buttonText
				if isFollowing then
					fTxt, fBg, fTc = "✓ Following", Color3.fromRGB(54, 52, 76), Color3.fromRGB(242, 244, 255)
				elseif hasPending then
					fTxt, fBg, fTc = "⏳ Requested", Color3.fromRGB(192, 128, 28), Color3.fromRGB(255, 255, 255)
				elseif isFollowedBy then
					fTxt, fBg, fTc = "+ Follow Back", Color3.fromRGB(157, 78, 255), Color3.fromRGB(255, 255, 255)
				end

				local busy = false
				C.Button(actRow, {
					Size = UDim2.new(0.35, -4, 1, 0),
					BackgroundColor3 = fBg,
					TextColor3 = fTc,
					Text = fTxt,
					TextSize = 10.5,
					LayoutOrder = 1,
					ZIndex = 32,
					OnClick = function()
						if busy then return end
						busy = true
						task.spawn(function()
							local ok, msg
							if isFollowing then ok, msg = Backend.UnfollowUser(uidStr)
							elseif hasPending then ok, msg = Backend.CancelFollowRequest(uidStr)
							else ok, msg = Backend.FollowUser(uidStr) end
							Z100.UI.ShowToast(ok and "👥 Social" or "⚠️ Notice", msg, ok and themeObj.accent or Color3.fromRGB(235, 65, 80), uidStr)
							busy = false
							Z100.Router.OpenProfile(uidStr)
						end)
					end,
				})

				C.Button(actRow, {
					Size = UDim2.new(0.30, -4, 1, 0),
					BackgroundColor3 = Color3.fromRGB(16, 172, 122),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = "✉ Message",
					TextSize = 10.5,
					LayoutOrder = 2,
					ZIndex = 32,
					OnClick = function()
						task.spawn(function()
							local ok, reason = Backend.CanMessageUser(uidStr)
							if not ok then
								Z100.UI.ShowToast("🔒 DM Restricted", reason, Color3.fromRGB(235, 65, 80), uidStr)
								return
							end
							Util.RegisterAccount(prof.username, prof.displayName, tonumber(uidStr) or 1)
							local key = prof.username:lower()
							State.Cache.DMs[key] = State.Cache.DMs[key] or {}
							State.ChatSubMode = "DM"
							State.ActiveDM = key
							Z100.Router.Navigate("Messages")
						end)
					end,
				})

				C.Button(actRow, {
					Size = UDim2.new(0.21, -4, 1, 0),
					BackgroundColor3 = isBlocked and Color3.fromRGB(48, 128, 198) or Color3.fromRGB(172, 40, 54),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = isBlocked and "🔓 Unblock" or "🚫 Block",
					TextSize = 9.5,
					LayoutOrder = 3,
					ZIndex = 32,
					OnClick = function()
						task.spawn(function()
							if isBlocked then Backend.UnblockUser(uidStr) else Backend.BlockUser(uidStr) end
							Z100.Router.OpenProfile(uidStr)
						end)
					end,
				})

				C.Button(actRow, {
					Size = UDim2.new(0.12, -2, 1, 0),
					BackgroundColor3 = Color3.fromRGB(78, 42, 58),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = "🚩",
					TextSize = 11,
					LayoutOrder = 4,
					ZIndex = 32,
					OnClick = function()
						C.PromptDialog("🚩 Report @" .. prof.username, "Reason (spam, harassment, impersonation)...", "Submit", function(reason)
							local ok, errMsg = Backend.ReportUser(uidStr, reason)
							Z100.UI.ShowToast(ok and "🛡️ Report Submitted" or "⚠️ Error", ok and "Flagged for ZAYN Moderation." or errMsg, Color3.fromRGB(255, 184, 48), uidStr)
						end)
					end,
				})
			end

			if isBlockedBy then
				local blk = Instance.new("TextLabel", content)
				blk.Size = UDim2.new(1, 0, 0, 20)
				blk.BackgroundTransparency = 1
				blk.Font = Z100.Theme.Tokens.Fonts.Title
				blk.TextSize = 10.5
				blk.TextColor3 = Color3.fromRGB(255, 85, 95)
				blk.Text = "🚫 You cannot interact with this account."
				blk.LayoutOrder = 4
				blk.ZIndex = 32
			end

			-- 3. PROFILE QUICK NAVIGATION STRIP
			local qStrip = Instance.new("Frame", scroll)
			qStrip.Size = UDim2.new(1, 0, 0, 44)
			qStrip.BackgroundColor3 = themeObj.cardBg
			qStrip.BorderSizePixel = 0
			qStrip.LayoutOrder = 3
			qStrip.ZIndex = 25
			C.Corner(qStrip, Z100.Theme.Tokens.Radius.MD)
			C.Stroke(qStrip, themeObj.border1, 1.1, 0.5)
			C.ListLayout(qStrip, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
			table.insert(animTargets, qStrip)

			local qItems = {
				{ Text = "◎ Stories", Fn = function()
					if #userStories > 0 and Z100.Stories.OpenViewer then
						Z100.Stories.OpenViewer(uidStr, userStories, 1)
					else
						Z100.Router.Navigate(isMe and "StoryEditor" or "Stories")
					end
				end },
				{ Text = "♫ Music",   Fn = function() Z100.Router.Navigate("MusicStudio") end },
				{ Text = "✨ Decor",   Fn = function() Z100.Router.OpenStore("Decorations") end },
				{ Text = "🎨 Themes",  Fn = function() Z100.Router.OpenStore("Themes") end },
				{ Text = "♛ Store",   Fn = function() Z100.Router.OpenStore("Bundle") end },
			}

			for i, qi in ipairs(qItems) do
				C.Button(qStrip, {
					Size = UDim2.new(0.188, 0, 0, 30),
					BackgroundColor3 = themeObj.bg1,
					TextColor3 = themeObj.textColor,
					Text = qi.Text,
					TextSize = 9.5,
					LayoutOrder = i,
					ZIndex = 26,
					OnClick = qi.Fn,
				})
			end

			Z100.Anim.PlaySequentialEntrance(scroll, animTargets)
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 10 / 15 : DEDICATED PROFILE EDITOR SCREEN (LIVE PREVIEW & PRIVACY)
-- ========================================================================= --

do
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend

	local editorRenderSeq = 0

	function Z100.Screens.RenderProfileEditor(host)
		if not host or not host.Parent then return end

		editorRenderSeq = editorRenderSeq + 1
		local mySeq = editorRenderSeq
		local p = Z100.Theme.Get()

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_ProfileEditorScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 32)

		local skel = C.LoadingSkeleton(scroll, 4, 68, 1)

		task.spawn(function()
			Backend.FetchEntitlements(Z100.MyUid, true)
			local prof = Backend.FetchProfile(Z100.MyUid, true)
			local blocks = Backend.FetchMyBlocks()

			if editorRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			if not prof then
				C.ErrorState(scroll, "Failed to load your profile data for editing.", function()
					Z100.Router.Navigate("ProfileEditor")
				end, 1)
				return
			end

			if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "EDIT PROFILE" end
			if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Customize identity, cosmetics & privacy" end

			local draft = {
				displayName = prof.displayName or Z100.Player.DisplayName,
				customAvatar = prof.customAvatar or "",
				theme = prof.theme or "default_base",
				decoration = prof.decoration or "none",
				privacy = {
					isPrivate = prof.privacy and prof.privacy.isPrivate == true,
					allowFollows = not (prof.privacy and prof.privacy.allowFollows == false),
					hideLists = prof.privacy and prof.privacy.hideLists == true,
					dmPermission = (prof.privacy and prof.privacy.dmPermission) or "Everyone",
					storyPrivacy = (prof.privacy and prof.privacy.storyPrivacy) or "Public",
				},
			}

			local animTargets = {}

			-- ============================================================= --
			-- 1. LIVE ANIMATED APPEARANCE PREVIEW PANEL
			-- ============================================================= --
			local previewCard = Instance.new("Frame", scroll)
			previewCard.Name = "EditorLivePreview"
			previewCard.Size = UDim2.new(1, 0, 0, 102)
			previewCard.BackgroundColor3 = p.Card
			previewCard.BorderSizePixel = 0
			previewCard.LayoutOrder = 1
			previewCard.ZIndex = 24
			C.Corner(previewCard, Z100.Theme.Tokens.Radius.LG)
			table.insert(animTargets, previewCard)

			local pvGrad = Instance.new("UIGradient", previewCard)
			pvGrad.Rotation = 135

			local pvAvWrap = Instance.new("Frame", previewCard)
			pvAvWrap.Size = UDim2.new(0, 64, 0, 64)
			pvAvWrap.Position = UDim2.new(0, 16, 0.5, -32)
			pvAvWrap.BackgroundColor3 = p.BgRoot
			pvAvWrap.ZIndex = 28
			C.Corner(pvAvWrap, Z100.Theme.Tokens.Radius.Pill)

			local pvImg = Instance.new("ImageLabel", pvAvWrap)
			pvImg.Size = UDim2.new(1, -4, 1, -4)
			pvImg.Position = UDim2.new(0.5, 0, 0.5, 0)
			pvImg.AnchorPoint = Vector2.new(0.5, 0.5)
			pvImg.BackgroundTransparency = 1
			pvImg.ScaleType = Enum.ScaleType.Crop
			pvImg.ZIndex = 29
			C.Corner(pvImg, Z100.Theme.Tokens.Radius.Pill)

			local pvName = Instance.new("TextLabel", previewCard)
			pvName.Size = UDim2.new(1, -104, 0, 24)
			pvName.Position = UDim2.new(0, 94, 0, 18)
			pvName.BackgroundTransparency = 1
			pvName.Font = Z100.Theme.Tokens.Fonts.Heading
			pvName.TextSize = 16
			pvName.TextXAlignment = Enum.TextXAlignment.Left
			pvName.ClipsDescendants = true
			pvName.ZIndex = 28

			local pvMeta = Instance.new("TextLabel", previewCard)
			pvMeta.Size = UDim2.new(1, -104, 0, 36)
			pvMeta.Position = UDim2.new(0, 94, 0, 44)
			pvMeta.BackgroundTransparency = 1
			pvMeta.Font = Z100.Theme.Tokens.Fonts.Body
			pvMeta.TextSize = 10
			pvMeta.TextXAlignment = Enum.TextXAlignment.Left
			pvMeta.TextWrapped = true
			pvMeta.ZIndex = 28

			local function refreshLivePreview()
				local tObj = Z100.Catalog.ResolveProfileTheme(draft.theme)
				local dObj = Z100.Catalog.DecorationMap[draft.decoration]
				previewCard.BackgroundColor3 = tObj.bg1
				pvGrad.Color = ColorSequence.new(tObj.bg1, tObj.bg2)
				Z100.Anim.ApplyFullProfileEffects(previewCard, pvGrad, tObj, tObj.id ~= "default_base")
				Util.LoadAvatarHeadshot(pvImg, Z100.MyUid, draft.customAvatar)
				Z100.Anim.ApplyAvatarDecoration(pvAvWrap, draft.decoration, false)

				pvName.Text = (draft.displayName ~= "" and draft.displayName) or Z100.Player.DisplayName
				if tObj.id ~= "default_base" then
					Z100.Anim.ApplyGradientText(pvName, tObj.accent, tObj.accent2)
				else
					local oldG = pvName:FindFirstChild("V100TextGrad")
					if oldG then oldG:Destroy() end
					pvName.TextColor3 = tObj.textColor
				end

				pvMeta.TextColor3 = tObj.subText
				pvMeta.Text = string.format(
					"@%s (Roblox Identity Locked)\n✨ %s  •  🎨 %s",
					Z100.MyName,
					dObj and dObj.name or "No Decoration",
					tObj.name
				)
			end
			refreshLivePreview()

			-- ============================================================= --
			-- 2. IDENTITY & PROFILE IMAGE SECTION
			-- ============================================================= --
			local idCard = C.Card(scroll, { Name = "EditorIdentityCard", LayoutOrder = 2, ZIndex = 24 })
			table.insert(animTargets, idCard)
			C.SectionHeader(idCard, "◉ Identity & Profile Picture", "Display name & supported Roblox avatar asset", 1)

			C.TextInput(idCard, {
				Placeholder = "Display Name (max " .. tostring(Z100.Config.Limits.DisplayNameMax) .. " chars)...",
				Text = draft.displayName,
				LayoutOrder = 2,
				ZIndex = 25,
				OnChange = function(val)
					draft.displayName = val:sub(1, Z100.Config.Limits.DisplayNameMax)
					refreshLivePreview()
				end,
			})

			local avRow = Instance.new("Frame", idCard)
			avRow.Size = UDim2.new(1, 0, 0, 36)
			avRow.BackgroundTransparency = 1
			avRow.LayoutOrder = 3
			avRow.ZIndex = 25

			local avWrap, avBox = C.TextInput(avRow, {
				Size = UDim2.new(1, -78, 1, 0),
				Placeholder = "Image Asset ID or URL (blank = Roblox Avatar)...",
				Text = draft.customAvatar,
				ZIndex = 26,
				OnSubmit = function(val)
					draft.customAvatar = val:match("^%s*(.-)%s*$") or ""
					refreshLivePreview()
				end,
			})
			avBox.FocusLost:Connect(function()
				draft.customAvatar = avBox.Text:match("^%s*(.-)%s*$") or ""
				refreshLivePreview()
			end)

			C.Button(avRow, {
				Size = UDim2.new(0, 72, 1, 0),
				Position = UDim2.new(1, -72, 0, 0),
				Variant = "secondary",
				Text = "Reset",
				TextSize = 10,
				ZIndex = 26,
				OnClick = function()
					avBox.Text = ""
					draft.customAvatar = ""
					refreshLivePreview()
				end,
			})

			-- ============================================================= --
			-- 3. ACTIVE COSMETICS PICKER (OWNED PAID ITEMS ONLY)
			-- ============================================================= --
			local cosCard = C.Card(scroll, { Name = "EditorCosmeticsCard", LayoutOrder = 3, ZIndex = 24 })
			table.insert(animTargets, cosCard)
			C.SectionHeader(cosCard, "✨ Active Cosmetics", "Switch between your owned paid Decorations & Themes", 1, "Store ›", function()
				Z100.Router.OpenStore("Decorations")
			end)

			local ownedDecors = { { id = "none", name = "None (Default)" } }
			for _, d in ipairs(Z100.Catalog.Decorations) do
				if Backend.OwnsDecoration(Z100.MyUid, d.id) then
					table.insert(ownedDecors, { id = d.id, name = d.name })
				end
			end

			local ownedThemes = { { id = "default_base", name = "Standard Obsidian" } }
			for _, t in ipairs(Z100.Catalog.ProfileThemes) do
				if Backend.OwnsTheme(Z100.MyUid, t.id) then
					table.insert(ownedThemes, { id = t.id, name = t.name })
				end
			end

			local decIdx = 1
			for i, item in ipairs(ownedDecors) do if item.id == draft.decoration then decIdx = i; break end end
			local decBtn
			decBtn = C.Button(cosCard, {
				Variant = "secondary",
				Text = "✨ Avatar Decoration (" .. tostring(#ownedDecors - 1) .. " Owned): " .. ownedDecors[decIdx].name .. "  ▸",
				TextSize = 10.5,
				LayoutOrder = 2,
				ZIndex = 25,
				OnClick = function()
					if #ownedDecors <= 1 then
						Z100.UI.ShowToast("🔒 Paid Cosmetic", "All Avatar Decorations cost ₹300. Opening Paid Store...", p.Gold)
						Z100.Router.OpenStore("Decorations")
						return
					end
					decIdx = (decIdx % #ownedDecors) + 1
					draft.decoration = ownedDecors[decIdx].id
					decBtn.Text = "✨ Avatar Decoration (" .. tostring(#ownedDecors - 1) .. " Owned): " .. ownedDecors[decIdx].name .. "  ▸"
					refreshLivePreview()
				end,
			})

			local thmIdx = 1
			for i, item in ipairs(ownedThemes) do if item.id == draft.theme then thmIdx = i; break end end
			local thmBtn
			thmBtn = C.Button(cosCard, {
				Variant = "secondary",
				Text = "🎨 Profile Theme (" .. tostring(#ownedThemes - 1) .. " Owned): " .. ownedThemes[thmIdx].name .. "  ▸",
				TextSize = 10.5,
				LayoutOrder = 3,
				ZIndex = 25,
				OnClick = function()
					if #ownedThemes <= 1 then
						Z100.UI.ShowToast("🔒 Paid Theme", "All Profile Themes cost ₹300. Opening Paid Store...", p.Gold)
						Z100.Router.OpenStore("Themes")
						return
					end
					thmIdx = (thmIdx % #ownedThemes) + 1
					draft.theme = ownedThemes[thmIdx].id
					thmBtn.Text = "🎨 Profile Theme (" .. tostring(#ownedThemes - 1) .. " Owned): " .. ownedThemes[thmIdx].name .. "  ▸"
					refreshLivePreview()
				end,
			})

			-- ============================================================= --
			-- 4. PRIVACY & STORY VISIBILITY SETTINGS
			-- ============================================================= --
			local privCard = C.Card(scroll, { Name = "EditorPrivacyCard", LayoutOrder = 4, ZIndex = 24 })
			table.insert(animTargets, privCard)
			C.SectionHeader(privCard, "🔒 Privacy & Story Controls", "Manage followers, DMs & default story audience", 1)

			C.ToggleRow(privCard, "Private Account", "Require manual approval for new followers", draft.privacy.isPrivate, 2, function(v)
				draft.privacy.isPrivate = v
			end)
			C.ToggleRow(privCard, "Allow New Followers", "Let other users follow your profile", draft.privacy.allowFollows, 3, function(v)
				draft.privacy.allowFollows = v
			end)
			C.ToggleRow(privCard, "Hide Followers & Following Lists", "Prevent others from opening your lists", draft.privacy.hideLists, 4, function(v)
				draft.privacy.hideLists = v
			end)

			local storyModes = { "Public", "Followers", "Private" }
			local sIdx = 1
			for i, v in ipairs(storyModes) do if v == draft.privacy.storyPrivacy then sIdx = i; break end end
			local stPrivBtn
			stPrivBtn = C.Button(privCard, {
				Variant = "ghost",
				Text = "◎ Default Story Privacy: " .. draft.privacy.storyPrivacy .. "  (Tap to cycle)",
				TextSize = 10.5,
				LayoutOrder = 5,
				ZIndex = 25,
				OnClick = function()
					sIdx = (sIdx % #storyModes) + 1
					draft.privacy.storyPrivacy = storyModes[sIdx]
					stPrivBtn.Text = "◎ Default Story Privacy: " .. draft.privacy.storyPrivacy .. "  (Tap to cycle)"
				end,
			})

			local dmModes = { "Everyone", "Followers", "Mutuals", "None" }
			local dIdx = 1
			for i, v in ipairs(dmModes) do if v == draft.privacy.dmPermission then dIdx = i; break end end
			local dmPrivBtn
			dmPrivBtn = C.Button(privCard, {
				Variant = "ghost",
				Text = "✉ Who Can Message Me: " .. draft.privacy.dmPermission .. "  (Tap to cycle)",
				TextSize = 10.5,
				LayoutOrder = 6,
				ZIndex = 25,
				OnClick = function()
					dIdx = (dIdx % #dmModes) + 1
					draft.privacy.dmPermission = dmModes[dIdx]
					dmPrivBtn.Text = "✉ Who Can Message Me: " .. draft.privacy.dmPermission .. "  (Tap to cycle)"
				end,
			})

			-- ============================================================= --
			-- 5. BLOCKED USERS MANAGER
			-- ============================================================= --
			local blkCard = C.Card(scroll, { Name = "EditorBlockedUsers", LayoutOrder = 5, ZIndex = 24 })
			table.insert(animTargets, blkCard)
			C.SectionHeader(blkCard, "🚫 Blocked Users", "Unblock accounts anytime", 1)

			local blkCount = 0
			for bUid, val in pairs(blocks) do
				if val == true then
					blkCount = blkCount + 1
					local acc = Util.GetAccountByUid(bUid)
					local row = Instance.new("Frame", blkCard)
					row.Size = UDim2.new(1, 0, 0, 36)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = blkCount + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local lbl = Instance.new("TextLabel", row)
					lbl.Size = UDim2.new(1, -92, 1, 0)
					lbl.Position = UDim2.new(0, 10, 0, 0)
					lbl.BackgroundTransparency = 1
					lbl.Font = Z100.Theme.Tokens.Fonts.Body
					lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary
					lbl.TextXAlignment = Enum.TextXAlignment.Left
					lbl.Text = "@" .. acc.Username .. " (UID: " .. tostring(bUid) .. ")"
					lbl.ZIndex = 26

					C.Button(row, {
						Size = UDim2.new(0, 76, 0, 26),
						Position = UDim2.new(1, -82, 0.5, -13),
						Variant = "secondary",
						Text = "Unblock",
						TextSize = 9.5,
						ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								Backend.UnblockUser(bUid)
								Z100.Router.Navigate("ProfileEditor")
							end)
						end,
					})
				end
			end
			if blkCount == 0 then
				local none = Instance.new("TextLabel", blkCard)
				none.Size = UDim2.new(1, 0, 0, 22)
				none.BackgroundTransparency = 1
				none.Font = Z100.Theme.Tokens.Fonts.Body
				none.TextSize = 10.5
				none.TextColor3 = p.TextMuted
				none.TextXAlignment = Enum.TextXAlignment.Left
				none.Text = "You have not blocked any users."
				none.LayoutOrder = 2
				none.ZIndex = 25
			end

			-- ============================================================= --
			-- 6. SAVE & CANCEL FOOTER
			-- ============================================================= --
			local footer = Instance.new("Frame", scroll)
			footer.Size = UDim2.new(1, 0, 0, 38)
			footer.BackgroundTransparency = 1
			footer.LayoutOrder = 6
			footer.ZIndex = 25

			local saveBusy = false
			local saveBtn
			saveBtn = C.Button(footer, {
				Size = UDim2.new(0.54, -4, 1, 0),
				Variant = "success",
				Text = "💾 Save Changes",
				TextSize = 11.5,
				ZIndex = 26,
				OnClick = function()
					if saveBusy then return end
					saveBusy = true
					saveBtn.Text = "◐ Saving..."
					task.spawn(function()
						local ok, msg = Backend.SaveMyProfile(draft)
						saveBusy = false
						if ok then
							Z100.UI.ShowToast("✅ Profile Saved", msg, p.Success, Z100.MyUid)
							Z100.Router.OpenProfile(Z100.MyUid)
						else
							if saveBtn and saveBtn.Parent then saveBtn.Text = "💾 Save Changes" end
							Z100.UI.ShowToast("⚠️ Save Failed", tostring(msg), p.Danger, Z100.MyUid)
						end
					end)
				end,
			})

			C.Button(footer, {
				Size = UDim2.new(0.46, -4, 1, 0),
				Position = UDim2.new(0.54, 4, 0, 0),
				Variant = "secondary",
				Text = "✕ Cancel",
				TextSize = 11.5,
				ZIndex = 26,
				OnClick = function()
					Z100.Router.OpenProfile(Z100.MyUid)
				end,
			})

			Z100.Anim.PlaySequentialEntrance(scroll, animTargets)
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 11 / 15 : STORIES FEED, STORY EDITOR & FULL-SCREEN STORY VIEWER
-- ========================================================================= --

do
	local Lighting = Z100.Services.Lighting
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend

	local storiesFeedSeq = 0
	local storyEditorSeq = 0
	local viewerSessionSeq = 0

	-- ===================================================================== --
	-- [SECTION A : STORIES FEED & MY ACTIVE STORIES MANAGER]
	-- ===================================================================== --
	function Z100.Screens.RenderStories(host)
		if not host or not host.Parent then return end

		storiesFeedSeq = storiesFeedSeq + 1
		local mySeq = storiesFeedSeq
		local p = Z100.Theme.Get()

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "STORIES" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "24-hour photo & online music stories" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_StoriesScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 22, 14)
		C.AttachAutoCanvas(scroll, list, 28)

		-- Top Action Row
		local topRow = Instance.new("Frame", scroll)
		topRow.Size = UDim2.new(1, 0, 0, 38)
		topRow.BackgroundTransparency = 1
		topRow.LayoutOrder = 1
		topRow.ZIndex = 24

		C.Button(topRow, {
			Size = UDim2.new(0.72, -4, 1, 0),
			Variant = "primary",
			Text = "➕ Create New Photo Story (24h)",
			TextSize = 11.5,
			ZIndex = 25,
			OnClick = function() Z100.Router.Navigate("StoryEditor") end,
		})

		C.Button(topRow, {
			Size = UDim2.new(0.28, -2, 1, 0),
			Position = UDim2.new(0.72, 4, 0, 0),
			Variant = "secondary",
			Text = "🔄 Refresh",
			TextSize = 10.5,
			ZIndex = 25,
			OnClick = function() Z100.Router.Navigate("Stories") end,
		})

		local skel = C.LoadingSkeleton(scroll, 3, 74, 2)

		task.spawn(function()
			local buckets, myStories = Backend.FetchStoriesFeed()

			if storiesFeedSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			local animTargets = {}

			-- 1. Active Stories Ring Tray
			local trayCard = C.Card(scroll, {
				Name = "StoriesActiveTray",
				LayoutOrder = 2,
				PadY = 10,
				PadX = 12,
				ListGap = 6,
				ZIndex = 24,
			})
			table.insert(animTargets, trayCard)

			C.SectionHeader(trayCard, "◎ Active Stories (" .. tostring(#buckets) .. ")", "Tap any glowing ring to watch", 1)

			if #buckets == 0 then
				C.EmptyState(trayCard, "◎", "No Active Stories", "Be the first to share a 24-hour photo & music story!", "➕ Create Story", function()
					Z100.Router.Navigate("StoryEditor")
				end, 2)
			else
				local hScroll = Instance.new("ScrollingFrame", trayCard)
				hScroll.Size = UDim2.new(1, 0, 0, 84)
				hScroll.BackgroundTransparency = 1
				hScroll.ScrollBarThickness = 2
				hScroll.ScrollBarImageColor3 = p.Accent
				hScroll.ScrollingDirection = Enum.ScrollingDirection.X
				hScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
				hScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				hScroll.LayoutOrder = 2
				hScroll.ZIndex = 25
				C.ListLayout(hScroll, 10, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
				C.Padding(hScroll, 2, 4, 2, 4)

				for idx, bucket in ipairs(buckets) do
					local acc = Util.GetAccountByUid(bucket.uid)
					local prof = State.Profiles[bucket.uid]

					local item = Instance.new("TextButton", hScroll)
					item.Size = UDim2.new(0, 68, 0, 76)
					item.BackgroundTransparency = 1
					item.Text = ""
					item.LayoutOrder = idx
					item.ZIndex = 26
					C.AttachButtonFeedback(item, 1.06)

					local avHold = Instance.new("Frame", item)
					avHold.Size = UDim2.new(0, 50, 0, 50)
					avHold.Position = UDim2.new(0.5, -25, 0, 4)
					avHold.BackgroundColor3 = p.BgRoot
					avHold.ZIndex = 27
					C.Corner(avHold, Z100.Theme.Tokens.Radius.Pill)

					local img = Instance.new("ImageLabel", avHold)
					img.Size = UDim2.new(1, -4, 1, -4)
					img.Position = UDim2.new(0.5, 0, 0.5, 0)
					img.AnchorPoint = Vector2.new(0.5, 0.5)
					img.BackgroundTransparency = 1
					img.ScaleType = Enum.ScaleType.Crop
					img.ZIndex = 28
					C.Corner(img, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(img, bucket.uid, prof and prof.customAvatar)
					Z100.Anim.ApplyStoryRing(avHold, bucket.ring)

					local uLbl = Instance.new("TextLabel", item)
					uLbl.Size = UDim2.new(1, 0, 0, 14)
					uLbl.Position = UDim2.new(0, 0, 1, -15)
					uLbl.BackgroundTransparency = 1
					uLbl.Font = Z100.Theme.Tokens.Fonts.Title
					uLbl.TextSize = 9.5
					uLbl.TextColor3 = p.TextPrimary
					uLbl.ClipsDescendants = true
					uLbl.Text = (bucket.uid == Z100.MyUid) and "Your Story" or acc.DisplayName
					uLbl.ZIndex = 27

					item.MouseButton1Click:Connect(function()
						Z100.Stories.OpenViewer(bucket.uid, bucket.stories, 1)
					end)
				end
			end

			-- 2. My Active Stories Manager
			local myCard = C.Card(scroll, {
				Name = "MyActiveStoriesCard",
				LayoutOrder = 3,
				ZIndex = 24,
			})
			table.insert(animTargets, myCard)

			C.SectionHeader(myCard, "🎞️ My Active Stories (" .. tostring(#myStories) .. ")", "Automatically expire after 24 hours", 1)

			if #myStories == 0 then
				local em = Instance.new("TextLabel", myCard)
				em.Size = UDim2.new(1, 0, 0, 28)
				em.BackgroundTransparency = 1
				em.Font = Z100.Theme.Tokens.Fonts.Body
				em.TextSize = 10.5
				em.TextColor3 = p.TextMuted
				em.TextXAlignment = Enum.TextXAlignment.Left
				em.Text = "You have no active stories in the last 24 hours."
				em.LayoutOrder = 2
				em.ZIndex = 25
			else
				for idx, st in ipairs(myStories) do
					local row = Instance.new("Frame", myCard)
					row.Size = UDim2.new(1, 0, 0, 58)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = idx + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local thumb = Instance.new("ImageLabel", row)
					thumb.Size = UDim2.new(0, 44, 0, 44)
					thumb.Position = UDim2.new(0, 7, 0.5, -22)
					thumb.BackgroundColor3 = p.BgRoot
					thumb.ScaleType = Enum.ScaleType.Crop
					thumb.ZIndex = 26
					C.Corner(thumb, Z100.Theme.Tokens.Radius.SM)
					Util.LoadImageSafe(thumb, st.imageRef)

					local info = Instance.new("TextLabel", row)
					info.Size = UDim2.new(1, -172, 1, -8)
					info.Position = UDim2.new(0, 58, 0, 4)
					info.BackgroundTransparency = 1
					info.Font = Z100.Theme.Tokens.Fonts.Body
					info.TextSize = 10.5
					info.TextColor3 = p.TextPrimary
					info.TextXAlignment = Enum.TextXAlignment.Left
					info.TextWrapped = true
					info.RichText = true
					info.ZIndex = 26
					local cap = (st.caption and st.caption ~= "") and st.caption:sub(1, 34) or "Photo Story"
					local musTag = (type(st.music) == "table" and st.music.title) and (" • ♫ " .. tostring(st.music.title):sub(1, 18)) or ""
					info.Text = string.format("<b>%s</b>\n<font color='#%s' size='9.5'>%s • %s%s</font>",
						Util.EscapeRichText(cap),
						p.TextSecondary:ToHex(),
						tostring(st.privacy or "Public"),
						Util.TimeAgo(st.createdAt),
						Util.EscapeRichText(musTag))

					C.Button(row, {
						Size = UDim2.new(0, 56, 0, 28),
						Position = UDim2.new(1, -104, 0.5, -14),
						Variant = "primary",
						Text = "👁 View",
						TextSize = 9.5,
						ZIndex = 26,
						OnClick = function() Z100.Stories.OpenViewer(Z100.MyUid, myStories, idx) end,
					})

					C.Button(row, {
						Size = UDim2.new(0, 38, 0, 28),
						Position = UDim2.new(1, -44, 0.5, -14),
						Variant = "danger",
						Text = "🗑",
						TextSize = 11,
						ZIndex = 26,
						OnClick = function()
							C.ConfirmDialog("Delete Story", "Permanently delete this active story?", "Delete", "danger", function()
								local ok, msg = Backend.DeleteStory(Z100.MyUid, st.id)
								Z100.UI.ShowToast(ok and "🗑 Deleted" or "⚠️ Error", msg, p.Danger)
								Z100.Router.Navigate("Stories")
							end)
						end,
					})
				end
			end

			Z100.Anim.PlaySequentialEntrance(scroll, animTargets)
		end)
	end

	-- ===================================================================== --
	-- [SECTION B : STORY CREATION EDITOR WITH LIVE PREVIEW & ONLINE MUSIC]
	-- ===================================================================== --
	function Z100.Screens.RenderStoryEditor(host)
		if not host or not host.Parent then return end

		storyEditorSeq = storyEditorSeq + 1
		Z100.Music.StopAudio("ZaynV100_StoryAudio")
		local p = Z100.Theme.Get()

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "CREATE STORY" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Design your 24h photo & music story" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_StoryEditorScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		local prof = State.Profiles[Z100.MyUid]
		local defaultPriv = (prof and prof.privacy and prof.privacy.storyPrivacy) or "Public"

		local draft = {
			imageRef = "",
			caption = "",
			overlayText = "",
			sticker = "",
			bgHex = "obsidian",
			privacy = defaultPriv,
			music = Z100.Stories.DraftMusic,
		}

		-- 1. LIVE STORY PREVIEW CANVAS
		local pvCard = C.Card(scroll, {
			Name = "StoryLivePreviewWrap",
			LayoutOrder = 1,
			FixedHeight = true,
			Size = UDim2.new(1, 0, 0, 234),
			StrokeColor = p.BorderGlow,
			Padding = false,
			UseList = false,
			ZIndex = 24,
		})

		local canvas = Instance.new("Frame", pvCard)
		canvas.Size = UDim2.new(0, 156, 0, 216)
		canvas.Position = UDim2.new(0.5, 0, 0.5, 0)
		canvas.AnchorPoint = Vector2.new(0.5, 0.5)
		canvas.BackgroundColor3 = Z100.Stories.Backgrounds[1].c1
		canvas.ClipsDescendants = true
		canvas.ZIndex = 25
		C.Corner(canvas, Z100.Theme.Tokens.Radius.MD)

		local pvGrad = Instance.new("UIGradient", canvas)
		pvGrad.Rotation = 135
		pvGrad.Color = ColorSequence.new(Z100.Stories.Backgrounds[1].c1, Z100.Stories.Backgrounds[1].c2)

		local pvImg = Instance.new("ImageLabel", canvas)
		pvImg.Size = UDim2.new(1, 0, 1, 0)
		pvImg.BackgroundTransparency = 1
		pvImg.ScaleType = Enum.ScaleType.Crop
		pvImg.Image = ""
		pvImg.ZIndex = 26

		local pvHint = Instance.new("TextLabel", canvas)
		pvHint.Size = UDim2.new(1, -16, 0, 48)
		pvHint.Position = UDim2.new(0, 8, 0.5, -24)
		pvHint.BackgroundTransparency = 1
		pvHint.Font = Z100.Theme.Tokens.Fonts.Title
		pvHint.TextSize = 10.5
		pvHint.TextColor3 = p.TextSecondary
		pvHint.TextWrapped = true
		pvHint.Text = "◎ Live Story Preview\nPaste Asset ID or Image URL below"
		pvHint.ZIndex = 27

		local pvSticker = Instance.new("TextLabel", canvas)
		pvSticker.Size = UDim2.new(0, 44, 0, 44)
		pvSticker.Position = UDim2.new(1, -50, 0, 10)
		pvSticker.BackgroundTransparency = 1
		pvSticker.Font = Z100.Theme.Tokens.Fonts.Heading
		pvSticker.TextSize = 28
		pvSticker.Text = ""
		pvSticker.ZIndex = 28

		local pvOverlay = Instance.new("TextLabel", canvas)
		pvOverlay.Size = UDim2.new(1, -14, 0, 32)
		pvOverlay.Position = UDim2.new(0, 7, 0.46, -16)
		pvOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		pvOverlay.BackgroundTransparency = 1
		pvOverlay.Font = Z100.Theme.Tokens.Fonts.Heading
		pvOverlay.TextSize = 12
		pvOverlay.TextColor3 = Color3.fromRGB(255, 255, 255)
		pvOverlay.TextWrapped = true
		pvOverlay.Text = ""
		pvOverlay.ZIndex = 28
		C.Corner(pvOverlay, Z100.Theme.Tokens.Radius.XS)

		local pvMusicPill = Instance.new("TextLabel", canvas)
		pvMusicPill.Size = UDim2.new(1, -14, 0, 20)
		pvMusicPill.Position = UDim2.new(0, 7, 0, 8)
		pvMusicPill.BackgroundColor3 = Color3.fromRGB(10, 14, 24)
		pvMusicPill.BackgroundTransparency = 0.22
		pvMusicPill.Font = Z100.Theme.Tokens.Fonts.Title
		pvMusicPill.TextSize = 9
		pvMusicPill.TextColor3 = Color3.fromRGB(0, 240, 195)
		pvMusicPill.ClipsDescendants = true
		pvMusicPill.Visible = false
		pvMusicPill.ZIndex = 28
		C.Corner(pvMusicPill, Z100.Theme.Tokens.Radius.Pill)

		local pvCaption = Instance.new("TextLabel", canvas)
		pvCaption.Size = UDim2.new(1, -12, 0, 34)
		pvCaption.Position = UDim2.new(0, 6, 1, -38)
		pvCaption.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		pvCaption.BackgroundTransparency = 0.42
		pvCaption.Font = Z100.Theme.Tokens.Fonts.Body
		pvCaption.TextSize = 9.5
		pvCaption.TextColor3 = Color3.fromRGB(255, 255, 255)
		pvCaption.TextWrapped = true
		pvCaption.Visible = false
		pvCaption.ZIndex = 28
		C.Corner(pvCaption, Z100.Theme.Tokens.Radius.XS)

		local function syncPreview()
			local bgObj = Z100.Stories.BackgroundMap[draft.bgHex] or Z100.Stories.Backgrounds[1]
			canvas.BackgroundColor3 = bgObj.c1
			pvGrad.Color = ColorSequence.new(bgObj.c1, bgObj.c2)

			if draft.imageRef ~= "" then
				pvHint.Visible = false
				Util.LoadImageSafe(pvImg, draft.imageRef)
			else
				pvImg.Image = ""
				pvHint.Visible = true
			end

			pvOverlay.Text = draft.overlayText
			pvOverlay.BackgroundTransparency = (draft.overlayText ~= "") and 0.45 or 1
			pvSticker.Text = draft.sticker
			pvCaption.Text = draft.caption
			pvCaption.Visible = (draft.caption ~= "")

			if type(draft.music) == "table" and tostring(draft.music.videoId or "") ~= "" then
				pvMusicPill.Visible = true
				pvMusicPill.Text = "♫ " .. tostring(draft.music.title or "Track"):sub(1, 20)
			else
				pvMusicPill.Visible = false
			end
		end
		syncPreview()

		-- 2. EDITOR CONTROLS CARD
		local ctrl = C.Card(scroll, { Name = "StoryEditorControls", LayoutOrder = 2, ZIndex = 24 })

		C.TextInput(ctrl, {
			Placeholder = "🖼️ Photo: Roblox Image Asset ID or direct image URL...",
			LayoutOrder = 1,
			ZIndex = 25,
			OnChange = function(v)
				draft.imageRef = v:gsub("^%s+", ""):gsub("%s+$", "")
				syncPreview()
			end,
		})

		C.TextInput(ctrl, {
			Placeholder = "✍️ Caption (optional, max 160 chars)...",
			LayoutOrder = 2,
			ZIndex = 25,
			OnChange = function(v)
				draft.caption = v:sub(1, Z100.Config.Limits.StoryCaptionMax)
				syncPreview()
			end,
		})

		C.TextInput(ctrl, {
			Placeholder = "🔤 Center Text Overlay (optional, max 80 chars)...",
			LayoutOrder = 3,
			ZIndex = 25,
			OnChange = function(v)
				draft.overlayText = v:sub(1, Z100.Config.Limits.StoryOverlayMax)
				syncPreview()
			end,
		})

		-- Stickers Strip
		local stkScroll = Instance.new("ScrollingFrame", ctrl)
		stkScroll.Size = UDim2.new(1, 0, 0, 32)
		stkScroll.BackgroundTransparency = 1
		stkScroll.ScrollBarThickness = 0
		stkScroll.ScrollingDirection = Enum.ScrollingDirection.X
		stkScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
		stkScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		stkScroll.LayoutOrder = 4
		stkScroll.ZIndex = 25
		C.ListLayout(stkScroll, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

		for idx, em in ipairs(Z100.Stories.QuickStickers) do
			C.Button(stkScroll, {
				Size = UDim2.new(0, 30, 0, 28),
				Variant = "secondary",
				Text = em == "" and "Off" or em,
				TextSize = em == "" and 9 or 13,
				LayoutOrder = idx,
				ZIndex = 26,
				OnClick = function()
					draft.sticker = em
					syncPreview()
				end,
			})
		end

		-- Background Swatches Row
		local bgRow = Instance.new("Frame", ctrl)
		bgRow.Size = UDim2.new(1, 0, 0, 30)
		bgRow.BackgroundTransparency = 1
		bgRow.LayoutOrder = 5
		bgRow.ZIndex = 25
		C.ListLayout(bgRow, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

		for idx, bgObj in ipairs(Z100.Stories.Backgrounds) do
			local sw = Instance.new("TextButton", bgRow)
			sw.Size = UDim2.new(0.158, 0, 1, 0)
			sw.BackgroundColor3 = bgObj.c2
			sw.AutoButtonColor = false
			sw.Font = Z100.Theme.Tokens.Fonts.Title
			sw.TextSize = 8.5
			sw.TextColor3 = Color3.fromRGB(255, 255, 255)
			sw.Text = bgObj.name
			sw.LayoutOrder = idx
			sw.ZIndex = 26
			C.Corner(sw, Z100.Theme.Tokens.Radius.XS)
			local g = Instance.new("UIGradient", sw)
			g.Color = ColorSequence.new(bgObj.c1, bgObj.c2)
			sw.MouseButton1Click:Connect(function()
				draft.bgHex = bgObj.id
				syncPreview()
			end)
		end

		-- Online Music Studio Attachment Box (Gated behind ₹1500 Music Studio Pass)
		local musicBox = C.Card(ctrl, {
			Name = "StoryMusicAttachment",
			LayoutOrder = 6,
			BackgroundColor3 = p.SurfaceElev,
			StrokeColor = Color3.fromRGB(0, 210, 175),
			PadY = 8,
			PadX = 10,
			ListGap = 6,
			ZIndex = 25,
		})

		local mLbl = Instance.new("TextLabel", musicBox)
		mLbl.Size = UDim2.new(1, 0, 0, 18)
		mLbl.BackgroundTransparency = 1
		mLbl.Font = Z100.Theme.Tokens.Fonts.Title
		mLbl.TextSize = 10
		mLbl.TextColor3 = Color3.fromRGB(0, 238, 195)
		mLbl.TextXAlignment = Enum.TextXAlignment.Left
		mLbl.ClipsDescendants = true
		mLbl.LayoutOrder = 1
		mLbl.ZIndex = 26

		local function updateMusicLbl()
			local hasPass = Backend.HasMusicStudioPass(Z100.MyUid)
			if not hasPass then
				mLbl.Text = "🔒 Story Music Locked — ₹" .. tostring(Backend.GetMusicPassPrice()) .. " Music Studio Pass Required"
			elseif type(draft.music) == "table" and tostring(draft.music.videoId or "") ~= "" then
				mLbl.Text = string.format("♫ %s  (Start: %ds • Vol: %d%%)",
					tostring(draft.music.title):sub(1, 24),
					math.floor(draft.music.startTime or 0),
					math.floor((draft.music.volume or 0.7) * 100))
			else
				mLbl.Text = "♫ Story Music: None selected (Unlocked ✅)"
			end
		end
		updateMusicLbl()

		local mBtnRow = Instance.new("Frame", musicBox)
		mBtnRow.Size = UDim2.new(1, 0, 0, 30)
		mBtnRow.BackgroundTransparency = 1
		mBtnRow.LayoutOrder = 2
		mBtnRow.ZIndex = 26
		C.ListLayout(mBtnRow, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

		C.Button(mBtnRow, {
			Size = UDim2.new(0.35, -3, 1, 0),
			Variant = "success",
			Text = "♫ Pick Song",
			TextSize = 9.5,
			LayoutOrder = 1,
			ZIndex = 27,
			OnClick = function()
				if not Backend.HasMusicStudioPass(Z100.MyUid) then
					Z100.UI.ShowToast("🔒 Paid Feature (₹" .. tostring(Backend.GetMusicPassPrice()) .. ")",
						"Unlock Music Studio Pro in Paid Store to attach online music.", p.Gold)
					Z100.Router.OpenStore("MusicPass")
					return
				end
				task.spawn(function()
					local tracks = Backend.FetchMyMusicLibrary(true)
					if #tracks == 0 then
						Z100.UI.ShowToast("♫ My Music Empty", "Search & save a song in Online Music Studio first!", p.Info)
						Z100.Router.Navigate("MusicStudio")
						return
					end
					local modal = C.OpenModal({
						Name = "ZaynV100_TrackPicker",
						Title = "♫ Select Song From My Music",
						Width = 370,
						FixedHeight = 290,
						AccentColor = Color3.fromRGB(0, 235, 195),
						UseList = false,
					})
					if not modal then return end
					local sc = Instance.new("ScrollingFrame", modal.Body)
					sc.Size = UDim2.new(1, 0, 1, 0)
					sc.BackgroundTransparency = 1
					sc.BorderSizePixel = 0
					sc.ScrollBarThickness = 2
					sc.ZIndex = modal.Body.ZIndex + 1
					local sl = C.ListLayout(sc, 6)
					C.AttachAutoCanvas(sc, sl, 10)

					for idx, tr in ipairs(tracks) do
						C.Button(sc, {
							Size = UDim2.new(1, -4, 0, 38),
							Variant = "secondary",
							Text = "♫ " .. tostring(tr.title):sub(1, 28) .. " — " .. tostring(tr.artist or "YouTube"):sub(1, 16),
							TextSize = 10,
							LayoutOrder = idx,
							ZIndex = sc.ZIndex + 1,
							OnClick = function()
								draft.music = {
									videoId = tr.videoId,
									title = tr.title,
									artist = tr.artist,
									duration = tr.duration,
									thumbnail = tr.thumbnail,
									startTime = tr.startTime or 0,
									volume = tr.volume or 0.7,
								}
								Z100.Stories.SetDraftMusic(draft.music)
								updateMusicLbl()
								syncPreview()
								modal.Close()
							end,
						})
					end
				end)
			end,
		})

		C.Button(mBtnRow, {
			Size = UDim2.new(0.24, -3, 1, 0),
			Variant = "primary",
			Text = "🎧 Test",
			TextSize = 9.5,
			LayoutOrder = 2,
			ZIndex = 27,
			OnClick = function()
				if type(draft.music) == "table" and tostring(draft.music.videoId or "") ~= "" then
					Z100.Music.PlayOnlineTrack(draft.music, "ZaynV100_StoryAudio", function(st, detail)
						if not mLbl or not mLbl.Parent then return end
						if st == "loading" then mLbl.Text = "◐ " .. tostring(detail)
						elseif st == "error" then mLbl.Text = "⚠️ " .. tostring(detail)
						elseif st == "playing" then mLbl.Text = "🔊 Playing: " .. tostring(draft.music.title):sub(1, 26) end
					end)
				else
					Z100.UI.ShowToast("🔇 No Song", "Select a saved song first.", p.TextMuted)
				end
			end,
		})

		C.Button(mBtnRow, {
			Size = UDim2.new(0.20, -3, 1, 0),
			Variant = "secondary",
			Text = "🔊 Vol",
			TextSize = 9.5,
			LayoutOrder = 3,
			ZIndex = 27,
			OnClick = function()
				if type(draft.music) ~= "table" then return end
				local vols = { 0.35, 0.7, 0.9, 1.0 }
				local cur = draft.music.volume or 0.7
				local nextV = vols[1]
				for idx, v in ipairs(vols) do
					if math.abs(v - cur) < 0.08 then nextV = vols[(idx % #vols) + 1]; break end
				end
				draft.music.volume = nextV
				updateMusicLbl()
			end,
		})

		C.Button(mBtnRow, {
			Size = UDim2.new(0.20, -3, 1, 0),
			Variant = "danger",
			Text = "✕ Clear",
			TextSize = 9.5,
			LayoutOrder = 4,
			ZIndex = 27,
			OnClick = function()
				Z100.Music.StopAudio("ZaynV100_StoryAudio")
				draft.music = nil
				Z100.Stories.SetDraftMusic(nil)
				updateMusicLbl()
				syncPreview()
			end,
		})

		-- Privacy Selector + Publish Button
		local privModes = { "Public", "Followers", "Private" }
		local pIdx = 1
		for i, v in ipairs(privModes) do if v == draft.privacy then pIdx = i; break end end

		local privBtn
		privBtn = C.Button(ctrl, {
			Variant = "ghost",
			Text = "🔒 Story Privacy: " .. draft.privacy .. "  (Tap to switch)",
			TextSize = 10.5,
			LayoutOrder = 7,
			ZIndex = 25,
			OnClick = function()
				pIdx = (pIdx % #privModes) + 1
				draft.privacy = privModes[pIdx]
				privBtn.Text = "🔒 Story Privacy: " .. draft.privacy .. "  (Tap to switch)"
			end,
		})

		local pubBusy = false
		local pubBtn
		pubBtn = C.Button(ctrl, {
			Height = 40,
			Variant = "success",
			Text = "🚀 PUBLISH STORY (24H LIVE)",
			TextSize = 12,
			LayoutOrder = 8,
			ZIndex = 25,
			OnClick = function()
				if pubBusy then return end
				pubBusy = true
				pubBtn.Text = "◐ Publishing..."
				Z100.Music.StopAudio("ZaynV100_StoryAudio")
				task.spawn(function()
					local ok, res = Backend.PublishStory(draft)
					pubBusy = false
					if ok then
						Z100.Stories.SetDraftMusic(nil)
						Z100.UI.ShowToast("◎ Story Published!", "Your 24-hour photo story is now live!", p.Success, Z100.MyUid)
						Z100.Router.Navigate("Stories")
					else
						if pubBtn and pubBtn.Parent then pubBtn.Text = "🚀 PUBLISH STORY (24H LIVE)" end
						Z100.UI.ShowToast("⚠️ Publish Failed", tostring(res), p.Danger)
					end
				end)
			end,
		})
	end

	-- ===================================================================== --
	-- [SECTION C : FULL-SCREEN INSTAGRAM STORY VIEWER]
	-- ===================================================================== --
	function Z100.Stories.CloseViewer()
		viewerSessionSeq = viewerSessionSeq + 1
		Z100.Music.StopAudio("ZaynV100_StoryAudio")
		if Z100.Stories._progressAnimId then
			Z100.Anim.Unregister(Z100.Stories._progressAnimId)
			Z100.Stories._progressAnimId = nil
		end
		if Lighting:FindFirstChild("ZaynV100_Blur") then
			Lighting.ZaynV100_Blur:Destroy()
		end
		local old = Z100.UI.ScreenGui and Z100.UI.ScreenGui:FindFirstChild("ZaynV100_StoryViewer")
		if old then old:Destroy() end
	end

	function Z100.Stories.OpenViewer(ownerUid, storiesList, startIndex)
		if type(storiesList) ~= "table" or #storiesList == 0 then return end
		Z100.Stories.CloseViewer()

		local p = Z100.Theme.Get()
		local mySession = viewerSessionSeq
		local uidStr = tostring(ownerUid)
		local isOwner = (uidStr == Z100.MyUid)
		local canModerate = isOwner or Util.IsAdmin()
		local curIdx = math.clamp(tonumber(startIndex) or 1, 1, #storiesList)
		local paused = false
		local storyStartClock = os.clock()
		local STORY_DURATION = 8.0

		local blur = Instance.new("BlurEffect", Lighting)
		blur.Name = "ZaynV100_Blur"
		blur.Size = 18

		local overlay = Instance.new("Frame", Z100.UI.ScreenGui)
		overlay.Name = "ZaynV100_StoryViewer"
		overlay.Size = UDim2.new(1, 0, 1, 0)
		overlay.BackgroundColor3 = Color3.fromRGB(4, 4, 8)
		overlay.BackgroundTransparency = 0.14
		overlay.Active = true
		overlay.ZIndex = 1600

		local vp = Z100.UI.GetViewportSize()
		local cardH = math.clamp(math.floor(vp.Y * 0.85), 390, 640)
		local cardW = math.clamp(math.floor(cardH * 0.58), 280, 390)

		local frame = Instance.new("Frame", overlay)
		frame.Size = UDim2.new(0, cardW, 0, cardH)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
		frame.ClipsDescendants = true
		frame.ZIndex = 1602
		C.Corner(frame, Z100.Theme.Tokens.Radius.XL)
		C.Stroke(frame, p.BorderGlow, 1.8, 0.1)

		local bgGrad = Instance.new("UIGradient", frame)
		bgGrad.Rotation = 135

		local photo = Instance.new("ImageLabel", frame)
		photo.Size = UDim2.new(1, 0, 1, 0)
		photo.BackgroundTransparency = 1
		photo.ScaleType = Enum.ScaleType.Crop
		photo.ZIndex = 1603

		local topScrim = Instance.new("Frame", frame)
		topScrim.Size = UDim2.new(1, 0, 0, 96)
		topScrim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		topScrim.BorderSizePixel = 0
		topScrim.ZIndex = 1604
		local tsG = Instance.new("UIGradient", topScrim)
		tsG.Rotation = 90
		tsG.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1) })

		local botScrim = Instance.new("Frame", frame)
		botScrim.Size = UDim2.new(1, 0, 0, 150)
		botScrim.Position = UDim2.new(0, 0, 1, -150)
		botScrim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		botScrim.BorderSizePixel = 0
		botScrim.ZIndex = 1604
		local bsG = Instance.new("UIGradient", botScrim)
		bsG.Rotation = 90
		bsG.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.12) })

		-- Segmented Progress Bar
		local progRow = Instance.new("Frame", frame)
		progRow.Size = UDim2.new(1, -20, 0, 4)
		progRow.Position = UDim2.new(0, 10, 0, 10)
		progRow.BackgroundTransparency = 1
		progRow.ZIndex = 1608
		C.ListLayout(progRow, 4, Enum.FillDirection.Horizontal)

		local progFills = {}
		local segW = 1 / #storiesList
		for i = 1, #storiesList do
			local track = Instance.new("Frame", progRow)
			track.Size = UDim2.new(segW, -3, 1, 0)
			track.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			track.BackgroundTransparency = 0.65
			track.BorderSizePixel = 0
			track.ZIndex = 1608
			C.Corner(track, Z100.Theme.Tokens.Radius.Pill)

			local fill = Instance.new("Frame", track)
			fill.Size = UDim2.new(0, 0, 1, 0)
			fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			fill.BorderSizePixel = 0
			fill.ZIndex = 1609
			C.Corner(fill, Z100.Theme.Tokens.Radius.Pill)
			progFills[i] = fill
		end

		-- Owner Header (Tap -> Opens Owner Profile)
		local ownerBtn = Instance.new("TextButton", frame)
		ownerBtn.Size = UDim2.new(1, -110, 0, 38)
		ownerBtn.Position = UDim2.new(0, 10, 0, 20)
		ownerBtn.BackgroundTransparency = 1
		ownerBtn.Text = ""
		ownerBtn.ZIndex = 1610
		ownerBtn.MouseButton1Click:Connect(function()
			Z100.Stories.CloseViewer()
			Z100.Router.OpenProfile(uidStr)
		end)

		local oAv = Instance.new("ImageLabel", ownerBtn)
		oAv.Size = UDim2.new(0, 34, 0, 34)
		oAv.Position = UDim2.new(0, 0, 0.5, -17)
		oAv.BackgroundTransparency = 1
		oAv.ScaleType = Enum.ScaleType.Crop
		oAv.ZIndex = 1611
		C.Corner(oAv, Z100.Theme.Tokens.Radius.Pill)

		local oAcc = Util.GetAccountByUid(uidStr)
		local oProf = State.Profiles[uidStr]
		Util.LoadAvatarHeadshot(oAv, uidStr, oProf and oProf.customAvatar)

		local oTxt = Instance.new("TextLabel", ownerBtn)
		oTxt.Size = UDim2.new(1, -42, 1, 0)
		oTxt.Position = UDim2.new(0, 42, 0, 0)
		oTxt.BackgroundTransparency = 1
		oTxt.Font = Z100.Theme.Tokens.Fonts.Title
		oTxt.TextSize = 11
		oTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
		oTxt.TextXAlignment = Enum.TextXAlignment.Left
		oTxt.RichText = true
		oTxt.ZIndex = 1611

		-- Close & Moderate Buttons
		local closeBtn = Instance.new("TextButton", frame)
		closeBtn.Size = UDim2.new(0, 28, 0, 28)
		closeBtn.Position = UDim2.new(1, -36, 0, 24)
		closeBtn.BackgroundColor3 = Color3.fromRGB(28, 26, 40)
		closeBtn.BackgroundTransparency = 0.2
		closeBtn.Font = Z100.Theme.Tokens.Fonts.Heading
		closeBtn.TextSize = 12
		closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeBtn.Text = "✕"
		closeBtn.ZIndex = 1612
		C.Corner(closeBtn, Z100.Theme.Tokens.Radius.Pill)
		closeBtn.MouseButton1Click:Connect(Z100.Stories.CloseViewer)

		local modBtn = Instance.new("TextButton", frame)
		modBtn.Size = UDim2.new(0, 28, 0, 28)
		modBtn.Position = UDim2.new(1, -70, 0, 24)
		modBtn.BackgroundColor3 = canModerate and Color3.fromRGB(190, 40, 56) or Color3.fromRGB(68, 42, 58)
		modBtn.BackgroundTransparency = 0.2
		modBtn.Font = Z100.Theme.Tokens.Fonts.Heading
		modBtn.TextSize = 12
		modBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		modBtn.Text = canModerate and "🗑" or "🚩"
		modBtn.ZIndex = 1612
		C.Corner(modBtn, Z100.Theme.Tokens.Radius.Pill)

		local musicPill = Instance.new("TextLabel", frame)
		musicPill.Size = UDim2.new(1, -24, 0, 22)
		musicPill.Position = UDim2.new(0, 12, 0, 64)
		musicPill.BackgroundColor3 = Color3.fromRGB(10, 14, 24)
		musicPill.BackgroundTransparency = 0.25
		musicPill.Font = Z100.Theme.Tokens.Fonts.Title
		musicPill.TextSize = 10
		musicPill.TextColor3 = Color3.fromRGB(0, 242, 198)
		musicPill.Visible = false
		musicPill.ZIndex = 1608
		C.Corner(musicPill, Z100.Theme.Tokens.Radius.Pill)

		local stickerLbl = Instance.new("TextLabel", frame)
		stickerLbl.Size = UDim2.new(0, 56, 0, 56)
		stickerLbl.Position = UDim2.new(1, -66, 0, 94)
		stickerLbl.BackgroundTransparency = 1
		stickerLbl.Font = Z100.Theme.Tokens.Fonts.Heading
		stickerLbl.TextSize = 36
		stickerLbl.ZIndex = 1607

		local overlayLbl = Instance.new("TextLabel", frame)
		overlayLbl.Size = UDim2.new(1, -28, 0, 44)
		overlayLbl.Position = UDim2.new(0, 14, 0.48, -22)
		overlayLbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		overlayLbl.BackgroundTransparency = 1
		overlayLbl.Font = Z100.Theme.Tokens.Fonts.Heading
		overlayLbl.TextSize = 15
		overlayLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		overlayLbl.TextWrapped = true
		overlayLbl.ZIndex = 1607
		C.Corner(overlayLbl, Z100.Theme.Tokens.Radius.SM)

		local prevZone = Instance.new("TextButton", frame)
		prevZone.Size = UDim2.new(0.32, 0, 0.56, 0)
		prevZone.Position = UDim2.new(0, 0, 0.18, 0)
		prevZone.BackgroundTransparency = 1
		prevZone.Text = ""
		prevZone.ZIndex = 1609

		local nextZone = Instance.new("TextButton", frame)
		nextZone.Size = UDim2.new(0.68, 0, 0.56, 0)
		nextZone.Position = UDim2.new(0.32, 0, 0.18, 0)
		nextZone.BackgroundTransparency = 1
		nextZone.Text = ""
		nextZone.ZIndex = 1609

		local capLbl = Instance.new("TextLabel", frame)
		capLbl.Size = UDim2.new(1, -24, 0, 42)
		capLbl.Position = UDim2.new(0, 12, 1, -104)
		capLbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		capLbl.BackgroundTransparency = 0.45
		capLbl.Font = Z100.Theme.Tokens.Fonts.Body
		capLbl.TextSize = 11.5
		capLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		capLbl.TextWrapped = true
		capLbl.Visible = false
		capLbl.ZIndex = 1608
		C.Corner(capLbl, Z100.Theme.Tokens.Radius.SM)

		-- Bottom Interaction Bar
		local botBar = Instance.new("Frame", frame)
		botBar.Size = UDim2.new(1, -20, 0, 50)
		botBar.Position = UDim2.new(0, 10, 1, -56)
		botBar.BackgroundTransparency = 1
		botBar.ZIndex = 1612

		local viewersBtn = nil
		if isOwner then
			viewersBtn = C.Button(botBar, {
				Size = UDim2.new(1, 0, 0, 36),
				Position = UDim2.new(0, 0, 0.5, -18),
				Variant = "secondary",
				Text = "👁 Viewers (Loading...)",
				TextSize = 11,
				ZIndex = 1613,
			})
		else
			C.ListLayout(botBar, 5, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

			C.Button(botBar, {
				Size = UDim2.new(0.42, 0, 0, 34),
				Variant = "primary",
				Text = "✉ Reply DM",
				TextSize = 10.5,
				ZIndex = 1613,
				OnClick = function()
					paused = true
					Z100.Stories.CloseViewer()
					local ok, reason = Backend.CanMessageUser(uidStr)
					if not ok then
						Z100.UI.ShowToast("🔒 DM Restricted", reason, p.Danger, uidStr)
						return
					end
					Util.RegisterAccount(oAcc.Username, oAcc.DisplayName, tonumber(uidStr) or 1)
					local key = oAcc.Username:lower()
					State.Cache.DMs[key] = State.Cache.DMs[key] or {}
					State.ChatSubMode = "DM"
					State.ActiveDM = key
					Z100.Router.Navigate("Messages")
				end,
			})

			for _, em in ipairs({ "🔥", "❤️", "😂", "😮", "👏" }) do
				C.Button(botBar, {
					Size = UDim2.new(0, 34, 0, 34),
					Radius = Z100.Theme.Tokens.Radius.Pill,
					Variant = "secondary",
					Text = em,
					TextSize = 15,
					ZIndex = 1613,
					OnClick = function()
						Backend.ReactToStory(storiesList[curIdx], em)
						Z100.UI.ShowToast("🔥 Reaction Sent", "Reacted " .. em .. " to @" .. oAcc.Username .. "'s story", p.Accent, uidStr)
					end,
				})
			end
		end

		local function openViewersPopup(storyObj)
			paused = true
			if frame:FindFirstChild("ZaynV100_ViewersModal") then frame.ZaynV100_ViewersModal:Destroy() end
			local vm = Instance.new("Frame", frame)
			vm.Name = "ZaynV100_ViewersModal"
			vm.Size = UDim2.new(1, -20, 0, 236)
			vm.Position = UDim2.new(0, 10, 1, -246)
			vm.BackgroundColor3 = p.Surface
			vm.ZIndex = 1620
			C.Corner(vm, Z100.Theme.Tokens.Radius.MD)
			C.Stroke(vm, p.BorderGlow, 1.5, 0.1)

			local vh = Instance.new("TextLabel", vm)
			vh.Size = UDim2.new(1, -40, 0, 30); vh.Position = UDim2.new(0, 12, 0, 4); vh.BackgroundTransparency = 1
			vh.Font = Z100.Theme.Tokens.Fonts.Heading; vh.TextSize = 11.5; vh.TextColor3 = p.Accent; vh.TextXAlignment = Enum.TextXAlignment.Left
			vh.Text = "👁 Story Viewers"; vh.ZIndex = 1621

			local vx = Instance.new("TextButton", vm)
			vx.Size = UDim2.new(0, 24, 0, 24); vx.Position = UDim2.new(1, -30, 0, 6); vx.BackgroundColor3 = p.Danger
			vx.Font = Z100.Theme.Tokens.Fonts.Heading; vx.TextSize = 11; vx.TextColor3 = Color3.fromRGB(255, 255, 255); vx.Text = "✕"; vx.ZIndex = 1621
			C.Corner(vx, Z100.Theme.Tokens.Radius.XS)
			vx.MouseButton1Click:Connect(function() vm:Destroy(); paused = false; storyStartClock = os.clock() end)

			local vs = Instance.new("ScrollingFrame", vm)
			vs.Size = UDim2.new(1, -16, 1, -42); vs.Position = UDim2.new(0, 8, 0, 36); vs.BackgroundTransparency = 1; vs.ScrollBarThickness = 2; vs.ZIndex = 1621
			local vl = C.ListLayout(vs, 5)
			C.AttachAutoCanvas(vs, vl, 10)

			task.spawn(function()
				local viewers = Backend.FetchStoryViewers(storyObj.id)
				if not vs or not vs.Parent then return end
				if #viewers == 0 then
					local em = Instance.new("TextLabel", vs)
					em.Size = UDim2.new(1, 0, 0, 40); em.BackgroundTransparency = 1; em.Font = Z100.Theme.Tokens.Fonts.Body
					em.TextSize = 10.5; em.TextColor3 = p.TextMuted; em.Text = "No viewers yet."; em.ZIndex = 1622
					return
				end
				for idx, v in ipairs(viewers) do
					local vb = C.Button(vs, {
						Size = UDim2.new(1, -4, 0, 36),
						Variant = "secondary",
						Text = "@" .. v.username .. " (" .. v.displayName .. ")  •  " .. Util.TimeAgo(v.viewedAt),
						TextSize = 10,
						LayoutOrder = idx,
						ZIndex = 1622,
						OnClick = function()
							Z100.Stories.CloseViewer()
							Z100.Router.OpenProfile(v.uid)
						end,
					})
					vb.TextXAlignment = Enum.TextXAlignment.Left
					C.Padding(vb, 0, 8, 0, 10)
				end
			end)
		end

		local function showStoryAt(idx)
			if viewerSessionSeq ~= mySession or not frame or not frame.Parent then return end
			if idx < 1 then idx = 1 end
			if idx > #storiesList then
				Z100.Stories.CloseViewer()
				return
			end
			curIdx = idx
			storyStartClock = os.clock()
			local st = storiesList[curIdx]

			for i = 1, #progFills do
				progFills[i].Size = UDim2.new(i < curIdx and 1 or 0, 0, 1, 0)
			end

			local bgObj = Z100.Stories.BackgroundMap[st.bgHex] or Z100.Stories.Backgrounds[1]
			frame.BackgroundColor3 = bgObj.c1
			bgGrad.Color = ColorSequence.new(bgObj.c1, bgObj.c2)
			Util.LoadImageSafe(photo, st.imageRef)

			oTxt.Text = string.format("%s\n<font color='#C2C0E0' size='9'>@%s • %s • %s</font>",
				Util.EscapeRichText(tostring(st.ownerDisplay or oAcc.DisplayName)),
				Util.EscapeRichText(tostring(st.ownerName or oAcc.Username)),
				Util.TimeAgo(st.createdAt),
				tostring(st.privacy or "Public"))

			stickerLbl.Text = tostring(st.sticker or "")
			overlayLbl.Text = tostring(st.overlayText or "")
			overlayLbl.BackgroundTransparency = (overlayLbl.Text ~= "") and 0.45 or 1

			capLbl.Text = tostring(st.caption or "")
			capLbl.Visible = (capLbl.Text ~= "")

			-- Synchronized Online YouTube Music Playback
			Z100.Music.StopAudio("ZaynV100_StoryAudio")
			if type(st.music) == "table" and tostring(st.music.videoId or "") ~= "" then
				musicPill.Visible = true
				musicPill.Text = "♫ " .. tostring(st.music.title or "Track") .. " — " .. tostring(st.music.artist or "YouTube")
				if State.Prefs.StoryAudioEnabled and not State.Prefs.MuteAllAudio then
					Z100.Music.PlayOnlineTrack(st.music, "ZaynV100_StoryAudio", function(playState, detail)
						if not musicPill or not musicPill.Parent then return end
						if playState == "error" then
							musicPill.Text = "⚠️ " .. tostring(detail):sub(1, 36)
						end
					end)
				end
			else
				musicPill.Visible = false
			end

			Backend.RecordStoryView(st.id)

			if isOwner and viewersBtn then
				viewersBtn.Text = "👁 Viewers (...)"
				task.spawn(function()
					local vs = Backend.FetchStoryViewers(st.id)
					if viewersBtn and viewersBtn.Parent and storiesList[curIdx] == st then
						viewersBtn.Text = "👁 Viewers (" .. tostring(#vs) .. ") • Tap to view list"
					end
				end)
			end
		end

		if viewersBtn then
			viewersBtn.MouseButton1Click:Connect(function()
				openViewersPopup(storiesList[curIdx])
			end)
		end

		modBtn.MouseButton1Click:Connect(function()
			local st = storiesList[curIdx]
			if canModerate then
				task.spawn(function()
					local ok, msg = Backend.DeleteStory(st.ownerUid, st.id)
					Z100.Stories.CloseViewer()
					Z100.UI.ShowToast(ok and "🗑 Story Deleted" or "⚠️ Error", msg, p.Danger)
					if State.ActiveScreen == "Stories" then Z100.Router.Navigate("Stories") end
				end)
			else
				paused = true
				Z100.Stories.CloseViewer()
				C.PromptDialog("🚩 Report Story", "Reason for reporting this story...", "Report", function(reason)
					local ok, err = Backend.ReportStory(st, reason)
					Z100.UI.ShowToast(ok and "🛡️ Story Reported" or "⚠️ Error", ok and "Flagged for Admin review." or err, p.Warning)
				end)
			end
		end)

		prevZone.MouseButton1Click:Connect(function() showStoryAt(curIdx - 1) end)
		nextZone.MouseButton1Click:Connect(function() showStoryAt(curIdx + 1) end)

		showStoryAt(curIdx)

		Z100.Stories._progressAnimId = Z100.Anim.Register(frame, function()
			if paused or viewerSessionSeq ~= mySession then return end
			local elapsed = os.clock() - storyStartClock
			local pct = math.clamp(elapsed / STORY_DURATION, 0, 1)
			if progFills[curIdx] then
				progFills[curIdx].Size = UDim2.new(pct, 0, 1, 0)
			end
			if elapsed >= STORY_DURATION then
				showStoryAt(curIdx + 1)
			end
		end, false)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 12 / 15 : ONLINE MUSIC STUDIO (₹1500 GATE, YT SEARCH, MP3 DECK & LIB)
-- ========================================================================= --

do
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend
	local Music = Z100.Music

	local studioRenderSeq = 0
	local studioDeckAnimId = nil

	local function stopDeckAnim()
		if studioDeckAnimId then
			Z100.Anim.Unregister(studioDeckAnimId)
			studioDeckAnimId = nil
		end
	end

	function Z100.Screens.RenderMusicStudio(host)
		if not host or not host.Parent then return end

		studioRenderSeq = studioRenderSeq + 1
		local mySeq = studioRenderSeq
		stopDeckAnim()

		local p = Z100.Theme.Get()
		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "MUSIC STUDIO PRO" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Online YouTube MP3 Search & Story Audio" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_MusicStudioScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 232, 192)
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		local skel = C.LoadingSkeleton(scroll, 3, 76, 1)

		task.spawn(function()
			Backend.FetchStoreConfig()
			Backend.FetchEntitlements(Z100.MyUid, true)
			local hasPass = Backend.HasMusicStudioPass(Z100.MyUid)
			local musicPrice = Backend.GetMusicPassPrice()
			local myTracks = hasPass and Backend.FetchMyMusicLibrary(true) or {}

			if studioRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			-- ============================================================= --
			-- [STRICT ₹1500 PAID LOCK SCREEN FOR NON-OWNERS]
			-- ============================================================= --
			if not hasPass then
				local lockCard = C.Card(scroll, {
					Name = "MusicStudioLockCard",
					LayoutOrder = 1,
					BackgroundColor3 = Color3.fromRGB(11, 16, 26),
					StrokeColor = Color3.fromRGB(0, 232, 192),
					StrokeThickness = 1.8,
					HAlign = Enum.HorizontalAlignment.Center,
					PadY = 20,
					PadX = 18,
					ListGap = 10,
					ZIndex = 24,
				})

				local pill = Instance.new("TextLabel", lockCard)
				pill.Size = UDim2.new(0, 210, 0, 24)
				pill.BackgroundColor3 = Color3.fromRGB(0, 225, 185)
				pill.Font = Z100.Theme.Tokens.Fonts.Heading
				pill.TextSize = 10
				pill.TextColor3 = Color3.fromRGB(8, 16, 20)
				pill.Text = "🔒 PAID STUDIO PASS • ₹" .. tostring(musicPrice) .. " ONE-TIME"
				pill.LayoutOrder = 1
				pill.ZIndex = 25
				C.Corner(pill, Z100.Theme.Tokens.Radius.Pill)

				local title = Instance.new("TextLabel", lockCard)
				title.Size = UDim2.new(1, 0, 0, 28)
				title.BackgroundTransparency = 1
				title.Font = Z100.Theme.Tokens.Fonts.Heading
				title.TextSize = 18
				title.Text = "♫ ZAYN ONLINE MUSIC STUDIO PRO"
				title.LayoutOrder = 2
				title.ZIndex = 25
				Z100.Anim.ApplyGradientText(title, Color3.fromRGB(0, 245, 198), Color3.fromRGB(72, 188, 255))

				local desc = Instance.new("TextLabel", lockCard)
				desc.Size = UDim2.new(1, 0, 0, 0)
				desc.AutomaticSize = Enum.AutomaticSize.Y
				desc.BackgroundTransparency = 1
				desc.Font = Z100.Theme.Tokens.Fonts.Body
				desc.TextSize = 11
				desc.TextColor3 = Color3.fromRGB(210, 232, 242)
				desc.TextWrapped = true
				desc.TextXAlignment = Enum.TextXAlignment.Left
				desc.RichText = true
				desc.LayoutOrder = 3
				desc.ZIndex = 25
				desc.Text = string.format(
					"Online Music Studio is a <b>₹%d ONE-TIME PAID FEATURE</b> (zero free access).\n\n" ..
					"✦ Search any song online live via YouTube MP3 API\n" ..
					"✦ Stream & preview tracks directly inside your executor\n" ..
					"✦ Save unlimited songs to your permanent cloud My Music Library\n" ..
					"✦ Customize Start Position (sec) & Volume for Story Music\n" ..
					"✦ Attach online songs directly to your 24h Photo Stories\n" ..
					"✦ Unlock permanent <b>♫ STUDIO</b> Animated Profile Badge",
					musicPrice
				)

				C.Button(lockCard, {
					Height = 40,
					BackgroundColor3 = Color3.fromRGB(0, 215, 172),
					TextColor3 = Color3.fromRGB(8, 18, 18),
					Text = "♛ BUY MUSIC STUDIO PASS — ₹" .. tostring(musicPrice) .. " (OPEN STORE)",
					TextSize = 11.5,
					LayoutOrder = 4,
					ZIndex = 25,
					OnClick = function() Z100.Router.OpenStore("MusicPass") end,
				})

				local foot = Instance.new("TextLabel", lockCard)
				foot.Size = UDim2.new(1, 0, 0, 26)
				foot.BackgroundTransparency = 1
				foot.Font = Z100.Theme.Tokens.Fonts.Body
				foot.TextSize = 9.5
				foot.TextColor3 = p.TextMuted
				foot.TextWrapped = true
				foot.Text = "Admin manually verifies your Discord payment before activating Music Studio on your account."
				foot.LayoutOrder = 5
				foot.ZIndex = 25
				return
			end

			-- ============================================================= --
			-- [UNLOCKED ONLINE MUSIC STUDIO PRO]
			-- ============================================================= --
			local animTargets = {}
			local customStartSec = 0
			local customVolPct = math.floor((tonumber(State.Prefs.MusicVolume) or 0.7) * 100)

			-- 1. LIVE NOW-PLAYING MP3 DECK
			local deck = C.Card(scroll, {
				Name = "MusicNowPlayingDeck",
				LayoutOrder = 1,
				FixedHeight = true,
				Size = UDim2.new(1, 0, 0, 82),
				BackgroundColor3 = Color3.fromRGB(11, 18, 28),
				StrokeColor = Color3.fromRGB(0, 228, 188),
				StrokeThickness = 1.5,
				Padding = false,
				UseList = false,
				ZIndex = 24,
			})
			table.insert(animTargets, deck)

			local deckThumb = Instance.new("ImageLabel", deck)
			deckThumb.Size = UDim2.new(0, 50, 0, 50)
			deckThumb.Position = UDim2.new(0, 10, 0, 10)
			deckThumb.BackgroundColor3 = p.BgRoot
			deckThumb.ScaleType = Enum.ScaleType.Crop
			deckThumb.Image = "rbxthumb://type=Asset&id=88879794421294&w=150&h=150"
			deckThumb.ZIndex = 25
			C.Corner(deckThumb, Z100.Theme.Tokens.Radius.SM)

			local deckTitle = Instance.new("TextLabel", deck)
			deckTitle.Size = UDim2.new(1, -148, 0, 20)
			deckTitle.Position = UDim2.new(0, 70, 0, 10)
			deckTitle.BackgroundTransparency = 1
			deckTitle.Font = Z100.Theme.Tokens.Fonts.Heading
			deckTitle.TextSize = 11.5
			deckTitle.TextColor3 = Color3.fromRGB(0, 240, 198)
			deckTitle.TextXAlignment = Enum.TextXAlignment.Left
			deckTitle.ClipsDescendants = true
			deckTitle.Text = "♫ ONLINE MUSIC STUDIO • Ready"
			deckTitle.ZIndex = 25

			local deckSub = Instance.new("TextLabel", deck)
			deckSub.Size = UDim2.new(1, -148, 0, 16)
			deckSub.Position = UDim2.new(0, 70, 0, 32)
			deckSub.BackgroundTransparency = 1
			deckSub.Font = Z100.Theme.Tokens.Fonts.Body
			deckSub.TextSize = 9.5
			deckSub.TextColor3 = p.TextSecondary
			deckSub.TextXAlignment = Enum.TextXAlignment.Left
			deckSub.ClipsDescendants = true
			deckSub.Text = "Search any song online below to stream or attach to Stories."
			deckSub.ZIndex = 25

			local progTrack = Instance.new("Frame", deck)
			progTrack.Size = UDim2.new(1, -20, 0, 6)
			progTrack.Position = UDim2.new(0, 10, 1, -14)
			progTrack.BackgroundColor3 = Color3.fromRGB(26, 36, 52)
			progTrack.BorderSizePixel = 0
			progTrack.ZIndex = 25
			C.Corner(progTrack, Z100.Theme.Tokens.Radius.Pill)

			local progFill = Instance.new("Frame", progTrack)
			progFill.Size = UDim2.new(0, 0, 1, 0)
			progFill.BackgroundColor3 = Color3.fromRGB(0, 238, 195)
			progFill.BorderSizePixel = 0
			progFill.ZIndex = 26
			C.Corner(progFill, Z100.Theme.Tokens.Radius.Pill)

			C.Button(deck, {
				Size = UDim2.new(0, 64, 0, 32),
				Position = UDim2.new(1, -74, 0, 14),
				Variant = "danger",
				Text = "⏹ Stop",
				TextSize = 10,
				ZIndex = 26,
				OnClick = function()
					stopDeckAnim()
					Music.StopAudio("ZaynV100_MusicAudio")
					deckTitle.Text = "♫ ONLINE MUSIC STUDIO • Stopped"
					deckSub.Text = "Playback stopped."
					progFill.Size = UDim2.new(0, 0, 1, 0)
				end,
			})

			local function playTrackOnDeck(trackObj)
				stopDeckAnim()
				if trackObj.thumbnail and trackObj.thumbnail ~= "" then
					Util.LoadImageSafe(deckThumb, trackObj.thumbnail)
				end

				local cloneTrack = {
					videoId = trackObj.videoId,
					title = trackObj.title,
					artist = trackObj.artist,
					duration = trackObj.duration,
					thumbnail = trackObj.thumbnail,
					mp3Url = trackObj.mp3Url,
					startTime = tonumber(trackObj.startTime) or customStartSec,
					volume = tonumber(trackObj.volume) or math.clamp(customVolPct / 100, 0, 1),
				}

				Music.PlayOnlineTrack(cloneTrack, "ZaynV100_MusicAudio", function(st, detail)
					if not deck or not deck.Parent then return end
					if st == "loading" then
						deckTitle.Text = "◐ " .. tostring(cloneTrack.title):sub(1, 28)
						deckSub.Text = tostring(detail)
						progFill.Size = UDim2.new(0, 0, 1, 0)
					elseif st == "error" or st == "muted" then
						deckTitle.Text = "⚠️ " .. tostring(cloneTrack.title):sub(1, 26)
						deckSub.Text = tostring(detail)
						progFill.Size = UDim2.new(0, 0, 1, 0)
						Z100.UI.ShowToast("⚠️ Music Playback", tostring(detail), p.Warning)
					elseif st == "playing" then
						local totalLen = tonumber(detail) or tonumber(cloneTrack.duration) or 0
						deckTitle.Text = "🔊 " .. tostring(cloneTrack.title):sub(1, 30)
						studioDeckAnimId = Z100.Anim.Register(deck, function()
							local snd = Music.ActiveSound
							if not snd or not snd.Parent or not snd.IsPlaying then return end
							local tl = math.max(1, snd.TimeLength > 0 and snd.TimeLength or totalLen)
							local pos = snd.TimePosition
							progFill.Size = UDim2.new(math.clamp(pos / tl, 0, 1), 0, 1, 0)
							deckSub.Text = string.format("%s  •  %s / %s  •  Vol %d%%",
								tostring(cloneTrack.artist or "YouTube"):sub(1, 18),
								Util.FormatDuration(pos),
								Util.FormatDuration(tl),
								math.floor((snd.Volume or 0.7) * 100))
						end, false)
					end
				end)
			end

			-- 2. ONLINE YOUTUBE SEARCH & CLIP TUNING CARD
			local searchCard = C.Card(scroll, { Name = "MusicSearchCard", LayoutOrder = 2, ZIndex = 24 })
			table.insert(animTargets, searchCard)
			C.SectionHeader(searchCard, "🔍 Online YouTube Music Search", "Search any song worldwide via RapidAPI", 1)

			local sRow = Instance.new("Frame", searchCard)
			sRow.Size = UDim2.new(1, 0, 0, 36)
			sRow.BackgroundTransparency = 1
			sRow.LayoutOrder = 2
			sRow.ZIndex = 25

			local _, searchBox = C.TextInput(sRow, {
				Size = UDim2.new(1, -86, 1, 0),
				Placeholder = "Search song title or artist (e.g. Hope XXXTENTACION, Kesariya)...",
				ZIndex = 26,
			})

			local tuneRow = Instance.new("Frame", searchCard)
			tuneRow.Size = UDim2.new(1, 0, 0, 32)
			tuneRow.BackgroundTransparency = 1
			tuneRow.LayoutOrder = 3
			tuneRow.ZIndex = 25

			C.TextInput(tuneRow, {
				Size = UDim2.new(0.49, -2, 1, 0),
				Height = 32,
				Placeholder = "Start Time Sec (0)",
				Text = tostring(customStartSec),
				ZIndex = 26,
				OnChange = function(v) customStartSec = math.max(0, tonumber(v) or 0) end,
			})

			local volWrap = C.TextInput(tuneRow, {
				Size = UDim2.new(0.49, -2, 1, 0),
				Height = 32,
				Placeholder = "Volume 0-100 (70)",
				Text = tostring(customVolPct),
				ZIndex = 26,
				OnChange = function(v) customVolPct = math.clamp(tonumber(v) or 70, 0, 100) end,
			})
			volWrap.Position = UDim2.new(0.51, 2, 0, 0)

			local resultsWrap = Instance.new("Frame", searchCard)
			resultsWrap.Size = UDim2.new(1, 0, 0, 0)
			resultsWrap.AutomaticSize = Enum.AutomaticSize.Y
			resultsWrap.BackgroundTransparency = 1
			resultsWrap.LayoutOrder = 4
			resultsWrap.ZIndex = 25
			C.ListLayout(resultsWrap, 6)

			local function renderSearchResults(tracks)
				for _, ch in ipairs(resultsWrap:GetChildren()) do
					if not ch:IsA("UIListLayout") then ch:Destroy() end
				end
				if type(tracks) ~= "table" or #tracks == 0 then return end

				for idx, tr in ipairs(tracks) do
					local row = Instance.new("Frame", resultsWrap)
					row.Size = UDim2.new(1, 0, 0, 56)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = idx
					row.ZIndex = 26
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local th = Instance.new("ImageLabel", row)
					th.Size = UDim2.new(0, 42, 0, 42)
					th.Position = UDim2.new(0, 7, 0.5, -21)
					th.BackgroundColor3 = p.BgRoot
					th.ScaleType = Enum.ScaleType.Crop
					th.ZIndex = 27
					C.Corner(th, Z100.Theme.Tokens.Radius.XS)
					Util.LoadImageSafe(th, tr.thumbnail)

					local lbl = Instance.new("TextLabel", row)
					lbl.Size = UDim2.new(1, -206, 1, -6)
					lbl.Position = UDim2.new(0, 56, 0, 3)
					lbl.BackgroundTransparency = 1
					lbl.Font = Z100.Theme.Tokens.Fonts.Body
					lbl.TextSize = 10
					lbl.TextColor3 = p.TextPrimary
					lbl.TextXAlignment = Enum.TextXAlignment.Left
					lbl.ClipsDescendants = true
					lbl.RichText = true
					lbl.ZIndex = 27
					lbl.Text = string.format("<b>%s</b>\n<font color='#%s' size='9'>%s • %s</font>",
						Util.EscapeRichText(tostring(tr.title):sub(1, 30)),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(tostring(tr.artist):sub(1, 20)),
						Util.FormatDuration(tr.duration))

					C.Button(row, {
						Size = UDim2.new(0, 32, 0, 28),
						Position = UDim2.new(1, -144, 0.5, -14),
						Variant = "primary",
						Text = "▶",
						TextSize = 11,
						ZIndex = 27,
						OnClick = function() playTrackOnDeck(tr) end,
					})

					C.Button(row, {
						Size = UDim2.new(0, 48, 0, 28),
						Position = UDim2.new(1, -108, 0.5, -14),
						Variant = "success",
						Text = "+ Save",
						TextSize = 9.5,
						ZIndex = 27,
						OnClick = function()
							task.spawn(function()
								local ok, res = Backend.SaveTrackToLibrary(tr, customStartSec, customVolPct / 100)
								Z100.UI.ShowToast(ok and "♫ Saved to Library" or "⚠️ Error", ok and tostring(res.title) or tostring(res), ok and p.Success or p.Danger)
								if ok then Z100.Router.Navigate("MusicStudio") end
							end)
						end,
					})

					C.Button(row, {
						Size = UDim2.new(0, 52, 0, 28),
						Position = UDim2.new(1, -56, 0.5, -14),
						Variant = "secondary",
						Text = "◎ Story",
						TextSize = 9.5,
						ZIndex = 27,
						OnClick = function()
							stopDeckAnim()
							Music.StopAudio("ZaynV100_MusicAudio")
							tr.startTime = customStartSec
							tr.volume = math.clamp(customVolPct / 100, 0, 1)
							Z100.Stories.SetDraftMusic(tr)
							Z100.UI.ShowToast("♫ Attached to Story", tostring(tr.title) .. " loaded in Story Editor!", p.Success)
							Z100.Router.Navigate("StoryEditor")
						end,
					})
				end
			end

			local searchBusy = false
			local searchBtn
			local function doSearch()
				if searchBusy then return end
				local q = searchBox.Text:match("^%s*(.-)%s*$") or ""
				if q == "" then return end
				searchBusy = true
				searchBtn.Text = "..."
				for _, ch in ipairs(resultsWrap:GetChildren()) do
					if not ch:IsA("UIListLayout") then ch:Destroy() end
				end
				local resSkel = C.LoadingSkeleton(resultsWrap, 3, 50, 1)

				task.spawn(function()
					local ok, tracks, err = Music.SearchOnline(q)
					searchBusy = false
					if searchBtn and searchBtn.Parent then searchBtn.Text = "🔍 Find" end
					if resSkel and resSkel.Parent then resSkel:Destroy() end
					if not resultsWrap or not resultsWrap.Parent then return end

					if ok and #tracks > 0 then
						renderSearchResults(tracks)
					else
						C.ErrorState(resultsWrap, tostring(err or "No songs found."), doSearch, 1)
					end
				end)
			end

			searchBtn = C.Button(sRow, {
				Size = UDim2.new(0, 80, 1, 0),
				Position = UDim2.new(1, -80, 0, 0),
				Variant = "primary",
				Text = "🔍 Find",
				TextSize = 10.5,
				ZIndex = 26,
				OnClick = doSearch,
			})
			searchBox.FocusLost:Connect(function(enter) if enter then doSearch() end end)

			if #State.MusicSearchResults > 0 then
				renderSearchResults(State.MusicSearchResults)
			end

			-- 3. MY MUSIC CLOUD LIBRARY
			local libCard = C.Card(scroll, {
				Name = "MyMusicLibraryCard",
				LayoutOrder = 3,
				StrokeColor = Color3.fromRGB(0, 198, 165),
				ZIndex = 24,
			})
			table.insert(animTargets, libCard)

			C.SectionHeader(libCard, "💿 My Music Library (" .. tostring(#myTracks) .. ")", "Saved online songs ready for playback & Stories", 1)

			if #myTracks == 0 then
				C.EmptyState(libCard, "♫", "Your Library is Empty", "Search any song above and tap '+ Save' to build your personal cloud playlist.", nil, nil, 2)
			else
				for idx, tr in ipairs(myTracks) do
					local row = Instance.new("Frame", libCard)
					row.Size = UDim2.new(1, 0, 0, 52)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = idx + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local info = Instance.new("TextLabel", row)
					info.Size = UDim2.new(1, -162, 1, -6)
					info.Position = UDim2.new(0, 10, 0, 3)
					info.BackgroundTransparency = 1
					info.Font = Z100.Theme.Tokens.Fonts.Body
					info.TextSize = 10
					info.TextColor3 = p.TextPrimary
					info.TextXAlignment = Enum.TextXAlignment.Left
					info.ClipsDescendants = true
					info.RichText = true
					info.ZIndex = 26
					info.Text = string.format("<b>%s</b>\n<font color='#%s' size='9'>%s • Start %ds • Vol %d%%</font>",
						Util.EscapeRichText(tostring(tr.title):sub(1, 28)),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(tostring(tr.artist or "YouTube"):sub(1, 18)),
						math.floor(tonumber(tr.startTime) or 0),
						math.floor((tonumber(tr.volume) or 0.7) * 100))

					C.Button(row, {
						Size = UDim2.new(0, 32, 0, 28),
						Position = UDim2.new(1, -152, 0.5, -14),
						Variant = "primary",
						Text = "▶",
						TextSize = 11,
						ZIndex = 26,
						OnClick = function() playTrackOnDeck(tr) end,
					})

					C.Button(row, {
						Size = UDim2.new(0, 74, 0, 28),
						Position = UDim2.new(1, -116, 0.5, -14),
						Variant = "secondary",
						Text = "◎ Use Story",
						TextSize = 9.5,
						ZIndex = 26,
						OnClick = function()
							stopDeckAnim()
							Music.StopAudio("ZaynV100_MusicAudio")
							Z100.Stories.SetDraftMusic(tr)
							Z100.UI.ShowToast("♫ Attached to Story", tostring(tr.title) .. " loaded in Story Editor!", p.Success)
							Z100.Router.Navigate("StoryEditor")
						end,
					})

					C.Button(row, {
						Size = UDim2.new(0, 32, 0, 28),
						Position = UDim2.new(1, -38, 0.5, -14),
						Variant = "danger",
						Text = "🗑",
						TextSize = 11,
						ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								Backend.RemoveTrackFromLibrary(tr.id)
								Z100.Router.Navigate("MusicStudio")
							end)
						end,
					})
				end
			end

			Z100.Anim.PlaySequentialEntrance(scroll, animTargets)
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 13 / 15 : MESSAGES & CHAT SCREEN (SERVER, E2E DMs, VAULT & COMMANDS)
-- ========================================================================= --

do
	local Players = Z100.Services.Players
	local RunService = Z100.Services.Run
	local Lighting = Z100.Services.Lighting
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend
	local Crypto = Z100.Crypto
	local DB = Z100.DB
	local Nodes = Z100.Nodes

	local chatRefs = {
		Scroll = nil,
		TextBox = nil,
		SendBtn = nil,
		ReplyBar = nil,
		ReplyTxt = nil,
		JumpBtn = nil,
		StickerTray = nil,
		VaultTray = nil,
		SlowLbl = nil,
		SubTitleLbl = nil,
	}

	-- ===================================================================== --
	-- [SECTION A : READ RECEIPTS, UNREAD COUNTS & LOCK STATE]
	-- ===================================================================== --
	function Z100.Chat.GetLastRead(dmKey)
		local tbl = Util.ReadLocalJSON(Z100.LocalFiles.LastRead, {})
		if not dmKey then return tbl end
		return tonumber(tbl[dmKey]) or 0
	end

	function Z100.Chat.SetLastRead(dmKey, ts)
		local tbl = Util.ReadLocalJSON(Z100.LocalFiles.LastRead, {})
		tbl[dmKey] = ts
		Util.WriteLocalJSON(Z100.LocalFiles.LastRead, tbl)
		if Z100.UI.UpdateBadges then Z100.UI.UpdateBadges() end
	end

	function Z100.Chat.GetUnreadCount(dmKey)
		local count, lr = 0, Z100.Chat.GetLastRead(dmKey)
		for _, msg in ipairs(State.Cache.DMs[dmKey] or {}) do
			if (tonumber(msg.Time) or 0) > lr and msg.UserID ~= Z100.Player.UserId then
				count = count + 1
			end
		end
		return count
	end

	function Z100.Chat.GetTotalUnreadDMs()
		local total = 0
		for dmKey in pairs(State.Cache.DMs) do
			total = total + Z100.Chat.GetUnreadCount(dmKey)
		end
		return total
	end

	function Z100.Chat.SetLockState(locked)
		State.IsLocked = locked == true
		local tb = chatRefs.TextBox
		local sb = chatRefs.SendBtn
		if not tb or not tb.Parent then return end
		local p = Z100.Theme.Get()
		if State.IsLocked and not Util.IsAdmin() then
			tb.TextEditable = false
			tb.Text = ""
			tb.PlaceholderText = "🔒 Server chat locked by Admin"
			tb.TextColor3 = p.Danger
			if sb and sb.Parent then sb.BackgroundColor3 = Color3.fromRGB(92, 26, 36) end
		else
			tb.TextEditable = true
			tb.PlaceholderText = (State.ChatSubMode == "DM" and State.ActiveDM)
				and ("Message @" .. Util.GetAccount(State.ActiveDM).Username .. "...")
				or "Message server or type /help..."
			tb.TextColor3 = p.TextPrimary
			if sb and sb.Parent then sb.BackgroundColor3 = p.Accent end
		end
	end

	function Z100.Chat.ScrollToBottom(force)
		task.spawn(function()
			RunService.RenderStepped:Wait()
			RunService.RenderStepped:Wait()
			local sc = chatRefs.Scroll
			if not sc or not sc.Parent then return end
			local maxY = sc.CanvasSize.Y.Offset - sc.AbsoluteWindowSize.Y
			if maxY <= 0 then
				if chatRefs.JumpBtn and chatRefs.JumpBtn.Parent then chatRefs.JumpBtn.Visible = false end
				return
			end
			if force or sc.CanvasPosition.Y >= maxY - 70 then
				Z100.Theme.Tween(sc, Z100.Theme.Tokens.Timing.Base, { CanvasPosition = Vector2.new(0, maxY) })
				if chatRefs.JumpBtn and chatRefs.JumpBtn.Parent then chatRefs.JumpBtn.Visible = false end
			else
				if chatRefs.JumpBtn and chatRefs.JumpBtn.Parent then chatRefs.JumpBtn.Visible = true end
			end
		end)
	end

	function Z100.Chat.CancelActionBar()
		State.ReplyingTo = nil
		State.EditingMsgID = nil
		if chatRefs.ReplyBar and chatRefs.ReplyBar.Parent then
			chatRefs.ReplyBar.Visible = false
		end
	end

	function Z100.Chat.SetReply(senderName, text, dispName)
		local pv = Util.SanitizePreviewText(text)
		if #pv > 36 then pv = pv:sub(1, 36) .. "..." end
		State.ReplyingTo = { Username = senderName, DispName = dispName, Text = pv }
		State.EditingMsgID = nil
		if chatRefs.ReplyBar and chatRefs.ReplyBar.Parent and chatRefs.ReplyTxt then
			chatRefs.ReplyTxt.Text = "↩ Replying to <b>" .. Util.EscapeRichText(dispName) .. "</b>: " .. Util.EscapeRichText(pv)
			chatRefs.ReplyBar.Visible = true
		end
		if chatRefs.TextBox and chatRefs.TextBox.Parent then chatRefs.TextBox:CaptureFocus() end
	end

	function Z100.Chat.StartEditing(msgId, oldText)
		State.EditingMsgID = msgId
		State.ReplyingTo = nil
		if chatRefs.TextBox and chatRefs.TextBox.Parent then
			chatRefs.TextBox.Text = oldText
			chatRefs.TextBox:CaptureFocus()
		end
		if chatRefs.ReplyBar and chatRefs.ReplyBar.Parent and chatRefs.ReplyTxt then
			chatRefs.ReplyTxt.Text = "✎ Editing message: " .. Util.EscapeRichText(tostring(oldText):sub(1, 36))
			chatRefs.ReplyBar.Visible = true
		end
	end

	-- ===================================================================== --
	-- [SECTION B : REACTIONS, UNSEND & BUBBLE ACTION MENU]
	-- ===================================================================== --
	function Z100.Chat.UpdateBubbleReactions(msgId, rctTbl)
		local row = State.ActiveBubbles[msgId]
		if not row or not row.Parent or not row:FindFirstChild("MessageBubble") then return end
		local holder = row.MessageBubble:FindFirstChild("ReactContainer")
		if not holder then return end

		for _, ch in ipairs(holder:GetChildren()) do
			if ch:IsA("TextButton") then ch:Destroy() end
		end
		if type(rctTbl) ~= "table" then return end

		local p = Z100.Theme.Get()
		for hexKey, users in pairs(rctTbl) do
			local emoji = Crypto.HexDecode(hexKey)
			if emoji and type(users) == "table" then
				local cnt, iReacted = 0, false
				for uKey, val in pairs(users) do
					if val then
						cnt = cnt + 1
						if uKey == Z100.MyNameLower then iReacted = true end
					end
				end
				if cnt > 0 then
					local pill = Instance.new("TextButton", holder)
					pill.Size = UDim2.new(0, 0, 0, 20)
					pill.AutomaticSize = Enum.AutomaticSize.X
					pill.BackgroundColor3 = iReacted and p.Accent or p.SurfaceElev
					pill.BackgroundTransparency = iReacted and 0.15 or 0.2
					pill.AutoButtonColor = false
					pill.Font = Z100.Theme.Tokens.Fonts.Title
					pill.TextSize = 10.5
					pill.TextColor3 = Color3.fromRGB(255, 255, 255)
					pill.Text = emoji .. " " .. tostring(cnt)
					pill.ZIndex = holder.ZIndex + 1
					C.Corner(pill, Z100.Theme.Tokens.Radius.Pill)
					C.Padding(pill, 0, 7, 0, 7)
					pill.MouseButton1Click:Connect(function()
						Z100.Chat.ToggleReaction(msgId, emoji)
					end)
				end
			end
		end
	end

	function Z100.Chat.ToggleReaction(msgId, emoji)
		task.spawn(function()
			local myLow = Z100.MyNameLower
			local isDM = (State.ChatSubMode == "DM" and State.ActiveDM ~= nil)
			local partner = isDM and State.ActiveDM or nil
			local basePath = isDM
				and (Nodes.DMs .. "/" .. myLow .. "/" .. partner .. "/" .. msgId .. "/_rct")
				or (Nodes.ServerChat .. "/" .. State.JobId .. "/" .. msgId .. "/_rct")

			local list = isDM and State.Cache.DMs[partner] or State.Cache.Server
			local msgRef, rct = nil, {}
			if type(list) == "table" then
				for _, item in ipairs(list) do
					if item.ID == msgId then msgRef = item; rct = item.Reactions or {}; break end
				end
			end

			local existingHex = nil
			for hexKey, users in pairs(rct) do
				if type(users) == "table" and users[myLow] then existingHex = hexKey; break end
			end

			local targetHex = Crypto.HexEncode(emoji)
			if not targetHex or targetHex == "" then return end

			if existingHex == targetHex then
				rct[existingHex][myLow] = nil
				if next(rct[existingHex]) == nil then rct[existingHex] = nil end
				DB.DeleteAsync(basePath .. "/" .. existingHex .. "/" .. myLow)
				if isDM then
					DB.DeleteAsync(Nodes.DMs .. "/" .. partner .. "/" .. myLow .. "/" .. msgId .. "/_rct/" .. existingHex .. "/" .. myLow)
				end
			else
				if existingHex then
					rct[existingHex][myLow] = nil
					if next(rct[existingHex]) == nil then rct[existingHex] = nil end
					DB.DeleteAsync(basePath .. "/" .. existingHex .. "/" .. myLow)
					if isDM then
						DB.DeleteAsync(Nodes.DMs .. "/" .. partner .. "/" .. myLow .. "/" .. msgId .. "/_rct/" .. existingHex .. "/" .. myLow)
					end
				end
				rct[targetHex] = rct[targetHex] or {}
				rct[targetHex][myLow] = true
				DB.PutAsync(basePath .. "/" .. targetHex .. "/" .. myLow, true)
				if isDM then
					DB.PutAsync(Nodes.DMs .. "/" .. partner .. "/" .. myLow .. "/" .. msgId .. "/_rct/" .. targetHex .. "/" .. myLow, true)
				end
			end

			if msgRef then
				msgRef.Reactions = rct
				Z100.Chat.UpdateBubbleReactions(msgId, rct)
			end
		end)
	end

	function Z100.Chat.UnsendMsg(msgId)
		local myLow = Z100.MyNameLower
		local partner = State.ActiveDM and State.ActiveDM:lower() or ""
		if State.ChatSubMode == "DM" and partner ~= "" then
			DB.DeleteAsync(Nodes.DMs .. "/" .. myLow .. "/" .. partner .. "/" .. msgId)
			DB.DeleteAsync(Nodes.DMs .. "/" .. partner .. "/" .. myLow .. "/" .. msgId)
		else
			DB.DeleteAsync(Nodes.ServerChat .. "/" .. State.JobId .. "/" .. msgId)
		end
		if State.ActiveBubbles[msgId] then
			State.ActiveBubbles[msgId]:Destroy()
			State.ActiveBubbles[msgId] = nil
		end
		Z100.UI.ShowToast("🗑 Message Unsent", "Message removed from chat.", Z100.Theme.Get().Danger)
	end

	function Z100.Chat.OpenBubbleMenu(senderName, senderUid, text, msgId, isMe)
		if senderName == "ZARA" then return end
		local acc = Util.GetAccount(senderName)
		local cleanTxt = text:sub(1, 5) == "[EDT]" and text:sub(6) or text
		local isMedia = cleanTxt:match("^%[STICKER://") or cleanTxt:match("^%[MEDIA::")
		local p = Z100.Theme.Get()

		local modal = C.OpenModal({
			Name = "ZaynV100_BubbleMenu",
			Title = "Message • " .. acc.DisplayName,
			Width = 300,
		})
		if not modal then return end

		local rRow = Instance.new("Frame", modal.Body)
		rRow.Size = UDim2.new(1, 0, 0, 36)
		rRow.BackgroundColor3 = p.SurfaceElev
		rRow.LayoutOrder = 1
		rRow.ZIndex = modal.Body.ZIndex + 1
		C.Corner(rRow, Z100.Theme.Tokens.Radius.SM)
		C.ListLayout(rRow, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

		for _, em in ipairs({ "❤️", "😂", "🔥", "💀", "👍", "⚡" }) do
			C.Button(rRow, {
				Size = UDim2.new(0, 34, 0, 28),
				Variant = "ghost",
				Text = em,
				TextSize = 15,
				ZIndex = rRow.ZIndex + 1,
				OnClick = function()
					modal.Close()
					Z100.Chat.ToggleReaction(msgId, em)
				end,
			})
		end

		local ord = 2
		local function opt(lbl, variant, fn)
			C.Button(modal.Body, {
				Height = 32,
				Variant = variant,
				Text = lbl,
				TextSize = 11,
				LayoutOrder = ord,
				ZIndex = modal.Body.ZIndex + 1,
				OnClick = function() modal.Close(); fn() end,
			})
			ord = ord + 1
		end

		opt("◉ View Profile", "primary", function()
			local uNum = tonumber(senderUid)
			if uNum and uNum > 1 then
				Z100.Router.OpenProfile(uNum)
			else
				task.spawn(function()
					local res = Util.ResolveUser(senderName)
					if res and res.UserId then Z100.Router.OpenProfile(res.UserId) end
				end)
			end
		end)
		opt("↩ Reply", "secondary", function() Z100.Chat.SetReply(senderName, cleanTxt, acc.DisplayName) end)
		opt("📋 Copy Text", "secondary", function()
			Util.CopyText(cleanTxt)
			Z100.UI.ShowToast("📋 Copied", "Copied message to clipboard.", p.Accent)
		end)
		if isMe and msgId and not isMedia then
			opt("✎ Edit Message", "secondary", function() Z100.Chat.StartEditing(msgId, cleanTxt) end)
		end
		if isMe and msgId then
			opt("🗑 Unsend Message", "danger", function() Z100.Chat.UnsendMsg(msgId) end)
		end
	end

	-- ===================================================================== --
	-- [SECTION C : MODERN V100 MESSAGE BUBBLE RENDERER]
	-- ===================================================================== --
	function Z100.Chat.RenderBubble(senderName, senderUid, msgText, ts, msgId, edited, reactions)
		local scroll = chatRefs.Scroll
		if not scroll or not scroll.Parent then return end

		local p = Z100.Theme.Get()
		local isMe = tostring(senderName):lower() == Z100.MyNameLower
		local isSystem = (senderName == "ZARA")
		local uidNum = tonumber(senderUid) or 0

		if not isMe and not isSystem and uidNum > 1 and Backend.IsBlocked(uidNum) then
			return
		end

		local rplUser, rplBody, body = tostring(msgText or ""):match("^%[RPL::(.-)::(.-)::RPL%]%s*(.*)")
		if not rplUser then body = tostring(msgText or "") end
		local isEdited = edited == true
		if body:sub(1, 5) == "[EDT]" then isEdited = true; body = body:sub(6) end

		local row = Instance.new("Frame", scroll)
		row.Size = UDim2.new(1, 0, 0, 0)
		row.AutomaticSize = Enum.AutomaticSize.Y
		row.BackgroundTransparency = 1
		row.ZIndex = scroll.ZIndex + 1
		if msgId then State.ActiveBubbles[msgId] = row end

		-- Clickable Avatar (Opens User Profile)
		local avWrap = Instance.new("Frame", row)
		avWrap.Size = UDim2.new(0, 32, 0, 32)
		avWrap.BackgroundColor3 = p.BgRoot
		avWrap.AnchorPoint = isMe and Vector2.new(1, 0) or Vector2.new(0, 0)
		avWrap.Position = isMe and UDim2.new(1, -2, 0, 2) or UDim2.new(0, 2, 0, 2)
		avWrap.ZIndex = row.ZIndex + 1
		C.Corner(avWrap, Z100.Theme.Tokens.Radius.Pill)

		local avBtn = Instance.new("ImageButton", avWrap)
		avBtn.Size = UDim2.new(1, -2, 1, -2)
		avBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
		avBtn.AnchorPoint = Vector2.new(0.5, 0.5)
		avBtn.BackgroundTransparency = 1
		avBtn.ScaleType = Enum.ScaleType.Crop
		avBtn.ZIndex = avWrap.ZIndex + 1
		C.Corner(avBtn, Z100.Theme.Tokens.Radius.Pill)

		if isSystem then
			avBtn.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
		else
			local prof = uidNum > 1 and State.Profiles[tostring(uidNum)] or nil
			Util.LoadAvatarHeadshot(avBtn, uidNum, prof and prof.customAvatar)
			if prof and prof.decoration and prof.decoration ~= "none" then
				Z100.Anim.ApplyAvatarDecoration(avWrap, prof.decoration, true)
			end
		end

		avBtn.MouseButton1Click:Connect(function()
			if isSystem then return end
			if uidNum > 1 then
				Z100.Router.OpenProfile(uidNum)
			else
				task.spawn(function()
					local res = Util.ResolveUser(senderName)
					if res and res.UserId then Z100.Router.OpenProfile(res.UserId) end
				end)
			end
		end)

		local bubble = Instance.new("Frame", row)
		bubble.Name = "MessageBubble"
		bubble.AutomaticSize = Enum.AutomaticSize.XY
		bubble.AnchorPoint = isMe and Vector2.new(1, 0) or Vector2.new(0, 0)
		bubble.Position = isMe and UDim2.new(1, -42, 0, 0) or UDim2.new(0, 42, 0, 0)
		bubble.BackgroundColor3 = isMe and p.BubbleMe or p.BubbleOther
		bubble.BorderSizePixel = 0
		bubble.Active = true
		bubble.ZIndex = row.ZIndex + 1
		C.Corner(bubble, Z100.Theme.Tokens.Radius.MD)
		C.Stroke(bubble, isMe and p.Accent or p.Border, 1, isMe and 0.45 or 0.55)

		local maxBubbleW = (State.DeviceClass == "Mobile") and 220 or 380
		Instance.new("UISizeConstraint", bubble).MaxSize = Vector2.new(maxBubbleW, 9999)
		C.ListLayout(bubble, 3)
		C.Padding(bubble, 7, 12, 7, 12)

		-- Sender Name & Timestamp Header
		local acc = Util.GetAccount(senderName)
		local headLbl = Instance.new("TextLabel", bubble)
		headLbl.AutomaticSize = Enum.AutomaticSize.XY
		headLbl.BackgroundTransparency = 1
		headLbl.Font = Z100.Theme.Tokens.Fonts.Title
		headLbl.TextSize = 9.5
		headLbl.TextColor3 = isSystem and p.Gold or (isMe and Color3.fromRGB(220, 200, 255) or p.Accent)
		headLbl.RichText = true
		headLbl.LayoutOrder = 1
		headLbl.ZIndex = bubble.ZIndex + 1
		headLbl.Text = string.format("%s  <font color='#%s' size='8.5'>%s</font>",
			Util.EscapeRichText(isSystem and "ZAYN SYSTEM" or acc.DisplayName),
			p.TextMuted:ToHex(),
			Util.TimeAgo(ts))

		if rplUser then
			local rAcc = Util.GetAccount(rplUser)
			local rBox = Instance.new("Frame", bubble)
			rBox.AutomaticSize = Enum.AutomaticSize.XY
			rBox.BackgroundColor3 = p.BgRoot
			rBox.BackgroundTransparency = 0.45
			rBox.LayoutOrder = 2
			rBox.ZIndex = bubble.ZIndex + 1
			C.Corner(rBox, Z100.Theme.Tokens.Radius.XS)
			C.Padding(rBox, 3, 8, 3, 8)
			local rt = Instance.new("TextLabel", rBox)
			rt.AutomaticSize = Enum.AutomaticSize.XY
			rt.BackgroundTransparency = 1
			rt.Font = Z100.Theme.Tokens.Fonts.Body
			rt.TextSize = 9.5
			rt.TextColor3 = p.TextSecondary
			rt.RichText = true
			rt.Text = "↩ <b>" .. Util.EscapeRichText(rAcc.DisplayName) .. "</b>: " .. Util.EscapeRichText(tostring(rplBody))
			rt.ZIndex = rBox.ZIndex + 1
		end

		local stkId = body:match("%[STICKER://(%d+)%]")
		local mediaUrl = body:match("%[MEDIA::(.-)::MEDIA%]")
		if stkId then
			local img = Instance.new("ImageLabel", bubble)
			img.Size = UDim2.new(0, 108, 0, 108)
			img.BackgroundTransparency = 1
			img.Image = "rbxthumb://type=Asset&id=" .. stkId .. "&w=150&h=150"
			img.ScaleType = Enum.ScaleType.Fit
			img.LayoutOrder = 3
			img.ZIndex = bubble.ZIndex + 1
		elseif mediaUrl then
			local mBtn = Instance.new("ImageButton", bubble)
			mBtn.Size = UDim2.new(0, 190, 0, 140)
			mBtn.BackgroundColor3 = p.BgRoot
			mBtn.ScaleType = Enum.ScaleType.Crop
			mBtn.LayoutOrder = 3
			mBtn.ZIndex = bubble.ZIndex + 1
			C.Corner(mBtn, Z100.Theme.Tokens.Radius.SM)
			Util.LoadImageSafe(mBtn, mediaUrl)
			mBtn.MouseButton1Click:Connect(function()
				if not Z100.UI.ScreenGui or Z100.UI.ScreenGui:FindFirstChild("ZaynV100_MediaViewer") then return end
				local blur = Instance.new("BlurEffect", Lighting); blur.Name = "ZaynV100_Blur"; blur.Size = 18
				local v = Instance.new("Frame", Z100.UI.ScreenGui)
				v.Name = "ZaynV100_MediaViewer"; v.Size = UDim2.new(1, 0, 1, 0)
				v.BackgroundColor3 = Color3.fromRGB(0, 0, 0); v.BackgroundTransparency = 0.15; v.Active = true; v.ZIndex = 1700
				local full = Instance.new("ImageLabel", v)
				full.Size = UDim2.new(0.86, 0, 0.86, 0); full.Position = UDim2.new(0.5, 0, 0.5, 0); full.AnchorPoint = Vector2.new(0.5, 0.5)
				full.BackgroundTransparency = 1; full.ScaleType = Enum.ScaleType.Fit; full.ZIndex = 1701
				Util.LoadImageSafe(full, mediaUrl)
				local x = Instance.new("TextButton", v)
				x.Size = UDim2.new(0, 40, 0, 40); x.Position = UDim2.new(1, -24, 0, 32); x.AnchorPoint = Vector2.new(1, 0)
				x.BackgroundColor3 = p.Danger; x.Font = Z100.Theme.Tokens.Fonts.Heading; x.TextSize = 16
				x.TextColor3 = Color3.fromRGB(255, 255, 255); x.Text = "✕"; x.ZIndex = 1702
				C.Corner(x, Z100.Theme.Tokens.Radius.Pill)
				x.MouseButton1Click:Connect(function()
					if Lighting:FindFirstChild("ZaynV100_Blur") then Lighting.ZaynV100_Blur:Destroy() end
					v:Destroy()
				end)
			end)
		else
			local msgLbl = Instance.new("TextLabel", bubble)
			msgLbl.AutomaticSize = Enum.AutomaticSize.XY
			msgLbl.BackgroundTransparency = 1
			msgLbl.Font = Z100.Theme.Tokens.Fonts.Body
			msgLbl.TextSize = 12
			msgLbl.TextColor3 = p.TextPrimary
			msgLbl.TextWrapped = true
			msgLbl.RichText = true
			msgLbl.TextXAlignment = Enum.TextXAlignment.Left
			msgLbl.LayoutOrder = 3
			msgLbl.ZIndex = bubble.ZIndex + 1
			local escaped = isSystem and body or Util.EscapeRichText(body)
			msgLbl.Text = isEdited and (escaped .. "\n<font color='#9A9CB8' size='9'><i>(edited)</i></font>") or escaped
		end

		local rHold = Instance.new("Frame", bubble)
		rHold.Name = "ReactContainer"
		rHold.AutomaticSize = Enum.AutomaticSize.XY
		rHold.BackgroundTransparency = 1
		rHold.LayoutOrder = 4
		rHold.ZIndex = bubble.ZIndex + 1
		C.ListLayout(rHold, 4, Enum.FillDirection.Horizontal)
		if reactions then Z100.Chat.UpdateBubbleReactions(msgId, reactions) end

		-- Long-press or Right-click to open Bubble Action Menu
		local holding = false
		bubble.InputBegan:Connect(function(inp)
			if isSystem then return end
			if inp.UserInputType == Enum.UserInputType.MouseButton2 then
				Z100.Chat.OpenBubbleMenu(senderName, uidNum, body, msgId, isMe)
			elseif inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
				holding = true
				task.delay(0.45, function()
					if holding and bubble.Parent then
						holding = false
						Z100.Chat.OpenBubbleMenu(senderName, uidNum, body, msgId, isMe)
					end
				end)
			end
		end)
		bubble.InputEnded:Connect(function() holding = false end)

		Z100.Chat.ScrollToBottom(isMe)
	end

	-- ===================================================================== --
	-- [SECTION D : SLASH COMMANDS & ENCRYPTED CHAT SEND PIPELINE]
	-- ===================================================================== --
	function Z100.Chat.ProcessCommand(rawText)
		local cmd, arg = rawText:match("^/(%S+)%s*(.*)$")
		if not cmd then return false end
		cmd = cmd:lower()
		arg = tostring(arg or ""):match("^%s*(.-)%s*$")
		local p = Z100.Theme.Get()

		if cmd == "profile" or cmd == "p" then
			if arg == "" then
				Z100.Router.OpenProfile(Z100.MyUid)
			else
				task.spawn(function()
					local res = Util.ResolveUser(arg)
					if res and res.UserId then Z100.Router.OpenProfile(res.UserId)
					else Z100.UI.ShowToast("⚠️ Not Found", "No user matches '" .. arg .. "'", p.Danger) end
				end)
			end
			return true
		elseif cmd == "home" then Z100.Router.Navigate("Home"); return true
		elseif cmd == "edit" then Z100.Router.Navigate("ProfileEditor"); return true
		elseif cmd == "stories" or cmd == "story" then Z100.Router.Navigate("Stories"); return true
		elseif cmd == "createstory" then Z100.Router.Navigate("StoryEditor"); return true
		elseif cmd == "music" or cmd == "studio" then Z100.Router.Navigate("MusicStudio"); return true
		elseif cmd == "store" or cmd == "shop" then Z100.Router.OpenStore("Decorations"); return true
		elseif cmd == "themes" then Z100.Router.OpenStore("Themes"); return true
		elseif cmd == "settings" then Z100.Router.Navigate("Settings"); return true
		elseif cmd == "admin" then Z100.Router.Navigate("Admin"); return true
		elseif cmd == "inbox" or cmd == "dms" then
			State.ChatSubMode = "DM_Inbox"
			Z100.Router.Navigate("Messages")
			return true
		elseif cmd == "dm" and arg ~= "" then
			task.spawn(function()
				local res = Util.ResolveUser(arg)
				if not res or not res.UserId then
					Z100.UI.ShowToast("⚠️ Not Found", "User '" .. arg .. "' not found.", p.Danger)
					return
				end
				local ok, why = Backend.CanMessageUser(res.UserId)
				if not ok then Z100.UI.ShowToast("🔒 DM Blocked", why, p.Danger); return end
				local key = res.Username:lower()
				State.Cache.DMs[key] = State.Cache.DMs[key] or {}
				State.ChatSubMode = "DM"
				State.ActiveDM = key
				Z100.Router.Navigate("Messages")
			end)
			return true
		elseif cmd == "help" then
			Z100.Chat.RenderBubble("ZARA", 0,
				"<b>👑 ZAYN SOCIAL V100 COMMANDS:</b>\n" ..
				"/home • /profile [user] • /edit • /stories • /createstory\n" ..
				"/studio • /store • /themes • /dm [user] • /inbox • /settings" ..
				(Util.IsAdmin() and "\n<b>Owner:</b> /admin • /lock • /unlock • /broadcast [msg] • /ban [user] • /unban [user]" or ""),
				Util.Now(), "HELP_" .. tostring(os.clock()), false, nil)
			return true
		elseif Util.IsAdmin() then
			if cmd == "lock" then
				DB.PutAsync(Nodes.Locks .. "/" .. State.JobId, true)
				Z100.Chat.SetLockState(true)
				Z100.UI.ShowToast("🔒 Locked", "Server chat locked.", p.Danger)
				return true
			elseif cmd == "unlock" then
				DB.DeleteAsync(Nodes.Locks .. "/" .. State.JobId)
				Z100.Chat.SetLockState(false)
				Z100.UI.ShowToast("🔓 Unlocked", "Server chat unlocked.", p.Success)
				return true
			elseif cmd == "broadcast" and arg ~= "" then
				DB.PutAsync(Nodes.Broadcasts, { msg = arg, time = Util.Now() })
				Z100.UI.ShowGlobalBanner(arg)
				return true
			elseif cmd == "ban" and arg ~= "" then
				DB.PutAsync(Nodes.Blacklist .. "/Accs/" .. arg:lower(), '"true"')
				Z100.UI.ShowToast("⛔ Blacklisted", "@" .. arg .. " permanently restricted.", p.Danger)
				return true
			elseif cmd == "unban" and arg ~= "" then
				task.spawn(function()
					local low = arg:lower()
					local hw = DB.Get(Nodes.Blacklist .. "/Accs/" .. low)
					DB.Delete(Nodes.Blacklist .. "/Accs/" .. low)
					if type(hw) == "string" and hw ~= "" and hw ~= "true" then
						DB.Delete(Nodes.Blacklist .. "/HWs/" .. hw)
					end
					Z100.UI.ShowToast("🔓 Unbanned", "@" .. arg .. " removed from blacklist.", p.Success)
				end)
				return true
			end
		end
		return false
	end

	function Z100.Chat.Send(rawMessage)
		local text = tostring(rawMessage or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if text == "" then return end

		if text:sub(1, 1) == "/" and Z100.Chat.ProcessCommand(text) then
			return
		end

		if State.IsLocked and not Util.IsAdmin() then
			Z100.UI.ShowToast("🔒 Locked", "Server chat is locked by Admin.", Z100.Theme.Get().Danger)
			return
		end

		local nowClock = os.clock()
		if nowClock - State.LastSendClock < Z100.Config.Limits.ChatCooldown and not Util.IsAdmin() then
			return
		end
		if #text > Z100.Config.Limits.MessageMax then text = text:sub(1, Z100.Config.Limits.MessageMax) end

		local finalBody = text
		local ts = Util.Now()
		local msgId = State.EditingMsgID or ("M100_" .. tostring(ts) .. "_" .. Util.GenerateKey(6))
		local isEdit = (State.EditingMsgID ~= nil)

		if isEdit then
			finalBody = "[EDT]" .. text
		elseif State.ReplyingTo then
			finalBody = string.format("[RPL::%s::%s::RPL] %s",
				tostring(State.ReplyingTo.Username),
				tostring(State.ReplyingTo.Text),
				text)
		end

		State.LastSendClock = nowClock
		Z100.Chat.CancelActionBar()

		-- Direct Message Mode (E2E Encrypted)
		if State.ChatSubMode == "DM" and State.ActiveDM then
			local partnerLow = State.ActiveDM
			local acc = Util.GetAccount(partnerLow)
			if acc and acc.UserId > 1 then
				local canDM, why = Backend.CanMessageUser(acc.UserId)
				if not canDM then
					Z100.UI.ShowToast("🔒 DM Restricted", why, Z100.Theme.Get().Danger)
					return
				end
			end

			local dmKey = Crypto.GetDMKey(Z100.MyNameLower, partnerLow)
			local encMsg, sig = Crypto.Encrypt(dmKey, finalBody)
			local payload = { u = Z100.Player.UserId, s = Z100.MyName, m = encMsg, sign = sig, t = ts }

			State.SeenMsgIds[msgId] = true
			State.Cache.DMs[partnerLow] = State.Cache.DMs[partnerLow] or {}
			if isEdit then
				for _, item in ipairs(State.Cache.DMs[partnerLow]) do
					if item.ID == msgId then item.Msg = finalBody; item.Edited = true; break end
				end
				if State.ActiveBubbles[msgId] then State.ActiveBubbles[msgId]:Destroy() end
			else
				table.insert(State.Cache.DMs[partnerLow], {
					ID = msgId, Sender = Z100.MyName, UserID = Z100.Player.UserId,
					Msg = finalBody, Time = ts, Edited = false, Reactions = {},
				})
			end

			Z100.Chat.RenderBubble(Z100.MyName, Z100.Player.UserId, finalBody, ts, msgId, isEdit, nil)
			Z100.Chat.SetLastRead(partnerLow, ts)

			DB.PutAsync(Nodes.DMs .. "/" .. Z100.MyNameLower .. "/" .. partnerLow .. "/" .. msgId, payload)
			DB.PutAsync(Nodes.DMs .. "/" .. partnerLow .. "/" .. Z100.MyNameLower .. "/" .. msgId, payload)
			return
		end

		-- Server Chat Mode (E2E Encrypted per JobId)
		local srvKey = Crypto.ServerSalt .. State.JobId
		local encMsg, sig = Crypto.Encrypt(srvKey, finalBody)
		local payload = { u = Z100.Player.UserId, s = Z100.MyName, m = encMsg, sign = sig, t = ts }

		State.SeenMsgIds[msgId] = true
		if isEdit then
			for _, item in ipairs(State.Cache.Server) do
				if item.ID == msgId then item.Msg = finalBody; item.Edited = true; break end
			end
			if State.ActiveBubbles[msgId] then State.ActiveBubbles[msgId]:Destroy() end
		else
			table.insert(State.Cache.Server, {
				ID = msgId, Sender = Z100.MyName, UserID = Z100.Player.UserId,
				Msg = finalBody, Time = ts, Edited = false, Reactions = {},
			})
		end

		Z100.Chat.RenderBubble(Z100.MyName, Z100.Player.UserId, finalBody, ts, msgId, isEdit, nil)
		DB.PutAsync(Nodes.ServerChat .. "/" .. State.JobId .. "/" .. msgId, payload)
	end

	-- ===================================================================== --
	-- [SECTION E : MESSAGES SCREEN RENDERER (SERVER | INBOX | DM | FRIENDS)]
	-- ===================================================================== --
	function Z100.Screens.RenderMessages(host)
		if not host or not host.Parent then return end

		local p = Z100.Theme.Get()
		local subMode = State.ChatSubMode or "Server"
		table.clear(State.ActiveBubbles)
		chatRefs.Scroll = nil
		chatRefs.TextBox = nil
		chatRefs.SendBtn = nil
		chatRefs.ReplyBar = nil
		chatRefs.JumpBtn = nil

		if Z100.UI.HeaderTitle then
			if subMode == "DM" and State.ActiveDM then
				Z100.UI.HeaderTitle.Text = Util.GetAccount(State.ActiveDM).DisplayName
			elseif subMode == "DM_Inbox" then
				Z100.UI.HeaderTitle.Text = "DIRECT MESSAGES"
			elseif subMode == "CloseFriends" then
				Z100.UI.HeaderTitle.Text = "CLOSE FRIENDS"
			else
				Z100.UI.HeaderTitle.Text = "SERVER CHAT"
			end
		end
		if Z100.UI.HeaderSub then
			Z100.UI.HeaderSub.Text = (subMode == "DM" and State.ActiveDM)
				and ("@" .. Util.GetAccount(State.ActiveDM).Username .. " • E2E Encrypted")
				or "Encrypted real-time messaging"
		end

		local root = Instance.new("Frame", host)
		root.Name = "ZaynV100_MessagesRoot"
		root.Size = UDim2.new(1, 0, 1, 0)
		root.BackgroundTransparency = 1
		root.ZIndex = 22

		-- Top Sub-Navigation Tab Bar (Server | Inbox | Close Friends)
		local topWrap = Instance.new("Frame", root)
		topWrap.Size = UDim2.new(1, -24, 0, 38)
		topWrap.Position = UDim2.new(0, 12, 0, 10)
		topWrap.BackgroundTransparency = 1
		topWrap.ZIndex = 24

		local activeTabId = (subMode == "DM") and "DM_Inbox" or subMode
		C.TabBar(topWrap, {
			{ Id = "Server",       Label = "💬 Server Chat" },
			{ Id = "DM_Inbox",     Label = "📩 DM Inbox" },
			{ Id = "CloseFriends", Label = "♥ Close Friends" },
		}, activeTabId, 1, function(tabId)
			State.ChatSubMode = tabId
			if tabId ~= "DM" then State.ActiveDM = nil end
			Z100.Router.Navigate("Messages")
		end)

		local isInputVisible = (subMode == "Server" or (subMode == "DM" and State.ActiveDM ~= nil))
		local topOffset = 56

		-- Optional DM Header Strip (Back to Inbox + Open Profile)
		if subMode == "DM" and State.ActiveDM then
			local dmBar = Instance.new("Frame", root)
			dmBar.Size = UDim2.new(1, -24, 0, 34)
			dmBar.Position = UDim2.new(0, 12, 0, topOffset)
			dmBar.BackgroundColor3 = p.SurfaceElev
			dmBar.ZIndex = 24
			C.Corner(dmBar, Z100.Theme.Tokens.Radius.SM)
			C.Stroke(dmBar, p.Border, 1, 0.45)

			local acc = Util.GetAccount(State.ActiveDM)
			C.Button(dmBar, {
				Size = UDim2.new(0, 68, 0, 24),
				Position = UDim2.new(0, 6, 0.5, -12),
				Variant = "ghost",
				Text = "‹ Inbox",
				TextSize = 10,
				ZIndex = 25,
				OnClick = function()
					State.ChatSubMode = "DM_Inbox"
					State.ActiveDM = nil
					Z100.Router.Navigate("Messages")
				end,
			})

			local tLbl = Instance.new("TextLabel", dmBar)
			tLbl.Size = UDim2.new(1, -162, 1, 0)
			tLbl.Position = UDim2.new(0, 80, 0, 0)
			tLbl.BackgroundTransparency = 1
			tLbl.Font = Z100.Theme.Tokens.Fonts.Title
			tLbl.TextSize = 11
			tLbl.TextColor3 = p.TextPrimary
			tLbl.TextXAlignment = Enum.TextXAlignment.Left
			tLbl.ClipsDescendants = true
			tLbl.Text = acc.DisplayName .. " (@" .. acc.Username .. ")"
			tLbl.ZIndex = 25
			chatRefs.SubTitleLbl = tLbl

			C.Button(dmBar, {
				Size = UDim2.new(0, 74, 0, 24),
				Position = UDim2.new(1, -80, 0.5, -12),
				Variant = "primary",
				Text = "◉ Profile",
				TextSize = 9.5,
				ZIndex = 25,
				OnClick = function()
					if acc.UserId > 1 then Z100.Router.OpenProfile(acc.UserId) end
				end,
			})
			topOffset = topOffset + 40
		end

		-- Optional Inbox Live Search Bar
		local searchBoxRef = nil
		if subMode == "DM_Inbox" then
			local sWrap, sBox = C.TextInput(root, {
				Size = UDim2.new(1, -24, 0, 34),
				Placeholder = "🔍 Search username or UserId to start a DM...",
				ZIndex = 24,
			})
			sWrap.Position = UDim2.new(0, 12, 0, topOffset)
			searchBoxRef = sBox
			topOffset = topOffset + 42
		end

		-- Primary Messages / Inbox Scroll Container
		local bottomReserve = isInputVisible and 58 or 12
		local scroll = Instance.new("ScrollingFrame", root)
		scroll.Name = "MessagesScroll"
		scroll.Size = UDim2.new(1, -24, 1, -(topOffset + bottomReserve))
		scroll.Position = UDim2.new(0, 12, 0, topOffset)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 23
		local sLay = C.ListLayout(scroll, 8)
		C.Padding(scroll, 4, 4, 12, 4)
		C.AttachAutoCanvas(scroll, sLay, 28)
		chatRefs.Scroll = scroll

		-- ================================================================= --
		-- RENDER CONTENT BY SUB-MODE
		-- ================================================================= --
		if subMode == "Server" then
			if #State.Cache.Server == 0 then
				C.EmptyState(scroll, "💬", "Server Chat Ready", "Messages are E2E encrypted per server. Type below or try /help!", nil, nil, 1)
			else
				for _, msg in ipairs(State.Cache.Server) do
					Z100.Chat.RenderBubble(msg.Sender, msg.UserID, msg.Msg, msg.Time, msg.ID, msg.Edited, msg.Reactions)
				end
			end

		elseif subMode == "DM" and State.ActiveDM then
			local msgs = State.Cache.DMs[State.ActiveDM] or {}
			if #msgs == 0 then
				C.EmptyState(scroll, "✉", "Start Conversation", "Send a private E2E encrypted message to @" .. Util.GetAccount(State.ActiveDM).Username, nil, nil, 1)
			else
				for _, msg in ipairs(msgs) do
					Z100.Chat.RenderBubble(msg.Sender, msg.UserID, msg.Msg, msg.Time, msg.ID, msg.Edited, msg.Reactions)
				end
			end
			Z100.Chat.SetLastRead(State.ActiveDM, Util.Now())
			DB.PutAsync(Nodes.ReadReceipts .. "/" .. State.ActiveDM .. "/" .. Z100.MyNameLower, Util.Now())

		elseif subMode == "DM_Inbox" then
			local function renderInbox(filterQ)
				for _, ch in ipairs(scroll:GetChildren()) do
					if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
				end
				local q = tostring(filterQ or ""):gsub("^%s+", ""):gsub("%s+$", "")

				if q ~= "" then
					-- Live Search Mode (Server players + Global Roblox lookup)
					local shown = {}
					local lowQ = q:lower()
					local ord = 1
					local function addSearchUser(disp, uname, uid)
						local card = Instance.new("Frame", scroll)
						card.Size = UDim2.new(1, 0, 0, 52)
						card.BackgroundColor3 = p.Card
						card.LayoutOrder = ord
						card.ZIndex = 24
						C.Corner(card, Z100.Theme.Tokens.Radius.SM)
						C.Stroke(card, p.Border, 1, 0.45)
						ord = ord + 1

						local av = Instance.new("ImageButton", card)
						av.Size = UDim2.new(0, 34, 0, 34)
						av.Position = UDim2.new(0, 9, 0.5, -17)
						av.BackgroundColor3 = p.BgRoot
						av.ScaleType = Enum.ScaleType.Crop
						av.ZIndex = 25
						C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
						Util.LoadAvatarHeadshot(av, uid)
						av.MouseButton1Click:Connect(function() if tonumber(uid) and tonumber(uid) > 1 then Z100.Router.OpenProfile(uid) end end)

						local lbl = Instance.new("TextLabel", card)
						lbl.Size = UDim2.new(1, -162, 1, -6)
						lbl.Position = UDim2.new(0, 50, 0, 3)
						lbl.BackgroundTransparency = 1
						lbl.Font = Z100.Theme.Tokens.Fonts.Body
						lbl.TextSize = 10.5
						lbl.TextColor3 = p.TextPrimary
						lbl.TextXAlignment = Enum.TextXAlignment.Left
						lbl.ClipsDescendants = true
						lbl.RichText = true
						lbl.ZIndex = 25
						lbl.Text = string.format("<b>%s</b>\n<font color='#%s' size='9.5'>@%s</font>",
							Util.EscapeRichText(disp), p.TextSecondary:ToHex(), Util.EscapeRichText(uname))

						C.Button(card, {
							Size = UDim2.new(0, 52, 0, 28),
							Position = UDim2.new(1, -104, 0.5, -14),
							Variant = "primary",
							Text = "DM",
							TextSize = 10,
							ZIndex = 25,
							OnClick = function()
								local key = uname:lower()
								Util.RegisterAccount(uname, disp, uid)
								State.Cache.DMs[key] = State.Cache.DMs[key] or {}
								State.ChatSubMode = "DM"
								State.ActiveDM = key
								Z100.Router.Navigate("Messages")
							end,
						})
						C.Button(card, {
							Size = UDim2.new(0, 42, 0, 28),
							Position = UDim2.new(1, -48, 0.5, -14),
							Variant = "secondary",
							Text = "◉",
							TextSize = 11,
							ZIndex = 25,
							OnClick = function() if tonumber(uid) and tonumber(uid) > 1 then Z100.Router.OpenProfile(uid) end end,
						})
					end

					for _, plr in ipairs(Players:GetPlayers()) do
						if plr ~= Z100.Player and (plr.Name:lower():find(lowQ, 1, true) or plr.DisplayName:lower():find(lowQ, 1, true)) then
							shown[plr.UserId] = true
							addSearchUser(plr.DisplayName, plr.Name, plr.UserId)
						end
					end

					task.spawn(function()
						local res = Util.ResolveUser(q)
						if res and res.UserId and not shown[res.UserId] and res.UserId ~= Z100.Player.UserId and scroll and scroll.Parent then
							addSearchUser(res.DisplayName, res.Username, res.UserId)
						end
					end)
					return
				end

				-- Conversations List
				local rows = {}
				for dmKey, msgs in pairs(State.Cache.DMs) do
					local last = msgs[#msgs]
					table.insert(rows, {
						key = dmKey,
						time = last and last.Time or 0,
						preview = last and last.Msg or "Start chatting...",
						unread = Z100.Chat.GetUnreadCount(dmKey),
					})
				end
				table.sort(rows, function(a, b) return a.time > b.time end)

				if #rows == 0 then
					C.EmptyState(scroll, "📩", "No Conversations Yet", "Search any username above or tap 'Message' on a user's profile.", nil, nil, 1)
					return
				end

				for idx, r in ipairs(rows) do
					local acc = Util.GetAccount(r.key)
					local card = Instance.new("TextButton", scroll)
					card.Size = UDim2.new(1, 0, 0, 54)
					card.BackgroundColor3 = (r.unread > 0) and p.CardHover or p.Card
					card.AutoButtonColor = false
					card.Text = ""
					card.LayoutOrder = idx
					card.ZIndex = 24
					C.Corner(card, Z100.Theme.Tokens.Radius.SM)
					C.Stroke(card, (r.unread > 0) and p.Accent or p.Border, 1.1, (r.unread > 0) and 0.2 or 0.5)
					C.AttachButtonFeedback(card, 1.01)

					local av = Instance.new("ImageLabel", card)
					av.Size = UDim2.new(0, 36, 0, 36)
					av.Position = UDim2.new(0, 9, 0.5, -18)
					av.BackgroundColor3 = p.BgRoot
					av.ScaleType = Enum.ScaleType.Crop
					av.ZIndex = 25
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, acc.UserId)

					local lbl = Instance.new("TextLabel", card)
					lbl.Size = UDim2.new(1, -138, 1, -8)
					lbl.Position = UDim2.new(0, 52, 0, 4)
					lbl.BackgroundTransparency = 1
					lbl.Font = Z100.Theme.Tokens.Fonts.Body
					lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary
					lbl.TextXAlignment = Enum.TextXAlignment.Left
					lbl.ClipsDescendants = true
					lbl.RichText = true
					lbl.ZIndex = 25
					lbl.Text = string.format("<b>%s</b> <font color='#%s' size='9'>@%s</font>\n<font color='#%s' size='9.5'>%s</font>",
						Util.EscapeRichText(acc.DisplayName),
						p.TextMuted:ToHex(),
						Util.EscapeRichText(acc.Username),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(Util.SanitizePreviewText(r.preview):sub(1, 44)))

					if r.unread > 0 then
						local ub = Instance.new("TextLabel", card)
						ub.Size = UDim2.new(0, 48, 0, 20)
						ub.Position = UDim2.new(1, -86, 0.5, -10)
						ub.BackgroundColor3 = p.Accent
						ub.Font = Z100.Theme.Tokens.Fonts.Heading
						ub.TextSize = 9
						ub.TextColor3 = p.AccentText
						ub.Text = r.unread >= 5 and "5+ New" or (tostring(r.unread) .. " New")
						ub.ZIndex = 26
						C.Corner(ub, Z100.Theme.Tokens.Radius.Pill)
					end

					local heart = Instance.new("TextButton", card)
					heart.Size = UDim2.new(0, 28, 0, 28)
					heart.Position = UDim2.new(1, -34, 0.5, -14)
					heart.BackgroundTransparency = 1
					heart.Font = Z100.Theme.Tokens.Fonts.Heading
					heart.TextSize = 18
					heart.Text = "♥"
					heart.ZIndex = 26
					local function syncHeart()
						local isCF = false
						for _, u in ipairs(State.CloseFriends) do if u:lower() == acc.Username:lower() then isCF = true; break end end
						heart.TextColor3 = isCF and Color3.fromRGB(255, 58, 92) or p.TextMuted
					end
					syncHeart()
					heart.MouseButton1Click:Connect(function()
						local idxF = nil
						for i, u in ipairs(State.CloseFriends) do if u:lower() == acc.Username:lower() then idxF = i; break end end
						if idxF then table.remove(State.CloseFriends, idxF) else table.insert(State.CloseFriends, acc.Username) end
						Util.WriteLocalJSON(Z100.LocalFiles.CloseFriends, State.CloseFriends)
						syncHeart()
					end)

					card.MouseButton1Click:Connect(function()
						State.ChatSubMode = "DM"
						State.ActiveDM = r.key
						Z100.Router.Navigate("Messages")
					end)
				end
			end

			renderInbox("")
			if searchBoxRef then
				searchBoxRef:GetPropertyChangedSignal("Text"):Connect(function()
					renderInbox(searchBoxRef.Text)
				end)
			end

		elseif subMode == "CloseFriends" then
			if #State.CloseFriends == 0 then
				C.EmptyState(scroll, "♥", "No Close Friends Yet", "Tap the ♥ icon on any conversation in DM Inbox to pin your Close Friends.", "Open Inbox", function()
					State.ChatSubMode = "DM_Inbox"
					Z100.Router.Navigate("Messages")
				end, 1)
			else
				for idx, uname in ipairs(State.CloseFriends) do
					local acc = Util.GetAccount(uname)
					local card = Instance.new("Frame", scroll)
					card.Size = UDim2.new(1, 0, 0, 52)
					card.BackgroundColor3 = p.Card
					card.LayoutOrder = idx
					card.ZIndex = 24
					C.Corner(card, Z100.Theme.Tokens.Radius.SM)
					C.Stroke(card, p.Border, 1, 0.45)

					local av = Instance.new("ImageButton", card)
					av.Size = UDim2.new(0, 34, 0, 34); av.Position = UDim2.new(0, 9, 0.5, -17)
					av.BackgroundColor3 = p.BgRoot; av.ScaleType = Enum.ScaleType.Crop; av.ZIndex = 25
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, acc.UserId)
					av.MouseButton1Click:Connect(function() if acc.UserId > 1 then Z100.Router.OpenProfile(acc.UserId) end end)

					local lbl = Instance.new("TextLabel", card)
					lbl.Size = UDim2.new(1, -162, 1, -6); lbl.Position = UDim2.new(0, 50, 0, 3)
					lbl.BackgroundTransparency = 1; lbl.Font = Z100.Theme.Tokens.Fonts.Body; lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.RichText = true; lbl.ZIndex = 25
					lbl.Text = string.format("<b>%s</b>\n<font color='#%s' size='9.5'>@%s</font>",
						Util.EscapeRichText(acc.DisplayName), p.TextSecondary:ToHex(), Util.EscapeRichText(acc.Username))

					C.Button(card, {
						Size = UDim2.new(0, 52, 0, 28), Position = UDim2.new(1, -102, 0.5, -14),
						Variant = "primary", Text = "DM", TextSize = 10, ZIndex = 25,
						OnClick = function()
							local key = acc.Username:lower()
							State.Cache.DMs[key] = State.Cache.DMs[key] or {}
							State.ChatSubMode = "DM"
							State.ActiveDM = key
							Z100.Router.Navigate("Messages")
						end,
					})
					C.Button(card, {
						Size = UDim2.new(0, 40, 0, 28), Position = UDim2.new(1, -46, 0.5, -14),
						Variant = "danger", Text = "✕", TextSize = 11, ZIndex = 25,
						OnClick = function()
							table.remove(State.CloseFriends, idx)
							Util.WriteLocalJSON(Z100.LocalFiles.CloseFriends, State.CloseFriends)
							Z100.Router.Navigate("Messages")
						end,
					})
				end
			end
		end

		-- ================================================================= --
		-- COMPOSER BAR, REPLY BAR, STICKERS & IMAGE VAULT TRAYS
		-- ================================================================= --
		if isInputVisible then
			local jumpBtn = C.Button(root, {
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(1, -46, 1, -96),
				Radius = Z100.Theme.Tokens.Radius.Pill,
				Variant = "primary",
				Text = "↓",
				TextSize = 14,
				ZIndex = 34,
				OnClick = function() Z100.Chat.ScrollToBottom(true) end,
			})
			jumpBtn.Visible = false
			chatRefs.JumpBtn = jumpBtn

			local repBar = Instance.new("Frame", root)
			repBar.Size = UDim2.new(1, -24, 0, 28)
			repBar.Position = UDim2.new(0, 12, 1, -86)
			repBar.BackgroundColor3 = p.SurfaceElev
			repBar.Visible = false
			repBar.ZIndex = 35
			C.Corner(repBar, Z100.Theme.Tokens.Radius.SM)
			C.Stroke(repBar, p.Accent, 1, 0.35)
			chatRefs.ReplyBar = repBar

			local repTxt = Instance.new("TextLabel", repBar)
			repTxt.Size = UDim2.new(1, -34, 1, 0); repTxt.Position = UDim2.new(0, 10, 0, 0)
			repTxt.BackgroundTransparency = 1; repTxt.Font = Z100.Theme.Tokens.Fonts.Body; repTxt.TextSize = 10
			repTxt.TextColor3 = p.TextSecondary; repTxt.TextXAlignment = Enum.TextXAlignment.Left; repTxt.RichText = true; repTxt.ClipsDescendants = true; repTxt.ZIndex = 36
			chatRefs.ReplyTxt = repTxt

			local cancelRep = Instance.new("TextButton", repBar)
			cancelRep.Size = UDim2.new(0, 22, 0, 22); cancelRep.Position = UDim2.new(1, -25, 0.5, -11)
			cancelRep.BackgroundColor3 = p.Card; cancelRep.Font = Z100.Theme.Tokens.Fonts.Heading; cancelRep.TextSize = 10
			cancelRep.TextColor3 = p.TextSecondary; cancelRep.Text = "✕"; cancelRep.ZIndex = 36
			C.Corner(cancelRep, Z100.Theme.Tokens.Radius.Pill)
			cancelRep.MouseButton1Click:Connect(Z100.Chat.CancelActionBar)

			-- Sticker Tray
			local sTray = Instance.new("Frame", root)
			sTray.Size = UDim2.new(1, -24, 0, 185)
			sTray.Position = UDim2.new(0, 12, 1, -244)
			sTray.BackgroundColor3 = p.Surface
			sTray.Visible = false
			sTray.ZIndex = 45
			C.Corner(sTray, Z100.Theme.Tokens.Radius.MD)
			C.Stroke(sTray, p.BorderGlow, 1.3, 0.2)
			chatRefs.StickerTray = sTray

			local sSc = Instance.new("ScrollingFrame", sTray)
			sSc.Size = UDim2.new(1, -16, 1, -16); sSc.Position = UDim2.new(0, 8, 0, 8)
			sSc.BackgroundTransparency = 1; sSc.ScrollBarThickness = 2; sSc.ZIndex = 46
			local sg = Instance.new("UIGridLayout", sSc)
			sg.CellSize = UDim2.new(0, 50, 0, 50); sg.CellPadding = UDim2.new(0, 8, 0, 8)
			sg.HorizontalAlignment = Enum.HorizontalAlignment.Center
			for _, stkId in ipairs(Z100.Catalog.Stickers) do
				local sb = Instance.new("ImageButton", sSc)
				sb.BackgroundTransparency = 1
				sb.Image = "rbxthumb://type=Asset&id=" .. stkId .. "&w=150&h=150"
				sb.ScaleType = Enum.ScaleType.Fit
				sb.ZIndex = 47
				C.AttachButtonFeedback(sb, 1.08)
				sb.MouseButton1Click:Connect(function()
					Z100.Chat.Send("[STICKER://" .. stkId .. "]")
					sTray.Visible = false
				end)
			end
			sSc.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#Z100.Catalog.Stickers / 6) * 60)

			-- Image Vault Tray
			local vTray = Instance.new("Frame", root)
			vTray.Size = UDim2.new(1, -24, 0, 195)
			vTray.Position = UDim2.new(0, 12, 1, -254)
			vTray.BackgroundColor3 = p.Surface
			vTray.Visible = false
			vTray.ZIndex = 46
			C.Corner(vTray, Z100.Theme.Tokens.Radius.MD)
			C.Stroke(vTray, p.BorderGlow, 1.3, 0.2)
			chatRefs.VaultTray = vTray

			local _, vUrlBox = C.TextInput(vTray, {
				Size = UDim2.new(1, -90, 0, 30),
				Placeholder = "Paste Image Asset ID or URL...",
				ZIndex = 47,
			})
			vUrlBox.Parent.Position = UDim2.new(0, 8, 0, 8)

			local vSc = Instance.new("ScrollingFrame", vTray)
			vSc.Size = UDim2.new(1, -16, 1, -48); vSc.Position = UDim2.new(0, 8, 0, 44)
			vSc.BackgroundTransparency = 1; vSc.ScrollBarThickness = 2; vSc.ZIndex = 47
			local vg = Instance.new("UIGridLayout", vSc)
			vg.CellSize = UDim2.new(0, 56, 0, 56); vg.CellPadding = UDim2.new(0, 8, 0, 8)

			local function refreshVault()
				for _, ch in ipairs(vSc:GetChildren()) do
					if ch:IsA("ImageButton") or ch:IsA("TextLabel") then ch:Destroy() end
				end
				if #State.Vault == 0 then
					local em = Instance.new("TextLabel", vSc)
					em.Size = UDim2.new(1, 0, 0, 50); em.BackgroundTransparency = 1; em.Font = Z100.Theme.Tokens.Fonts.Body
					em.TextSize = 10; em.TextColor3 = p.TextMuted; em.Text = "Image Vault empty."; em.ZIndex = 48
					return
				end
				for idx, imgRef in ipairs(State.Vault) do
					local ib = Instance.new("ImageButton", vSc)
					ib.BackgroundColor3 = p.Card; ib.ScaleType = Enum.ScaleType.Crop; ib.ZIndex = 48
					C.Corner(ib, Z100.Theme.Tokens.Radius.XS)
					Util.LoadImageSafe(ib, imgRef)
					ib.MouseButton1Click:Connect(function()
						Z100.Chat.Send("[MEDIA::" .. imgRef .. "::MEDIA]")
						vTray.Visible = false
					end)
				end
				vSc.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#State.Vault / 5) * 66)
			end

			C.Button(vTray, {
				Size = UDim2.new(0, 72, 0, 30),
				Position = UDim2.new(1, -78, 0, 8),
				Variant = "primary",
				Text = "+ Save",
				TextSize = 10,
				ZIndex = 47,
				OnClick = function()
					local raw = vUrlBox.Text:match("^%s*(.-)%s*$") or ""
					if raw == "" then return end
					vUrlBox.Text = ""
					table.insert(State.Vault, 1, raw)
					Util.WriteLocalJSON(Z100.LocalFiles.Vault, State.Vault)
					refreshVault()
				end,
			})

			-- Bottom Composer Bar
			local composer = Instance.new("Frame", root)
			composer.Size = UDim2.new(1, -24, 0, 40)
			composer.Position = UDim2.new(0, 12, 1, -48)
			composer.BackgroundColor3 = p.InputBg
			composer.ZIndex = 32
			C.Corner(composer, Z100.Theme.Tokens.Radius.MD)
			C.Stroke(composer, p.Border, 1.2, 0.3)

			local tb = Instance.new("TextBox", composer)
			tb.Size = UDim2.new(1, -120, 1, 0)
			tb.Position = UDim2.new(0, 12, 0, 0)
			tb.BackgroundTransparency = 1
			tb.Font = Z100.Theme.Tokens.Fonts.Body
			tb.TextSize = 12
			tb.TextColor3 = p.TextPrimary
			tb.PlaceholderColor3 = p.TextMuted
			tb.TextXAlignment = Enum.TextXAlignment.Left
			tb.ClearTextOnFocus = false
			tb.Text = ""
			tb.ZIndex = 33
			chatRefs.TextBox = tb

			C.Button(composer, {
				Size = UDim2.new(0, 30, 0, 30),
				Position = UDim2.new(1, -108, 0.5, -15),
				Variant = "ghost",
				Text = "🖼️",
				TextSize = 12,
				ZIndex = 33,
				OnClick = function()
					vTray.Visible = not vTray.Visible
					if vTray.Visible then sTray.Visible = false; refreshVault() end
				end,
			})

			C.Button(composer, {
				Size = UDim2.new(0, 30, 0, 30),
				Position = UDim2.new(1, -74, 0.5, -15),
				Variant = "ghost",
				Text = "🏵️",
				TextSize = 12,
				ZIndex = 33,
				OnClick = function()
					sTray.Visible = not sTray.Visible
					if sTray.Visible then vTray.Visible = false end
				end,
			})

			local sendBtn = C.Button(composer, {
				Size = UDim2.new(0, 34, 0, 30),
				Position = UDim2.new(1, -38, 0.5, -15),
				Variant = "primary",
				Text = "▶",
				TextSize = 13,
				ZIndex = 33,
				OnClick = function()
					local txt = tb.Text
					tb.Text = ""
					Z100.Chat.Send(txt)
				end,
			})
			chatRefs.SendBtn = sendBtn

			tb.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					local txt = tb.Text
					tb.Text = ""
					Z100.Chat.Send(txt)
				end
			end)

			-- Typing indicator for DMs
			local lastTyp = 0
			tb:GetPropertyChangedSignal("Text"):Connect(function()
				if State.ChatSubMode == "DM" and State.ActiveDM and not State.IsLocked then
					local now = os.clock()
					if now - lastTyp > 2.5 and #tb.Text > 0 then
						lastTyp = now
						DB.PutAsync(Nodes.DMs .. "/" .. State.ActiveDM .. "/" .. Z100.MyNameLower .. "/_typ", {
							s = Z100.Player.DisplayName,
							t = Util.Now(),
						})
					end
				end
			end)

			Z100.Chat.SetLockState(State.IsLocked)
			Z100.Chat.ScrollToBottom(true)
		end
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 14 / 15 : PAID STORE SCREEN (₹300 / ₹1500) & NOTIFICATIONS CENTER
-- ========================================================================= --

do
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend

	local storeRenderSeq = 0
	local notifsRenderSeq = 0

	-- ===================================================================== --
	-- [SECTION A : REAL DISCORD PAYMENT VERIFICATION MODAL (NO FAKE UNLOCKS)]
	-- ===================================================================== --
	function Z100.UI.OpenPurchaseModal(itemType, itemId, itemName, priceINR)
		local p = Z100.Theme.Get()
		local cfg = State.StoreConfig
		local discordHandle = tostring(cfg.discordContact or Z100.Config.Store.DiscordContact)
		local discordSrv = tostring(cfg.discordServer or Z100.Config.Store.DiscordServer)
		local finalPrice = math.max(1, math.floor(tonumber(priceINR) or 300))
		local isMusic = (itemType == "music_studio")

		local modal = C.OpenModal({
			Name = "ZaynV100_PurchaseModal",
			Title = "♛ VERIFY PURCHASE — ₹" .. tostring(finalPrice),
			Width = 390,
			AccentColor = isMusic and Color3.fromRGB(0, 235, 195) or p.Gold,
		})
		if not modal then return end

		local infoCard = C.Card(modal.Body, {
			LayoutOrder = 1,
			BackgroundColor3 = p.SurfaceElev,
			PadY = 10,
			PadX = 12,
			ZIndex = modal.Body.ZIndex + 1,
		})

		local infoLbl = Instance.new("TextLabel", infoCard)
		infoLbl.Size = UDim2.new(1, 0, 0, 0)
		infoLbl.AutomaticSize = Enum.AutomaticSize.Y
		infoLbl.BackgroundTransparency = 1
		infoLbl.Font = Z100.Theme.Tokens.Fonts.Body
		infoLbl.TextSize = 10.5
		infoLbl.TextColor3 = p.TextPrimary
		infoLbl.TextXAlignment = Enum.TextXAlignment.Left
		infoLbl.TextWrapped = true
		infoLbl.RichText = true
		infoLbl.ZIndex = infoCard.ZIndex + 1
		infoLbl.Text = string.format(
			"<b>Item:</b> %s  (<b>₹%d ONE-TIME</b>)\n" ..
			"<b>Roblox Account:</b> @%s (UID: %s)\n" ..
			"<b>Owner Discord:</b> <font color='#FFD24C'>@%s</font> (%s)\n\n" ..
			"<font color='#%s'>1. Contact the owner on Discord & complete payment.\n" ..
			"2. Submit your Discord username below to log a ticket.\n" ..
			"3. Admin manually verifies payment & permanently activates your unlock.</font>",
			Util.EscapeRichText(tostring(itemName)),
			finalPrice,
			Util.EscapeRichText(Z100.MyName),
			Z100.MyUid,
			Util.EscapeRichText(discordHandle),
			Util.EscapeRichText(discordSrv),
			p.TextSecondary:ToHex()
		)

		C.Button(modal.Body, {
			Height = 32,
			Variant = "discord",
			Text = "💬 Copy Owner Discord (@" .. discordHandle .. ")",
			TextSize = 10.5,
			LayoutOrder = 2,
			ZIndex = modal.Body.ZIndex + 1,
			OnClick = function()
				local copyTarget = (type(cfg.discordURL) == "string" and cfg.discordURL ~= "") and cfg.discordURL or discordHandle
				Util.CopyText(copyTarget)
				Z100.UI.ShowToast("💬 Discord Copied", "Contact @" .. discordHandle .. " on Discord to verify ₹" .. finalPrice .. " payment.", Color3.fromRGB(88, 101, 242))
			end,
		})

		local _, discBox = C.TextInput(modal.Body, {
			Placeholder = "Your Discord Username (required for Admin verification)...",
			LayoutOrder = 3,
			ZIndex = modal.Body.ZIndex + 1,
		})

		local _, noteBox = C.TextInput(modal.Body, {
			Placeholder = "Optional note / payment reference (e.g. UPI sent on Discord)...",
			LayoutOrder = 4,
			ZIndex = modal.Body.ZIndex + 1,
		})

		local busy = false
		local subBtn
		subBtn = C.Button(modal.Body, {
			Height = 38,
			Variant = "success",
			Text = "🎫 SUBMIT VERIFICATION TICKET (PENDING ADMIN)",
			TextSize = 11,
			LayoutOrder = 5,
			ZIndex = modal.Body.ZIndex + 1,
			OnClick = function()
				if busy then return end
				local dUser = discBox.Text:match("^%s*(.-)%s*$") or ""
				if dUser == "" then
					Z100.UI.ShowToast("⚠️ Discord Required", "Enter your Discord username first.", p.Danger)
					return
				end
				busy = true
				subBtn.Text = "◐ Submitting Ticket..."
				task.spawn(function()
					local ok, res = Backend.SubmitPurchaseTicket(itemType, itemId, itemName, finalPrice, dUser, noteBox.Text)
					busy = false
					if ok then
						modal.Close()
						Z100.UI.ShowToast("🎫 Ticket Logged (" .. tostring(res) .. ")",
							"Status: PENDING VERIFICATION. Contact @" .. discordHandle .. " on Discord — unlocks once Admin approves.",
							p.Gold)
						if State.ActiveScreen == "PremiumStore" then
							Z100.Router.OpenStore(State.StoreTab)
						end
					else
						if subBtn and subBtn.Parent then subBtn.Text = "🎫 SUBMIT VERIFICATION TICKET (PENDING ADMIN)" end
						Z100.UI.ShowToast("⚠️ Failed", tostring(res), p.Danger)
					end
				end)
			end,
		})
	end

	-- ===================================================================== --
	-- [SECTION B : MY PURCHASE TICKETS STATUS LIST]
	-- ===================================================================== --
	local function renderMyTicketsCard(parent, tickets, order)
		local p = Z100.Theme.Get()
		local card = C.Card(parent, {
			Name = "MyPurchaseTickets",
			LayoutOrder = order,
			ZIndex = 24,
		})
		C.SectionHeader(card, "🎫 My Verification Tickets (" .. tostring(#tickets) .. ")", "Live Admin verification status", 1)

		if #tickets == 0 then
			local em = Instance.new("TextLabel", card)
			em.Size = UDim2.new(1, 0, 0, 24)
			em.BackgroundTransparency = 1
			em.Font = Z100.Theme.Tokens.Fonts.Body
			em.TextSize = 10
			em.TextColor3 = p.TextMuted
			em.TextXAlignment = Enum.TextXAlignment.Left
			em.Text = "No purchase verification tickets submitted yet."
			em.LayoutOrder = 2
			em.ZIndex = 25
			return card
		end

		for idx, tk in ipairs(tickets) do
			if idx > 8 then break end
			local st = tostring(tk.status or "pending_verification")
			local stLbl, stCol = "⏳ PENDING VERIFICATION", p.Warning
			if st == "approved" then
				stLbl, stCol = "✅ APPROVED & UNLOCKED", p.Success
			elseif st == "rejected" then
				stLbl, stCol = "❌ REJECTED", p.Danger
			end

			local row = Instance.new("Frame", card)
			row.Size = UDim2.new(1, 0, 0, 46)
			row.BackgroundColor3 = p.SurfaceElev
			row.LayoutOrder = idx + 1
			row.ZIndex = 25
			C.Corner(row, Z100.Theme.Tokens.Radius.SM)

			local lbl = Instance.new("TextLabel", row)
			lbl.Size = UDim2.new(1, -16, 1, -6)
			lbl.Position = UDim2.new(0, 8, 0, 3)
			lbl.BackgroundTransparency = 1
			lbl.Font = Z100.Theme.Tokens.Fonts.Body
			lbl.TextSize = 10
			lbl.TextColor3 = p.TextPrimary
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.TextWrapped = true
			lbl.RichText = true
			lbl.ZIndex = 26
			lbl.Text = string.format("<b>%s (₹%s)</b> — <font color='#%s'><b>%s</b></font>\n<font color='#%s' size='9'>ID: %s • Discord: %s • %s</font>",
				Util.EscapeRichText(tostring(tk.itemName or tk.itemId)),
				tostring(tk.priceINR or 300),
				stCol:ToHex(),
				stLbl,
				p.TextMuted:ToHex(),
				tostring(tk.id),
				Util.EscapeRichText(tostring(tk.discordUser or "N/A")),
				Util.TimeAgo(tk.createdAt))
		end
		return card
	end

	-- ===================================================================== --
	-- [SECTION C : PAID STORE SCREEN RENDERER (100% PAID — ZERO FREE ITEMS)]
	-- ===================================================================== --
	function Z100.Screens.RenderStore(host, tabOverride)
		if not host or not host.Parent then return end

		if type(tabOverride) == "string" and tabOverride ~= "" then
			State.StoreTab = tabOverride
		end
		local activeTab = State.StoreTab or "Decorations"

		storeRenderSeq = storeRenderSeq + 1
		local mySeq = storeRenderSeq
		local p = Z100.Theme.Get()

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "ZAYN PAID STORE" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Cosmetics ₹300 • Online Music Studio ₹1500" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_StoreScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Gold
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		local skel = C.LoadingSkeleton(scroll, 4, 72, 1)

		task.spawn(function()
			Backend.FetchStoreConfig()
			Backend.FetchEntitlements(Z100.MyUid, true)
			local prof = Backend.FetchProfile(Z100.MyUid, true)
			local myTickets = Backend.FetchMyPurchaseTickets()

			if storeRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end
			if not prof then return end

			local hasBundle = Backend.HasCosmeticsBundle(Z100.MyUid)
			local hasMusic = Backend.HasMusicStudioPass(Z100.MyUid)
			local bundlePrice = Backend.GetBundlePrice()
			local musicPrice = Backend.GetMusicPassPrice()
			local discordHandle = tostring(State.StoreConfig.discordContact or Z100.Config.Store.DiscordContact)

			-- 1. STORE TOP TAB BAR
			C.TabBar(scroll, {
				{ Id = "Decorations", Label = "✨ Decor ₹300",             Color = p.Accent,                    ActiveText = p.AccentText },
				{ Id = "Themes",      Label = "🎨 Themes ₹300",            Color = p.Info,                      ActiveText = Color3.fromRGB(10, 14, 22) },
				{ Id = "Bundle",      Label = "♛ Bundle ₹" .. bundlePrice, Color = p.Gold,                      ActiveText = p.GoldDark },
				{ Id = "MusicPass",   Label = "♫ Studio ₹" .. musicPrice,  Color = Color3.fromRGB(0, 225, 185), ActiveText = Color3.fromRGB(8, 16, 18) },
			}, activeTab, 1, function(newTab)
				State.StoreTab = newTab
				Z100.Router.OpenStore(newTab)
			end)

			-- 2. INTERACTIVE LIVE PREVIEW STAGE
			local pvStage, pvGrad, pvAvWrap, pvImg, pvName, pvSub, pvResetBtn
			local function updateLivePreview()
				if not pvStage or not pvStage.Parent then return end
				local tId = State.PreviewTheme or prof.theme or "default_base"
				local dId = State.PreviewDecoration or prof.decoration or "none"
				local tObj = Z100.Catalog.ResolveProfileTheme(tId)
				local dObj = Z100.Catalog.DecorationMap[dId]

				pvStage.BackgroundColor3 = tObj.bg1
				pvGrad.Color = ColorSequence.new(tObj.bg1, tObj.bg2)
				Z100.Anim.ApplyFullProfileEffects(pvStage, pvGrad, tObj, tObj.id ~= "default_base")
				Util.LoadAvatarHeadshot(pvImg, Z100.MyUid, prof.customAvatar)
				Z100.Anim.ApplyAvatarDecoration(pvAvWrap, dId, false)

				pvName.Text = prof.displayName or Z100.Player.DisplayName
				if tObj.id ~= "default_base" then
					Z100.Anim.ApplyGradientText(pvName, tObj.accent, tObj.accent2)
				else
					local oldG = pvName:FindFirstChild("V100TextGrad")
					if oldG then oldG:Destroy() end
					pvName.TextColor3 = tObj.textColor
				end

				local isPreviewing = (State.PreviewTheme ~= nil) or (State.PreviewDecoration ~= nil)
				pvSub.TextColor3 = tObj.subText
				pvSub.Text = string.format("%s\n✨ %s  •  🎨 %s",
					isPreviewing and "👁 LIVE PREVIEW MODE (Equip after purchase)" or "ACTIVE EQUIPPED PROFILE LOOK",
					dObj and dObj.name or "No Decoration",
					tObj.name)
				pvResetBtn.Visible = isPreviewing
			end

			if activeTab == "Decorations" or activeTab == "Themes" or activeTab == "Bundle" then
				pvStage = Instance.new("Frame", scroll)
				pvStage.Name = "StoreLivePreview"
				pvStage.Size = UDim2.new(1, 0, 0, 98)
				pvStage.BackgroundColor3 = p.Card
				pvStage.BorderSizePixel = 0
				pvStage.LayoutOrder = 2
				pvStage.ZIndex = 24
				C.Corner(pvStage, Z100.Theme.Tokens.Radius.LG)

				pvGrad = Instance.new("UIGradient", pvStage)
				pvGrad.Rotation = 135

				pvAvWrap = Instance.new("Frame", pvStage)
				pvAvWrap.Size = UDim2.new(0, 62, 0, 62)
				pvAvWrap.Position = UDim2.new(0, 16, 0.5, -31)
				pvAvWrap.BackgroundColor3 = p.BgRoot
				pvAvWrap.ZIndex = 28
				C.Corner(pvAvWrap, Z100.Theme.Tokens.Radius.Pill)

				pvImg = Instance.new("ImageLabel", pvAvWrap)
				pvImg.Size = UDim2.new(1, -4, 1, -4)
				pvImg.Position = UDim2.new(0.5, 0, 0.5, 0)
				pvImg.AnchorPoint = Vector2.new(0.5, 0.5)
				pvImg.BackgroundTransparency = 1
				pvImg.ScaleType = Enum.ScaleType.Crop
				pvImg.ZIndex = 29
				C.Corner(pvImg, Z100.Theme.Tokens.Radius.Pill)

				pvName = Instance.new("TextLabel", pvStage)
				pvName.Size = UDim2.new(1, -158, 0, 22)
				pvName.Position = UDim2.new(0, 92, 0, 18)
				pvName.BackgroundTransparency = 1
				pvName.Font = Z100.Theme.Tokens.Fonts.Heading
				pvName.TextSize = 15.5
				pvName.TextXAlignment = Enum.TextXAlignment.Left
				pvName.ClipsDescendants = true
				pvName.ZIndex = 28

				pvSub = Instance.new("TextLabel", pvStage)
				pvSub.Size = UDim2.new(1, -108, 0, 34)
				pvSub.Position = UDim2.new(0, 92, 0, 42)
				pvSub.BackgroundTransparency = 1
				pvSub.Font = Z100.Theme.Tokens.Fonts.Body
				pvSub.TextSize = 9.5
				pvSub.TextXAlignment = Enum.TextXAlignment.Left
				pvSub.TextWrapped = true
				pvSub.ZIndex = 28

				pvResetBtn = C.Button(pvStage, {
					Size = UDim2.new(0, 56, 0, 24),
					Position = UDim2.new(1, -66, 0, 10),
					Variant = "danger",
					Text = "Reset",
					TextSize = 9,
					ZIndex = 30,
					OnClick = function()
						State.PreviewDecoration = nil
						State.PreviewTheme = nil
						updateLivePreview()
					end,
				})
				pvResetBtn.Visible = false
				updateLivePreview()
			end

			-- ============================================================= --
			-- TAB 1: AVATAR DECORATIONS (16 ITEMS — ALL ₹300 PAID)
			-- ============================================================= --
			if activeTab == "Decorations" then
				local bar = C.Card(scroll, {
					LayoutOrder = 3,
					FixedHeight = true,
					Size = UDim2.new(1, 0, 0, 38),
					StrokeColor = p.Accent,
					Padding = false,
					UseList = false,
					ZIndex = 24,
				})
				local bLbl = Instance.new("TextLabel", bar)
				bLbl.Size = UDim2.new(1, -110, 1, 0); bLbl.Position = UDim2.new(0, 12, 0, 0)
				bLbl.BackgroundTransparency = 1; bLbl.Font = Z100.Theme.Tokens.Fonts.Title; bLbl.TextSize = 10
				bLbl.TextColor3 = p.TextPrimary; bLbl.TextXAlignment = Enum.TextXAlignment.Left; bLbl.ZIndex = 25
				bLbl.Text = hasBundle
					and "♛ ₹300 Premium Bundle Active — All 16 Avatar Decorations Unlocked!"
					or "💎 All 16 Avatar Decorations are PAID (₹300 each or ₹" .. bundlePrice .. " Bundle)"

				if prof.decoration and prof.decoration ~= "none" then
					C.Button(bar, {
						Size = UDim2.new(0, 92, 0, 26),
						Position = UDim2.new(1, -98, 0.5, -13),
						Variant = "danger",
						Text = "Unequip",
						TextSize = 9.5,
						ZIndex = 25,
						OnClick = function()
							task.spawn(function()
								Backend.SaveMyProfile({ decoration = "none" })
								State.PreviewDecoration = nil
								Z100.Router.OpenStore("Decorations")
							end)
						end,
					})
				end

				local ord = 4
				for _, dItem in ipairs(Z100.Catalog.Decorations) do
					local owned = Backend.OwnsDecoration(Z100.MyUid, dItem.id)
					if Backend.IsDecorationEnabled(dItem.id) or owned then
						local price = Backend.GetDecorationPrice(dItem.id)
						local equipped = (prof.decoration == dItem.id)

						local card = Instance.new("Frame", scroll)
						card.Size = UDim2.new(1, 0, 0, 76)
						card.BackgroundColor3 = p.Card
						card.BorderSizePixel = 0
						card.LayoutOrder = ord
						card.ZIndex = 24
						C.Corner(card, Z100.Theme.Tokens.Radius.MD)
						C.Stroke(card, equipped and p.Success or (owned and dItem.accent or p.Border), equipped and 1.8 or 1.1, 0.25)

						local sw = Instance.new("Frame", card)
						sw.Size = UDim2.new(0, 44, 0, 44); sw.Position = UDim2.new(0, 10, 0.5, -22)
						sw.BackgroundColor3 = p.BgRoot; sw.ZIndex = 25
						C.Corner(sw, Z100.Theme.Tokens.Radius.Pill)
						local swSt = C.Stroke(sw, Color3.fromRGB(255, 255, 255), 2.2, 0)
						Instance.new("UIGradient", swSt).Color = ColorSequence.new(dItem.accent, dItem.secondary)

						local swImg = Instance.new("ImageLabel", sw)
						swImg.Size = UDim2.new(1, -4, 1, -4); swImg.Position = UDim2.new(0.5, 0, 0.5, 0)
						swImg.AnchorPoint = Vector2.new(0.5, 0.5); swImg.BackgroundTransparency = 1; swImg.ScaleType = Enum.ScaleType.Crop; swImg.ZIndex = 26
						C.Corner(swImg, Z100.Theme.Tokens.Radius.Pill)
						Util.LoadAvatarHeadshot(swImg, Z100.MyUid, prof.customAvatar)

						local txt = Instance.new("TextLabel", card)
						txt.Size = UDim2.new(1, -216, 1, -8); txt.Position = UDim2.new(0, 64, 0, 4)
						txt.BackgroundTransparency = 1; txt.Font = Z100.Theme.Tokens.Fonts.Body; txt.TextSize = 10
						txt.TextColor3 = p.TextPrimary; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextWrapped = true; txt.RichText = true; txt.ZIndex = 25
						local statusTag = owned and "<font color='#10D48E'>OWNED</font>" or ("<font color='#FFD24C'>₹" .. price .. " • LOCKED</font>")
						txt.Text = string.format("<b>%s</b>  <font color='#%s' size='9'>[%s]</font>\n%s\n<font color='#%s' size='9'>%s</font>",
							dItem.name, dItem.accent:ToHex(), dItem.tag, statusTag, p.TextSecondary:ToHex(), dItem.description)

						C.Button(card, {
							Size = UDim2.new(0, 60, 0, 28),
							Position = UDim2.new(1, -146, 0.5, -14),
							Variant = "secondary",
							Text = "👁 Preview",
							TextSize = 9.5,
							ZIndex = 26,
							OnClick = function()
								State.PreviewDecoration = dItem.id
								updateLivePreview()
								scroll.CanvasPosition = Vector2.new(0, 0)
							end,
						})

						if owned then
							C.Button(card, {
								Size = UDim2.new(0, 76, 0, 28),
								Position = UDim2.new(1, -82, 0.5, -14),
								Variant = equipped and "success" or "primary",
								Text = equipped and "✓ Unequip" or "⚡ Equip",
								TextSize = 9.5,
								ZIndex = 26,
								OnClick = function()
									task.spawn(function()
										local ok, msg = Backend.SaveMyProfile({ decoration = equipped and "none" or dItem.id })
										State.PreviewDecoration = nil
										Z100.UI.ShowToast(ok and "✨ Updated" or "⚠️ Locked", ok and (equipped and "Decoration unequipped." or (dItem.name .. " equipped!")) or msg, dItem.accent)
										Z100.Router.OpenStore("Decorations")
									end)
								end,
							})
						else
							C.Button(card, {
								Size = UDim2.new(0, 76, 0, 28),
								Position = UDim2.new(1, -82, 0.5, -14),
								Variant = "gold",
								Text = "🛒 ₹" .. tostring(price),
								TextSize = 9.5,
								ZIndex = 26,
								OnClick = function()
									Z100.UI.OpenPurchaseModal("decoration", dItem.id, dItem.name .. " (Avatar Decoration)", price)
								end,
							})
						end
						ord = ord + 1
					end
				end

			-- ============================================================= --
			-- TAB 2: PROFILE THEMES (15 FULL THEMES — ALL ₹300 PAID)
			-- ============================================================= --
			elseif activeTab == "Themes" then
				local bar = C.Card(scroll, {
					LayoutOrder = 3,
					FixedHeight = true,
					Size = UDim2.new(1, 0, 0, 38),
					StrokeColor = p.Info,
					Padding = false,
					UseList = false,
					ZIndex = 24,
				})
				local bLbl = Instance.new("TextLabel", bar)
				bLbl.Size = UDim2.new(1, -110, 1, 0); bLbl.Position = UDim2.new(0, 12, 0, 0)
				bLbl.BackgroundTransparency = 1; bLbl.Font = Z100.Theme.Tokens.Fonts.Title; bLbl.TextSize = 10
				bLbl.TextColor3 = p.TextPrimary; bLbl.TextXAlignment = Enum.TextXAlignment.Left; bLbl.ZIndex = 25
				bLbl.Text = hasBundle
					and "♛ ₹300 Premium Bundle Active — All 15 Profile Themes Unlocked!"
					or "🎨 All 15 Full Profile Themes are PAID (₹300 each or ₹" .. bundlePrice .. " Bundle)"

				if prof.theme and prof.theme ~= "default_base" then
					C.Button(bar, {
						Size = UDim2.new(0, 92, 0, 26),
						Position = UDim2.new(1, -98, 0.5, -13),
						Variant = "danger",
						Text = "Reset Base",
						TextSize = 9.5,
						ZIndex = 25,
						OnClick = function()
							task.spawn(function()
								Backend.SaveMyProfile({ theme = "default_base" })
								State.PreviewTheme = nil
								Z100.Router.OpenStore("Themes")
							end)
						end,
					})
				end

				local ord = 4
				for _, tItem in ipairs(Z100.Catalog.ProfileThemes) do
					local owned = Backend.OwnsTheme(Z100.MyUid, tItem.id)
					if Backend.IsThemeEnabled(tItem.id) or owned then
						local price = Backend.GetThemePrice(tItem.id)
						local equipped = (prof.theme == tItem.id)

						local card = Instance.new("Frame", scroll)
						card.Size = UDim2.new(1, 0, 0, 76)
						card.BackgroundColor3 = tItem.bg1
						card.BorderSizePixel = 0
						card.LayoutOrder = ord
						card.ZIndex = 24
						C.Corner(card, Z100.Theme.Tokens.Radius.MD)
						local tg = Instance.new("UIGradient", card)
						tg.Rotation = 135; tg.Color = ColorSequence.new(tItem.bg1, tItem.bg2)
						C.Stroke(card, equipped and p.Success or tItem.border1, equipped and 1.8 or 1.2, 0.2)

						local txt = Instance.new("TextLabel", card)
						txt.Size = UDim2.new(1, -166, 1, -8); txt.Position = UDim2.new(0, 12, 0, 4)
						txt.BackgroundTransparency = 1; txt.Font = Z100.Theme.Tokens.Fonts.Body; txt.TextSize = 10
						txt.TextColor3 = tItem.textColor; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextWrapped = true; txt.RichText = true; txt.ZIndex = 25
						local statusTag = owned and "<font color='#10D48E'>OWNED</font>" or ("<font color='#FFD24C'>₹" .. price .. " • LOCKED</font>")
						txt.Text = string.format("<b>%s</b>  <font color='#%s' size='9'>[%s]</font>\n%s\n<font color='#%s' size='9'>%s</font>",
							tItem.name, tItem.accent:ToHex(), tItem.tag, statusTag, tItem.subText:ToHex(), tItem.description)

						C.Button(card, {
							Size = UDim2.new(0, 60, 0, 28),
							Position = UDim2.new(1, -146, 0.5, -14),
							Variant = "secondary",
							Text = "👁 Preview",
							TextSize = 9.5,
							ZIndex = 26,
							OnClick = function()
								State.PreviewTheme = tItem.id
								updateLivePreview()
								scroll.CanvasPosition = Vector2.new(0, 0)
							end,
						})

						if owned then
							C.Button(card, {
								Size = UDim2.new(0, 76, 0, 28),
								Position = UDim2.new(1, -82, 0.5, -14),
								BackgroundColor3 = equipped and p.Success or tItem.buttonBg,
								TextColor3 = equipped and Color3.fromRGB(8, 20, 16) or tItem.buttonText,
								Text = equipped and "✓ Unequip" or "⚡ Equip",
								TextSize = 9.5,
								ZIndex = 26,
								OnClick = function()
									task.spawn(function()
										local ok, msg = Backend.SaveMyProfile({ theme = equipped and "default_base" or tItem.id })
										State.PreviewTheme = nil
										Z100.UI.ShowToast(ok and "🎨 Updated" or "⚠️ Locked", ok and (equipped and "Reset to Standard theme." or (tItem.name .. " equipped!")) or msg, tItem.accent)
										Z100.Router.OpenStore("Themes")
									end)
								end,
							})
						else
							C.Button(card, {
								Size = UDim2.new(0, 76, 0, 28),
								Position = UDim2.new(1, -82, 0.5, -14),
								Variant = "gold",
								Text = "🛒 ₹" .. tostring(price),
								TextSize = 9.5,
								ZIndex = 26,
								OnClick = function()
									Z100.UI.OpenPurchaseModal("theme", tItem.id, tItem.name .. " (Profile Theme)", price)
								end,
							})
						end
						ord = ord + 1
					end
				end

			-- ============================================================= --
			-- TAB 3: ZAYN PREMIUM PACKAGE (₹300 ONE-TIME BUNDLE)
			-- ============================================================= --
			elseif activeTab == "Bundle" then
				local card = C.Card(scroll, {
					LayoutOrder = 3,
					BackgroundColor3 = Color3.fromRGB(18, 14, 9),
					StrokeColor = p.Gold,
					StrokeThickness = 1.8,
					HAlign = Enum.HorizontalAlignment.Center,
					PadY = 16,
					PadX = 16,
					ListGap = 10,
					ZIndex = 24,
				})

				local pill = Instance.new("TextLabel", card)
				pill.Size = UDim2.new(0, 205, 0, 24)
				pill.BackgroundColor3 = hasBundle and p.Success or p.Gold
				pill.Font = Z100.Theme.Tokens.Fonts.Heading
				pill.TextSize = 10
				pill.TextColor3 = p.GoldDark
				pill.Text = hasBundle and "✅ ACTIVATED ON YOUR ACCOUNT" or ("♛ ₹" .. tostring(bundlePrice) .. " ONE-TIME PACKAGE")
				pill.LayoutOrder = 1
				pill.ZIndex = 25
				C.Corner(pill, Z100.Theme.Tokens.Radius.Pill)

				local title = Instance.new("TextLabel", card)
				title.Size = UDim2.new(1, 0, 0, 26); title.BackgroundTransparency = 1
				title.Font = Z100.Theme.Tokens.Fonts.Heading; title.TextSize = 18
				title.Text = "ZAYN PREMIUM PACKAGE"; title.LayoutOrder = 2; title.ZIndex = 25
				Z100.Anim.ApplyGradientText(title, Color3.fromRGB(255, 228, 100), Color3.fromRGB(255, 148, 30))

				local desc = Instance.new("TextLabel", card)
				desc.Size = UDim2.new(1, 0, 0, 0); desc.AutomaticSize = Enum.AutomaticSize.Y
				desc.BackgroundTransparency = 1; desc.Font = Z100.Theme.Tokens.Fonts.Body; desc.TextSize = 10.5
				desc.TextColor3 = Color3.fromRGB(246, 238, 220); desc.TextWrapped = true; desc.TextXAlignment = Enum.TextXAlignment.Left; desc.RichText = true
				desc.LayoutOrder = 3; desc.ZIndex = 25
				desc.Text = string.format(
					"<b>Includes the complete V100 Cosmetics Bundle (₹%d ONE-TIME):</b>\n" ..
					"✦ All <b>16 Premium Avatar Decorations</b> (Rings, Auras, Halo, Horns, Wings)\n" ..
					"✦ All <b>15 Full Profile Theme Packs</b> (Royal Gold, Dark Emperor, Galaxy, Cyber...)\n" ..
					"✦ Full Royal Gold Premium UI Mode in Settings\n" ..
					"✦ Permanent <b>💎 VIP</b> & <b>⚡ ELITE</b> Animated Profile Badges\n" ..
					"✦ Permanently saved across all servers & rejoins\n\n" ..
					"<font color='#C9B58C' size='9.5'>Note: Online Music Studio Pro (₹%d) is sold separately in the Studio tab.</font>",
					bundlePrice, musicPrice
				)

				local btnRow = Instance.new("Frame", card)
				btnRow.Size = UDim2.new(1, 0, 0, 36); btnRow.BackgroundTransparency = 1; btnRow.LayoutOrder = 4; btnRow.ZIndex = 25

				C.Button(btnRow, {
					Size = UDim2.new(0.56, -3, 1, 0),
					Variant = hasBundle and "success" or "gold",
					Text = hasBundle and "✅ BUNDLE OWNED" or ("🛒 BUY NOW — ₹" .. tostring(bundlePrice)),
					TextSize = 11,
					ZIndex = 26,
					OnClick = function()
						if hasBundle then Z100.Router.OpenStore("Decorations")
						else Z100.UI.OpenPurchaseModal("cosmetics_bundle", "zayn_premium_300", "ZAYN Premium Cosmetics Package", bundlePrice) end
					end,
				})

				C.Button(btnRow, {
					Size = UDim2.new(0.44, -3, 1, 0),
					Position = UDim2.new(0.56, 6, 0, 0),
					Variant = "discord",
					Text = "💬 Discord Owner",
					TextSize = 10.5,
					ZIndex = 26,
					OnClick = function()
						Util.CopyText(discordHandle)
						Z100.UI.ShowToast("💬 Discord Copied", "Contact @" .. discordHandle .. " on Discord.", Color3.fromRGB(88, 101, 242))
					end,
				})

				renderMyTicketsCard(scroll, myTickets, 4)

			-- ============================================================= --
			-- TAB 4: ONLINE MUSIC STUDIO PRO PASS (₹1500 ONE-TIME)
			-- ============================================================= --
			elseif activeTab == "MusicPass" then
				local card = C.Card(scroll, {
					LayoutOrder = 2,
					BackgroundColor3 = Color3.fromRGB(10, 16, 26),
					StrokeColor = Color3.fromRGB(0, 232, 192),
					StrokeThickness = 1.8,
					HAlign = Enum.HorizontalAlignment.Center,
					PadY = 16,
					PadX = 16,
					ListGap = 10,
					ZIndex = 24,
				})

				local pill = Instance.new("TextLabel", card)
				pill.Size = UDim2.new(0, 215, 0, 24)
				pill.BackgroundColor3 = hasMusic and p.Success or Color3.fromRGB(0, 228, 190)
				pill.Font = Z100.Theme.Tokens.Fonts.Heading
				pill.TextSize = 10
				pill.TextColor3 = Color3.fromRGB(8, 16, 20)
				pill.Text = hasMusic and "✅ MUSIC STUDIO UNLOCKED" or ("♫ EXCLUSIVE PASS • ₹" .. tostring(musicPrice) .. " ONE-TIME")
				pill.LayoutOrder = 1
				pill.ZIndex = 25
				C.Corner(pill, Z100.Theme.Tokens.Radius.Pill)

				local title = Instance.new("TextLabel", card)
				title.Size = UDim2.new(1, 0, 0, 26); title.BackgroundTransparency = 1
				title.Font = Z100.Theme.Tokens.Fonts.Heading; title.TextSize = 18
				title.Text = "♫ ZAYN ONLINE MUSIC STUDIO PRO"; title.LayoutOrder = 2; title.ZIndex = 25
				Z100.Anim.ApplyGradientText(title, Color3.fromRGB(0, 245, 198), Color3.fromRGB(72, 188, 255))

				local desc = Instance.new("TextLabel", card)
				desc.Size = UDim2.new(1, 0, 0, 0); desc.AutomaticSize = Enum.AutomaticSize.Y
				desc.BackgroundTransparency = 1; desc.Font = Z100.Theme.Tokens.Fonts.Body; desc.TextSize = 10.5
				desc.TextColor3 = Color3.fromRGB(220, 242, 248); desc.TextWrapped = true; desc.TextXAlignment = Enum.TextXAlignment.Left; desc.RichText = true
				desc.LayoutOrder = 3; desc.ZIndex = 25
				desc.Text = string.format(
					"<b>Unlock the Online YouTube MP3 Music Studio (₹%d ONE-TIME):</b>\n" ..
					"✦ Search any song online live via YouTube MP3 API\n" ..
					"✦ Stream & preview tracks directly inside your executor\n" ..
					"✦ Permanent cloud <b>My Music Library</b> saved across sessions\n" ..
					"✦ Attach online songs with Start Position & Volume to 24h Stories\n" ..
					"✦ Permanent <b>♫ STUDIO</b> Animated Profile Badge",
					musicPrice
				)

				local btnRow = Instance.new("Frame", card)
				btnRow.Size = UDim2.new(1, 0, 0, 36); btnRow.BackgroundTransparency = 1; btnRow.LayoutOrder = 4; btnRow.ZIndex = 25

				C.Button(btnRow, {
					Size = UDim2.new(0.56, -3, 1, 0),
					BackgroundColor3 = Color3.fromRGB(0, 212, 168),
					TextColor3 = Color3.fromRGB(8, 18, 18),
					Text = hasMusic and "♫ OPEN MUSIC STUDIO" or ("🛒 BUY STUDIO — ₹" .. tostring(musicPrice)),
					TextSize = 11,
					ZIndex = 26,
					OnClick = function()
						if hasMusic then Z100.Router.Navigate("MusicStudio")
						else Z100.UI.OpenPurchaseModal("music_studio", "zayn_music_studio_1500", "ZAYN Online Music Studio Pro", musicPrice) end
					end,
				})

				C.Button(btnRow, {
					Size = UDim2.new(0.44, -3, 1, 0),
					Position = UDim2.new(0.56, 6, 0, 0),
					Variant = "discord",
					Text = "💬 Discord Owner",
					TextSize = 10.5,
					ZIndex = 26,
					OnClick = function()
						Util.CopyText(discordHandle)
						Z100.UI.ShowToast("💬 Discord Copied", "Contact @" .. discordHandle .. " on Discord.", Color3.fromRGB(88, 101, 242))
					end,
				})

				renderMyTicketsCard(scroll, myTickets, 3)
			end
		end)
	end

	-- ===================================================================== --
	-- [SECTION D : NOTIFICATIONS CENTER SCREEN]
	-- ===================================================================== --
	function Z100.Screens.RenderNotifications(host)
		if not host or not host.Parent then return end

		notifsRenderSeq = notifsRenderSeq + 1
		local mySeq = notifsRenderSeq
		local p = Z100.Theme.Get()

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "NOTIFICATIONS" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Followers, story reactions, messages & store alerts" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_NotifsScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 10, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 28)

		local skel = C.LoadingSkeleton(scroll, 4, 58, 1)

		task.spawn(function()
			local notifs = Backend.FetchMyNotifs(true)
			local reqs = Backend.FetchMyRequests()

			if notifsRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
			if skel and skel.Parent then skel:Destroy() end

			-- Top Actions Row
			local topBar = Instance.new("Frame", scroll)
			topBar.Size = UDim2.new(1, 0, 0, 34)
			topBar.BackgroundTransparency = 1
			topBar.LayoutOrder = 1
			topBar.ZIndex = 24

			C.Button(topBar, {
				Size = UDim2.new(0.55, -3, 1, 0),
				Variant = "primary",
				Text = "✅ Mark All Read",
				TextSize = 10.5,
				ZIndex = 25,
				OnClick = function()
					Backend.MarkAllNotifsRead()
					Z100.Router.Navigate("Notifications")
				end,
			})
			C.Button(topBar, {
				Size = UDim2.new(0.45, -3, 1, 0),
				Position = UDim2.new(0.55, 6, 0, 0),
				Variant = "secondary",
				Text = "🔄 Refresh",
				TextSize = 10.5,
				ZIndex = 25,
				OnClick = function() Z100.Router.Navigate("Notifications") end,
			})

			local ord = 2

			-- Pending Follow Requests Section
			local reqList = {}
			for rUid, rData in pairs(reqs) do
				if type(rData) == "table" then
					table.insert(reqList, {
						uid = tostring(rUid),
						username = tostring(rData.username or "User"),
						displayName = tostring(rData.displayName or rData.username or "User"),
						time = tonumber(rData.time) or 0,
					})
				end
			end
			table.sort(reqList, function(a, b) return a.time > b.time end)

			if #reqList > 0 then
				local reqCard = C.Card(scroll, {
					LayoutOrder = ord,
					StrokeColor = p.Accent,
					ZIndex = 24,
				})
				ord = ord + 1
				C.SectionHeader(reqCard, "📩 Pending Follow Requests (" .. tostring(#reqList) .. ")", nil, 1)

				for idx, r in ipairs(reqList) do
					local row = Instance.new("Frame", reqCard)
					row.Size = UDim2.new(1, 0, 0, 46)
					row.BackgroundColor3 = p.SurfaceElev
					row.LayoutOrder = idx + 1
					row.ZIndex = 25
					C.Corner(row, Z100.Theme.Tokens.Radius.SM)

					local av = Instance.new("ImageButton", row)
					av.Size = UDim2.new(0, 32, 0, 32); av.Position = UDim2.new(0, 8, 0.5, -16)
					av.BackgroundColor3 = p.BgRoot; av.ScaleType = Enum.ScaleType.Crop; av.ZIndex = 26
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, r.uid)
					av.MouseButton1Click:Connect(function() Z100.Router.OpenProfile(r.uid) end)

					local lbl = Instance.new("TextLabel", row)
					lbl.Size = UDim2.new(1, -150, 1, -4); lbl.Position = UDim2.new(0, 46, 0, 2)
					lbl.BackgroundTransparency = 1; lbl.Font = Z100.Theme.Tokens.Fonts.Title; lbl.TextSize = 10.5
					lbl.TextColor3 = p.TextPrimary; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ClipsDescendants = true; lbl.RichText = true; lbl.ZIndex = 26
					lbl.Text = string.format("%s\n<font color='#%s' size='9'>@%s • %s</font>",
						Util.EscapeRichText(r.displayName), p.TextMuted:ToHex(), Util.EscapeRichText(r.username), Util.TimeAgo(r.time))

					C.Button(row, {
						Size = UDim2.new(0, 60, 0, 26), Position = UDim2.new(1, -98, 0.5, -13),
						Variant = "success", Text = "✓ Accept", TextSize = 9.5, ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								Backend.AcceptFollowRequest(r.uid)
								Z100.Router.Navigate("Notifications")
							end)
						end,
					})
					C.Button(row, {
						Size = UDim2.new(0, 30, 0, 26), Position = UDim2.new(1, -34, 0.5, -13),
						Variant = "danger", Text = "✕", TextSize = 10, ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								Backend.DeclineFollowRequest(r.uid)
								Z100.Router.Navigate("Notifications")
							end)
						end,
					})
				end
			end

			-- Notifications Feed
			if #notifs == 0 then
				C.EmptyState(scroll, "🔔", "All Caught Up", "You have no notifications right now.", nil, nil, ord)
			else
				for idx, item in ipairs(notifs) do
					local unread = (item.read ~= true)
					local card = Instance.new("TextButton", scroll)
					card.Size = UDim2.new(1, 0, 0, 58)
					card.BackgroundColor3 = unread and p.CardHover or p.Card
					card.AutoButtonColor = false
					card.Text = ""
					card.LayoutOrder = ord + idx
					card.ZIndex = 24
					C.Corner(card, Z100.Theme.Tokens.Radius.SM)
					C.Stroke(card, unread and p.Accent or p.Border, 1.1, unread and 0.2 or 0.55)
					C.AttachButtonFeedback(card, 1.01)

					local av = Instance.new("ImageLabel", card)
					av.Size = UDim2.new(0, 34, 0, 34); av.Position = UDim2.new(0, 10, 0.5, -17)
					av.BackgroundColor3 = p.BgRoot; av.ScaleType = Enum.ScaleType.Crop; av.ZIndex = 25
					C.Corner(av, Z100.Theme.Tokens.Radius.Pill)
					Util.LoadAvatarHeadshot(av, item.fromUid)

					local txt = Instance.new("TextLabel", card)
					txt.Size = UDim2.new(1, -60, 1, -8); txt.Position = UDim2.new(0, 52, 0, 4)
					txt.BackgroundTransparency = 1; txt.Font = Z100.Theme.Tokens.Fonts.Body; txt.TextSize = 10
					txt.TextColor3 = p.TextPrimary; txt.TextXAlignment = Enum.TextXAlignment.Left; txt.TextWrapped = true; txt.RichText = true; txt.ZIndex = 25
					txt.Text = string.format("<b>%s</b>  <font color='#%s' size='9'>• %s</font>\n<font color='#%s'>%s</font>",
						Util.EscapeRichText(tostring(item.title)),
						p.TextMuted:ToHex(),
						Util.TimeAgo(item.timestamp),
						p.TextSecondary:ToHex(),
						Util.EscapeRichText(tostring(item.message)))

					card.MouseButton1Click:Connect(function()
						if unread and item.id then
							Backend.MarkNotifRead(item.id)
						end
						if item.type == "purchase_approved" then
							Z100.Router.OpenStore("Decorations")
						elseif item.fromUid and tonumber(item.fromUid) and tonumber(item.fromUid) > 1 then
							Z100.Router.OpenProfile(item.fromUid)
						end
					end)
				end
			end
		end)
	end
end
-- ========================================================================= --
--  👑 ZAYN SOCIAL V100 — TITANGUARD ULTIMATE (UNIVERSAL EXECUTOR BUILD)
--  PART 15 / 15 : SETTINGS, ADMIN PANEL, ROUTER, ZERO-LAG SYNC & FINAL BOOT
-- ========================================================================= --

do
	local Players = Z100.Services.Players
	local C = Z100.Components
	local State = Z100.State
	local Util = Z100.Util
	local Backend = Z100.Backend
	local Crypto = Z100.Crypto
	local DB = Z100.DB
	local Nodes = Z100.Nodes
	local ENV = (type(getgenv) == "function" and getgenv()) or _G

	local adminRenderSeq = 0
	Z100.Admin.SelectedUser = nil

	-- ===================================================================== --
	-- [SECTION A : SETTINGS SCREEN (APPEARANCE, AUDIO, ALERTS & ACCOUNT)]
	-- ===================================================================== --
	function Z100.Screens.RenderSettings(host)
		if not host or not host.Parent then return end

		local p = Z100.Theme.Get()
		local prefs = State.Prefs

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "SETTINGS" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Appearance, performance, audio & account" end

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_SettingsScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Accent
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		local hasBundle = Backend.HasCosmeticsBundle(Z100.MyUid)
		local hasMusic = Backend.HasMusicStudioPass(Z100.MyUid)

		-- 1. APPEARANCE & PERFORMANCE CARD
		local appCard = C.Card(scroll, { Name = "SettingsAppearance", LayoutOrder = 1, ZIndex = 24 })
		C.SectionHeader(appCard, "🎨 Appearance & Performance", "Theme mode, motion & responsive UI scale", 1)

		local modeBtn
		modeBtn = C.Button(appCard, {
			Variant = (prefs.DesignMode == "Premium") and "gold" or "secondary",
			Text = "Design Mode: " .. tostring(prefs.DesignMode) .. (hasBundle and "  (Tap to switch Standard / Royal Gold)" or "  (Royal Gold requires ₹300 Bundle)"),
			TextSize = 10.5,
			LayoutOrder = 2,
			ZIndex = 25,
			OnClick = function()
				if prefs.DesignMode == "Standard" then
					if not hasBundle and not Util.IsAdmin() then
						Z100.UI.ShowToast("🔒 Royal Gold Locked", "Unlock the ₹" .. tostring(Backend.GetBundlePrice()) .. " Premium Package in Paid Store.", p.Gold)
						Z100.Router.OpenStore("Bundle")
						return
					end
					prefs.DesignMode = "Premium"
				else
					prefs.DesignMode = "Standard"
				end
				Util.SavePrefs()
				Z100.UI.ApplyDesignTheme()
				Z100.Router.Navigate("Settings", nil, true)
			end,
		})

		local intensities = { "High", "Medium", "Low" }
		local intIdx = 1
		for i, v in ipairs(intensities) do if v == prefs.AnimIntensity then intIdx = i; break end end
		local intBtn
		intBtn = C.Button(appCard, {
			Variant = "ghost",
			Text = "✨ Animation Intensity: " .. tostring(prefs.AnimIntensity) .. "  (Tap to cycle)",
			TextSize = 10.5,
			LayoutOrder = 3,
			ZIndex = 25,
			OnClick = function()
				intIdx = (intIdx % #intensities) + 1
				prefs.AnimIntensity = intensities[intIdx]
				Util.SavePrefs()
				intBtn.Text = "✨ Animation Intensity: " .. tostring(prefs.AnimIntensity) .. "  (Tap to cycle)"
			end,
		})

		C.ToggleRow(appCard, "Reduce Motion", "Minimize UI tweens and heavy animations for low-end devices", prefs.ReduceMotion, 4, function(v)
			prefs.ReduceMotion = v
			Util.SavePrefs()
		end)

		C.ToggleRow(appCard, "Particle & Ambient Effects", "Enable floating particles, sparkles & light sweeps on profiles", prefs.ParticlesEnabled, 5, function(v)
			prefs.ParticlesEnabled = v
			Util.SavePrefs()
		end)

		local scales = { 0.85, 1.0, 1.15 }
		local scIdx = 2
		for i, v in ipairs(scales) do if math.abs(v - (prefs.UIScale or 1.0)) < 0.05 then scIdx = i; break end end
		local scBtn
		scBtn = C.Button(appCard, {
			Variant = "ghost",
			Text = "📐 UI Window Scale: " .. tostring(math.floor((prefs.UIScale or 1.0) * 100)) .. "%  (Tap to cycle)",
			TextSize = 10.5,
			LayoutOrder = 6,
			ZIndex = 25,
			OnClick = function()
				scIdx = (scIdx % #scales) + 1
				prefs.UIScale = scales[scIdx]
				Util.SavePrefs()
				scBtn.Text = "📐 UI Window Scale: " .. tostring(math.floor(prefs.UIScale * 100)) .. "%  (Tap to cycle)"
				Z100.UI.NotifyResponsive()
			end,
		})

		-- 2. NOTIFICATIONS CARD
		local notifCard = C.Card(scroll, { Name = "SettingsNotifs", LayoutOrder = 2, ZIndex = 24 })
		C.SectionHeader(notifCard, "🔔 Notification Preferences", "Control live toast popups", 1)

		C.ToggleRow(notifCard, "Message Notifications", "Show toast alerts for incoming Server & DM messages", prefs.NotifyMessages, 2, function(v)
			prefs.NotifyMessages = v; Util.SavePrefs()
		end)
		C.ToggleRow(notifCard, "Follow & Request Alerts", "Show alerts when someone follows or requests you", prefs.NotifyFollows, 3, function(v)
			prefs.NotifyFollows = v; Util.SavePrefs()
		end)
		C.ToggleRow(notifCard, "Story Reactions & Replies", "Show alerts for story interactions", prefs.NotifyStories, 4, function(v)
			prefs.NotifyStories = v; Util.SavePrefs()
		end)

		-- 3. AUDIO SETTINGS CARD
		local audCard = C.Card(scroll, { Name = "SettingsAudio", LayoutOrder = 3, ZIndex = 24 })
		C.SectionHeader(audCard, "♫ Audio & Music Studio", "Control online MP3 & story sound", 1)

		local vols = { 0.35, 0.7, 1.0 }
		local vIdx = 2
		for i, v in ipairs(vols) do if math.abs(v - (prefs.MusicVolume or 0.7)) < 0.1 then vIdx = i; break end end
		local volBtn
		volBtn = C.Button(audCard, {
			Variant = "ghost",
			Text = "🔊 Default Music Volume: " .. tostring(math.floor((prefs.MusicVolume or 0.7) * 100)) .. "%  (Tap to cycle)",
			TextSize = 10.5,
			LayoutOrder = 2,
			ZIndex = 25,
			OnClick = function()
				vIdx = (vIdx % #vols) + 1
				prefs.MusicVolume = vols[vIdx]
				Util.SavePrefs()
				volBtn.Text = "🔊 Default Music Volume: " .. tostring(math.floor(prefs.MusicVolume * 100)) .. "%  (Tap to cycle)"
				if Z100.Music.ActiveSound and Z100.Music.ActiveSound.Parent then
					Z100.Music.ActiveSound.Volume = prefs.MusicVolume
				end
			end,
		})

		C.ToggleRow(audCard, "Story Audio Autoplay", "Automatically play attached online music when viewing stories", prefs.StoryAudioEnabled, 3, function(v)
			prefs.StoryAudioEnabled = v; Util.SavePrefs()
		end)
		C.ToggleRow(audCard, "Mute All App Audio", "Silence Music Studio & Story audio globally", prefs.MuteAllAudio, 4, function(v)
			prefs.MuteAllAudio = v; Util.SavePrefs()
			if v then Z100.Music.StopAudio() end
		end)

		-- 4. ACCOUNT, OWNERSHIP & ADMIN ACCESS CARD
		local accCard = C.Card(scroll, { Name = "SettingsAccount", LayoutOrder = 4, ZIndex = 24 })
		C.SectionHeader(accCard, "◉ Account & Ownership", "Executor: " .. tostring(Z100.Exec.Name) .. " • " .. Z100.Version, 1)

		local statusLbl = Instance.new("TextLabel", accCard)
		statusLbl.Size = UDim2.new(1, 0, 0, 0)
		statusLbl.AutomaticSize = Enum.AutomaticSize.Y
		statusLbl.BackgroundTransparency = 1
		statusLbl.Font = Z100.Theme.Tokens.Fonts.Body
		statusLbl.TextSize = 10.5
		statusLbl.TextColor3 = p.TextPrimary
		statusLbl.TextXAlignment = Enum.TextXAlignment.Left
		statusLbl.TextWrapped = true
		statusLbl.RichText = true
		statusLbl.LayoutOrder = 2
		statusLbl.ZIndex = 25
		statusLbl.Text = string.format(
			"<b>Account:</b> @%s (UID: %s)\n" ..
			"<b>₹300 Premium Cosmetics Bundle:</b> %s\n" ..
			"<b>₹1500 Online Music Studio Pass:</b> %s",
			Util.EscapeRichText(Z100.MyName),
			Z100.MyUid,
			hasBundle and "<font color='#10D48E'><b>OWNED ✅</b></font>" or "<font color='#FF6070'>LOCKED</font>",
			hasMusic and "<font color='#10D48E'><b>OWNED ✅</b></font>" or "<font color='#FF6070'>LOCKED</font>"
		)

		C.Button(accCard, {
			Variant = "primary",
			Text = "✎ Open Profile Editor & Privacy",
			TextSize = 10.5,
			LayoutOrder = 3,
			ZIndex = 25,
			OnClick = function() Z100.Router.Navigate("ProfileEditor") end,
		})

		C.Button(accCard, {
			Variant = "discord",
			Text = "💬 Copy Support Discord (@" .. tostring(State.StoreConfig.discordContact) .. ")",
			TextSize = 10.5,
			LayoutOrder = 4,
			ZIndex = 25,
			OnClick = function()
				Util.CopyText(State.StoreConfig.discordContact)
				Z100.UI.ShowToast("💬 Copied", "Support Discord @" .. tostring(State.StoreConfig.discordContact) .. " copied.", Color3.fromRGB(88, 101, 242))
			end,
		})

		if Util.IsAdmin() then
			C.Button(accCard, {
				Variant = "danger",
				Text = "🛡️ OPEN OWNER ADMIN CONTROL PANEL",
				TextSize = 11,
				LayoutOrder = 5,
				ZIndex = 25,
				OnClick = function() Z100.Router.Navigate("Admin") end,
			})
		end
	end

	-- ===================================================================== --
	-- [SECTION B : SECURE OWNER-ONLY ADMIN CONTROL PANEL (4 TABS)]
	-- ===================================================================== --
	function Z100.Screens.RenderAdmin(host, tabOverride)
		if not host or not host.Parent then return end

		local p = Z100.Theme.Get()
		if not Util.IsAdmin() then
			Z100.Security.LogViolation("ADMIN_PANEL_ATTEMPT", "Unauthorized user tried opening V100 Admin Panel")
			C.ErrorState(host, "⛔ ACCESS DENIED — Authorized Owner UID required.", function()
				Z100.Router.Navigate("Home", nil, true)
			end, 1)
			return
		end

		if type(tabOverride) == "string" and tabOverride ~= "" then
			State.AdminTab = tabOverride
		end
		local activeTab = State.AdminTab or "Tickets"

		if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "ADMIN CONTROL PANEL" end
		if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "Owner Dashboard • @" .. Z100.MyName end

		adminRenderSeq = adminRenderSeq + 1
		local mySeq = adminRenderSeq

		local scroll = Instance.new("ScrollingFrame", host)
		scroll.Name = "ZaynV100_AdminScroll"
		scroll.Size = UDim2.new(1, 0, 1, 0)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 3
		scroll.ScrollBarImageColor3 = p.Danger
		scroll.ZIndex = 22

		local list = C.ListLayout(scroll, 12, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center)
		C.Padding(scroll, 12, 14, 24, 14)
		C.AttachAutoCanvas(scroll, list, 30)

		C.TabBar(scroll, {
			{ Id = "Tickets",    Label = "🎫 Tickets", Color = p.Gold,                       ActiveText = p.GoldDark },
			{ Id = "Users",      Label = "◉ Users",    Color = p.Accent,                     ActiveText = p.AccentText },
			{ Id = "Store",      Label = "⚙ Store",    Color = Color3.fromRGB(0, 220, 185),  ActiveText = Color3.fromRGB(8, 16, 18) },
			{ Id = "Moderation", Label = "🛡️ Mod",     Color = p.Danger,                     ActiveText = Color3.fromRGB(255, 255, 255) },
		}, activeTab, 1, function(newTab)
			State.AdminTab = newTab
			Z100.Router.Navigate("Admin", newTab, true)
		end)

		local skel = C.LoadingSkeleton(scroll, 3, 72, 2)

		task.spawn(function()
			-- TAB 1: PURCHASE VERIFICATION TICKETS
			if activeTab == "Tickets" then
				local tickets = Backend.AdminFetchPurchaseTickets()
				if adminRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
				if skel and skel.Parent then skel:Destroy() end

				local pending = 0
				for _, tk in ipairs(tickets) do if tostring(tk.status) == "pending_verification" then pending = pending + 1 end end

				local box = C.Card(scroll, { LayoutOrder = 2, StrokeColor = p.Gold, ZIndex = 24 })
				C.SectionHeader(box, "🎫 Purchase Tickets (" .. pending .. " Pending / " .. #tickets .. " Total)", "Approve to permanently unlock on buyer's account", 1)

				if #tickets == 0 then
					C.EmptyState(box, "🎫", "No Tickets Yet", "Submitted ₹300 & ₹1500 verification tickets will appear here.", nil, nil, 2)
					return
				end

				for idx, tk in ipairs(tickets) do
					if idx > 25 then break end
					local st = tostring(tk.status or "pending_verification")
					local isPend = (st == "pending_verification")

					local card = Instance.new("Frame", box)
					card.Size = UDim2.new(1, 0, 0, isPend and 94 or 58)
					card.BackgroundColor3 = p.SurfaceElev
					card.LayoutOrder = idx + 1
					card.ZIndex = 25
					C.Corner(card, Z100.Theme.Tokens.Radius.SM)
					C.Stroke(card, isPend and p.Gold or (st == "approved" and p.Success or p.Danger), 1.1, 0.3)

					local info = Instance.new("TextLabel", card)
					info.Size = UDim2.new(1, -16, 0, 50); info.Position = UDim2.new(0, 8, 0, 4)
					info.BackgroundTransparency = 1; info.Font = Z100.Theme.Tokens.Fonts.Body; info.TextSize = 10
					info.TextColor3 = p.TextPrimary; info.TextXAlignment = Enum.TextXAlignment.Left; info.TextWrapped = true; info.RichText = true; info.ZIndex = 26
					local noteStr = (tk.note and tk.note ~= "") and (" • " .. tostring(tk.note)) or ""
					info.Text = string.format("<b>@%s</b> (UID: %s) — <font color='#FFD24C'><b>₹%s %s</b></font>\nDiscord: <b>%s</b> • %s • %s%s",
						Util.EscapeRichText(tostring(tk.username)), tostring(tk.uid), tostring(tk.priceINR or 300),
						Util.EscapeRichText(tostring(tk.itemName or tk.itemId)), Util.EscapeRichText(tostring(tk.discordUser or "N/A")),
						st:upper(), Util.TimeAgo(tk.createdAt), Util.EscapeRichText(noteStr))

					if isPend then
						local bRow = Instance.new("Frame", card)
						bRow.Size = UDim2.new(1, -16, 0, 28); bRow.Position = UDim2.new(0, 8, 1, -34); bRow.BackgroundTransparency = 1; bRow.ZIndex = 26

						C.Button(bRow, {
							Size = UDim2.new(0.56, -3, 1, 0), Variant = "success", Text = "✅ APPROVE & UNLOCK", TextSize = 10, ZIndex = 27,
							OnClick = function()
								task.spawn(function()
									local ok, msg = Backend.AdminVerifyTicket(tk, true)
									Z100.UI.ShowToast(ok and "✅ Verified" or "⚠️ Error", msg, p.Success)
									Z100.Router.Navigate("Admin", "Tickets", true)
								end)
							end,
						})
						C.Button(bRow, {
							Size = UDim2.new(0.44, -3, 1, 0), Position = UDim2.new(0.56, 6, 0, 0), Variant = "danger", Text = "❌ REJECT", TextSize = 10, ZIndex = 27,
							OnClick = function()
								task.spawn(function()
									local _, msg = Backend.AdminVerifyTicket(tk, false)
									Z100.UI.ShowToast("❌ Rejected", msg, p.Danger)
									Z100.Router.Navigate("Admin", "Tickets", true)
								end)
							end,
						})
					end
				end

			-- TAB 2: USERS, OWNERSHIP INSPECTOR & GRANTS
			elseif activeTab == "Users" then
				local regUsers = Backend.AdminFetchUsersList()
				local sel = Z100.Admin.SelectedUser
				local selEnt = sel and Backend.FetchEntitlements(sel.uid, true) or nil

				if adminRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
				if skel and skel.Parent then skel:Destroy() end

				local sCard = C.Card(scroll, { LayoutOrder = 2, StrokeColor = p.Accent, ZIndex = 24 })
				C.SectionHeader(sCard, "🔍 Inspect User (Username or UserId)", nil, 1)

				local sRow = Instance.new("Frame", sCard)
				sRow.Size = UDim2.new(1, 0, 0, 34); sRow.BackgroundTransparency = 1; sRow.LayoutOrder = 2; sRow.ZIndex = 25
				local _, qBox = C.TextInput(sRow, { Size = UDim2.new(1, -84, 1, 0), Placeholder = "Username or UserId...", Text = sel and sel.username or "", ZIndex = 26 })
				C.Button(sRow, {
					Size = UDim2.new(0, 78, 1, 0), Position = UDim2.new(1, -78, 0, 0), Variant = "primary", Text = "Inspect", TextSize = 10.5, ZIndex = 26,
					OnClick = function()
						local q = qBox.Text:match("^%s*(.-)%s*$") or ""
						if q == "" then return end
						task.spawn(function()
							local res = Util.ResolveUser(q)
							if res and res.UserId then
								Z100.Admin.SelectedUser = { uid = tostring(res.UserId), username = res.Username, displayName = res.DisplayName }
								Z100.Router.Navigate("Admin", "Users", true)
							else
								Z100.UI.ShowToast("⚠️ Not Found", "Could not resolve '" .. q .. "'", p.Danger)
							end
						end)
					end,
				})

				if sel and selEnt then
					local uCard = C.Card(scroll, { LayoutOrder = 3, StrokeColor = p.Gold, ZIndex = 24 })
					C.SectionHeader(uCard, "♛ Manage @" .. sel.username .. " (UID: " .. sel.uid .. ")", nil, 1)

					local sum = Instance.new("TextLabel", uCard)
					sum.Size = UDim2.new(1, 0, 0, 0); sum.AutomaticSize = Enum.AutomaticSize.Y; sum.BackgroundTransparency = 1
					sum.Font = Z100.Theme.Tokens.Fonts.Body; sum.TextSize = 10.5; sum.TextColor3 = p.TextPrimary
					sum.TextXAlignment = Enum.TextXAlignment.Left; sum.TextWrapped = true; sum.RichText = true; sum.LayoutOrder = 2; sum.ZIndex = 25
					sum.Text = string.format(
						"<b>₹300 Cosmetics Bundle:</b> %s\n<b>₹1500 Music Studio Pass:</b> %s\n<b>Single Unlocks:</b> %d Decorations • %d Themes",
						selEnt.cosmeticsBundle and "<font color='#10D48E'>OWNED ✅</font>" or "<font color='#FF6070'>LOCKED</font>",
						selEnt.musicStudioPass and "<font color='#10D48E'>OWNED ✅</font>" or "<font color='#FF6070'>LOCKED</font>",
						Util.CountKeys(selEnt.ownedDecorations), Util.CountKeys(selEnt.ownedThemes))

					local pkgRow = Instance.new("Frame", uCard)
					pkgRow.Size = UDim2.new(1, 0, 0, 32); pkgRow.BackgroundTransparency = 1; pkgRow.LayoutOrder = 3; pkgRow.ZIndex = 25

					C.Button(pkgRow, {
						Size = UDim2.new(0.49, 0, 1, 0),
						Variant = selEnt.cosmeticsBundle and "danger" or "gold",
						Text = selEnt.cosmeticsBundle and "❌ Revoke ₹300 Bundle" or "♛ Grant ₹300 Bundle",
						TextSize = 9.5, ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								local ok, msg = Backend.AdminSetCosmeticsBundle(sel.uid, not selEnt.cosmeticsBundle)
								Z100.UI.ShowToast(ok and "✅ Updated" or "⚠️ Error", msg, p.Gold)
								Z100.Router.Navigate("Admin", "Users", true)
							end)
						end,
					})
					C.Button(pkgRow, {
						Size = UDim2.new(0.49, 0, 1, 0), Position = UDim2.new(0.51, 0, 0, 0),
						Variant = selEnt.musicStudioPass and "danger" or "success",
						Text = selEnt.musicStudioPass and "❌ Revoke ₹1500 Studio" or "♫ Grant ₹1500 Studio",
						TextSize = 9.5, ZIndex = 26,
						OnClick = function()
							task.spawn(function()
								local ok, msg = Backend.AdminSetMusicStudioPass(sel.uid, not selEnt.musicStudioPass)
								Z100.UI.ShowToast(ok and "✅ Updated" or "⚠️ Error", msg, p.Success)
								Z100.Router.Navigate("Admin", "Users", true)
							end)
						end,
					})

					local types = { "decoration", "theme", "badge" }
					local tIdx = 1
					local tBtn
					tBtn = C.Button(uCard, {
						Height = 30, Variant = "ghost", Text = "Single Item Type: DECORATION (Tap to cycle)", TextSize = 10, LayoutOrder = 4, ZIndex = 25,
						OnClick = function() tIdx = (tIdx % #types) + 1; tBtn.Text = "Single Item Type: " .. types[tIdx]:upper() .. " (Tap to cycle)" end,
					})

					local _, itemBox = C.TextInput(uCard, { Placeholder = "Item ID (e.g. royal_gold_ring / royal_gold / VIP)...", LayoutOrder = 5, ZIndex = 25 })

					local actRow = Instance.new("Frame", uCard)
					actRow.Size = UDim2.new(1, 0, 0, 30); actRow.BackgroundTransparency = 1; actRow.LayoutOrder = 6; actRow.ZIndex = 25
					C.Button(actRow, {
						Size = UDim2.new(0.49, 0, 1, 0), Variant = "success", Text = "🎁 Grant Item", TextSize = 10, ZIndex = 26,
						OnClick = function()
							local id = itemBox.Text:match("^%s*(.-)%s*$") or ""
							if id == "" then return end
							task.spawn(function()
								local ok, msg = Backend.AdminSetSingleItem(sel.uid, types[tIdx], id, true)
								Z100.UI.ShowToast(ok and "🎁 Granted" or "⚠️ Error", msg, p.Success)
								Z100.Router.Navigate("Admin", "Users", true)
							end)
						end,
					})
					C.Button(actRow, {
						Size = UDim2.new(0.49, 0, 1, 0), Position = UDim2.new(0.51, 0, 0, 0), Variant = "danger", Text = "🗑 Revoke Item", TextSize = 10, ZIndex = 26,
						OnClick = function()
							local id = itemBox.Text:match("^%s*(.-)%s*$") or ""
							if id == "" then return end
							task.spawn(function()
								local ok, msg = Backend.AdminSetSingleItem(sel.uid, types[tIdx], id, false)
								Z100.UI.ShowToast(ok and "🗑 Revoked" or "⚠️ Error", msg, p.Danger)
								Z100.Router.Navigate("Admin", "Users", true)
							end)
						end,
					})

					local modRow = Instance.new("Frame", uCard)
					modRow.Size = UDim2.new(1, 0, 0, 30); modRow.BackgroundTransparency = 1; modRow.LayoutOrder = 7; modRow.ZIndex = 25
					C.Button(modRow, {
						Size = UDim2.new(0.49, 0, 1, 0), Variant = "secondary", Text = "◉ Open Profile", TextSize = 10, ZIndex = 26,
						OnClick = function() Z100.Router.OpenProfile(sel.uid) end,
					})
					C.Button(modRow, {
						Size = UDim2.new(0.49, 0, 1, 0), Position = UDim2.new(0.51, 0, 0, 0), Variant = "danger", Text = "⛔ Blacklist User", TextSize = 10, ZIndex = 26,
						OnClick = function()
							if sel.uid == Z100.MyUid then return end
							DB.PutAsync(Nodes.Blacklist .. "/Accs/" .. sel.username:lower(), '"true"')
							Backend.AdminLogAction("blacklist_user", sel.uid, "@" .. sel.username)
							Z100.UI.ShowToast("⛔ Blacklisted", "@" .. sel.username .. " restricted.", p.Danger)
						end,
					})
				end

				local dirCard = C.Card(scroll, { LayoutOrder = 4, ZIndex = 24 })
				C.SectionHeader(dirCard, "📋 Recent Registered Users (" .. tostring(#regUsers) .. ")", nil, 1)
				for idx, u in ipairs(regUsers) do
					if idx > 15 then break end
					local b = C.Button(dirCard, {
						Height = 32, Variant = "secondary",
						Text = "  @" .. tostring(u.username) .. " (" .. tostring(u.displayName or u.username) .. ")  •  UID: " .. tostring(u.uid),
						TextSize = 10, LayoutOrder = idx + 1, ZIndex = 25,
						OnClick = function()
							Z100.Admin.SelectedUser = { uid = tostring(u.uid), username = tostring(u.username), displayName = tostring(u.displayName or u.username) }
							Z100.Router.Navigate("Admin", "Users", true)
						end,
					})
					b.TextXAlignment = Enum.TextXAlignment.Left
				end

			-- TAB 3: STORE PRICING & COSMETICS AVAILABILITY
			elseif activeTab == "Store" then
				Backend.FetchStoreConfig()
				if adminRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
				if skel and skel.Parent then skel:Destroy() end

				local cfg = State.StoreConfig
				local pCard = C.Card(scroll, { LayoutOrder = 2, StrokeColor = Color3.fromRGB(0, 225, 185), ZIndex = 24 })
				C.SectionHeader(pCard, "💰 Paid Store Pricing & Discord Config", "Changes sync live to all users", 1)

				local _, decB = C.TextInput(pCard, { Placeholder = "Decoration Price INR (300)", Text = tostring(cfg.decorationPriceINR), LayoutOrder = 2, ZIndex = 25 })
				local _, thmB = C.TextInput(pCard, { Placeholder = "Theme Price INR (300)", Text = tostring(cfg.themePriceINR), LayoutOrder = 3, ZIndex = 25 })
				local _, bunB = C.TextInput(pCard, { Placeholder = "Bundle Price INR (300)", Text = tostring(cfg.bundlePriceINR), LayoutOrder = 4, ZIndex = 25 })
				local _, musB = C.TextInput(pCard, { Placeholder = "Music Studio Pass INR (1500)", Text = tostring(cfg.musicPassPriceINR), LayoutOrder = 5, ZIndex = 25 })
				local _, dUsB = C.TextInput(pCard, { Placeholder = "Owner Discord Username", Text = tostring(cfg.discordContact), LayoutOrder = 6, ZIndex = 25 })
				local _, dUrlB = C.TextInput(pCard, { Placeholder = "Optional Discord Contact URL", Text = tostring(cfg.discordURL or ""), LayoutOrder = 7, ZIndex = 25 })

				C.Button(pCard, {
					Height = 36, Variant = "success", Text = "💾 SAVE STORE CONFIG", TextSize = 11, LayoutOrder = 8, ZIndex = 25,
					OnClick = function()
						cfg.decorationPriceINR = math.max(1, math.floor(tonumber(decB.Text) or 300))
						cfg.themePriceINR = math.max(1, math.floor(tonumber(thmB.Text) or 300))
						cfg.bundlePriceINR = math.max(1, math.floor(tonumber(bunB.Text) or 300))
						cfg.musicPassPriceINR = math.max(1, math.floor(tonumber(musB.Text) or 1500))
						if dUsB.Text:match("%S") then cfg.discordContact = dUsB.Text:gsub("^%s+", ""):gsub("%s+$", "") end
						cfg.discordURL = dUrlB.Text:gsub("^%s+", ""):gsub("%s+$", "")
						task.spawn(function()
							local ok, err = Backend.AdminSaveStoreConfig()
							Z100.UI.ShowToast(ok and "✅ Config Saved" or "⚠️ Error", ok and "Store pricing & Discord updated!" or tostring(err), p.Success)
						end)
					end,
				})

				local tCard = C.Card(scroll, { LayoutOrder = 3, ZIndex = 24 })
				C.SectionHeader(tCard, "✨ Toggle Cosmetics Availability", "Tap any item to enable/disable in Store", 1)
				local ord = 2
				for _, d in ipairs(Z100.Catalog.Decorations) do
					local en = Backend.IsDecorationEnabled(d.id)
					C.Button(tCard, {
						Height = 28, Variant = en and "secondary" or "danger",
						Text = "✨ " .. d.name .. " — " .. (en and "ENABLED ✅" or "DISABLED ❌"),
						TextSize = 9.5, LayoutOrder = ord, ZIndex = 25,
						OnClick = function()
							cfg.disabledDecorations[d.id] = en and true or nil
							task.spawn(function() Backend.AdminSaveStoreConfig(); Z100.Router.Navigate("Admin", "Store", true) end)
						end,
					})
					ord = ord + 1
				end
				for _, t in ipairs(Z100.Catalog.ProfileThemes) do
					local en = Backend.IsThemeEnabled(t.id)
					C.Button(tCard, {
						Height = 28, Variant = en and "secondary" or "danger",
						Text = "🎨 " .. t.name .. " — " .. (en and "ENABLED ✅" or "DISABLED ❌"),
						TextSize = 9.5, LayoutOrder = ord, ZIndex = 25,
						OnClick = function()
							cfg.disabledThemes[t.id] = en and true or nil
							task.spawn(function() Backend.AdminSaveStoreConfig(); Z100.Router.Navigate("Admin", "Store", true) end)
						end,
					})
					ord = ord + 1
				end

			-- TAB 4: MODERATION, BROADCAST, REPORTS & AUDIT LOGS
			elseif activeTab == "Moderation" then
				local sReports = Backend.AdminFetchReportedStories()
				local uReports = Backend.AdminFetchUserReports()
				local logs = Backend.AdminFetchLogs()

				if adminRenderSeq ~= mySeq or not scroll or not scroll.Parent then return end
				if skel and skel.Parent then skel:Destroy() end

				local sysCard = C.Card(scroll, { LayoutOrder = 2, StrokeColor = p.Danger, ZIndex = 24 })
				C.SectionHeader(sysCard, "📢 Global Broadcast, Chat Lock & Unban", nil, 1)

				local _, bcBox = C.TextInput(sysCard, { Placeholder = "Global announcement banner message...", LayoutOrder = 2, ZIndex = 25 })
				C.Button(sysCard, {
					Variant = "danger", Text = "📢 SEND GLOBAL BROADCAST", TextSize = 10.5, LayoutOrder = 3, ZIndex = 25,
					OnClick = function()
						local txt = bcBox.Text:match("^%s*(.-)%s*$") or ""
						if txt == "" then return end
						bcBox.Text = ""
						DB.PutAsync(Nodes.Broadcasts, { msg = txt, time = Util.Now() })
						Backend.AdminLogAction("broadcast", "", txt)
						Z100.UI.ShowGlobalBanner(txt)
					end,
				})

				local lkRow = Instance.new("Frame", sysCard)
				lkRow.Size = UDim2.new(1, 0, 0, 30); lkRow.BackgroundTransparency = 1; lkRow.LayoutOrder = 4; lkRow.ZIndex = 25
				C.Button(lkRow, {
					Size = UDim2.new(0.49, 0, 1, 0), Variant = "danger", Text = "🔒 Lock Server Chat", TextSize = 10, ZIndex = 26,
					OnClick = function()
						DB.PutAsync(Nodes.Locks .. "/" .. State.JobId, true)
						Z100.Chat.SetLockState(true)
						Z100.UI.ShowToast("🔒 Locked", "Server chat locked.", p.Danger)
					end,
				})
				C.Button(lkRow, {
					Size = UDim2.new(0.49, 0, 1, 0), Position = UDim2.new(0.51, 0, 0, 0), Variant = "success", Text = "🔓 Unlock Server Chat", TextSize = 10, ZIndex = 26,
					OnClick = function()
						DB.DeleteAsync(Nodes.Locks .. "/" .. State.JobId)
						Z100.Chat.SetLockState(false)
						Z100.UI.ShowToast("🔓 Unlocked", "Server chat unlocked.", p.Success)
					end,
				})

				local _, unbanBox = C.TextInput(sysCard, { Placeholder = "Unban Roblox Username...", LayoutOrder = 5, ZIndex = 25 })
				C.Button(sysCard, {
					Variant = "primary", Text = "🔓 UNBAN ACCOUNT", TextSize = 10.5, LayoutOrder = 6, ZIndex = 25,
					OnClick = function()
						local u = unbanBox.Text:match("^%s*(.-)%s*$") or ""
						if u == "" then return end
						unbanBox.Text = ""
						task.spawn(function()
							local low = u:lower()
							local hw = DB.Get(Nodes.Blacklist .. "/Accs/" .. low)
							DB.Delete(Nodes.Blacklist .. "/Accs/" .. low)
							if type(hw) == "string" and hw ~= "" and hw ~= "true" then DB.Delete(Nodes.Blacklist .. "/HWs/" .. hw) end
							Backend.AdminLogAction("unban_user", "", "@" .. u)
							Z100.UI.ShowToast("🔓 Unbanned", "@" .. u .. " removed from blacklist.", p.Success)
						end)
					end,
				})

				-- Reported Stories
				local repCard = C.Card(scroll, { LayoutOrder = 3, StrokeColor = p.Warning, ZIndex = 24 })
				C.SectionHeader(repCard, "🚩 Reported Stories (" .. tostring(#sReports) .. ")", nil, 1)
				if #sReports == 0 then
					local em = Instance.new("TextLabel", repCard); em.Size = UDim2.new(1, 0, 0, 22); em.BackgroundTransparency = 1
					em.Font = Z100.Theme.Tokens.Fonts.Body; em.TextSize = 10; em.TextColor3 = p.TextMuted; em.TextXAlignment = Enum.TextXAlignment.Left
					em.Text = "No reported stories."; em.LayoutOrder = 2; em.ZIndex = 25
				else
					for idx, rep in ipairs(sReports) do
						local row = Instance.new("Frame", repCard)
						row.Size = UDim2.new(1, 0, 0, 76); row.BackgroundColor3 = p.SurfaceElev; row.LayoutOrder = idx + 1; row.ZIndex = 25
						C.Corner(row, Z100.Theme.Tokens.Radius.SM)
						local t = Instance.new("TextLabel", row); t.Size = UDim2.new(1, -16, 0, 40); t.Position = UDim2.new(0, 8, 0, 4)
						t.BackgroundTransparency = 1; t.Font = Z100.Theme.Tokens.Fonts.Body; t.TextSize = 10; t.TextColor3 = p.TextPrimary
						t.TextXAlignment = Enum.TextXAlignment.Left; t.TextWrapped = true; t.RichText = true; t.ZIndex = 26
						t.Text = string.format("<b>Story by @%s</b> • By @%s (%s)\n<font color='#FFB830'>%s</font>",
							Util.EscapeRichText(tostring(rep.ownerName)), Util.EscapeRichText(tostring(rep.reporterName)),
							Util.TimeAgo(rep.timestamp), Util.EscapeRichText(tostring(rep.reason)))

						C.Button(row, {
							Size = UDim2.new(0.52, -8, 0, 24), Position = UDim2.new(0, 8, 1, -28), Variant = "danger", Text = "🗑 Delete Story", TextSize = 9.5, ZIndex = 26,
							OnClick = function()
								task.spawn(function()
									Backend.AdminResolveStoryReport(rep, true)
									Z100.Router.Navigate("Admin", "Moderation", true)
								end)
							end,
						})
						C.Button(row, {
							Size = UDim2.new(0.46, -8, 0, 24), Position = UDim2.new(0.54, 0, 1, -28), Variant = "secondary", Text = "✓ Dismiss", TextSize = 9.5, ZIndex = 26,
							OnClick = function()
								task.spawn(function()
									Backend.AdminResolveStoryReport(rep, false)
									Z100.Router.Navigate("Admin", "Moderation", true)
								end)
							end,
						})
					end
				end

				-- User Reports & Admin Audit Logs Summary
				if #uReports > 0 then
					local urCard = C.Card(scroll, { LayoutOrder = 4, ZIndex = 24 })
					C.SectionHeader(urCard, "⚠️ User Reports (" .. tostring(#uReports) .. ")", nil, 1)
					for idx, ur in ipairs(uReports) do
						if idx > 8 then break end
						local row = Instance.new("Frame", urCard)
						row.Size = UDim2.new(1, 0, 0, 44); row.BackgroundColor3 = p.SurfaceElev; row.LayoutOrder = idx + 1; row.ZIndex = 25
						C.Corner(row, Z100.Theme.Tokens.Radius.SM)
						local t = Instance.new("TextLabel", row); t.Size = UDim2.new(1, -84, 1, -4); t.Position = UDim2.new(0, 8, 0, 2)
						t.BackgroundTransparency = 1; t.Font = Z100.Theme.Tokens.Fonts.Body; t.TextSize = 9.5; t.TextColor3 = p.TextPrimary
						t.TextXAlignment = Enum.TextXAlignment.Left; t.TextWrapped = true; t.ZIndex = 26
						t.Text = "Target UID " .. tostring(ur.targetUid) .. " • " .. tostring(ur.reason)
						C.Button(row, {
							Size = UDim2.new(0, 68, 0, 26), Position = UDim2.new(1, -74, 0.5, -13), Variant = "secondary", Text = "Dismiss", TextSize = 9, ZIndex = 26,
							OnClick = function()
								task.spawn(function() Backend.AdminDismissUserReport(ur.id); Z100.Router.Navigate("Admin", "Moderation", true) end)
							end,
						})
					end
				end

				if #logs > 0 then
					local logCard = C.Card(scroll, { LayoutOrder = 5, ZIndex = 24 })
					C.SectionHeader(logCard, "📜 Recent Admin Audit Logs", nil, 1)
					for idx = 1, math.min(6, #logs) do
						local lg = logs[idx]
						local lt = Instance.new("TextLabel", logCard)
						lt.Size = UDim2.new(1, 0, 0, 22); lt.BackgroundTransparency = 1; lt.Font = Z100.Theme.Tokens.Fonts.Body
						lt.TextSize = 9.5; lt.TextColor3 = p.TextSecondary; lt.TextXAlignment = Enum.TextXAlignment.Left; lt.ClipsDescendants = true
						lt.Text = string.format("• [%s] @%s: %s (%s)", Util.TimeAgo(lg.timestamp), tostring(lg.adminName), tostring(lg.action), tostring(lg.details))
						lt.LayoutOrder = idx + 1; lt.ZIndex = 25
					end
				end
			end
		end)
	end

	-- ===================================================================== --
	-- [SECTION C : UNIFIED SCREEN ROUTER (Z100.Router)]
	-- ===================================================================== --
	function Z100.Router.Navigate(screenId, param, skipHistory)
		local host = Z100.UI.ContentHost
		if not host or not host.Parent then return end

		local prev = State.ActiveScreen
		if prev == "MusicStudio" and screenId ~= "MusicStudio" then
			Z100.Music.StopAudio("ZaynV100_MusicAudio")
		end
		if prev == "StoryEditor" and screenId ~= "StoryEditor" then
			Z100.Music.StopAudio("ZaynV100_StoryAudio")
		end

		if not skipHistory and prev and prev ~= screenId then
			table.insert(State.ScreenHistory, { Screen = prev })
			while #State.ScreenHistory > 12 do table.remove(State.ScreenHistory, 1) end
		end

		State.ActiveScreen = screenId
		Util.RunScreenCleanup()
		Z100.Chat.CancelActionBar()

		for _, ch in ipairs(host:GetChildren()) do
			ch:Destroy()
		end

		if Z100.UI.BackBtn then
			local showBack = (#State.ScreenHistory > 0 and screenId ~= "Home")
			Z100.UI.BackBtn.Visible = showBack
			if Z100.UI.HeaderTitle then
				Z100.UI.HeaderTitle.Position = showBack and UDim2.new(0, 48, 0, 5) or UDim2.new(0, 14, 0, 5)
			end
			if Z100.UI.HeaderSub then
				Z100.UI.HeaderSub.Position = showBack and UDim2.new(0, 48, 0, 26) or UDim2.new(0, 14, 0, 26)
			end
		end

		if screenId == "Home" then
			if Z100.UI.HeaderTitle then Z100.UI.HeaderTitle.Text = "ZAYN SOCIAL V100" end
			if Z100.UI.HeaderSub then Z100.UI.HeaderSub.Text = "TITANGUARD ULTIMATE" end
			Z100.Screens.RenderHome(host)
		elseif screenId == "Messages" then
			Z100.Screens.RenderMessages(host)
		elseif screenId == "Notifications" then
			Z100.Screens.RenderNotifications(host)
		elseif screenId == "Stories" then
			Z100.Screens.RenderStories(host)
		elseif screenId == "StoryEditor" then
			Z100.Screens.RenderStoryEditor(host)
		elseif screenId == "Profile" then
			Z100.Screens.RenderProfile(host, param or State.ViewingProfileUid)
		elseif screenId == "ProfileEditor" then
			Z100.Screens.RenderProfileEditor(host)
		elseif screenId == "MusicStudio" then
			Z100.Screens.RenderMusicStudio(host)
		elseif screenId == "PremiumStore" then
			Z100.Screens.RenderStore(host, param or State.StoreTab)
		elseif screenId == "Settings" then
			Z100.Screens.RenderSettings(host)
		elseif screenId == "Admin" then
			Z100.Screens.RenderAdmin(host, param or State.AdminTab)
		end

		Z100.UI.UpdateNavActive(screenId)
	end

	function Z100.Router.GoBack()
		local last = table.remove(State.ScreenHistory)
		if last and last.Screen then
			Z100.Router.Navigate(last.Screen, nil, true)
		else
			Z100.Router.Navigate("Home", nil, true)
		end
	end

	function Z100.Router.OpenProfile(uid)
		local uidStr = Util.NormalizeUid(uid) or Z100.MyUid
		State.ViewingProfileUid = uidStr
		Z100.Router.Navigate("Profile", uidStr)
	end

	function Z100.Router.OpenStore(tabName)
		State.StoreTab = tabName or "Decorations"
		Z100.Router.Navigate("PremiumStore", State.StoreTab)
	end

	function Z100.Router.RefreshCurrent()
		Z100.Router.Navigate(State.ActiveScreen, nil, true)
	end

	-- ===================================================================== --
	-- [SECTION D : STAGGERED ZERO-LAG REALTIME FIREBASE SYNC LOOPS]
	-- ===================================================================== --
	local lastBroadcastTs = Util.Now()

	local function syncServerChat(silentInitial)
		local raw = DB.Get(Nodes.ServerChat .. "/" .. State.JobId)
		if type(raw) ~= "table" then return end

		local srvKey = Crypto.ServerSalt .. State.JobId
		local nowTs = Util.Now()
		local parsed = {}

		for msgId, item in pairs(raw) do
			if type(item) == "table" and item.m and item.sign and item.s then
				local msgTs = tonumber(item.t) or 0
				if nowTs - msgTs > Z100.Config.Limits.ServerChatTTL then
					DB.DeleteAsync(Nodes.ServerChat .. "/" .. State.JobId .. "/" .. msgId)
				else
					local plain = Crypto.Decrypt(srvKey, item.m, item.sign)
					if plain then
						local uid = tonumber(item.u) or 1
						Util.RegisterAccount(item.s, item.s, uid)
						table.insert(parsed, {
							ID = msgId,
							Sender = tostring(item.s),
							UserID = uid,
							Msg = plain,
							Time = msgTs,
							Edited = (plain:sub(1, 5) == "[EDT]"),
							Reactions = type(item._rct) == "table" and item._rct or {},
						})
					end
				end
			end
		end

		table.sort(parsed, function(a, b) return a.Time < b.Time end)
		State.Cache.Server = parsed

		local viewingServer = (State.ActiveScreen == "Messages" and State.ChatSubMode == "Server")
		for _, msg in ipairs(parsed) do
			if not State.SeenMsgIds[msg.ID] then
				State.SeenMsgIds[msg.ID] = true
				if viewingServer then
					Z100.Chat.RenderBubble(msg.Sender, msg.UserID, msg.Msg, msg.Time, msg.ID, msg.Edited, msg.Reactions)
				elseif not silentInitial and State.Prefs.NotifyMessages and msg.UserID ~= Z100.Player.UserId then
					Z100.UI.ShowToast("💬 " .. Util.GetAccount(msg.Sender).DisplayName, msg.Msg, Z100.Theme.Get().Accent, msg.UserID, function()
						State.ChatSubMode = "Server"
						Z100.Router.Navigate("Messages")
					end)
				end
			elseif viewingServer and State.ActiveBubbles[msg.ID] then
				Z100.Chat.UpdateBubbleReactions(msg.ID, msg.Reactions)
			end
		end
	end

	local function syncDMs(silentInitial)
		local raw = DB.Get(Nodes.DMs .. "/" .. Z100.MyNameLower)
		if type(raw) ~= "table" then return end

		local nowTs = Util.Now()
		for partnerLow, convo in pairs(raw) do
			if type(convo) == "table" then
				local dmKey = Crypto.GetDMKey(Z100.MyNameLower, partnerLow)
				local list = {}

				for msgId, item in pairs(convo) do
					if msgId ~= "_typ" and type(item) == "table" and item.m and item.sign and item.s then
						local msgTs = tonumber(item.t) or 0
						if nowTs - msgTs <= Z100.Config.Limits.DMTTL then
							local plain = Crypto.Decrypt(dmKey, item.m, item.sign)
							if plain then
								local uid = tonumber(item.u) or 1
								Util.RegisterAccount(item.s, item.s, uid)
								table.insert(list, {
									ID = msgId,
									Sender = tostring(item.s),
									UserID = uid,
									Msg = plain,
									Time = msgTs,
									Edited = (plain:sub(1, 5) == "[EDT]"),
									Reactions = type(item._rct) == "table" and item._rct or {},
								})
							end
						end
					end
				end

				table.sort(list, function(a, b) return a.Time < b.Time end)
				State.Cache.DMs[partnerLow] = list

				local viewingThisDM = (State.ActiveScreen == "Messages" and State.ChatSubMode == "DM" and State.ActiveDM == partnerLow)
				for _, msg in ipairs(list) do
					if not State.SeenMsgIds[msg.ID] then
						State.SeenMsgIds[msg.ID] = true
						if viewingThisDM then
							Z100.Chat.RenderBubble(msg.Sender, msg.UserID, msg.Msg, msg.Time, msg.ID, msg.Edited, msg.Reactions)
							Z100.Chat.SetLastRead(partnerLow, nowTs)
						elseif not silentInitial and State.Prefs.NotifyMessages and msg.UserID ~= Z100.Player.UserId then
							Z100.UI.ShowToast("📩 DM • " .. Util.GetAccount(msg.Sender).DisplayName, msg.Msg, Color3.fromRGB(0, 220, 175), msg.UserID, function()
								State.ChatSubMode = "DM"
								State.ActiveDM = partnerLow
								Z100.Router.Navigate("Messages")
							end)
						end
					elseif viewingThisDM and State.ActiveBubbles[msg.ID] then
						Z100.Chat.UpdateBubbleReactions(msg.ID, msg.Reactions)
					end
				end
			end
		end

		Z100.UI.UpdateBadges()
	end

	local function syncSystemControls()
		local locked = DB.Get(Nodes.Locks .. "/" .. State.JobId)
		local isLocked = (locked == true or locked == "true")
		if isLocked ~= State.IsLocked then
			Z100.Chat.SetLockState(isLocked)
		end

		local bc = DB.Get(Nodes.Broadcasts)
		if type(bc) == "table" and bc.msg and tonumber(bc.time) and tonumber(bc.time) > lastBroadcastTs then
			lastBroadcastTs = tonumber(bc.time)
			Z100.UI.ShowGlobalBanner(bc.msg)
		end
	end

	local function startBackgroundLoops()
		-- Fast Loop (~2.8s): Server Chat & System Controls
		task.spawn(function()
			syncServerChat(true)
			while not ENV.ZaynV100_Unloading and Z100.UI.ScreenGui and Z100.UI.ScreenGui.Parent do
				task.wait(2.8)
				if ENV.ZaynV100_Unloading then break end
				pcall(syncServerChat, false)
				pcall(syncSystemControls)
			end
		end)

		-- Medium Loop (~4.8s): Direct Messages
		task.spawn(function()
			syncDMs(true)
			while not ENV.ZaynV100_Unloading and Z100.UI.ScreenGui and Z100.UI.ScreenGui.Parent do
				task.wait(4.8)
				if ENV.ZaynV100_Unloading then break end
				pcall(syncDMs, false)
			end
		end)

		-- Slow Loop (~22s): Presence, Notifications, Requests, Entitlements & Security
		task.spawn(function()
			Backend.HeartbeatPresence()
			Backend.FetchMyNotifs(true)
			Backend.FetchMyRequests()
			Z100.UI.UpdateBadges()

			while not ENV.ZaynV100_Unloading and Z100.UI.ScreenGui and Z100.UI.ScreenGui.Parent do
				task.wait(22)
				if ENV.ZaynV100_Unloading then break end
				pcall(Backend.HeartbeatPresence)
				pcall(Backend.FetchMyNotifs, false)
				pcall(Backend.FetchMyRequests)
				pcall(Backend.FetchEntitlements, Z100.MyUid, true)
				pcall(Backend.FetchStoreConfig)
				pcall(Z100.UI.UpdateBadges)
				pcall(Z100.Security.CheckBlacklist)
			end
		end)
	end

	-- ===================================================================== --
	-- [SECTION E : FINAL BOOT SEQUENCE]
	-- ===================================================================== --
	Z100.UI.BuildMasterShell()

	for _, plr in ipairs(Players:GetPlayers()) do
		Util.RegisterAccount(plr.Name, plr.DisplayName, plr.UserId)
	end
	Util.TrackConn(Players.PlayerAdded:Connect(function(plr)
		Util.RegisterAccount(plr.Name, plr.DisplayName, plr.UserId)
	end))

	task.spawn(function()
		pcall(Backend.FetchStoreConfig)
		pcall(Backend.FetchEntitlements, Z100.MyUid, true)
		pcall(Backend.FetchProfile, Z100.MyUid, true)
		pcall(Backend.FetchMyBlocks)
		pcall(Backend.FetchGraph, Z100.MyUid, true)
		pcall(Backend.FetchUserStories, Z100.MyUid, true)
		pcall(Z100.UI.ApplyDesignTheme)
	end)

	Z100.Router.Navigate("Home", nil, true)
	startBackgroundLoops()

	Z100.UI.ShowToast(
		"👑 ZAYN SOCIAL V100 LOADED",
		"Titanguard Ultimate Ready • Executor: " .. tostring(Z100.Exec.Name),
		Z100.Theme.Get().Accent,
		Z100.MyUid
	)
	print("✅ [ZAYN SOCIAL V100] TITANGUARD ULTIMATE FULLY BOOTED ON " .. tostring(Z100.Exec.Name) .. "!")
end
