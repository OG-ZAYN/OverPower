-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 1 / 8 : CORE BOOTSTRAP, ZERO-LAG ANIMATION ENGINE, PROXY & STATE
-- ========================================================================= --

print("👑 ZAYN CHAT V71.0 INSTA ELITE EXECUTING (ZERO-LAG ENGINE, INSTA PROFILE, 12 AURAS, 10 THEMES & ₹300 ELITE PASS)...")

local a = type(getgenv) == "function" and getgenv() or _G

if type(a) == "table" then
    if a.MatrixEngine_Loaded then
        a.MatrixEngine_Unloading = true
        if type(a.MatrixEngine_Cleanup) == "function" then
            pcall(a.MatrixEngine_Cleanup)
        end
        task.wait(0.25)
        pcall(function()
            local b = type(gethui) == "function" and gethui() or game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
            for _, d in pairs(b:GetChildren()) do
                if d.Name:match("^MatrixUI_") or d.Name:match("^ZaynMusic_") then
                    d:Destroy()
                end
            end
        end)
    end
    a.MatrixEngine_Loaded = true
    a.MatrixEngine_Unloading = false
end

local e = game:GetService("Players")
local f = game:GetService("HttpService")
local g = game:GetService("TweenService")
local h = game:GetService("RunService")
local i = game:GetService("UserInputService")
local j = game:GetService("Lighting")
local k = game:GetService("ReplicatedStorage")
local l = pcall(function() return game:GetService("UserService") end) and game:GetService("UserService") or nil
local m = e.LocalPlayer
local n = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or (type(getgenv) == "function" and getgenv().request) or request

if not n then
    warn("ZAYN CHAT V71.0: HTTP request pipeline missing in this executor!")
    return
end

local function o()
    local p = "MatrixUI_"
    for _ = 1, 15 do
        p = p .. string.char(math.random(65, 90))
    end
    return p
end

local q = typeof(newcclosure) == "function" and newcclosure or function(r) return r end

local function s(t, u)
    local v = type(t)
    local w = type(u)
    if v ~= w then return false end
    if v ~= "table" and w ~= "table" then return t == u end
    for x, y in pairs(t) do
        local z = u[x]
        if z == nil or not s(y, z) then return false end
    end
    for A, z in pairs(u) do
        local y = t[A]
        if y == nil or not s(y, z) then return false end
    end
    return true
end

local function B()
    local C = ""
    pcall(function() C = gethwid() end)
    if not C or C == "" then pcall(function() C = getgenv().gethwid() end) end
    if not C or C == "" then pcall(function() C = game:GetService("RbxAnalyticsService"):GetClientId() end) end
    if not C or C == "" then pcall(function() C = game:GetService("LogService"):GetClientId() end) end
    if not C or C == "" then C = "FALLBACK_ID_" .. tostring(m.UserId) end
    return tostring(C):gsub("[^%w_]", "")
end

local D = B()
local E = identifyexecutor and identifyexecutor() or "Unknown_Universal_Exec"

-- ========================================================================= --
-- [NETWORK ROUTING: PROXY GATEWAY]
-- ========================================================================= --
local F = "https://daddyshome-d6f86-default-rtdb.asia-southeast1.firebasedatabase.app"
local PROXY_URL = "https://script.google.com/macros/s/AKfycbzHfd2lPp32N0etjgKfQbJwrBpDnYFRPmxKul29r_pZO1GEGdGsZjwKEsL0zPaIDHQ9/exec"
local PROXY_AUTH = "T9$xK2#pL8*mQ5^yV1%wC6)bN5_rP2&hF7(dJ4@kM3!zX9+vB0~gC1>lZ8<nS4"

local function G(H, I, J)
    local reqPath = string.sub(H, string.len(F) + 1)
    local payload = {
        auth = PROXY_AUTH,
        path = reqPath,
        method = I
    }
    if J ~= nil then
        payload.body = J
    end

    local K = {
        Url = PROXY_URL,
        Method = "POST",
        Timeout = 12,
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = f:JSONEncode(payload)
    }

    local ok, res = pcall(function() return n(K) end)
    if ok and res and res.Body then
        return {
            StatusCode = res.StatusCode or 200,
            Body = res.Body
        }
    end
    return {StatusCode = 500, Body = "null"}
end

-- ========================================================================= --
-- [UTILITY GENERATORS]
-- ========================================================================= --
local function generate18CharDynamicKey()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local key = ""
    for _ = 1, 18 do
        local r = math.random(1, #charset)
        key = key .. charset:sub(r, r)
    end
    return key
end

function getRainbowText(text)
    local colors = {"#FF0000", "#FF7F00", "#FFFF00", "#00FF00", "#00FFFF", "#EE82EE"}
    local res = ""
    local cIdx = 1
    for idx = 1, #text do
        local char = text:sub(idx, idx)
        if char:match("%s") then
            res = res .. char
        else
            res = res .. "<font color='" .. colors[cIdx] .. "'>" .. char .. "</font>"
            cIdx = (cIdx % #colors) + 1
        end
    end
    return res
end

-- Existing V70.1 DB Nodes (100% Preserved)
local L = "LOGISTICS_PIPELINE_CENTRAL_SRV"
local M = "SECURE_TELEMETRY_DMS_CORE"
local N = "THREAT_ANALYSIS_FORENSIC_LOGS"
local O = "ACCESS_CONTROL_BLACKLIST_DB"
local P = "SUSPENSION_STATE_CONTAINERS"
local Q = "DICTIONARY_SANITISED_STRING_FILTERS"
local R = "EMERGENCY_OVERLAY_BROADCASTS"
local S = "ASYNC_POSTAL_SERVICE_QUEUE"
local T = "READ_RECEIPTS_METLOCK"

-- V71.0 Insta Elite Persistent DB Nodes (Matched 1:1 with Strict Firebase Rules in Part 8)
local DB_SOCIAL = {
    Profiles = "ZAYN_V71_PROFILES",
    Followers = "ZAYN_V71_FOLLOWERS",
    Following = "ZAYN_V71_FOLLOWING",
    Requests = "ZAYN_V71_FOLLOW_REQUESTS",
    Blocks = "ZAYN_V71_BLOCKS",
    Reports = "ZAYN_V71_REPORTS",
    Notifs = "ZAYN_V71_SOCIAL_NOTIFS",
    Entitlements = "ZAYN_V71_ENTITLEMENTS",
    PurchaseReqs = "ZAYN_V71_PURCHASE_REQUESTS",
    StoreConfig = "ZAYN_V71_STORE_CONFIG",
    Presence = "ZAYN_V71_PRESENCE",
    UsernameIndex = "ZAYN_V71_USER_INDEX"
}

local U = q(function() return "A7D9E4B2C1F03E5D8A91624B5C3D2E7F8A9B1C3D4E6F8A2B5C7D9E1F0A2B4C6D" end)
local V = q(function() return "MATRIX_QUANTUM_CORE_CIPHER_SHIELD_V59_" end)
local W = "NEXUS_MATRIX_CORE_OVERRIDE_SECURE_KEY"
local X = "MATRIX_KERNEL_SECURE_ISOLATION_M4.sys"
local Y = game.JobId ~= "" and game.JobId or "OFFLINE_STUDIO_TEST_99"
local Z = Y:gsub("[^%w_]", "")

-- ========================================================================= --
-- [TITANGUARD SECURITY & ACCESS CHECKS (ZERO-LAG)]
-- ========================================================================= --
local function _()
    task.spawn(function()
        pcall(function()
            local b = type(gethui) == "function" and gethui() or game:GetService("CoreGui") or m:WaitForChild("PlayerGui")
            for _, d in pairs(b:GetChildren()) do
                if d.Name:find("Matrix") or d.Name:find("Zayn") then
                    d:Destroy()
                end
            end
        end)
    end)
    m:Kick("\n⛔ APEX TITAN BAN ENGINE ⛔\nAccount permanently blacklisted from ZAYN CHAT.")
    task.wait(0.5)
    while true do task.wait(9e9) end
end

local function a0()
    local a1 = m.Name:lower()
    local a2 = pcall(isfile, X) and isfile(X)
    local a3, a4 = pcall(function() return G(F .. "/" .. O .. "/Accs/" .. a1 .. ".json?bust=" .. tostring(os.clock()), "GET").Body end)
    local a5, a6 = pcall(function() return G(F .. "/" .. O .. "/HWs/" .. D .. ".json?bust=" .. tostring(os.clock()), "GET").Body end)
    local a7 = (a3 and a4 and a4 ~= "null" and string.find(a4, "true")) or (a5 and a6 and a6 ~= "null" and string.find(a6, "true"))

    if a7 then
        task.spawn(function()
            pcall(function() if writefile then writefile(X, "PERMA_BANNED_BY_MATRIX_ADMIN") end end)
            G(F .. "/" .. O .. "/HWs/" .. D .. ".json", "PUT", '"true"')
            G(F .. "/" .. O .. "/Accs/" .. a1 .. ".json", "PUT", f:JSONEncode(D))
        end)
        _()
    elseif a2 and not a7 then
        pcall(function() if delfile then delfile(X) end end)
    end
end
task.spawn(a0)

local function ah()
    local ai, aj = m.Name, m.DisplayName
    pcall(function()
        if l then
            local a5, ak = pcall(function() return l:GetUserInfosByUserIdsAsync({m.UserId})[1] end)
            if a5 and ak then
                if ak.Username then ai = ak.Username end
                if ak.DisplayName then aj = ak.DisplayName end
            end
        end
    end)
    local function al(am)
        if not am then return false end
        local an = am:lower():gsub("0", "o"):gsub("1", "i")
        return string.find(an, "forbid") ~= nil
    end
    if al(ai) or al(aj) then
        task.spawn(function()
            pcall(function() if writefile then writefile(X, "PERMA_BANNED_FORBID_CLAN") end end)
            G(F .. "/" .. O .. "/HWs/" .. D .. ".json", "PUT", '"true"')
            G(F .. "/" .. O .. "/Accs/" .. ai:lower() .. ".json", "PUT", f:JSONEncode(D))
            _()
        end)
    end
end
task.spawn(ah)

local ao = {
    UserIds = {["baduser123"] = true},
    HWIDs = {["ADD_HWID_HERE"] = true}
}

if ao.UserIds[m.Name:lower()] or ao.HWIDs[D] then
    m:Kick("\n⛔ PERMANENT BAN ⛔\nMachine strictly blacklisted from Matrix Network.")
    while true do task.wait(9e9) end
end

local function ap(aq, ar)
    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
    local as = {
        ["SPY-01"] = true, ["TRP-M01"] = true, ["GC-SPOOF"] = true,
        ["META-HOOK"] = true, ["VIP-SPOOF"] = true, ["GOD-BREACH"] = true,
        ["ID-SPOOF"] = true, ["PFP-SPOOF"] = true
    }
    if as[aq] then
        task.spawn(function()
            G(F .. "/" .. O .. "/HWs/" .. D .. ".json", "PUT", '"true"')
            G(F .. "/" .. O .. "/Accs/" .. m.Name:lower() .. ".json", "PUT", f:JSONEncode(D))
            pcall(function() if writefile then writefile(X, "PERMA_BANNED_BY_TITANGUARD") end end)
        end)
    end
    task.spawn(function()
        pcall(function()
            local at = {
                PlayerName = m.Name,
                PlayerID = m.UserId,
                HWID = D,
                Executor = E,
                ViolationCode = aq,
                Reason = ar,
                ServerJobId = Z,
                Timestamp = os.time()
            }
            G(F .. "/" .. N .. "/" .. m.Name:lower() .. "_" .. os.time() .. ".json", "PUT", f:JSONEncode(at))
        end)
    end)
    task.wait(0.5)
    m:Kick("\n🛡️ MATRIX TITANGUARD 🛡️\nIntercepted Violation: [" .. aq .. "]\nSession securely closed.")
    while true do task.wait(9e9) end
end

local function au()
    local av = e.LocalPlayer
    if av.UserId ~= 10432865434 then return false end
    if string.lower(av.Name) ~= "erennn0779" then return false end
    local ck = e:GetPlayerByUserId(10432865434)
    if ck ~= av then return false end
    return true
end

if m.UserId == 10432865434 and not au() then
    ap("VIP-SPOOF", "Identity Theft Intercepted")
end

-- One-time startup identity verification (No 3.5s lag spike!)
task.spawn(function()
    pcall(function()
        local rId = e:GetUserIdFromNameAsync(m.Name)
        local rName = e:GetNameFromUserIdAsync(m.UserId)
        if rId and tonumber(rId) ~= tonumber(m.UserId) then
            ap("ID-SPOOF", "Identity/Username Spoofed")
        end
        if rName and tostring(rName) ~= tostring(m.Name) then
            ap("PFP-SPOOF", "UserId/PFP Spoof Detected")
        end
    end)
end)

task.spawn(function()
    while task.wait(15.0) do
        if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then break end
        if getthreadidentity and pcall(getthreadidentity) and getthreadidentity() < 7 then
            ap("THREAD-HIJACK", "Privilege Downgrade Exploit")
        end
        local rPlr = e:GetPlayerByUserId(m.UserId)
        if rPlr and rPlr ~= m then
            ap("ID-SPOOF", "UserId Meta Hook Detected")
        end
    end
end)

local function aw()
    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
    local ax = getrawmetatable or function() return nil end
    local ay = isreadonly or function() return true end
    for _, az in ipairs({f, e, k, game:GetService("CoreGui"), game:GetService("StarterGui"), m}) do
        local aA = ax(az)
        if aA and (typeof(aA) ~= "table" or not ay(aA)) then
            ap("META-HOOK", "Service Compromised")
        end
    end
end

local function aB()
    local p, ae = pcall(function() return workspace:GetServerTimeNow() end)
    return p and math.floor(ae) or os.time()
end

local aC = aB()
local aD = 604800

-- ========================================================================= --
-- [STICKERS REGISTRY (100% PRESERVED)]
-- ========================================================================= --
local aE = {"77649364","4575171289","2939688117","377662481","8602843662","84406977929953","99638752080138","11648237431","5883531940","9597834616","12573542769","13297237968","135055229700449","14164452624","118477781128724","83990024276263","15404150022","168290988","15149485377","14742201370","13329191544","12753246648","15314865297","13276722238","13249175283","7037371946","13967189767","443560505","13116796587","14493140295","2888515085","13231918877","9086717675","14833591986","16360873499","6818722708","11623459250","12623079321","12053823662","12166869426","8182380790","11345695781","8456743354","1256360176","8768749220","5292514021","999768230","5407493180","7733028325","125989715201434","10647500234","716863728","6782774868","6994151853","1300344098","9165727833","6330794400","7556499349","2526156072","1453449619","562995176","12469870064","598216372","8698296249","5903467384","10908290816","7841526286","593859098","7115067559","11720860736","117835306190098","6045731887","9948638664","7552400717","347860305","6555037286","9385438651","2583962647","164257379","10135822340","10958368441","7377232515","10979508572","5808569143","108448993475959","5690340480","5207537160","8564974306","83677040163363","72687512455219","128965568153551","87410449404372","76757365751988","97531898393056","87239554144904","72793460663497","108283809544243","71992024065641","16022747924","138721634729987","90357041968118","136413255954959","100722574482118","70439907124750","95112780943766","112758420253845","130819442854007","87693756574279","105612301516352","124268818508779","86402817297314","15725480856","11257388490","16116414577","128857855373749","11920416812","13948817339","16007326492","107949395268622","77449075537615","91965007204396","108550928457595","135700976643537","71442089462191","124047412639555","90286953844894","83671542566237","96930545429149","74143981281416","75030286063678","81437059666138","129040222524985","85407192167743","98946997706325","100287950037286","80072297841157","96077354717088","96161460480890","138169899581401","106236025715477","116799405","95770046851932","124145396344946","86278563388796","113540856419753","115062400395026","107679067587993","106503865025496","111616336841381","134676873059671","108796531608917","107991336904158","102923210652647","127600871692693","116671713835756","91554946838716","129299999390074","112947637609310","9535816766","113433225859507","129716842531162","120533300214549","121648840999566","18260819726","16199278981","17597703320","13166065031","120578004452417","12729122625","9897741285","130121292590990","14036814111","128535076379472","12410868506","88936593668553","100088928101922","16450680734","12028496352","12028382065","18974318836","86247165299072","16172341273","81322691393605","14107602842","124905421403275","104386409157529","96811408303163","94625331166483","92064377599037","103845863474380","90727287236387","7530801913","14412069881","88780855152800","139094555259200","17894229494","96463708021010","17883713384","18355912002","10180536602","11818627075","9142678957","2245118763","2094272667","2790989672","3072000000","11648246819","10149736922","1049903144","5663084305","14790980059","10982686736","6754961478","6892957751","14334644220","7118722842"}

local aF = {}
local aG = {}
for _, aH in ipairs(aE) do
    local aI = tostring(aH)
    if not aG[aI] and aI ~= "102243712812624" then
        aG[aI] = true
        table.insert(aF, aI)
    end
end

-- ========================================================================= --
-- [WIRE-COMPATIBLE MESSAGE CODEC & SIGNATURE (V70.1 COMPATIBLE)]
-- ========================================================================= --
local function aJ(am)
    return string.upper(am:gsub(".", function(aK) return string.format("%02X", string.byte(aK)) end))
end

local function aL(aM)
    return aM:gsub("..", function(aN) return string.char(tonumber(aN, 16) or 0) end)
end

math.randomseed(os.time() + tick())

local aO = bit32 and bit32.bxor or function(aP, aQ)
    local aR, aK = 1, 0
    while aP > 0 or aQ > 0 do
        if aP % 2 ~= aQ % 2 then aK = aK + aR end
        aP, aQ, aR = math.floor(aP / 2), math.floor(aQ / 2), aR * 2
    end
    return aK
end

local function aS(aT)
    local am = string.upper(tostring(aT)) .. "||" .. aL(U())
    local aU = 2166136261
    for aV = 1, #am do
        aU = aO(aU, string.byte(am, aV))
        aU = aU * 16777619 % 4294967296
    end
    return string.format("%08X", aU)
end

local NETWORK_SECURITY_KEY = "k9#M$7xQ!wP2&vL9(bN5*zR8@jT4^yF1%qC6)mK3#sD7!hV8&tG2*x"

local function strToBytes(str)
    local b = {}
    for idx = 1, #str do b[idx] = string.byte(str, idx) end
    return b
end

local function bytesToHex(b)
    local h_t = {}
    for idx = 1, #b do h_t[idx] = string.format("%02x", b[idx]) end
    return table.concat(h_t)
end

local function hexToBytes(str)
    local b = {}
    for idx = 1, #str, 2 do b[#b + 1] = tonumber(str:sub(idx, idx + 1), 16) or 0 end
    return b
end

local function bytesToStr(b)
    local c_t = {}
    for idx = 1, #b do c_t[idx] = string.char(b[idx]) end
    return table.concat(c_t)
end

local function secureRandomBytes(len)
    local b = {}
    for idx = 1, len do b[idx] = math.random(0, 255) end
    return b
end

local function generateSecuritySignature(secKey, sender, payloadHex, timestamp)
    local raw = tostring(secKey) .. "::" .. tostring(sender) .. "::" .. tostring(payloadHex) .. "::" .. tostring(timestamp)
    local hash = 2166136261
    for idx = 1, #raw do
        hash = aO(hash, string.byte(raw, idx))
        hash = (hash * 16777619) % 4294967296
    end
    return string.format("%08X", hash)
end

local function deriveStreamKeyBytes(keyStr)
    local hash = 2166136261
    local out = {}
    for idx = 1, 32 do
        hash = aO(hash, string.byte(keyStr, (idx % #keyStr) + 1) or 0)
        hash = (hash * 16777619) % 4294967296
        out[idx] = hash % 256
    end
    return out
end

local function xorStreamTransform(keyBytes, nonceBytes, plainBytes)
    local out = {}
    local kSize = #keyBytes
    local nSize = #nonceBytes
    for idx = 1, #plainBytes do
        local kByte = keyBytes[((idx - 1) % kSize) + 1]
        local nByte = nonceBytes[((idx - 1) % nSize) + 1]
        out[idx] = aO(plainBytes[idx], aO(kByte, nByte))
    end
    return out
end

local function b3(aX, b4)
    local keyBytes = deriveStreamKeyBytes(aX)
    local nonceBytes = secureRandomBytes(12)
    local plainBytes = strToBytes(b4)
    local cipherBytes = xorStreamTransform(keyBytes, nonceBytes, plainBytes)
    local payloadCombined = bytesToHex(nonceBytes) .. "|" .. bytesToHex(cipherBytes)
    local sig = generateSecuritySignature(NETWORK_SECURITY_KEY, m.UserId, payloadCombined, os.time())
    return payloadCombined, sig
end

local function b9(aX, ba, bb)
    if not ba or not bb then return nil end
    local parts = string.split(ba, "|")
    if #parts ~= 2 then return nil end
    local keyBytes = deriveStreamKeyBytes(aX)
    local plainBytes = xorStreamTransform(keyBytes, hexToBytes(parts[1]), hexToBytes(parts[2]))
    return bytesToStr(plainBytes)
end

local function be(bf, bg)
    local p = {string.lower(bf), string.lower(bg)}
    table.sort(p)
    return "MATRIX_DM_CIPHER_" .. p[1] .. "_X_" .. p[2]
end

-- ========================================================================= --
-- [LOCAL STORAGE HELPERS]
-- ========================================================================= --
local bi = "CRYPTO_MATRIX_RELATION_MAP_" .. m.UserId .. ".json"
local bj = "QUANTUM_VAULT_BINARY_DATA_" .. m.UserId .. ".json"
local bk = "SYNCHRONIZATION_METLOCK_TIMESTAMPS_" .. m.UserId .. ".json"
local bl = "ZAYN_FAV_STICKERS_" .. m.UserId .. ".json"

local function bm()
    if not readfile then return {} end
    local p, b2 = pcall(function() return f:JSONDecode(readfile(bi)) end)
    return p and typeof(b2) == "table" and b2 or {}
end

local function bn(ae)
    if writefile then pcall(function() writefile(bi, f:JSONEncode(ae)) end) end
end

local function bo()
    if not readfile then return {} end
    local p, b2 = pcall(function() return f:JSONDecode(readfile(bj)) end)
    return p and typeof(b2) == "table" and b2 or {}
end

local function bp(ae)
    if writefile then pcall(function() writefile(bj, f:JSONEncode(ae)) end) end
end

local function bq()
    if not readfile then return {} end
    local p, b2 = pcall(function() return f:JSONDecode(readfile(bl)) end)
    return p and typeof(b2) == "table" and b2 or {}
end

local function br(ae)
    if writefile then pcall(function() writefile(bl, f:JSONEncode(ae)) end) end
end

-- ========================================================================= --
-- [MASTER STATE CONTAINER (V70.1 + V71.0 INSTA ELITE & ₹300 ELITE PASS)]
-- ========================================================================= --
local bs = {
    Version = "71.0",
    Mode = "Server",
    ActiveDM = nil,
    MessagesCount = 0,
    MaxMessages = 100,
    CurrentTheme = "PureBlack",
    ReplyingTo = nil,
    EditingMsgID = nil,
    ActiveSwipeBubble = nil,
    SwipeState = {
        Active = false,
        Bubble = nil,
        StartX = 0,
        BasePos = nil,
        IsMe = false,
        ReplyIcon = nil,
        Sender = "",
        LiveText = ""
    },
    SeenIDs = {},
    Cache = {Server = {}, DMs = {}},
    ActiveBubbleNodes = {},
    AccountRegistry = {},
    MuteServerToasts = false,
    UI = {},
    LastSendTime = 0,
    PendingCommitGrace = {},
    TitleRegistry = {["erennn0779"] = "CREATOR", ["izayn"] = "CREATOR"},
    ThrottlingFlags = {BurstCount = 0, LastWindow = os.clock()},
    IsLocked = false,
    ShadowMuted = {},
    MutedKeywords = {},
    LastSentMessage = "",
    MessageTimestamps = {},
    IsSpying = false,
    CloseFriends = bm(),
    FavStickers = bq(),
    PartnerReadTimestamps = {},
    DJRegistry = {["erennn0779"] = true, ["izayn"] = true},

    -- Centralized Zero-Lag Connection & Animation Manager
    Connections = {},
    AnimTasks = {},
    AnimNextId = 0,

    -- Safe Pre-Initialized Namespaces (Permanently Prevents nil-index errors!)
    AnimEngine = {
        ApplyAvatarEffect = function() end,
        ClearAvatarEffect = function() end,
        AttachFloatingParticles = function() end,
        ApplyGradientUsername = function() end,
        CreateAnimatedBadge = function() end,
        AttachCurvedTitle = function() end
    },
    SocialEngine = {},

    -- V71.0 Insta Elite Social & Customization State
    Social = {
        MyUid = tostring(m.UserId),
        ViewingProfileUid = tostring(m.UserId),
        CustomTab = "Avatar", -- "Avatar" | "Decoration" | "Theme" | "PremiumStore"
        PreviewDecoration = nil,
        PreviewTheme = nil,
        Profiles = {},          -- [uid] = {uid, username, displayName, bio, theme, decoration, frameStyle, badges, privacy}
        Followers = {},         -- [uid] = { [followerUid] = ts }
        Following = {},         -- [uid] = { [targetUid] = ts }
        Requests = {},          -- incoming requests for me
        SentRequests = {},      -- outgoing requests from me
        Blocks = {},            -- [blockedUid] = true
        BlockedBy = {},         -- [blockerUid] = true
        Presence = {},          -- [uid] = {online = bool, lastSeen = ts}
        Entitlements = {},      -- [uid] = {elitePass = bool, ownedDecorations = {}, ownedThemes = {}, badges = {}, grantedAt = ts}
        StoreConfig = {
            elitePassPriceINR = 300,
            discordContact = "official_zayn",
            discordServer = "ZAYN UI LAB (Discord: @official_zayn)",
            disabledDecorations = {},
            disabledThemes = {},
            priceOverrides = {},
            customItems = {}
        },
        Notifs = {},
        SeenNotifIds = {},
        UnreadNotifs = 0
    }
}

-- ========================================================================= --
-- [UNIFIED ZERO-LAG CONNECTION & ANIMATION MANAGER]
-- ========================================================================= --
function bs.TrackConn(conn)
    if conn then
        table.insert(bs.Connections, conn)
    end
    return conn
end

function bs.RegisterAnim(anchorGui, callback)
    bs.AnimNextId = bs.AnimNextId + 1
    local id = bs.AnimNextId
    bs.AnimTasks[id] = {
        gui = anchorGui,
        fn = callback
    }
    return id
end

function bs.UnregisterAnim(id)
    if id then
        bs.AnimTasks[id] = nil
    end
end

local masterAnimAccum = 0
bs.TrackConn(h.Heartbeat:Connect(function(dt)
    if type(a) == "table" and a.MatrixEngine_Unloading then
        return
    end
    masterAnimAccum = masterAnimAccum + dt
    if masterAnimAccum < 0.033 then
        return
    end
    local stepDt = masterAnimAccum
    masterAnimAccum = 0
    local now = os.clock()

    for id, taskObj in pairs(bs.AnimTasks) do
        local gui = taskObj.gui
        if not gui or not gui.Parent then
            bs.AnimTasks[id] = nil
        else
            local isVisible = true
            local cur = gui
            while cur and not cur:IsA("ScreenGui") do
                if cur:IsA("GuiObject") and not cur.Visible then
                    isVisible = false
                    break
                end
                cur = cur.Parent
            end
            if isVisible then
                pcall(taskObj.fn, now, stepDt)
            end
        end
    end
end))

-- Single Global Swipe Listener (Zero per-bubble leaks!)
bs.TrackConn(i.InputChanged:Connect(function(inputObj)
    local st = bs.SwipeState
    if not st.Active or not st.Bubble or not st.Bubble.Parent then return end
    if inputObj.UserInputType == Enum.UserInputType.MouseMovement or inputObj.UserInputType == Enum.UserInputType.Touch then
        local fx = inputObj.Position.X - st.StartX
        if st.IsMe and fx < 0 then
            local gm = math.max(fx, -60)
            st.Bubble.Position = st.BasePos + UDim2.new(0, gm, 0, 0)
            if st.ReplyIcon then st.ReplyIcon.TextTransparency = 1 - math.abs(gm) / 45 end
        elseif (not st.IsMe) and fx > 0 then
            local gm = math.min(fx, 60)
            st.Bubble.Position = st.BasePos + UDim2.new(0, gm, 0, 0)
            if st.ReplyIcon then st.ReplyIcon.TextTransparency = 1 - gm / 45 end
        end
    end
end))

bs.TrackConn(i.InputEnded:Connect(function(inputObj)
    local st = bs.SwipeState
    if not st.Active then return end
    if inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch then
        local bubble = st.Bubble
        local basePos = st.BasePos
        local repIcon = st.ReplyIcon
        local fx = inputObj.Position.X - st.StartX
        local isMe = st.IsMe
        local sender = st.Sender

        st.Active = false
        st.Bubble = nil
        bs.ActiveSwipeBubble = nil

        if bubble and bubble.Parent then
            if (isMe and fx <= -40) or ((not isMe) and fx >= 40) then
                local liveTxt = bubble:GetAttribute("LiveText") or st.LiveText or ""
                if bs.SetReply then
                    bs.SetReply(sender, liveTxt, bs.GetAccount(sender).DisplayName)
                end
            end
            g:Create(bubble, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = basePos}):Play()
        end
        if repIcon and repIcon.Parent then
            g:Create(repIcon, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        end
    end
end))

if type(a) == "table" then
    a.MatrixEngine_Cleanup = function()
        for _, conn in ipairs(bs.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        bs.Connections = {}
        bs.AnimTasks = {}
    end
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 2 / 8 : THEMES, SCREENGUI, SAFE DB ENGINE, TOASTS & AUDIO PIPELINE
-- ========================================================================= --

bs.ThumbnailCache = {}
bs.UsernameIdCache = {}
bs.IdUsernameCache = {}
bs.DisplayNameCache = {}

function bs.AttachBossInteractions(bt, bu)
    if not bt or not bt:IsA("GuiObject") then return end
    local bv = bt:FindFirstChild("BossScale") or Instance.new("UIScale")
    bv.Name = "BossScale"
    bv.Scale = 1.0
    bv.Parent = bt
    local bw = bt:FindFirstChildWhichIsA("UIStroke")

    bt.MouseEnter:Connect(function()
        g:Create(bv, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = bu or 1.05}):Play()
        if bw then
            g:Create(bw, TweenInfo.new(0.18), {Thickness = 2.0, Transparency = 0}):Play()
        end
    end)

    bt.MouseLeave:Connect(function()
        g:Create(bv, TweenInfo.new(0.20, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.0}):Play()
        if bw then
            g:Create(bw, TweenInfo.new(0.18), {Thickness = 1.2, Transparency = 0.2}):Play()
        end
    end)

    if bt:IsA("TextButton") or bt:IsA("ImageButton") then
        bt.MouseButton1Down:Connect(function()
            g:Create(bv, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.93}):Play()
        end)
        bt.MouseButton1Up:Connect(function()
            g:Create(bv, TweenInfo.new(0.28, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = bu or 1.05}):Play()
        end)
    end
end

-- ========================================================================= --
-- [ERROR-AWARE DATABASE WRAPPERS (DETECTS FIREBASE PERMISSION DENIED)]
-- ========================================================================= --
local function isFirebaseErrorBody(bodyStr)
    if type(bodyStr) ~= "string" then return true, "Empty response" end
    if bodyStr == "" or bodyStr:match("^%s*<") then
        return true, "Proxy returned HTML/empty response"
    end
    local ok, parsed = pcall(function() return f:JSONDecode(bodyStr) end)
    if ok and type(parsed) == "table" and parsed.error ~= nil then
        return true, tostring(parsed.error)
    end
    return false, nil
end

local function bx(H, by)
    local bz = os.clock()
    if bz - bs.ThrottlingFlags.LastWindow < 1.0 then
        bs.ThrottlingFlags.BurstCount = bs.ThrottlingFlags.BurstCount + 1
        if bs.ThrottlingFlags.BurstCount > 16 then
            return
        end
    else
        bs.ThrottlingFlags.BurstCount = 1
        bs.ThrottlingFlags.LastWindow = bz
    end
    task.spawn(function()
        local p, a_ = pcall(function() return G(H, "PUT", by) end)
        if not p or (a_ and a_.StatusCode and a_.StatusCode >= 400) then
            task.wait(0.8)
            pcall(function() G(H, "PUT", by) end)
        end
    end)
end

local function bA(bB)
    local bC = "?bust=" .. tostring(os.clock()):gsub("%.", "") .. "_" .. math.random(1000, 9999)
    local bD, a_ = pcall(function() return G(F .. "/" .. bB .. ".json" .. bC, "GET") end)
    if bD and typeof(a_) == "table" and (a_.StatusCode == 200 or a_.StatusCode == 304) and a_.Body and a_.Body ~= "null" and a_.Body ~= "" and not a_.Body:match("^%s*<") then
        local p, bE = pcall(f.JSONDecode, f, a_.Body)
        if p then
            if type(bE) == "table" and bE.error ~= nil then
                return nil
            end
            return bE
        end
    end
    return nil
end

function bs.DbGet(path)
    return bA(path)
end

function bs.DbPut(path, dataValue)
    local encoded = typeof(dataValue) == "string" and dataValue or f:JSONEncode(dataValue)
    local ok, res = pcall(function()
        return G(F .. "/" .. path .. ".json", "PUT", encoded)
    end)
    if not ok or type(res) ~= "table" then
        return false, "Network request failed"
    end
    if res.StatusCode and res.StatusCode >= 400 then
        local _, errText = isFirebaseErrorBody(res.Body)
        return false, errText or ("HTTP " .. tostring(res.StatusCode))
    end
    local hasErr, errMsg = isFirebaseErrorBody(res.Body)
    if hasErr then
        return false, errMsg
    end
    return true, nil
end

function bs.DbPutAsync(path, dataValue)
    local encoded = typeof(dataValue) == "string" and dataValue or f:JSONEncode(dataValue)
    bx(F .. "/" .. path .. ".json", encoded)
end

function bs.DbDelete(path)
    local ok, res = pcall(function()
        return G(F .. "/" .. path .. ".json", "DELETE")
    end)
    if not ok or type(res) ~= "table" then
        return false, "Network request failed"
    end
    if res.StatusCode and res.StatusCode >= 400 then
        local _, errText = isFirebaseErrorBody(res.Body)
        return false, errText or ("HTTP " .. tostring(res.StatusCode))
    end
    local hasErr, errMsg = isFirebaseErrorBody(res.Body)
    if hasErr then
        return false, errMsg
    end
    return true, nil
end

function bs.DbDeleteAsync(path)
    task.spawn(function()
        pcall(function()
            G(F .. "/" .. path .. ".json", "DELETE")
        end)
    end)
end

function bs.GetLastRead(bF)
    if not readfile then return bF and 0 or {} end
    local p, b2 = pcall(function() return f:JSONDecode(readfile(bk)) end)
    if not bF then
        return p and typeof(b2) == "table" and b2 or {}
    end
    return p and typeof(b2) == "table" and b2[bF] and tonumber(b2[bF]) or 0
end

function bs.SetLastRead(bF, bG)
    if not writefile then return end
    local p, b2 = pcall(function() return f:JSONDecode(readfile(bk)) end)
    local bH = p and typeof(b2) == "table" and b2 or {}
    bH[bF] = bG
    pcall(function() writefile(bk, f:JSONEncode(bH)) end)
end

function bs.GetUnreadCount(bF)
    local bI = 0
    local bJ = bs.GetLastRead(bF)
    for _, bK in ipairs(bs.Cache.DMs[bF] or {}) do
        if bK.Time > bJ and bK.UserID ~= m.UserId then
            bI = bI + 1
        end
    end
    return bI
end

-- ========================================================================= --
-- [CHAT UI THEMES (V70.1 PRESERVED + OBSIDIAN GOLD)]
-- ========================================================================= --
local bL = {
    PureBlack = {
        MainBg = Color3.fromRGB(5, 5, 10),
        HeaderBg = Color3.fromRGB(11, 11, 18),
        InputBg = Color3.fromRGB(18, 18, 28),
        TextColor = Color3.fromRGB(242, 244, 250),
        NameColor = Color3.fromRGB(180, 195, 220),
        SubText = Color3.fromRGB(128, 132, 155),
        MyBubble = Color3.fromRGB(42, 44, 60),
        OtherBubble = Color3.fromRGB(20, 20, 30),
        Accent = Color3.fromRGB(0, 225, 255),
        BgTrans = 0,
        HeadTrans = 0,
        InpTrans = 0,
        BubOtherTrans = 0,
        BubMeTrans = 0,
        StrokeColor = Color3.fromRGB(48, 54, 76),
        SendText = Color3.fromRGB(8, 10, 16)
    },
    ObsidianGold = {
        MainBg = Color3.fromRGB(10, 9, 14),
        HeaderBg = Color3.fromRGB(17, 15, 22),
        InputBg = Color3.fromRGB(24, 21, 30),
        TextColor = Color3.fromRGB(250, 246, 238),
        NameColor = Color3.fromRGB(255, 212, 75),
        SubText = Color3.fromRGB(168, 154, 128),
        MyBubble = Color3.fromRGB(78, 56, 18),
        OtherBubble = Color3.fromRGB(26, 23, 32),
        Accent = Color3.fromRGB(255, 205, 55),
        BgTrans = 0.02,
        HeadTrans = 0,
        InpTrans = 0,
        BubOtherTrans = 0,
        BubMeTrans = 0,
        StrokeColor = Color3.fromRGB(190, 145, 40),
        SendText = Color3.fromRGB(16, 12, 6)
    },
    Dark = {
        MainBg = Color3.fromRGB(24, 24, 30),
        HeaderBg = Color3.fromRGB(32, 32, 42),
        InputBg = Color3.fromRGB(38, 38, 50),
        TextColor = Color3.fromRGB(245, 245, 250),
        NameColor = Color3.fromRGB(165, 170, 195),
        SubText = Color3.fromRGB(130, 130, 155),
        MyBubble = Color3.fromRGB(90, 105, 245),
        OtherBubble = Color3.fromRGB(45, 45, 58),
        Accent = Color3.fromRGB(90, 105, 245),
        BgTrans = 0,
        HeadTrans = 0,
        InpTrans = 0,
        BubOtherTrans = 0,
        BubMeTrans = 0,
        StrokeColor = Color3.fromRGB(50, 50, 68),
        SendText = Color3.fromRGB(255, 255, 255)
    },
    Light = {
        MainBg = Color3.fromRGB(245, 247, 250),
        HeaderBg = Color3.fromRGB(255, 255, 255),
        InputBg = Color3.fromRGB(240, 242, 248),
        TextColor = Color3.fromRGB(15, 15, 20),
        NameColor = Color3.fromRGB(80, 80, 95),
        SubText = Color3.fromRGB(110, 110, 125),
        MyBubble = Color3.fromRGB(212, 235, 255),
        OtherBubble = Color3.fromRGB(225, 228, 235),
        Accent = Color3.fromRGB(230, 40, 60),
        BgTrans = 0,
        HeadTrans = 0,
        InpTrans = 0,
        BubOtherTrans = 0,
        BubMeTrans = 0,
        StrokeColor = Color3.fromRGB(220, 225, 235),
        SendText = Color3.fromRGB(255, 255, 255)
    },
    Glass = {
        MainBg = Color3.fromRGB(5, 15, 30),
        HeaderBg = Color3.fromRGB(10, 25, 50),
        InputBg = Color3.fromRGB(15, 35, 70),
        TextColor = Color3.fromRGB(255, 255, 255),
        NameColor = Color3.fromRGB(135, 215, 255),
        SubText = Color3.fromRGB(185, 205, 228),
        MyBubble = Color3.fromRGB(10, 120, 220),
        OtherBubble = Color3.fromRGB(25, 50, 90),
        Accent = Color3.fromRGB(0, 220, 255),
        BgTrans = 0.32,
        HeadTrans = 0.42,
        InpTrans = 0.42,
        BubOtherTrans = 0.35,
        BubMeTrans = 0.20,
        StrokeColor = Color3.fromRGB(50, 130, 220),
        SendText = Color3.fromRGB(255, 255, 255)
    },
    Lovely = {
        MainBg = Color3.fromRGB(255, 240, 245),
        HeaderBg = Color3.fromRGB(255, 225, 235),
        InputBg = Color3.fromRGB(255, 245, 250),
        TextColor = Color3.fromRGB(70, 40, 60),
        NameColor = Color3.fromRGB(200, 90, 130),
        SubText = Color3.fromRGB(150, 110, 130),
        MyBubble = Color3.fromRGB(255, 185, 205),
        OtherBubble = Color3.fromRGB(255, 215, 225),
        Accent = Color3.fromRGB(240, 100, 140),
        BgTrans = 0,
        HeadTrans = 0,
        InpTrans = 0,
        BubOtherTrans = 0,
        BubMeTrans = 0,
        StrokeColor = Color3.fromRGB(255, 195, 215),
        SendText = Color3.fromRGB(255, 255, 255)
    }
}

local bM = {"PureBlack", "ObsidianGold", "Dark", "Light", "Glass", "Lovely"}
local bN = {PureBlack = "⚫", ObsidianGold = "👑", Dark = "🌙", Light = "☀️", Glass = "🧊", Lovely = "🌸"}
local bO = 1
local bP = nil

pcall(function()
    bP = type(gethui) == "function" and gethui() or game:GetService("CoreGui")
end)
if not bP then
    bP = m:WaitForChild("PlayerGui")
end

local bQ = Instance.new("ScreenGui")
bQ.Name = o()
bQ.ResetOnSpawn = false
bQ.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
bQ.IgnoreGuiInset = true

local bR = pcall(function() bQ.Parent = bP end)
if not bR then
    bQ.Parent = m:WaitForChild("PlayerGui")
end

bs.TrackConn(bQ.AncestryChanged:Connect(function(_, bS)
    if bS == nil and bQ.Name:find("MatrixUI_") and type(getgenv) == "function" and not getgenv().MatrixEngine_Unloading then
        ap("UI-HIJACK", "UI Container Destroyed")
    end
end))

bs.TrackConn(bQ.Destroying:Connect(function()
    if j:FindFirstChild("MatrixCinematicBlur") then
        j.MatrixCinematicBlur:Destroy()
    end
    if type(a) == "table" and type(a.MatrixEngine_Cleanup) == "function" then
        pcall(a.MatrixEngine_Cleanup)
    end
end))

local bT = Instance.new("Frame", bQ)
bT.Name = "MatrixSmartToastContainer"
bT.Size = UDim2.new(0, 270, 0.65, 0)
bT.AnchorPoint = Vector2.new(1, 1)
bT.Position = UDim2.new(1, -15, 1, -15)
bT.BackgroundTransparency = 1
bT.ZIndex = 2000

local bU = Instance.new("UIListLayout", bT)
bU.Padding = UDim.new(0, 10)
bU.VerticalAlignment = Enum.VerticalAlignment.Bottom
bU.HorizontalAlignment = Enum.HorizontalAlignment.Right
bU.SortOrder = Enum.SortOrder.LayoutOrder

-- ========================================================================= --
-- [GLOBAL ANNOUNCEMENT, SPY MODE & TEXT SANITIZER]
-- ========================================================================= --
function bs.TriggerGlobalAnnouncement(bV)
    local aQ = Instance.new("Frame", bQ)
    aQ.Size = UDim2.new(1, 0, 0, 40)
    aQ.Position = UDim2.new(0, 0, 0, -40)
    aQ.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    aQ.ZIndex = 9999

    local ae = Instance.new("TextLabel", aQ)
    ae.Size = UDim2.new(1, 0, 1, 0)
    ae.BackgroundTransparency = 1
    ae.Text = "📢 ZAYN GLOBAL : " .. tostring(bV)
    ae.Font = Enum.Font.GothamBold
    ae.TextColor3 = Color3.fromRGB(255, 255, 255)
    ae.TextSize = 14
    ae.ZIndex = 10000

    g:Create(aQ, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(7.5, function()
        if aQ and aQ.Parent then
            g:Create(aQ, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, -40)}):Play()
            task.delay(0.5, function()
                if aQ and aQ.Parent then aQ:Destroy() end
            end)
        end
    end)
end

function bs.ToggleSpyMode(bW)
    local bX = e:FindFirstChild(bW)
    if bX and bX.Character and bX.Character:FindFirstChild("Humanoid") then
        if not bs.IsSpying then
            workspace.CurrentCamera.CameraSubject = bX.Character.Humanoid
            if m.Character then
                for _, d in pairs(m.Character:GetDescendants()) do
                    if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 1 end
                end
            end
            bs.IsSpying = true
            bs.TriggerToast("👁️ SPY MODE", "Spectating " .. bW, false)
        else
            workspace.CurrentCamera.CameraSubject = m.Character and m.Character:FindFirstChild("Humanoid") or workspace.CurrentCamera.CameraSubject
            bs.IsSpying = false
            bs.TriggerToast("👁️ SPY MODE", "Disabled", false)
        end
    else
        bs.TriggerToast("⚠️ SPY MODE", "Player not in this server!", false)
    end
end

local function bY(bZ)
    if not bZ then return "" end
    local _, _, b_ = bZ:match("^%[RPL::(.-)::(.-)::RPL%]%s*(.*)")
    local c0 = b_ or bZ
    if c0:sub(1, 5) == "[EDT]" then c0 = c0:sub(6) end
    if c0:match("^%[MEDIA::") then return "🖼️ [Image Vault]" end
    if c0:match("^%[STICKER://") then return "🏵️ [Sticker]" end
    return c0:gsub("<[^>]+>", "")
end

function bs.SyncNativeRobloxBubbleSettings()
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    pcall(function()
        local c1 = game:GetService("TextChatService")
        if c1 and c1:FindFirstChild("BubbleChatConfiguration") then
            c1.BubbleChatConfiguration.BackgroundColor3 = ae.OtherBubble
            c1.BubbleChatConfiguration.TextColor3 = ae.TextColor
        end
    end)
    pcall(function()
        game:GetService("Chat"):SetBubbleChatSettings({
            BackgroundColor3 = ae.OtherBubble,
            TextColor3 = ae.TextColor
        })
    end)
end

-- ========================================================================= --
-- [CACHED ACCOUNT REGISTRY & FAST AVATAR LOADER]
-- ========================================================================= --
function bs.RegisterAccount(c2, c3, c4, c5)
    if not c2 or typeof(c2) ~= "string" or c2 == "" then return end
    local c6 = c2:lower()
    local uidNum = tonumber(c4) or 1
    if not bs.AccountRegistry[c6] then
        bs.AccountRegistry[c6] = {
            Username = c2,
            DisplayName = c3 or c2,
            UserId = uidNum,
            Verified = false
        }
    else
        if uidNum > 1 then bs.AccountRegistry[c6].UserId = uidNum end
        if c3 and c3 ~= "" then bs.AccountRegistry[c6].DisplayName = c3 end
    end

    if uidNum > 1 then
        local uidStr = tostring(uidNum)
        bs.UsernameIdCache[c6] = uidNum
        bs.IdUsernameCache[uidStr] = bs.AccountRegistry[c6].Username
        bs.DisplayNameCache[uidStr] = bs.AccountRegistry[c6].DisplayName
    end

    if c5 and bs.AccountRegistry[c6].Verified then
        c5.Text = bs.AccountRegistry[c6].DisplayName .. " (@" .. bs.AccountRegistry[c6].Username .. ")"
    elseif not bs.AccountRegistry[c6].Verified and uidNum > 1 and l then
        task.spawn(function()
            local p, ak = pcall(function() return l:GetUserInfosByUserIdsAsync({uidNum})[1] end)
            if p and ak and ak.Username then
                if ak.Username:lower() ~= c6 then return end
                bs.AccountRegistry[c6].DisplayName = ak.DisplayName or ak.Username
                bs.AccountRegistry[c6].Username = ak.Username
                bs.AccountRegistry[c6].Verified = true
                bs.IdUsernameCache[tostring(uidNum)] = ak.Username
                bs.DisplayNameCache[tostring(uidNum)] = ak.DisplayName or ak.Username
                if c5 and c5.Parent then
                    c5.Text = (ak.DisplayName or ak.Username) .. " (@" .. ak.Username .. ")"
                end
            end
        end)
    end
end

function bs.GetAccount(c7)
    if not c7 or typeof(c7) ~= "string" then
        return {Username = "Unknown", DisplayName = "Unknown", UserId = 1, Verified = false}
    end
    local c6 = c7:lower()
    if bs.AccountRegistry[c6] then
        return bs.AccountRegistry[c6]
    end
    for _, aR in ipairs(e:GetPlayers()) do
        if aR.Name:lower() == c6 then
            bs.RegisterAccount(aR.Name, aR.DisplayName, aR.UserId)
            return bs.AccountRegistry[c6]
        end
    end
    return {Username = c7, DisplayName = c7, UserId = bs.UsernameIdCache[c6] or 1, Verified = false}
end

function bs.GetAccountByUid(uid)
    local uidStr = tostring(uid or "")
    local uidNum = tonumber(uid) or 0
    if uidNum <= 0 then
        return {Username = "Unknown", DisplayName = "Unknown", UserId = 0, Verified = false}
    end
    local livePlr = e:GetPlayerByUserId(uidNum)
    if livePlr then
        bs.RegisterAccount(livePlr.Name, livePlr.DisplayName, livePlr.UserId)
        return bs.AccountRegistry[livePlr.Name:lower()]
    end
    local prof = bs.Social.Profiles[uidStr]
    if prof and prof.username then
        bs.RegisterAccount(prof.username, prof.displayName or prof.username, uidNum)
        return {Username = prof.username, DisplayName = prof.displayName or prof.username, UserId = uidNum, Verified = true}
    end
    if bs.IdUsernameCache[uidStr] then
        local uname = bs.IdUsernameCache[uidStr]
        return {Username = uname, DisplayName = bs.DisplayNameCache[uidStr] or uname, UserId = uidNum, Verified = true}
    end
    return {Username = "User_" .. uidStr, DisplayName = "User " .. uidStr, UserId = uidNum, Verified = false}
end

function bs.ResolveUserInput(query)
    local clean = tostring(query or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("^@", "")
    if clean == "" then return nil end

    if clean:match("^%d+$") then
        local uidNum = tonumber(clean)
        if not uidNum or uidNum <= 0 then return nil end
        local livePlr = e:GetPlayerByUserId(uidNum)
        if livePlr then
            bs.RegisterAccount(livePlr.Name, livePlr.DisplayName, livePlr.UserId)
            return {UserId = livePlr.UserId, Username = livePlr.Name, DisplayName = livePlr.DisplayName}
        end
        if bs.IdUsernameCache[clean] then
            return {UserId = uidNum, Username = bs.IdUsernameCache[clean], DisplayName = bs.DisplayNameCache[clean] or bs.IdUsernameCache[clean]}
        end
        if l then
            local ok, infoArr = pcall(function() return l:GetUserInfosByUserIdsAsync({uidNum}) end)
            if ok and type(infoArr) == "table" and infoArr[1] and infoArr[1].Username then
                local uInfo = infoArr[1]
                bs.RegisterAccount(uInfo.Username, uInfo.DisplayName or uInfo.Username, uidNum)
                return {UserId = uidNum, Username = uInfo.Username, DisplayName = uInfo.DisplayName or uInfo.Username}
            end
        end
        local okN, uname = pcall(function() return e:GetNameFromUserIdAsync(uidNum) end)
        if okN and uname then
            bs.RegisterAccount(uname, uname, uidNum)
            return {UserId = uidNum, Username = uname, DisplayName = uname}
        end
        return nil
    end

    local low = clean:lower()
    for _, aR in ipairs(e:GetPlayers()) do
        if aR.Name:lower() == low or aR.DisplayName:lower() == low then
            bs.RegisterAccount(aR.Name, aR.DisplayName, aR.UserId)
            return {UserId = aR.UserId, Username = aR.Name, DisplayName = aR.DisplayName}
        end
    end

    if bs.UsernameIdCache[low] and bs.UsernameIdCache[low] > 1 then
        local acc = bs.GetAccount(low)
        return {UserId = acc.UserId, Username = acc.Username, DisplayName = acc.DisplayName}
    end

    local okId, foundUid = pcall(function() return e:GetUserIdFromNameAsync(clean) end)
    if okId and foundUid and foundUid > 0 then
        local uname, dname = clean, clean
        if l then
            pcall(function()
                local infoArr = l:GetUserInfosByUserIdsAsync({foundUid})
                if infoArr and infoArr[1] then
                    uname = infoArr[1].Username or clean
                    dname = infoArr[1].DisplayName or uname
                end
            end)
        else
            pcall(function()
                uname = e:GetNameFromUserIdAsync(foundUid) or clean
                dname = uname
            end)
        end
        bs.RegisterAccount(uname, dname, foundUid)
        return {UserId = foundUid, Username = uname, DisplayName = dname}
    end
    return nil
end

local function c8(c9, H)
    if not H then return end
    if H:sub(1, 10):lower() == "rbxassetid" or H:sub(1, 9):lower() == "rbxthumb:" then
        c9.Image = H
        return
    end
    if not getcustomasset or not isfile then return end
    local ca = aS(H)
    local cb = "MatrixMediaCache_" .. ca .. ".png"
    if pcall(isfile, cb) and isfile(cb) then
        pcall(function() c9.Image = getcustomasset(cb) end)
        return
    end
    task.spawn(function()
        local bD, a_ = pcall(function() return n({Url = H, Method = "GET", Timeout = 12}) end)
        if bD and a_ and a_.StatusCode == 200 and a_.Body then
            pcall(function()
                if writefile then writefile(cb, a_.Body) end
                c9.Image = getcustomasset(cb)
            end)
        end
    end)
end

function bs.LoadHeadshotByUid(imgLabel, uid)
    if not imgLabel then return end
    local num = tonumber(uid)
    if not num or num <= 0 then
        imgLabel.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
        return
    end
    imgLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(num) .. "&w=150&h=150"
end

local function cc(cd, ce)
    if not cd then return end
    if ce == "ZARA" then
        cd.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
        return
    end
    local low = tostring(ce or ""):lower()
    if bs.ThumbnailCache[low] then
        cd.Image = bs.ThumbnailCache[low]
        return
    end
    local livePlr = e:FindFirstChild(ce)
    if livePlr then
        local uri = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(livePlr.UserId) .. "&w=150&h=150"
        bs.ThumbnailCache[low] = uri
        bs.UsernameIdCache[low] = livePlr.UserId
        cd.Image = uri
        return
    end
    if bs.UsernameIdCache[low] and bs.UsernameIdCache[low] > 1 then
        local uri = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(bs.UsernameIdCache[low]) .. "&w=150&h=150"
        bs.ThumbnailCache[low] = uri
        cd.Image = uri
        return
    end
    task.spawn(function()
        local bD, cf = pcall(function() return e:GetUserIdFromNameAsync(ce) end)
        local aH = (bD and cf and cf > 0) and cf or 1
        bs.UsernameIdCache[low] = aH
        local uri = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(aH) .. "&w=150&h=150"
        bs.ThumbnailCache[low] = uri
        if cd and cd.Parent then cd.Image = uri end
    end)
end

-- ========================================================================= --
-- [REACTIONS, ADMIN COMMANDS & CHAT LOCK]
-- ========================================================================= --
function bs.ToggleReaction(cg, ch)
    task.spawn(function()
        local ci = m.Name:lower()
        local cj = F .. "/" .. L .. "/" .. Z .. "/" .. cg .. "/_rct"
        local ck = false
        local cl = nil
        if bs.Mode == "DM" and bs.ActiveDM then
            cl = bs.ActiveDM
            cj = F .. "/" .. M .. "/" .. ci .. "/" .. cl .. "/" .. cg .. "/_rct"
            ck = true
        end
        local cm = (bs.Mode == "Server") and bs.Cache.Server or (bs.Mode == "DM" and bs.Cache.DMs[bs.ActiveDM] or nil)
        local cn, co = nil, {}
        if cm then
            for _, cp in ipairs(cm) do
                if cp.ID == cg then cn = cp; co = cp.Reactions or {}; break end
            end
        end
        local cq = nil
        for cr, cs in pairs(co) do
            if typeof(cs) == "table" and cs[ci] then cq = cr; break end
        end
        local ct = aJ(ch)
        if not ct or ct == "" then return end
        local function cu(H, I, J) pcall(function() G(H, I, J) end) end

        if cq == ct then
            co[cq][ci] = nil
            if next(co[cq]) == nil then co[cq] = nil end
            cu(cj .. "/" .. cq .. "/" .. ci .. ".json", "DELETE")
            if ck then cu(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. cg .. "/_rct/" .. cq .. "/" .. ci .. ".json", "DELETE") end
            bs.TriggerToast("🎭 Reaction", "Removed " .. ch, false)
        else
            if cq then
                co[cq][ci] = nil
                if next(co[cq]) == nil then co[cq] = nil end
                cu(cj .. "/" .. cq .. "/" .. ci .. ".json", "DELETE")
                if ck then cu(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. cg .. "/_rct/" .. cq .. "/" .. ci .. ".json", "DELETE") end
            end
            co[ct] = co[ct] or {}
            co[ct][ci] = true
            cu(cj .. "/" .. ct .. "/" .. ci .. ".json", "PUT", '"true"')
            if ck then cu(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. cg .. "/_rct/" .. ct .. "/" .. ci .. ".json", "PUT", '"true"') end
            bs.TriggerToast("🎭 Reaction", "Reacted with " .. ch, false)
        end
        if cn then
            cn.Reactions = co
            pcall(function() bs.UpdateBubbleReactions(cg, co) end)
        end
    end)
end

function bs.DispatchGodCommand(cv)
    if not au() then ap("GOD-SPOOF", "Illegal God Execution"); return end
    if cv:sub(1, 9) == "BAN_USER:" then
        task.spawn(function() G(F .. "/" .. O .. "/Accs/" .. cv:sub(10):lower() .. ".json", "PUT", '"true"') end)
    elseif cv:sub(1, 11) == "UNBAN_USER:" then
        local cw = cv:sub(12):lower()
        task.spawn(function()
            local ok, cx = pcall(function() return G(F .. "/" .. O .. "/Accs/" .. cw .. ".json", "GET").Body end)
            if ok and type(cx) == "string" and cx ~= "null" and cx ~= "" then
                G(F .. "/" .. O .. "/HWs/" .. cx:gsub('"', '') .. ".json", "DELETE")
            end
            G(F .. "/" .. O .. "/Accs/" .. cw .. ".json", "DELETE")
        end)
    elseif cv:sub(1, 10) == "LOCK_CHAT:" then
        task.spawn(function() G(F .. "/" .. P .. "/" .. cv:sub(11):lower() .. ".json", "PUT", '"true"') end)
    elseif cv:sub(1, 12) == "UNLOCK_CHAT:" then
        task.spawn(function() G(F .. "/" .. P .. "/" .. cv:sub(13):lower() .. ".json", "DELETE") end)
    elseif cv:sub(1, 13) == "MUTE_KEYWORD:" then
        task.spawn(function() G(F .. "/" .. Q .. "/KWs/" .. cv:sub(14):lower() .. ".json", "PUT", '"true"') end)
    elseif cv:sub(1, 15) == "UNMUTE_KEYWORD:" then
        task.spawn(function() G(F .. "/" .. Q .. "/KWs/" .. cv:sub(16):lower() .. ".json", "DELETE") end)
    elseif cv:sub(1, 9) == "GRANT_DJ:" then
        local cw = cv:sub(10):lower()
        bs.DJRegistry[cw] = true
        bs.TriggerToast("🎵 SYSTEM UPDATE", cw .. " granted Server DJ Access.", false)
    elseif cv:sub(1, 10) == "REVOKE_DJ:" then
        local cw = cv:sub(11):lower()
        bs.DJRegistry[cw] = nil
        bs.TriggerToast("🎵 SYSTEM UPDATE", cw .. " lost Server DJ Access.", false)
    end

    local cz, cA = b3(W, cv)
    task.spawn(function()
        G(F .. "/" .. L .. "/" .. Z .. "/ZAYN_NET_GOD_" .. os.time() .. "_" .. math.random(100, 999) .. ".json", "PUT", f:JSONEncode({
            u = m.UserId, s = "ZARA_OVERSEER_PROTOCOL", m = cz, sign = cA, t = aB()
        }))
    end)
    bs.TriggerToast("⚙️ Admin Action", "Issued: " .. (cv:match("^(.-):") or cv), false)
end

function bs.SetLockState(cB)
    bs.IsLocked = cB
    if not bs.UI.TextBox then return end
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    if cB then
        bs.UI.TextBox.TextEditable = false
        bs.UI.TextBox.ClearTextOnFocus = false
        bs.UI.TextBox.Text = ""
        bs.UI.TextBox.PlaceholderText = "🔒 ZAYN CHAT LOCKED BY ADMIN"
        bs.UI.TextBox.TextColor3 = Color3.fromRGB(255, 80, 80)
        bs.UI.SendBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
    else
        bs.UI.TextBox.TextEditable = true
        bs.UI.TextBox.PlaceholderText = "Type message..."
        bs.UI.TextBox.TextColor3 = ae.TextColor
        bs.UI.SendBtn.BackgroundColor3 = ae.Accent
    end
end

task.spawn(function()
    local p, aQ = pcall(function() return G(F .. "/" .. P .. "/" .. m.Name:lower() .. ".json", "GET").Body end)
    if p and aQ and aQ == '"true"' then bs.SetLockState(true) end
    local a5, cC = pcall(function() return G(F .. "/" .. Q .. "/KWs.json", "GET").Body end)
    if a5 and cC and cC ~= "null" and cC ~= "" and not cC:match("^%s*<") then
        local p2, cD = pcall(function() return f:JSONDecode(cC) end)
        if p2 and type(cD) == "table" and not cD.error then bs.MutedKeywords = cD end
    end
end)

-- ========================================================================= --
-- [SMART TOAST NOTIFICATIONS]
-- ========================================================================= --
function bs.TriggerToast(e4, f8, ck, f9, fa)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local eS = Instance.new("Frame")
    eS.Size = UDim2.new(1, 0, 0, 54)
    eS.BackgroundColor3 = ae.HeaderBg
    eS.BackgroundTransparency = 1
    eS.ZIndex = 2001
    Instance.new("UICorner", eS).CornerRadius = UDim.new(0, 12)

    local fb = Instance.new("UIStroke", eS)
    fb.Color = ck and Color3.fromRGB(0, 220, 115) or ae.Accent
    fb.Transparency = 1

    local fc = Instance.new("TextLabel", eS)
    fc.Size = UDim2.new(1, -20, 1, 0)
    fc.Position = UDim2.new(0, 10, 0, 0)
    fc.BackgroundTransparency = 1
    fc.Font = Enum.Font.GothamMedium
    fc.TextSize = 11.5
    fc.TextColor3 = ae.TextColor
    fc.TextTransparency = 1
    fc.TextXAlignment = Enum.TextXAlignment.Left
    fc.RichText = true
    fc.ClipsDescendants = true
    fc.ZIndex = 2002
    fc.Text = string.format("<b>%s</b>\n<font color='#9AA0B8'>%s</font>", tostring(e4), bY(tostring(f8)):sub(1, 42))

    local fd = nil
    if fa then
        fc.Size = UDim2.new(1, -56, 1, 0)
        fc.Position = UDim2.new(0, 50, 0, 0)
        fd = Instance.new("ImageLabel", eS)
        fd.Size = UDim2.new(0, 34, 0, 34)
        fd.Position = UDim2.new(0, 8, 0.5, -17)
        fd.BackgroundTransparency = 1
        fd.ImageTransparency = 1
        fd.ZIndex = 2002
        Instance.new("UICorner", fd).CornerRadius = UDim.new(1, 0)
        cc(fd, fa)
    end

    eS.Parent = bT
    g:Create(eS, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = ae.HeadTrans}):Play()
    g:Create(fb, TweenInfo.new(0.30), {Transparency = 0}):Play()
    g:Create(fc, TweenInfo.new(0.30), {TextTransparency = 0}):Play()
    if fd then g:Create(fd, TweenInfo.new(0.30), {ImageTransparency = 0}):Play() end

    if ck and f9 then
        local fe = Instance.new("TextButton", eS)
        fe.Size = UDim2.new(1, 0, 1, 0)
        fe.BackgroundTransparency = 1
        fe.Text = ""
        fe.ZIndex = 2003
        fe.MouseButton1Click:Connect(function()
            bs.SwitchMode("DM", f9)
            if bs.UI.MainBg and not bs.UI.MainBg.Visible then bs.UI.MainBg.Visible = true end
            eS:Destroy()
        end)
    end

    task.spawn(function()
        task.wait(4)
        if eS and eS.Parent then
            local ff = g:Create(eS, TweenInfo.new(0.28), {BackgroundTransparency = 1})
            g:Create(fc, TweenInfo.new(0.28), {TextTransparency = 1}):Play()
            g:Create(fb, TweenInfo.new(0.28), {Transparency = 1}):Play()
            if fd then g:Create(fd, TweenInfo.new(0.28), {ImageTransparency = 1}):Play() end
            ff:Play()
            ff.Completed:Wait()
            if eS and eS.Parent then eS:Destroy() end
        end
    end)
end

function bs.TriggerArrivalToast(fg)
    local eS = Instance.new("Frame")
    eS.Size = UDim2.new(1, 0, 0, 56)
    eS.BackgroundColor3 = Color3.fromRGB(22, 10, 40)
    eS.BackgroundTransparency = 1
    eS.ZIndex = 2001
    Instance.new("UICorner", eS).CornerRadius = UDim.new(0, 12)

    local fb = Instance.new("UIStroke", eS)
    fb.Color = Color3.fromRGB(180, 60, 255)
    fb.Thickness = 1.5
    fb.Transparency = 1

    local fd = Instance.new("ImageLabel", eS)
    fd.Size = UDim2.new(0, 34, 0, 34)
    fd.Position = UDim2.new(0, 10, 0.5, -17)
    fd.BackgroundTransparency = 1
    fd.ImageTransparency = 1
    fd.Image = "rbxthumb://type=Asset&id=81131373496932&w=150&h=150"
    fd.ZIndex = 2002
    Instance.new("UICorner", fd).CornerRadius = UDim.new(1, 0)

    local fc = Instance.new("TextLabel", eS)
    fc.Size = UDim2.new(1, -58, 1, 0)
    fc.Position = UDim2.new(0, 54, 0, 0)
    fc.BackgroundTransparency = 1
    fc.Font = Enum.Font.GothamMedium
    fc.TextSize = 11
    fc.TextColor3 = Color3.fromRGB(255, 255, 255)
    fc.TextXAlignment = Enum.TextXAlignment.Left
    fc.RichText = true
    fc.TextTransparency = 1
    fc.ZIndex = 2002
    fc.Text = "<font color='#B43CFF'><b>ZARA</b></font>\nWelcome dear <b>" .. tostring(fg) .. "</b>!"

    eS.Parent = bT
    g:Create(eS, TweenInfo.new(0.32, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 0.08}):Play()
    g:Create(fb, TweenInfo.new(0.32), {Transparency = 0}):Play()
    g:Create(fc, TweenInfo.new(0.32), {TextTransparency = 0}):Play()
    g:Create(fd, TweenInfo.new(0.32), {ImageTransparency = 0}):Play()

    task.spawn(function()
        task.wait(4.2)
        if eS and eS.Parent then
            local ff = g:Create(eS, TweenInfo.new(0.32), {BackgroundTransparency = 1})
            g:Create(fc, TweenInfo.new(0.32), {TextTransparency = 1}):Play()
            g:Create(fb, TweenInfo.new(0.32), {Transparency = 1}):Play()
            g:Create(fd, TweenInfo.new(0.32), {ImageTransparency = 1}):Play()
            ff:Play()
            ff.Completed:Wait()
            if eS and eS.Parent then eS:Destroy() end
        end
    end)
end

function bs.TriggerSocialToast(titleText, bodyText, accentColor, avatarUid, onClickFn)
    local eS = Instance.new("Frame")
    eS.Size = UDim2.new(1, 0, 0, 58)
    eS.BackgroundColor3 = Color3.fromRGB(14, 12, 26)
    eS.BackgroundTransparency = 1
    eS.ZIndex = 2001
    Instance.new("UICorner", eS).CornerRadius = UDim.new(0, 12)

    local fb = Instance.new("UIStroke", eS)
    fb.Color = accentColor or Color3.fromRGB(0, 230, 255)
    fb.Thickness = 1.6
    fb.Transparency = 1

    local fd = Instance.new("ImageLabel", eS)
    fd.Size = UDim2.new(0, 34, 0, 34)
    fd.Position = UDim2.new(0, 10, 0.5, -17)
    fd.BackgroundTransparency = 1
    fd.ImageTransparency = 1
    fd.ZIndex = 2002
    Instance.new("UICorner", fd).CornerRadius = UDim.new(1, 0)
    bs.LoadHeadshotByUid(fd, avatarUid)

    local fc = Instance.new("TextLabel", eS)
    fc.Size = UDim2.new(1, -56, 1, 0)
    fc.Position = UDim2.new(0, 52, 0, 0)
    fc.BackgroundTransparency = 1
    fc.Font = Enum.Font.GothamMedium
    fc.TextSize = 11
    fc.TextColor3 = Color3.fromRGB(245, 245, 255)
    fc.TextXAlignment = Enum.TextXAlignment.Left
    fc.RichText = true
    fc.TextWrapped = true
    fc.ClipsDescendants = true
    fc.TextTransparency = 1
    fc.ZIndex = 2002
    fc.Text = string.format("<b>%s</b>\n<font color='#A5A8C8'>%s</font>", tostring(titleText), tostring(bodyText):sub(1, 70))

    eS.Parent = bT
    g:Create(eS, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.06}):Play()
    g:Create(fb, TweenInfo.new(0.30), {Transparency = 0}):Play()
    g:Create(fc, TweenInfo.new(0.30), {TextTransparency = 0}):Play()
    g:Create(fd, TweenInfo.new(0.30), {ImageTransparency = 0}):Play()

    if type(onClickFn) == "function" then
        local fe = Instance.new("TextButton", eS)
        fe.Size = UDim2.new(1, 0, 1, 0)
        fe.BackgroundTransparency = 1
        fe.Text = ""
        fe.ZIndex = 2003
        fe.MouseButton1Click:Connect(function()
            if bs.UI.MainBg and not bs.UI.MainBg.Visible then
                bs.UI.MainBg.Visible = true
                bs.UI.MainBg.GroupTransparency = 0
            end
            pcall(onClickFn)
            eS:Destroy()
        end)
    end

    task.spawn(function()
        task.wait(4.6)
        if eS and eS.Parent then
            local ff = g:Create(eS, TweenInfo.new(0.28), {BackgroundTransparency = 1})
            g:Create(fc, TweenInfo.new(0.28), {TextTransparency = 1}):Play()
            g:Create(fb, TweenInfo.new(0.28), {Transparency = 1}):Play()
            g:Create(fd, TweenInfo.new(0.28), {ImageTransparency = 1}):Play()
            ff:Play()
            ff.Completed:Wait()
            if eS and eS.Parent then eS:Destroy() end
        end
    end)
end

-- ========================================================================= --
-- [RESILIENT MULTI-API MUSIC SEARCH & STREAMING ENGINE (FIXES INVALID JSON)]
-- ========================================================================= --
local function formatDurSec(sec)
    local num = tonumber(sec)
    if not num or num <= 0 then return "03:30" end
    return string.format("%02d:%02d", math.floor(num / 60), math.floor(num % 60))
end

function bs.SearchMusicTracks(query)
    local encoded = f:UrlEncode(query)
    local rapidHost = "youtube-search-unlimited.p.rapidapi.com"
    local rapidKey = "0542323a46mshec2535016607a28p102505jsne1f803a161ef"

    -- Provider 1: Primary RapidAPI Search
    local ok1, res1 = pcall(function()
        return n({
            Url = "https://" .. rapidHost .. "/ytsearch/?query=" .. encoded,
            Method = "GET",
            Timeout = 8,
            Headers = {
                ["X-RapidAPI-Host"] = rapidHost,
                ["X-RapidAPI-Key"] = rapidKey,
                ["Content-Type"] = "application/json"
            }
        })
    end)

    if ok1 and res1 and res1.StatusCode == 200 and res1.Body and res1.Body ~= "" and not res1.Body:match("^%s*<") then
        local decOk, parsed = pcall(function() return f:JSONDecode(res1.Body) end)
        if decOk and type(parsed) == "table" and not parsed.message then
            local rawList = parsed.results or parsed.videos or parsed.items or parsed
            if type(rawList) == "table" and #rawList > 0 then
                local tracks = {}
                for _, node in ipairs(rawList) do
                    if type(node) == "table" then
                        local vId = type(node.id) == "table" and (node.id.videoId or node.id.video_id) or (node.id or node.videoId or node.video_id)
                        local tName = node.title or node.name
                        local ch = node.channel or node.author or node.uploaderName or "YouTube"
                        if type(ch) == "table" then ch = ch.name or "YouTube" end
                        local dur = node.duration or node.durationText or node.length or node.lengthText or "03:45"
                        if tName and vId then
                            table.insert(tracks, {title = tostring(tName), channel = tostring(ch), id = tostring(vId), duration = tostring(dur)})
                            if #tracks >= 12 then break end
                        end
                    end
                end
                if #tracks > 0 then return true, tracks, "RapidAPI" end
            end
        end
    end

    -- Provider 2+: Free Piped / Invidious Public API Fallbacks (Prevents Invalid JSON failures!)
    local fallbacks = {
        {kind = "piped", url = "https://pipedapi.kavin.rocks/search?q=" .. encoded .. "&filter=music_songs"},
        {kind = "piped", url = "https://pipedapi.adminforge.de/search?q=" .. encoded .. "&filter=videos"},
        {kind = "invidious", url = "https://inv.nadeko.net/api/v1/search?q=" .. encoded .. "&type=video"},
        {kind = "invidious", url = "https://iv.ggtyler.dev/api/v1/search?q=" .. encoded .. "&type=video"}
    }

    for _, ep in ipairs(fallbacks) do
        local okF, resF = pcall(function()
            return n({Url = ep.url, Method = "GET", Timeout = 8})
        end)
        if okF and resF and resF.StatusCode == 200 and resF.Body and resF.Body ~= "" and not resF.Body:match("^%s*<") then
            local decOk, parsed = pcall(function() return f:JSONDecode(resF.Body) end)
            if decOk and type(parsed) == "table" then
                local items = (ep.kind == "piped") and (parsed.items or parsed) or parsed
                if type(items) == "table" and #items > 0 then
                    local tracks = {}
                    for _, node in ipairs(items) do
                        if type(node) == "table" then
                            local durNum = tonumber(node.duration or node.lengthSeconds) or 200
                            if durNum <= 450 then
                                local vId = node.videoId
                                if not vId and type(node.url) == "string" then
                                    vId = node.url:match("v=([%w_%-]+)")
                                end
                                local tName = node.title
                                local ch = node.uploaderName or node.author or "YouTube"
                                if vId and tName then
                                    table.insert(tracks, {
                                        title = tostring(tName),
                                        channel = tostring(ch),
                                        id = tostring(vId),
                                        duration = formatDurSec(durNum)
                                    })
                                    if #tracks >= 12 then break end
                                end
                            end
                        end
                    end
                    if #tracks > 0 then return true, tracks, ep.kind end
                end
            end
        end
    end

    return false, {}, "All search nodes busy or rate-limited. Try again in a moment."
end

function bs.PlayGlobalTrack(trackId)
    local downloadHost = "youtube-mp36.p.rapidapi.com"
    local soundSvc = game:GetService("SoundService")
    local GlobalSound = soundSvc:FindFirstChild("MatrixGlobalSound") or Instance.new("Sound", soundSvc)
    GlobalSound.Name = "MatrixGlobalSound"
    GlobalSound.Volume = 0.6
    if GlobalSound.IsPlaying then GlobalSound:Stop() end

    local linkUrl = "https://" .. downloadHost .. "/dl?id=" .. tostring(trackId)
    task.spawn(function()
        local finalLink = nil
        local retries = 0
        while retries < 12 do
            local success, res = pcall(function()
                return n({
                    Url = linkUrl,
                    Method = "GET",
                    Timeout = 10,
                    Headers = {
                        ["X-RapidAPI-Host"] = downloadHost,
                        ["X-RapidAPI-Key"] = "0542323a46mshec2535016607a28p102505jsne1f803a161ef",
                        ["Content-Type"] = "application/json"
                    }
                })
            end)
            if success and res and res.StatusCode == 200 and res.Body and res.Body ~= "" and not res.Body:match("^%s*<") then
                local decodeOk, data = pcall(function() return f:JSONDecode(res.Body) end)
                if decodeOk and type(data) == "table" then
                    if data.status == "ok" and data.link then
                        finalLink = data.link
                        break
                    elseif data.status == "processing" or data.msg == "in queue" then
                        retries = retries + 1
                        task.wait(0.8)
                    else
                        break
                    end
                else
                    break
                end
            else
                break
            end
        end

        if finalLink then
            local fileOk, buffer = pcall(function() return n({Url = finalLink, Method = "GET", Timeout = 15}) end)
            if fileOk and buffer and buffer.StatusCode == 200 and buffer.Body then
                local targetFile = "Zayn_GlobalSync_" .. tostring(trackId) .. ".mp3"
                pcall(function() if writefile then writefile(targetFile, buffer.Body) end end)
                task.wait(0.05)
                local assetOk, localAssetToken = pcall(function() return getcustomasset(targetFile) end)
                if assetOk and localAssetToken then
                    GlobalSound.SoundId = localAssetToken
                    GlobalSound:Play()
                end
            end
        end
    end)
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 3 / 8 : 12 AVATAR DECORATIONS, 10 PROFILE THEMES & ANIMATION ENGINE
-- ========================================================================= --

bs.TierColors = {
    Free = Color3.fromRGB(0, 225, 175),
    ElitePass = Color3.fromRGB(255, 205, 55),
    Exclusive = Color3.fromRGB(255, 55, 175),
    Legendary = Color3.fromRGB(180, 75, 255)
}

-- ========================================================================= --
-- [SECTION A : 12 PREMIUM AVATAR DECORATIONS CATALOG]
-- ========================================================================= --
bs.DecorationCatalog = {
    {
        id = "rgb_neon",
        name = "RGB Neon Ring",
        tier = "Free",
        priceINR = 0,
        accent = Color3.fromRGB(0, 240, 255),
        secondary = Color3.fromRGB(255, 45, 165),
        description = "Smooth 360-degree full spectrum RGB neon chroma ring."
    },
    {
        id = "royal_gold",
        name = "Royal Gold Aura",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(255, 210, 55),
        secondary = Color3.fromRGB(255, 145, 15),
        description = "Molten 24K gold rotating halo with royal orbiting crown stars."
    },
    {
        id = "galaxy_king",
        name = "Galaxy King",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(165, 65, 255),
        secondary = Color3.fromRGB(0, 210, 255),
        description = "Deep-space royal nebula ring with twinkling astral crown sparks."
    },
    {
        id = "fire_lord",
        name = "Fire Lord",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(255, 85, 15),
        secondary = Color3.fromRGB(255, 220, 50),
        description = "Blazing solar inferno ring with rising ember sparks & heat pulse."
    },
    {
        id = "ice_emperor",
        name = "Ice Emperor",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(130, 235, 255),
        secondary = Color3.fromRGB(240, 252, 255),
        description = "Crystalline glacial halo with orbiting frost snowflakes."
    },
    {
        id = "cyber_phantom",
        name = "Cyber Phantom",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(255, 0, 145),
        secondary = Color3.fromRGB(0, 255, 235),
        description = "Cybernetic neon glitch ring with holographic vertical scanline."
    },
    {
        id = "diamond_elite",
        name = "Diamond Elite",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(220, 248, 255),
        secondary = Color3.fromRGB(140, 195, 255),
        description = "Platinum crystal shimmer ring with dazzling diamond starbursts."
    },
    {
        id = "rainbow_pulse",
        name = "Rainbow Pulse",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(255, 70, 200),
        secondary = Color3.fromRGB(60, 255, 185),
        description = "Expanding prismatic shockwave pulse with live HSV rotation."
    },
    {
        id = "shadow_legend",
        name = "Shadow Legend",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(135, 35, 225),
        secondary = Color3.fromRGB(255, 30, 75),
        description = "Dark obsidian eclipse ring with crimson-violet phantom wisps."
    },
    {
        id = "electric_storm",
        name = "Electric Storm",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(80, 215, 255),
        secondary = Color3.fromRGB(235, 250, 255),
        description = "High-voltage crackling plasma bolts surging around your avatar."
    },
    {
        id = "holo_ring",
        name = "Holographic Ring",
        tier = "ElitePass",
        priceINR = 300,
        accent = Color3.fromRGB(110, 255, 230),
        secondary = Color3.fromRGB(210, 120, 255),
        description = "Iridescent futuristic prism aura with counter-rotating light bands."
    },
    {
        id = "cosmic_energy",
        name = "Cosmic Energy",
        tier = "Legendary",
        priceINR = 300,
        accent = Color3.fromRGB(255, 55, 190),
        secondary = Color3.fromRGB(0, 240, 255),
        description = "Dual counter-rotating astral rings with mythic orbiting energy orbs."
    }
}

bs.DecorationMap = {}
for _, dItem in ipairs(bs.DecorationCatalog) do
    bs.DecorationMap[dItem.id] = dItem
end

-- ========================================================================= --
-- [SECTION B : 10 PREMIUM FULL PROFILE THEMES CATALOG]
-- ========================================================================= --
bs.ProfileThemeCatalog = {
    {
        id = "royal_black_gold",
        name = "Royal Black & Gold",
        tier = "Free",
        priceINR = 0,
        bg1 = Color3.fromRGB(10, 9, 12),
        bg2 = Color3.fromRGB(36, 26, 10),
        cardBg = Color3.fromRGB(18, 16, 20),
        borderColor = Color3.fromRGB(245, 195, 55),
        accent = Color3.fromRGB(255, 212, 65),
        accent2 = Color3.fromRGB(255, 140, 20),
        textColor = Color3.fromRGB(252, 248, 238),
        subText = Color3.fromRGB(190, 172, 132),
        particleColor = Color3.fromRGB(255, 215, 80),
        description = "Obsidian black canvas lined with 24K royal gold shimmer."
    },
    {
        id = "cyberpunk_neon",
        name = "Cyberpunk Neon",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(12, 6, 22),
        bg2 = Color3.fromRGB(48, 8, 44),
        cardBg = Color3.fromRGB(20, 12, 34),
        borderColor = Color3.fromRGB(255, 35, 155),
        accent = Color3.fromRGB(0, 245, 255),
        accent2 = Color3.fromRGB(255, 35, 155),
        textColor = Color3.fromRGB(245, 250, 255),
        subText = Color3.fromRGB(175, 155, 210),
        particleColor = Color3.fromRGB(0, 245, 255),
        description = "High-contrast neon pink and electric cyan cyber city grid."
    },
    {
        id = "galaxy_universe",
        name = "Galaxy Universe",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(9, 7, 26),
        bg2 = Color3.fromRGB(36, 14, 72),
        cardBg = Color3.fromRGB(18, 13, 40),
        borderColor = Color3.fromRGB(165, 75, 255),
        accent = Color3.fromRGB(185, 95, 255),
        accent2 = Color3.fromRGB(45, 205, 255),
        textColor = Color3.fromRGB(246, 242, 255),
        subText = Color3.fromRGB(168, 160, 212),
        particleColor = Color3.fromRGB(200, 150, 255),
        description = "Deep cosmic nebula gradient with floating stardust particles."
    },
    {
        id = "blood_moon",
        name = "Blood Moon",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(16, 5, 8),
        bg2 = Color3.fromRGB(58, 10, 18),
        cardBg = Color3.fromRGB(26, 10, 14),
        borderColor = Color3.fromRGB(235, 40, 55),
        accent = Color3.fromRGB(255, 55, 65),
        accent2 = Color3.fromRGB(255, 145, 45),
        textColor = Color3.fromRGB(255, 240, 242),
        subText = Color3.fromRGB(195, 140, 148),
        particleColor = Color3.fromRGB(255, 75, 85),
        description = "Crimson lunar eclipse obsidian theme with glowing ruby borders."
    },
    {
        id = "ice_kingdom",
        name = "Ice Kingdom",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(6, 16, 28),
        bg2 = Color3.fromRGB(14, 46, 72),
        cardBg = Color3.fromRGB(12, 26, 42),
        borderColor = Color3.fromRGB(120, 230, 255),
        accent = Color3.fromRGB(145, 240, 255),
        accent2 = Color3.fromRGB(230, 250, 255),
        textColor = Color3.fromRGB(242, 252, 255),
        subText = Color3.fromRGB(155, 205, 225),
        particleColor = Color3.fromRGB(185, 245, 255),
        description = "Frosted glacial glassmorphism with crisp arctic crystal accents."
    },
    {
        id = "emerald_elite",
        name = "Emerald Elite",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(5, 16, 14),
        bg2 = Color3.fromRGB(10, 48, 36),
        cardBg = Color3.fromRGB(11, 26, 22),
        borderColor = Color3.fromRGB(0, 235, 155),
        accent = Color3.fromRGB(0, 245, 165),
        accent2 = Color3.fromRGB(120, 255, 215),
        textColor = Color3.fromRGB(238, 255, 248),
        subText = Color3.fromRGB(142, 198, 178),
        particleColor = Color3.fromRGB(40, 255, 175),
        description = "Rich obsidian emerald vault with neon mint highlights."
    },
    {
        id = "holo_future",
        name = "Holographic Future",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(10, 14, 26),
        bg2 = Color3.fromRGB(28, 22, 56),
        cardBg = Color3.fromRGB(16, 20, 36),
        borderColor = Color3.fromRGB(115, 245, 235),
        accent = Color3.fromRGB(100, 250, 235),
        accent2 = Color3.fromRGB(220, 110, 255),
        textColor = Color3.fromRGB(248, 252, 255),
        subText = Color3.fromRGB(165, 185, 218),
        particleColor = Color3.fromRGB(150, 245, 255),
        description = "Iridescent pearl-prism futuristic glass with shifting chroma trims."
    },
    {
        id = "diamond_luxury",
        name = "Diamond Luxury",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(14, 16, 24),
        bg2 = Color3.fromRGB(36, 44, 62),
        cardBg = Color3.fromRGB(22, 25, 36),
        borderColor = Color3.fromRGB(225, 242, 255),
        accent = Color3.fromRGB(235, 248, 255),
        accent2 = Color3.fromRGB(155, 205, 255),
        textColor = Color3.fromRGB(255, 255, 255),
        subText = Color3.fromRGB(180, 195, 220),
        particleColor = Color3.fromRGB(240, 250, 255),
        description = "Brushed platinum & diamond-white luxury profile showcase."
    },
    {
        id = "shadow_assassin",
        name = "Shadow Assassin",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(6, 6, 10),
        bg2 = Color3.fromRGB(26, 10, 34),
        cardBg = Color3.fromRGB(13, 12, 20),
        borderColor = Color3.fromRGB(155, 45, 235),
        accent = Color3.fromRGB(175, 65, 255),
        accent2 = Color3.fromRGB(255, 35, 85),
        textColor = Color3.fromRGB(240, 238, 248),
        subText = Color3.fromRGB(145, 138, 170),
        particleColor = Color3.fromRGB(170, 55, 245),
        description = "Stealth matte-obsidian theme with razor violet-crimson accents."
    },
    {
        id = "sunset_aura",
        name = "Sunset Aura",
        tier = "ElitePass",
        priceINR = 300,
        bg1 = Color3.fromRGB(22, 10, 24),
        bg2 = Color3.fromRGB(64, 24, 34),
        cardBg = Color3.fromRGB(30, 15, 28),
        borderColor = Color3.fromRGB(255, 130, 65),
        accent = Color3.fromRGB(255, 155, 60),
        accent2 = Color3.fromRGB(255, 55, 145),
        textColor = Color3.fromRGB(255, 246, 242),
        subText = Color3.fromRGB(215, 168, 165),
        particleColor = Color3.fromRGB(255, 175, 90),
        description = "Warm twilight horizon blending golden amber with neon rose."
    }
}

bs.ProfileThemeMap = {}
for _, tItem in ipairs(bs.ProfileThemeCatalog) do
    bs.ProfileThemeMap[tItem.id] = tItem
end

-- ========================================================================= --
-- [SECTION C : ANIMATED BADGES REGISTRY]
-- ========================================================================= --
bs.BadgeCatalog = {
    CREATOR = {
        label = "👑 CREATOR",
        c1 = Color3.fromRGB(0, 235, 255),
        c2 = Color3.fromRGB(255, 50, 190),
        bg = Color3.fromRGB(28, 14, 44),
        textCol = Color3.fromRGB(255, 255, 255)
    },
    VIP = {
        label = "💎 VIP ELITE",
        c1 = Color3.fromRGB(255, 215, 65),
        c2 = Color3.fromRGB(255, 135, 20),
        bg = Color3.fromRGB(40, 28, 10),
        textCol = Color3.fromRGB(255, 248, 218)
    },
    LEGEND = {
        label = "🌌 LEGEND",
        c1 = Color3.fromRGB(185, 70, 255),
        c2 = Color3.fromRGB(255, 60, 175),
        bg = Color3.fromRGB(32, 12, 48),
        textCol = Color3.fromRGB(255, 245, 255)
    },
    ELITE = {
        label = "⚡ ELITE",
        c1 = Color3.fromRGB(0, 220, 255),
        c2 = Color3.fromRGB(45, 115, 255),
        bg = Color3.fromRGB(10, 28, 48),
        textCol = Color3.fromRGB(235, 250, 255)
    },
    OG = {
        label = "🔥 OG",
        c1 = Color3.fromRGB(255, 105, 40),
        c2 = Color3.fromRGB(255, 45, 95),
        bg = Color3.fromRGB(42, 14, 18),
        textCol = Color3.fromRGB(255, 240, 235)
    },
    DJ = {
        label = "🎵 DJ",
        c1 = Color3.fromRGB(0, 255, 180),
        c2 = Color3.fromRGB(0, 180, 255),
        bg = Color3.fromRGB(10, 34, 34),
        textCol = Color3.fromRGB(230, 255, 250)
    }
}

-- ========================================================================= --
-- [SECTION D : ZERO-LAG ANIMATION ENGINE (12 DECORATIONS + FRAMES + PARTICLES)]
-- ========================================================================= --
function bs.AnimEngine.ClearAvatarEffect(container)
    if not container then return end
    local oldAnimId = container:GetAttribute("ZaynAvatarAnimId")
    if oldAnimId then
        bs.UnregisterAnim(oldAnimId)
        container:SetAttribute("ZaynAvatarAnimId", nil)
    end
    local oldFx = container:FindFirstChild("ZaynAvatarFX")
    if oldFx then
        oldFx:Destroy()
    end
end

function bs.AnimEngine.ApplyAvatarEffect(container, decorId, compactMode)
    if not container or not container:IsA("GuiObject") then return end
    bs.AnimEngine.ClearAvatarEffect(container)

    if not decorId or decorId == "" or decorId == "none" then
        return
    end

    local decor = bs.DecorationMap[decorId]
    if not decor then
        -- Support admin-added custom decorations dynamically
        local customList = bs.Social.StoreConfig and bs.Social.StoreConfig.customItems
        if type(customList) == "table" and customList[decorId] then
            local cItem = customList[decorId]
            decor = {
                id = decorId,
                name = tostring(cItem.name or decorId),
                accent = Color3.fromRGB(tonumber(cItem.r1) or 0, tonumber(cItem.g1) or 230, tonumber(cItem.b1) or 255),
                secondary = Color3.fromRGB(tonumber(cItem.r2) or 255, tonumber(cItem.g2) or 65, tonumber(cItem.b2) or 190)
            }
        else
            return
        end
    end

    local isCompact = compactMode == true
    local baseZ = (container.ZIndex or 1) + 2

    local fxRoot = Instance.new("Frame")
    fxRoot.Name = "ZaynAvatarFX"
    fxRoot.Size = UDim2.new(1, 0, 1, 0)
    fxRoot.Position = UDim2.new(0.5, 0, 0.5, 0)
    fxRoot.AnchorPoint = Vector2.new(0.5, 0.5)
    fxRoot.BackgroundTransparency = 1
    fxRoot.ZIndex = baseZ
    fxRoot.Parent = container

    local mainRing = Instance.new("Frame", fxRoot)
    mainRing.Name = "MainRing"
    mainRing.Size = UDim2.new(1, isCompact and 4 or 8, 1, isCompact and 4 or 8)
    mainRing.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainRing.AnchorPoint = Vector2.new(0.5, 0.5)
    mainRing.BackgroundTransparency = 1
    mainRing.ZIndex = baseZ + 1
    Instance.new("UICorner", mainRing).CornerRadius = UDim.new(1, 0)

    local mainStroke = Instance.new("UIStroke", mainRing)
    mainStroke.Thickness = isCompact and 1.8 or 3.0
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local mainGrad = Instance.new("UIGradient", mainStroke)

    local haloRing = Instance.new("Frame", fxRoot)
    haloRing.Name = "HaloRing"
    haloRing.Size = UDim2.new(1, isCompact and 8 or 16, 1, isCompact and 8 or 16)
    haloRing.Position = UDim2.new(0.5, 0, 0.5, 0)
    haloRing.AnchorPoint = Vector2.new(0.5, 0.5)
    haloRing.BackgroundTransparency = 1
    haloRing.ZIndex = baseZ
    Instance.new("UICorner", haloRing).CornerRadius = UDim.new(1, 0)

    local haloStroke = Instance.new("UIStroke", haloRing)
    haloStroke.Thickness = isCompact and 1.1 or 2.0
    haloStroke.Color = decor.accent
    haloStroke.Transparency = 0.5

    local haloGrad = Instance.new("UIGradient", haloStroke)
    haloGrad.Color = ColorSequence.new(decor.accent, decor.secondary)

    local function createOrbitNodes(count, dotSize, symbol, col1, col2)
        if isCompact then return {} end
        local nodes = {}
        for idx = 1, count do
            local node
            if symbol then
                node = Instance.new("TextLabel", fxRoot)
                node.Size = UDim2.new(0, dotSize + 5, 0, dotSize + 5)
                node.BackgroundTransparency = 1
                node.Text = symbol
                node.Font = Enum.Font.GothamBold
                node.TextSize = dotSize + 2
                node.TextColor3 = (idx % 2 == 0) and col2 or col1
            else
                node = Instance.new("Frame", fxRoot)
                node.Size = UDim2.new(0, dotSize, 0, dotSize)
                node.BackgroundColor3 = (idx % 2 == 0) and col2 or col1
                node.BorderSizePixel = 0
                Instance.new("UICorner", node).CornerRadius = UDim.new(1, 0)
            end
            node.AnchorPoint = Vector2.new(0.5, 0.5)
            node.ZIndex = baseZ + 4
            table.insert(nodes, {obj = node, phase = (idx - 1) * (math.pi * 2 / count), idx = idx})
        end
        return nodes
    end

    local animId = nil

    -- 1. RGB NEON RING
    if decorId == "rgb_neon" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 0, 95)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 200, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 145)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 210, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 0, 95))
        })
        haloGrad.Color = mainGrad.Color
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 165) % 360
            haloGrad.Rotation = (-now * 110) % 360
            haloStroke.Transparency = 0.42 + math.sin(now * 3.2) * 0.16
        end)

    -- 2. ROYAL GOLD AURA
    elseif decorId == "royal_gold" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 245, 165)),
            ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 195, 35)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 105, 10)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 245, 165))
        })
        local sparks = createOrbitNodes(4, 7, "✦", Color3.fromRGB(255, 238, 125), Color3.fromRGB(255, 180, 30))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 95) % 360
            local p = (math.sin(now * 2.8) + 1) * 0.5
            haloStroke.Transparency = 0.28 + p * 0.42
            for _, sp in ipairs(sparks) do
                local ang = now * 1.45 + sp.phase
                sp.obj.Position = UDim2.new(0.5 + math.cos(ang) * 0.58, 0, 0.5 + math.sin(ang) * 0.58, 0)
                sp.obj.TextTransparency = 0.1 + ((math.sin(now * 5 + sp.idx) + 1) * 0.35)
            end
        end)

    -- 3. GALAXY KING
    elseif decorId == "galaxy_king" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(175, 65, 255)),
            ColorSequenceKeypoint.new(0.35, Color3.fromRGB(45, 20, 130)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 210, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 210, 75))
        })
        local stars = createOrbitNodes(5, 6, "✧", Color3.fromRGB(225, 195, 255), Color3.fromRGB(115, 235, 255))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 75) % 360
            haloGrad.Rotation = (-now * 50) % 360
            haloStroke.Transparency = 0.32 + math.sin(now * 2.4) * 0.2
            for _, st in ipairs(stars) do
                local ang = now * (0.95 + (st.idx % 2) * 0.45) + st.phase
                local rad = 0.57 + ((st.idx % 2) * 0.05)
                st.obj.Position = UDim2.new(0.5 + math.cos(ang) * rad, 0, 0.5 + math.sin(ang) * rad, 0)
                st.obj.TextTransparency = 0.12 + ((math.sin(now * 4 + st.idx * 2) + 1) * 0.35)
            end
        end)

    -- 4. FIRE LORD
    elseif decorId == "fire_lord" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 238, 80)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 95, 15)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(210, 18, 15)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 238, 80))
        })
        local embers = createOrbitNodes(5, 4, nil, Color3.fromRGB(255, 200, 45), Color3.fromRGB(255, 65, 15))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 195) % 360
            local flicker = (math.sin(now * 16) + math.cos(now * 9)) * 0.25 + 0.5
            mainStroke.Thickness = (isCompact and 1.8 or 2.8) + flicker * 1.1
            haloStroke.Transparency = 0.24 + (1 - flicker) * 0.45
            for _, em in ipairs(embers) do
                local life = (now * 0.95 + em.idx * 0.21) % 1
                local xOff = math.sin(now * 3.2 + em.idx * 2) * 0.42
                em.obj.Position = UDim2.new(0.5 + xOff, 0, 0.92 - life * 1.12, 0)
                em.obj.BackgroundTransparency = life
            end
        end)

    -- 5. ICE EMPEROR
    elseif decorId == "ice_emperor" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(245, 253, 255)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(95, 228, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(45, 145, 235)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(245, 253, 255))
        })
        local shards = createOrbitNodes(4, 7, "❄", Color3.fromRGB(230, 250, 255), Color3.fromRGB(115, 228, 255))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 58) % 360
            haloStroke.Transparency = 0.32 + math.sin(now * 2.5) * 0.2
            for _, sh in ipairs(shards) do
                local ang = now * 1.15 + sh.phase
                sh.obj.Position = UDim2.new(0.5 + math.cos(ang) * 0.58, 0, 0.5 + math.sin(ang) * 0.58, 0)
                sh.obj.Rotation = (now * 85) % 360
            end
        end)

    -- 6. CYBER PHANTOM
    elseif decorId == "cyber_phantom" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 255, 240)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 155)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 255, 240))
        })
        local scanLine = nil
        if not isCompact then
            scanLine = Instance.new("Frame", fxRoot)
            scanLine.Size = UDim2.new(0.92, 0, 0, 2)
            scanLine.AnchorPoint = Vector2.new(0.5, 0.5)
            scanLine.BackgroundColor3 = Color3.fromRGB(0, 255, 240)
            scanLine.BackgroundTransparency = 0.25
            scanLine.BorderSizePixel = 0
            scanLine.ZIndex = baseZ + 3
        end
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 145) % 360
            haloGrad.Rotation = (-now * 185) % 360
            local glitchTick = math.floor(now * 10) % 13 == 0
            if glitchTick then
                haloRing.Position = UDim2.new(0.5, math.random(-2, 2), 0.5, math.random(-1, 1))
                haloStroke.Color = Color3.fromRGB(255, 0, 150)
                haloStroke.Transparency = 0.15
            else
                haloRing.Position = UDim2.new(0.5, 0, 0.5, 0)
                haloStroke.Color = Color3.fromRGB(0, 255, 235)
                haloStroke.Transparency = 0.48
            end
            if scanLine then
                local yPos = (now * 0.72) % 1
                scanLine.Position = UDim2.new(0.5, 0, yPos, 0)
                scanLine.BackgroundTransparency = 0.25 + math.abs(yPos - 0.5) * 1.1
            end
        end)

    -- 7. DIAMOND ELITE
    elseif decorId == "diamond_elite" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(165, 200, 245)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.55, Color3.fromRGB(190, 245, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(165, 200, 245))
        })
        local glints = createOrbitNodes(4, 8, "✦", Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 242, 255))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 135) % 360
            haloStroke.Transparency = 0.28 + math.abs(math.sin(now * 3.5)) * 0.45
            for _, gl in ipairs(glints) do
                local ang = gl.phase + math.sin(now * 0.6) * 0.25
                gl.obj.Position = UDim2.new(0.5 + math.cos(ang) * 0.56, 0, 0.5 + math.sin(ang) * 0.56, 0)
                gl.obj.TextTransparency = 1 - math.max(0, math.sin(now * 4.5 + gl.idx * 1.7))
            end
        end)

    -- 8. RAINBOW PULSE
    elseif decorId == "rainbow_pulse" then
        animId = bs.RegisterAnim(fxRoot, function(now)
            local h1 = (now * 0.28) % 1
            local c1 = Color3.fromHSV(h1, 0.9, 1)
            local c2 = Color3.fromHSV((h1 + 0.33) % 1, 0.9, 1)
            local c3 = Color3.fromHSV((h1 + 0.66) % 1, 0.9, 1)
            mainGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, c1),
                ColorSequenceKeypoint.new(0.5, c2),
                ColorSequenceKeypoint.new(1, c3)
            })
            mainGrad.Rotation = (now * 125) % 360
            local wave = (now * 1.1) % 1
            local pad = (isCompact and 4 or 8) + math.floor(wave * (isCompact and 10 or 20))
            haloRing.Size = UDim2.new(1, pad, 1, pad)
            haloStroke.Color = c1
            haloStroke.Transparency = wave
        end)

    -- 9. SHADOW LEGEND
    elseif decorId == "shadow_legend" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(20, 12, 32)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(150, 35, 240)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 25, 75)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(20, 12, 32))
        })
        local wisps = createOrbitNodes(4, 5, nil, Color3.fromRGB(175, 45, 255), Color3.fromRGB(255, 35, 85))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (-now * 115) % 360
            haloGrad.Rotation = (now * 85) % 360
            local pulse = (math.sin(now * 3.0) + 1) * 0.5
            haloStroke.Transparency = 0.22 + (1 - pulse) * 0.5
            for _, ws in ipairs(wisps) do
                local ang = -now * 1.9 + ws.phase
                local rad = 0.55 + math.sin(now * 3 + ws.idx) * 0.05
                ws.obj.Position = UDim2.new(0.5 + math.cos(ang) * rad, 0, 0.5 + math.sin(ang) * rad, 0)
            end
        end)

    -- 10. ELECTRIC STORM
    elseif decorId == "electric_storm" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(235, 250, 255)),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(40, 175, 255)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(125, 75, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(235, 250, 255))
        })
        local bolts = createOrbitNodes(4, 8, "⚡", Color3.fromRGB(120, 235, 255), Color3.fromRGB(255, 255, 255))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 320) % 360
            local zap = math.sin(now * 24) > 0.52
            mainStroke.Thickness = (isCompact and 1.8 or 2.8) + (zap and 1.2 or 0)
            haloStroke.Transparency = zap and 0.14 or 0.65
            for _, bNode in ipairs(bolts) do
                local ang = now * 3.1 + bNode.phase
                local jitter = zap and 0.04 or 0
                bNode.obj.Position = UDim2.new(0.5 + math.cos(ang) * (0.58 + jitter), 0, 0.5 + math.sin(ang) * (0.58 + jitter), 0)
                bNode.obj.TextTransparency = zap and 0 or 0.42
            end
        end)

    -- 11. HOLOGRAPHIC RING
    elseif decorId == "holo_ring" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(110, 255, 235)),
            ColorSequenceKeypoint.new(0.35, Color3.fromRGB(215, 130, 255)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 195, 230)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(110, 255, 235))
        })
        haloGrad.Color = mainGrad.Color
        local prisms = createOrbitNodes(4, 6, "◆", Color3.fromRGB(130, 255, 240), Color3.fromRGB(225, 145, 255))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 110) % 360
            haloGrad.Rotation = (-now * 145) % 360
            local p = (math.sin(now * 3.0) + 1) * 0.5
            haloStroke.Transparency = 0.25 + p * 0.35
            for _, pr in ipairs(prisms) do
                local ang = now * 1.3 + pr.phase
                pr.obj.Position = UDim2.new(0.5 + math.cos(ang) * 0.58, 0, 0.5 + math.sin(ang) * 0.58, 0)
                pr.obj.Rotation = (now * 120) % 360
            end
        end)

    -- 12. COSMIC ENERGY
    elseif decorId == "cosmic_energy" then
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 50, 185)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(145, 55, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 240, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 215, 70))
        })
        haloGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 240, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 55, 195)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 210, 60))
        })
        local orbs = createOrbitNodes(6, 5, nil, Color3.fromRGB(0, 240, 255), Color3.fromRGB(255, 75, 195))
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 160) % 360
            haloGrad.Rotation = (-now * 125) % 360
            local pulse = (math.sin(now * 3.2) + 1) * 0.5
            mainStroke.Thickness = (isCompact and 2.0 or 3.2) + pulse * 0.9
            haloStroke.Transparency = 0.2 + (1 - pulse) * 0.38
            local pad = (isCompact and 8 or 16) + math.floor(pulse * (isCompact and 4 or 6))
            haloRing.Size = UDim2.new(1, pad, 1, pad)
            for _, ob in ipairs(orbs) do
                local dir = (ob.idx % 2 == 0) and 1 or -1
                local ang = now * (1.85 * dir) + ob.phase
                local rad = (ob.idx % 2 == 0) and 0.58 or 0.64
                ob.obj.Position = UDim2.new(0.5 + math.cos(ang) * rad, 0, 0.5 + math.sin(ang) * rad, 0)
            end
        end)

    -- FALLBACK FOR ADMIN-ADDED CUSTOM DECORATIONS
    else
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, decor.accent),
            ColorSequenceKeypoint.new(0.5, decor.secondary),
            ColorSequenceKeypoint.new(1.0, decor.accent)
        })
        animId = bs.RegisterAnim(fxRoot, function(now)
            mainGrad.Rotation = (now * 130) % 360
            haloStroke.Transparency = 0.3 + ((math.sin(now * 3) + 1) * 0.25)
        end)
    end

    if animId then
        container:SetAttribute("ZaynAvatarAnimId", animId)
    end
end

-- ========================================================================= --
-- [ANIMATED PROFILE FRAME, PARTICLES, GRADIENT NAMES, BADGES & CURVED TITLES]
-- ========================================================================= --
function bs.AnimEngine.ApplyProfileFrameEffect(frameObj, themeObj, isElite)
    if not frameObj or not themeObj then return end
    local stroke = frameObj:FindFirstChild("ZaynEliteFrameStroke") or Instance.new("UIStroke", frameObj)
    stroke.Name = "ZaynEliteFrameStroke"
    stroke.Thickness = isElite and 2.0 or 1.4
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = isElite and 0.1 or 0.3

    local grad = stroke:FindFirstChild("FrameGrad") or Instance.new("UIGradient", stroke)
    grad.Name = "FrameGrad"
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, themeObj.accent),
        ColorSequenceKeypoint.new(0.5, themeObj.accent2),
        ColorSequenceKeypoint.new(1.0, themeObj.accent)
    })

    local oldId = frameObj:GetAttribute("ZaynFrameAnimId")
    if oldId then bs.UnregisterAnim(oldId) end

    if isElite then
        local id = bs.RegisterAnim(frameObj, function(now)
            grad.Rotation = (now * 75) % 360
        end)
        frameObj:SetAttribute("ZaynFrameAnimId", id)
    end
end

function bs.AnimEngine.AttachFloatingParticles(parentFrame, particleColor, count)
    if not parentFrame then return end
    local oldP = parentFrame:FindFirstChild("ZaynParticleLayer")
    if oldP then
        local oldId = oldP:GetAttribute("AnimId")
        if oldId then bs.UnregisterAnim(oldId) end
        oldP:Destroy()
    end

    local layer = Instance.new("Frame", parentFrame)
    layer.Name = "ZaynParticleLayer"
    layer.Size = UDim2.new(1, 0, 1, 0)
    layer.BackgroundTransparency = 1
    layer.ClipsDescendants = true
    layer.ZIndex = (parentFrame.ZIndex or 1) + 1

    local dots = {}
    local total = math.clamp(count or 10, 4, 18)
    for idx = 1, total do
        local d = Instance.new("Frame", layer)
        local sz = math.random(2, 5)
        d.Size = UDim2.new(0, sz, 0, sz)
        d.BackgroundColor3 = particleColor or Color3.fromRGB(0, 230, 255)
        d.BorderSizePixel = 0
        d.ZIndex = layer.ZIndex
        Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
        table.insert(dots, {
            obj = d,
            xBase = math.random(5, 95) / 100,
            speed = 0.08 + (math.random(1, 10) / 85),
            offset = math.random(0, 100) / 100,
            sway = (math.random(2, 6) / 100)
        })
    end

    local id = bs.RegisterAnim(layer, function(now)
        for idx, pt in ipairs(dots) do
            local prog = (now * pt.speed + pt.offset) % 1
            local y = 1.05 - (prog * 1.15)
            local x = pt.xBase + math.sin(now * 1.8 + idx) * pt.sway
            pt.obj.Position = UDim2.new(x, 0, y, 0)
            pt.obj.BackgroundTransparency = 1 - (math.sin(prog * math.pi) * 0.65)
        end
    end)
    layer:SetAttribute("AnimId", id)
end

function bs.AnimEngine.ApplyGradientUsername(textLabel, c1, c2)
    if not textLabel then return end
    local oldGrad = textLabel:FindFirstChild("ZaynNameGrad")
    if oldGrad then oldGrad:Destroy() end
    local oldId = textLabel:GetAttribute("ZaynNameAnimId")
    if oldId then bs.UnregisterAnim(oldId) end

    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    local grad = Instance.new("UIGradient", textLabel)
    grad.Name = "ZaynNameGrad"
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, c1 or Color3.fromRGB(0, 235, 255)),
        ColorSequenceKeypoint.new(0.5, c2 or Color3.fromRGB(255, 65, 190)),
        ColorSequenceKeypoint.new(1, c1 or Color3.fromRGB(0, 235, 255))
    })

    local id = bs.RegisterAnim(textLabel, function(now)
        grad.Offset = Vector2.new(math.sin(now * 1.8) * 0.6, 0)
    end)
    textLabel:SetAttribute("ZaynNameAnimId", id)
end

function bs.AnimEngine.CreateAnimatedBadge(parent, badgeKey)
    local info = bs.BadgeCatalog[badgeKey]
    if not info then return nil end

    local pill = Instance.new("Frame", parent)
    pill.Name = "Badge_" .. badgeKey
    pill.Size = UDim2.new(0, 0, 0, 20)
    pill.AutomaticSize = Enum.AutomaticSize.X
    pill.BackgroundColor3 = info.bg
    pill.ZIndex = (parent.ZIndex or 1) + 2
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
    lbl.TextColor3 = info.textCol
    lbl.Text = info.label
    lbl.ZIndex = pill.ZIndex + 1

    bs.RegisterAnim(pill, function(now)
        stGrad.Rotation = (now * 110) % 360
    end)
    return pill
end

function bs.AnimEngine.AttachCurvedTitle(fi, fj)
    if not fi or not fi.Parent then return end
    local fk = fi.Parent
    local fl = fk:FindFirstChild("MatrixCurvedTitleArc")
    if fl then
        local oldId = fl:GetAttribute("AnimId")
        if oldId then bs.UnregisterAnim(oldId) end
        fl:Destroy()
    end

    fl = Instance.new("Frame")
    fl.Name = "MatrixCurvedTitleArc"
    fl.Size = fi.Size
    fl.Position = fi.Position
    fl.AnchorPoint = fi.AnchorPoint
    fl.BackgroundTransparency = 1
    fl.ZIndex = fi.ZIndex + 6
    fl.Parent = fk

    local aN = #fj
    local fm = fi.Size.X.Offset / 2 + 4.5
    local fn = math.rad(-90 - math.min((aN - 1) * 18, 160) / 2)
    local fo = math.rad(-90 + math.min((aN - 1) * 18, 160) / 2)
    local fp, fq = fi.Size.X.Offset / 2, fi.Size.Y.Offset / 2
    local fr = {}

    for aV = 1, aN do
        local fs = aN > 1 and fn + (aV - 1) * (fo - fn) / (aN - 1) or fn
        local ft = Instance.new("TextLabel", fl)
        ft.Size = UDim2.new(0, 14, 0, 14)
        ft.AnchorPoint = Vector2.new(0.5, 0.5)
        ft.Position = UDim2.new(0, fp + math.cos(fs) * fm, 0, fq + math.sin(fs) * fm)
        ft.BackgroundTransparency = 1
        ft.Text = fj:sub(aV, aV)
        ft.Font = Enum.Font.GothamBold
        ft.TextSize = 8.5
        ft.TextColor3 = Color3.fromRGB(255, 255, 255)
        ft.TextXAlignment = Enum.TextXAlignment.Center
        ft.Rotation = math.deg(fs) + 90
        ft.ZIndex = fl.ZIndex + 1

        local fu = Instance.new("UIGradient", ft)
        fu.Rotation = 45
        fu.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 195, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 60, 255))
        })
        table.insert(fr, {l = ft, idx = aV})
    end

    local fv = 10.0
    local id = bs.RegisterAnim(fl, function(now)
        for _, fx in ipairs(fr) do
            local fy = (now - fx.idx * 0.22) % fv
            fx.l.TextTransparency = fy < 5.0 and 0 or (fy < 6.0 and (1 - math.cos((fy - 5.0) * math.pi)) / 2 or (fy < 9.0 and 1 or (1 + math.cos((fy - 9.0) * math.pi)) / 2))
        end
    end)
    fl:SetAttribute("AnimId", id)
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 4 / 8 : PERSISTENT SOCIAL, ENTITLEMENTS, ₹300 PASS & ADMIN BACKEND
-- ========================================================================= --

local function countMapKeys(tbl)
    if type(tbl) ~= "table" then return 0 end
    local c = 0
    for _, v in pairs(tbl) do
        if v ~= nil and v ~= false then
            c = c + 1
        end
    end
    return c
end

local function normalizeUid(uid)
    local str = tostring(uid or ""):gsub("[^%d]", "")
    if str == "" or tonumber(str) == nil or tonumber(str) <= 0 then
        return nil
    end
    return str
end

local function formatDbErr(errMsg)
    local msg = tostring(errMsg or "Database error")
    if msg:lower():find("permission") then
        return "Firebase Permission Denied — paste the V71.0 Rules from Part 8 in Firebase Console."
    end
    return msg
end

-- ========================================================================= --
-- [SECTION A : STORE CONFIG & DYNAMIC CATALOG HELPERS]
-- ========================================================================= --
function bs.SocialEngine.FetchStoreConfig()
    local raw = bs.DbGet(DB_SOCIAL.StoreConfig)
    if type(raw) == "table" then
        local cfg = bs.Social.StoreConfig
        if tonumber(raw.elitePassPriceINR) then
            cfg.elitePassPriceINR = math.max(1, math.floor(tonumber(raw.elitePassPriceINR)))
        end
        if type(raw.discordContact) == "string" and raw.discordContact ~= "" then
            cfg.discordContact = raw.discordContact
        end
        if type(raw.discordServer) == "string" and raw.discordServer ~= "" then
            cfg.discordServer = raw.discordServer
        end
        cfg.disabledDecorations = type(raw.disabledDecorations) == "table" and raw.disabledDecorations or {}
        cfg.disabledThemes = type(raw.disabledThemes) == "table" and raw.disabledThemes or {}
        cfg.priceOverrides = type(raw.priceOverrides) == "table" and raw.priceOverrides or {}
        cfg.customItems = type(raw.customItems) == "table" and raw.customItems or {}
    end
    return bs.Social.StoreConfig
end

function bs.SocialEngine.GetElitePassPrice()
    return tonumber(bs.Social.StoreConfig.elitePassPriceINR) or 300
end

function bs.SocialEngine.IsDecorationEnabled(decorId)
    local dis = bs.Social.StoreConfig.disabledDecorations
    return not (type(dis) == "table" and dis[decorId] == true)
end

function bs.SocialEngine.IsThemeEnabled(themeId)
    local dis = bs.Social.StoreConfig.disabledThemes
    return not (type(dis) == "table" and dis[themeId] == true)
end

function bs.SocialEngine.GetDecorationPrice(decorId)
    local overrides = bs.Social.StoreConfig.priceOverrides
    if type(overrides) == "table" and overrides["dec_" .. tostring(decorId)] ~= nil then
        return tonumber(overrides["dec_" .. tostring(decorId)]) or 0
    end
    local d = bs.DecorationMap[decorId]
    if d then return tonumber(d.priceINR) or 0 end
    local custom = bs.Social.StoreConfig.customItems
    if type(custom) == "table" and type(custom[decorId]) == "table" then
        return tonumber(custom[decorId].priceINR) or bs.SocialEngine.GetElitePassPrice()
    end
    return bs.SocialEngine.GetElitePassPrice()
end

function bs.SocialEngine.GetThemePrice(themeId)
    local overrides = bs.Social.StoreConfig.priceOverrides
    if type(overrides) == "table" and overrides["thm_" .. tostring(themeId)] ~= nil then
        return tonumber(overrides["thm_" .. tostring(themeId)]) or 0
    end
    local t = bs.ProfileThemeMap[themeId]
    if t then return tonumber(t.priceINR) or 0 end
    local custom = bs.Social.StoreConfig.customItems
    if type(custom) == "table" and type(custom[themeId]) == "table" then
        return tonumber(custom[themeId].priceINR) or bs.SocialEngine.GetElitePassPrice()
    end
    return bs.SocialEngine.GetElitePassPrice()
end

function bs.SocialEngine.GetAllDecorations(includeDisabled)
    local list = {}
    for _, item in ipairs(bs.DecorationCatalog) do
        if includeDisabled or bs.SocialEngine.IsDecorationEnabled(item.id) then
            table.insert(list, item)
        end
    end
    local custom = bs.Social.StoreConfig.customItems
    if type(custom) == "table" then
        for idKey, cItem in pairs(custom) do
            if type(cItem) == "table" and cItem.kind == "decoration" and not bs.DecorationMap[idKey] then
                if includeDisabled or bs.SocialEngine.IsDecorationEnabled(idKey) then
                    table.insert(list, {
                        id = idKey,
                        name = tostring(cItem.name or idKey),
                        tier = (tonumber(cItem.priceINR) or 0) == 0 and "Free" or "Exclusive",
                        priceINR = tonumber(cItem.priceINR) or 300,
                        accent = Color3.fromRGB(tonumber(cItem.r1) or 0, tonumber(cItem.g1) or 230, tonumber(cItem.b1) or 255),
                        secondary = Color3.fromRGB(tonumber(cItem.r2) or 255, tonumber(cItem.g2) or 65, tonumber(cItem.b2) or 190),
                        description = tostring(cItem.description or "Custom Admin Exclusive Avatar Decoration.")
                    })
                end
            end
        end
    end
    return list
end

function bs.SocialEngine.GetAllThemes(includeDisabled)
    local list = {}
    for _, item in ipairs(bs.ProfileThemeCatalog) do
        if includeDisabled or bs.SocialEngine.IsThemeEnabled(item.id) then
            table.insert(list, item)
        end
    end
    local custom = bs.Social.StoreConfig.customItems
    if type(custom) == "table" then
        for idKey, cItem in pairs(custom) do
            if type(cItem) == "table" and cItem.kind == "theme" and not bs.ProfileThemeMap[idKey] then
                if includeDisabled or bs.SocialEngine.IsThemeEnabled(idKey) then
                    local a1 = Color3.fromRGB(tonumber(cItem.r1) or 0, tonumber(cItem.g1) or 230, tonumber(cItem.b1) or 255)
                    local a2 = Color3.fromRGB(tonumber(cItem.r2) or 180, tonumber(cItem.g2) or 60, tonumber(cItem.b2) or 255)
                    table.insert(list, {
                        id = idKey,
                        name = tostring(cItem.name or idKey),
                        tier = (tonumber(cItem.priceINR) or 0) == 0 and "Free" or "Exclusive",
                        priceINR = tonumber(cItem.priceINR) or 300,
                        bg1 = Color3.fromRGB(10, 10, 18),
                        bg2 = Color3.fromRGB(28, 22, 48),
                        cardBg = Color3.fromRGB(18, 16, 30),
                        borderColor = a1,
                        accent = a1,
                        accent2 = a2,
                        textColor = Color3.fromRGB(248, 248, 255),
                        subText = Color3.fromRGB(170, 175, 205),
                        particleColor = a1,
                        description = tostring(cItem.description or "Custom Admin Exclusive Profile Theme.")
                    })
                end
            end
        end
    end
    return list
end

function bs.SocialEngine.ResolveThemeObject(themeId)
    if bs.ProfileThemeMap[themeId] then
        return bs.ProfileThemeMap[themeId]
    end
    for _, item in ipairs(bs.SocialEngine.GetAllThemes(true)) do
        if item.id == themeId then return item end
    end
    return bs.ProfileThemeMap["royal_black_gold"] or bs.ProfileThemeCatalog[1]
end

-- ========================================================================= --
-- [SECTION B : ENTITLEMENTS & OWNERSHIP VERIFICATION (NO FAKE PURCHASES)]
-- ========================================================================= --
function bs.SocialEngine.GetEmptyEntitlement()
    return {
        elitePass = false,
        ownedDecorations = {},
        ownedThemes = {},
        badges = {},
        grantedBy = "",
        grantedAt = 0
    }
end

function bs.SocialEngine.FetchEntitlements(uid, forceRefresh)
    local uidStr = normalizeUid(uid)
    if not uidStr then return bs.SocialEngine.GetEmptyEntitlement() end

    if not forceRefresh and bs.Social.Entitlements[uidStr] then
        return bs.Social.Entitlements[uidStr]
    end

    local raw = bs.DbGet(DB_SOCIAL.Entitlements .. "/" .. uidStr)
    local ent = bs.SocialEngine.GetEmptyEntitlement()
    if type(raw) == "table" then
        ent.elitePass = raw.elitePass == true
        ent.ownedDecorations = type(raw.ownedDecorations) == "table" and raw.ownedDecorations or {}
        ent.ownedThemes = type(raw.ownedThemes) == "table" and raw.ownedThemes or {}
        ent.badges = type(raw.badges) == "table" and raw.badges or {}
        ent.grantedBy = tostring(raw.grantedBy or "")
        ent.grantedAt = tonumber(raw.grantedAt) or 0
    end

    -- Authorized Creator always has full elite entitlement
    if uidStr == "10432865434" then
        ent.elitePass = true
    end

    bs.Social.Entitlements[uidStr] = ent
    return ent
end

function bs.SocialEngine.HasElitePass(uid)
    local uidStr = normalizeUid(uid) or bs.Social.MyUid
    if uidStr == "10432865434" then return true end
    local ent = bs.Social.Entitlements[uidStr]
    return type(ent) == "table" and ent.elitePass == true
end

function bs.SocialEngine.OwnsDecoration(uid, decorId)
    if not decorId or decorId == "" or decorId == "none" then return true end
    local uidStr = normalizeUid(uid) or bs.Social.MyUid
    if bs.SocialEngine.GetDecorationPrice(decorId) == 0 then return true end
    if bs.SocialEngine.HasElitePass(uidStr) then return true end
    local ent = bs.Social.Entitlements[uidStr]
    return type(ent) == "table" and type(ent.ownedDecorations) == "table" and ent.ownedDecorations[decorId] == true
end

function bs.SocialEngine.OwnsTheme(uid, themeId)
    if not themeId or themeId == "" or themeId == "royal_black_gold" then return true end
    local uidStr = normalizeUid(uid) or bs.Social.MyUid
    if bs.SocialEngine.GetThemePrice(themeId) == 0 then return true end
    if bs.SocialEngine.HasElitePass(uidStr) then return true end
    local ent = bs.Social.Entitlements[uidStr]
    return type(ent) == "table" and type(ent.ownedThemes) == "table" and ent.ownedThemes[themeId] == true
end

-- ========================================================================= --
-- [SECTION C : PROFILE FETCH, NORMALIZATION & PERSISTENT SAVING]
-- ========================================================================= --
function bs.SocialEngine.GetDefaultPrivacy()
    return {
        isPrivate = false,
        allowFollows = true,
        dmPermission = "Everyone",
        hideLists = false
    }
end

function bs.SocialEngine.GetDefaultBadges(uidStr, username)
    local badges = {}
    local low = tostring(username or ""):lower()
    if uidStr == "10432865434" or low == "erennn0779" or low == "izayn" then
        table.insert(badges, "CREATOR")
        table.insert(badges, "VIP")
        table.insert(badges, "LEGEND")
        table.insert(badges, "OG")
    end
    if bs.DJRegistry[low] then
        table.insert(badges, "DJ")
    end
    return badges
end

function bs.SocialEngine.BuildDefaultProfile(uidStr, username, displayName)
    local acc = bs.GetAccountByUid(uidStr)
    local uName = (username and username ~= "") and username or acc.Username
    local dName = (displayName and displayName ~= "") and displayName or acc.DisplayName
    return {
        uid = uidStr,
        username = uName,
        displayName = dName,
        bio = "Hey there! Using ZAYN CHAT V71.0 Insta Elite.",
        theme = "royal_black_gold",
        decoration = "none",
        badges = bs.SocialEngine.GetDefaultBadges(uidStr, uName),
        privacy = bs.SocialEngine.GetDefaultPrivacy(),
        createdAt = aB(),
        updatedAt = aB()
    }
end

function bs.SocialEngine.EnsureProfileNormalized(uidStr, rawProfile)
    local base = bs.SocialEngine.BuildDefaultProfile(uidStr)
    local ent = bs.SocialEngine.FetchEntitlements(uidStr, false)
    local raw = type(rawProfile) == "table" and rawProfile or {}

    local rawTheme = tostring(raw.theme or "royal_black_gold")
    local rawDecor = tostring(raw.decoration or raw.avatarAnim or "none")

    -- Enforce entitlement validity when normalizing displayed cosmetics
    if not bs.SocialEngine.OwnsTheme(uidStr, rawTheme) then
        rawTheme = "royal_black_gold"
    end
    if rawDecor ~= "none" and not bs.SocialEngine.OwnsDecoration(uidStr, rawDecor) then
        rawDecor = "none"
    end

    local merged = {
        uid = uidStr,
        username = (type(raw.username) == "string" and raw.username ~= "") and raw.username or base.username,
        displayName = (type(raw.displayName) == "string" and raw.displayName ~= "") and raw.displayName or base.displayName,
        bio = type(raw.bio) == "string" and raw.bio or base.bio,
        theme = rawTheme,
        decoration = rawDecor,
        badges = {},
        privacy = bs.SocialEngine.GetDefaultPrivacy(),
        createdAt = tonumber(raw.createdAt) or base.createdAt,
        updatedAt = tonumber(raw.updatedAt) or aB()
    }

    local seenBadge = {}
    local function addB(bKey)
        local key = tostring(bKey or ""):upper()
        if bs.BadgeCatalog[key] and not seenBadge[key] then
            seenBadge[key] = true
            table.insert(merged.badges, key)
        end
    end

    for _, defB in ipairs(bs.SocialEngine.GetDefaultBadges(uidStr, merged.username)) do
        addB(defB)
    end
    if ent.elitePass then
        addB("VIP")
        addB("ELITE")
    end
    if type(ent.badges) == "table" then
        for bKey, bVal in pairs(ent.badges) do
            if type(bKey) == "number" and type(bVal) == "string" then
                addB(bVal)
            elseif bVal == true then
                addB(bKey)
            end
        end
    end

    if type(raw.privacy) == "table" then
        merged.privacy.isPrivate = raw.privacy.isPrivate == true
        merged.privacy.allowFollows = raw.privacy.allowFollows ~= false
        merged.privacy.hideLists = raw.privacy.hideLists == true
        local dmP = tostring(raw.privacy.dmPermission or "Everyone")
        if dmP == "Everyone" or dmP == "Followers" or dmP == "Mutuals" or dmP == "None" then
            merged.privacy.dmPermission = dmP
        end
    end

    bs.RegisterAccount(merged.username, merged.displayName, tonumber(uidStr) or 1)
    return merged
end

function bs.SocialEngine.FetchProfile(uid, forceRefresh)
    local uidStr = normalizeUid(uid)
    if not uidStr then return nil end

    if not forceRefresh and bs.Social.Profiles[uidStr] then
        return bs.Social.Profiles[uidStr]
    end

    bs.SocialEngine.FetchEntitlements(uidStr, forceRefresh == true)
    local raw = bs.DbGet(DB_SOCIAL.Profiles .. "/" .. uidStr)
    local prof = bs.SocialEngine.EnsureProfileNormalized(uidStr, raw)
    bs.Social.Profiles[uidStr] = prof

    if uidStr == bs.Social.MyUid and type(raw) ~= "table" then
        prof.username = m.Name
        prof.displayName = m.DisplayName
        bs.Social.Profiles[uidStr] = prof
        bs.DbPutAsync(DB_SOCIAL.Profiles .. "/" .. uidStr, prof)
        bs.DbPutAsync(DB_SOCIAL.UsernameIndex .. "/" .. m.Name:lower(), {
            uid = uidStr,
            username = m.Name,
            displayName = m.DisplayName,
            updatedAt = aB()
        })
    end

    return prof
end

function bs.SocialEngine.SaveMyProfileChanges(updates)
    local myUid = bs.Social.MyUid
    local current = bs.SocialEngine.FetchProfile(myUid, false)
    if not current then return false, "Profile unavailable" end

    if type(updates.displayName) == "string" then
        local cleanName = updates.displayName:gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 28)
        if cleanName ~= "" then current.displayName = cleanName end
    end

    if type(updates.bio) == "string" then
        current.bio = updates.bio:gsub("[\r\n]+", " "):sub(1, 140)
    end

    if type(updates.theme) == "string" then
        if not bs.SocialEngine.OwnsTheme(myUid, updates.theme) then
            return false, "Locked theme — requires ₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. " ZAYN ELITE PASS."
        end
        current.theme = updates.theme
    end

    if type(updates.decoration) == "string" then
        if updates.decoration ~= "none" and not bs.SocialEngine.OwnsDecoration(myUid, updates.decoration) then
            return false, "Locked decoration — requires ₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. " ZAYN ELITE PASS."
        end
        current.decoration = updates.decoration
    end

    if type(updates.privacy) == "table" then
        if updates.privacy.isPrivate ~= nil then current.privacy.isPrivate = updates.privacy.isPrivate == true end
        if updates.privacy.allowFollows ~= nil then current.privacy.allowFollows = updates.privacy.allowFollows == true end
        if updates.privacy.hideLists ~= nil then current.privacy.hideLists = updates.privacy.hideLists == true end
        if type(updates.privacy.dmPermission) == "string" then
            local dmP = updates.privacy.dmPermission
            if dmP == "Everyone" or dmP == "Followers" or dmP == "Mutuals" or dmP == "None" then
                current.privacy.dmPermission = dmP
            end
        end
    end

    current.username = m.Name
    current.updatedAt = aB()
    bs.Social.Profiles[myUid] = current

    local putOk, errMsg = bs.DbPut(DB_SOCIAL.Profiles .. "/" .. myUid, current)
    if not putOk then
        return false, formatDbErr(errMsg)
    end

    bs.DbPutAsync(DB_SOCIAL.UsernameIndex .. "/" .. m.Name:lower(), {
        uid = myUid,
        username = m.Name,
        displayName = current.displayName,
        updatedAt = aB()
    })

    if bs.RefreshProfileUI and bs.Mode == "Profile" and bs.Social.ViewingProfileUid == myUid then
        bs.RefreshProfileUI(myUid)
    end
    return true, "Saved permanently to database!"
end

function bs.SocialEngine.EquipDecoration(decorId)
    local myUid = bs.Social.MyUid
    local target = (decorId and decorId ~= "") and tostring(decorId) or "none"

    -- Re-fetch authoritative entitlements before allowing equip
    bs.SocialEngine.FetchEntitlements(myUid, true)
    if target ~= "none" then
        if not bs.SocialEngine.IsDecorationEnabled(target) then
            return false, "This decoration is currently disabled by Admin."
        end
        if not bs.SocialEngine.OwnsDecoration(myUid, target) then
            return false, "Locked! Get the ₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. " ZAYN ELITE PASS to unlock."
        end
    end

    local ok, msg = bs.SocialEngine.SaveMyProfileChanges({decoration = target})
    if ok then
        bs.Social.PreviewDecoration = nil
        local label = target == "none" and "Avatar decoration removed." or ("Equipped: " .. (bs.DecorationMap[target] and bs.DecorationMap[target].name or target))
        bs.TriggerSocialToast("✨ Avatar Updated", label, Color3.fromRGB(0, 235, 255), myUid)
        if bs.RefreshCustomizeUI and bs.Mode == "Customize" then bs.RefreshCustomizeUI() end
        return true, label
    end
    return false, msg
end

function bs.SocialEngine.EquipTheme(themeId)
    local myUid = bs.Social.MyUid
    local target = (themeId and themeId ~= "") and tostring(themeId) or "royal_black_gold"

    bs.SocialEngine.FetchEntitlements(myUid, true)
    if not bs.SocialEngine.IsThemeEnabled(target) then
        return false, "This profile theme is currently disabled by Admin."
    end
    if not bs.SocialEngine.OwnsTheme(myUid, target) then
        return false, "Locked! Get the ₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. " ZAYN ELITE PASS to unlock."
    end

    local ok, msg = bs.SocialEngine.SaveMyProfileChanges({theme = target})
    if ok then
        bs.Social.PreviewTheme = nil
        local tObj = bs.SocialEngine.ResolveThemeObject(target)
        bs.TriggerSocialToast("🎨 Theme Applied", "Profile theme set to " .. tObj.name, tObj.accent, myUid)
        if bs.RefreshCustomizeUI and bs.Mode == "Customize" then bs.RefreshCustomizeUI() end
        return true, "Applied " .. tObj.name
    end
    return false, msg
end

-- ========================================================================= --
-- [SECTION D : ₹300 ZAYN ELITE PASS PURCHASE REQUEST (NO FAKE PAYMENT!)]
-- ========================================================================= --
function bs.SocialEngine.SubmitPurchaseRequest(itemType, itemId, discordUser, paymentNote)
    local myUid = bs.Social.MyUid
    local cleanDiscord = tostring(discordUser or ""):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 50)
    local cleanNote = tostring(paymentNote or ""):gsub("[\r\n]+", " "):sub(1, 140)
    if cleanDiscord == "" then
        return false, "Enter your Discord username so Admin can verify your payment."
    end

    local reqId = "PAY_" .. myUid .. "_" .. tostring(aB())
    local priceINR = bs.SocialEngine.GetElitePassPrice()
    if itemType == "decoration" then
        priceINR = bs.SocialEngine.GetDecorationPrice(itemId)
    elseif itemType == "theme" then
        priceINR = bs.SocialEngine.GetThemePrice(itemId)
    end

    local payload = {
        id = reqId,
        uid = myUid,
        username = m.Name,
        displayName = m.DisplayName,
        itemType = tostring(itemType or "elite_pass"),
        itemId = tostring(itemId or "zayn_elite_pass"),
        priceINR = priceINR,
        discordUser = cleanDiscord,
        note = cleanNote,
        status = "pending_verification",
        createdAt = aB()
    }

    local ok, errMsg = bs.DbPut(DB_SOCIAL.PurchaseReqs .. "/" .. reqId, payload)
    if not ok then
        return false, formatDbErr(errMsg)
    end

    bs.SocialEngine.AddLocalNotification(
        "purchase_pending",
        "⏳ Verification Ticket Submitted",
        "Contact " .. bs.Social.StoreConfig.discordServer .. " with Ticket ID: " .. reqId .. ". Admin will verify payment before unlocking.",
        myUid,
        Color3.fromRGB(255, 205, 55),
        function() bs.OpenCustomizePage("PremiumStore") end
    )
    return true, reqId
end

-- ========================================================================= --
-- [SECTION E : ONLINE PRESENCE, BLOCK/UNBLOCK, REPORT & NOTIFICATIONS]
-- ========================================================================= --
function bs.SocialEngine.HeartbeatPresence()
    local myUid = bs.Social.MyUid
    local nowTs = aB()
    bs.Social.Presence[myUid] = {online = true, lastSeen = nowTs, jobId = Z}
    bs.DbPutAsync(DB_SOCIAL.Presence .. "/" .. myUid, {
        online = true,
        lastSeen = nowTs,
        username = m.Name,
        jobId = Z
    })
end

function bs.SocialEngine.FetchPresence(uid)
    local uidStr = normalizeUid(uid)
    if not uidStr then return false, 0 end
    if e:GetPlayerByUserId(tonumber(uidStr)) then
        bs.Social.Presence[uidStr] = {online = true, lastSeen = aB()}
        return true, aB()
    end
    local data = bs.DbGet(DB_SOCIAL.Presence .. "/" .. uidStr)
    if type(data) == "table" then
        local lastSeen = tonumber(data.lastSeen) or 0
        local isOnline = (data.online == true) and ((aB() - lastSeen) <= 75)
        bs.Social.Presence[uidStr] = {online = isOnline, lastSeen = lastSeen}
        return isOnline, lastSeen
    end
    bs.Social.Presence[uidStr] = {online = false, lastSeen = 0}
    return false, 0
end

function bs.SocialEngine.IsOnlineCached(uid)
    local uidStr = normalizeUid(uid)
    if not uidStr then return false end
    if e:GetPlayerByUserId(tonumber(uidStr)) then return true end
    local p = bs.Social.Presence[uidStr]
    return p ~= nil and p.online == true and (aB() - (p.lastSeen or 0)) <= 75
end

function bs.SocialEngine.FetchMyBlocks()
    local data = bs.DbGet(DB_SOCIAL.Blocks .. "/" .. bs.Social.MyUid)
    bs.Social.Blocks = type(data) == "table" and data or {}
    return bs.Social.Blocks
end

function bs.SocialEngine.IsBlocked(targetUid)
    local tUid = normalizeUid(targetUid)
    return tUid ~= nil and bs.Social.Blocks[tUid] == true
end

function bs.SocialEngine.IsBlockedBy(targetUid)
    local tUid = normalizeUid(targetUid)
    if not tUid then return false end
    if bs.Social.BlockedBy[tUid] ~= nil then return bs.Social.BlockedBy[tUid] == true end
    local check = bs.DbGet(DB_SOCIAL.Blocks .. "/" .. tUid .. "/" .. bs.Social.MyUid)
    local isBlk = (check == true or check == "true")
    bs.Social.BlockedBy[tUid] = isBlk
    return isBlk
end

function bs.SocialEngine.BlockUser(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid or tUid == myUid then return false, "Invalid user" end

    local ok, errMsg = bs.DbPut(DB_SOCIAL.Blocks .. "/" .. myUid .. "/" .. tUid, true)
    if not ok then return false, formatDbErr(errMsg) end
    bs.Social.Blocks[tUid] = true

    bs.DbDeleteAsync(DB_SOCIAL.Following .. "/" .. myUid .. "/" .. tUid)
    bs.DbDeleteAsync(DB_SOCIAL.Followers .. "/" .. tUid .. "/" .. myUid)
    bs.DbDeleteAsync(DB_SOCIAL.Following .. "/" .. tUid .. "/" .. myUid)
    bs.DbDeleteAsync(DB_SOCIAL.Followers .. "/" .. myUid .. "/" .. tUid)
    bs.DbDeleteAsync(DB_SOCIAL.Requests .. "/" .. myUid .. "/" .. tUid)
    bs.DbDeleteAsync(DB_SOCIAL.Requests .. "/" .. tUid .. "/" .. myUid)

    if bs.Social.Following[myUid] then bs.Social.Following[myUid][tUid] = nil end
    if bs.Social.Followers[tUid] then bs.Social.Followers[tUid][myUid] = nil end
    if bs.Social.Followers[myUid] then bs.Social.Followers[myUid][tUid] = nil end
    if bs.Social.Following[tUid] then bs.Social.Following[tUid][myUid] = nil end
    bs.Social.Requests[tUid] = nil
    bs.Social.SentRequests[tUid] = nil

    bs.TriggerSocialToast("🚫 User Blocked", "User blocked and relationships cleared.", Color3.fromRGB(235, 65, 80), tUid)
    return true, "Blocked"
end

function bs.SocialEngine.UnblockUser(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid then return false, "Invalid user" end
    bs.Social.Blocks[tUid] = nil
    bs.DbDelete(DB_SOCIAL.Blocks .. "/" .. myUid .. "/" .. tUid)
    bs.TriggerSocialToast("✅ Unblocked", "You can interact with this user again.", Color3.fromRGB(0, 225, 145), tUid)
    return true, "Unblocked"
end

function bs.SocialEngine.ReportUser(targetUid, reasonText)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid or tUid == myUid then return false, "Invalid target" end
    local cleanReason = tostring(reasonText or "Inappropriate behavior"):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, 200)
    if cleanReason == "" then cleanReason = "Inappropriate behavior" end

    local repId = "REP_" .. tostring(aB()) .. "_" .. tostring(math.random(1000, 9999))
    local ok, errMsg = bs.DbPut(DB_SOCIAL.Reports .. "/" .. repId, {
        id = repId,
        reporterUid = myUid,
        reporterName = m.Name,
        targetUid = tUid,
        reason = cleanReason,
        serverJobId = Z,
        timestamp = aB()
    })
    if ok then
        bs.TriggerSocialToast("🛡️ Report Sent", "Submitted to ZAYN Moderation.", Color3.fromRGB(255, 165, 45), tUid)
        return true, "Report submitted"
    end
    return false, formatDbErr(errMsg)
end

function bs.SocialEngine.PushNotification(targetUid, notifType, title, message, fromUid)
    local tUid = normalizeUid(targetUid)
    if not tUid then return end
    local nId = "N_" .. tostring(aB()) .. "_" .. tostring(math.random(1000, 9999))
    bs.DbPutAsync(DB_SOCIAL.Notifs .. "/" .. tUid .. "/" .. nId, {
        id = nId,
        type = tostring(notifType or "social"),
        title = tostring(title or "Social Update"),
        message = tostring(message or ""),
        fromUid = tostring(fromUid or bs.Social.MyUid),
        read = false,
        timestamp = aB()
    })
end

function bs.SocialEngine.AddLocalNotification(notifType, title, message, fromUid, accentColor, onClickFn)
    local nId = "LOCAL_N_" .. tostring(aB()) .. "_" .. tostring(math.random(100, 999))
    local entry = {
        id = nId,
        type = notifType,
        title = title,
        message = message,
        fromUid = tostring(fromUid or bs.Social.MyUid),
        read = false,
        timestamp = aB()
    }
    bs.Social.SeenNotifIds[nId] = true
    table.insert(bs.Social.Notifs, 1, entry)
    bs.Social.UnreadNotifs = bs.Social.UnreadNotifs + 1
    if bs.UpdateNavNotifBadge then bs.UpdateNavNotifBadge() end
    bs.TriggerSocialToast(title, message, accentColor or Color3.fromRGB(0, 230, 255), fromUid, onClickFn)
end

function bs.SocialEngine.FetchMyNotifications(silentInitial)
    local myUid = bs.Social.MyUid
    local data = bs.DbGet(DB_SOCIAL.Notifs .. "/" .. myUid)
    if type(data) ~= "table" then return bs.Social.Notifs end

    local list = {}
    local unread = 0
    for nId, item in pairs(data) do
        if type(item) == "table" and item.title then
            item.id = item.id or nId
            table.insert(list, item)
            if not item.read then unread = unread + 1 end
            if not bs.Social.SeenNotifIds[item.id] then
                bs.Social.SeenNotifIds[item.id] = true
                if not silentInitial and not item.read then
                    local col = Color3.fromRGB(0, 230, 255)
                    local clickFn = function() bs.OpenUserProfile(item.fromUid) end
                    if item.type == "follow_request" then
                        col = Color3.fromRGB(255, 185, 40)
                        clickFn = function() bs.OpenUserProfile(myUid); task.delay(0.3, function() if bs.OpenFollowersOverlay then bs.OpenFollowersOverlay(myUid, "Requests") end end) end
                    elseif item.type == "elite_granted" then
                        col = Color3.fromRGB(255, 210, 55)
                        clickFn = function() bs.OpenCustomizePage("Decoration") end
                    end
                    bs.TriggerSocialToast(item.title, item.message, col, item.fromUid, clickFn)
                end
            end
        end
    end

    table.sort(list, function(x, y) return (tonumber(x.timestamp) or 0) > (tonumber(y.timestamp) or 0) end)
    while #list > 50 do
        local old = table.remove(list)
        if old and old.id then bs.DbDeleteAsync(DB_SOCIAL.Notifs .. "/" .. myUid .. "/" .. old.id) end
    end

    bs.Social.Notifs = list
    bs.Social.UnreadNotifs = unread
    if bs.UpdateNavNotifBadge then bs.UpdateNavNotifBadge() end
    if bs.Mode == "Notifications" and bs.RefreshNotifsUI then bs.RefreshNotifsUI() end
    return list
end

function bs.SocialEngine.MarkAllNotificationsRead()
    local myUid = bs.Social.MyUid
    for _, item in ipairs(bs.Social.Notifs) do
        if not item.read then
            item.read = true
            if item.id and not tostring(item.id):match("^LOCAL_N_") then
                bs.DbPutAsync(DB_SOCIAL.Notifs .. "/" .. myUid .. "/" .. item.id .. "/read", true)
            end
        end
    end
    bs.Social.UnreadNotifs = 0
    if bs.UpdateNavNotifBadge then bs.UpdateNavNotifBadge() end
end

-- ========================================================================= --
-- [SECTION F : FOLLOWERS, FOLLOWING, MUTUALS, REQUESTS & DM PERMISSIONS]
-- ========================================================================= --
function bs.SocialEngine.FetchGraphForUser(uid, forceRefresh)
    local uidStr = normalizeUid(uid)
    if not uidStr then return {}, {} end
    if forceRefresh or not bs.Social.Followers[uidStr] then
        local fData = bs.DbGet(DB_SOCIAL.Followers .. "/" .. uidStr)
        bs.Social.Followers[uidStr] = type(fData) == "table" and fData or {}
    end
    if forceRefresh or not bs.Social.Following[uidStr] then
        local gData = bs.DbGet(DB_SOCIAL.Following .. "/" .. uidStr)
        bs.Social.Following[uidStr] = type(gData) == "table" and gData or {}
    end
    return bs.Social.Followers[uidStr], bs.Social.Following[uidStr]
end

function bs.SocialEngine.FetchMyRequests()
    local rData = bs.DbGet(DB_SOCIAL.Requests .. "/" .. bs.Social.MyUid)
    bs.Social.Requests = type(rData) == "table" and rData or {}
    return bs.Social.Requests
end

function bs.SocialEngine.GetFollowerCount(uid)
    local uidStr = normalizeUid(uid)
    return uidStr and countMapKeys(bs.Social.Followers[uidStr]) or 0
end

function bs.SocialEngine.GetFollowingCount(uid)
    local uidStr = normalizeUid(uid)
    return uidStr and countMapKeys(bs.Social.Following[uidStr]) or 0
end

function bs.SocialEngine.GetRequestCount()
    return countMapKeys(bs.Social.Requests)
end

function bs.SocialEngine.IsFollowing(targetUid)
    local tUid = normalizeUid(targetUid)
    local myF = bs.Social.Following[bs.Social.MyUid]
    return tUid ~= nil and type(myF) == "table" and myF[tUid] ~= nil and myF[tUid] ~= false
end

function bs.SocialEngine.IsFollowedBy(targetUid)
    local tUid = normalizeUid(targetUid)
    local myF = bs.Social.Followers[bs.Social.MyUid]
    return tUid ~= nil and type(myF) == "table" and myF[tUid] ~= nil and myF[tUid] ~= false
end

function bs.SocialEngine.IsMutual(targetUid)
    return bs.SocialEngine.IsFollowing(targetUid) and bs.SocialEngine.IsFollowedBy(targetUid)
end

function bs.SocialEngine.GetMutualFollowers(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid then return {} end
    local myFollowing = bs.Social.Following[myUid] or {}
    local targetFollowers = bs.Social.Followers[tUid] or {}
    local mutuals = {}
    for uidKey, val in pairs(myFollowing) do
        if val and targetFollowers[uidKey] and (tUid == myUid or tostring(uidKey) ~= myUid) then
            table.insert(mutuals, tostring(uidKey))
        end
    end
    return mutuals
end

function bs.SocialEngine.HasSentRequestTo(targetUid)
    local tUid = normalizeUid(targetUid)
    if not tUid then return false end
    if bs.Social.SentRequests[tUid] then return true end
    local existing = bs.DbGet(DB_SOCIAL.Requests .. "/" .. tUid .. "/" .. bs.Social.MyUid)
    if type(existing) == "table" then
        bs.Social.SentRequests[tUid] = true
        return true
    end
    return false
end

function bs.SocialEngine.FollowUser(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid then return false, "Invalid user ID" end
    if tUid == myUid then return false, "You cannot follow yourself" end
    if bs.SocialEngine.IsBlocked(tUid) then return false, "Unblock this user before following" end
    if bs.SocialEngine.IsBlockedBy(tUid) then return false, "Unable to follow this user" end
    if bs.SocialEngine.IsFollowing(tUid) then return false, "Already following this user" end

    local targetProf = bs.SocialEngine.FetchProfile(tUid, true)
    if targetProf and targetProf.privacy and targetProf.privacy.allowFollows == false then
        return false, "This user disabled new followers"
    end

    local nowTs = aB()
    if targetProf and targetProf.privacy and targetProf.privacy.isPrivate == true then
        if bs.SocialEngine.HasSentRequestTo(tUid) then return false, "Request already pending" end
        local ok, errMsg = bs.DbPut(DB_SOCIAL.Requests .. "/" .. tUid .. "/" .. myUid, {
            uid = myUid,
            username = m.Name,
            displayName = (bs.Social.Profiles[myUid] and bs.Social.Profiles[myUid].displayName) or m.DisplayName,
            time = nowTs
        })
        if not ok then return false, formatDbErr(errMsg) end
        bs.Social.SentRequests[tUid] = true
        bs.SocialEngine.PushNotification(tUid, "follow_request", "📩 Follow Request", m.DisplayName .. " (@" .. m.Name .. ") requested to follow you.", myUid)
        return true, "Follow request sent!"
    end

    local ok1, err1 = bs.DbPut(DB_SOCIAL.Following .. "/" .. myUid .. "/" .. tUid, nowTs)
    if not ok1 then return false, formatDbErr(err1) end
    local ok2, err2 = bs.DbPut(DB_SOCIAL.Followers .. "/" .. tUid .. "/" .. myUid, nowTs)
    if not ok2 then return false, formatDbErr(err2) end

    bs.Social.Following[myUid] = bs.Social.Following[myUid] or {}
    bs.Social.Following[myUid][tUid] = nowTs
    bs.Social.Followers[tUid] = bs.Social.Followers[tUid] or {}
    bs.Social.Followers[tUid][myUid] = nowTs

    bs.SocialEngine.PushNotification(tUid, "follow", "👤 New Follower", m.DisplayName .. " (@" .. m.Name .. ") started following you!", myUid)
    return true, "Followed successfully!"
end

function bs.SocialEngine.CancelFollowRequest(targetUid)
    local tUid = normalizeUid(targetUid)
    if not tUid then return false, "Invalid user" end
    bs.DbDelete(DB_SOCIAL.Requests .. "/" .. tUid .. "/" .. bs.Social.MyUid)
    bs.Social.SentRequests[tUid] = nil
    return true, "Follow request cancelled"
end

function bs.SocialEngine.UnfollowUser(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid then return false, "Invalid user" end
    bs.DbDelete(DB_SOCIAL.Following .. "/" .. myUid .. "/" .. tUid)
    bs.DbDelete(DB_SOCIAL.Followers .. "/" .. tUid .. "/" .. myUid)
    if bs.Social.Following[myUid] then bs.Social.Following[myUid][tUid] = nil end
    if bs.Social.Followers[tUid] then bs.Social.Followers[tUid][myUid] = nil end
    return true, "Unfollowed"
end

function bs.SocialEngine.AcceptFollowRequest(requesterUid)
    local myUid = bs.Social.MyUid
    local rUid = normalizeUid(requesterUid)
    if not rUid or rUid == myUid then return false, "Invalid requester" end
    local nowTs = aB()
    bs.DbDelete(DB_SOCIAL.Requests .. "/" .. myUid .. "/" .. rUid)
    bs.DbPut(DB_SOCIAL.Followers .. "/" .. myUid .. "/" .. rUid, nowTs)
    bs.DbPut(DB_SOCIAL.Following .. "/" .. rUid .. "/" .. myUid, nowTs)

    bs.Social.Requests[rUid] = nil
    bs.Social.Followers[myUid] = bs.Social.Followers[myUid] or {}
    bs.Social.Followers[myUid][rUid] = nowTs
    bs.Social.Following[rUid] = bs.Social.Following[rUid] or {}
    bs.Social.Following[rUid][myUid] = nowTs

    bs.SocialEngine.PushNotification(rUid, "request_accepted", "✅ Request Accepted", m.DisplayName .. " accepted your follow request!", myUid)
    return true, "Request accepted!"
end

function bs.SocialEngine.DeclineFollowRequest(requesterUid)
    local rUid = normalizeUid(requesterUid)
    if not rUid then return false, "Invalid requester" end
    bs.DbDelete(DB_SOCIAL.Requests .. "/" .. bs.Social.MyUid .. "/" .. rUid)
    bs.Social.Requests[rUid] = nil
    return true, "Request declined"
end

function bs.SocialEngine.RemoveFollower(followerUid)
    local myUid = bs.Social.MyUid
    local fUid = normalizeUid(followerUid)
    if not fUid then return false, "Invalid follower" end
    bs.DbDelete(DB_SOCIAL.Followers .. "/" .. myUid .. "/" .. fUid)
    bs.DbDelete(DB_SOCIAL.Following .. "/" .. fUid .. "/" .. myUid)
    if bs.Social.Followers[myUid] then bs.Social.Followers[myUid][fUid] = nil end
    if bs.Social.Following[fUid] then bs.Social.Following[fUid][myUid] = nil end
    return true, "Follower removed"
end

function bs.SocialEngine.CanMessageUser(targetUid)
    local myUid = bs.Social.MyUid
    local tUid = normalizeUid(targetUid)
    if not tUid or tUid == myUid then return false, "Cannot DM yourself" end
    if bs.SocialEngine.IsBlocked(tUid) then return false, "You blocked this user" end
    if bs.SocialEngine.IsBlockedBy(tUid) then return false, "You cannot message this user" end
    local prof = bs.SocialEngine.FetchProfile(tUid, false)
    local dmPerm = (prof and prof.privacy and prof.privacy.dmPermission) or "Everyone"
    if dmPerm == "None" then return false, "This user disabled DMs"
    elseif dmPerm == "Followers" and not bs.SocialEngine.IsFollowing(tUid) then return false, "Only followers can DM this user"
    elseif dmPerm == "Mutuals" and not bs.SocialEngine.IsMutual(tUid) then return false, "Only mutual followers can DM this user" end
    return true, "Allowed"
end

-- ========================================================================= --
-- [SECTION G : AUTHORIZED ADMIN PREMIUM & STORE MANAGEMENT APIs]
-- ========================================================================= --
function bs.SocialEngine.AdminFetchPurchaseRequests()
    if not au() then return {} end
    local raw = bs.DbGet(DB_SOCIAL.PurchaseReqs)
    local list = {}
    if type(raw) == "table" then
        for reqId, item in pairs(raw) do
            if type(item) == "table" and item.uid then
                item.id = item.id or reqId
                table.insert(list, item)
            end
        end
    end
    table.sort(list, function(x, y) return (tonumber(x.createdAt) or 0) > (tonumber(y.createdAt) or 0) end)
    return list
end

function bs.SocialEngine.AdminSetElitePass(targetUid, grantBool)
    if not au() then return false, "Admin only" end
    local tUid = normalizeUid(targetUid)
    if not tUid then return false, "Invalid User ID" end

    local ent = bs.SocialEngine.FetchEntitlements(tUid, true)
    ent.elitePass = grantBool == true
    ent.grantedBy = m.Name
    ent.grantedAt = aB()
    ent.badges = type(ent.badges) == "table" and ent.badges or {}
    ent.badges["VIP"] = grantBool == true
    ent.badges["ELITE"] = grantBool == true

    local ok, errMsg = bs.DbPut(DB_SOCIAL.Entitlements .. "/" .. tUid, ent)
    if not ok then return false, formatDbErr(errMsg) end

    bs.Social.Entitlements[tUid] = ent
    if grantBool then
        bs.SocialEngine.PushNotification(tUid, "elite_granted", "👑 ZAYN ELITE PASS ACTIVATED!", "Your ₹300 ZAYN ELITE PASS has been verified! All themes, auras & VIP badge are unlocked.", bs.Social.MyUid)
    else
        bs.SocialEngine.PushNotification(tUid, "social", "⚠️ Elite Pass Revoked", "Your ZAYN ELITE PASS access was updated by Admin.", bs.Social.MyUid)
    end
    return true, grantBool and ("Granted Elite Pass to " .. tUid) or ("Revoked Elite Pass from " .. tUid)
end

function bs.SocialEngine.AdminSetUserItemOwnership(targetUid, itemType, itemId, grantBool)
    if not au() then return false, "Admin only" end
    local tUid = normalizeUid(targetUid)
    if not tUid or not itemId or itemId == "" then return false, "Invalid User ID or Item ID" end

    local ent = bs.SocialEngine.FetchEntitlements(tUid, true)
    if itemType == "decoration" then
        ent.ownedDecorations[itemId] = grantBool and true or nil
    elseif itemType == "theme" then
        ent.ownedThemes[itemId] = grantBool and true or nil
    elseif itemType == "badge" then
        ent.badges[tostring(itemId):upper()] = grantBool and true or nil
    else
        return false, "Invalid itemType (decoration / theme / badge)"
    end
    ent.grantedBy = m.Name
    ent.grantedAt = aB()

    local ok, errMsg = bs.DbPut(DB_SOCIAL.Entitlements .. "/" .. tUid, ent)
    if not ok then return false, formatDbErr(errMsg) end

    bs.Social.Entitlements[tUid] = ent
    if grantBool then
        bs.SocialEngine.PushNotification(tUid, "elite_granted", "🎁 Item Unlocked by Admin!", "Admin granted you " .. tostring(itemId) .. " (" .. tostring(itemType) .. ").", bs.Social.MyUid)
    end
    return true, (grantBool and "Granted " or "Revoked ") .. tostring(itemId) .. " for " .. tUid
end

function bs.SocialEngine.AdminApprovePurchaseRequest(reqObj)
    if not au() then return false, "Admin only" end
    if type(reqObj) ~= "table" or not reqObj.uid then return false, "Invalid ticket" end

    local ok, msg
    if reqObj.itemType == "elite_pass" then
        ok, msg = bs.SocialEngine.AdminSetElitePass(reqObj.uid, true)
    else
        ok, msg = bs.SocialEngine.AdminSetUserItemOwnership(reqObj.uid, reqObj.itemType, reqObj.itemId, true)
    end
    if not ok then return false, msg end

    bs.DbPut(DB_SOCIAL.PurchaseReqs .. "/" .. reqObj.id .. "/status", '"approved"')
    bs.DbPutAsync(DB_SOCIAL.PurchaseReqs .. "/" .. reqObj.id .. "/verifiedBy", '"' .. m.Name .. '"')
    return true, "Approved & granted entitlement to " .. tostring(reqObj.username)
end

function bs.SocialEngine.AdminRejectPurchaseRequest(reqObj)
    if not au() then return false, "Admin only" end
    if type(reqObj) ~= "table" or not reqObj.id then return false, "Invalid ticket" end
    bs.DbPut(DB_SOCIAL.PurchaseReqs .. "/" .. reqObj.id .. "/status", '"rejected"')
    bs.SocialEngine.PushNotification(reqObj.uid, "social", "❌ Payment Ticket Rejected", "Ticket " .. tostring(reqObj.id) .. " could not be verified. Contact @" .. bs.Social.StoreConfig.discordContact .. " on Discord.", bs.Social.MyUid)
    return true, "Ticket rejected"
end

function bs.SocialEngine.AdminSaveStoreConfig()
    if not au() then return false, "Admin only" end
    local ok, errMsg = bs.DbPut(DB_SOCIAL.StoreConfig, bs.Social.StoreConfig)
    if not ok then return false, formatDbErr(errMsg) end
    return true, "Store configuration saved!"
end

-- Navigation Shortcuts
function bs.OpenUserProfile(uid)
    local uidStr = normalizeUid(uid) or bs.Social.MyUid
    bs.Social.ViewingProfileUid = uidStr
    bs.SwitchMode("Profile", uidStr)
end

function bs.OpenCustomizePage(tabName)
    bs.Social.CustomTab = tabName or "Avatar"
    bs.SwitchMode("Customize")
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 5 / 8 : MASTER UI, CENTERED 4-TAB NAV, MULTI-API MUSIC & ADMIN PANEL
-- ========================================================================= --

bs.Layout = {
    HeaderH = 32,
    NavH = 42
}

function bs.UpdateNavNotifBadge()
    local badge = bs.UI.NavNotifBadge
    if not badge then return end
    local count = (bs.Social.UnreadNotifs or 0) + bs.SocialEngine.GetRequestCount()
    if count > 0 then
        badge.Visible = true
        local txt = badge:FindFirstChild("CountTxt")
        if txt then
            txt.Text = count > 9 and "9+" or tostring(count)
        end
    else
        badge.Visible = false
    end
end

function bs.UpdateNavActiveState(activeMode)
    if not bs.UI.NavButtons then return end
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local tabGroup = "Chat"
    if activeMode == "Profile" then
        tabGroup = "Profile"
    elseif activeMode == "Customize" then
        tabGroup = "Customize"
    elseif activeMode == "Notifications" then
        tabGroup = "Alerts"
    end

    for key, btn in pairs(bs.UI.NavButtons) do
        local isAct = (key == tabGroup)
        local ind = btn:FindFirstChild("ActiveBar")
        local lbl = btn:FindFirstChild("NavLbl")
        local ico = btn:FindFirstChild("NavIco")
        if isAct then
            g:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(26, 24, 44),
                BackgroundTransparency = 0.12
            }):Play()
            if ind then ind.Visible = true; ind.BackgroundColor3 = ae.Accent end
            if lbl then lbl.TextColor3 = ae.Accent end
            if ico then ico.TextTransparency = 0 end
        else
            g:Create(btn, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
            if ind then ind.Visible = false end
            if lbl then lbl.TextColor3 = ae.SubText end
            if ico then ico.TextTransparency = 0.28 end
        end
    end
end

-- ========================================================================= --
-- [SUB-BUILDER 1 : FIXED CENTERED 4-TAB GLASSMORPHIC BOTTOM NAV BAR]
-- ========================================================================= --
function bs.BuildNavBar(cG, ae)
    local NavBar = Instance.new("Frame", cG)
    NavBar.Name = "ZaynBottomNavBar"
    NavBar.Size = UDim2.new(1, 0, 0, bs.Layout.NavH)
    NavBar.Position = UDim2.new(0, 0, 1, -bs.Layout.NavH)
    NavBar.BackgroundColor3 = ae.HeaderBg
    NavBar.BackgroundTransparency = ae.HeadTrans
    NavBar.BorderSizePixel = 0
    NavBar.ZIndex = 65
    bs.UI.NavBar = NavBar

    -- Divider stays OUTSIDE the UIListLayout frame so buttons NEVER shift sideways!
    local navTopLine = Instance.new("Frame", NavBar)
    navTopLine.Name = "NavTopLine"
    navTopLine.Size = UDim2.new(1, 0, 0, 1)
    navTopLine.Position = UDim2.new(0, 0, 0, 0)
    navTopLine.BackgroundColor3 = ae.StrokeColor
    navTopLine.BackgroundTransparency = 0.35
    navTopLine.BorderSizePixel = 0
    navTopLine.ZIndex = 66

    local btnHolder = Instance.new("Frame", NavBar)
    btnHolder.Name = "NavButtonsRow"
    btnHolder.Size = UDim2.new(1, -12, 1, -2)
    btnHolder.Position = UDim2.new(0, 6, 0, 2)
    btnHolder.BackgroundTransparency = 1
    btnHolder.ZIndex = 66

    local navLayout = Instance.new("UIListLayout", btnHolder)
    navLayout.FillDirection = Enum.FillDirection.Horizontal
    navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    navLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    navLayout.Padding = UDim.new(0, 6)
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder

    bs.UI.NavButtons = {}

    local navDefs = {
        {key = "Chat",      icon = "💬", label = "Chat",      order = 1, fn = function() bs.SwitchMode("Server") end},
        {key = "Profile",   icon = "👤", label = "Profile",   order = 2, fn = function() bs.OpenUserProfile(bs.Social.MyUid) end},
        {key = "Customize", icon = "✨", label = "Customize", order = 3, fn = function() bs.OpenCustomizePage("Avatar") end},
        {key = "Alerts",    icon = "🔔", label = "Alerts",    order = 4, fn = function() bs.SwitchMode("Notifications") end}
    }

    for _, def in ipairs(navDefs) do
        local btn = Instance.new("TextButton", btnHolder)
        btn.Name = "NavBtn_" .. def.key
        btn.Size = UDim2.new(0.235, 0, 0, 34)
        btn.BackgroundColor3 = Color3.fromRGB(26, 24, 44)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.LayoutOrder = def.order
        btn.ZIndex = 67
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(btn, 1.05)

        local activeBar = Instance.new("Frame", btn)
        activeBar.Name = "ActiveBar"
        activeBar.Size = UDim2.new(0.55, 0, 0, 2)
        activeBar.Position = UDim2.new(0.225, 0, 0, 0)
        activeBar.BackgroundColor3 = ae.Accent
        activeBar.BorderSizePixel = 0
        activeBar.Visible = (def.key == "Chat")
        activeBar.ZIndex = 68
        Instance.new("UICorner", activeBar).CornerRadius = UDim.new(1, 0)

        local ico = Instance.new("TextLabel", btn)
        ico.Name = "NavIco"
        ico.Size = UDim2.new(1, 0, 0, 17)
        ico.Position = UDim2.new(0, 0, 0, 3)
        ico.BackgroundTransparency = 1
        ico.Text = def.icon
        ico.TextSize = 13
        ico.Font = Enum.Font.GothamBold
        ico.TextColor3 = Color3.fromRGB(255, 255, 255)
        ico.ZIndex = 68

        local lbl = Instance.new("TextLabel", btn)
        lbl.Name = "NavLbl"
        lbl.Size = UDim2.new(1, 0, 0, 12)
        lbl.Position = UDim2.new(0, 0, 0, 20)
        lbl.BackgroundTransparency = 1
        lbl.Text = def.label
        lbl.TextSize = 9.5
        lbl.Font = Enum.Font.GothamBold
        lbl.TextColor3 = ae.SubText
        lbl.ZIndex = 68

        if def.key == "Alerts" then
            local badge = Instance.new("Frame", btn)
            badge.Name = "NavNotifBadge"
            badge.Size = UDim2.new(0, 16, 0, 14)
            badge.Position = UDim2.new(0.5, 8, 0, 2)
            badge.BackgroundColor3 = Color3.fromRGB(255, 45, 130)
            badge.Visible = false
            badge.ZIndex = 70
            Instance.new("UICorner", badge).CornerRadius = UDim.new(1, 0)

            local cnt = Instance.new("TextLabel", badge)
            cnt.Name = "CountTxt"
            cnt.Size = UDim2.new(1, 0, 1, 0)
            cnt.BackgroundTransparency = 1
            cnt.Font = Enum.Font.GothamBold
            cnt.TextSize = 8.5
            cnt.TextColor3 = Color3.fromRGB(255, 255, 255)
            cnt.Text = "1"
            cnt.ZIndex = 71
            bs.UI.NavNotifBadge = badge
        end

        btn.MouseButton1Click:Connect(function()
            def.fn()
        end)
        bs.UI.NavButtons[def.key] = btn
    end
end

-- ========================================================================= --
-- [SUB-BUILDER 2 : SETTINGS PAGE]
-- ========================================================================= --
function bs.BuildSettingsPage(cG, ae)
    local cP = Instance.new("ScrollingFrame", cG)
    cP.Name = "SettingsPage"
    cP.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH))
    cP.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    cP.BackgroundTransparency = 1
    cP.ScrollBarThickness = 2
    cP.Visible = false
    cP.ZIndex = 20
    bs.UI.SettingsPage = cP

    local cQ = Instance.new("UIListLayout", cP)
    cQ.Padding = UDim.new(0, 8)
    cQ.HorizontalAlignment = Enum.HorizontalAlignment.Center
    cQ.SortOrder = Enum.SortOrder.LayoutOrder

    local cR = Instance.new("UIPadding", cP)
    cR.PaddingTop = UDim.new(0, 10)
    cR.PaddingBottom = UDim.new(0, 14)

    cQ:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        cP.CanvasSize = UDim2.new(0, 0, 0, cQ.AbsoluteContentSize.Y + 28)
    end)

    local function cS(cT, cU, cV, cW)
        local aQ = Instance.new("TextButton", cP)
        aQ.Size = UDim2.new(1, -24, 0, 42)
        aQ.BackgroundColor3 = ae.InputBg
        aQ.Text = ""
        aQ.ZIndex = 21
        Instance.new("UICorner", aQ).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", aQ).Color = ae.StrokeColor
        bs.AttachBossInteractions(aQ, 1.03)

        local cY = Instance.new("TextLabel", aQ)
        cY.Name = "EmojiIcon"
        cY.Size = UDim2.new(0, 44, 1, 0)
        cY.BackgroundTransparency = 1
        cY.Font = Enum.Font.GothamBold
        cY.TextSize = 16
        cY.Text = cU
        cY.TextColor3 = ae.TextColor
        cY.ZIndex = 22

        local cZ = Instance.new("ImageLabel", aQ)
        cZ.Name = "DecalIcon"
        cZ.Size = UDim2.new(0, 26, 0, 26)
        cZ.Position = UDim2.new(0, 9, 0.5, -13)
        cZ.BackgroundTransparency = 1
        cZ.ScaleType = Enum.ScaleType.Crop
        cZ.ZIndex = 22
        Instance.new("UICorner", cZ).CornerRadius = UDim.new(1, 0)
        if cV then
            cZ.Image = "rbxthumb://type=Asset&id=" .. cV .. "&w=150&h=150"
        end

        local c_ = bs.CurrentTheme == "Dark" or bs.CurrentTheme == "PureBlack" or bs.CurrentTheme == "ObsidianGold"
        if cV and c_ then
            cY.Visible = false; cZ.Visible = true
        else
            cY.Visible = true; cZ.Visible = false
        end

        local d0 = Instance.new("TextLabel", aQ)
        d0.Name = "MenuText"
        d0.Size = UDim2.new(1, -48, 1, 0)
        d0.Position = UDim2.new(0, 44, 0, 0)
        d0.BackgroundTransparency = 1
        d0.Font = Enum.Font.GothamBold
        d0.TextSize = 12.5
        d0.TextColor3 = ae.TextColor
        d0.TextXAlignment = Enum.TextXAlignment.Left
        d0.Text = cT
        d0.ZIndex = 22

        aQ.MouseButton1Click:Connect(function() cW() end)
        return aQ
    end
    bs.AddSettingsRow = cS

    local d1 = cS("Chat Theme: " .. bs.CurrentTheme, bN[bs.CurrentTheme] or "⚫", nil, function() end)
    d1.MouseButton1Click:Connect(function()
        bO = bO % #bM + 1
        bs.CurrentTheme = bM[bO]
        d1:FindFirstChild("MenuText").Text = "Chat Theme: " .. bs.CurrentTheme
        local cY = d1:FindFirstChild("EmojiIcon")
        if cY then cY.Text = bN[bs.CurrentTheme] or "⚫" end
        bs.UpdateThemeAnimated()
    end)

    cS("My Insta Elite Profile", "👤", nil, function() bs.OpenUserProfile(bs.Social.MyUid) end)
    cS("Customize Avatar, Themes & ₹300 Pass", "✨", nil, function() bs.OpenCustomizePage("Avatar") end)
    cS("Music Studio Player", "🎵", nil, function() bs.SwitchMode("Music") end)
    cS("DMs Inbox", "📩", "76603582829185", function() bs.SwitchMode("DM_Inbox") end)
    cS("Close Friends", "♥️", "12323660650", function() bs.SwitchMode("CloseFriends") end)
    cS("Image Vault", "🖼️", "12623721060", function()
        bs.SwitchMode("Server")
        if bs.UI.StickerTray then bs.UI.StickerTray.Visible = false end
        if bs.UI.ImageTray then
            bs.UI.ImageTray.Visible = true
            bs.RefreshVaultUI()
        end
    end)

    local d2 = cS(bs.MuteServerToasts and "Unmute Alerts" or "Mute Alerts", bs.MuteServerToasts and "🔕" or "🔊", nil, function() end)
    d2.MouseButton1Click:Connect(function()
        bs.MuteServerToasts = not bs.MuteServerToasts
        d2:FindFirstChild("MenuText").Text = bs.MuteServerToasts and "Unmute Alerts" or "Mute Alerts"
        local d3 = d2:FindFirstChild("EmojiIcon")
        if d3 then d3.Text = bs.MuteServerToasts and "🔕" or "🔊" end
        bs.TriggerToast("🔕 Alerts", bs.MuteServerToasts and "Popups Silenced" or "Popups Active", false)
    end)

    local rzF = Instance.new("Frame", cP)
    rzF.Name = "ResizeUIBox"
    rzF.Size = UDim2.new(1, -24, 0, 66)
    rzF.BackgroundColor3 = ae.InputBg
    rzF.ZIndex = 21
    Instance.new("UICorner", rzF).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", rzF).Color = ae.StrokeColor

    local rzT = Instance.new("TextLabel", rzF)
    rzT.Size = UDim2.new(1, 0, 0, 22)
    rzT.Position = UDim2.new(0, 0, 0, 5)
    rzT.BackgroundTransparency = 1
    rzT.Font = Enum.Font.GothamBold
    rzT.TextSize = 11.5
    rzT.TextColor3 = ae.TextColor
    rzT.Text = "📐 Custom UI Size (W:340-560, H:320-480)"
    rzT.ZIndex = 22

    local rzW = Instance.new("TextBox", rzF)
    rzW.Size = UDim2.new(0.28, 0, 0, 26)
    rzW.Position = UDim2.new(0.06, 0, 0, 32)
    rzW.BackgroundColor3 = ae.HeaderBg
    rzW.TextColor3 = ae.TextColor
    rzW.Font = Enum.Font.GothamMedium
    rzW.TextSize = 11
    rzW.PlaceholderText = "Width"
    rzW.Text = ""
    rzW.ZIndex = 22
    Instance.new("UICorner", rzW).CornerRadius = UDim.new(0, 6)

    local rzH = Instance.new("TextBox", rzF)
    rzH.Size = UDim2.new(0.28, 0, 0, 26)
    rzH.Position = UDim2.new(0.38, 0, 0, 32)
    rzH.BackgroundColor3 = ae.HeaderBg
    rzH.TextColor3 = ae.TextColor
    rzH.Font = Enum.Font.GothamMedium
    rzH.TextSize = 11
    rzH.PlaceholderText = "Height"
    rzH.Text = ""
    rzH.ZIndex = 22
    Instance.new("UICorner", rzH).CornerRadius = UDim.new(0, 6)

    local rzB = Instance.new("TextButton", rzF)
    rzB.Size = UDim2.new(0.22, 0, 0, 26)
    rzB.Position = UDim2.new(0.72, 0, 0, 32)
    rzB.BackgroundColor3 = ae.Accent
    rzB.TextColor3 = ae.SendText
    rzB.Font = Enum.Font.GothamBold
    rzB.TextSize = 11
    rzB.Text = "APPLY"
    rzB.ZIndex = 22
    Instance.new("UICorner", rzB).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(rzB, 1.05)

    rzB.MouseButton1Click:Connect(function()
        local nw, nh = tonumber(rzW.Text), tonumber(rzH.Text)
        if nw and nh then
            nw = math.clamp(nw, 340, 560)
            nh = math.clamp(nh, 320, 480)
            g:Create(cG, TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, nw, 0, nh)}):Play()
            bs.TriggerToast("📐 UI Adjusted", "Size set to " .. nw .. "x" .. nh, false)
        else
            bs.TriggerToast("⚠️ Error", "Valid width & height required", false)
        end
    end)
end

-- ========================================================================= --
-- [SUB-BUILDER 3 : INTEGRATED MULTI-API MUSIC STUDIO (FIXES INVALID JSON)]
-- ========================================================================= --
function bs.BuildMusicPanel(cG)
    local MusicPanel = Instance.new("Frame", cG)
    MusicPanel.Name = "ZaynMusic_Panel"
    MusicPanel.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH))
    MusicPanel.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    MusicPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
    MusicPanel.BorderSizePixel = 0
    MusicPanel.Visible = false
    MusicPanel.ZIndex = 50
    bs.UI.MusicPanel = MusicPanel

    local MusicGrad = Instance.new("UIGradient", MusicPanel)
    MusicGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 7, 14)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 10, 36)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 18, 42))
    })
    MusicGrad.Rotation = 45

    local downloadHost = "youtube-mp36.p.rapidapi.com"
    local rapidApiKey = "0542323a46mshec2535016607a28p102505jsne1f803a161ef"
    local favStorageFile = "Zayn_Fav_Songs.json"

    local function getSavedFavorites()
        if isfile and pcall(isfile, favStorageFile) and isfile(favStorageFile) then
            local ok, parsed = pcall(function() return f:JSONDecode(readfile(favStorageFile)) end)
            if ok and type(parsed) == "table" then return parsed end
        end
        return {}
    end

    local function saveToFavoritesRegistry(t)
        pcall(function() if writefile then writefile(favStorageFile, f:JSONEncode(t)) end end)
    end

    local sessionQueue = {}
    local currentQueueIndex = 1

    local BrowserPanel = Instance.new("Frame", MusicPanel)
    BrowserPanel.Name = "BrowserPanel"
    BrowserPanel.Size = UDim2.new(1, 0, 1, -28)
    BrowserPanel.BackgroundTransparency = 1
    BrowserPanel.Visible = true
    BrowserPanel.ZIndex = 51

    local TabNav = Instance.new("Frame", BrowserPanel)
    TabNav.Size = UDim2.new(1, -24, 0, 28)
    TabNav.Position = UDim2.new(0, 12, 0, 8)
    TabNav.BackgroundTransparency = 1
    TabNav.ZIndex = 52

    local SearchTabBtn = Instance.new("TextButton", TabNav)
    SearchTabBtn.Size = UDim2.new(0.5, -4, 1, 0)
    SearchTabBtn.BackgroundColor3 = Color3.fromRGB(75, 30, 150)
    SearchTabBtn.Text = "🎵 SEARCH ENGINE"
    SearchTabBtn.Font = Enum.Font.GothamBold
    SearchTabBtn.TextSize = 10
    SearchTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchTabBtn.BorderSizePixel = 0
    SearchTabBtn.ZIndex = 55
    Instance.new("UICorner", SearchTabBtn).CornerRadius = UDim.new(0, 8)

    local FavTabBtn = Instance.new("TextButton", TabNav)
    FavTabBtn.Size = UDim2.new(0.5, -4, 1, 0)
    FavTabBtn.Position = UDim2.new(0.5, 4, 0, 0)
    FavTabBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
    FavTabBtn.Text = "⭐ MY FAVORITES"
    FavTabBtn.Font = Enum.Font.GothamBold
    FavTabBtn.TextSize = 10
    FavTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FavTabBtn.BorderSizePixel = 0
    FavTabBtn.ZIndex = 55
    Instance.new("UICorner", FavTabBtn).CornerRadius = UDim.new(0, 8)

    local SearchBar = Instance.new("Frame", BrowserPanel)
    SearchBar.Size = UDim2.new(1, -24, 0, 32)
    SearchBar.Position = UDim2.new(0, 12, 0, 42)
    SearchBar.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
    SearchBar.BorderSizePixel = 0
    SearchBar.ZIndex = 52
    Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0, 8)

    local SearchInput = Instance.new("TextBox", SearchBar)
    SearchInput.Size = UDim2.new(1, -80, 1, 0)
    SearchInput.Position = UDim2.new(0, 10, 0, 0)
    SearchInput.BackgroundTransparency = 1
    SearchInput.Font = Enum.Font.GothamMedium
    SearchInput.TextSize = 11
    SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchInput.PlaceholderText = "Search track or artist name..."
    SearchInput.PlaceholderColor3 = Color3.fromRGB(130, 120, 145)
    SearchInput.Text = ""
    SearchInput.ClearTextOnFocus = false
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.ZIndex = 55

    local SearchBtn = Instance.new("TextButton", SearchBar)
    SearchBtn.Size = UDim2.new(0, 64, 0, 24)
    SearchBtn.Position = UDim2.new(1, -68, 0.5, -12)
    SearchBtn.BackgroundColor3 = Color3.fromRGB(185, 0, 105)
    SearchBtn.Text = "SEARCH"
    SearchBtn.Font = Enum.Font.GothamBold
    SearchBtn.TextSize = 10
    SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBtn.BorderSizePixel = 0
    SearchBtn.ZIndex = 56
    Instance.new("UICorner", SearchBtn).CornerRadius = UDim.new(0, 6)

    local ResultsScroll = Instance.new("ScrollingFrame", BrowserPanel)
    ResultsScroll.Size = UDim2.new(1, -24, 1, -86)
    ResultsScroll.Position = UDim2.new(0, 12, 0, 80)
    ResultsScroll.BackgroundTransparency = 1
    ResultsScroll.BorderSizePixel = 0
    ResultsScroll.ScrollBarThickness = 3
    ResultsScroll.ScrollBarImageColor3 = Color3.fromRGB(185, 0, 105)
    ResultsScroll.ZIndex = 52

    local ListLayout = Instance.new("UIListLayout", ResultsScroll)
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", ResultsScroll).PaddingTop = UDim.new(0, 2)

    local StatusBar = Instance.new("Frame", MusicPanel)
    StatusBar.Size = UDim2.new(1, -24, 0, 22)
    StatusBar.Position = UDim2.new(0, 12, 1, -26)
    StatusBar.BackgroundColor3 = Color3.fromRGB(8, 6, 14)
    StatusBar.BorderSizePixel = 0
    StatusBar.ZIndex = 60
    Instance.new("UICorner", StatusBar).CornerRadius = UDim.new(0, 6)

    local StatusText = Instance.new("TextLabel", StatusBar)
    StatusText.Size = UDim2.new(1, -14, 1, 0)
    StatusText.Position = UDim2.new(0, 7, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Zayn Music Engine: Multi-API Ready"
    StatusText.Font = Enum.Font.GothamMedium
    StatusText.TextSize = 10
    StatusText.TextColor3 = Color3.fromRGB(170, 160, 195)
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.ClipsDescendants = true
    StatusText.ZIndex = 61

    local PlayerPanel = Instance.new("Frame", MusicPanel)
    PlayerPanel.Name = "PlayerPanel"
    PlayerPanel.Size = UDim2.new(1, 0, 1, -28)
    PlayerPanel.BackgroundTransparency = 1
    PlayerPanel.Visible = false
    PlayerPanel.ZIndex = 55

    local MetaBlock = Instance.new("Frame", PlayerPanel)
    MetaBlock.Size = UDim2.new(1, -28, 0, 62)
    MetaBlock.Position = UDim2.new(0, 14, 0, 10)
    MetaBlock.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
    MetaBlock.BorderSizePixel = 0
    MetaBlock.ZIndex = 56
    Instance.new("UICorner", MetaBlock).CornerRadius = UDim.new(0, 10)

    local TrackNameLabel = Instance.new("TextLabel", MetaBlock)
    TrackNameLabel.Size = UDim2.new(1, -58, 0, 24)
    TrackNameLabel.Position = UDim2.new(0, 12, 0, 8)
    TrackNameLabel.BackgroundTransparency = 1
    TrackNameLabel.Text = "Loading Track..."
    TrackNameLabel.Font = Enum.Font.GothamBold
    TrackNameLabel.TextSize = 12
    TrackNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TrackNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    TrackNameLabel.ClipsDescendants = true
    TrackNameLabel.ZIndex = 57

    local ArtistLabel = Instance.new("TextLabel", MetaBlock)
    ArtistLabel.Size = UDim2.new(1, -58, 0, 18)
    ArtistLabel.Position = UDim2.new(0, 12, 0, 34)
    ArtistLabel.BackgroundTransparency = 1
    ArtistLabel.Text = "By Unknown Artist"
    ArtistLabel.Font = Enum.Font.GothamMedium
    ArtistLabel.TextSize = 10
    ArtistLabel.TextColor3 = Color3.fromRGB(0, 255, 210)
    ArtistLabel.TextXAlignment = Enum.TextXAlignment.Left
    ArtistLabel.ClipsDescendants = true
    ArtistLabel.ZIndex = 57

    local ToggleFavBtn = Instance.new("TextButton", MetaBlock)
    ToggleFavBtn.Size = UDim2.new(0, 34, 0, 34)
    ToggleFavBtn.Position = UDim2.new(1, -44, 0.5, -17)
    ToggleFavBtn.BackgroundColor3 = Color3.fromRGB(45, 32, 70)
    ToggleFavBtn.Text = "☆"
    ToggleFavBtn.Font = Enum.Font.GothamBold
    ToggleFavBtn.TextSize = 18
    ToggleFavBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFavBtn.BorderSizePixel = 0
    ToggleFavBtn.ZIndex = 58
    Instance.new("UICorner", ToggleFavBtn).CornerRadius = UDim.new(0, 8)

    local ContentRack = Instance.new("Frame", PlayerPanel)
    ContentRack.Size = UDim2.new(1, 0, 1, -78)
    ContentRack.Position = UDim2.new(0, 0, 0, 78)
    ContentRack.BackgroundTransparency = 1
    ContentRack.ZIndex = 56

    local ProgressContainer = Instance.new("TextButton", ContentRack)
    ProgressContainer.Size = UDim2.new(1, -28, 0, 10)
    ProgressContainer.Position = UDim2.new(0, 14, 0, 8)
    ProgressContainer.BackgroundColor3 = Color3.fromRGB(25, 18, 40)
    ProgressContainer.Text = ""
    ProgressContainer.BorderSizePixel = 0
    ProgressContainer.AutoButtonColor = false
    ProgressContainer.ZIndex = 57
    Instance.new("UICorner", ProgressContainer).CornerRadius = UDim.new(1, 0)

    local ProgressBar = Instance.new("Frame", ProgressContainer)
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 58
    Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1, 0)
    Instance.new("UIGradient", ProgressBar).Color = ColorSequence.new(Color3.fromRGB(255, 0, 127), Color3.fromRGB(0, 160, 255))

    local ProgressKnob = Instance.new("Frame", ProgressContainer)
    ProgressKnob.Size = UDim2.new(0, 12, 0, 12)
    ProgressKnob.Position = UDim2.new(0, -6, 0.5, -6)
    ProgressKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProgressKnob.BorderSizePixel = 0
    ProgressKnob.ZIndex = 59
    Instance.new("UICorner", ProgressKnob).CornerRadius = UDim.new(1, 0)

    local TimeCurrent = Instance.new("TextLabel", ContentRack)
    TimeCurrent.Size = UDim2.new(0, 60, 0, 18)
    TimeCurrent.Position = UDim2.new(0, 14, 0, 22)
    TimeCurrent.BackgroundTransparency = 1
    TimeCurrent.Text = "00:00"
    TimeCurrent.Font = Enum.Font.GothamMedium
    TimeCurrent.TextSize = 10
    TimeCurrent.TextColor3 = Color3.fromRGB(0, 255, 255)
    TimeCurrent.TextXAlignment = Enum.TextXAlignment.Left
    TimeCurrent.ZIndex = 57

    local TimeTotal = Instance.new("TextLabel", ContentRack)
    TimeTotal.Size = UDim2.new(0, 60, 0, 18)
    TimeTotal.Position = UDim2.new(1, -74, 0, 22)
    TimeTotal.BackgroundTransparency = 1
    TimeTotal.Text = "00:00"
    TimeTotal.Font = Enum.Font.GothamMedium
    TimeTotal.TextSize = 10
    TimeTotal.TextColor3 = Color3.fromRGB(255, 0, 127)
    TimeTotal.TextXAlignment = Enum.TextXAlignment.Right
    TimeTotal.ZIndex = 57

    local ControlRackFrame = Instance.new("Frame", ContentRack)
    ControlRackFrame.Size = UDim2.new(1, -28, 0, 38)
    ControlRackFrame.Position = UDim2.new(0, 14, 0, 48)
    ControlRackFrame.BackgroundTransparency = 1
    ControlRackFrame.ZIndex = 57

    local ControlLayout = Instance.new("UIListLayout", ControlRackFrame)
    ControlLayout.FillDirection = Enum.FillDirection.Horizontal
    ControlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ControlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ControlLayout.Padding = UDim.new(0, 6)
    ControlLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local function buildMusicBtn(txt, widthScale, order, col)
        local btn = Instance.new("TextButton", ControlRackFrame)
        btn.Size = UDim2.new(widthScale, -5, 0, 34)
        btn.BackgroundColor3 = col
        btn.Text = txt
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.LayoutOrder = order
        btn.ZIndex = 60
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(btn, 1.06)
        return btn
    end

    local PrevBtn = buildMusicBtn("⏮ PREV", 0.17, 1, Color3.fromRGB(45, 35, 65))
    local PauseBtn = buildMusicBtn("⏸ PAUSE", 0.22, 2, Color3.fromRGB(0, 110, 185))
    local NextBtn = buildMusicBtn("⏭ NEXT", 0.17, 3, Color3.fromRGB(45, 35, 65))
    local ServerBtn = buildMusicBtn("🌐 SERVER", 0.23, 4, Color3.fromRGB(175, 110, 15))
    local StopBtn = buildMusicBtn("✖ CLOSE", 0.21, 5, Color3.fromRGB(165, 25, 35))

    local VolRack = Instance.new("Frame", ContentRack)
    VolRack.Size = UDim2.new(1, -28, 0, 26)
    VolRack.Position = UDim2.new(0, 14, 0, 96)
    VolRack.BackgroundTransparency = 1
    VolRack.ZIndex = 57

    local VolIcon = Instance.new("TextLabel", VolRack)
    VolIcon.Size = UDim2.new(0, 24, 1, 0)
    VolIcon.BackgroundTransparency = 1
    VolIcon.Text = "🔊"
    VolIcon.TextSize = 12
    VolIcon.TextColor3 = Color3.fromRGB(0, 255, 255)
    VolIcon.ZIndex = 58

    local VolTrack = Instance.new("TextButton", VolRack)
    VolTrack.Size = UDim2.new(1, -32, 0, 6)
    VolTrack.Position = UDim2.new(0, 28, 0.5, -3)
    VolTrack.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    VolTrack.Text = ""
    VolTrack.BorderSizePixel = 0
    VolTrack.AutoButtonColor = false
    VolTrack.ZIndex = 58
    Instance.new("UICorner", VolTrack).CornerRadius = UDim.new(1, 0)

    local VolFill = Instance.new("Frame", VolTrack)
    VolFill.Size = UDim2.new(0.6, 0, 1, 0)
    VolFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VolFill.BorderSizePixel = 0
    VolFill.ZIndex = 59
    Instance.new("UICorner", VolFill).CornerRadius = UDim.new(1, 0)
    Instance.new("UIGradient", VolFill).Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(130, 0, 255))

    local VolKnob = Instance.new("Frame", VolTrack)
    VolKnob.Size = UDim2.new(0, 12, 0, 12)
    VolKnob.Position = UDim2.new(0.6, -6, 0.5, -6)
    VolKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VolKnob.BorderSizePixel = 0
    VolKnob.ZIndex = 60
    Instance.new("UICorner", VolKnob).CornerRadius = UDim.new(1, 0)

    local LoaderFrame = Instance.new("Frame", PlayerPanel)
    LoaderFrame.Size = UDim2.new(1, -28, 0, 120)
    LoaderFrame.Position = UDim2.new(0, 14, 0, 84)
    LoaderFrame.BackgroundTransparency = 1
    LoaderFrame.Visible = false
    LoaderFrame.ZIndex = 62

    local LoaderText = Instance.new("TextLabel", LoaderFrame)
    LoaderText.Size = UDim2.new(1, 0, 0, 28)
    LoaderText.Position = UDim2.new(0, 0, 0, 14)
    LoaderText.BackgroundTransparency = 1
    LoaderText.Text = "◐  ᴅᴏᴡɴʟᴏᴀᴅɪɴɢ   ᴀᴜᴅɪᴏ..."
    LoaderText.Font = Enum.Font.GothamBold
    LoaderText.TextSize = 12
    LoaderText.TextColor3 = Color3.fromRGB(255, 0, 127)
    LoaderText.ZIndex = 63

    local LoaderBarBackground = Instance.new("Frame", LoaderFrame)
    LoaderBarBackground.Size = UDim2.new(0, 200, 0, 4)
    LoaderBarBackground.Position = UDim2.new(0.5, -100, 0, 50)
    LoaderBarBackground.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    LoaderBarBackground.BorderSizePixel = 0
    LoaderBarBackground.ZIndex = 63
    Instance.new("UICorner", LoaderBarBackground).CornerRadius = UDim.new(1, 0)

    local LoaderBarGlow = Instance.new("Frame", LoaderBarBackground)
    LoaderBarGlow.Size = UDim2.new(0.3, 0, 1, 0)
    LoaderBarGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoaderBarGlow.BorderSizePixel = 0
    LoaderBarGlow.ZIndex = 64
    Instance.new("UICorner", LoaderBarGlow).CornerRadius = UDim.new(1, 0)
    Instance.new("UIGradient", LoaderBarGlow).Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 127))

    local LoaderCancelBtn = Instance.new("TextButton", LoaderFrame)
    LoaderCancelBtn.Size = UDim2.new(0, 90, 0, 28)
    LoaderCancelBtn.Position = UDim2.new(0.5, -45, 0, 68)
    LoaderCancelBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 35)
    LoaderCancelBtn.Text = "✖ CANCEL"
    LoaderCancelBtn.Font = Enum.Font.GothamBold
    LoaderCancelBtn.TextSize = 10
    LoaderCancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoaderCancelBtn.BorderSizePixel = 0
    LoaderCancelBtn.ZIndex = 64
    Instance.new("UICorner", LoaderCancelBtn).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(LoaderCancelBtn, 1.06)

    local soundSvc = game:GetService("SoundService")
    local GlobalSound = soundSvc:FindFirstChild("MatrixGlobalSound") or Instance.new("Sound", soundSvc)
    GlobalSound.Name = "MatrixGlobalSound"
    GlobalSound.Volume = 0.6

    bs.AttachBossInteractions(SearchBtn, 1.08)
    bs.AttachBossInteractions(SearchTabBtn, 1.06)
    bs.AttachBossInteractions(FavTabBtn, 1.06)
    bs.AttachBossInteractions(ToggleFavBtn, 1.1)

    local function formatSeconds(val)
        if not val or val ~= val then return "00:00" end
        return string.format("%02d:%02d", math.floor(val / 60), math.floor(val % 60))
    end

    local musicAnimId, seekBlock, isDraggingVol, loadingActive, playSession = nil, false, false, false, 0

    local function stopMusicProgressLoop()
        if musicAnimId then bs.UnregisterAnim(musicAnimId); musicAnimId = nil end
    end

    local function playSelectedQueueIndex()
        local trackNode = sessionQueue[currentQueueIndex]
        if not trackNode then return end

        playSession = playSession + 1
        local mySess = playSession
        stopMusicProgressLoop()
        BrowserPanel.Visible = false
        PlayerPanel.Visible = true
        ContentRack.Visible = false
        LoaderFrame.Visible = true
        loadingActive = true

        TrackNameLabel.Text = trackNode.title
        ArtistLabel.Text = "By " .. trackNode.channel
        ProgressBar.Size = UDim2.new(0, 0, 1, 0)
        ProgressKnob.Position = UDim2.new(0, -6, 0.5, -6)
        TimeCurrent.Text = "00:00"
        TimeTotal.Text = "00:00"
        PauseBtn.Text = "⏸ PAUSE"

        local isFav = false
        for _, f_item in ipairs(getSavedFavorites()) do
            if f_item.id == trackNode.id then isFav = true; break end
        end
        ToggleFavBtn.Text = isFav and "★" or "☆"
        ToggleFavBtn.TextColor3 = isFav and Color3.fromRGB(255, 220, 40) or Color3.fromRGB(255, 255, 255)
        ServerBtn.Visible = (bs.DJRegistry[m.Name:lower()] == true or au())
        StatusText.Text = "⏳ Connecting to audio node..."
        StatusText.TextColor3 = Color3.fromRGB(0, 255, 255)

        task.spawn(function()
            local spinChars = {"◐", "◓", "◑", "◒"}
            local ticks = 0
            LoaderBarGlow.Position = UDim2.new(0, 0, 0, 0)
            local tw = g:Create(LoaderBarGlow, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(0.7, 0, 0, 0)})
            tw:Play()
            while loadingActive and playSession == mySess do
                ticks = ticks + 1
                LoaderText.Text = spinChars[(ticks % #spinChars) + 1] .. "  ᴅᴏᴡɴʟᴏᴀᴅɪɴɢ   ᴀᴜᴅɪᴏ" .. string.rep(".", ticks % 4)
                task.wait(0.14)
            end
            tw:Cancel()
        end)

        task.spawn(function()
            local linkUrl = "https://" .. downloadHost .. "/dl?id=" .. tostring(trackNode.id)
            local finalLink, retryCount = nil, 0
            while retryCount < 14 and loadingActive and playSession == mySess do
                local ok, res = pcall(function()
                    return n({
                        Url = linkUrl,
                        Method = "GET",
                        Timeout = 10,
                        Headers = {
                            ["X-RapidAPI-Host"] = downloadHost,
                            ["X-RapidAPI-Key"] = rapidApiKey,
                            ["Content-Type"] = "application/json"
                        }
                    })
                end)
                if playSession ~= mySess then return end
                if ok and res and res.StatusCode == 200 and res.Body and res.Body ~= "" and not res.Body:match("^%s*<") then
                    local dOk, data = pcall(function() return f:JSONDecode(res.Body) end)
                    if dOk and type(data) == "table" then
                        if data.status == "ok" and data.link then finalLink = data.link; break
                        elseif data.status == "processing" or data.msg == "in queue" then
                            StatusText.Text = "⏳ Rendering audio stream... (" .. (retryCount + 1) .. ")"
                            task.wait(0.8); retryCount = retryCount + 1
                        else
                            StatusText.Text = "❌ API Error: " .. tostring(data.msg or "Unavailable"); break
                        end
                    else
                        StatusText.Text = "❌ Audio host returned invalid JSON"; break
                    end
                else
                    StatusText.Text = "❌ Audio download host unreachable."; break
                end
            end

            if playSession ~= mySess then return end
            if finalLink and loadingActive then
                StatusText.Text = "📥 Downloading audio..."
                local fOk, buf = pcall(function() return n({Url = finalLink, Method = "GET", Timeout = 15}) end)
                if playSession ~= mySess then return end
                if fOk and buf and buf.StatusCode == 200 and buf.Body then
                    local targetLocalFile = "ZaynStudio_StreamTrack.mp3"
                    pcall(function() if writefile then writefile(targetLocalFile, buf.Body) end end)
                    task.wait(0.05)
                    local aOk, token = pcall(function() return getcustomasset(targetLocalFile) end)
                    if aOk and token then
                        if GlobalSound.IsPlaying then GlobalSound:Stop() end
                        local pOk, pErr = pcall(function() GlobalSound.SoundId = token; GlobalSound:Play() end)
                        if pOk then
                            loadingActive = false
                            LoaderFrame.Visible = false
                            ContentRack.Visible = true
                            StatusText.Text = "🔊 Now Playing: " .. trackNode.title
                            StatusText.TextColor3 = Color3.fromRGB(0, 255, 255)

                            musicAnimId = bs.RegisterAnim(ContentRack, function()
                                if not seekBlock and (GlobalSound.IsPlaying or GlobalSound.TimePosition > 0) then
                                    local len, pos = GlobalSound.TimeLength, GlobalSound.TimePosition
                                    if len > 0 then
                                        local pct = math.clamp(pos / len, 0, 1)
                                        ProgressBar.Size = UDim2.new(pct, 0, 1, 0)
                                        ProgressKnob.Position = UDim2.new(pct, -6, 0.5, -6)
                                        TimeCurrent.Text = formatSeconds(pos)
                                        TimeTotal.Text = formatSeconds(len)
                                        if pos >= len - 0.5 then
                                            stopMusicProgressLoop()
                                            if currentQueueIndex < #sessionQueue then
                                                currentQueueIndex = currentQueueIndex + 1
                                                playSelectedQueueIndex()
                                            else
                                                GlobalSound:Stop(); PauseBtn.Text = "▶ PLAY"
                                            end
                                        end
                                    end
                                end
                            end)
                        else
                            loadingActive = false; LoaderText.Text = "❌ Playback Failed"; StatusText.Text = "❌ " .. tostring(pErr)
                        end
                    else
                        loadingActive = false; LoaderText.Text = "❌ Asset Load Error"; StatusText.Text = "❌ getcustomasset failed."
                    end
                else
                    loadingActive = false; LoaderText.Text = "❌ Fetch Failed"; StatusText.Text = "❌ Failed to fetch audio stream."
                end
            elseif loadingActive then
                loadingActive = false; LoaderText.Text = "❌ Audio Stream Timeout"
            end
        end)
    end

    local function adjustSeek(inp)
        if GlobalSound.TimeLength > 0 then
            local pct = math.clamp((inp.Position.X - ProgressContainer.AbsolutePosition.X) / math.max(1, ProgressContainer.AbsoluteSize.X), 0, 1)
            ProgressBar.Size = UDim2.new(pct, 0, 1, 0)
            ProgressKnob.Position = UDim2.new(pct, -6, 0.5, -6)
            GlobalSound.TimePosition = pct * GlobalSound.TimeLength
            TimeCurrent.Text = formatSeconds(GlobalSound.TimePosition)
        end
    end

    local function adjustVol(inp)
        local pct = math.clamp((inp.Position.X - VolTrack.AbsolutePosition.X) / math.max(1, VolTrack.AbsoluteSize.X), 0, 1)
        VolFill.Size = UDim2.new(pct, 0, 1, 0)
        VolKnob.Position = UDim2.new(pct, -6, 0.5, -6)
        GlobalSound.Volume = pct
    end

    ProgressContainer.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then seekBlock = true; adjustSeek(inp) end
    end)
    VolTrack.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then isDraggingVol = true; adjustVol(inp) end
    end)
    bs.TrackConn(i.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            if seekBlock then adjustSeek(inp) end
            if isDraggingVol then adjustVol(inp) end
        end
    end))
    bs.TrackConn(i.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            seekBlock = false; isDraggingVol = false
        end
    end))

    PauseBtn.MouseButton1Click:Connect(function()
        if GlobalSound.SoundId ~= "" then
            if GlobalSound.IsPlaying then GlobalSound:Pause(); PauseBtn.Text = "▶ RESUME"
            else GlobalSound:Play(); PauseBtn.Text = "⏸ PAUSE" end
        end
    end)

    ServerBtn.MouseButton1Click:Connect(function()
        if not (bs.DJRegistry[m.Name:lower()] or au()) then
            bs.TriggerToast("⛔ LOCKED", "Server DJ permission required!", false); return
        end
        local trackNode = sessionQueue[currentQueueIndex]
        if trackNode and trackNode.id and trackNode.title then
            local cmd = "/musicsync " .. tostring(trackNode.id) .. " | " .. getRainbowText(trackNode.title) .. " | " .. getRainbowText(m.DisplayName .. " (@" .. m.Name .. ")")
            task.spawn(function() G(F .. "/" .. R .. ".json", "PUT", f:JSONEncode({m = cmd, t = aB()})) end)
            bs.TriggerToast("🌐 SERVER SYNC", "Broadcasting: " .. trackNode.title, false)
        end
    end)

    local function closePlayer()
        playSession = playSession + 1
        loadingActive = false
        stopMusicProgressLoop()
        GlobalSound:Stop(); GlobalSound.SoundId = ""
        PlayerPanel.Visible = false; LoaderFrame.Visible = false; BrowserPanel.Visible = true
        StatusText.Text = "Zayn Music Engine: Multi-API Ready"
        StatusText.TextColor3 = Color3.fromRGB(170, 160, 195)
    end
    StopBtn.MouseButton1Click:Connect(closePlayer)
    LoaderCancelBtn.MouseButton1Click:Connect(closePlayer)

    PrevBtn.MouseButton1Click:Connect(function()
        if currentQueueIndex > 1 and not loadingActive then currentQueueIndex = currentQueueIndex - 1; playSelectedQueueIndex() end
    end)
    NextBtn.MouseButton1Click:Connect(function()
        if currentQueueIndex < #sessionQueue and not loadingActive then currentQueueIndex = currentQueueIndex + 1; playSelectedQueueIndex() end
    end)

    ToggleFavBtn.MouseButton1Click:Connect(function()
        local tr = sessionQueue[currentQueueIndex]
        if not tr or loadingActive then return end
        local favs, idxFound = getSavedFavorites(), nil
        for idx, it in ipairs(favs) do if it.id == tr.id then idxFound = idx; break end end
        if idxFound then
            table.remove(favs, idxFound); ToggleFavBtn.Text = "☆"; ToggleFavBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            StatusText.Text = "⭐ Removed from Favorites."
        else
            table.insert(favs, {title = tr.title, channel = tr.channel, id = tr.id, duration = tr.duration})
            ToggleFavBtn.Text = "★"; ToggleFavBtn.TextColor3 = Color3.fromRGB(255, 220, 40)
            StatusText.Text = "⭐ Saved to Favorites!"
        end
        saveToFavoritesRegistry(favs)
    end)

    local function renderSongCard(title, channel, durationStr, idx)
        local row = Instance.new("Frame", ResultsScroll)
        row.Name = "TrackRow"
        row.Size = UDim2.new(1, -6, 0, 44)
        row.BackgroundColor3 = Color3.fromRGB(16, 14, 28)
        row.LayoutOrder = idx
        row.BorderSizePixel = 0
        row.ZIndex = 54
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

        local tLbl = Instance.new("TextLabel", row)
        tLbl.Size = UDim2.new(1, -86, 0, 18)
        tLbl.Position = UDim2.new(0, 10, 0, 4)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = title
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 11
        tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.ClipsDescendants = true
        tLbl.ZIndex = 55

        local sLbl = Instance.new("TextLabel", row)
        sLbl.Size = UDim2.new(1, -86, 0, 14)
        sLbl.Position = UDim2.new(0, 10, 0, 23)
        sLbl.BackgroundTransparency = 1
        sLbl.Text = "By " .. channel .. "  [" .. (durationStr or "N/A") .. "]"
        sLbl.Font = Enum.Font.GothamMedium
        sLbl.TextSize = 10
        sLbl.TextColor3 = Color3.fromRGB(0, 255, 210)
        sLbl.TextXAlignment = Enum.TextXAlignment.Left
        sLbl.ClipsDescendants = true
        sLbl.ZIndex = 55

        local pBtn = Instance.new("TextButton", row)
        pBtn.Size = UDim2.new(0, 62, 0, 26)
        pBtn.Position = UDim2.new(1, -70, 0.5, -13)
        pBtn.BackgroundColor3 = Color3.fromRGB(185, 0, 105)
        pBtn.Text = "▶ PLAY"
        pBtn.Font = Enum.Font.GothamBold
        pBtn.TextSize = 10
        pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pBtn.BorderSizePixel = 0
        pBtn.ZIndex = 58
        Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
        bs.AttachBossInteractions(pBtn, 1.08)

        pBtn.MouseButton1Click:Connect(function()
            if not loadingActive then currentQueueIndex = idx; playSelectedQueueIndex() end
        end)
    end

    local activeSearchId = 0
    local function runMusicSearch()
        local query = SearchInput.Text:match("^%s*(.-)%s*$")
        if query == "" or loadingActive then return end
        activeSearchId = activeSearchId + 1
        local myId = activeSearchId
        StatusText.Text = "🔍 Searching '" .. query .. "'..."
        StatusText.TextColor3 = Color3.fromRGB(255, 0, 127)
        for _, ch in pairs(ResultsScroll:GetChildren()) do
            if ch:IsA("Frame") or ch:IsA("TextLabel") then ch:Destroy() end
        end
        sessionQueue = {}

        task.spawn(function()
            local ok, tracks, provider = bs.SearchMusicTracks(query)
            if activeSearchId ~= myId then return end
            if ok and #tracks > 0 then
                for idx, tr in ipairs(tracks) do
                    table.insert(sessionQueue, tr)
                    renderSongCard(tr.title, tr.channel, tr.duration, idx)
                end
                StatusText.Text = "✅ Loaded " .. #tracks .. " tracks via " .. tostring(provider)
                StatusText.TextColor3 = Color3.fromRGB(0, 255, 255)
            else
                StatusText.Text = "❌ " .. tostring(provider)
                StatusText.TextColor3 = Color3.fromRGB(255, 70, 110)
            end
        end)
    end

    SearchTabBtn.MouseButton1Click:Connect(function()
        if loadingActive then return end
        SearchBar.Visible = true
        ResultsScroll.Position = UDim2.new(0, 12, 0, 80)
        ResultsScroll.Size = UDim2.new(1, -24, 1, -86)
        SearchTabBtn.BackgroundColor3 = Color3.fromRGB(75, 30, 150)
        FavTabBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
        for _, ch in pairs(ResultsScroll:GetChildren()) do
            if ch:IsA("Frame") or ch:IsA("TextLabel") then ch:Destroy() end
        end
        StatusText.Text = "Search Engine Ready."
    end)

    FavTabBtn.MouseButton1Click:Connect(function()
        if loadingActive then return end
        SearchBar.Visible = false
        ResultsScroll.Position = UDim2.new(0, 12, 0, 42)
        ResultsScroll.Size = UDim2.new(1, -24, 1, -48)
        FavTabBtn.BackgroundColor3 = Color3.fromRGB(75, 30, 150)
        SearchTabBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
        for _, ch in pairs(ResultsScroll:GetChildren()) do
            if ch:IsA("Frame") or ch:IsA("TextLabel") then ch:Destroy() end
        end
        sessionQueue = {}
        local favs = getSavedFavorites()
        if #favs == 0 then
            local empty = Instance.new("TextLabel", ResultsScroll)
            empty.Size = UDim2.new(1, 0, 0, 50)
            empty.BackgroundTransparency = 1
            empty.Text = "⭐ No favorite tracks saved yet."
            empty.Font = Enum.Font.GothamMedium
            empty.TextSize = 11
            empty.TextColor3 = Color3.fromRGB(150, 130, 180)
            empty.ZIndex = 55
            return
        end
        for idx, it in ipairs(favs) do
            table.insert(sessionQueue, it)
            renderSongCard(it.title, it.channel, it.duration, idx)
        end
        StatusText.Text = "⭐ Loaded " .. #favs .. " favorite tracks."
        StatusText.TextColor3 = Color3.fromRGB(0, 255, 255)
    end)

    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ResultsScroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 12)
    end)
    SearchBtn.MouseButton1Click:Connect(runMusicSearch)
    SearchInput.FocusLost:Connect(function(enter) if enter then runMusicSearch() end end)
end

-- ========================================================================= --
-- [SUB-BUILDER 4 : STICKER TRAY & IMAGE VAULT TRAY]
-- ========================================================================= --
function bs.BuildStickerAndVaultTrays(cG, ae)
    local dq = Instance.new("Frame", cG)
    dq.Name = "StickerTray"
    dq.Size = UDim2.new(1, -20, 0, 230)
    dq.Position = UDim2.new(0, 10, 1, -(bs.Layout.NavH + 278))
    dq.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    dq.Visible = false
    dq.ZIndex = 70
    Instance.new("UICorner", dq).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", dq).Color = ae.Accent
    bs.UI.StickerTray = dq

    local ds = Instance.new("Frame", dq)
    ds.Size = UDim2.new(1, -16, 0, 30)
    ds.Position = UDim2.new(0, 8, 0, 8)
    ds.BackgroundTransparency = 1
    ds.ZIndex = 71

    local dt = Instance.new("TextButton", ds)
    dt.Size = UDim2.new(0.5, -4, 1, 0)
    dt.BackgroundColor3 = ae.Accent
    dt.Font = Enum.Font.GothamBold
    dt.TextSize = 11
    dt.TextColor3 = ae.SendText
    dt.Text = "All Stickers"
    dt.ZIndex = 72
    Instance.new("UICorner", dt).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(dt, 1.05)

    local du = Instance.new("TextButton", ds)
    du.Size = UDim2.new(0.5, -4, 1, 0)
    du.Position = UDim2.new(0.5, 4, 0, 0)
    du.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    du.Font = Enum.Font.GothamBold
    du.TextSize = 11
    du.TextColor3 = Color3.fromRGB(200, 200, 215)
    du.Text = "⭐ Favorites"
    du.ZIndex = 72
    Instance.new("UICorner", du).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(du, 1.05)

    local dv = Instance.new("ScrollingFrame", dq)
    dv.Size = UDim2.new(1, -16, 1, -50)
    dv.Position = UDim2.new(0, 8, 0, 42)
    dv.BackgroundTransparency = 1
    dv.ScrollBarThickness = 2
    dv.ZIndex = 71
    local dw = Instance.new("UIGridLayout", dv)
    dw.CellSize = UDim2.new(0, 52, 0, 52)
    dw.CellPadding = UDim2.new(0, 8, 0, 8)
    dw.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Instance.new("UIPadding", dv).PaddingTop = UDim.new(0, 4)

    local dx = "All"
    local function dy()
        for _, aK in pairs(dv:GetChildren()) do
            if aK:IsA("ImageButton") or aK:IsA("TextLabel") then aK:Destroy() end
        end
        local dz = dx == "Favs" and bs.FavStickers or aF
        dv.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#dz / 6) * 60)

        if #dz == 0 and dx == "Favs" then
            local dA = Instance.new("TextLabel", dv)
            dA.Size = UDim2.new(1, 0, 1, 0)
            dA.BackgroundTransparency = 1
            dA.Text = "No favorite stickers yet!\nClick the ⭐ to add."
            dA.TextColor3 = Color3.fromRGB(150, 150, 165)
            dA.Font = Enum.Font.GothamMedium
            dA.TextSize = 11
            dA.ZIndex = 72
            return
        end

        for _, dB in ipairs(dz) do
            local dC = Instance.new("ImageButton", dv)
            dC.BackgroundTransparency = 1
            dC.ZIndex = 72
            dC.Image = "rbxthumb://type=Asset&id=" .. dB .. "&w=150&h=150"
            dC.ScaleType = Enum.ScaleType.Fit
            bs.AttachBossInteractions(dC, 1.08)

            local dD = Instance.new("TextButton", dC)
            dD.Size = UDim2.new(0, 16, 0, 16)
            dD.Position = UDim2.new(1, -16, 0, 0)
            dD.BackgroundTransparency = 1
            dD.Text = "⭐"
            dD.TextSize = 12
            dD.ZIndex = 73

            local function dE()
                local dF = false
                for _, d in ipairs(bs.FavStickers) do if d == dB then dF = true; break end end
                dD.TextTransparency = dF and 0 or 0.6
            end
            dE()

            dD.MouseButton1Click:Connect(function()
                local dG = nil
                for aV, d in ipairs(bs.FavStickers) do if d == dB then dG = aV; break end end
                if dG then table.remove(bs.FavStickers, dG) else table.insert(bs.FavStickers, dB) end
                br(bs.FavStickers); dE()
                if dx == "Favs" then dy() end
            end)

            dC.MouseButton1Click:Connect(function()
                local tDiff = os.clock() - bs.LastSendTime
                if tDiff < 3.0 and (bs.Mode == "Server" or bs.Mode == "DM") then
                    task.spawn(function()
                        local op = bs.UI.InputWrapper.Position
                        for idx = 1, 6 do bs.UI.InputWrapper.Position = op + UDim2.new(0, idx % 2 == 0 and 6 or -6, 0, 0); task.wait(0.03) end
                        bs.UI.InputWrapper.Position = op
                    end)
                    return
                end
                bs.Send("[STICKER://" .. dB .. "]")
                bs.LastSendTime = os.clock()
                table.insert(bs.MessageTimestamps, os.clock())
                dq.Visible = false
            end)
        end
    end

    dt.MouseButton1Click:Connect(function()
        dx = "All"; dt.BackgroundColor3 = ae.Accent; dt.TextColor3 = ae.SendText
        du.BackgroundColor3 = Color3.fromRGB(35, 35, 48); du.TextColor3 = Color3.fromRGB(200, 200, 215); dy()
    end)
    du.MouseButton1Click:Connect(function()
        dx = "Favs"; du.BackgroundColor3 = ae.Accent; du.TextColor3 = ae.SendText
        dt.BackgroundColor3 = Color3.fromRGB(35, 35, 48); dt.TextColor3 = Color3.fromRGB(200, 200, 215); dy()
    end)
    dy()

    local dH = Instance.new("Frame", cG)
    dH.Name = "ImageVaultTray"
    dH.Size = UDim2.new(1, -20, 0, 220)
    dH.Position = UDim2.new(0, 10, 1, -(bs.Layout.NavH + 268))
    dH.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    dH.Visible = false
    dH.ZIndex = 75
    Instance.new("UICorner", dH).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", dH).Color = ae.Accent
    bs.UI.ImageTray = dH

    local dJ = Instance.new("Frame", dH)
    dJ.Size = UDim2.new(1, -16, 0, 32)
    dJ.Position = UDim2.new(0, 8, 0, 8)
    dJ.BackgroundTransparency = 1
    dJ.ZIndex = 76

    local dK = Instance.new("TextBox", dJ)
    dK.Size = UDim2.new(1, -100, 1, 0)
    dK.BackgroundColor3 = ae.InputBg
    dK.TextColor3 = ae.TextColor
    dK.Font = Enum.Font.GothamMedium
    dK.TextSize = 11
    dK.PlaceholderText = "Paste direct image URL..."
    dK.TextXAlignment = Enum.TextXAlignment.Left
    dK.ClearTextOnFocus = false
    dK.Text = ""
    dK.ZIndex = 77
    Instance.new("UICorner", dK).CornerRadius = UDim.new(0, 6)
    Instance.new("UIPadding", dK).PaddingLeft = UDim.new(0, 8)

    local dL = Instance.new("TextButton", dJ)
    dL.Size = UDim2.new(0, 60, 1, 0)
    dL.Position = UDim2.new(1, -95, 0, 0)
    dL.BackgroundColor3 = ae.Accent
    dL.Font = Enum.Font.GothamBold
    dL.TextSize = 11
    dL.TextColor3 = ae.SendText
    dL.Text = "📥 Save"
    dL.ZIndex = 77
    Instance.new("UICorner", dL).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(dL, 1.05)

    local dM = Instance.new("TextButton", dJ)
    dM.Size = UDim2.new(0, 30, 1, 0)
    dM.Position = UDim2.new(1, -30, 0, 0)
    dM.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    dM.Font = Enum.Font.GothamBold
    dM.TextSize = 12
    dM.TextColor3 = Color3.fromRGB(255, 255, 255)
    dM.Text = "X"
    dM.ZIndex = 77
    Instance.new("UICorner", dM).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(dM, 1.1)
    dM.MouseButton1Click:Connect(function() dH.Visible = false end)

    local dN = Instance.new("ScrollingFrame", dH)
    dN.Name = "VaultScroll"
    dN.Size = UDim2.new(1, -16, 1, -50)
    dN.Position = UDim2.new(0, 8, 0, 46)
    dN.BackgroundTransparency = 1
    dN.ScrollBarThickness = 2
    dN.ZIndex = 76
    local dO = Instance.new("UIGridLayout", dN)
    dO.CellSize = UDim2.new(0, 58, 0, 58)
    dO.CellPadding = UDim2.new(0, 8, 0, 8)

    dL.MouseButton1Click:Connect(function()
        local dP = dK.Text:match("^%s*(.-)%s*$")
        if not dP or dP == "" then return end
        dK.Text = ""
        local dQ = bo()
        for _, cw in ipairs(dQ) do
            if cw == dP then bs.TriggerToast("⚠️ Notice", "Already in vault", false); return end
        end
        table.insert(dQ, dP); bp(dQ)
        bs.TriggerToast("✅ Secure Vault", "Image saved!", false)
        bs.RefreshVaultUI()
    end)
end

-- ========================================================================= --
-- [SUB-BUILDER 5 : FULL ADMIN CONSOLE (TICKETS, ENTITLEMENTS, STORE & MOD)]
-- ========================================================================= --
function bs.BuildAdminConsole(cG, ae)
    -- Shared Modal Prompt Helper
    local function dW(dX, dY, dZ, d_)
        if cG:FindFirstChild("MatrixAdminModal") then cG.MatrixAdminModal:Destroy() end
        local e0 = Instance.new("Frame", cG)
        e0.Name = "MatrixAdminModal"
        e0.Size = UDim2.new(1, 0, 1, 0)
        e0.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        e0.BackgroundTransparency = 0.52
        e0.ZIndex = 130
        e0.Active = true

        local e1 = Instance.new("Frame", e0)
        e1.Size = UDim2.new(0, 290, 0, 155)
        e1.Position = UDim2.new(0.5, 0, 0.5, 0)
        e1.AnchorPoint = Vector2.new(0.5, 0.5)
        e1.BackgroundColor3 = ae.HeaderBg
        e1.ZIndex = 131
        Instance.new("UICorner", e1).CornerRadius = UDim.new(0, 12)
        Instance.new("UIStroke", e1).Color = ae.Accent

        local e3 = Instance.new("UIScale", e1)
        e3.Scale = 0.8
        g:Create(e3, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.0}):Play()

        local e4 = Instance.new("TextLabel", e1)
        e4.Size = UDim2.new(1, -20, 0, 26)
        e4.Position = UDim2.new(0, 10, 0, 10)
        e4.BackgroundTransparency = 1
        e4.Font = Enum.Font.GothamBold
        e4.TextSize = 12.5
        e4.TextColor3 = ae.TextColor
        e4.Text = dX
        e4.ZIndex = 132

        local e5 = Instance.new("TextBox", e1)
        e5.Size = UDim2.new(1, -24, 0, 34)
        e5.Position = UDim2.new(0, 12, 0, 44)
        e5.BackgroundColor3 = ae.InputBg
        e5.TextColor3 = ae.TextColor
        e5.Font = Enum.Font.GothamMedium
        e5.TextSize = 11.5
        e5.PlaceholderText = dY
        e5.PlaceholderColor3 = ae.SubText
        e5.ClearTextOnFocus = false
        e5.Text = ""
        e5.ZIndex = 132
        Instance.new("UICorner", e5).CornerRadius = UDim.new(0, 8)
        Instance.new("UIPadding", e5).PaddingLeft = UDim.new(0, 8)

        local e6 = Instance.new("TextButton", e1)
        e6.Size = UDim2.new(0.45, 0, 0, 34)
        e6.Position = UDim2.new(0, 12, 1, -44)
        e6.BackgroundColor3 = ae.Accent
        e6.Font = Enum.Font.GothamBold
        e6.TextSize = 11
        e6.TextColor3 = ae.SendText
        e6.Text = dZ
        e6.ZIndex = 132
        Instance.new("UICorner", e6).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(e6, 1.05)

        local e7 = Instance.new("TextButton", e1)
        e7.Size = UDim2.new(0.45, 0, 0, 34)
        e7.Position = UDim2.new(0.52, 0, 1, -44)
        e7.BackgroundColor3 = Color3.fromRGB(65, 65, 78)
        e7.Font = Enum.Font.GothamBold
        e7.TextSize = 11
        e7.TextColor3 = Color3.fromRGB(255, 255, 255)
        e7.Text = "Cancel"
        e7.ZIndex = 132
        Instance.new("UICorner", e7).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(e7, 1.05)

        e7.MouseButton1Click:Connect(function() e0:Destroy() end)
        e6.MouseButton1Click:Connect(function()
            local e8 = e5.Text:match("^%s*(.-)%s*$")
            if e8 and e8 ~= "" then
                e0:Destroy()
                task.spawn(function() d_(e8) end)
            end
        end)
    end
    bs.PromptInput = dW

    local d4 = Instance.new("Frame", cG)
    d4.Name = "AdminSettingsConsole"
    d4.Size = UDim2.new(1, -16, 1, -(bs.Layout.HeaderH + bs.Layout.NavH + 12))
    d4.Position = UDim2.new(0, 8, 0, bs.Layout.HeaderH + 6)
    d4.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
    d4.Visible = false
    d4.ZIndex = 90
    Instance.new("UICorner", d4).CornerRadius = UDim.new(0, 14)
    Instance.new("UIStroke", d4).Color = Color3.fromRGB(255, 205, 55)
    bs.UI.AdminTray = d4

    local dS = Instance.new("TextLabel", d4)
    dS.Size = UDim2.new(1, -48, 0, 28)
    dS.Position = UDim2.new(0, 12, 0, 6)
    dS.BackgroundTransparency = 1
    dS.Font = Enum.Font.GothamBold
    dS.TextSize = 12.5
    dS.TextColor3 = Color3.fromRGB(255, 212, 75)
    dS.TextXAlignment = Enum.TextXAlignment.Left
    dS.Text = "👑 ADMIN ELITE CONTROL CENTER"
    dS.ZIndex = 92

    local dT = Instance.new("TextButton", d4)
    dT.Size = UDim2.new(0, 24, 0, 24)
    dT.Position = UDim2.new(1, -30, 0, 8)
    dT.BackgroundColor3 = Color3.fromRGB(185, 40, 50)
    dT.Text = "X"
    dT.Font = Enum.Font.GothamBold
    dT.TextSize = 11
    dT.TextColor3 = Color3.fromRGB(255, 255, 255)
    dT.ZIndex = 92
    Instance.new("UICorner", dT).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(dT, 1.1)
    dT.MouseButton1Click:Connect(function() d4.Visible = false end)

    -- 4 Sub-Tabs: Tickets | Entitlements | Store Config | Moderation
    local tabBar = Instance.new("Frame", d4)
    tabBar.Size = UDim2.new(1, -16, 0, 26)
    tabBar.Position = UDim2.new(0, 8, 0, 36)
    tabBar.BackgroundTransparency = 1
    tabBar.ZIndex = 92

    local tLay = Instance.new("UIListLayout", tabBar)
    tLay.FillDirection = Enum.FillDirection.Horizontal
    tLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tLay.Padding = UDim.new(0, 4)
    tLay.SortOrder = Enum.SortOrder.LayoutOrder

    local dU = Instance.new("ScrollingFrame", d4)
    dU.Size = UDim2.new(1, -16, 1, -72)
    dU.Position = UDim2.new(0, 8, 0, 66)
    dU.BackgroundTransparency = 1
    dU.ScrollBarThickness = 2
    dU.ZIndex = 91
    local dV = Instance.new("UIListLayout", dU)
    dV.Padding = UDim.new(0, 7)
    dV.HorizontalAlignment = Enum.HorizontalAlignment.Center
    dV.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", dU).PaddingTop = UDim.new(0, 3)
    dV:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dU.CanvasSize = UDim2.new(0, 0, 0, dV.AbsoluteContentSize.Y + 18)
    end)

    local adminTab = "Tickets"
    local tabBtns = {}

    local function addAdminCard(title, sub, btnText, col, onClick)
        local ee = Instance.new("Frame", dU)
        ee.Size = UDim2.new(1, -6, 0, 48)
        ee.BackgroundColor3 = Color3.fromRGB(20, 20, 34)
        ee.ZIndex = 92
        Instance.new("UICorner", ee).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", ee).Color = Color3.fromRGB(48, 50, 72)

        local ef = Instance.new("TextLabel", ee)
        ef.Size = UDim2.new(0.64, 0, 0, 18)
        ef.Position = UDim2.new(0, 10, 0, 6)
        ef.BackgroundTransparency = 1
        ef.Font = Enum.Font.GothamBold
        ef.TextSize = 11
        ef.TextColor3 = Color3.fromRGB(245, 245, 255)
        ef.TextXAlignment = Enum.TextXAlignment.Left
        ef.ClipsDescendants = true
        ef.Text = title
        ef.ZIndex = 93

        local eg = Instance.new("TextLabel", ee)
        eg.Size = UDim2.new(0.64, 0, 0, 16)
        eg.Position = UDim2.new(0, 10, 0, 25)
        eg.BackgroundTransparency = 1
        eg.Font = Enum.Font.GothamMedium
        eg.TextSize = 9.5
        eg.TextColor3 = Color3.fromRGB(155, 160, 188)
        eg.TextXAlignment = Enum.TextXAlignment.Left
        eg.ClipsDescendants = true
        eg.Text = sub
        eg.ZIndex = 93

        local eh = Instance.new("TextButton", ee)
        eh.Size = UDim2.new(0.31, 0, 0, 30)
        eh.Position = UDim2.new(0.67, 0, 0.5, -15)
        eh.BackgroundColor3 = col
        eh.Font = Enum.Font.GothamBold
        eh.TextSize = 10
        eh.TextColor3 = Color3.fromRGB(255, 255, 255)
        eh.Text = btnText
        eh.ZIndex = 93
        Instance.new("UICorner", eh).CornerRadius = UDim.new(0, 6)
        bs.AttachBossInteractions(eh, 1.05)
        eh.MouseButton1Click:Connect(onClick)
    end

    local function renderAdminTab()
        for kTab, b in pairs(tabBtns) do
            b.BackgroundColor3 = (kTab == adminTab) and Color3.fromRGB(165, 50, 235) or Color3.fromRGB(24, 24, 38)
            b.TextColor3 = (kTab == adminTab) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(175, 180, 205)
        end
        for _, ch in pairs(dU:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end

        if adminTab == "Tickets" then
            addAdminCard("🔄 REFRESH TICKETS", "Check pending ₹300 Elite Pass verifications", "REFRESH", Color3.fromRGB(0, 165, 215), function()
                renderAdminTab()
            end)

            local loadLbl = Instance.new("TextLabel", dU)
            loadLbl.Size = UDim2.new(1, 0, 0, 34)
            loadLbl.BackgroundTransparency = 1
            loadLbl.Font = Enum.Font.GothamMedium
            loadLbl.TextSize = 11
            loadLbl.TextColor3 = Color3.fromRGB(0, 225, 255)
            loadLbl.Text = "◐ Fetching payment verification tickets..."
            loadLbl.ZIndex = 93

            task.spawn(function()
                local reqs = bs.SocialEngine.AdminFetchPurchaseRequests()
                if loadLbl and loadLbl.Parent then loadLbl:Destroy() end
                if adminTab ~= "Tickets" then return end

                local pendingShown = 0
                for _, reqObj in ipairs(reqs) do
                    if reqObj.status == "pending_verification" then
                        pendingShown = pendingShown + 1
                        local card = Instance.new("Frame", dU)
                        card.Size = UDim2.new(1, -6, 0, 74)
                        card.BackgroundColor3 = Color3.fromRGB(24, 20, 38)
                        card.ZIndex = 92
                        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
                        Instance.new("UIStroke", card).Color = Color3.fromRGB(255, 205, 55)

                        local info = Instance.new("TextLabel", card)
                        info.Size = UDim2.new(1, -16, 0, 36)
                        info.Position = UDim2.new(0, 8, 0, 4)
                        info.BackgroundTransparency = 1
                        info.Font = Enum.Font.GothamMedium
                        info.TextSize = 10
                        info.TextColor3 = Color3.fromRGB(245, 245, 255)
                        info.TextXAlignment = Enum.TextXAlignment.Left
                        info.TextWrapped = true
                        info.RichText = true
                        info.ZIndex = 93
                        info.Text = string.format("<b>@%s</b> (%s) • ₹%s %s\n<font color='#00E5FF'>Discord: %s</font> • %s",
                            tostring(reqObj.username), tostring(reqObj.uid), tostring(reqObj.priceINR or 300),
                            tostring(reqObj.itemId), tostring(reqObj.discordUser), tostring(reqObj.note or ""))

                        local appBtn = Instance.new("TextButton", card)
                        appBtn.Size = UDim2.new(0.46, 0, 0, 24)
                        appBtn.Position = UDim2.new(0.02, 0, 1, -29)
                        appBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 115)
                        appBtn.Font = Enum.Font.GothamBold
                        appBtn.TextSize = 10
                        appBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        appBtn.Text = "✓ VERIFY & GRANT"
                        appBtn.ZIndex = 93
                        Instance.new("UICorner", appBtn).CornerRadius = UDim.new(0, 6)
                        appBtn.MouseButton1Click:Connect(function()
                            task.spawn(function()
                                local ok, msg = bs.SocialEngine.AdminApprovePurchaseRequest(reqObj)
                                bs.TriggerToast(ok and "✅ Verified" or "⚠️ Error", msg, false)
                                renderAdminTab()
                            end)
                        end)

                        local rejBtn = Instance.new("TextButton", card)
                        rejBtn.Size = UDim2.new(0.46, 0, 0, 24)
                        rejBtn.Position = UDim2.new(0.52, 0, 1, -29)
                        rejBtn.BackgroundColor3 = Color3.fromRGB(175, 42, 55)
                        rejBtn.Font = Enum.Font.GothamBold
                        rejBtn.TextSize = 10
                        rejBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        rejBtn.Text = "✕ REJECT"
                        rejBtn.ZIndex = 93
                        Instance.new("UICorner", rejBtn).CornerRadius = UDim.new(0, 6)
                        rejBtn.MouseButton1Click:Connect(function()
                            task.spawn(function()
                                bs.SocialEngine.AdminRejectPurchaseRequest(reqObj)
                                bs.TriggerToast("❌ Rejected", "Ticket marked rejected", false)
                                renderAdminTab()
                            end)
                        end)
                    end
                end
                if pendingShown == 0 then
                    local empty = Instance.new("TextLabel", dU)
                    empty.Size = UDim2.new(1, 0, 0, 44)
                    empty.BackgroundTransparency = 1
                    empty.Font = Enum.Font.GothamMedium
                    empty.TextSize = 11
                    empty.TextColor3 = Color3.fromRGB(150, 155, 185)
                    empty.Text = "📭 No pending purchase verification tickets."
                    empty.ZIndex = 93
                end
            end)

        elseif adminTab == "Entitlements" then
            addAdminCard("👑 GRANT ₹300 ELITE PASS", "Unlocks all auras, themes & VIP badge for user", "GRANT PASS", Color3.fromRGB(215, 150, 20), function()
                dW("👑 GRANT ELITE PASS", "Username or User ID...", "Grant Pass", function(val)
                    local res = bs.ResolveUserInput(val)
                    if not res then bs.TriggerToast("⚠️ Error", "User not found", false); return end
                    local ok, msg = bs.SocialEngine.AdminSetElitePass(res.UserId, true)
                    bs.TriggerToast(ok and "👑 Granted" or "⚠️ Error", msg, false)
                end)
            end)
            addAdminCard("✖ REVOKE ELITE PASS", "Removes premium pass entitlement from user", "REVOKE PASS", Color3.fromRGB(175, 40, 52), function()
                dW("✖ REVOKE ELITE PASS", "Username or User ID...", "Revoke", function(val)
                    local res = bs.ResolveUserInput(val)
                    if not res then bs.TriggerToast("⚠️ Error", "User not found", false); return end
                    local ok, msg = bs.SocialEngine.AdminSetElitePass(res.UserId, false)
                    bs.TriggerToast(ok and "✖ Revoked" or "⚠️ Error", msg, false)
                end)
            end)
            addAdminCard("✨ GRANT SINGLE DECORATION", "Format: UserId:royal_gold (or galaxy_king etc.)", "GRANT AURA", Color3.fromRGB(130, 55, 225), function()
                dW("✨ GRANT DECORATION", "UserId:decorId (e.g. 12345:royal_gold)", "Grant", function(val)
                    local uStr, item = val:match("^(%S+):(%S+)$")
                    local res = uStr and bs.ResolveUserInput(uStr) or nil
                    if not res or not item then bs.TriggerToast("⚠️ Format", "Use UserId:decorId", false); return end
                    local ok, msg = bs.SocialEngine.AdminSetUserItemOwnership(res.UserId, "decoration", item, true)
                    bs.TriggerToast(ok and "✨ Granted" or "⚠️ Error", msg, false)
                end)
            end)
            addAdminCard("🎨 GRANT SINGLE THEME", "Format: UserId:cyberpunk_neon / blood_moon", "GRANT THEME", Color3.fromRGB(0, 155, 210), function()
                dW("🎨 GRANT THEME", "UserId:themeId (e.g. 12345:blood_moon)", "Grant", function(val)
                    local uStr, item = val:match("^(%S+):(%S+)$")
                    local res = uStr and bs.ResolveUserInput(uStr) or nil
                    if not res or not item then bs.TriggerToast("⚠️ Format", "Use UserId:themeId", false); return end
                    local ok, msg = bs.SocialEngine.AdminSetUserItemOwnership(res.UserId, "theme", item, true)
                    bs.TriggerToast(ok and "🎨 Granted" or "⚠️ Error", msg, false)
                end)
            end)
            addAdminCard("💎 GRANT / REVOKE BADGE", "Format: UserId:VIP / LEGEND / OG / ELITE", "GRANT BADGE", Color3.fromRGB(0, 175, 125), function()
                dW("💎 GRANT BADGE", "UserId:BADGE (VIP/LEGEND/OG/ELITE)", "Grant", function(val)
                    local uStr, bName = val:match("^(%S+):(%a+)$")
                    local res = uStr and bs.ResolveUserInput(uStr) or nil
                    if not res or not bName or not bs.BadgeCatalog[bName:upper()] then bs.TriggerToast("⚠️ Format", "Use UserId:VIP", false); return end
                    local ok, msg = bs.SocialEngine.AdminSetUserItemOwnership(res.UserId, "badge", bName:upper(), true)
                    bs.TriggerToast(ok and "💎 Granted" or "⚠️ Error", msg, false)
                end)
            end)

        elseif adminTab == "Store" then
            addAdminCard("💰 ELITE PASS PRICE (₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. ")", "Configure official INR price shown in Store", "SET PRICE", Color3.fromRGB(210, 145, 20), function()
                dW("💰 SET ELITE PASS PRICE (₹)", "Enter amount (e.g. 300)...", "Save Price", function(val)
                    local num = tonumber(val)
                    if not num or num < 1 then bs.TriggerToast("⚠️ Error", "Valid INR number required", false); return end
                    bs.Social.StoreConfig.elitePassPriceINR = math.floor(num)
                    local ok, msg = bs.SocialEngine.AdminSaveStoreConfig()
                    bs.TriggerToast(ok and "✅ Saved" or "⚠️ Error", msg, false)
                    renderAdminTab()
                end)
            end)
            addAdminCard("💬 DISCORD CONTACT", "Current: " .. tostring(bs.Social.StoreConfig.discordServer), "EDIT DISCORD", Color3.fromRGB(88, 101, 242), function()
                dW("💬 SET OFFICIAL DISCORD", "Discord server / handle text...", "Save", function(val)
                    bs.Social.StoreConfig.discordServer = val
                    local ok, msg = bs.SocialEngine.AdminSaveStoreConfig()
                    bs.TriggerToast(ok and "✅ Saved" or "⚠️ Error", msg, false)
                    renderAdminTab()
                end)
            end)
            addAdminCard("➕ ADD NEW CUSTOM ITEM", "Format: decoration|id|Name|300 or theme|id|Name|300", "ADD ITEM", Color3.fromRGB(0, 175, 130), function()
                dW("➕ ADD PREMIUM ITEM", "decoration|cyber_nova|Cyber Nova|300", "Add Item", function(val)
                    local kind, idKey, iName, pr = val:match("^(%a+)|([%w_]+)|([^|]+)|(%d+)$")
                    if not (kind and idKey and iName and tonumber(pr)) then
                        bs.TriggerToast("⚠️ Format", "Use decoration|id|Name|300", false); return
                    end
                    bs.Social.StoreConfig.customItems[idKey] = {
                        kind = kind:lower(),
                        name = iName,
                        priceINR = tonumber(pr),
                        r1 = 0, g1 = 235, b1 = 255,
                        r2 = 255, g2 = 60, b2 = 185,
                        description = "Admin Exclusive Custom Item"
                    }
                    local ok, msg = bs.SocialEngine.AdminSaveStoreConfig()
                    bs.TriggerToast(ok and "✅ Added" or "⚠️ Error", msg, false)
                    renderAdminTab()
                end)
            end)
            addAdminCard("🏷️ SET ITEM PRICE OVERRIDE", "Format: dec_royal_gold:300 or thm_blood_moon:0", "SET ITEM ₹", Color3.fromRGB(150, 55, 225), function()
                dW("🏷️ ITEM PRICE OVERRIDE", "dec_royal_gold:300 or thm_blood_moon:0", "Save", function(val)
                    local key, pr = val:match("^([%w_]+):(%d+)$")
                    if not key or not tonumber(pr) then bs.TriggerToast("⚠️ Format", "Use dec_id:price or thm_id:price", false); return end
                    bs.Social.StoreConfig.priceOverrides[key] = tonumber(pr)
                    local ok, msg = bs.SocialEngine.AdminSaveStoreConfig()
                    bs.TriggerToast(ok and "✅ Saved" or "⚠️ Error", msg, false)
                end)
            end)

            -- Quick Enable / Disable toggles for Decorations & Themes
            for _, dItem in ipairs(bs.SocialEngine.GetAllDecorations(true)) do
                local en = bs.SocialEngine.IsDecorationEnabled(dItem.id)
                addAdminCard("✨ Aura: " .. dItem.name, "ID: " .. dItem.id .. " • " .. (en and "Active" or "Disabled"), en and "DISABLE" or "ENABLE", en and Color3.fromRGB(145, 45, 60) or Color3.fromRGB(0, 165, 115), function()
                    bs.Social.StoreConfig.disabledDecorations[dItem.id] = en and true or nil
                    task.spawn(function()
                        bs.SocialEngine.AdminSaveStoreConfig()
                        renderAdminTab()
                    end)
                end)
            end
            for _, tItem in ipairs(bs.SocialEngine.GetAllThemes(true)) do
                local en = bs.SocialEngine.IsThemeEnabled(tItem.id)
                addAdminCard("🎨 Theme: " .. tItem.name, "ID: " .. tItem.id .. " • " .. (en and "Active" or "Disabled"), en and "DISABLE" or "ENABLE", en and Color3.fromRGB(145, 45, 60) or Color3.fromRGB(0, 165, 115), function()
                    bs.Social.StoreConfig.disabledThemes[tItem.id] = en and true or nil
                    task.spawn(function()
                        bs.SocialEngine.AdminSaveStoreConfig()
                        renderAdminTab()
                    end)
                end)
            end

        elseif adminTab == "Mod" then
            addAdminCard("🎵 GRANT SERVER DJ", "Allows target to play Server Sync music", "GRANT DJ", Color3.fromRGB(175, 110, 15), function()
                dW("🎵 GRANT SERVER DJ", "Exact Username...", "Grant DJ", function(cw) bs.DispatchGodCommand("GRANT_DJ:" .. cw:gsub("^@", ""):lower()) end)
            end)
            addAdminCard("🔇 REVOKE SERVER DJ", "Removes Server Sync music access", "REVOKE DJ", Color3.fromRGB(120, 50, 50), function()
                dW("🔇 REVOKE SERVER DJ", "Exact Username...", "Revoke DJ", function(cw) bs.DispatchGodCommand("REVOKE_DJ:" .. cw:gsub("^@", ""):lower()) end)
            end)
            addAdminCard("🔨 EXECUTE HWID BAN", "Permanently restricts device HWID & User", "BAN USER", Color3.fromRGB(190, 40, 40), function()
                dW("🔨 HARDWARE BAN USER", "Exact Username...", "Execute Ban", function(cw) bs.DispatchGodCommand("BAN_USER:" .. cw:lower()) end)
            end)
            addAdminCard("✅ PARDON / UNBAN", "Removes permanent restriction", "UNBAN", Color3.fromRGB(40, 140, 200), function()
                dW("✅ UNBAN ACCOUNT", "Exact Username...", "Revoke Ban", function(cw) bs.DispatchGodCommand("UNBAN_USER:" .. cw:lower()) end)
            end)
            addAdminCard("🔒 LOCK CHAT", "Disables message input box for user", "LOCK CHAT", Color3.fromRGB(210, 110, 20), function()
                dW("🔒 SUSPEND CHAT", "Exact Username...", "Lock Chat", function(cw) bs.DispatchGodCommand("LOCK_CHAT:" .. cw:lower()) end)
            end)
            addAdminCard("🔓 RESTORE ACCESS", "Re-enables chat input box for user", "UNLOCK", Color3.fromRGB(30, 160, 80), function()
                dW("🔓 RESTORE ACCESS", "Exact Username...", "Unlock Chat", function(cw) bs.DispatchGodCommand("UNLOCK_CHAT:" .. cw:lower()) end)
            end)
            addAdminCard("👻 GHOST MUTE", "Silently hides target's messages", "SHADOW MUTE", Color3.fromRGB(130, 40, 190), function()
                dW("👻 SHADOW MUTE", "Exact Username...", "Mute", function(cw) bs.DispatchGodCommand("SHADOW_MUTE:" .. cw:lower()) end)
            end)
            addAdminCard("👁️ SPECTATE CAM", "Locally attaches camera to target", "SPY CAM", Color3.fromRGB(40, 60, 210), function()
                dW("👁️ SPECTATE PLAYER", "Exact Username in server...", "Attach Cam", function(cw) bs.ToggleSpyMode(cw) end)
            end)

            local ei = Instance.new("TextBox", dU)
            ei.Size = UDim2.new(1, -8, 0, 32)
            ei.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
            ei.TextColor3 = Color3.fromRGB(245, 245, 255)
            ei.Font = Enum.Font.GothamMedium
            ei.TextSize = 11
            ei.PlaceholderText = "Type Keyword to Mute/Unmute..."
            ei.PlaceholderColor3 = Color3.fromRGB(130, 135, 160)
            ei.TextXAlignment = Enum.TextXAlignment.Left
            ei.ClearTextOnFocus = false
            ei.Text = ""
            ei.ZIndex = 92
            Instance.new("UICorner", ei).CornerRadius = UDim.new(0, 6)
            Instance.new("UIPadding", ei).PaddingLeft = UDim.new(0, 8)

            local ej = Instance.new("Frame", dU)
            ej.Size = UDim2.new(1, -8, 0, 30)
            ej.BackgroundTransparency = 1
            ej.ZIndex = 92

            local ek = Instance.new("TextButton", ej)
            ek.Size = UDim2.new(0.48, 0, 1, 0)
            ek.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
            ek.Text = "🔇 MUTE KEYWORD"
            ek.Font = Enum.Font.GothamBold
            ek.TextSize = 10
            ek.TextColor3 = Color3.fromRGB(255, 255, 255)
            ek.ZIndex = 93
            Instance.new("UICorner", ek).CornerRadius = UDim.new(0, 6)
            ek.MouseButton1Click:Connect(function()
                local kw = ei.Text:lower():match("^%s*(.-)%s*$")
                if kw and kw ~= "" then bs.DispatchGodCommand("MUTE_KEYWORD:" .. kw); ei.Text = "" end
            end)

            local el = Instance.new("TextButton", ej)
            el.Size = UDim2.new(0.48, 0, 1, 0)
            el.Position = UDim2.new(0.52, 0, 0, 0)
            el.BackgroundColor3 = Color3.fromRGB(40, 150, 80)
            el.Text = "🔊 UNMUTE KEYWORD"
            el.Font = Enum.Font.GothamBold
            el.TextSize = 10
            el.TextColor3 = Color3.fromRGB(255, 255, 255)
            el.ZIndex = 93
            Instance.new("UICorner", el).CornerRadius = UDim.new(0, 6)
            el.MouseButton1Click:Connect(function()
                local kw = ei.Text:lower():match("^%s*(.-)%s*$")
                if kw and kw ~= "" then bs.DispatchGodCommand("UNMUTE_KEYWORD:" .. kw); ei.Text = "" end
            end)
        end
    end

    local tabDefs = {
        {id = "Tickets",      lbl = "🧾 Tickets",   ord = 1},
        {id = "Entitlements", lbl = "👑 Premium",   ord = 2},
        {id = "Store",        lbl = "🛒 Store Cfg", ord = 3},
        {id = "Mod",          lbl = "🛡️ Mod",       ord = 4}
    }
    for _, td in ipairs(tabDefs) do
        local tb = Instance.new("TextButton", tabBar)
        tb.Size = UDim2.new(0.242, 0, 1, 0)
        tb.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
        tb.Font = Enum.Font.GothamBold
        tb.TextSize = 9.5
        tb.TextColor3 = Color3.fromRGB(185, 190, 215)
        tb.Text = td.lbl
        tb.LayoutOrder = td.ord
        tb.ZIndex = 93
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
        tb.MouseButton1Click:Connect(function()
            adminTab = td.id
            renderAdminTab()
        end)
        tabBtns[td.id] = tb
    end

    bs.OpenAdminConsole = function()
        if not au() then return end
        bs.SwitchMode("Server")
        d4.Visible = true
        renderAdminTab()
    end

    if au() and bs.AddSettingsRow then
        bs.AddSettingsRow("Admin Console (Verify ₹300 & Store)", "⚡", nil, function()
            bs.OpenAdminConsole()
        end)
    end
end

-- ========================================================================= --
-- [MAIN SHELL BUILDER : CALLS ALL MODULAR SUB-BUILDERS CLEANLY]
-- ========================================================================= --
function bs.BuildMasterUI()
    local ae = bL[bs.CurrentTheme] or bL.PureBlack

    local cE = Instance.new("ImageButton", bQ)
    cE.Name = "MatrixMovableToggle"
    cE.Size = UDim2.new(0, 46, 0, 46)
    cE.Position = UDim2.new(0, 20, 0.4, -23)
    cE.Image = "rbxthumb://type=Asset&id=88879794421294&w=150&h=150"
    cE.ScaleType = Enum.ScaleType.Crop
    cE.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
    cE.Active = true
    cE.Draggable = true
    cE.ZIndex = 1500
    Instance.new("UICorner", cE).CornerRadius = UDim.new(1, 0)
    local cF = Instance.new("UIStroke", cE)
    cF.Color = ae.Accent
    cF.Thickness = 1.8
    bs.AttachBossInteractions(cE, 1.1)

    local cG = Instance.new("CanvasGroup", bQ)
    cG.Name = "MatrixMainFrame"
    cG.Size = UDim2.new(0, 468, 0, 404)
    cG.AnchorPoint = Vector2.new(0.5, 0.5)
    cG.Position = UDim2.new(0.5, 0, 0.5, 0)
    cG.BackgroundColor3 = ae.MainBg
    cG.BackgroundTransparency = ae.BgTrans
    cG.Visible = true
    cG.Active = true
    cG.Draggable = true
    Instance.new("UICorner", cG).CornerRadius = UDim.new(0, 16)
    local cH = Instance.new("UIStroke", cG)
    cH.Color = ae.StrokeColor
    cH.Thickness = 2

    local cG_isTog = false
    cE.MouseButton1Click:Connect(function()
        if cG_isTog then return end
        cG_isTog = true
        if cG.Visible then
            local tw = g:Create(cG, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {GroupTransparency = 1})
            tw:Play()
            task.delay(0.22, function() cG.Visible = false; cG_isTog = false end)
        else
            cG.GroupTransparency = 1
            cG.Visible = true
            g:Create(cG, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {GroupTransparency = 0}):Play()
            if bs.Mode == "Server" or bs.Mode == "DM" then bs.HandleScroll(true) end
            task.delay(0.22, function() cG_isTog = false end)
        end
    end)

    -- TOP HEADER
    local cJ = Instance.new("Frame", cG)
    cJ.Name = "CleanHeader"
    cJ.Size = UDim2.new(1, 0, 0, bs.Layout.HeaderH)
    cJ.BackgroundColor3 = ae.HeaderBg
    cJ.BackgroundTransparency = ae.HeadTrans
    cJ.BorderSizePixel = 0
    cJ.ZIndex = 20
    Instance.new("UICorner", cJ).CornerRadius = UDim.new(0, 14)

    local headerDivider = Instance.new("Frame", cJ)
    headerDivider.Size = UDim2.new(1, 0, 0, 1)
    headerDivider.Position = UDim2.new(0, 0, 1, -1)
    headerDivider.BackgroundColor3 = ae.StrokeColor
    headerDivider.BackgroundTransparency = 0.4
    headerDivider.BorderSizePixel = 0
    headerDivider.ZIndex = 21

    local drgT, drgS, drgP = false, nil, nil
    cJ.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            drgT = true; drgS = ip.Position; drgP = cG.Position
            ip.Changed:Connect(function() if ip.UserInputState == Enum.UserInputState.End then drgT = false end end)
        end
    end)
    bs.TrackConn(i.InputChanged:Connect(function(ip)
        if drgT and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
            local dl = ip.Position - drgS
            cG.Position = UDim2.new(drgP.X.Scale, drgP.X.Offset + dl.X, drgP.Y.Scale, drgP.Y.Offset + dl.Y)
        end
    end))

    local cK = Instance.new("TextButton", cJ)
    cK.Name = "BackBtn"
    cK.Size = UDim2.new(0, 34, 1, 0)
    cK.Position = UDim2.new(0, 4, 0, 0)
    cK.BackgroundTransparency = 1
    cK.Font = Enum.Font.GothamBold
    cK.Text = "<"
    cK.TextSize = 16
    cK.TextColor3 = ae.Accent
    cK.Visible = false
    cK.ZIndex = 22
    bs.AttachBossInteractions(cK, 1.15)
    cK.MouseButton1Click:Connect(function()
        if bs.Mode == "DM" or bs.Mode == "CloseFriends" then bs.SwitchMode("DM_Inbox")
        else bs.SwitchMode("Server") end
    end)

    local cL = Instance.new("ImageLabel", cJ)
    cL.Name = "ActiveDMProfilePic"
    cL.Size = UDim2.new(0, 24, 0, 24)
    cL.Position = UDim2.new(0, 36, 0.5, -12)
    cL.BackgroundTransparency = 1
    cL.Visible = false
    cL.ZIndex = 22
    Instance.new("UICorner", cL).CornerRadius = UDim.new(1, 0)

    local cM = Instance.new("TextButton", cJ)
    cM.Name = "MainTitle"
    cM.Size = UDim2.new(0, 260, 1, 0)
    cM.Position = UDim2.new(0, 14, 0, 0)
    cM.BackgroundTransparency = 1
    cM.Text = "ᴢ ᴀ ʏ ɴ  ᴄ ʜ ᴀ ᴛ  ᴠ71"
    cM.Font = Enum.Font.GothamBold
    cM.TextSize = 15.5
    cM.TextColor3 = Color3.fromRGB(255, 255, 255)
    cM.TextXAlignment = Enum.TextXAlignment.Left
    cM.ZIndex = 22

    local cN = Instance.new("UIGradient", cM)
    cN.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 225, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(165, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 205, 65))
    })

    cM.MouseButton1Click:Connect(function()
        if bs.Mode == "DM" and bs.ActiveDM then
            local acc = bs.GetAccount(bs.ActiveDM)
            if acc and acc.UserId and acc.UserId > 1 then
                bs.OpenUserProfile(acc.UserId)
            else
                task.spawn(function()
                    local res = bs.ResolveUserInput(bs.ActiveDM)
                    if res and res.UserId then bs.OpenUserProfile(res.UserId) end
                end)
            end
        end
    end)

    local cSubTitle = Instance.new("TextLabel", cJ)
    cSubTitle.Size = UDim2.new(0, 200, 0, 12)
    cSubTitle.Position = UDim2.new(0, 68, 0, 18)
    cSubTitle.BackgroundTransparency = 1
    cSubTitle.Font = Enum.Font.GothamMedium
    cSubTitle.TextSize = 9
    cSubTitle.TextColor3 = Color3.fromRGB(150, 155, 180)
    cSubTitle.TextXAlignment = Enum.TextXAlignment.Left
    cSubTitle.Text = ""
    cSubTitle.Visible = false
    cSubTitle.ZIndex = 22

    local quickMusicBtn = Instance.new("TextButton", cJ)
    quickMusicBtn.Size = UDim2.new(0, 26, 0, 24)
    quickMusicBtn.Position = UDim2.new(1, -64, 0.5, -12)
    quickMusicBtn.BackgroundColor3 = ae.InputBg
    quickMusicBtn.Text = "🎵"
    quickMusicBtn.Font = Enum.Font.GothamBold
    quickMusicBtn.TextSize = 13
    quickMusicBtn.TextColor3 = ae.TextColor
    quickMusicBtn.ZIndex = 22
    Instance.new("UICorner", quickMusicBtn).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(quickMusicBtn, 1.1)
    quickMusicBtn.MouseButton1Click:Connect(function()
        bs.SwitchMode(bs.Mode == "Music" and "Server" or "Music")
    end)

    local cO = Instance.new("TextButton", cJ)
    cO.Name = "MenuBtn"
    cO.Size = UDim2.new(0, 26, 0, 24)
    cO.Position = UDim2.new(1, -33, 0.5, -12)
    cO.BackgroundColor3 = ae.InputBg
    cO.Text = "⚙️"
    cO.Font = Enum.Font.GothamBold
    cO.TextSize = 13
    cO.TextColor3 = ae.TextColor
    cO.ZIndex = 22
    Instance.new("UICorner", cO).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(cO, 1.1)
    cO.MouseButton1Click:Connect(function()
        bs.SwitchMode(bs.Mode == "Settings" and "Server" or "Settings")
        if bs.UI.AdminTray then bs.UI.AdminTray.Visible = false end
        if bs.UI.ImageTray then bs.UI.ImageTray.Visible = false end
        if bs.UI.StickerTray then bs.UI.StickerTray.Visible = false end
    end)

    -- CHAT SEARCH, MESSAGE SCROLL & INPUT WRAPPER (Placeholder strictly "Type message...")
    local d5 = Instance.new("Frame", cG)
    d5.Name = "MatrixGlobalSearch"
    d5.Size = UDim2.new(1, -20, 0, 34)
    d5.Position = UDim2.new(0, 10, 0, bs.Layout.HeaderH + 6)
    d5.BackgroundColor3 = ae.InputBg
    d5.Visible = false
    d5.ZIndex = 12
    Instance.new("UICorner", d5).CornerRadius = UDim.new(0, 17)

    local d6 = Instance.new("TextBox", d5)
    d6.Size = UDim2.new(1, -20, 1, 0)
    d6.Position = UDim2.new(0, 14, 0, 0)
    d6.BackgroundTransparency = 1
    d6.Font = Enum.Font.GothamMedium
    d6.TextSize = 12
    d6.TextColor3 = ae.TextColor
    d6.PlaceholderText = "Search username or User ID..."
    d6.PlaceholderColor3 = ae.SubText
    d6.TextXAlignment = Enum.TextXAlignment.Left
    d6.ClearTextOnFocus = false
    d6.Text = ""
    d6.ZIndex = 13

    local d7 = Instance.new("ScrollingFrame", cG)
    d7.Name = "MessageScroll"
    d7.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH + 46))
    d7.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    d7.BackgroundTransparency = 1
    d7.ScrollBarThickness = 2
    d7.ZIndex = 5

    local d8 = Instance.new("UIListLayout", d7)
    d8.Padding = UDim.new(0, 8)
    d8.SortOrder = Enum.SortOrder.LayoutOrder

    local d9 = Instance.new("UIPadding", d7)
    d9.PaddingLeft = UDim.new(0, 14); d9.PaddingRight = UDim.new(0, 14)
    d9.PaddingTop = UDim.new(0, 10); d9.PaddingBottom = UDim.new(0, 10)
    d8:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        d7.CanvasSize = UDim2.new(0, 0, 0, d8.AbsoluteContentSize.Y + 44)
    end)

    local db = Instance.new("TextButton", cG)
    db.Name = "MatrixJumpBtn"
    db.Size = UDim2.new(0, 34, 0, 34)
    db.Position = UDim2.new(1, -46, 1, -(bs.Layout.NavH + 88))
    db.BackgroundColor3 = ae.Accent
    db.Text = "⬇️"
    db.Font = Enum.Font.GothamBold
    db.TextSize = 14
    db.TextColor3 = ae.SendText
    db.Visible = false
    db.ZIndex = 18
    Instance.new("UICorner", db).CornerRadius = UDim.new(1, 0)
    bs.AttachBossInteractions(db, 1.1)
    db.MouseButton1Click:Connect(function() bs.HandleScroll(true) end)

    local dc = Instance.new("Frame", cG)
    dc.Name = "MatrixReplyPocketBar"
    dc.Size = UDim2.new(1, -24, 0, 32)
    dc.Position = UDim2.new(0, 12, 1, -(bs.Layout.NavH + 44))
    dc.BackgroundColor3 = ae.InputBg
    dc.Visible = false
    dc.ZIndex = 14
    Instance.new("UICorner", dc).CornerRadius = UDim.new(0, 8)

    local dd = Instance.new("TextLabel", dc)
    dd.Size = UDim2.new(0, 25, 1, 0); dd.Position = UDim2.new(0, 5, 0, 0)
    dd.BackgroundTransparency = 1; dd.Text = "↩"; dd.Font = Enum.Font.GothamBold; dd.TextSize = 14; dd.TextColor3 = ae.Accent; dd.ZIndex = 15

    local de = Instance.new("TextLabel", dc)
    de.Size = UDim2.new(1, -60, 1, 0); de.Position = UDim2.new(0, 30, 0, 0)
    de.BackgroundTransparency = 1; de.Font = Enum.Font.GothamMedium; de.TextSize = 10; de.TextColor3 = ae.SubText
    de.TextXAlignment = Enum.TextXAlignment.Left; de.RichText = true; de.ZIndex = 15

    local df = Instance.new("TextButton", dc)
    df.Size = UDim2.new(0, 20, 0, 20); df.Position = UDim2.new(1, -26, 0.5, -10)
    df.BackgroundColor3 = ae.MainBg; df.Text = "X"; df.TextColor3 = ae.SubText; df.Font = Enum.Font.GothamBold; df.ZIndex = 15
    Instance.new("UICorner", df).CornerRadius = UDim.new(1, 0)
    bs.AttachBossInteractions(df, 1.15)

    local cSlow = Instance.new("TextLabel", cG)
    cSlow.Size = UDim2.new(1, -24, 0, 14)
    cSlow.Position = UDim2.new(0, 14, 1, -(bs.Layout.NavH + 58))
    cSlow.BackgroundTransparency = 1
    cSlow.Font = Enum.Font.GothamMedium
    cSlow.TextSize = 10
    cSlow.TextColor3 = Color3.fromRGB(250, 80, 80)
    cSlow.TextXAlignment = Enum.TextXAlignment.Left
    cSlow.Text = ""
    cSlow.Visible = false
    cSlow.ZIndex = 16
    bs.UI.SlowdownLabel = cSlow

    local dg = Instance.new("Frame", cG)
    dg.Name = "InputWrapper"
    dg.Size = UDim2.new(1, -24, 0, 36)
    dg.Position = UDim2.new(0, 12, 1, -(bs.Layout.NavH + 42))
    dg.BackgroundColor3 = ae.InputBg
    dg.BackgroundTransparency = ae.InpTrans
    dg.ZIndex = 16
    Instance.new("UICorner", dg).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", dg).Color = ae.StrokeColor

    local di = Instance.new("TextButton", dg)
    di.Size = UDim2.new(0, 28, 0, 28)
    di.Position = UDim2.new(1, -68, 0.5, -14)
    di.BackgroundColor3 = ae.HeaderBg
    di.Font = Enum.Font.GothamBold
    di.TextSize = 13
    di.ZIndex = 17
    Instance.new("UICorner", di).CornerRadius = UDim.new(1, 0)
    bs.AttachBossInteractions(di, 1.12)

    local dj = Instance.new("ImageLabel", di)
    dj.Name = "StkDecal"
    dj.Size = UDim2.new(1, 0, 1, 0)
    dj.BackgroundTransparency = 1
    dj.Image = "rbxthumb://type=Asset&id=87270658272764&w=150&h=150"
    dj.ScaleType = Enum.ScaleType.Crop
    dj.ZIndex = 18
    Instance.new("UICorner", dj).CornerRadius = UDim.new(1, 0)
    if bs.CurrentTheme == "Dark" or bs.CurrentTheme == "PureBlack" or bs.CurrentTheme == "ObsidianGold" then
        di.Text = ""; dj.Visible = true
    else
        di.Text = "🏵️"; dj.Visible = false
    end

    local dk = Instance.new("TextButton", dg)
    dk.Name = "SendBtn"
    dk.Size = UDim2.new(0, 32, 0, 28)
    dk.Position = UDim2.new(1, -36, 0.5, -14)
    dk.BackgroundColor3 = ae.Accent
    dk.Text = "▶︎"
    dk.Font = Enum.Font.GothamBold
    dk.TextSize = 14
    dk.TextColor3 = ae.SendText
    dk.ZIndex = 17
    Instance.new("UICorner", dk).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(dk, 1.15)

    local dl = Instance.new("TextBox", dg)
    dl.Name = "InputTextBox"
    dl.Size = UDim2.new(1, -85, 1, 0)
    dl.Position = UDim2.new(0, 14, 0, 0)
    dl.BackgroundTransparency = 1
    dl.Font = Enum.Font.GothamMedium
    dl.TextSize = 12
    dl.TextColor3 = ae.TextColor
    dl.PlaceholderText = "Type message..."
    dl.PlaceholderColor3 = ae.SubText
    dl.TextXAlignment = Enum.TextXAlignment.Left
    dl.ClearTextOnFocus = false
    dl.Text = ""
    dl.ZIndex = 17

    local dm = 0
    dl:GetPropertyChangedSignal("Text"):Connect(function()
        if bs.Mode == "DM" and bs.ActiveDM and not bs.IsLocked then
            local dn = os.clock()
            if dn - dm > 2.5 and #dl.Text > 0 then
                dm = dn
                local dp = f:JSONEncode({s = m.DisplayName, t = aB()})
                task.spawn(function()
                    pcall(function() G(F .. "/" .. M .. "/" .. bs.ActiveDM .. "/" .. m.Name:lower() .. "/_typ.json", "PUT", dp) end)
                end)
            end
        end
    end)

    bs.UI.MainBg = cG; bs.UI.ToggleBtn = cE; bs.UI.MainStroke = cH; bs.UI.HeaderBg = cJ
    bs.UI.QuickMusicBtn = quickMusicBtn; bs.UI.Scroll = d7; bs.UI.JumpBtn = db
    bs.UI.InputWrapper = dg; bs.UI.TextBox = dl; bs.UI.SendBtn = dk
    bs.UI.SearchWrapper = d5; bs.UI.SearchInput = d6; bs.UI.Title = cM; bs.UI.SubTitle = cSubTitle
    bs.UI.Back = cK; bs.UI.HeaderDP = cL; bs.UI.ReplyPreview = dc; bs.UI.ReplyIcon = dd
    bs.UI.ReplyText = de; bs.UI.CancelRep = df; bs.UI.MenuBtn = cO; bs.UI.StickerBtn = di; bs.UI.TitleGrad = cN

    -- Build All Sub-Panels Modularly
    bs.BuildNavBar(cG, ae)
    bs.BuildSettingsPage(cG, ae)
    bs.BuildMusicPanel(cG)
    bs.BuildStickerAndVaultTrays(cG, ae)
    bs.BuildAdminConsole(cG, ae)

    if bs.BuildProfilePage then bs.BuildProfilePage(cG) end
    if bs.BuildCustomizePage then bs.BuildCustomizePage(cG) end
    if bs.BuildNotificationsPage then bs.BuildNotificationsPage(cG) end

    bs.SyncNativeRobloxBubbleSettings()
    if bs.IsLocked then bs.SetLockState(true) end

    bs.RegisterAnim(cSlow, function()
        local tDiff = os.clock() - bs.LastSendTime
        if tDiff < 3.0 and (bs.Mode == "Server" or bs.Mode == "DM") then
            cSlow.Visible = true
            cSlow.Text = "⏳ Slowdown mode : " .. math.ceil(3.0 - tDiff) .. "s"
        else
            cSlow.Visible = false
        end
    end)
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 6 / 8 : INSTAGRAM-STYLE ELITE PROFILE PAGE & FOLLOWERS POPUP OVERLAY
-- ========================================================================= --

local profileRenderToken = 0
local overlayRenderToken = 0

function bs.BuildProfilePage(cG)
    local page = Instance.new("ScrollingFrame", cG)
    page.Name = "ZaynProfilePage"
    page.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH))
    page.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    page.BackgroundColor3 = Color3.fromRGB(10, 9, 14)
    page.BackgroundTransparency = 0
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 205, 55)
    page.Visible = false
    page.ZIndex = 30
    bs.UI.ProfilePage = page

    local bgGrad = Instance.new("UIGradient", page)
    bgGrad.Name = "ProfileBgGrad"
    bgGrad.Rotation = 140
    bgGrad.Color = ColorSequence.new(Color3.fromRGB(10, 9, 12), Color3.fromRGB(36, 26, 10))
    bs.UI.ProfileBgGrad = bgGrad

    local list = Instance.new("UIListLayout", page)
    list.Padding = UDim.new(0, 9)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding", page)
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 16)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 28)
    end)

    bs.UI.ProfileList = list
end

local function makeInstaBtn(parent, txt, bgCol, txtCol, widthScale, order, onClick)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(widthScale, -4, 0, 32)
    btn.BackgroundColor3 = bgCol
    btn.Text = txt
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10.5
    btn.TextColor3 = txtCol or Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.ZIndex = 37
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(btn, 1.05)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- ========================================================================= --
-- [SECTION A : CLICKABLE FOLLOWERS / FOLLOWING / REQUESTS POPUP OVERLAY]
-- (Appears directly on top of the Profile Page — No separate main pages!)
-- ========================================================================= --
local function renderOverlayUserRow(scroll, uidStr, modeTab, isMyProfile, themeObj, orderIdx, onRefresh)
    local acc = bs.GetAccountByUid(uidStr)
    local isMeRow = (uidStr == bs.Social.MyUid)
    local isMutual = (not isMeRow) and bs.SocialEngine.IsMutual(uidStr)
    local isFollowing = (not isMeRow) and bs.SocialEngine.IsFollowing(uidStr)
    local isOnline = bs.SocialEngine.IsOnlineCached(uidStr)

    local row = Instance.new("Frame", scroll)
    row.Name = "OverlayUser_" .. uidStr
    row.Size = UDim2.new(1, -4, 0, 52)
    row.BackgroundColor3 = themeObj.cardBg
    row.LayoutOrder = orderIdx
    row.ZIndex = 115
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local rStroke = Instance.new("UIStroke", row)
    rStroke.Color = isMutual and themeObj.accent or Color3.fromRGB(48, 50, 74)
    rStroke.Transparency = isMutual and 0.25 or 0.55

    local avWrap = Instance.new("Frame", row)
    avWrap.Size = UDim2.new(0, 36, 0, 36)
    avWrap.Position = UDim2.new(0, 8, 0.5, -18)
    avWrap.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
    avWrap.ZIndex = 116
    Instance.new("UICorner", avWrap).CornerRadius = UDim.new(1, 0)

    local avImg = Instance.new("ImageLabel", avWrap)
    avImg.Size = UDim2.new(1, -2, 1, -2)
    avImg.Position = UDim2.new(0.5, 0, 0.5, 0)
    avImg.AnchorPoint = Vector2.new(0.5, 0.5)
    avImg.BackgroundTransparency = 1
    avImg.ScaleType = Enum.ScaleType.Crop
    avImg.ZIndex = 117
    Instance.new("UICorner", avImg).CornerRadius = UDim.new(1, 0)
    bs.LoadHeadshotByUid(avImg, uidStr)

    local cachedProf = bs.Social.Profiles[uidStr]
    if cachedProf and cachedProf.decoration and cachedProf.decoration ~= "none" then
        bs.AnimEngine.ApplyAvatarEffect(avWrap, cachedProf.decoration, true)
    end

    local dot = Instance.new("Frame", avWrap)
    dot.Size = UDim2.new(0, 9, 0, 9)
    dot.Position = UDim2.new(1, -8, 1, -8)
    dot.BackgroundColor3 = isOnline and Color3.fromRGB(0, 235, 130) or Color3.fromRGB(108, 112, 130)
    dot.ZIndex = 120
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    -- Tap name/avatar area to jump directly to that user's Profile
    local infoBtn = Instance.new("TextButton", row)
    infoBtn.Size = UDim2.new(1, -166, 1, 0)
    infoBtn.Position = UDim2.new(0, 52, 0, 0)
    infoBtn.BackgroundTransparency = 1
    infoBtn.Text = ""
    infoBtn.ZIndex = 117
    infoBtn.MouseButton1Click:Connect(function()
        if bs.UI.MainBg and bs.UI.MainBg:FindFirstChild("InstaSocialOverlay") then
            bs.UI.MainBg.InstaSocialOverlay:Destroy()
        end
        bs.OpenUserProfile(uidStr)
    end)

    local nLbl = Instance.new("TextLabel", infoBtn)
    nLbl.Size = UDim2.new(1, 0, 0, 18)
    nLbl.Position = UDim2.new(0, 0, 0, 8)
    nLbl.BackgroundTransparency = 1
    nLbl.Font = Enum.Font.GothamBold
    nLbl.TextSize = 11.5
    nLbl.TextColor3 = themeObj.textColor
    nLbl.TextXAlignment = Enum.TextXAlignment.Left
    nLbl.ClipsDescendants = true
    nLbl.Text = acc.DisplayName .. (isMutual and " ✦" or "")
    nLbl.ZIndex = 118

    local uLbl = Instance.new("TextLabel", infoBtn)
    uLbl.Size = UDim2.new(1, 0, 0, 14)
    uLbl.Position = UDim2.new(0, 0, 0, 28)
    uLbl.BackgroundTransparency = 1
    uLbl.Font = Enum.Font.GothamMedium
    uLbl.TextSize = 9.5
    uLbl.TextColor3 = themeObj.subText
    uLbl.TextXAlignment = Enum.TextXAlignment.Left
    uLbl.ClipsDescendants = true
    uLbl.Text = "@" .. acc.Username .. " • " .. uidStr
    uLbl.ZIndex = 118

    if not acc.Verified then
        task.spawn(function()
            local res = bs.ResolveUserInput(uidStr)
            if res and nLbl and nLbl.Parent then
                nLbl.Text = res.DisplayName .. (isMutual and " ✦" or "")
                uLbl.Text = "@" .. res.Username .. " • " .. uidStr
            end
        end)
    end

    local actBox = Instance.new("Frame", row)
    actBox.Size = UDim2.new(0, 108, 1, 0)
    actBox.Position = UDim2.new(1, -114, 0, 0)
    actBox.BackgroundTransparency = 1
    actBox.ZIndex = 117

    local aLay = Instance.new("UIListLayout", actBox)
    aLay.FillDirection = Enum.FillDirection.Horizontal
    aLay.HorizontalAlignment = Enum.HorizontalAlignment.Right
    aLay.VerticalAlignment = Enum.VerticalAlignment.Center
    aLay.Padding = UDim.new(0, 4)

    local function miniAct(txt, w, col, cb)
        local b = Instance.new("TextButton", actBox)
        b.Size = UDim2.new(0, w, 0, 26)
        b.BackgroundColor3 = col
        b.Font = Enum.Font.GothamBold
        b.TextSize = 9.5
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Text = txt
        b.ZIndex = 118
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        bs.AttachBossInteractions(b, 1.06)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    if modeTab == "Requests" then
        miniAct("✓ Accept", 58, Color3.fromRGB(0, 175, 115), function()
            task.spawn(function()
                local ok, msg = bs.SocialEngine.AcceptFollowRequest(uidStr)
                bs.TriggerSocialToast(ok and "✅ Accepted" or "⚠️ Notice", msg, themeObj.accent, uidStr)
                bs.UpdateNavNotifBadge()
                onRefresh()
            end)
        end)
        miniAct("✕", 28, Color3.fromRGB(175, 42, 55), function()
            task.spawn(function()
                bs.SocialEngine.DeclineFollowRequest(uidStr)
                bs.UpdateNavNotifBadge()
                onRefresh()
            end)
        end)
    elseif modeTab == "Followers" and isMyProfile then
        if not isFollowing then
            miniAct("+ Back", 48, Color3.fromRGB(0, 165, 225), function()
                task.spawn(function()
                    local ok, msg = bs.SocialEngine.FollowUser(uidStr)
                    bs.TriggerSocialToast(ok and "👥 Followed" or "⚠️ Notice", msg, themeObj.accent, uidStr)
                    onRefresh()
                end)
            end)
        end
        miniAct("Remove", 52, Color3.fromRGB(165, 42, 58), function()
            task.spawn(function()
                local _, msg = bs.SocialEngine.RemoveFollower(uidStr)
                bs.TriggerSocialToast("🗑️ Removed", msg, Color3.fromRGB(235, 80, 95), uidStr)
                onRefresh()
            end)
        end)
    elseif modeTab == "Following" and isMyProfile then
        miniAct("Unfollow", 64, Color3.fromRGB(165, 45, 60), function()
            task.spawn(function()
                bs.SocialEngine.UnfollowUser(uidStr)
                bs.TriggerSocialToast("👥 Unfollowed", "Removed from following.", Color3.fromRGB(185, 190, 210), uidStr)
                onRefresh()
            end)
        end)
    elseif not isMeRow then
        miniAct(isFollowing and "Unfollow" or "+ Follow", 64, isFollowing and Color3.fromRGB(60, 62, 82) or Color3.fromRGB(0, 175, 225), function()
            task.spawn(function()
                local ok, msg = isFollowing and bs.SocialEngine.UnfollowUser(uidStr) or bs.SocialEngine.FollowUser(uidStr)
                bs.TriggerSocialToast(ok and "👥 Social" or "⚠️ Notice", msg, themeObj.accent, uidStr)
                onRefresh()
            end)
        end)
    end
end

function bs.OpenFollowersOverlay(targetUid, initialTab)
    local cG = bs.UI.MainBg
    if not cG then return end
    if cG:FindFirstChild("InstaSocialOverlay") then
        cG.InstaSocialOverlay:Destroy()
    end

    local uidStr = tostring(targetUid or bs.Social.ViewingProfileUid or bs.Social.MyUid)
    local isMyProf = (uidStr == bs.Social.MyUid)
    local prof = bs.Social.Profiles[uidStr]
    local themeObj = bs.SocialEngine.ResolveThemeObject(prof and prof.theme or "royal_black_gold")
    local currentTab = initialTab or "Followers"

    local backdrop = Instance.new("Frame", cG)
    backdrop.Name = "InstaSocialOverlay"
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 1
    backdrop.Active = true
    backdrop.ZIndex = 110

    local closeCatcher = Instance.new("TextButton", backdrop)
    closeCatcher.Size = UDim2.new(1, 0, 1, 0)
    closeCatcher.BackgroundTransparency = 1
    closeCatcher.Text = ""
    closeCatcher.ZIndex = 111

    local modal = Instance.new("Frame", backdrop)
    modal.Name = "OverlayCard"
    modal.Size = UDim2.new(1, -32, 1, -76)
    modal.Position = UDim2.new(0.5, 0, 0.5, 0)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = themeObj.bg1
    modal.ZIndex = 112
    Instance.new("UICorner", modal).CornerRadius = UDim.new(0, 14)

    local mGrad = Instance.new("UIGradient", modal)
    mGrad.Rotation = 135
    mGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)

    local mStroke = Instance.new("UIStroke", modal)
    mStroke.Color = themeObj.accent
    mStroke.Thickness = 1.6

    local mScale = Instance.new("UIScale", modal)
    mScale.Scale = 0.86
    g:Create(backdrop, TweenInfo.new(0.22), {BackgroundTransparency = 0.45}):Play()
    g:Create(mScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.0}):Play()

    local function closeOverlay()
        g:Create(backdrop, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
        g:Create(mScale, TweenInfo.new(0.18), {Scale = 0.88}):Play()
        task.delay(0.18, function()
            if backdrop and backdrop.Parent then backdrop:Destroy() end
            if bs.Mode == "Profile" and bs.RefreshProfileUI then
                bs.RefreshProfileUI(uidStr)
            end
        end)
    end
    closeCatcher.MouseButton1Click:Connect(closeOverlay)

    -- Modal Header
    local hdr = Instance.new("Frame", modal)
    hdr.Size = UDim2.new(1, 0, 0, 36)
    hdr.BackgroundTransparency = 1
    hdr.ZIndex = 113

    local hTitle = Instance.new("TextLabel", hdr)
    hTitle.Size = UDim2.new(1, -46, 1, 0)
    hTitle.Position = UDim2.new(0, 12, 0, 0)
    hTitle.BackgroundTransparency = 1
    hTitle.Font = Enum.Font.GothamBold
    hTitle.TextSize = 13
    hTitle.TextColor3 = themeObj.accent
    hTitle.TextXAlignment = Enum.TextXAlignment.Left
    hTitle.Text = "@" .. tostring(prof and prof.username or bs.GetAccountByUid(uidStr).Username) .. " • Connections"
    hTitle.ZIndex = 114

    local xBtn = Instance.new("TextButton", hdr)
    xBtn.Size = UDim2.new(0, 26, 0, 26)
    xBtn.Position = UDim2.new(1, -32, 0.5, -13)
    xBtn.BackgroundColor3 = Color3.fromRGB(185, 42, 55)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.TextSize = 11
    xBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    xBtn.Text = "X"
    xBtn.ZIndex = 115
    Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(xBtn, 1.1)
    xBtn.MouseButton1Click:Connect(closeOverlay)

    -- Popup Tabs Row (Followers | Following | Mutuals | Requests if self)
    local tabBar = Instance.new("Frame", modal)
    tabBar.Size = UDim2.new(1, -20, 0, 28)
    tabBar.Position = UDim2.new(0, 10, 0, 38)
    tabBar.BackgroundTransparency = 1
    tabBar.ZIndex = 113

    local tLay = Instance.new("UIListLayout", tabBar)
    tLay.FillDirection = Enum.FillDirection.Horizontal
    tLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tLay.Padding = UDim.new(0, 5)
    tLay.SortOrder = Enum.SortOrder.LayoutOrder

    local scroll = Instance.new("ScrollingFrame", modal)
    scroll.Size = UDim2.new(1, -20, 1, -78)
    scroll.Position = UDim2.new(0, 10, 0, 72)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = themeObj.accent
    scroll.ZIndex = 113

    local sLay = Instance.new("UIListLayout", scroll)
    sLay.Padding = UDim.new(0, 6)
    sLay.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", scroll).PaddingTop = UDim.new(0, 2)
    sLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, sLay.AbsoluteContentSize.Y + 14)
    end)

    local tabButtons = {}
    local function populateOverlay()
        overlayRenderToken = overlayRenderToken + 1
        local myTok = overlayRenderToken

        for kTab, tb in pairs(tabButtons) do
            if kTab == "Requests" then
                local rCnt = bs.SocialEngine.GetRequestCount()
                tb.Text = rCnt > 0 and ("Reqs (" .. rCnt .. ")") or "Requests"
            end
            if kTab == currentTab then
                tb.BackgroundColor3 = themeObj.accent
                tb.TextColor3 = Color3.fromRGB(10, 12, 18)
            else
                tb.BackgroundColor3 = themeObj.cardBg
                tb.TextColor3 = themeObj.textColor
            end
        end

        for _, ch in pairs(scroll:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end

        local loadLbl = Instance.new("TextLabel", scroll)
        loadLbl.Size = UDim2.new(1, 0, 0, 44)
        loadLbl.BackgroundTransparency = 1
        loadLbl.Font = Enum.Font.GothamMedium
        loadLbl.TextSize = 11
        loadLbl.TextColor3 = themeObj.accent
        loadLbl.Text = "◐ Loading " .. currentTab .. "..."
        loadLbl.ZIndex = 114

        task.spawn(function()
            bs.SocialEngine.FetchGraphForUser(bs.Social.MyUid, true)
            if not isMyProf then
                bs.SocialEngine.FetchGraphForUser(uidStr, true)
            end

            local uidList = {}
            if currentTab == "Followers" then
                for uKey, val in pairs(bs.Social.Followers[uidStr] or {}) do
                    if val then table.insert(uidList, tostring(uKey)) end
                end
            elseif currentTab == "Following" then
                for uKey, val in pairs(bs.Social.Following[uidStr] or {}) do
                    if val then table.insert(uidList, tostring(uKey)) end
                end
            elseif currentTab == "Mutuals" then
                uidList = bs.SocialEngine.GetMutualFollowers(uidStr)
            elseif currentTab == "Requests" and isMyProf then
                local reqs = bs.SocialEngine.FetchMyRequests()
                for uKey, val in pairs(reqs) do
                    if type(val) == "table" then
                        if val.username then
                            bs.RegisterAccount(val.username, val.displayName or val.username, tonumber(uKey) or 1)
                        end
                        table.insert(uidList, tostring(uKey))
                    end
                end
            end

            if overlayRenderToken ~= myTok or not scroll or not scroll.Parent then return end
            if loadLbl and loadLbl.Parent then loadLbl:Destroy() end

            if #uidList == 0 then
                local empty = Instance.new("TextLabel", scroll)
                empty.Size = UDim2.new(1, 0, 0, 64)
                empty.BackgroundTransparency = 1
                empty.Font = Enum.Font.GothamMedium
                empty.TextSize = 11
                empty.TextColor3 = themeObj.subText
                empty.TextWrapped = true
                empty.Text = currentTab == "Requests" and "📭 No pending follow requests." or ("No users in " .. currentTab .. " yet.")
                empty.ZIndex = 114
                return
            end

            for idx, uStr in ipairs(uidList) do
                renderOverlayUserRow(scroll, uStr, currentTab, isMyProf, themeObj, idx, populateOverlay)
            end
        end)
    end

    local tabDefs = isMyProf and {
        {id = "Followers", lbl = "Followers", w = 0.24, ord = 1},
        {id = "Following", lbl = "Following", w = 0.24, ord = 2},
        {id = "Mutuals",   lbl = "Mutuals",   w = 0.23, ord = 3},
        {id = "Requests",  lbl = "Requests",  w = 0.25, ord = 4}
    } or {
        {id = "Followers", lbl = "Followers", w = 0.32, ord = 1},
        {id = "Following", lbl = "Following", w = 0.32, ord = 2},
        {id = "Mutuals",   lbl = "Mutuals",   w = 0.32, ord = 3}
    }

    for _, td in ipairs(tabDefs) do
        local tb = Instance.new("TextButton", tabBar)
        tb.Size = UDim2.new(td.w, 0, 1, 0)
        tb.BackgroundColor3 = themeObj.cardBg
        tb.Font = Enum.Font.GothamBold
        tb.TextSize = 10
        tb.TextColor3 = themeObj.textColor
        tb.Text = td.lbl
        tb.LayoutOrder = td.ord
        tb.ZIndex = 114
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 7)
        bs.AttachBossInteractions(tb, 1.04)
        tb.MouseButton1Click:Connect(function()
            currentTab = td.id
            populateOverlay()
        end)
        tabButtons[td.id] = tb
    end

    populateOverlay()
end

-- ========================================================================= --
-- [SECTION B : INLINE EDIT PROFILE & PRIVACY SETTINGS PANEL]
-- ========================================================================= --
function bs.BuildProfileEditorCard(page, prof, themeObj)
    local editor = Instance.new("Frame", page)
    editor.Name = "ProfileEditorCard"
    editor.Size = UDim2.new(1, 0, 0, 0)
    editor.AutomaticSize = Enum.AutomaticSize.Y
    editor.BackgroundColor3 = themeObj.cardBg
    editor.Visible = false
    editor.LayoutOrder = 6
    editor.ZIndex = 36
    Instance.new("UICorner", editor).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", editor).Color = themeObj.accent

    local eList = Instance.new("UIListLayout", editor)
    eList.Padding = UDim.new(0, 8)
    eList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    eList.SortOrder = Enum.SortOrder.LayoutOrder

    local ePad = Instance.new("UIPadding", editor)
    ePad.PaddingTop = UDim.new(0, 10); ePad.PaddingBottom = UDim.new(0, 12)
    ePad.PaddingLeft = UDim.new(0, 12); ePad.PaddingRight = UDim.new(0, 12)

    local hdr = Instance.new("TextLabel", editor)
    hdr.Size = UDim2.new(1, 0, 0, 18)
    hdr.BackgroundTransparency = 1
    hdr.Font = Enum.Font.GothamBold
    hdr.TextSize = 11.5
    hdr.TextColor3 = themeObj.accent
    hdr.TextXAlignment = Enum.TextXAlignment.Left
    hdr.Text = "✏️ EDIT PROFILE & PRIVACY"
    hdr.LayoutOrder = 1
    hdr.ZIndex = 37

    local nameBox = Instance.new("TextBox", editor)
    nameBox.Size = UDim2.new(1, 0, 0, 32)
    nameBox.BackgroundColor3 = themeObj.bg1
    nameBox.Font = Enum.Font.GothamMedium
    nameBox.TextSize = 11.5
    nameBox.TextColor3 = themeObj.textColor
    nameBox.PlaceholderText = "Display Name (max 28 chars)"
    nameBox.PlaceholderColor3 = themeObj.subText
    nameBox.Text = prof.displayName or m.DisplayName
    nameBox.ClearTextOnFocus = false
    nameBox.TextXAlignment = Enum.TextXAlignment.Left
    nameBox.LayoutOrder = 2
    nameBox.ZIndex = 37
    Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 8)
    Instance.new("UIPadding", nameBox).PaddingLeft = UDim.new(0, 10)

    local bioBox = Instance.new("TextBox", editor)
    bioBox.Size = UDim2.new(1, 0, 0, 48)
    bioBox.BackgroundColor3 = themeObj.bg1
    bioBox.Font = Enum.Font.GothamMedium
    bioBox.TextSize = 11
    bioBox.TextColor3 = themeObj.textColor
    bioBox.PlaceholderText = "Write your Instagram bio (max 140 chars)..."
    bioBox.PlaceholderColor3 = themeObj.subText
    bioBox.Text = prof.bio or ""
    bioBox.TextWrapped = true
    bioBox.ClearTextOnFocus = false
    bioBox.TextXAlignment = Enum.TextXAlignment.Left
    bioBox.TextYAlignment = Enum.TextYAlignment.Top
    bioBox.LayoutOrder = 3
    bioBox.ZIndex = 37
    Instance.new("UICorner", bioBox).CornerRadius = UDim.new(0, 8)
    local bPad = Instance.new("UIPadding", bioBox)
    bPad.PaddingLeft = UDim.new(0, 10); bPad.PaddingRight = UDim.new(0, 10); bPad.PaddingTop = UDim.new(0, 6)

    local privDraft = {
        isPrivate = prof.privacy and prof.privacy.isPrivate == true,
        allowFollows = not (prof.privacy and prof.privacy.allowFollows == false),
        hideLists = prof.privacy and prof.privacy.hideLists == true,
        dmPermission = (prof.privacy and prof.privacy.dmPermission) or "Everyone"
    }

    local dmModes = {"Everyone", "Followers", "Mutuals", "None"}
    local dmIdx = 1
    for idx, md in ipairs(dmModes) do if md == privDraft.dmPermission then dmIdx = idx; break end end

    local function makeToggle(lbl, initVal, ord, cb)
        local b = Instance.new("TextButton", editor)
        b.Size = UDim2.new(1, 0, 0, 28)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 10
        b.TextColor3 = Color3.fromRGB(235, 238, 250)
        b.LayoutOrder = ord
        b.ZIndex = 37
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
        local v = initVal
        local function upd()
            b.Text = lbl .. ": " .. (v and "ON ✅" or "OFF ❌")
            b.BackgroundColor3 = v and Color3.fromRGB(22, 46, 48) or Color3.fromRGB(28, 22, 34)
        end
        upd()
        b.MouseButton1Click:Connect(function() v = not v; upd(); cb(v) end)
    end

    makeToggle("🔒 Private Account (Follow Approval)", privDraft.isPrivate, 4, function(v) privDraft.isPrivate = v end)
    makeToggle("➕ Allow New Followers", privDraft.allowFollows, 5, function(v) privDraft.allowFollows = v end)
    makeToggle("🙈 Hide Followers / Following Lists", privDraft.hideLists, 6, function(v) privDraft.hideLists = v end)

    local dmBtn = Instance.new("TextButton", editor)
    dmBtn.Size = UDim2.new(1, 0, 0, 28)
    dmBtn.BackgroundColor3 = Color3.fromRGB(20, 26, 44)
    dmBtn.Font = Enum.Font.GothamBold
    dmBtn.TextSize = 10
    dmBtn.TextColor3 = themeObj.accent
    dmBtn.Text = "💬 Who Can DM Me: " .. privDraft.dmPermission
    dmBtn.LayoutOrder = 7
    dmBtn.ZIndex = 37
    Instance.new("UICorner", dmBtn).CornerRadius = UDim.new(0, 7)
    dmBtn.MouseButton1Click:Connect(function()
        dmIdx = (dmIdx % #dmModes) + 1
        privDraft.dmPermission = dmModes[dmIdx]
        dmBtn.Text = "💬 Who Can DM Me: " .. privDraft.dmPermission
    end)

    local btnRow = Instance.new("Frame", editor)
    btnRow.Size = UDim2.new(1, 0, 0, 32)
    btnRow.BackgroundTransparency = 1
    btnRow.LayoutOrder = 8
    btnRow.ZIndex = 37
    local rLay = Instance.new("UIListLayout", btnRow)
    rLay.FillDirection = Enum.FillDirection.Horizontal
    rLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    rLay.Padding = UDim.new(0, 8)

    makeInstaBtn(btnRow, "💾 SAVE CHANGES", Color3.fromRGB(0, 175, 125), Color3.fromRGB(255, 255, 255), 0.54, 1, function()
        task.spawn(function()
            local ok, msg = bs.SocialEngine.SaveMyProfileChanges({
                displayName = nameBox.Text,
                bio = bioBox.Text,
                privacy = privDraft
            })
            if ok then
                bs.TriggerSocialToast("✅ Profile Saved", msg, themeObj.accent, bs.Social.MyUid)
            else
                bs.TriggerSocialToast("⚠️ Save Failed", msg, Color3.fromRGB(235, 65, 80), bs.Social.MyUid)
            end
        end)
    end)

    makeInstaBtn(btnRow, "✖ CLOSE", Color3.fromRGB(68, 66, 84), Color3.fromRGB(255, 255, 255), 0.42, 2, function()
        editor.Visible = false
    end)

    return editor
end

-- ========================================================================= --
-- [SECTION C : INSTAGRAM-STYLE PROFILE PAGE RENDERER (FULL THEME STYLING)]
-- ========================================================================= --
function bs.RefreshProfileUI(targetUid)
    local page = bs.UI.ProfilePage
    if not page then return end

    profileRenderToken = profileRenderToken + 1
    local myToken = profileRenderToken
    local uidStr = tostring(targetUid or bs.Social.ViewingProfileUid or bs.Social.MyUid)
    bs.Social.ViewingProfileUid = uidStr

    for _, ch in pairs(page:GetChildren()) do
        if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") and not ch:IsA("UIGradient") then
            ch:Destroy()
        end
    end

    local loadLbl = Instance.new("TextLabel", page)
    loadLbl.Size = UDim2.new(1, 0, 0, 72)
    loadLbl.BackgroundTransparency = 1
    loadLbl.Font = Enum.Font.GothamBold
    loadLbl.TextSize = 12
    loadLbl.TextColor3 = Color3.fromRGB(0, 225, 255)
    loadLbl.Text = "◐ Loading Insta Elite Profile..."
    loadLbl.ZIndex = 32

    task.spawn(function()
        local isMe = (uidStr == bs.Social.MyUid)
        local prof = bs.SocialEngine.FetchProfile(uidStr, true)
        bs.SocialEngine.FetchGraphForUser(uidStr, true)
        if not isMe then
            bs.SocialEngine.FetchGraphForUser(bs.Social.MyUid, false)
        else
            bs.SocialEngine.FetchMyRequests()
        end
        local isOnline = bs.SocialEngine.FetchPresence(uidStr)
        local hasElite = bs.SocialEngine.HasElitePass(uidStr)
        local isBlocked = (not isMe) and bs.SocialEngine.IsBlocked(uidStr)
        local isBlockedBy = (not isMe) and bs.SocialEngine.IsBlockedBy(uidStr)
        local isFollowing = (not isMe) and bs.SocialEngine.IsFollowing(uidStr)
        local isFollowedBy = (not isMe) and bs.SocialEngine.IsFollowedBy(uidStr)
        local hasPendingReq = (not isMe) and (not isFollowing) and bs.SocialEngine.HasSentRequestTo(uidStr)

        if profileRenderToken ~= myToken or not page or not page.Parent then return end
        if loadLbl and loadLbl.Parent then loadLbl:Destroy() end

        if not prof then
            local err = Instance.new("TextLabel", page)
            err.Size = UDim2.new(1, 0, 0, 60)
            err.BackgroundTransparency = 1
            err.Font = Enum.Font.GothamBold
            err.TextSize = 12
            err.TextColor3 = Color3.fromRGB(240, 75, 90)
            err.Text = "⚠️ Could not load user profile."
            err.ZIndex = 32
            return
        end

        local themeObj = bs.SocialEngine.ResolveThemeObject(prof.theme)
        local followerCount = bs.SocialEngine.GetFollowerCount(uidStr)
        local followingCount = bs.SocialEngine.GetFollowingCount(uidStr)
        local mutualList = bs.SocialEngine.GetMutualFollowers(uidStr)
        local isPrivateLocked = (not isMe) and prof.privacy and prof.privacy.isPrivate and (not isFollowing)
        local canOpenLists = isMe or (not isPrivateLocked and not (prof.privacy and prof.privacy.hideLists))

        -- Apply Full Profile Theme to the entire Profile Page canvas!
        page.BackgroundColor3 = themeObj.bg1
        page.ScrollBarImageColor3 = themeObj.accent
        if bs.UI.ProfileBgGrad then
            bs.UI.ProfileBgGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)
        end
        if bs.UI.Title then
            bs.UI.Title.Text = isMe and "MY INSTA PROFILE" or ("@" .. tostring(prof.username))
        end

        -- ================================================================= --
        -- 1. QUICK PROFILE FINDER BAR (Search any user by Username or ID)
        -- ================================================================= --
        local finderBar = Instance.new("Frame", page)
        finderBar.Name = "ProfileFinderBar"
        finderBar.Size = UDim2.new(1, 0, 0, 32)
        finderBar.BackgroundColor3 = themeObj.cardBg
        finderBar.LayoutOrder = 1
        finderBar.ZIndex = 33
        Instance.new("UICorner", finderBar).CornerRadius = UDim.new(0, 10)
        local fSt = Instance.new("UIStroke", finderBar)
        fSt.Color = themeObj.borderColor
        fSt.Transparency = 0.55

        local findInput = Instance.new("TextBox", finderBar)
        findInput.Size = UDim2.new(1, -68, 1, 0)
        findInput.Position = UDim2.new(0, 10, 0, 0)
        findInput.BackgroundTransparency = 1
        findInput.Font = Enum.Font.GothamMedium
        findInput.TextSize = 11
        findInput.TextColor3 = themeObj.textColor
        findInput.PlaceholderText = "Find user profile by Username or User ID..."
        findInput.PlaceholderColor3 = themeObj.subText
        findInput.TextXAlignment = Enum.TextXAlignment.Left
        findInput.ClearTextOnFocus = false
        findInput.Text = ""
        findInput.ZIndex = 34

        local goBtn = Instance.new("TextButton", finderBar)
        goBtn.Size = UDim2.new(0, 54, 0, 24)
        goBtn.Position = UDim2.new(1, -58, 0.5, -12)
        goBtn.BackgroundColor3 = themeObj.accent
        goBtn.Font = Enum.Font.GothamBold
        goBtn.TextSize = 10
        goBtn.TextColor3 = Color3.fromRGB(10, 12, 18)
        goBtn.Text = "🔍 GO"
        goBtn.ZIndex = 34
        Instance.new("UICorner", goBtn).CornerRadius = UDim.new(0, 6)
        bs.AttachBossInteractions(goBtn, 1.06)

        local function lookupProfile()
            local qTxt = findInput.Text:match("^%s*(.-)%s*$")
            if qTxt == "" then return end
            goBtn.Text = "⏳"
            task.spawn(function()
                local res = bs.ResolveUserInput(qTxt)
                if goBtn and goBtn.Parent then goBtn.Text = "🔍 GO" end
                if res and res.UserId then
                    bs.OpenUserProfile(res.UserId)
                else
                    bs.TriggerSocialToast("⚠️ Not Found", "No Roblox user found for '" .. qTxt .. "'", Color3.fromRGB(235, 65, 80), bs.Social.MyUid)
                end
            end)
        end
        goBtn.MouseButton1Click:Connect(lookupProfile)
        findInput.FocusLost:Connect(function(enter) if enter then lookupProfile() end end)

        -- ================================================================= --
        -- 2. INSTAGRAM-STYLE HERO CARD (AVATAR + CLICKABLE STATS + BIO + BADGES)
        -- ================================================================= --
        local hero = Instance.new("Frame", page)
        hero.Name = "InstaHeroCard"
        hero.Size = UDim2.new(1, 0, 0, 0)
        hero.AutomaticSize = Enum.AutomaticSize.Y
        hero.BackgroundColor3 = themeObj.cardBg
        hero.BorderSizePixel = 0
        hero.LayoutOrder = 2
        hero.ZIndex = 32
        Instance.new("UICorner", hero).CornerRadius = UDim.new(0, 14)

        local hGrad = Instance.new("UIGradient", hero)
        hGrad.Rotation = 135
        hGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)

        -- Animated Elite Profile Frame Border + Particles
        bs.AnimEngine.ApplyProfileFrameEffect(hero, themeObj, hasElite)
        bs.AnimEngine.AttachFloatingParticles(hero, themeObj.particleColor, hasElite and 12 or 6)

        -- Smooth entrance scale
        local heroScale = Instance.new("UIScale", hero)
        heroScale.Scale = 0.93
        g:Create(heroScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.0}):Play()

        local heroContent = Instance.new("Frame", hero)
        heroContent.Size = UDim2.new(1, 0, 0, 0)
        heroContent.AutomaticSize = Enum.AutomaticSize.Y
        heroContent.BackgroundTransparency = 1
        heroContent.ZIndex = 35

        local hcLay = Instance.new("UIListLayout", heroContent)
        hcLay.Padding = UDim.new(0, 7)
        hcLay.SortOrder = Enum.SortOrder.LayoutOrder

        local hcPad = Instance.new("UIPadding", heroContent)
        hcPad.PaddingTop = UDim.new(0, 12); hcPad.PaddingBottom = UDim.new(0, 12)
        hcPad.PaddingLeft = UDim.new(0, 14); hcPad.PaddingRight = UDim.new(0, 14)

        -- TOP INSTAGRAM ROW: Left = 70px Animated Avatar | Right = Clickable Followers / Following / Mutuals
        local topRow = Instance.new("Frame", heroContent)
        topRow.Size = UDim2.new(1, 0, 0, 76)
        topRow.BackgroundTransparency = 1
        topRow.LayoutOrder = 1
        topRow.ZIndex = 36

        local avatarHolder = Instance.new("Frame", topRow)
        avatarHolder.Name = "InstaAvatarHolder"
        avatarHolder.Size = UDim2.new(0, 68, 0, 68)
        avatarHolder.Position = UDim2.new(0, 2, 0.5, -34)
        avatarHolder.BackgroundColor3 = themeObj.bg1
        avatarHolder.ZIndex = 37
        Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0)

        local avImg = Instance.new("ImageLabel", avatarHolder)
        avImg.Size = UDim2.new(1, -4, 1, -4)
        avImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        avImg.AnchorPoint = Vector2.new(0.5, 0.5)
        avImg.BackgroundTransparency = 1
        avImg.ScaleType = Enum.ScaleType.Crop
        avImg.ZIndex = 38
        Instance.new("UICorner", avImg).CornerRadius = UDim.new(1, 0)
        bs.LoadHeadshotByUid(avImg, uidStr)

        if prof.decoration and prof.decoration ~= "none" then
            bs.AnimEngine.ApplyAvatarEffect(avatarHolder, prof.decoration, false)
        else
            local defSt = Instance.new("UIStroke", avatarHolder)
            defSt.Color = themeObj.accent
            defSt.Thickness = 2
        end

        -- Online / Offline Indicator Dot
        local onlineDot = Instance.new("Frame", avatarHolder)
        onlineDot.Size = UDim2.new(0, 14, 0, 14)
        onlineDot.Position = UDim2.new(1, -12, 1, -12)
        onlineDot.BackgroundColor3 = isOnline and Color3.fromRGB(0, 235, 130) or Color3.fromRGB(115, 120, 138)
        onlineDot.ZIndex = 44
        Instance.new("UICorner", onlineDot).CornerRadius = UDim.new(1, 0)
        local dSt = Instance.new("UIStroke", onlineDot)
        dSt.Color = themeObj.bg1
        dSt.Thickness = 2

        -- Right Clickable Stats Box (Real counts only — No fake post counts!)
        local statsBox = Instance.new("Frame", topRow)
        statsBox.Size = UDim2.new(1, -86, 0, 56)
        statsBox.Position = UDim2.new(0, 84, 0.5, -28)
        statsBox.BackgroundColor3 = themeObj.bg1
        statsBox.BackgroundTransparency = 0.42
        statsBox.ZIndex = 36
        Instance.new("UICorner", statsBox).CornerRadius = UDim.new(0, 10)
        local sbSt = Instance.new("UIStroke", statsBox)
        sbSt.Color = themeObj.borderColor
        sbSt.Transparency = 0.55

        local sbLay = Instance.new("UIListLayout", statsBox)
        sbLay.FillDirection = Enum.FillDirection.Horizontal
        sbLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
        sbLay.VerticalAlignment = Enum.VerticalAlignment.Center

        local function makeStatBtn(labelStr, numVal, targetOverlayTab)
            local cell = Instance.new("TextButton", statsBox)
            cell.Size = UDim2.new(0.333, 0, 1, 0)
            cell.BackgroundTransparency = 1
            cell.Text = ""
            cell.ZIndex = 37
            bs.AttachBossInteractions(cell, 1.06)

            local num = Instance.new("TextLabel", cell)
            num.Size = UDim2.new(1, 0, 0, 24)
            num.Position = UDim2.new(0, 0, 0, 6)
            num.BackgroundTransparency = 1
            num.Font = Enum.Font.GothamBold
            num.TextSize = 15.5
            num.TextColor3 = themeObj.textColor
            num.Text = tostring(numVal)
            num.ZIndex = 38

            local lbl = Instance.new("TextLabel", cell)
            lbl.Size = UDim2.new(1, 0, 0, 16)
            lbl.Position = UDim2.new(0, 0, 0, 31)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 9.5
            lbl.TextColor3 = themeObj.accent
            lbl.Text = labelStr
            lbl.ZIndex = 38

            cell.MouseButton1Click:Connect(function()
                if not canOpenLists then
                    bs.TriggerSocialToast("🔒 Private List", "This user's connection list is private.", Color3.fromRGB(255, 165, 45), uidStr)
                    return
                end
                bs.OpenFollowersOverlay(uidStr, targetOverlayTab)
            end)
        end

        makeStatBtn("Followers", followerCount, "Followers")
        makeStatBtn("Following", followingCount, "Following")
        makeStatBtn("Mutuals", #mutualList, "Mutuals")

        -- DISPLAY NAME (GRADIENT) + USERNAME + ONLINE STATUS
        local identityBlock = Instance.new("Frame", heroContent)
        identityBlock.Size = UDim2.new(1, 0, 0, 38)
        identityBlock.BackgroundTransparency = 1
        identityBlock.LayoutOrder = 2
        identityBlock.ZIndex = 36

        local dispLbl = Instance.new("TextLabel", identityBlock)
        dispLbl.Size = UDim2.new(1, 0, 0, 20)
        dispLbl.BackgroundTransparency = 1
        dispLbl.Font = Enum.Font.GothamBold
        dispLbl.TextSize = 15
        dispLbl.TextXAlignment = Enum.TextXAlignment.Left
        dispLbl.ClipsDescendants = true
        dispLbl.Text = prof.displayName or prof.username
        dispLbl.ZIndex = 37
        bs.AnimEngine.ApplyGradientUsername(dispLbl, themeObj.accent, themeObj.accent2)

        local metaLbl = Instance.new("TextLabel", identityBlock)
        metaLbl.Size = UDim2.new(1, 0, 0, 15)
        metaLbl.Position = UDim2.new(0, 0, 0, 22)
        metaLbl.BackgroundTransparency = 1
        metaLbl.Font = Enum.Font.GothamMedium
        metaLbl.TextSize = 10
        metaLbl.TextColor3 = themeObj.subText
        metaLbl.TextXAlignment = Enum.TextXAlignment.Left
        metaLbl.RichText = true
        metaLbl.ClipsDescendants = true
        metaLbl.ZIndex = 37
        local onlineTxt = isOnline and "<font color='#00EB82'>● Online</font>" or "<font color='#888CA0'>○ Offline</font>"
        local privTxt = (prof.privacy and prof.privacy.isPrivate) and " • 🔒 Private" or ""
        local fbTxt = (not isMe and isFollowedBy) and " • Follows you" or ""
        metaLbl.Text = "@" .. tostring(prof.username) .. " • ID " .. uidStr .. " • " .. onlineTxt .. privTxt .. fbTxt

        -- ANIMATED PREMIUM BADGES ROW
        local badgeRow = Instance.new("Frame", heroContent)
        badgeRow.Size = UDim2.new(1, 0, 0, 22)
        badgeRow.BackgroundTransparency = 1
        badgeRow.LayoutOrder = 3
        badgeRow.ZIndex = 36
        local bLay = Instance.new("UIListLayout", badgeRow)
        bLay.FillDirection = Enum.FillDirection.Horizontal
        bLay.Padding = UDim.new(0, 5)
        bLay.VerticalAlignment = Enum.VerticalAlignment.Center

        if type(prof.badges) == "table" and #prof.badges > 0 then
            for idx, bKey in ipairs(prof.badges) do
                if idx <= 4 then
                    bs.AnimEngine.CreateAnimatedBadge(badgeRow, bKey)
                end
            end
        else
            local tag = Instance.new("TextLabel", badgeRow)
            tag.Size = UDim2.new(0, 92, 0, 18)
            tag.BackgroundColor3 = themeObj.bg1
            tag.BackgroundTransparency = 0.35
            tag.Font = Enum.Font.GothamBold
            tag.TextSize = 9.5
            tag.TextColor3 = themeObj.subText
            tag.Text = "✦ ZAYN MEMBER"
            tag.ZIndex = 37
            Instance.new("UICorner", tag).CornerRadius = UDim.new(1, 0)
        end

        -- BIO TEXT (INSIDE HERO CARD LIKE INSTAGRAM)
        local bioLbl = Instance.new("TextLabel", heroContent)
        bioLbl.Size = UDim2.new(1, 0, 0, 0)
        bioLbl.AutomaticSize = Enum.AutomaticSize.Y
        bioLbl.BackgroundTransparency = 1
        bioLbl.Font = Enum.Font.GothamMedium
        bioLbl.TextSize = 11.5
        bioLbl.TextColor3 = themeObj.textColor
        bioLbl.TextWrapped = true
        bioLbl.TextXAlignment = Enum.TextXAlignment.Left
        bioLbl.RichText = true
        bioLbl.LayoutOrder = 4
        bioLbl.ZIndex = 36

        if isBlockedBy then
            bioLbl.Text = "<font color='#FF5566'><b>🚫 Profile Restricted</b></font> — You cannot interact with this account."
        elseif isPrivateLocked then
            bioLbl.Text = "<font color='#FFB84D'><b>🔒 Private Account</b></font> — Send a follow request to connect."
        else
            bioLbl.Text = (prof.bio and prof.bio ~= "") and prof.bio or "No bio yet."
        end

        -- ================================================================= --
        -- 3. INSTAGRAM ACTION BUTTONS ROW
        -- ================================================================= --
        local actBar = Instance.new("Frame", page)
        actBar.Name = "InstaActionBar"
        actBar.Size = UDim2.new(1, 0, 0, 34)
        actBar.BackgroundTransparency = 1
        actBar.LayoutOrder = 3
        actBar.ZIndex = 35

        local actLay = Instance.new("UIListLayout", actBar)
        actLay.FillDirection = Enum.FillDirection.Horizontal
        actLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
        actLay.VerticalAlignment = Enum.VerticalAlignment.Center
        actLay.Padding = UDim.new(0, 6)
        actLay.SortOrder = Enum.SortOrder.LayoutOrder

        if isMe then
            local editorCard = bs.BuildProfileEditorCard(page, prof, themeObj)

            makeInstaBtn(actBar, "✏️ Edit Profile", themeObj.cardBg, themeObj.textColor, 0.34, 1, function()
                editorCard.Visible = not editorCard.Visible
            end)

            makeInstaBtn(actBar, "✨ Customize", themeObj.accent, Color3.fromRGB(10, 12, 18), 0.36, 2, function()
                bs.OpenCustomizePage("Decoration")
            end)

            local reqCnt = bs.SocialEngine.GetRequestCount()
            makeInstaBtn(actBar, "📩 Reqs (" .. reqCnt .. ")", Color3.fromRGB(48, 42, 76), Color3.fromRGB(255, 255, 255), 0.29, 3, function()
                bs.OpenFollowersOverlay(uidStr, "Requests")
            end)
        else
            local fLabel, fCol = "➕ Follow", Color3.fromRGB(0, 175, 230)
            if isFollowing then
                fLabel, fCol = "✓ Following", Color3.fromRGB(52, 54, 76)
            elseif hasPendingReq then
                fLabel, fCol = "⏳ Requested", Color3.fromRGB(190, 125, 25)
            elseif isFollowedBy then
                fLabel, fCol = "➕ Follow Back", Color3.fromRGB(160, 55, 235)
            end

            local followBusy = false
            makeInstaBtn(actBar, fLabel, fCol, Color3.fromRGB(255, 255, 255), 0.34, 1, function()
                if followBusy then return end
                followBusy = true
                task.spawn(function()
                    local ok, msg
                    if isFollowing then ok, msg = bs.SocialEngine.UnfollowUser(uidStr)
                    elseif hasPendingReq then ok, msg = bs.SocialEngine.CancelFollowRequest(uidStr)
                    else ok, msg = bs.SocialEngine.FollowUser(uidStr) end
                    bs.TriggerSocialToast(ok and "👥 Social" or "⚠️ Notice", msg, ok and themeObj.accent or Color3.fromRGB(235, 65, 80), uidStr)
                    followBusy = false
                    bs.RefreshProfileUI(uidStr)
                end)
            end)

            makeInstaBtn(actBar, "💬 Message", Color3.fromRGB(0, 170, 120), Color3.fromRGB(255, 255, 255), 0.29, 2, function()
                task.spawn(function()
                    local allowed, reason = bs.SocialEngine.CanMessageUser(uidStr)
                    if not allowed then
                        bs.TriggerSocialToast("🔒 DM Restricted", reason, Color3.fromRGB(235, 70, 85), uidStr)
                        return
                    end
                    bs.RegisterAccount(prof.username, prof.displayName, tonumber(uidStr) or 1)
                    local key = prof.username:lower()
                    bs.Cache.DMs[key] = bs.Cache.DMs[key] or {}
                    bs.SwitchMode("DM", key)
                end)
            end)

            makeInstaBtn(actBar, isBlocked and "🔓 Unblock" or "🚫 Block", isBlocked and Color3.fromRGB(50, 130, 195) or Color3.fromRGB(165, 38, 52), Color3.fromRGB(255, 255, 255), 0.22, 3, function()
                task.spawn(function()
                    if isBlocked then bs.SocialEngine.UnblockUser(uidStr) else bs.SocialEngine.BlockUser(uidStr) end
                    bs.RefreshProfileUI(uidStr)
                end)
            end)

            makeInstaBtn(actBar, "🚩", Color3.fromRGB(82, 44, 56), Color3.fromRGB(255, 255, 255), 0.13, 4, function()
                if bs.PromptInput then
                    bs.PromptInput("🚩 REPORT @" .. tostring(prof.username), "Reason (spam, abuse, spoof)...", "Submit", function(reason)
                        bs.SocialEngine.ReportUser(uidStr, reason)
                    end)
                end
            end)
        end

        -- ================================================================= --
        -- 4. PROFILE SHOWCASE STRIP (EQUIPPED AURA + THEME + ELITE PASS STATUS)
        -- ================================================================= --
        local showCard = Instance.new("TextButton", page)
        showCard.Name = "ShowcaseCard"
        showCard.Size = UDim2.new(1, 0, 0, 56)
        showCard.BackgroundColor3 = themeObj.cardBg
        showCard.Text = ""
        showCard.LayoutOrder = 4
        showCard.ZIndex = 33
        Instance.new("UICorner", showCard).CornerRadius = UDim.new(0, 12)
        local scSt = Instance.new("UIStroke", showCard)
        scSt.Color = hasElite and Color3.fromRGB(255, 205, 55) or themeObj.borderColor
        scSt.Transparency = 0.35
        bs.AttachBossInteractions(showCard, 1.02)

        local decorName = (prof.decoration and bs.DecorationMap[prof.decoration]) and bs.DecorationMap[prof.decoration].name or (prof.decoration ~= "none" and tostring(prof.decoration) or "Default Ring")
        local eliteLabel = hasElite and "👑 ZAYN ELITE PASS ACTIVE" or ("🔒 Upgrade to ₹" .. tostring(bs.SocialEngine.GetElitePassPrice()) .. " ZAYN ELITE PASS")

        local scTxt = Instance.new("TextLabel", showCard)
        scTxt.Size = UDim2.new(1, -24, 1, 0)
        scTxt.Position = UDim2.new(0, 12, 0, 0)
        scTxt.BackgroundTransparency = 1
        scTxt.Font = Enum.Font.GothamMedium
        scTxt.TextSize = 10.5
        scTxt.TextColor3 = themeObj.textColor
        scTxt.TextXAlignment = Enum.TextXAlignment.Left
        scTxt.RichText = true
        scTxt.ZIndex = 34
        scTxt.Text = string.format(
            "<font color='#FFD246'><b>%s</b></font>\n✨ Aura: <b>%s</b>   •   🎨 Theme: <b>%s</b>",
            eliteLabel, decorName, themeObj.name
        )

        showCard.MouseButton1Click:Connect(function()
            if isMe then
                bs.OpenCustomizePage(hasElite and "Theme" or "PremiumStore")
            else
                bs.OpenCustomizePage("PremiumStore")
            end
        end)
    end)
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 7 / 8 : 4-TAB CUSTOMIZATION UI, ₹300 ELITE PASS, ALERTS & BUBBLES
-- ========================================================================= --

-- ========================================================================= --
-- [SECTION A : BUY ₹300 ZAYN ELITE PASS DISCORD VERIFICATION MODAL]
-- (No fake payment success — guides user to official Discord + logs ticket)
-- ========================================================================= --
local function openBuyEliteModal(itemType, itemId, itemName, priceINR)
    local cG = bs.UI.MainBg
    if not cG then return end
    if cG:FindFirstChild("ZaynElitePurchaseModal") then
        cG.ZaynElitePurchaseModal:Destroy()
    end

    local cfg = bs.Social.StoreConfig
    local finalPrice = tonumber(priceINR) or bs.SocialEngine.GetElitePassPrice()
    local discordInfo = tostring(cfg.discordServer or "ZAYN UI LAB (Discord: @official_zayn)")
    local discordHandle = tostring(cfg.discordContact or "official_zayn")

    local backdrop = Instance.new("Frame", cG)
    backdrop.Name = "ZaynElitePurchaseModal"
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.45
    backdrop.Active = true
    backdrop.ZIndex = 125

    local card = Instance.new("Frame", backdrop)
    card.Size = UDim2.new(1, -34, 0, 315)
    card.Position = UDim2.new(0.5, 0, 0.5, 0)
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.BackgroundColor3 = Color3.fromRGB(14, 12, 22)
    card.ZIndex = 126
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)

    local cGrad = Instance.new("UIGradient", card)
    cGrad.Rotation = 135
    cGrad.Color = ColorSequence.new(Color3.fromRGB(14, 12, 20), Color3.fromRGB(36, 26, 12))

    local cStroke = Instance.new("UIStroke", card)
    cStroke.Color = Color3.fromRGB(255, 205, 55)
    cStroke.Thickness = 1.8

    local cScale = Instance.new("UIScale", card)
    cScale.Scale = 0.86
    g:Create(cScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.0}):Play()

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, -46, 0, 26)
    title.Position = UDim2.new(0, 14, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13.5
    title.TextColor3 = Color3.fromRGB(255, 215, 70)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "👑 BUY " .. tostring(itemName or "ZAYN ELITE PASS") .. " (₹" .. tostring(finalPrice) .. ")"
    title.ZIndex = 127

    local closeBtn = Instance.new("TextButton", card)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 42, 52)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Text = "X"
    closeBtn.ZIndex = 128
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    bs.AttachBossInteractions(closeBtn, 1.1)
    closeBtn.MouseButton1Click:Connect(function() backdrop:Destroy() end)

    local guideBox = Instance.new("Frame", card)
    guideBox.Size = UDim2.new(1, -28, 0, 88)
    guideBox.Position = UDim2.new(0, 14, 0, 42)
    guideBox.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
    guideBox.ZIndex = 127
    Instance.new("UICorner", guideBox).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", guideBox).Color = Color3.fromRGB(88, 101, 242)

    local guideLbl = Instance.new("TextLabel", guideBox)
    guideLbl.Size = UDim2.new(1, -16, 1, -8)
    guideLbl.Position = UDim2.new(0, 8, 0, 4)
    guideLbl.BackgroundTransparency = 1
    guideLbl.Font = Enum.Font.GothamMedium
    guideLbl.TextSize = 10
    guideLbl.TextColor3 = Color3.fromRGB(235, 238, 250)
    guideLbl.TextWrapped = true
    guideLbl.TextXAlignment = Enum.TextXAlignment.Left
    guideLbl.TextYAlignment = Enum.TextYAlignment.Top
    guideLbl.RichText = true
    guideLbl.ZIndex = 128
    guideLbl.Text = string.format(
        "<font color='#00E5FF'><b>OFFICIAL VERIFICATION STEPS:</b></font>\n1. Contact <b>%s</b> on Discord.\n2. Complete ₹%d payment & send receipt with your Roblox ID (<b>%s</b>).\n3. Submit ticket below — Admin verifies payment & unlocks permanently.",
        discordInfo, finalPrice, bs.Social.MyUid
    )

    local copyRow = Instance.new("Frame", card)
    copyRow.Size = UDim2.new(1, -28, 0, 28)
    copyRow.Position = UDim2.new(0, 14, 0, 138)
    copyRow.BackgroundTransparency = 1
    copyRow.ZIndex = 127

    local copyDiscordBtn = Instance.new("TextButton", copyRow)
    copyDiscordBtn.Size = UDim2.new(0.49, 0, 1, 0)
    copyDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    copyDiscordBtn.Font = Enum.Font.GothamBold
    copyDiscordBtn.TextSize = 10
    copyDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyDiscordBtn.Text = "📋 Copy Discord (@" .. discordHandle .. ")"
    copyDiscordBtn.ZIndex = 128
    Instance.new("UICorner", copyDiscordBtn).CornerRadius = UDim.new(0, 7)
    bs.AttachBossInteractions(copyDiscordBtn, 1.04)
    copyDiscordBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local clip = setclipboard or toclipboard
            if clip then clip(discordHandle) end
        end)
        bs.TriggerSocialToast("📋 Discord Copied", "Copied @" .. discordHandle .. " to clipboard!", Color3.fromRGB(88, 101, 242), bs.Social.MyUid)
    end)

    local copyUidBtn = Instance.new("TextButton", copyRow)
    copyUidBtn.Size = UDim2.new(0.49, 0, 1, 0)
    copyUidBtn.Position = UDim2.new(0.51, 0, 0, 0)
    copyUidBtn.BackgroundColor3 = Color3.fromRGB(40, 44, 68)
    copyUidBtn.Font = Enum.Font.GothamBold
    copyUidBtn.TextSize = 10
    copyUidBtn.TextColor3 = Color3.fromRGB(240, 245, 255)
    copyUidBtn.Text = "🆔 Copy My ID (" .. bs.Social.MyUid .. ")"
    copyUidBtn.ZIndex = 128
    Instance.new("UICorner", copyUidBtn).CornerRadius = UDim.new(0, 7)
    bs.AttachBossInteractions(copyUidBtn, 1.04)
    copyUidBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local clip = setclipboard or toclipboard
            if clip then clip(bs.Social.MyUid) end
        end)
        bs.TriggerSocialToast("🆔 User ID Copied", "Copied " .. bs.Social.MyUid .. " to clipboard!", Color3.fromRGB(0, 225, 255), bs.Social.MyUid)
    end)

    local discInput = Instance.new("TextBox", card)
    discInput.Size = UDim2.new(1, -28, 0, 32)
    discInput.Position = UDim2.new(0, 14, 0, 174)
    discInput.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
    discInput.Font = Enum.Font.GothamMedium
    discInput.TextSize = 11
    discInput.TextColor3 = Color3.fromRGB(245, 245, 255)
    discInput.PlaceholderText = "Your Discord username (required for verification)..."
    discInput.PlaceholderColor3 = Color3.fromRGB(130, 135, 160)
    discInput.ClearTextOnFocus = false
    discInput.TextXAlignment = Enum.TextXAlignment.Left
    discInput.Text = ""
    discInput.ZIndex = 128
    Instance.new("UICorner", discInput).CornerRadius = UDim.new(0, 8)
    Instance.new("UIPadding", discInput).PaddingLeft = UDim.new(0, 10)

    local noteInput = Instance.new("TextBox", card)
    noteInput.Size = UDim2.new(1, -28, 0, 32)
    noteInput.Position = UDim2.new(0, 14, 0, 212)
    noteInput.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
    noteInput.Font = Enum.Font.GothamMedium
    noteInput.TextSize = 11
    noteInput.TextColor3 = Color3.fromRGB(245, 245, 255)
    noteInput.PlaceholderText = "Optional note / UPI ref (verified manually by Admin)..."
    noteInput.PlaceholderColor3 = Color3.fromRGB(130, 135, 160)
    noteInput.ClearTextOnFocus = false
    noteInput.TextXAlignment = Enum.TextXAlignment.Left
    noteInput.Text = ""
    noteInput.ZIndex = 128
    Instance.new("UICorner", noteInput).CornerRadius = UDim.new(0, 8)
    Instance.new("UIPadding", noteInput).PaddingLeft = UDim.new(0, 10)

    local submitBtn = Instance.new("TextButton", card)
    submitBtn.Size = UDim2.new(1, -28, 0, 36)
    submitBtn.Position = UDim2.new(0, 14, 1, -48)
    submitBtn.BackgroundColor3 = Color3.fromRGB(240, 185, 35)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 11.5
    submitBtn.TextColor3 = Color3.fromRGB(14, 12, 8)
    submitBtn.Text = "📩 SUBMIT VERIFICATION TICKET (NO INSTANT FAKE UNLOCK)"
    submitBtn.ZIndex = 128
    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 9)
    bs.AttachBossInteractions(submitBtn, 1.03)

    local subBusy = false
    submitBtn.MouseButton1Click:Connect(function()
        if subBusy then return end
        subBusy = true
        submitBtn.Text = "⏳ Submitting ticket..."
        task.spawn(function()
            local ok, resMsg = bs.SocialEngine.SubmitPurchaseRequest(itemType or "elite_pass", itemId or "zayn_elite_pass", discInput.Text, noteInput.Text)
            subBusy = false
            if ok then
                pcall(function()
                    local clip = setclipboard or toclipboard
                    if clip then clip(resMsg) end
                end)
                backdrop:Destroy()
                bs.TriggerSocialToast("🧾 Ticket Created", "Ticket " .. resMsg .. " copied! DM @" .. discordHandle .. " on Discord for admin verification.", Color3.fromRGB(255, 210, 60), bs.Social.MyUid)
            else
                if submitBtn and submitBtn.Parent then
                    submitBtn.Text = "📩 SUBMIT VERIFICATION TICKET"
                end
                bs.TriggerSocialToast("⚠️ Ticket Error", tostring(resMsg), Color3.fromRGB(235, 65, 80), bs.Social.MyUid)
            end
        end)
    end)
end

-- ========================================================================= --
-- [SECTION B : 4-TAB PROFILE CUSTOMIZATION UI (LIVE PREVIEW STAGE)]
-- Tabs: Avatar | Decoration | Theme | Premium Store
-- ========================================================================= --
function bs.BuildCustomizePage(cG)
    local panel = Instance.new("Frame", cG)
    panel.Name = "ZaynCustomizePage"
    panel.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH))
    panel.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    panel.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
    panel.BorderSizePixel = 0
    panel.Visible = false
    panel.ZIndex = 30
    bs.UI.CustomizePage = panel

    -- TOP LIVE PREVIEW STAGE (Shows real-time preview of selected Decoration & Theme!)
    local previewStage = Instance.new("Frame", panel)
    previewStage.Name = "LivePreviewStage"
    previewStage.Size = UDim2.new(1, -24, 0, 86)
    previewStage.Position = UDim2.new(0, 12, 0, 8)
    previewStage.BackgroundColor3 = Color3.fromRGB(16, 14, 24)
    previewStage.ZIndex = 32
    Instance.new("UICorner", previewStage).CornerRadius = UDim.new(0, 12)
    bs.UI.CustomPreviewStage = previewStage

    local pvGrad = Instance.new("UIGradient", previewStage)
    pvGrad.Rotation = 135
    pvGrad.Color = ColorSequence.new(Color3.fromRGB(10, 9, 12), Color3.fromRGB(36, 26, 10))
    bs.UI.CustomPreviewGrad = pvGrad

    local pvAvatarWrap = Instance.new("Frame", previewStage)
    pvAvatarWrap.Name = "PreviewAvatarHolder"
    pvAvatarWrap.Size = UDim2.new(0, 56, 0, 56)
    pvAvatarWrap.Position = UDim2.new(0, 14, 0.5, -28)
    pvAvatarWrap.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    pvAvatarWrap.ZIndex = 35
    Instance.new("UICorner", pvAvatarWrap).CornerRadius = UDim.new(1, 0)
    bs.UI.CustomPreviewAvatar = pvAvatarWrap

    local pvImg = Instance.new("ImageLabel", pvAvatarWrap)
    pvImg.Size = UDim2.new(1, -4, 1, -4)
    pvImg.Position = UDim2.new(0.5, 0, 0.5, 0)
    pvImg.AnchorPoint = Vector2.new(0.5, 0.5)
    pvImg.BackgroundTransparency = 1
    pvImg.ScaleType = Enum.ScaleType.Crop
    pvImg.ZIndex = 36
    Instance.new("UICorner", pvImg).CornerRadius = UDim.new(1, 0)
    bs.LoadHeadshotByUid(pvImg, bs.Social.MyUid)

    local pvName = Instance.new("TextLabel", previewStage)
    pvName.Size = UDim2.new(1, -162, 0, 20)
    pvName.Position = UDim2.new(0, 84, 0, 12)
    pvName.BackgroundTransparency = 1
    pvName.Font = Enum.Font.GothamBold
    pvName.TextSize = 13.5
    pvName.TextXAlignment = Enum.TextXAlignment.Left
    pvName.ClipsDescendants = true
    pvName.Text = m.DisplayName
    pvName.ZIndex = 35
    bs.UI.CustomPreviewName = pvName

    local pvInfo = Instance.new("TextLabel", previewStage)
    pvInfo.Size = UDim2.new(1, -162, 0, 30)
    pvInfo.Position = UDim2.new(0, 84, 0, 34)
    pvInfo.BackgroundTransparency = 1
    pvInfo.Font = Enum.Font.GothamMedium
    pvInfo.TextSize = 10
    pvInfo.TextColor3 = Color3.fromRGB(190, 195, 220)
    pvInfo.TextXAlignment = Enum.TextXAlignment.Left
    pvInfo.TextWrapped = true
    pvInfo.RichText = true
    pvInfo.ZIndex = 35
    bs.UI.CustomPreviewInfo = pvInfo

    local pvActionBtn = Instance.new("TextButton", previewStage)
    pvActionBtn.Size = UDim2.new(0, 68, 0, 26)
    pvActionBtn.Position = UDim2.new(1, -78, 0.5, -13)
    pvActionBtn.BackgroundColor3 = Color3.fromRGB(52, 48, 76)
    pvActionBtn.Font = Enum.Font.GothamBold
    pvActionBtn.TextSize = 9.5
    pvActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    pvActionBtn.Text = "↺ Reset"
    pvActionBtn.Visible = false
    pvActionBtn.ZIndex = 37
    Instance.new("UICorner", pvActionBtn).CornerRadius = UDim.new(0, 7)
    bs.AttachBossInteractions(pvActionBtn, 1.06)
    pvActionBtn.MouseButton1Click:Connect(function()
        bs.Social.PreviewDecoration = nil
        bs.Social.PreviewTheme = nil
        bs.RefreshCustomizeUI()
    end)
    bs.UI.CustomResetPreviewBtn = pvActionBtn

    -- 4 CLEAN TABS: Avatar | Decoration | Theme | Premium Store
    local tabBar = Instance.new("Frame", panel)
    tabBar.Size = UDim2.new(1, -24, 0, 30)
    tabBar.Position = UDim2.new(0, 12, 0, 100)
    tabBar.BackgroundTransparency = 1
    tabBar.ZIndex = 32

    local tLay = Instance.new("UIListLayout", tabBar)
    tLay.FillDirection = Enum.FillDirection.Horizontal
    tLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tLay.VerticalAlignment = Enum.VerticalAlignment.Center
    tLay.Padding = UDim.new(0, 5)
    tLay.SortOrder = Enum.SortOrder.LayoutOrder

    bs.UI.CustomTabBtns = {}
    local tabDefs = {
        {id = "Avatar",       lbl = "👤 Avatar",     ord = 1},
        {id = "Decoration",   lbl = "✨ Decoration", ord = 2},
        {id = "Theme",        lbl = "🎨 Theme",      ord = 3},
        {id = "PremiumStore", lbl = "👑 ₹300 Pass",  ord = 4}
    }

    for _, td in ipairs(tabDefs) do
        local tb = Instance.new("TextButton", tabBar)
        tb.Size = UDim2.new(0.242, 0, 1, 0)
        tb.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
        tb.Font = Enum.Font.GothamBold
        tb.TextSize = 9.5
        tb.TextColor3 = Color3.fromRGB(185, 190, 215)
        tb.Text = td.lbl
        tb.LayoutOrder = td.ord
        tb.ZIndex = 33
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(tb, 1.04)
        tb.MouseButton1Click:Connect(function()
            bs.Social.CustomTab = td.id
            bs.RefreshCustomizeUI()
        end)
        bs.UI.CustomTabBtns[td.id] = tb
    end

    -- CONTENT SCROLLING CONTAINER
    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Name = "CustomizeContentScroll"
    scroll.Size = UDim2.new(1, -24, 1, -142)
    scroll.Position = UDim2.new(0, 12, 0, 136)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 205, 55)
    scroll.ZIndex = 32
    bs.UI.CustomScroll = scroll

    local sLay = Instance.new("UIListLayout", scroll)
    sLay.Padding = UDim.new(0, 8)
    sLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sLay.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", scroll).PaddingTop = UDim.new(0, 3)
    Instance.new("UIPadding", scroll).PaddingBottom = UDim.new(0, 12)

    sLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, sLay.AbsoluteContentSize.Y + 18)
    end)
end

local function updateCustomLivePreview(prof, hasElite)
    local stage = bs.UI.CustomPreviewStage
    if not stage then return end

    local activeThemeId = bs.Social.PreviewTheme or (prof and prof.theme) or "royal_black_gold"
    local activeDecorId = bs.Social.PreviewDecoration
    if activeDecorId == nil then
        activeDecorId = (prof and prof.decoration) or "none"
    end

    local themeObj = bs.SocialEngine.ResolveThemeObject(activeThemeId)
    local decorObj = bs.DecorationMap[activeDecorId]
    local isPreviewing = (bs.Social.PreviewTheme ~= nil) or (bs.Social.PreviewDecoration ~= nil)

    stage.BackgroundColor3 = themeObj.bg1
    if bs.UI.CustomPreviewGrad then
        bs.UI.CustomPreviewGrad.Color = ColorSequence.new(themeObj.bg1, themeObj.bg2)
    end

    bs.AnimEngine.ApplyProfileFrameEffect(stage, themeObj, hasElite or isPreviewing)
    bs.AnimEngine.AttachFloatingParticles(stage, themeObj.particleColor, 8)
    bs.AnimEngine.ApplyAvatarEffect(bs.UI.CustomPreviewAvatar, activeDecorId, false)

    if bs.UI.CustomPreviewName then
        bs.UI.CustomPreviewName.Text = (prof and prof.displayName) or m.DisplayName
        bs.AnimEngine.ApplyGradientUsername(bs.UI.CustomPreviewName, themeObj.accent, themeObj.accent2)
    end

    if bs.UI.CustomPreviewInfo then
        local modeTag = isPreviewing and "<font color='#FFD246'><b>LIVE PREVIEW</b></font>" or "<font color='#00EB82'><b>CURRENTLY EQUIPPED</b></font>"
        local dName = decorObj and decorObj.name or (activeDecorId ~= "none" and activeDecorId or "None")
        bs.UI.CustomPreviewInfo.Text = string.format("%s\n✨ %s  •  🎨 %s", modeTag, dName, themeObj.name)
    end

    if bs.UI.CustomResetPreviewBtn then
        bs.UI.CustomResetPreviewBtn.Visible = isPreviewing
    end
end

local function renderAvatarTab(scroll, prof, hasElite)
    local card = Instance.new("Frame", scroll)
    card.Size = UDim2.new(1, -6, 0, 128)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 28)
    card.ZIndex = 33
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", card).Color = Color3.fromRGB(52, 56, 84)

    local info = Instance.new("TextLabel", card)
    info.Size = UDim2.new(1, -24, 0, 62)
    info.Position = UDim2.new(0, 12, 0, 10)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.GothamMedium
    info.TextSize = 11
    info.TextColor3 = Color3.fromRGB(230, 234, 248)
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextWrapped = true
    info.RichText = true
    info.ZIndex = 34
    local curDecor = (prof and prof.decoration and bs.DecorationMap[prof.decoration]) and bs.DecorationMap[prof.decoration].name or "Default Ring"
    local curTheme = bs.SocialEngine.ResolveThemeObject(prof and prof.theme or "royal_black_gold").name
    info.Text = string.format(
        "<b>👤 Roblox Avatar Synced:</b> @%s (ID: %s)\n<b>✨ Active Decoration:</b> %s\n<b>🎨 Active Profile Theme:</b> %s\n<b>👑 Status:</b> %s",
        m.Name, bs.Social.MyUid, curDecor, curTheme, hasElite and "<font color='#FFD246'>ZAYN ELITE PASS ACTIVE</font>" or "Standard Member"
    )

    local row = Instance.new("Frame", card)
    row.Size = UDim2.new(1, -24, 0, 32)
    row.Position = UDim2.new(0, 12, 1, -42)
    row.BackgroundTransparency = 1
    row.ZIndex = 34
    local rLay = Instance.new("UIListLayout", row)
    rLay.FillDirection = Enum.FillDirection.Horizontal
    rLay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    rLay.Padding = UDim.new(0, 6)

    local function avBtn(txt, w, col, fn)
        local b = Instance.new("TextButton", row)
        b.Size = UDim2.new(w, -4, 1, 0)
        b.BackgroundColor3 = col
        b.Font = Enum.Font.GothamBold
        b.TextSize = 10
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Text = txt
        b.ZIndex = 35
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        bs.AttachBossInteractions(b, 1.05)
        b.MouseButton1Click:Connect(fn)
    end

    avBtn("✨ Pick Aura", 0.34, Color3.fromRGB(0, 170, 225), function()
        bs.Social.CustomTab = "Decoration"; bs.RefreshCustomizeUI()
    end)
    avBtn("🎨 Pick Theme", 0.34, Color3.fromRGB(150, 55, 230), function()
        bs.Social.CustomTab = "Theme"; bs.RefreshCustomizeUI()
    end)
    avBtn("✖ Remove Aura", 0.32, Color3.fromRGB(165, 42, 58), function()
        task.spawn(function() bs.SocialEngine.EquipDecoration("none") end)
    end)
end

local function renderDecorationTab(scroll, prof)
    local equippedId = (prof and prof.decoration) or "none"
    local list = bs.SocialEngine.GetAllDecorations(false)

    for idx, decor in ipairs(list) do
        local isOwned = bs.SocialEngine.OwnsDecoration(bs.Social.MyUid, decor.id)
        local isEquipped = (equippedId == decor.id)
        local price = bs.SocialEngine.GetDecorationPrice(decor.id)

        local card = Instance.new("Frame", scroll)
        card.Name = "DecorCard_" .. decor.id
        card.Size = UDim2.new(1, -6, 0, 74)
        card.BackgroundColor3 = Color3.fromRGB(16, 15, 28)
        card.LayoutOrder = idx
        card.ZIndex = 33
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
        local st = Instance.new("UIStroke", card)
        st.Color = isEquipped and Color3.fromRGB(0, 235, 155) or decor.accent
        st.Thickness = isEquipped and 1.8 or 1.1
        st.Transparency = isEquipped and 0 or 0.45

        -- Live mini animated preview
        local miniAv = Instance.new("Frame", card)
        miniAv.Size = UDim2.new(0, 44, 0, 44)
        miniAv.Position = UDim2.new(0, 12, 0.5, -22)
        miniAv.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
        miniAv.ZIndex = 35
        Instance.new("UICorner", miniAv).CornerRadius = UDim.new(1, 0)

        local miniImg = Instance.new("ImageLabel", miniAv)
        miniImg.Size = UDim2.new(1, -4, 1, -4)
        miniImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        miniImg.AnchorPoint = Vector2.new(0.5, 0.5)
        miniImg.BackgroundTransparency = 1
        miniImg.ScaleType = Enum.ScaleType.Crop
        miniImg.ZIndex = 36
        Instance.new("UICorner", miniImg).CornerRadius = UDim.new(1, 0)
        bs.LoadHeadshotByUid(miniImg, bs.Social.MyUid)
        bs.AnimEngine.ApplyAvatarEffect(miniAv, decor.id, true)

        local tLbl = Instance.new("TextLabel", card)
        tLbl.Size = UDim2.new(1, -214, 0, 18)
        tLbl.Position = UDim2.new(0, 68, 0, 8)
        tLbl.BackgroundTransparency = 1
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 12
        tLbl.TextColor3 = Color3.fromRGB(248, 248, 255)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.ClipsDescendants = true
        tLbl.Text = decor.name
        tLbl.ZIndex = 35

        local dLbl = Instance.new("TextLabel", card)
        dLbl.Size = UDim2.new(1, -214, 0, 24)
        dLbl.Position = UDim2.new(0, 68, 0, 26)
        dLbl.BackgroundTransparency = 1
        dLbl.Font = Enum.Font.GothamMedium
        dLbl.TextSize = 9.5
        dLbl.TextColor3 = Color3.fromRGB(165, 170, 198)
        dLbl.TextXAlignment = Enum.TextXAlignment.Left
        dLbl.TextWrapped = true
        dLbl.ClipsDescendants = true
        dLbl.Text = decor.description
        dLbl.ZIndex = 35

        local sLbl = Instance.new("TextLabel", card)
        sLbl.Size = UDim2.new(1, -214, 0, 14)
        sLbl.Position = UDim2.new(0, 68, 1, -17)
        sLbl.BackgroundTransparency = 1
        sLbl.Font = Enum.Font.GothamBold
        sLbl.TextSize = 9
        sLbl.TextColor3 = isOwned and Color3.fromRGB(0, 235, 155) or Color3.fromRGB(255, 205, 65)
        sLbl.TextXAlignment = Enum.TextXAlignment.Left
        sLbl.Text = isEquipped and "● EQUIPPED" or (isOwned and "✓ OWNED" or ("🔒 LOCKED • ₹" .. tostring(price) .. " Elite Pass"))
        sLbl.ZIndex = 35

        -- Preview Button
        local pvBtn = Instance.new("TextButton", card)
        pvBtn.Size = UDim2.new(0, 58, 0, 28)
        pvBtn.Position = UDim2.new(1, -138, 0.5, -14)
        pvBtn.BackgroundColor3 = Color3.fromRGB(44, 42, 68)
        pvBtn.Font = Enum.Font.GothamBold
        pvBtn.TextSize = 9.5
        pvBtn.TextColor3 = Color3.fromRGB(235, 240, 255)
        pvBtn.Text = "👁️ Try"
        pvBtn.ZIndex = 37
        Instance.new("UICorner", pvBtn).CornerRadius = UDim.new(0, 7)
        bs.AttachBossInteractions(pvBtn, 1.06)
        pvBtn.MouseButton1Click:Connect(function()
            bs.Social.PreviewDecoration = decor.id
            bs.RefreshCustomizeUI()
        end)

        -- Apply / Remove / Unlock Button
        local actBtn = Instance.new("TextButton", card)
        actBtn.Size = UDim2.new(0, 70, 0, 28)
        actBtn.Position = UDim2.new(1, -76, 0.5, -14)
        actBtn.Font = Enum.Font.GothamBold
        actBtn.TextSize = 9.5
        actBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        actBtn.ZIndex = 37
        Instance.new("UICorner", actBtn).CornerRadius = UDim.new(0, 7)
        bs.AttachBossInteractions(actBtn, 1.06)

        if isEquipped then
            actBtn.BackgroundColor3 = Color3.fromRGB(165, 42, 58)
            actBtn.Text = "Remove"
        elseif isOwned then
            actBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 125)
            actBtn.Text = "Apply"
        else
            actBtn.BackgroundColor3 = Color3.fromRGB(215, 155, 25)
            actBtn.TextColor3 = Color3.fromRGB(14, 12, 8)
            actBtn.Text = "🔒 Unlock"
        end

        actBtn.MouseButton1Click:Connect(function()
            if isEquipped then
                task.spawn(function() bs.SocialEngine.EquipDecoration("none") end)
            elseif isOwned then
                task.spawn(function()
                    local ok, msg = bs.SocialEngine.EquipDecoration(decor.id)
                    if not ok then bs.TriggerSocialToast("⚠️ Error", msg, Color3.fromRGB(235, 65, 80), bs.Social.MyUid) end
                end)
            else
                openBuyEliteModal("elite_pass", "zayn_elite_pass", "ZAYN ELITE PASS", bs.SocialEngine.GetElitePassPrice())
            end
        end)
    end
end

local function renderThemeTab(scroll, prof)
    local equippedId = (prof and prof.theme) or "royal_black_gold"
    local list = bs.SocialEngine.GetAllThemes(false)

    for idx, tItem in ipairs(list) do
        local isOwned = bs.SocialEngine.OwnsTheme(bs.Social.MyUid, tItem.id)
        local isEquipped = (equippedId == tItem.id)
        local price = bs.SocialEngine.GetThemePrice(tItem.id)

        local card = Instance.new("Frame", scroll)
        card.Name = "ThemeCard_" .. tItem.id
        card.Size = UDim2.new(1, -6, 0, 74)
        card.BackgroundColor3 = tItem.bg1
        card.LayoutOrder = idx
        card.ZIndex = 33
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

        local cGrad = Instance.new("UIGradient", card)
        cGrad.Rotation = 135
        cGrad.Color = ColorSequence.new(tItem.bg1, tItem.bg2)

        local st = Instance.new("UIStroke", card)
        st.Color = isEquipped and Color3.fromRGB(0, 235, 155) or tItem.borderColor
        st.Thickness = isEquipped and 1.8 or 1.2
        st.Transparency = isEquipped and 0 or 0.35

        -- Color Swatch Preview Orb
        local swatch = Instance.new("Frame", card)
        swatch.Size = UDim2.new(0, 38, 0, 38)
        swatch.Position = UDim2.new(0, 12, 0.5, -19)
        swatch.BackgroundColor3 = tItem.accent
        swatch.ZIndex = 35
        Instance.new("UICorner", swatch).CornerRadius = UDim.new(1, 0)
        Instance.new("UIGradient", swatch).Color = ColorSequence.new(tItem.accent, tItem.accent2)
        Instance.new("UIStroke", swatch).Color = Color3.fromRGB(255, 255, 255)

        local tLbl = Instance.new("TextLabel", card)
        tLbl.Size = UDim2.new(1, -206, 0, 18)
        tLbl.Position = UDim2.new(0, 62, 0, 8)
        tLbl.BackgroundTransparency = 1
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 12
        tLbl.TextColor3 = tItem.textColor
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.ClipsDescendants = true
        tLbl.Text = tItem.name
        tLbl.ZIndex = 35

        local dLbl = Instance.new("TextLabel", card)
        dLbl.Size = UDim2.new(1, -206, 0, 24)
        dLbl.Position = UDim2.new(0, 62, 0, 26)
        dLbl.BackgroundTransparency = 1
        dLbl.Font = Enum.Font.GothamMedium
        dLbl.TextSize = 9.5
        dLbl.TextColor3 = tItem.subText
        dLbl.TextXAlignment = Enum.TextXAlignment.Left
        dLbl.TextWrapped = true
        dLbl.ClipsDescendants = true
        dLbl.Text = tItem.description
        dLbl.ZIndex = 35

        local sLbl = Instance.new("TextLabel", card)
        sLbl.Size = UDim2.new(1, -206, 0, 14)
        sLbl.Position = UDim2.new(0, 62, 1, -17)
        sLbl.BackgroundTransparency = 1
        sLbl.Font = Enum.Font.GothamBold
        sLbl.TextSize = 9
        sLbl.TextColor3 = isOwned and Color3.fromRGB(0, 235, 155) or Color3.fromRGB(255, 205, 65)
        sLbl.TextXAlignment = Enum.TextXAlignment.Left
        sLbl.Text = isEquipped and "● ACTIVE THEME" or (isOwned and "✓ OWNED" or ("🔒 LOCKED • ₹" .. tostring(price) .. " Elite Pass"))
        sLbl.ZIndex = 35

        local pvBtn = Instance.new("TextButton", card)
        pvBtn.Size = UDim2.new(0, 58, 0, 28)
        pvBtn.Position = UDim2.new(1, -138, 0.5, -14)
        pvBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 56)
        pvBtn.Font = Enum.Font.GothamBold
        pvBtn.TextSize = 9.5
        pvBtn.TextColor3 = Color3.fromRGB(240, 245, 255)
        pvBtn.Text = "👁️ Try"
        pvBtn.ZIndex = 37
        Instance.new("UICorner", pvBtn).CornerRadius = UDim.new(0, 7)
        bs.AttachBossInteractions(pvBtn, 1.06)
        pvBtn.MouseButton1Click:Connect(function()
            bs.Social.PreviewTheme = tItem.id
            bs.RefreshCustomizeUI()
        end)

        local actBtn = Instance.new("TextButton", card)
        actBtn.Size = UDim2.new(0, 70, 0, 28)
        actBtn.Position = UDim2.new(1, -76, 0.5, -14)
        actBtn.Font = Enum.Font.GothamBold
        actBtn.TextSize = 9.5
        actBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        actBtn.ZIndex = 37
        Instance.new("UICorner", actBtn).CornerRadius = UDim.new(0, 7)
        bs.AttachBossInteractions(actBtn, 1.06)

        if isEquipped then
            actBtn.BackgroundColor3 = Color3.fromRGB(48, 56, 72)
            actBtn.Text = "Active"
        elseif isOwned then
            actBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 125)
            actBtn.Text = "Apply"
        else
            actBtn.BackgroundColor3 = Color3.fromRGB(215, 155, 25)
            actBtn.TextColor3 = Color3.fromRGB(14, 12, 8)
            actBtn.Text = "🔒 Unlock"
        end

        actBtn.MouseButton1Click:Connect(function()
            if isEquipped then return end
            if isOwned then
                task.spawn(function()
                    local ok, msg = bs.SocialEngine.EquipTheme(tItem.id)
                    if not ok then bs.TriggerSocialToast("⚠️ Error", msg, Color3.fromRGB(235, 65, 80), bs.Social.MyUid) end
                end)
            else
                openBuyEliteModal("elite_pass", "zayn_elite_pass", "ZAYN ELITE PASS", bs.SocialEngine.GetElitePassPrice())
            end
        end)
    end
end

local function renderPremiumStoreTab(scroll, hasElite)
    local passPrice = bs.SocialEngine.GetElitePassPrice()
    local cfg = bs.Social.StoreConfig

    local passCard = Instance.new("Frame", scroll)
    passCard.Name = "ElitePassBanner"
    passCard.Size = UDim2.new(1, -6, 0, 206)
    passCard.BackgroundColor3 = Color3.fromRGB(16, 12, 22)
    passCard.ZIndex = 33
    Instance.new("UICorner", passCard).CornerRadius = UDim.new(0, 14)

    local pGrad = Instance.new("UIGradient", passCard)
    pGrad.Rotation = 135
    pGrad.Color = ColorSequence.new(Color3.fromRGB(14, 10, 22), Color3.fromRGB(48, 32, 12))

    bs.AnimEngine.ApplyProfileFrameEffect(passCard, bs.ProfileThemeMap.royal_black_gold, true)
    bs.AnimEngine.AttachFloatingParticles(passCard, Color3.fromRGB(255, 215, 80), 10)

    local hdr = Instance.new("TextLabel", passCard)
    hdr.Size = UDim2.new(1, -24, 0, 24)
    hdr.Position = UDim2.new(0, 12, 0, 10)
    hdr.BackgroundTransparency = 1
    hdr.Font = Enum.Font.GothamBold
    hdr.TextSize = 14.5
    hdr.TextXAlignment = Enum.TextXAlignment.Left
    hdr.Text = "👑 ₹" .. tostring(passPrice) .. " ZAYN ELITE PASS"
    hdr.ZIndex = 36
    bs.AnimEngine.ApplyGradientUsername(hdr, Color3.fromRGB(255, 220, 80), Color3.fromRGB(0, 235, 255))

    local perks = Instance.new("TextLabel", passCard)
    perks.Size = UDim2.new(1, -24, 0, 106)
    perks.Position = UDim2.new(0, 12, 0, 38)
    perks.BackgroundTransparency = 1
    perks.Font = Enum.Font.GothamMedium
    perks.TextSize = 10.5
    perks.TextColor3 = Color3.fromRGB(242, 240, 250)
    perks.TextXAlignment = Enum.TextXAlignment.Left
    perks.TextYAlignment = Enum.TextYAlignment.Top
    perks.TextWrapped = true
    perks.RichText = true
    perks.ZIndex = 36
    perks.Text = table.concat({
        "✦ <b>All 12 Premium Avatar Decorations</b> (Royal Gold, Galaxy King, Fire Lord, Cosmic Energy...)",
        "✦ <b>All 10 Exclusive Profile Themes</b> (Cyberpunk Neon, Blood Moon, Diamond Luxury...)",
        "✦ <b>Animated Profile Frames & Floating Particles</b>",
        "✦ <b>Permanent Animated VIP ELITE Badge</b> on your Profile",
        "<font color='#00E5FF'>💬 Verified manually via " .. tostring(cfg.discordServer) .. "</font>"
    }, "\n")

    local buyBtn = Instance.new("TextButton", passCard)
    buyBtn.Size = UDim2.new(1, -24, 0, 38)
    buyBtn.Position = UDim2.new(0, 12, 1, -48)
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.TextSize = 12
    buyBtn.ZIndex = 37
    Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0, 9)
    bs.AttachBossInteractions(buyBtn, 1.03)

    if hasElite then
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 125)
        buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyBtn.Text = "✅ ZAYN ELITE PASS OWNED & ACTIVE"
        buyBtn.MouseButton1Click:Connect(function()
            bs.Social.CustomTab = "Decoration"
            bs.RefreshCustomizeUI()
        end)
    else
        buyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 45)
        buyBtn.TextColor3 = Color3.fromRGB(16, 12, 6)
        buyBtn.Text = "👑 BUY PREMIUM — ₹" .. tostring(passPrice) .. " (OFFICIAL DISCORD)"
        buyBtn.MouseButton1Click:Connect(function()
            openBuyEliteModal("elite_pass", "zayn_elite_pass", "ZAYN ELITE PASS", passPrice)
        end)
    end

    if au() then
        local admBtn = Instance.new("TextButton", scroll)
        admBtn.Size = UDim2.new(1, -6, 0, 34)
        admBtn.BackgroundColor3 = Color3.fromRGB(64, 34, 105)
        admBtn.Font = Enum.Font.GothamBold
        admBtn.TextSize = 11
        admBtn.TextColor3 = Color3.fromRGB(255, 225, 110)
        admBtn.Text = "⚡ OPEN ADMIN VERIFICATION & STORE MANAGER"
        admBtn.ZIndex = 35
        Instance.new("UICorner", admBtn).CornerRadius = UDim.new(0, 9)
        bs.AttachBossInteractions(admBtn, 1.03)
        admBtn.MouseButton1Click:Connect(function()
            if bs.OpenAdminConsole then bs.OpenAdminConsole() end
        end)
    end
end

function bs.RefreshCustomizeUI()
    local scroll = bs.UI.CustomScroll
    if not scroll then return end

    local activeTab = bs.Social.CustomTab or "Avatar"
    for tId, tb in pairs(bs.UI.CustomTabBtns or {}) do
        if tId == activeTab then
            tb.BackgroundColor3 = (tId == "PremiumStore") and Color3.fromRGB(235, 175, 35) or Color3.fromRGB(150, 48, 235)
            tb.TextColor3 = (tId == "PremiumStore") and Color3.fromRGB(16, 12, 6) or Color3.fromRGB(255, 255, 255)
        else
            tb.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
            tb.TextColor3 = Color3.fromRGB(180, 185, 210)
        end
    end

    for _, ch in pairs(scroll:GetChildren()) do
        if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
    end

    local prof = bs.Social.Profiles[bs.Social.MyUid] or bs.SocialEngine.BuildDefaultProfile(bs.Social.MyUid, m.Name, m.DisplayName)
    local hasElite = bs.SocialEngine.HasElitePass(bs.Social.MyUid)

    updateCustomLivePreview(prof, hasElite)

    if activeTab == "Avatar" then
        renderAvatarTab(scroll, prof, hasElite)
    elseif activeTab == "Decoration" then
        renderDecorationTab(scroll, prof)
    elseif activeTab == "Theme" then
        renderThemeTab(scroll, prof)
    elseif activeTab == "PremiumStore" then
        renderPremiumStoreTab(scroll, hasElite)
    end
end

-- ========================================================================= --
-- [SECTION C : SOCIAL NOTIFICATIONS PAGE]
-- ========================================================================= --
local function formatTimeAgo(ts)
    local diff = math.max(0, aB() - (tonumber(ts) or aB()))
    if diff < 60 then return "Just now"
    elseif diff < 3600 then return tostring(math.floor(diff / 60)) .. "m ago"
    elseif diff < 86400 then return tostring(math.floor(diff / 3600)) .. "h ago"
    else return tostring(math.floor(diff / 86400)) .. "d ago" end
end

function bs.BuildNotificationsPage(cG)
    local panel = Instance.new("Frame", cG)
    panel.Name = "ZaynNotifsPage"
    panel.Size = UDim2.new(1, 0, 1, -(bs.Layout.HeaderH + bs.Layout.NavH))
    panel.Position = UDim2.new(0, 0, 0, bs.Layout.HeaderH)
    panel.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
    panel.BorderSizePixel = 0
    panel.Visible = false
    panel.ZIndex = 30
    bs.UI.NotifsPage = panel

    local topBar = Instance.new("Frame", panel)
    topBar.Size = UDim2.new(1, -24, 0, 32)
    topBar.Position = UDim2.new(0, 12, 0, 8)
    topBar.BackgroundTransparency = 1
    topBar.ZIndex = 32

    local reqBtn = Instance.new("TextButton", topBar)
    reqBtn.Size = UDim2.new(0.48, 0, 1, 0)
    reqBtn.BackgroundColor3 = Color3.fromRGB(48, 34, 78)
    reqBtn.Font = Enum.Font.GothamBold
    reqBtn.TextSize = 10.5
    reqBtn.TextColor3 = Color3.fromRGB(240, 235, 255)
    reqBtn.Text = "📩 Follow Requests (0)"
    reqBtn.ZIndex = 33
    Instance.new("UICorner", reqBtn).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(reqBtn, 1.04)
    reqBtn.MouseButton1Click:Connect(function()
        bs.OpenUserProfile(bs.Social.MyUid)
        task.delay(0.15, function()
            if bs.OpenFollowersOverlay then
                bs.OpenFollowersOverlay(bs.Social.MyUid, "Requests")
            end
        end)
    end)
    bs.UI.NotifReqBtn = reqBtn

    local markBtn = Instance.new("TextButton", topBar)
    markBtn.Size = UDim2.new(0.48, 0, 1, 0)
    markBtn.Position = UDim2.new(0.52, 0, 0, 0)
    markBtn.BackgroundColor3 = Color3.fromRGB(0, 155, 195)
    markBtn.Font = Enum.Font.GothamBold
    markBtn.TextSize = 10.5
    markBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    markBtn.Text = "✓ Mark All Read"
    markBtn.ZIndex = 33
    Instance.new("UICorner", markBtn).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(markBtn, 1.04)
    markBtn.MouseButton1Click:Connect(function()
        bs.SocialEngine.MarkAllNotificationsRead()
        bs.RefreshNotifsUI()
    end)

    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Name = "NotifsScroll"
    scroll.Size = UDim2.new(1, -24, 1, -50)
    scroll.Position = UDim2.new(0, 12, 0, 46)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 225, 255)
    scroll.ZIndex = 32
    bs.UI.NotifsScroll = scroll

    local nLay = Instance.new("UIListLayout", scroll)
    nLay.Padding = UDim.new(0, 7)
    nLay.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", scroll).PaddingTop = UDim.new(0, 2)
    Instance.new("UIPadding", scroll).PaddingBottom = UDim.new(0, 12)
    nLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, nLay.AbsoluteContentSize.Y + 18)
    end)
end

function bs.RefreshNotifsUI()
    local scroll = bs.UI.NotifsScroll
    if not scroll then return end

    if bs.UI.NotifReqBtn then
        bs.UI.NotifReqBtn.Text = "📩 Follow Requests (" .. tostring(bs.SocialEngine.GetRequestCount()) .. ")"
    end

    for _, ch in pairs(scroll:GetChildren()) do
        if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
    end

    local list = bs.Social.Notifs or {}
    if #list == 0 then
        local empty = Instance.new("TextLabel", scroll)
        empty.Size = UDim2.new(1, 0, 0, 70)
        empty.BackgroundTransparency = 1
        empty.Font = Enum.Font.GothamMedium
        empty.TextSize = 11.5
        empty.TextColor3 = Color3.fromRGB(150, 155, 185)
        empty.TextWrapped = true
        empty.Text = "🔔 All caught up!\nNew followers, requests & Elite Pass activations appear here."
        empty.ZIndex = 33
        return
    end

    for idx, item in ipairs(list) do
        local isUnread = (item.read ~= true)
        local accentCol = Color3.fromRGB(0, 225, 255)
        if item.type == "follow_request" then accentCol = Color3.fromRGB(255, 185, 45)
        elseif item.type == "follow" or item.type == "request_accepted" then accentCol = Color3.fromRGB(0, 235, 155)
        elseif item.type == "elite_granted" or item.type == "purchase_pending" then accentCol = Color3.fromRGB(255, 205, 55) end

        local card = Instance.new("TextButton", scroll)
        card.Size = UDim2.new(1, -4, 0, 56)
        card.BackgroundColor3 = isUnread and Color3.fromRGB(24, 22, 42) or Color3.fromRGB(16, 16, 26)
        card.Text = ""
        card.LayoutOrder = idx
        card.ZIndex = 33
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        local st = Instance.new("UIStroke", card)
        st.Color = isUnread and accentCol or Color3.fromRGB(40, 42, 62)
        st.Transparency = isUnread and 0.2 or 0.55
        bs.AttachBossInteractions(card, 1.02)

        local av = Instance.new("ImageLabel", card)
        av.Size = UDim2.new(0, 34, 0, 34)
        av.Position = UDim2.new(0, 10, 0.5, -17)
        av.BackgroundTransparency = 1
        av.ZIndex = 34
        Instance.new("UICorner", av).CornerRadius = UDim.new(1, 0)
        bs.LoadHeadshotByUid(av, item.fromUid)

        local tLbl = Instance.new("TextLabel", card)
        tLbl.Size = UDim2.new(1, -110, 0, 18)
        tLbl.Position = UDim2.new(0, 52, 0, 8)
        tLbl.BackgroundTransparency = 1
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextSize = 11.5
        tLbl.TextColor3 = Color3.fromRGB(245, 245, 255)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.ClipsDescendants = true
        tLbl.Text = tostring(item.title or "Social Update")
        tLbl.ZIndex = 34

        local mLbl = Instance.new("TextLabel", card)
        mLbl.Size = UDim2.new(1, -64, 0, 22)
        mLbl.Position = UDim2.new(0, 52, 0, 26)
        mLbl.BackgroundTransparency = 1
        mLbl.Font = Enum.Font.GothamMedium
        mLbl.TextSize = 10
        mLbl.TextColor3 = Color3.fromRGB(165, 170, 200)
        mLbl.TextXAlignment = Enum.TextXAlignment.Left
        mLbl.TextWrapped = true
        mLbl.ClipsDescendants = true
        mLbl.Text = tostring(item.message or "")
        mLbl.ZIndex = 34

        local timeLbl = Instance.new("TextLabel", card)
        timeLbl.Size = UDim2.new(0, 52, 0, 16)
        timeLbl.Position = UDim2.new(1, -60, 0, 8)
        timeLbl.BackgroundTransparency = 1
        timeLbl.Font = Enum.Font.GothamMedium
        timeLbl.TextSize = 9
        timeLbl.TextColor3 = accentCol
        timeLbl.TextXAlignment = Enum.TextXAlignment.Right
        timeLbl.Text = formatTimeAgo(item.timestamp)
        timeLbl.ZIndex = 34

        card.MouseButton1Click:Connect(function()
            if not item.read then
                item.read = true
                bs.Social.UnreadNotifs = math.max(0, (bs.Social.UnreadNotifs or 1) - 1)
                if item.id and not tostring(item.id):match("^LOCAL_N_") then
                    bs.DbPutAsync(DB_SOCIAL.Notifs .. "/" .. bs.Social.MyUid .. "/" .. item.id .. "/read", true)
                end
                bs.UpdateNavNotifBadge()
            end
            if item.type == "follow_request" then
                bs.OpenUserProfile(bs.Social.MyUid)
                task.delay(0.15, function() if bs.OpenFollowersOverlay then bs.OpenFollowersOverlay(bs.Social.MyUid, "Requests") end end)
            elseif item.type == "elite_granted" or item.type == "purchase_pending" then
                bs.OpenCustomizePage("PremiumStore")
            elseif item.fromUid then
                bs.OpenUserProfile(item.fromUid)
            end
        end)
    end
end

-- ========================================================================= --
-- [SECTION D : CHAT THEME UPDATER, VAULT UI & DM INBOX RENDERERS]
-- ========================================================================= --
function bs.UpdateThemeAnimated()
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local en = (bs.CurrentTheme == "Dark" or bs.CurrentTheme == "PureBlack" or bs.CurrentTheme == "ObsidianGold")
    local eo = TweenInfo.new(0.32, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    g:Create(bs.UI.MainBg, eo, {BackgroundColor3 = ae.MainBg, BackgroundTransparency = ae.BgTrans}):Play()
    g:Create(bs.UI.MainStroke, eo, {Color = ae.StrokeColor}):Play()
    g:Create(bs.UI.HeaderBg, eo, {BackgroundColor3 = ae.HeaderBg, BackgroundTransparency = ae.HeadTrans}):Play()
    g:Create(bs.UI.InputWrapper, eo, {BackgroundColor3 = ae.InputBg, BackgroundTransparency = ae.InpTrans}):Play()
    if bs.UI.NavBar then g:Create(bs.UI.NavBar, eo, {BackgroundColor3 = ae.HeaderBg, BackgroundTransparency = ae.HeadTrans}):Play() end

    bs.UI.TextBox.TextColor3 = ae.TextColor
    bs.UI.TextBox.PlaceholderColor3 = ae.SubText
    bs.UI.SendBtn.BackgroundColor3 = ae.Accent
    bs.UI.SendBtn.TextColor3 = ae.SendText
    bs.UI.JumpBtn.TextColor3 = ae.SendText
    bs.UI.MenuBtn.TextColor3 = ae.TextColor
    if bs.UI.MenuBtn then g:Create(bs.UI.MenuBtn, eo, {BackgroundColor3 = ae.InputBg}):Play() end
    if bs.UI.QuickMusicBtn then g:Create(bs.UI.QuickMusicBtn, eo, {BackgroundColor3 = ae.InputBg, TextColor3 = ae.TextColor}):Play() end

    if bs.UI.SettingsPage then
        for _, aK in ipairs(bs.UI.SettingsPage:GetChildren()) do
            if aK.Name == "ResizeUIBox" then
                g:Create(aK, eo, {BackgroundColor3 = ae.InputBg}):Play()
                if aK:FindFirstChild("UIStroke") then g:Create(aK.UIStroke, eo, {Color = ae.StrokeColor}):Play() end
                for _, ch in pairs(aK:GetChildren()) do
                    if ch:IsA("TextLabel") then g:Create(ch, eo, {TextColor3 = ae.TextColor}):Play()
                    elseif ch:IsA("TextBox") then g:Create(ch, eo, {BackgroundColor3 = ae.HeaderBg, TextColor3 = ae.TextColor}):Play()
                    elseif ch:IsA("TextButton") then g:Create(ch, eo, {BackgroundColor3 = ae.Accent, TextColor3 = ae.SendText}):Play() end
                end
            elseif aK:IsA("TextButton") then
                g:Create(aK, eo, {BackgroundColor3 = ae.InputBg}):Play()
                if aK:FindFirstChild("UIStroke") then g:Create(aK.UIStroke, eo, {Color = ae.StrokeColor}):Play() end
                local d0 = aK:FindFirstChild("MenuText")
                if d0 then g:Create(d0, eo, {TextColor3 = ae.TextColor}):Play() end
                local cY = aK:FindFirstChild("EmojiIcon")
                if cY then g:Create(cY, eo, {TextColor3 = ae.TextColor}):Play() end
                local cZ = aK:FindFirstChild("DecalIcon")
                if cZ and cZ.Image ~= "" then
                    if en then if cY then cY.Visible = false end; cZ.Visible = true
                    else if cY then cY.Visible = true end; cZ.Visible = false end
                end
            end
        end
    end

    if bs.UI.SearchWrapper then bs.UI.SearchWrapper.BackgroundColor3 = ae.InputBg end
    if bs.UI.SearchInput then bs.UI.SearchInput.TextColor3 = ae.TextColor; bs.UI.SearchInput.PlaceholderColor3 = ae.SubText end
    if bs.UI.StickerBtn then
        g:Create(bs.UI.StickerBtn, eo, {BackgroundColor3 = ae.HeaderBg}):Play()
        local ep = bs.UI.StickerBtn:FindFirstChild("StkDecal")
        if ep then
            if en then bs.UI.StickerBtn.Text = ""; ep.Visible = true else bs.UI.StickerBtn.Text = "🏵️"; ep.Visible = false end
        end
    end

    for _, eq in pairs(bs.UI.Scroll:GetChildren()) do
        if eq:IsA("Frame") and eq:FindFirstChild("MessageBubble") then
            local er = eq.MessageBubble
            local es = er.AnchorPoint.X == 1
            g:Create(er, eo, {BackgroundColor3 = es and ae.MyBubble or ae.OtherBubble, BackgroundTransparency = es and ae.BubMeTrans or ae.BubOtherTrans}):Play()
            local et = er:FindFirstChild("MainMessageText")
            if et then g:Create(et, eo, {TextColor3 = ae.TextColor}):Play() end
            local eu = er:FindFirstChild("SenderName")
            if eu and eu.Text ~= "ZARA" then g:Create(eu, eo, {TextColor3 = ae.NameColor}):Play() end
        end
        if eq.Name:match("^DM_Card_") and eq:IsA("TextButton") then
            g:Create(eq, eo, {BackgroundColor3 = eq:FindFirstChild("MatrixUnreadBadge") and ae.Accent or ae.OtherBubble, BackgroundTransparency = eq:FindFirstChild("MatrixUnreadBadge") and 0.85 or ae.BubOtherTrans}):Play()
            local dQ = eq:FindFirstChild("CardName")
            if dQ then g:Create(dQ, eo, {TextColor3 = ae.TextColor}):Play() end
            local ev = eq:FindFirstChild("Sub")
            if ev then g:Create(ev, eo, {TextColor3 = ae.SubText}):Play() end
        end
        if eq.Name:match("^SearchCard_") then
            g:Create(eq, eo, {BackgroundColor3 = ae.OtherBubble, BackgroundTransparency = ae.BubOtherTrans}):Play()
            if eq:FindFirstChild("UIStroke") then g:Create(eq.UIStroke, eo, {Color = ae.StrokeColor}):Play() end
            local ez = eq:FindFirstChild("Disp") or eq:FindFirstChild("CardName")
            if ez then g:Create(ez, eo, {TextColor3 = ae.TextColor}):Play() end
            local eA = eq:FindFirstChild("User") or eq:FindFirstChild("Sub")
            if eA then g:Create(eA, eo, {TextColor3 = ae.SubText}):Play() end
        end
    end

    bs.UpdateNavActiveState(bs.Mode)
    bs.SyncNativeRobloxBubbleSettings()
end

function bs.RefreshVaultUI()
    if not bs.UI.ImageTray then return end
    local eB = bs.UI.ImageTray:FindFirstChild("VaultScroll")
    if not eB then return end
    for _, aK in pairs(eB:GetChildren()) do if aK:IsA("ImageButton") then aK:Destroy() end end
    if bs.UI.ImageTray:FindFirstChild("EmptyVaultPlaque") then bs.UI.ImageTray.EmptyVaultPlaque:Destroy() end

    local eC = bo()
    if #eC == 0 then
        local dA = Instance.new("TextLabel", bs.UI.ImageTray)
        dA.Name = "EmptyVaultPlaque"
        dA.Size = UDim2.new(1, -16, 1, -92)
        dA.Position = UDim2.new(0, 8, 0, 88)
        dA.BackgroundTransparency = 1
        dA.Font = Enum.Font.GothamMedium
        dA.TextSize = 11
        dA.TextColor3 = Color3.fromRGB(200, 200, 210)
        dA.ZIndex = 100
        dA.RichText = true
        dA.TextWrapped = true
        dA.Text = "📂 Vault is currently empty!\nPaste a direct image link above and click Save.\n\n<font color='#B43CFF'>👉 Confused? Type <b>/helpphoto</b> in chat!</font>"
        eB.CanvasSize = UDim2.new(0, 0, 0, 100)
        return
    end

    eB.CanvasSize = UDim2.new(0, 0, 0, math.max(120, math.ceil(#eC / 4) * 66 + 20))
    for eD, eE in ipairs(eC) do
        local eF = Instance.new("ImageButton", eB)
        eF.Size = UDim2.new(0, 58, 0, 58)
        eF.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        eF.ScaleType = Enum.ScaleType.Fit
        eF.LayoutOrder = eD
        eF.ZIndex = 78
        Instance.new("UICorner", eF).CornerRadius = UDim.new(0, 6)
        bs.AttachBossInteractions(eF, 1.08)
        c8(eF, eE)

        local eG = Instance.new("TextButton", eF)
        eG.Size = UDim2.new(0, 18, 0, 18)
        eG.Position = UDim2.new(1, -15, 0, -3)
        eG.BackgroundColor3 = Color3.fromRGB(220, 45, 45)
        eG.Text = "X"
        eG.Font = Enum.Font.GothamBold
        eG.TextSize = 10
        eG.TextColor3 = Color3.fromRGB(255, 255, 255)
        eG.ZIndex = 79
        Instance.new("UICorner", eG).CornerRadius = UDim.new(1, 0)

        eF.MouseButton1Click:Connect(function()
            if os.clock() - bs.LastSendTime < 3.0 and (bs.Mode == "Server" or bs.Mode == "DM") then return end
            bs.Send("[MEDIA::" .. eE .. "::MEDIA]")
            bs.LastSendTime = os.clock()
            table.insert(bs.MessageTimestamps, os.clock())
            bs.UI.ImageTray.Visible = false
        end)
        eG.MouseButton1Click:Connect(function()
            table.remove(eC, eD); bp(eC); bs.RefreshVaultUI()
            bs.TriggerToast("🗑️ Secure Disk", "Photo wiped.", false)
        end)
    end
end

function bs.DressInboxCard(ee, eH, eI, eJ)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local ev = ee:FindFirstChild("Sub")
    if ev then
        local dQ = bY(eI)
        ev.Text = dQ:sub(1, 35) .. (#dQ > 35 and "..." or "")
    end
    local ew = ee:FindFirstChild("MatrixUnreadBadge")
    local ey = (ae.Accent == Color3.fromRGB(255, 255, 255) or ae.Accent == Color3.fromRGB(240, 240, 240)) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    local eL = bs.Cache.DMs[eH] and bs.Cache.DMs[eH][#bs.Cache.DMs[eH]] and bs.Cache.DMs[eH][#bs.Cache.DMs[eH]].Time or 0
    local eK = eL > 0 and ((bs.PartnerReadTimestamps[eH] or 0) >= eL)

    if eJ > 0 then
        if not ew then
            ew = Instance.new("Frame", ee)
            ew.Name = "MatrixUnreadBadge"
            ew.Size = UDim2.new(0, 60, 0, 22)
            ew.Position = UDim2.new(1, -104, 0.5, -11)
            ew.BackgroundColor3 = ae.Accent
            ew.ZIndex = 4
            Instance.new("UICorner", ew).CornerRadius = UDim.new(0, 6)
            local eN = Instance.new("TextLabel", ew)
            eN.Name = "Txt"; eN.Size = UDim2.new(1, 0, 1, 0); eN.BackgroundTransparency = 1
            eN.Font = Enum.Font.GothamBold; eN.TextSize = 10; eN.TextColor3 = ey; eN.ZIndex = 4
        end
        ew.Txt.Text = eJ >= 4 and "4+ New" or tostring(eJ) .. " New"
        ee.BackgroundColor3 = ae.Accent; ee.BackgroundTransparency = 0.85
        ew.BackgroundColor3 = ae.Accent; ew.Txt.TextColor3 = ey
    else
        if ew then ew:Destroy() end
        ee.BackgroundColor3 = ae.OtherBubble; ee.BackgroundTransparency = ae.BubOtherTrans
        if ev and bs.Cache.DMs[eH] and bs.Cache.DMs[eH][#bs.Cache.DMs[eH]] and bs.Cache.DMs[eH][#bs.Cache.DMs[eH]].Sender == m.Name then
            ev.Text = ev.Text .. (eK and "  •  Seen ✔️" or "  •  Sent ✔")
        end
    end
end

function bs.RenderInboxCard(eO, eP, eQ, eR)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local eS = Instance.new("TextButton", bs.UI.Scroll)
    eS.Name = "DM_Card_" .. eQ
    eS.Size = UDim2.new(1, 0, 0, 48)
    eS.BackgroundColor3 = ae.OtherBubble
    eS.BackgroundTransparency = ae.BubOtherTrans
    eS.Text = ""
    Instance.new("UICorner", eS).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", eS).Color = ae.StrokeColor
    bs.AttachBossInteractions(eS, 1.03)

    local eU = Instance.new("ImageLabel", eS)
    eU.Size = UDim2.new(0, 34, 0, 34); eU.Position = UDim2.new(0, 7, 0, 7); eU.BackgroundTransparency = 1
    cc(eU, eP); Instance.new("UICorner", eU).CornerRadius = UDim.new(1, 0)

    local eV = Instance.new("TextLabel", eS)
    eV.Name = "CardName"; eV.Size = UDim2.new(1, -110, 0, 18); eV.Position = UDim2.new(0, 50, 0, 5)
    eV.BackgroundTransparency = 1; eV.Font = Enum.Font.GothamBold; eV.TextSize = 13
    eV.TextColor3 = ae.TextColor; eV.TextXAlignment = Enum.TextXAlignment.Left
    eV.Text = eO .. "  •  ᴢᴀʏɴ ᴄʜᴀᴛ"

    local eW = Instance.new("TextLabel", eS)
    eW.Name = "Sub"; eW.Size = UDim2.new(1, -110, 0, 16); eW.Position = UDim2.new(0, 50, 0, 25)
    eW.BackgroundTransparency = 1; eW.Font = Enum.Font.GothamMedium; eW.TextSize = 11
    eW.TextColor3 = ae.SubText; eW.TextXAlignment = Enum.TextXAlignment.Left

    local eX = Instance.new("TextButton", eS)
    eX.Size = UDim2.new(0, 30, 0, 30); eX.Position = UDim2.new(1, -38, 0.5, -15)
    eX.BackgroundTransparency = 1; eX.Font = Enum.Font.GothamBold; eX.TextSize = 22; eX.Text = "♥"; eX.ZIndex = 5
    bs.AttachBossInteractions(eX, 1.2)

    local function eY()
        local eZ = false
        for _, cw in ipairs(bs.CloseFriends) do if cw:lower() == eP:lower() then eZ = true; break end end
        eX.TextColor3 = eZ and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(150, 150, 150)
    end
    eY()

    eX.MouseButton1Click:Connect(function()
        local e_, f0 = eP:lower(), nil
        for aV, cw in ipairs(bs.CloseFriends) do if cw:lower() == e_ then f0 = aV; break end end
        if f0 then table.remove(bs.CloseFriends, f0); bs.TriggerToast("♥️ Close Friends", "Removed " .. eO, false)
        else table.insert(bs.CloseFriends, eP); bs.TriggerToast("♥️ Close Friends", "Added " .. eO, false) end
        bn(bs.CloseFriends); eY()
    end)

    eS.MouseButton1Click:Connect(function() bs.SwitchMode("DM", eQ) end)
    bs.DressInboxCard(eS, eQ, eR, bs.GetUnreadCount(eQ))
end

function bs.RenderUserSearchCard(eO, f1, f2, f3, eJ)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local eS = Instance.new("Frame", bs.UI.Scroll)
    eS.Name = "SearchCard_" .. f1
    eS.Size = UDim2.new(1, 0, 0, 52)
    eS.BackgroundColor3 = ae.OtherBubble
    eS.BackgroundTransparency = ae.BubOtherTrans
    Instance.new("UICorner", eS).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", eS).Color = ae.StrokeColor

    local eU = Instance.new("ImageButton", eS)
    eU.Size = UDim2.new(0, 36, 0, 36); eU.Position = UDim2.new(0, 8, 0, 8); eU.BackgroundTransparency = 1
    Instance.new("UICorner", eU).CornerRadius = UDim.new(1, 0)
    bs.LoadHeadshotByUid(eU, f2)
    eU.MouseButton1Click:Connect(function() if tonumber(f2) and tonumber(f2) > 1 then bs.OpenUserProfile(f2) end end)

    local f5 = Instance.new("TextLabel", eS)
    f5.Name = "Disp"; f5.Size = UDim2.new(1, -185, 0, 18); f5.Position = UDim2.new(0, 54, 0, 7)
    f5.BackgroundTransparency = 1; f5.Font = Enum.Font.GothamBold; f5.TextSize = 13
    f5.TextColor3 = ae.TextColor; f5.TextXAlignment = Enum.TextXAlignment.Left; f5.ClipsDescendants = true; f5.Text = eO

    local f6 = Instance.new("TextLabel", eS)
    f6.Name = "User"; f6.Size = UDim2.new(1, -185, 0, 16); f6.Position = UDim2.new(0, 54, 0, 27)
    f6.BackgroundTransparency = 1; f6.Font = Enum.Font.GothamMedium; f6.TextSize = 11
    f6.TextColor3 = ae.SubText; f6.TextXAlignment = Enum.TextXAlignment.Left; f6.ClipsDescendants = true
    f6.Text = "@" .. f1 .. "  •  ᴢᴀʏɴ ᴄʜᴀᴛ"

    local profBtn = Instance.new("TextButton", eS)
    profBtn.Size = UDim2.new(0, 34, 0, 30); profBtn.Position = UDim2.new(1, -126, 0.5, -15)
    profBtn.BackgroundColor3 = Color3.fromRGB(48, 44, 78); profBtn.Font = Enum.Font.GothamBold; profBtn.TextSize = 13
    profBtn.TextColor3 = Color3.fromRGB(255, 255, 255); profBtn.Text = "👤"
    Instance.new("UICorner", profBtn).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(profBtn, 1.08)
    profBtn.MouseButton1Click:Connect(function() if tonumber(f2) and tonumber(f2) > 1 then bs.OpenUserProfile(f2) end end)

    local f7 = Instance.new("TextButton", eS)
    f7.Size = UDim2.new(0, 48, 0, 30); f7.Position = UDim2.new(1, -86, 0.5, -15)
    f7.BackgroundColor3 = ae.Accent; f7.Font = Enum.Font.GothamBold; f7.TextSize = 11.5; f7.TextColor3 = ae.SendText; f7.Text = "DM"
    Instance.new("UICorner", f7).CornerRadius = UDim.new(0, 8)
    bs.AttachBossInteractions(f7, 1.08)

    local eX = Instance.new("TextButton", eS)
    eX.Size = UDim2.new(0, 30, 0, 30); eX.Position = UDim2.new(1, -34, 0.5, -15)
    eX.BackgroundTransparency = 1; eX.Font = Enum.Font.GothamBold; eX.TextSize = 22; eX.Text = "♥"
    bs.AttachBossInteractions(eX, 1.2)

    local function eY()
        local eZ = false
        for _, cw in ipairs(bs.CloseFriends) do if cw:lower() == f1:lower() then eZ = true; break end end
        eX.TextColor3 = eZ and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(150, 150, 150)
    end
    eY()

    f7.MouseButton1Click:Connect(function()
        local ef = f1:lower()
        bs.RegisterAccount(f1, eO, f2); bs.Cache.DMs[ef] = bs.Cache.DMs[ef] or {}
        bs.SwitchMode("DM", ef)
        if bs.UI.SearchInput then bs.UI.SearchInput.Text = "" end
    end)

    eX.MouseButton1Click:Connect(function()
        local e_, f0 = f1:lower(), nil
        for aV, cw in ipairs(bs.CloseFriends) do if cw:lower() == e_ then f0 = aV; break end end
        if f0 then table.remove(bs.CloseFriends, f0); bs.TriggerToast("♥️ Close Friends", "Removed " .. eO, false); if f3 then eS:Destroy() end
        else table.insert(bs.CloseFriends, f1); bs.TriggerToast("♥️ Close Friends", "Added " .. eO, false) end
        bn(bs.CloseFriends); eY()
    end)
end

function bs.LiveUpdateInboxSort()
    if bs.Mode ~= "DM_Inbox" then return end
    local dV = {}
    for g_, gR in pairs(bs.Cache.DMs) do
        table.insert(dV, {k = g_, t = gR[#gR] and gR[#gR].Time or 0, s = gR[#gR] and gR[#gR].Msg or "Start secure chat...", u = bs.GetUnreadCount(g_)})
    end
    table.sort(dV, function(aP, aQ) return aP.t > aQ.t end)

    local gS = {}
    for eD, gT in ipairs(dV) do
        gS["DM_Card_" .. gT.k] = true
        local aK = bs.UI.Scroll:FindFirstChild("DM_Card_" .. gT.k)
        if aK then
            aK.LayoutOrder = eD; bs.DressInboxCard(aK, gT.k, gT.s, gT.u)
        else
            local fN = bs.GetAccount(gT.k)
            bs.RenderInboxCard(fN.DisplayName, fN.Username, gT.k, gT.s)
            local gU = bs.UI.Scroll:FindFirstChild("DM_Card_" .. gT.k)
            if gU then gU.LayoutOrder = eD end
        end
    end
    for _, eq in pairs(bs.UI.Scroll:GetChildren()) do
        if eq.Name:match("^DM_Card_") and not gS[eq.Name] then eq:Destroy() end
    end
end

-- ========================================================================= --
-- [SECTION E : ZERO-LAG UPGRADED CHAT BUBBLES, AVATAR RINGS & ACTION MENU]
-- ========================================================================= --
function bs.LiveSyncAllVisibleBubblesTitle()
    if not bs.UI.Scroll then return end
    for _, eq in pairs(bs.UI.Scroll:GetChildren()) do
        if eq:IsA("Frame") and eq:FindFirstChild("MessageBubble") then
            local avWrap = eq:FindFirstChild("BubbleAvatarWrap")
            local er = eq.MessageBubble
            if avWrap and er then
                local eu = er:GetAttribute("RawSender") or ""
                if eu == "" then
                    local fA = er:FindFirstChild("SenderName")
                    if fA then eu = fA.Text elseif er.AnchorPoint.X == 1 then eu = m.Name end
                end
                local fB = bs.TitleRegistry[eu:lower()] or (er.AnchorPoint.X == 1 and m.UserId == 10432865434 and "CREATOR" or nil)
                if fB then
                    bs.AnimEngine.AttachCurvedTitle(avWrap, fB)
                elseif avWrap.Parent:FindFirstChild("MatrixCurvedTitleArc") then
                    avWrap.Parent.MatrixCurvedTitleArc:Destroy()
                end
            end
        end
    end
end

function bs.UpdateBubbleReactions(cg, fC)
    local fD = bs.ActiveBubbleNodes[cg]
    if not fD or not fD:FindFirstChild("MessageBubble") then return end
    local fE = fD.MessageBubble:FindFirstChild("ReactContainer")
    if not fE then return end

    for _, aK in pairs(fE:GetChildren()) do if aK:IsA("TextButton") then aK:Destroy() end end
    if not fC or typeof(fC) ~= "table" then return end

    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    for cr, cs in pairs(fC) do
        local fF = aL(cr)
        if fF and typeof(cs) == "table" then
            local ab, fG, ci = 0, false, m.Name:lower()
            for fH, _ in pairs(cs) do ab = ab + 1; if fH == ci then fG = true end end
            if ab > 0 then
                local fI = Instance.new("TextButton", fE)
                fI.Size = UDim2.new(0, 0, 0, 20); fI.AutomaticSize = Enum.AutomaticSize.X
                fI.BackgroundColor3 = fG and ae.Accent or Color3.fromRGB(35, 35, 45)
                fI.BackgroundTransparency = fG and 0.2 or 0.4; fI.Text = ""
                Instance.new("UICorner", fI).CornerRadius = UDim.new(1, 0)
                bs.AttachBossInteractions(fI, 1.1)

                local fJ = Instance.new("UIPadding", fI); fJ.PaddingLeft = UDim.new(0, 6); fJ.PaddingRight = UDim.new(0, 6)
                local fK = Instance.new("UIListLayout", fI); fK.FillDirection = Enum.FillDirection.Horizontal
                fK.VerticalAlignment = Enum.VerticalAlignment.Center; fK.Padding = UDim.new(0, 4); fK.SortOrder = Enum.SortOrder.LayoutOrder

                local fL = Instance.new("TextLabel", fI)
                fL.Size = UDim2.new(0, 0, 1, 0); fL.AutomaticSize = Enum.AutomaticSize.X; fL.BackgroundTransparency = 1
                fL.Font = Enum.Font.GothamBold; fL.TextSize = 11; fL.TextColor3 = Color3.fromRGB(255, 255, 255)
                fL.Text = fF .. " " .. tostring(ab); fL.LayoutOrder = 0

                local fM = 1
                for fH, _ in pairs(cs) do
                    if fM <= 3 then
                        local fd = Instance.new("ImageLabel", fI)
                        fd.Size = UDim2.new(0, 14, 0, 14); fd.BackgroundTransparency = 1
                        Instance.new("UICorner", fd).CornerRadius = UDim.new(1, 0); fd.LayoutOrder = fM
                        cc(fd, bs.GetAccount(fH).Username)
                    end
                    fM = fM + 1
                end
                fI.MouseButton1Click:Connect(function() bs.ToggleReaction(cg, fF) end)
            end
        end
    end
end

function bs.RenderBubble(fa, c4, fO, bG, cg, fP, fQ)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local es = string.lower(fa) == string.lower(m.Name)
    local fR = (fa == "ZARA")

    local senderUidNum = tonumber(c4) or 0
    if not es and not fR and senderUidNum > 1 and bs.SocialEngine.IsBlocked(senderUidNum) then
        return
    end

    local fS, fT, fU = fO:match("^%[RPL::(.-)::(.-)::RPL%]%s*(.*)")
    if not fS then fU = fO end
    local fV = fP or false
    if fU:sub(1, 5) == "[EDT]" then fV = true; fU = fU:sub(6) end

    local fW = Instance.new("Frame", bs.UI.Scroll)
    fW.Size = UDim2.new(1, 0, 0, 0)
    fW.AutomaticSize = Enum.AutomaticSize.Y
    fW.BackgroundTransparency = 1
    if cg then bs.ActiveBubbleNodes[cg] = fW end

    local avSize = fR and 32 or 28
    local avWrap = Instance.new("Frame", fW)
    avWrap.Name = "BubbleAvatarWrap"
    avWrap.Size = UDim2.new(0, avSize, 0, avSize)
    avWrap.BackgroundTransparency = 1
    avWrap.AnchorPoint = es and Vector2.new(1, 0) or Vector2.new(0, 0)
    avWrap.Position = es and UDim2.new(1, -2, 0, 2) or UDim2.new(0, 2, 0, 2)
    avWrap.ZIndex = 6

    local eU = Instance.new("ImageButton", avWrap)
    eU.Size = UDim2.new(1, 0, 1, 0)
    eU.BackgroundTransparency = 1
    eU.ZIndex = 7
    Instance.new("UICorner", eU).CornerRadius = UDim.new(1, 0)
    if senderUidNum > 1 and not fR then bs.LoadHeadshotByUid(eU, senderUidNum) else cc(eU, fa) end

    if not fR and senderUidNum > 1 then
        local senderProf = bs.Social.Profiles[tostring(senderUidNum)]
        if senderProf and senderProf.decoration and senderProf.decoration ~= "none" then
            bs.AnimEngine.ApplyAvatarEffect(avWrap, senderProf.decoration, true)
        end
    end

    local ev = fa:lower()
    if not fR then
        local fX = bs.TitleRegistry[ev] or ((senderUidNum == 10432865434 or ev == "erennn0779" or ev == "izayn") and "CREATOR" or nil)
        if fX then bs.AnimEngine.AttachCurvedTitle(avWrap, fX) end
    end

    eU.MouseButton1Click:Connect(function()
        if fR then return end
        if senderUidNum > 1 then
            bs.OpenUserProfile(senderUidNum)
        else
            task.spawn(function()
                local res = bs.ResolveUserInput(fa)
                if res and res.UserId then bs.OpenUserProfile(res.UserId) end
            end)
        end
    end)

    local fY = es and UDim2.new(1, -38, 0, 0) or (fR and UDim2.new(0, 44, 0, 0) or UDim2.new(0, 38, 0, 0))
    local fZ = Instance.new("TextLabel", fW)
    fZ.Size = UDim2.new(0, 30, 0, 30); fZ.BackgroundTransparency = 1
    fZ.Position = es and UDim2.new(0, -15, 0.5, -15) or UDim2.new(1, -15, 0.5, -15)
    fZ.Text = "↩"; fZ.Font = Enum.Font.GothamBold; fZ.TextSize = 16; fZ.TextColor3 = ae.SubText; fZ.TextTransparency = 1

    local f_ = Instance.new("Frame", fW)
    f_.Name = "MessageBubble"
    f_.AutomaticSize = Enum.AutomaticSize.XY
    f_.AnchorPoint = es and Vector2.new(1, 0) or Vector2.new(0, 0)
    f_.Position = fY
    f_.Active = true
    Instance.new("UICorner", f_).CornerRadius = UDim.new(0, 14)
    Instance.new("UISizeConstraint", f_).MaxSize = Vector2.new(330, 9999)

    local g0 = Instance.new("UIListLayout", f_); g0.Padding = UDim.new(0, 3); g0.SortOrder = Enum.SortOrder.LayoutOrder
    local g1 = Instance.new("UIPadding", f_); g1.PaddingTop = UDim.new(0, 6); g1.PaddingBottom = UDim.new(0, 6); g1.PaddingLeft = UDim.new(0, 14); g1.PaddingRight = UDim.new(0, 14)
    f_:SetAttribute("LiveText", fU)
    f_:SetAttribute("RawSender", fa)

    if not es then
        local fN = bs.GetAccount(fa)
        local g2 = Instance.new("TextLabel", f_)
        g2.Name = "SenderName"; g2.AutomaticSize = Enum.AutomaticSize.XY; g2.BackgroundTransparency = 1
        g2.Font = Enum.Font.GothamBold; g2.TextSize = fR and 12 or 10
        g2.TextColor3 = fR and Color3.fromRGB(180, 60, 255) or ae.NameColor
        g2.Text = fR and "ZARA" or fN.DisplayName; g2.LayoutOrder = 1
        if not fR then bs.RegisterAccount(fa, fN.DisplayName, c4, g2) end
    end

    if fS then
        local g3 = bs.GetAccount(fS)
        local g4 = Instance.new("Frame", f_)
        g4.AutomaticSize = Enum.AutomaticSize.XY; g4.BackgroundColor3 = ae.TextColor; g4.BackgroundTransparency = 0.88; g4.LayoutOrder = 2
        Instance.new("UICorner", g4).CornerRadius = UDim.new(0, 6)
        local g5 = Instance.new("UIPadding", g4); g5.PaddingLeft = UDim.new(0, 12); g5.PaddingRight = UDim.new(0, 8); g5.PaddingTop = UDim.new(0, 4); g5.PaddingBottom = UDim.new(0, 4)
        local g6 = Instance.new("Frame", g4); g6.Size = UDim2.new(0, 3, 1, 0); g6.Position = UDim2.new(0, -8, 0, 0); g6.BackgroundColor3 = ae.Accent; g6.BorderSizePixel = 0
        Instance.new("UICorner", g6).CornerRadius = UDim.new(0, 2)
        local g7 = Instance.new("TextLabel", g4)
        g7.AutomaticSize = Enum.AutomaticSize.XY; g7.BackgroundTransparency = 1; g7.Font = Enum.Font.GothamMedium; g7.TextSize = 10
        g7.TextColor3 = ae.TextColor; g7.RichText = true; g7.Text = string.format("<b>%s</b>\n%s", g3.DisplayName, fT)
    end

    local g8 = fU:match("%[STICKER://(%d+)%]")
    local g9 = fU:match("%[MEDIA::(.-)::MEDIA%]")
    if g8 then
        local ga = Instance.new("ImageLabel", f_)
        ga.Size = UDim2.new(0, 115, 0, 115); ga.BackgroundTransparency = 1
        ga.Image = "rbxthumb://type=Asset&id=" .. g8 .. "&w=150&h=150"; ga.ScaleType = Enum.ScaleType.Fit; ga.LayoutOrder = 3
    elseif g9 then
        local gb = Instance.new("ImageButton", f_)
        gb.Size = UDim2.new(0, 195, 0, 150); gb.BackgroundColor3 = Color3.fromRGB(24, 24, 28); gb.ScaleType = Enum.ScaleType.Crop; gb.LayoutOrder = 3
        Instance.new("UICorner", gb).CornerRadius = UDim.new(0, 8); c8(gb, g9)
        gb.MouseButton1Click:Connect(function()
            if bQ:FindFirstChild("MatrixFullscreenViewerModal") then return end
            local gc = Instance.new("BlurEffect", j); gc.Name = "MatrixCinematicBlur"; gc.Size = 22
            local gd = Instance.new("Frame", bQ)
            gd.Name = "MatrixFullscreenViewerModal"; gd.Size = UDim2.new(1, 0, 1, 0); gd.Position = UDim2.new(0.5, 0, 0.5, 0); gd.AnchorPoint = Vector2.new(0.5, 0.5)
            gd.BackgroundColor3 = Color3.fromRGB(0, 0, 0); gd.BackgroundTransparency = 0.15; gd.Active = true; gd.ZIndex = 1000
            local ge = Instance.new("ImageLabel", gd)
            ge.Size = UDim2.new(0.9, 0, 0.9, 0); ge.Position = UDim2.new(0.5, 0, 0.5, 0); ge.AnchorPoint = Vector2.new(0.5, 0.5)
            ge.BackgroundTransparency = 1; ge.ScaleType = Enum.ScaleType.Fit; ge.ZIndex = 1001; c8(ge, g9)
            local gf = Instance.new("TextButton", gd)
            gf.Size = UDim2.new(0, 44, 0, 44); gf.Position = UDim2.new(1, -20, 0, 40); gf.AnchorPoint = Vector2.new(1, 0)
            gf.BackgroundColor3 = Color3.fromRGB(20, 20, 25); gf.Text = "X"; gf.Font = Enum.Font.GothamBold; gf.TextSize = 22; gf.TextColor3 = Color3.fromRGB(255, 255, 255); gf.ZIndex = 1002
            Instance.new("UICorner", gf).CornerRadius = UDim.new(1, 0); bs.AttachBossInteractions(gf, 1.1)
            gf.MouseButton1Click:Connect(function()
                if j:FindFirstChild("MatrixCinematicBlur") then j.MatrixCinematicBlur:Destroy() end
                gd:Destroy()
            end)
        end)
    else
        local gg = Instance.new("TextLabel", f_)
        gg.Name = "MainMessageText"; gg.AutomaticSize = Enum.AutomaticSize.XY; gg.BackgroundTransparency = 1
        gg.Font = Enum.Font.GothamMedium; gg.TextSize = 13; gg.TextColor3 = ae.TextColor
        gg.TextWrapped = true; gg.RichText = true; gg.TextXAlignment = Enum.TextXAlignment.Left
        gg.Text = fV and fU .. "\n<font color='#888888' size='10'><i>(edited)</i></font>" or fU; gg.LayoutOrder = 3
    end

    local gh = Instance.new("Frame", f_)
    gh.Name = "ReactContainer"; gh.AutomaticSize = Enum.AutomaticSize.XY; gh.BackgroundTransparency = 1; gh.LayoutOrder = 4
    local gi = Instance.new("UIListLayout", gh); gi.FillDirection = Enum.FillDirection.Horizontal; gi.Padding = UDim.new(0, 4); gi.SortOrder = Enum.SortOrder.LayoutOrder
    if fQ then bs.UpdateBubbleReactions(cg, fQ) end

    f_.BackgroundColor3 = es and ae.MyBubble or ae.OtherBubble
    f_.BackgroundTransparency = es and ae.BubMeTrans or ae.BubOtherTrans

    local gj = false
    f_.InputBegan:Connect(function(e5)
        if e5.UserInputType == Enum.UserInputType.MouseButton1 or e5.UserInputType == Enum.UserInputType.Touch then
            if fR then return end
            gj = true
            task.delay(0.58, function()
                if gj and f_.Parent and (not bs.SwipeState.Active or math.abs((f_.Position.X.Offset or 0) - fY.X.Offset) < 6) then
                    gj = false
                    bs.OpenActionMenu(fa, c4, f_:GetAttribute("LiveText") or fU, cg, es)
                end
            end)
            if not bs.SwipeState.Active then
                bs.ActiveSwipeBubble = f_
                bs.SwipeState.Active = true; bs.SwipeState.Bubble = f_; bs.SwipeState.StartX = e5.Position.X
                bs.SwipeState.BasePos = fY; bs.SwipeState.IsMe = es; bs.SwipeState.ReplyIcon = fZ
                bs.SwipeState.Sender = fa; bs.SwipeState.LiveText = fU
            end
        end
    end)
    f_.InputEnded:Connect(function() gj = false end)

    bs.HandleScroll(es)

    local f_lst = {}
    for _, cf in pairs(bs.UI.Scroll:GetChildren()) do
        if cf:IsA("Frame") and cf:FindFirstChild("MessageBubble") then table.insert(f_lst, cf) end
    end
    if #f_lst > 65 then
        table.sort(f_lst, function(p1, p2) return p1.AbsolutePosition.Y < p2.AbsolutePosition.Y end)
        for v_i = 1, #f_lst - 65 do if f_lst[v_i] then f_lst[v_i]:Destroy() end end
    end
end

function bs.OpenActionMenu(fa, c4, fU, cg, es)
    if fa == "ZARA" or bs.UI.MainBg:FindFirstChild("MatrixHoldActionMenu") then return end
    local fN = bs.GetAccount(fa)
    local gn = fN.DisplayName
    local go = fU:sub(1, 5) == "[EDT]" and fU:sub(6) or fU
    local ae = bL[bs.CurrentTheme] or bL.PureBlack

    local gp = Instance.new("Frame", bs.UI.MainBg)
    gp.Name = "MatrixHoldActionMenu"; gp.Size = UDim2.new(1, 0, 1, 0)
    gp.BackgroundColor3 = Color3.fromRGB(0, 0, 0); gp.BackgroundTransparency = 1; gp.Active = true; gp.ZIndex = 95

    local gq = Instance.new("TextButton", gp)
    gq.Size = UDim2.new(1, 0, 1, 0); gq.BackgroundTransparency = 1; gq.Text = ""; gq.ZIndex = 96

    local gr = go:match("^%[STICKER://") or go:match("^%[MEDIA::")
    local btnCount = 3 + ((es and cg) and (gr and 1 or 2) or 0)

    local gt = Instance.new("CanvasGroup", gp)
    gt.Size = UDim2.new(0, 264, 0, 125 + btnCount * 38)
    gt.Position = UDim2.new(0.5, 0, 0.5, 0); gt.AnchorPoint = Vector2.new(0.5, 0.5)
    gt.BackgroundTransparency = 1; gt.ZIndex = 97; gt.GroupTransparency = 1

    g:Create(gt, TweenInfo.new(0.22), {GroupTransparency = 0}):Play()
    g:Create(gp, TweenInfo.new(0.22), {BackgroundTransparency = 0.45}):Play()

    local gv = Instance.new("Frame", gt)
    gv.Size = UDim2.new(1, 0, 1, 0); gv.BackgroundColor3 = ae.HeaderBg; gv.ZIndex = 97
    Instance.new("UICorner", gv).CornerRadius = UDim.new(0, 16)
    local gw = Instance.new("UIStroke", gv); gw.Color = ae.Accent; gw.Thickness = 1.5

    local gx = Instance.new("UIListLayout", gv)
    gx.Padding = UDim.new(0, 4); gx.HorizontalAlignment = Enum.HorizontalAlignment.Center; gx.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", gv).PaddingTop = UDim.new(0, 12)

    local cM = Instance.new("TextLabel", gv)
    cM.Size = UDim2.new(1, -24, 0, 20); cM.BackgroundTransparency = 1; cM.Font = Enum.Font.GothamBold
    cM.TextSize = 13; cM.TextColor3 = ae.SubText; cM.LayoutOrder = 0; cM.ZIndex = 98; cM.Text = "Options (" .. gn .. ")"

    local actX = Instance.new("TextButton", gt)
    actX.Size = UDim2.new(0, 24, 0, 24); actX.Position = UDim2.new(1, -28, 0, 8)
    actX.BackgroundTransparency = 1; actX.Text = "X"; actX.Font = Enum.Font.GothamBold; actX.TextSize = 14
    actX.TextColor3 = Color3.fromRGB(220, 60, 60); actX.ZIndex = 100

    local function gy()
        g:Create(gp, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
        g:Create(gt, TweenInfo.new(0.18), {GroupTransparency = 1}):Play()
        task.delay(0.18, function() if gp and gp.Parent then gp:Destroy() end end)
    end
    actX.MouseButton1Click:Connect(gy); gq.MouseButton1Click:Connect(gy)

    local gA = Instance.new("Frame", gv)
    gA.Size = UDim2.new(1, -20, 0, 36); gA.BackgroundColor3 = Color3.fromRGB(30, 30, 42); gA.BackgroundTransparency = 0.3; gA.LayoutOrder = 1; gA.ZIndex = 98
    Instance.new("UICorner", gA).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", gA).Color = ae.Accent
    local gC = Instance.new("UIListLayout", gA)
    gC.FillDirection = Enum.FillDirection.Horizontal; gC.HorizontalAlignment = Enum.HorizontalAlignment.Center
    gC.VerticalAlignment = Enum.VerticalAlignment.Center; gC.Padding = UDim.new(0, 6)

    for _, fF in ipairs({"❤️", "😂", "💀", "🔥", "👍", "⚡"}) do
        local gD = Instance.new("TextButton", gA)
        gD.Size = UDim2.new(0, 32, 0, 28); gD.BackgroundColor3 = ae.InputBg; gD.BackgroundTransparency = 0.5
        gD.Font = Enum.Font.GothamBold; gD.TextSize = 15; gD.Text = fF; gD.ZIndex = 99
        Instance.new("UICorner", gD).CornerRadius = UDim.new(0, 6); bs.AttachBossInteractions(gD, 1.15)
        gD.MouseButton1Click:Connect(function() gy(); bs.ToggleReaction(cg, fF) end)
    end

    local gE = bY(go)
    local gF = Instance.new("TextLabel", gv)
    gF.Size = UDim2.new(1, -24, 0, 28); gF.BackgroundTransparency = 1; gF.Font = Enum.Font.GothamMedium
    gF.TextSize = 11; gF.TextColor3 = ae.TextColor; gF.TextWrapped = true; gF.LayoutOrder = 2; gF.ZIndex = 98
    gF.Text = gE == go and '"' .. go:sub(1, 35) .. '..."' or gE

    local gG = Instance.new("Frame", gv)
    gG.Size = UDim2.new(1, -30, 0, 1); gG.BackgroundColor3 = ae.SubText; gG.BackgroundTransparency = 0.8; gG.LayoutOrder = 3; gG.ZIndex = 98

    local gH = 4
    local function gI(cT, gJ, gK, cW)
        local aQ = Instance.new("TextButton", gv)
        aQ.Size = UDim2.new(1, -24, 0, 34); aQ.BackgroundColor3 = gK; aQ.BackgroundTransparency = 0.08
        aQ.Font = Enum.Font.GothamBold; aQ.TextSize = 11.5
        aQ.TextColor3 = gK == Color3.fromRGB(255, 255, 255) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        aQ.LayoutOrder = gH; aQ.ZIndex = 98; aQ.Text = gJ .. "    " .. cT
        Instance.new("UICorner", aQ).CornerRadius = UDim.new(0, 8); bs.AttachBossInteractions(aQ, 1.05)
        aQ.MouseButton1Click:Connect(function() cW(); gy() end)
        gH = gH + 1
    end

    gI("View Insta Profile", "👤", Color3.fromRGB(130, 50, 220), function()
        local uidNum = tonumber(c4)
        if uidNum and uidNum > 1 then bs.OpenUserProfile(uidNum)
        else
            task.spawn(function()
                local res = bs.ResolveUserInput(fa)
                if res and res.UserId then bs.OpenUserProfile(res.UserId) end
            end)
        end
    end)
    gI("Copy Text", "📋", Color3.fromRGB(35, 110, 200), function()
        pcall(function() local gL = setclipboard or toclipboard; if gL then gL(go); bs.TriggerToast("📋 Copied", "Text saved", false) end end)
    end)
    if es and cg and not gr then gI("Edit Message", "✏️", Color3.fromRGB(210, 130, 30), function() bs.StartEditing(cg, go) end) end
    gI("Reply", "↩️", ae.Accent, function() bs.SetReply(fa, go, gn) end)
    if es and cg then gI("Unsend", "🗑️", Color3.fromRGB(210, 45, 45), function() bs.UnsendMsg(cg) end) end
end

function bs.UnsendMsg(cg)
    local ci, cl = m.Name:lower(), bs.ActiveDM and bs.ActiveDM:lower() or ""
    task.spawn(function()
        if bs.Mode == "DM" and cl ~= "" then
            pcall(function()
                G(F .. "/" .. M .. "/" .. ci .. "/" .. cl .. "/" .. cg .. ".json", "DELETE")
                G(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. cg .. ".json", "DELETE")
            end)
        else
            pcall(function() G(F .. "/" .. L .. "/" .. Z .. "/" .. cg .. ".json", "DELETE") end)
        end
    end)
    bs.TriggerToast("🗑️ Unsent", "Message recalled globally", false)
    if bs.ActiveBubbleNodes[cg] then bs.ActiveBubbleNodes[cg]:Destroy(); bs.ActiveBubbleNodes[cg] = nil end
end

function bs.StartEditing(cg, gM)
    bs.EditingMsgID = cg; bs.UI.TextBox.Text = gM; bs.UI.ReplyIcon.Text = "✏️"
    bs.UI.ReplyText.Text = "Editing your message...\n" .. gM:sub(1, 28)
    bs.UI.ReplyPreview.Visible = true
    g:Create(bs.UI.ReplyPreview, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 12, 1, -(bs.Layout.NavH + 78))}):Play()
    bs.UI.TextBox:CaptureFocus()
end

function bs.SetReply(fa, b4, gN)
    local f8 = bY(b4)
    if #f8 > 28 and not f8:match("^%[") then f8 = f8:sub(1, 28) .. "..." end
    bs.ReplyingTo = {Username = fa, DispName = gN, Text = f8}
    bs.UI.ReplyText.Text = "Replying to <b>" .. gN .. "</b>\n" .. f8
    bs.UI.ReplyIcon.Text = "↩"; bs.UI.ReplyPreview.Visible = true
    g:Create(bs.UI.ReplyPreview, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 12, 1, -(bs.Layout.NavH + 78))}):Play()
    bs.UI.TextBox:CaptureFocus()
end

function bs.CancelActionBar()
    bs.ReplyingTo = nil; bs.EditingMsgID = nil
    if not bs.UI.ReplyPreview then return end
    local ff = g:Create(bs.UI.ReplyPreview, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 12, 1, -(bs.Layout.NavH + 44))})
    ff:Play()
    task.spawn(function() ff.Completed:Wait(); if bs.UI.ReplyPreview then bs.UI.ReplyPreview.Visible = false end end)
end

function bs.HandleScroll(gO)
    task.spawn(function()
        h.RenderStepped:Wait(); h.RenderStepped:Wait()
        if not bs.UI.Scroll then return end
        local gP = bs.UI.Scroll.CanvasSize.Y.Offset - bs.UI.Scroll.AbsoluteWindowSize.Y
        if gP <= 0 then return end
        local gQ = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        if gO then
            g:Create(bs.UI.Scroll, gQ, {CanvasPosition = Vector2.new(0, gP)}):Play()
            bs.UI.JumpBtn.Visible = false
        elseif bs.UI.Scroll.CanvasPosition.Y < gP - 50 then
            bs.UI.JumpBtn.Visible = true
        else
            g:Create(bs.UI.Scroll, gQ, {CanvasPosition = Vector2.new(0, gP)}):Play()
        end
    end)
end
-- ========================================================================= --
--  👑 ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION (UNCUT)
--  PART 8 / 8 : NAVIGATION ROUTER, COMMANDS, STAGGERED SYNC LOOP & BOOTSTRAP
-- ========================================================================= --

-- ========================================================================= --
-- [SECTION A : UNIFIED MODE ROUTER (CHAT, DM, INSTA PROFILE, CUSTOMIZE, ALERTS)]
-- ========================================================================= --
function bs.SwitchMode(gV, gW)
    local ae = bL[bs.CurrentTheme] or bL.PureBlack
    local headH = bs.Layout.HeaderH
    local navH = bs.Layout.NavH

    bs.Mode = gV
    bs.ActiveDM = (gV == "DM" and gW) and tostring(gW):lower() or nil

    if bs.UI.Scroll then
        for _, aK in pairs(bs.UI.Scroll:GetChildren()) do
            if not aK:IsA("UIListLayout") and not aK:IsA("UIPadding") then
                aK:Destroy()
            end
        end
    end
    bs.ActiveBubbleNodes = {}
    bs.MessagesCount = 0

    -- Hide all panels & popups cleanly before switching
    if bs.UI.SettingsPage then bs.UI.SettingsPage.Visible = false end
    if bs.UI.Scroll then bs.UI.Scroll.Visible = false end
    if bs.UI.InputWrapper then bs.UI.InputWrapper.Visible = false end
    if bs.UI.SearchWrapper then bs.UI.SearchWrapper.Visible = false end
    if bs.UI.StickerTray then bs.UI.StickerTray.Visible = false end
    if bs.UI.ImageTray then bs.UI.ImageTray.Visible = false end
    if bs.UI.ReplyPreview then bs.UI.ReplyPreview.Visible = false end
    if bs.UI.AdminTray then bs.UI.AdminTray.Visible = false end
    if bs.UI.MusicPanel then bs.UI.MusicPanel.Visible = false end
    if bs.UI.ProfilePage then bs.UI.ProfilePage.Visible = false end
    if bs.UI.CustomizePage then bs.UI.CustomizePage.Visible = false end
    if bs.UI.NotifsPage then bs.UI.NotifsPage.Visible = false end
    if bs.UI.JumpBtn then bs.UI.JumpBtn.Visible = false end
    if bs.UI.SubTitle then bs.UI.SubTitle.Visible = false end

    if bs.UI.MainBg and bs.UI.MainBg:FindFirstChild("InstaSocialOverlay") then
        bs.UI.MainBg.InstaSocialOverlay:Destroy()
    end

    if bs.UI.Title then
        bs.UI.Title.Visible = true
        bs.UI.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    if bs.UI.TitleGrad then
        bs.UI.TitleGrad.Enabled = true
    end

    if gV == "Settings" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "SETTINGS & TOOLS"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        if bs.UI.SettingsPage then bs.UI.SettingsPage.Visible = true end

    elseif gV == "Music" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "ᴢ ᴀ ʏ ɴ  ᴍ ᴜ s ɪ ᴄ"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        if bs.UI.MusicPanel then bs.UI.MusicPanel.Visible = true end

    elseif gV == "Profile" then
        local targetUid = tostring(gW or bs.Social.ViewingProfileUid or bs.Social.MyUid)
        bs.Social.ViewingProfileUid = targetUid
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = (targetUid == bs.Social.MyUid) and "MY INSTA PROFILE" or "USER PROFILE"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        if bs.UI.ProfilePage then
            bs.UI.ProfilePage.Visible = true
            bs.UI.ProfilePage.CanvasPosition = Vector2.new(0, 0)
            bs.RefreshProfileUI(targetUid)
        end

    elseif gV == "Customize" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "PROFILE CUSTOMIZATION"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        if bs.UI.CustomizePage then
            bs.UI.CustomizePage.Visible = true
            bs.RefreshCustomizeUI()
            task.spawn(function()
                bs.SocialEngine.FetchStoreConfig()
                bs.SocialEngine.FetchEntitlements(bs.Social.MyUid, true)
                if bs.Mode == "Customize" then
                    bs.RefreshCustomizeUI()
                end
            end)
        end

    elseif gV == "Notifications" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "SOCIAL ALERTS"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        if bs.UI.NotifsPage then
            bs.UI.NotifsPage.Visible = true
            bs.RefreshNotifsUI()
            task.spawn(function()
                bs.SocialEngine.FetchMyNotifications(true)
                bs.SocialEngine.FetchMyRequests()
                if bs.Mode == "Notifications" then
                    bs.RefreshNotifsUI()
                end
            end)
        end

    elseif gV == "Server" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "ᴢ ᴀ ʏ ɴ  ᴄ ʜ ᴀ ᴛ  ᴠ71"
        bs.UI.Title.Position = UDim2.new(0, 14, 0, 0)
        bs.UI.Back.Visible = false
        bs.UI.InputWrapper.Visible = true
        bs.UI.Scroll.Position = UDim2.new(0, 0, 0, headH)
        bs.UI.Scroll.Size = UDim2.new(1, 0, 1, -(headH + navH + 46))
        bs.UI.Scroll.Visible = true
        bs.UI.TextBox.PlaceholderText = bs.IsLocked and "🔒 ZAYN CHAT LOCKED BY ADMIN" or "Type message..."
        for _, bK in ipairs(bs.Cache.Server) do
            bs.RenderBubble(bK.Sender, bK.UserID, bK.Msg, bK.Time, bK.ID, bK.Edited, bK.Reactions)
        end

    elseif gV == "CloseFriends" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "CLOSE FRIENDS"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        bs.UI.Scroll.Position = UDim2.new(0, 0, 0, headH + 4)
        bs.UI.Scroll.Size = UDim2.new(1, 0, 1, -(headH + navH + 4))
        bs.UI.Scroll.Visible = true
        if #bs.CloseFriends == 0 then
            local b1 = Instance.new("TextLabel", bs.UI.Scroll)
            b1.Size = UDim2.new(1, 0, 0, 44)
            b1.BackgroundTransparency = 1
            b1.Font = Enum.Font.GothamMedium
            b1.TextSize = 12
            b1.TextColor3 = ae.SubText
            b1.Text = "Your Close Friends list is empty.\nSearch in DMs Inbox to add friends!"
            b1.RichText = true
            b1.TextXAlignment = Enum.TextXAlignment.Center
        else
            for _, cw in ipairs(bs.CloseFriends) do
                local fN = bs.GetAccount(cw)
                bs.RenderUserSearchCard(fN.DisplayName, fN.Username, fN.UserId, true, bs.GetUnreadCount(cw:lower()))
            end
        end

    elseif gV == "DM_Inbox" then
        bs.UI.HeaderDP.Visible = false
        bs.UI.Title.Text = "DMS INBOX"
        bs.UI.Title.Position = UDim2.new(0, 42, 0, 0)
        bs.UI.Back.Visible = true
        bs.UI.SearchWrapper.Visible = true
        bs.UI.SearchInput.PlaceholderText = "Search username or User ID..."
        bs.UI.Scroll.Position = UDim2.new(0, 0, 0, headH + 46)
        bs.UI.Scroll.Size = UDim2.new(1, 0, 1, -(headH + navH + 46))
        bs.UI.Scroll.Visible = true
        bs.LiveUpdateInboxSort()

    elseif gV == "DM" then
        local dmKey = tostring(gW or ""):lower()
        bs.SetLastRead(dmKey, aB())
        local fN = bs.GetAccount(dmKey)
        bs.UI.HeaderDP.Visible = true
        cc(bs.UI.HeaderDP, fN.Username)
        if bs.UI.TitleGrad then bs.UI.TitleGrad.Enabled = false end
        bs.UI.Title.TextColor3 = ae.TextColor
        bs.UI.Title.Text = fN.DisplayName
        bs.UI.Title.Position = UDim2.new(0, 68, 0, -4)
        if bs.UI.SubTitle then
            bs.UI.SubTitle.Visible = true
            bs.UI.SubTitle.Text = "@" .. fN.Username .. " • Tap name for Profile"
        end
        bs.UI.Back.Visible = true
        bs.UI.InputWrapper.Visible = true
        bs.UI.Scroll.Position = UDim2.new(0, 0, 0, headH)
        bs.UI.Scroll.Size = UDim2.new(1, 0, 1, -(headH + navH + 46))
        bs.UI.Scroll.Visible = true
        bs.UI.TextBox.PlaceholderText = bs.IsLocked and "🔒 ZAYN CHAT LOCKED BY ADMIN" or "Type message..."
        if bs.Cache.DMs[dmKey] then
            for _, bK in ipairs(bs.Cache.DMs[dmKey]) do
                bs.RenderBubble(bK.Sender, bK.UserID, bK.Msg, bK.Time, bK.ID, bK.Edited, bK.Reactions)
            end
        end
    end

    bs.UpdateNavActiveState(gV)
    if gV == "Server" or gV == "DM" then
        bs.HandleScroll(true)
    end
end

-- ========================================================================= --
-- [SECTION B : MESSAGE SENDING, EDITING & V71.0 CHAT COMMANDS]
-- ========================================================================= --
local function build18CharDynamicPacketKey(prefix)
    return prefix .. "_" .. generate18CharDynamicKey()
end

function bs.Send(em)
    if bs.IsLocked then return end
    local ci = m.Name:lower()

    if bs.Mode == "DM" and bs.ActiveDM then
        local targetAcc = bs.GetAccount(bs.ActiveDM)
        if targetAcc and targetAcc.UserId and targetAcc.UserId > 1 and bs.SocialEngine.IsBlocked(targetAcc.UserId) then
            bs.TriggerToast("🚫 Blocked", "Unblock this user to send DMs.", false)
            return
        end
    end

    if bs.ReplyingTo then
        em = string.format("[RPL::%s::%s::RPL] %s", bs.ReplyingTo.Username, bs.ReplyingTo.Text, em)
    end

    local function gX(p)
        local gY = p:lower()
        return gY:match("^https?://.+") and (gY:find("%.png") or gY:find("%.jpg") or gY:find("%.jpeg") or gY:find("%.webp") or gY:find("%.gif"))
    end
    if gX(em) and not em:match("^%[MEDIA::") then
        em = "[MEDIA::" .. em .. "::MEDIA]"
    end

    local h0 = aB()

    if bs.Mode == "DM" and bs.ActiveDM then
        local cl = bs.ActiveDM
        local gZ = build18CharDynamicPacketKey("ZDM")
        local cz, h1 = b3(be(ci, cl), em)
        local by = f:JSONEncode({u = m.UserId, s = m.Name, m = cz, sign = h1, t = h0})
        bs.PendingCommitGrace[gZ] = os.clock()
        bx(F .. "/" .. M .. "/" .. ci .. "/" .. cl .. "/" .. gZ .. ".json", by)
        bx(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. gZ .. ".json", by)
        bs.SetLastRead(cl, h0)
        task.spawn(function()
            pcall(function() G(F .. "/" .. S .. "/" .. cl .. "/" .. ci .. "/" .. gZ .. ".json", "PUT", '"true"') end)
        end)
        bs.SeenIDs[gZ] = h1
        bs.Cache.DMs[cl] = bs.Cache.DMs[cl] or {}
        table.insert(bs.Cache.DMs[cl], {Sender = m.Name, UserID = m.UserId, Msg = em, Time = h0, ID = gZ, Edited = false, Reactions = {}})
        bs.RenderBubble(m.Name, m.UserId, em, h0, gZ, false, {})
        bs.LiveUpdateInboxSort()

    elseif bs.Mode == "Server" then
        local gZ = build18CharDynamicPacketKey("ZNET")
        local cz, h1 = b3(V() .. Z, em)
        local by = f:JSONEncode({u = m.UserId, s = m.Name, m = cz, sign = h1, t = h0})
        bs.PendingCommitGrace[gZ] = os.clock()
        bx(F .. "/" .. L .. "/" .. Z .. "/" .. gZ .. ".json", by)
        bs.SeenIDs[gZ] = h1
        table.insert(bs.Cache.Server, {Sender = m.Name, UserID = m.UserId, Msg = em, Time = h0, ID = gZ, Edited = false, Reactions = {}})
        if m.Character and m.Character:FindFirstChild("Head") then
            pcall(function() game:GetService("Chat"):Chat(m.Character.Head, bY(em), Enum.ChatColor.White) end)
        end
        bs.RenderBubble(m.Name, m.UserId, em, h0, gZ, false, {})
    end
end

function bs.SubmitEdit(cg, h2)
    local ci = m.Name:lower()
    local h0 = aB()

    if bs.Mode == "DM" and bs.ActiveDM then
        local cl = bs.ActiveDM
        local cz, h1 = b3(be(ci, cl), "[EDT]" .. h2)
        for _, cp in ipairs(bs.Cache.DMs[cl] or {}) do
            if cp.ID == cg then cp.Msg = h2; cp.Edited = true; break end
        end
        bs.SeenIDs[cg] = h1
        local by = f:JSONEncode({u = m.UserId, s = m.Name, m = cz, sign = h1, t = h0})
        bx(F .. "/" .. M .. "/" .. ci .. "/" .. cl .. "/" .. cg .. ".json", by)
        bx(F .. "/" .. M .. "/" .. cl .. "/" .. ci .. "/" .. cg .. ".json", by)
        local fD = bs.ActiveBubbleNodes[cg]
        if fD and fD:FindFirstChild("MessageBubble") then
            fD.MessageBubble:SetAttribute("LiveText", h2)
            if fD.MessageBubble:FindFirstChild("MainMessageText") then
                fD.MessageBubble.MainMessageText.Text = h2 .. "\n<font color='#888888' size='10'><i>(edited)</i></font>"
            end
        end
    elseif bs.Mode == "Server" then
        local cz, h1 = b3(V() .. Z, "[EDT]" .. h2)
        for _, cp in ipairs(bs.Cache.Server or {}) do
            if cp.ID == cg then cp.Msg = h2; cp.Edited = true; break end
        end
        bs.SeenIDs[cg] = h1
        local by = f:JSONEncode({u = m.UserId, s = m.Name, m = cz, sign = h1, t = h0})
        bx(F .. "/" .. L .. "/" .. Z .. "/" .. cg .. ".json", by)
        local fD = bs.ActiveBubbleNodes[cg]
        if fD and fD:FindFirstChild("MessageBubble") then
            fD.MessageBubble:SetAttribute("LiveText", h2)
            if fD.MessageBubble:FindFirstChild("MainMessageText") then
                fD.MessageBubble.MainMessageText.Text = h2 .. "\n<font color='#888888' size='10'><i>(edited)</i></font>"
            end
        end
    end
end

local function h3()
    if bs.IsLocked then return end
    local em = bs.UI.TextBox.Text
    if em == "" then return end

    local lowCmd = em:lower():match("^%s*(.-)%s*$")

    -- Instant local shortcut commands
    if lowCmd == "/helpphoto" then
        bs.UI.TextBox.Text = ""
        local helpMsg = "<b>🖼️ Image Vault Guide:</b>\n1. Upload your photo to ImgBB / Catbox / Discord.\n2. Copy the <b>direct link</b> ending in .png / .jpg / .webp.\n3. Open Settings → Image Vault → Paste URL → Save!"
        local localId = "SYS_LOCAL_HELP_" .. os.time()
        table.insert(bs.Cache.Server, {Sender = "ZARA", UserID = 0, Msg = helpMsg, Time = aB(), ID = localId, Edited = false, Reactions = {}})
        if bs.Mode == "Server" then bs.RenderBubble("ZARA", 0, helpMsg, aB(), localId, false, {})
        else bs.TriggerToast("🖼️ Image Vault Help", "Paste direct .png/.jpg link in Vault!", false, nil, "ZARA") end
        return
    elseif lowCmd == "/customize" or lowCmd == "/store" or lowCmd == "/themes" then
        bs.UI.TextBox.Text = ""
        bs.OpenCustomizePage(lowCmd == "/themes" and "Theme" or (lowCmd == "/store" and "PremiumStore" or "Decoration"))
        return
    elseif lowCmd == "/profile" then
        bs.UI.TextBox.Text = ""
        bs.OpenUserProfile(bs.Social.MyUid)
        return
    end

    local profTarget = em:match("^/profile%s+(@?%S+)$")
    if profTarget then
        bs.UI.TextBox.Text = ""
        task.spawn(function()
            local res = bs.ResolveUserInput(profTarget)
            if res and res.UserId then bs.OpenUserProfile(res.UserId)
            else bs.TriggerSocialToast("⚠️ Not Found", "No user found for '" .. profTarget .. "'", Color3.fromRGB(235, 70, 85), bs.Social.MyUid) end
        end)
        return
    end

    local followTarget = em:match("^/follow%s+(@?%S+)$")
    if followTarget then
        bs.UI.TextBox.Text = ""
        task.spawn(function()
            local res = bs.ResolveUserInput(followTarget)
            if res and res.UserId then
                local ok, msg = bs.SocialEngine.FollowUser(res.UserId)
                bs.TriggerSocialToast(ok and "👥 Followed" or "⚠️ Notice", msg, ok and Color3.fromRGB(0, 230, 175) or Color3.fromRGB(235, 70, 85), res.UserId)
            else
                bs.TriggerSocialToast("⚠️ Not Found", "Could not find '" .. followTarget .. "'", Color3.fromRGB(235, 70, 85), bs.Social.MyUid)
            end
        end)
        return
    end

    local unfollowTarget = em:match("^/unfollow%s+(@?%S+)$")
    if unfollowTarget then
        bs.UI.TextBox.Text = ""
        task.spawn(function()
            local res = bs.ResolveUserInput(unfollowTarget)
            if res and res.UserId then
                local _, msg = bs.SocialEngine.UnfollowUser(res.UserId)
                bs.TriggerSocialToast("👥 Unfollow", msg, Color3.fromRGB(185, 190, 215), res.UserId)
            end
        end)
        return
    end

    -- 3-second chat cooldown
    local tDiff = os.clock() - bs.LastSendTime
    if tDiff < 3.0 and (bs.Mode == "Server" or bs.Mode == "DM") then
        task.spawn(function()
            local op = bs.UI.InputWrapper.Position
            for idx = 1, 6 do
                bs.UI.InputWrapper.Position = op + UDim2.new(0, idx % 2 == 0 and 6 or -6, 0, 0)
                task.wait(0.03)
            end
            bs.UI.InputWrapper.Position = op
        end)
        return
    end

    local h4 = em:match("^/global%s+(.+)$")
    local djUser = em:match("^/dj%s+(@?%S+)$")
    local undjUser = em:match("^/undj%s+(@?%S+)$")

    if h4 and au() then
        bs.UI.TextBox.Text = ""
        task.spawn(function() G(F .. "/" .. R .. ".json", "PUT", f:JSONEncode({m = h4, t = aB()})) end)
        bs.TriggerToast("📢 Broadcast", "Sent to all servers!", false)
        return
    elseif (h4 or djUser or undjUser) and not au() then
        bs.UI.TextBox.Text = ""
        ap("GOD-SPOOF", "Illegal Admin Command Attempt")
        return
    end

    if string.len(em) > 200 then
        bs.TriggerToast("⚠️ System", "Limit Exceeded! Message is too long.", false)
        return
    end
    if string.lower(em) == string.lower(bs.LastSentMessage) then
        bs.TriggerToast("⚠️ Spam Alert", "You cannot send the exact same message repeatedly.", false)
        return
    end

    local h5, h6 = os.clock(), {}
    for _, ae in ipairs(bs.MessageTimestamps) do
        if h5 - ae <= 10.0 then table.insert(h6, ae) end
    end
    bs.MessageTimestamps = h6
    if #bs.MessageTimestamps >= 10 then
        bs.TriggerToast("⚠️ Spam Blocked", "Typing too fast! Limit: 10 msgs / 10 sec", false)
        return
    end

    bs.UI.TextBox.Text = ""
    bs.LastSentMessage = em
    bs.LastSendTime = os.clock()
    table.insert(bs.MessageTimestamps, os.clock())

    local h7, h8 = em:match("^/title%s+(@?%S+)%s+(.+)$")
    local h9 = em:match("^/untitle%s+(@?%S+)$")
    if h7 or h9 or djUser or undjUser then
        bs.CancelActionBar()
        if au() then
            local cv
            if h7 then cv = "GRANT_TITLE:" .. h7:gsub("^@", ""):lower() .. ":" .. h8
            elseif h9 then cv = "REVOKE_TITLE:" .. h9:gsub("^@", ""):lower()
            elseif djUser then local target = djUser:gsub("^@", ""):lower(); bs.DJRegistry[target] = true; cv = "GRANT_DJ:" .. target
            elseif undjUser then local target = undjUser:gsub("^@", ""):lower(); bs.DJRegistry[target] = nil; cv = "REVOKE_DJ:" .. target end

            local ha, hb = b3(W, cv)
            task.spawn(function()
                G(F .. "/" .. L .. "/" .. Z .. "/ZAYN_NET_GOD_" .. os.time() .. "_" .. math.random(100, 999) .. ".json", "PUT", f:JSONEncode({
                    u = m.UserId, s = "ZARA_OVERSEER_PROTOCOL", m = ha, sign = hb, t = aB()
                }))
            end)
            bs.TriggerToast("⚙️ Admin Command", "Executed: " .. (cv:match("^(.-):") or cv), false)
        else
            ap("ADM-SPOOF", "Admin Protocol Breach")
        end
        return
    end

    if bs.EditingMsgID then
        local hc = bs.EditingMsgID
        bs.CancelActionBar()
        bs.SubmitEdit(hc, em)
    else
        bs.Send(em)
        bs.CancelActionBar()
    end
end

-- ========================================================================= --
-- [SECTION C : MODULAR ZERO-LAG STAGGERED NETWORK POLLERS]
-- ========================================================================= --
local function pollServerChat(dn, hM)
    local hW = bA(L .. "/" .. Z)
    local hX = {}
    if type(hW) == "table" then
        for cg, hY in pairs(hW) do
            hX[cg] = true
            local hZ = tonumber(typeof(hY) == "table" and hY.t or 0)
            local h_ = hZ < aC - 25
            if typeof(hY) == "table" and hY.t and (dn - hZ > 600) then
                task.spawn(function() pcall(function() G(F .. "/" .. L .. "/" .. Z .. "/" .. cg .. ".json", "DELETE") end) end)
            end

            if typeof(hY) == "table" and hY.s == "ZARA_OVERSEER_PROTOCOL" and tonumber(hY.u) == 10432865434 and hY.m then
                if not bs.SeenIDs[cg] and not h_ then
                    bs.SeenIDs[cg] = true
                    local i0 = b9(W, hY.m, hY.sign)
                    if i0 then
                        if i0:sub(1, 12) == "GRANT_TITLE:" then
                            local i1, i2 = i0:sub(13):match("^(.-):(.+)$")
                            if i1 and i2 then bs.TitleRegistry[i1:lower()] = i2; bs.LiveSyncAllVisibleBubblesTitle() end
                        elseif i0:sub(1, 13) == "REVOKE_TITLE:" then
                            bs.TitleRegistry[i0:sub(14):lower()] = nil; bs.LiveSyncAllVisibleBubblesTitle()
                        elseif i0:sub(1, 10) == "LOCK_CHAT:" then
                            if m.Name:lower() == i0:sub(11):lower() then
                                bs.SetLockState(true)
                                bs.TriggerToast("🔒 SYSTEM DISCIPLINE", "Your chat privileges were suspended by Admin.", false)
                            end
                        elseif i0:sub(1, 12) == "UNLOCK_CHAT:" then
                            if m.Name:lower() == i0:sub(13):lower() then
                                bs.SetLockState(false)
                                bs.TriggerToast("🔓 SYSTEM UPDATE", "Chat privileges restored.", false)
                            end
                        elseif i0:sub(1, 12) == "SHADOW_MUTE:" then
                            bs.ShadowMuted[i0:sub(13):lower()] = true
                        elseif i0:sub(1, 13) == "MUTE_KEYWORD:" then
                            bs.MutedKeywords[i0:sub(14):lower()] = true
                        elseif i0:sub(1, 15) == "UNMUTE_KEYWORD:" then
                            bs.MutedKeywords[i0:sub(16):lower()] = nil
                        elseif i0:sub(1, 9) == "GRANT_DJ:" then
                            local cw = i0:sub(10):lower()
                            bs.DJRegistry[cw] = true
                            if m.Name:lower() == cw then bs.TriggerToast("🎵 SYSTEM UPDATE", "Granted Server DJ Access.", true) end
                        elseif i0:sub(1, 10) == "REVOKE_DJ:" then
                            local cw = i0:sub(11):lower()
                            bs.DJRegistry[cw] = nil
                            if m.Name:lower() == cw then bs.TriggerToast("🎵 SYSTEM UPDATE", "Server DJ Access revoked.", false) end
                        elseif i0:sub(1, 9) == "BAN_USER:" then
                            local i3 = i0:sub(10):lower()
                            if m.Name:lower() == i3 then
                                task.spawn(function()
                                    G(F .. "/" .. O .. "/HWs/" .. D .. ".json", "PUT", '"true"')
                                    G(F .. "/" .. O .. "/Accs/" .. i3 .. ".json", "PUT", f:JSONEncode(D))
                                end)
                                pcall(function() if writefile then writefile(X, "PERMA_BANNED_BY_MATRIX_ADMIN") end end)
                                _()
                            end
                        elseif i0:sub(1, 11) == "UNBAN_USER:" then
                            if m.Name:lower() == i0:sub(12):lower() then
                                pcall(function() if delfile then delfile(X) end end)
                            end
                        end
                    end
                end
            elseif typeof(hY) == "table" and hY.s == "SYS_ZARA_ARRIVAL" and hY.m then
                if not bs.SeenIDs[cg] and not h_ and tonumber(hY.u) ~= m.UserId then
                    bs.SeenIDs[cg] = true
                    local arrMsg = "Welcome dear " .. tostring(hY.m) .. "!"
                    table.insert(bs.Cache.Server, {Sender = "ZARA", UserID = 0, Msg = arrMsg, Time = hZ, ID = cg, Edited = false, Reactions = {}})
                    if bs.Mode == "Server" then bs.RenderBubble("ZARA", 0, arrMsg, hZ, cg, false, {}) end
                    if not hM then bs.TriggerArrivalToast(tostring(hY.m)) end
                end
            elseif typeof(hY) == "table" and hY.m and hY.sign and hY.s then
                local i4 = bs.SeenIDs[cg] ~= nil
                bs.SeenIDs[cg] = hY.sign
                if hY.u then
                    bs.RegisterAccount(hY.s, nil, hY.u)
                    local uKey = tostring(hY.u)
                    if tonumber(hY.u) and tonumber(hY.u) > 1 and not bs.Social.Profiles[uKey] then
                        task.spawn(function() bs.SocialEngine.FetchProfile(uKey, false) end)
                    end
                end
                local i5 = not (bs.ShadowMuted[hY.s:lower()] and hY.s:lower() ~= m.Name:lower())
                if i5 then
                    local i6 = b9(V() .. Z, hY.m, hY.sign)
                    if i6 then
                        local fV = i6:sub(1, 5) == "[EDT]"
                        local hv = fV and i6:sub(6) or i6
                        local i7 = false
                        local i8 = hv:lower():gsub("0", "o"):gsub("1", "i"):gsub("3", "e"):gsub("4", "a"):gsub("5", "s"):gsub("7", "t"):gsub("@", "a"):gsub("%$", "s"):gsub("[ %._%-]", "")
                        for cD, _ in pairs(bs.MutedKeywords) do
                            if string.find(i8, cD:lower():gsub("[ %._%-]", "")) then i7 = true; break end
                        end
                        if not (i7 and hY.s:lower() ~= m.Name:lower()) then
                            if i4 then
                                local ia, ib = bs.ActiveBubbleNodes[cg], false
                                for _, cp in ipairs(bs.Cache.Server) do
                                    if cp.ID == cg then
                                        if cp.Msg ~= hv then
                                            cp.Msg = hv; cp.Edited = true; ib = true
                                            if ia and ia:FindFirstChild("MessageBubble") then
                                                ia.MessageBubble:SetAttribute("LiveText", hv)
                                                if ia.MessageBubble:FindFirstChild("MainMessageText") then
                                                    ia.MessageBubble.MainMessageText.Text = hv .. "\n<font color='#888888' size='10'><i>(edited)</i></font>"
                                                end
                                            end
                                        end
                                        if not s(cp.Reactions or {}, hY._rct or {}) then cp.Reactions = hY._rct or {}; ib = true end
                                        break
                                    end
                                end
                                if ib then bs.UpdateBubbleReactions(cg, hY._rct) end
                            elseif not h_ then
                                table.insert(bs.Cache.Server, {Sender = hY.s, UserID = hY.u, Msg = hv, Time = hZ, ID = cg, Edited = fV, Reactions = hY._rct or {}})
                                if string.lower(hY.s) ~= string.lower(m.Name) then
                                    local eB = e:FindFirstChild(hY.s) and e[hY.s].Character
                                    if eB and eB:FindFirstChild("Head") then
                                        pcall(function() game:GetService("Chat"):Chat(eB.Head, bY(hv), Enum.ChatColor.White) end)
                                    end
                                end
                                if bs.Mode == "Server" then bs.RenderBubble(hY.s, hY.u, hv, hZ, cg, fV, hY._rct or {}) end
                                if not hM and not bs.MuteServerToasts then bs.TriggerToast("🌐 Server Chat", hY.s .. ": " .. hv, false, nil, hY.s) end
                            end
                        end
                    end
                end
            end
        end
    end

    if bs.Mode == "Server" then
        for ic, b1 in pairs(bs.ActiveBubbleNodes) do
            if hW and not hX[ic] and not ic:match("^SYS_LOCAL") then
                if not (bs.PendingCommitGrace[ic] and os.clock() - bs.PendingCommitGrace[ic] < 45) then
                    b1:Destroy(); bs.ActiveBubbleNodes[ic] = nil
                end
            elseif hX[ic] then
                bs.PendingCommitGrace[ic] = nil
            end
        end
    end
end

local function pollDirectMessages(ci, dn, hM)
    local id = bA(M .. "/" .. ci)
    if type(id) ~= "table" then return end

    for g_, gR in pairs(id) do
        if typeof(gR) == "table" then
            bs.Cache.DMs[g_] = bs.Cache.DMs[g_] or {}
            local hs, iN = be(ci, g_), {}

            if not bs.AccountRegistry[g_] then
                task.spawn(function()
                    local res = bs.ResolveUserInput(g_)
                    if res then bs.RegisterAccount(res.Username, res.DisplayName, res.UserId) end
                end)
            end

            for hu, hY in pairs(gR) do
                iN[hu] = true
                if hu ~= "_typ" then
                    local hZ = tonumber(typeof(hY) == "table" and hY.t or 0)
                    if dn - hZ > aD then
                        task.spawn(function()
                            pcall(function()
                                G(F .. "/" .. M .. "/" .. ci .. "/" .. g_ .. "/" .. hu .. ".json", "DELETE")
                                G(F .. "/" .. M .. "/" .. g_ .. "/" .. ci .. "/" .. hu .. ".json", "DELETE")
                            end)
                        end)
                        if bs.ActiveBubbleNodes[hu] then bs.ActiveBubbleNodes[hu]:Destroy(); bs.ActiveBubbleNodes[hu] = nil end
                    elseif typeof(hY) == "table" and hY.m and hY.sign and hY.s then
                        local ig = bs.SeenIDs[hu] ~= nil
                        bs.SeenIDs[hu] = hY.sign
                        if hY.u then bs.RegisterAccount(hY.s, nil, hY.u) end
                        local i6 = b9(hs, hY.m, hY.sign)
                        if i6 then
                            local fV = i6:sub(1, 5) == "[EDT]"
                            local hv = fV and i6:sub(6) or i6
                            local i7 = false
                            local i8 = hv:lower():gsub("0", "o"):gsub("1", "i"):gsub("3", "e"):gsub("4", "a"):gsub("5", "s"):gsub("7", "t"):gsub("@", "a"):gsub("%$", "s"):gsub("[ %._%-]", "")
                            for cD, _ in pairs(bs.MutedKeywords) do
                                if string.find(i8, cD:lower():gsub("[ %._%-]", "")) then i7 = true; break end
                            end
                            if not (i7 and hY.s:lower() ~= m.Name:lower()) then
                                if ig then
                                    local ia, ib = bs.ActiveBubbleNodes[hu], false
                                    for _, cp in ipairs(bs.Cache.DMs[g_]) do
                                        if cp.ID == hu then
                                            if cp.Msg ~= hv then
                                                cp.Msg = hv; cp.Edited = true; ib = true
                                                if ia and ia:FindFirstChild("MessageBubble") then
                                                    ia.MessageBubble:SetAttribute("LiveText", hv)
                                                    if ia.MessageBubble:FindFirstChild("MainMessageText") then
                                                        ia.MessageBubble.MainMessageText.Text = hv .. "\n<font color='#888888' size='10'><i>(edited)</i></font>"
                                                    end
                                                end
                                            end
                                            if not s(cp.Reactions or {}, hY._rct or {}) then cp.Reactions = hY._rct or {}; ib = true end
                                            break
                                        end
                                    end
                                    if ib then bs.UpdateBubbleReactions(hu, hY._rct) end
                                else
                                    table.insert(bs.Cache.DMs[g_], {Sender = hY.s, UserID = hY.u, Msg = hv, Time = hZ, ID = hu, Edited = fV, Reactions = hY._rct or {}})
                                    if bs.Mode == "DM" and bs.ActiveDM == g_ then
                                        bs.RenderBubble(hY.s, hY.u, hv, hZ, hu, fV, hY._rct or {})
                                        bs.SetLastRead(g_, aB())
                                    end
                                    bs.LiveUpdateInboxSort()
                                    if not hM or bs.Mode ~= "DM" or bs.ActiveDM ~= g_ then
                                        bs.TriggerToast("💬 DM : " .. bs.GetAccount(g_).DisplayName, hv, true, g_, hY.s)
                                    end
                                end
                            end
                        end
                    end
                elseif typeof(hY) == "table" and hY.t then
                    local ih = dn - tonumber(hY.t)
                    if ih <= 4 and bs.Mode == "DM" and bs.ActiveDM == g_ then
                        bs.UI.Title.Text = (hY.s or g_) .. " is ᴛʏᴘɪɴɢ..."
                        bs.UI.Title.TextColor3 = Color3.fromRGB(0, 220, 255)
                    elseif bs.Mode == "DM" and bs.ActiveDM == g_ then
                        bs.UI.Title.Text = bs.GetAccount(g_).DisplayName
                        bs.UI.Title.TextColor3 = (bL[bs.CurrentTheme] or bL.PureBlack).TextColor
                    end
                end
            end

            if bs.Mode == "DM" and bs.ActiveDM == g_ then
                for ic, b1 in pairs(bs.ActiveBubbleNodes) do
                    if not iN[ic] and ic ~= "_typ" then
                        if not (bs.PendingCommitGrace[ic] and os.clock() - bs.PendingCommitGrace[ic] < 45) then
                            b1:Destroy(); bs.ActiveBubbleNodes[ic] = nil
                        end
                    elseif iN[ic] then
                        bs.PendingCommitGrace[ic] = nil
                    end
                end
            end
        end
    end
end

local function pollBroadcastsAndReadReceipts(ci, dn)
    local hU = bA(R)
    if type(hU) == "table" and hU.m and hU.t then
        local hV = tonumber(hU.t) or 0
        if hV > aC - 15 and bs.SeenIDs["BROADCAST_" .. hV] == nil then
            bs.SeenIDs["BROADCAST_" .. hV] = true
            local bMsg = tostring(hU.m)
            if bMsg:sub(1, 11) == "/musicsync " then
                local trackId, rbTrack, rbName = bMsg:sub(12):match("^(.-)%s*|%s*(.-)%s*|%s*(.+)$")
                if rbTrack and trackId then
                    local syncText = "<font color='#ff0000'>🎵</font> <font color='#ff7f00'>S</font><font color='#ffff00'>E</font><font color='#00ff00'>R</font><font color='#0000ff'>V</font><font color='#4b0082'>E</font><font color='#9400d3'>R</font> <font color='#ff0000'>S</font><font color='#ff7f00'>Y</font><font color='#ffff00'>N</font><font color='#00ff00'>C</font> <font color='#ffffff'>-</font> " .. rbName .. " <font color='#ffffff'>is playing:</font> <b>" .. rbTrack .. "</b>"
                    bs.TriggerToast("🌐 SERVER SYNC", "A DJ is playing a track!", true, nil, "ZARA")
                    table.insert(bs.Cache.Server, {Sender = "ZARA", UserID = 0, Msg = syncText, Time = aB(), ID = "SYS_LOCAL_DJ_SYNC_" .. hV, Edited = false, Reactions = {}})
                    if bs.Mode == "Server" then bs.RenderBubble("ZARA", 0, syncText, aB(), "SYS_LOCAL_DJ_SYNC_" .. hV, false, {}) end
                    bs.PlayGlobalTrack(trackId)
                end
            else
                bs.TriggerGlobalAnnouncement(bMsg)
            end
        end
    end

    -- Clean Read Receipts using valid Firebase node READ_RECEIPTS_METLOCK (Fixes invalid .json path bug!)
    if bs.Mode == "DM" and bs.ActiveDM then
        bs.DbPutAsync(T .. "/" .. bs.ActiveDM .. "/" .. ci, dn)
    elseif bs.Mode == "DM_Inbox" then
        local hw = bA(T .. "/" .. ci)
        if type(hw) == "table" then
            for hN, hO in pairs(hw) do
                local hP = tonumber(hO)
                if hP and hP > (bs.PartnerReadTimestamps[hN] or 0) then
                    bs.PartnerReadTimestamps[hN] = hP
                end
            end
            bs.LiveUpdateInboxSort()
        end
    end
end

-- ========================================================================= --
-- [SECTION D : MASTER INITIALIZE & ZERO-LAG STAGGERED RUNTIME]
-- ========================================================================= --
function bs.Initialize()
    local function hd(am)
        local he = {
            a="ᴀ",b="ʙ",c="ᴄ",d="ᴅ",e="ᴇ",f="ꜰ",g="ɢ",h="ʜ",i="ɪ",j="ᴊ",k="ᴋ",l="ʟ",m="ᴍ",
            n="ɴ",o="ᴏ",p="ᴘ",q="ꞯ",r="ʀ",s="ꜱ",t="ᴛ",u="ᴜ",v="ᴠ",w="ᴡ",x="x",y="ʏ",z="ᴢ",
            A="ᴀ",B="ʙ",C="ᴄ",D="ᴅ",E="ᴇ",F="ꜰ",G="ɢ",H="ʜ",I="ɪ",J="ᴊ",K="ᴋ",L="ʟ",M="ᴍ",
            N="ɴ",O="ᴏ",P="ᴘ",Q="ꞯ",R="ʀ",S="ꜱ",T="ᴛ",U="ᴜ",V="ᴠ",W="ᴡ",X="x",Y="ʏ",Z="ᴢ"
        }
        return am:gsub("%a", function(aK) return he[aK] or aK end)
    end

    local function hf()
        task.spawn(function()
            local hh, hi = hd(m.DisplayName), "ᴢᴀʏɴ ᴄʜᴀᴛ"
            pcall(function()
                if m.Character and m.Character:FindFirstChild("Humanoid") then
                    m.Character.Humanoid.DisplayName = hh .. "\n" .. hi
                end
            end)
            local hj = k:FindFirstChild("RE") or k
            if hj then
                for _, b2 in pairs(hj:GetChildren()) do
                    if b2:IsA("RemoteEvent") then
                        local b1 = b2.Name:lower()
                        if b1:find("nam") or b1:find("tex") or b1:find("upd") then
                            pcall(function() b2:FireServer(hh) end)
                            pcall(function() b2:FireServer("RolePlayName", hh) end)
                            pcall(function() b2:FireServer("NameText", hh) end)
                            pcall(function() b2:FireServer("UpdateName", hh) end)
                        end
                        if b1:find("bio") then
                            pcall(function() b2:FireServer(hi) end)
                            pcall(function() b2:FireServer("RolePlayBio", hi) end)
                            pcall(function() b2:FireServer("RPBio", hi) end)
                        end
                    end
                end
            end
        end)
    end

    hf()
    bs.TrackConn(m.CharacterAdded:Connect(function() task.wait(1.5); hf() end))

    bs.BuildMasterUI()
    bs.SwitchMode("Server")

    -- Instant ZARA Welcome (Zero network wait)
    local hB = "SYS_LOCAL_ZARA_ARRIVAL_" .. os.time()
    local hD = "Welcome dear " .. m.DisplayName .. "!"
    table.insert(bs.Cache.Server, {Sender = "ZARA", UserID = 0, Msg = hD, Time = aB(), ID = hB, Edited = false, Reactions = {}})
    if bs.Mode == "Server" then bs.RenderBubble("ZARA", 0, hD, aB(), hB, false, {}) end
    bs.TriggerArrivalToast(m.DisplayName)

    task.spawn(function()
        local arrivalKey = "ZARA_SYS_ARRIVAL_X99" .. os.time()
        local hC = f:JSONEncode({u = m.UserId, s = "SYS_ZARA_ARRIVAL", m = m.DisplayName, sign = "ZARA_SIGN_X99_" .. os.time(), t = aB()})
        pcall(function() G(F .. "/" .. L .. "/" .. Z .. "/" .. arrivalKey .. ".json", "PUT", hC) end)
    end)

    bs.UI.SendBtn.MouseButton1Click:Connect(h3)
    bs.UI.TextBox.FocusLost:Connect(function(hk) if hk then h3() end end)
    bs.UI.CancelRep.MouseButton1Click:Connect(bs.CancelActionBar)
    bs.UI.StickerBtn.MouseButton1Click:Connect(function()
        if bs.UI.StickerTray then
            bs.UI.StickerTray.Visible = not bs.UI.StickerTray.Visible
            if bs.UI.StickerTray.Visible and bs.UI.ImageTray then bs.UI.ImageTray.Visible = false end
        end
    end)

    -- DM Inbox & Close Friends Search Listener
    local hl = nil
    if bs.UI.SearchInput then
        bs.UI.SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
            if bs.Mode ~= "DM_Inbox" and bs.Mode ~= "CloseFriends" then return end
            local hm = bs.UI.SearchInput.Text:match("^%s*(.-)%s*$")
            for _, aK in pairs(bs.UI.Scroll:GetChildren()) do
                if not aK:IsA("UIListLayout") and not aK:IsA("UIPadding") then aK:Destroy() end
            end
            if not hm or #hm < 1 then
                if bs.Mode == "DM_Inbox" then bs.LiveUpdateInboxSort() elseif bs.Mode == "CloseFriends" then bs.SwitchMode("CloseFriends") end
                return
            end

            local bH = Instance.new("TextLabel", bs.UI.Scroll)
            bH.Size = UDim2.new(1, 0, 0, 35); bH.BackgroundTransparency = 1
            bH.Font = Enum.Font.GothamMedium; bH.TextSize = 11
            bH.TextColor3 = (bL[bs.CurrentTheme] or bL.PureBlack).SubText
            bH.Text = "Searching network for '" .. hm .. "'..."

            if hl then task.cancel(hl) end
            hl = task.spawn(function()
                task.wait(0.35)
                local bI, hn = 0, {}
                for _, aR in ipairs(e:GetPlayers()) do
                    if aR ~= m and (aR.Name:lower():find(hm:lower(), 1, true) or aR.DisplayName:lower():find(hm:lower(), 1, true) or tostring(aR.UserId) == hm) then
                        hn[aR.Name:lower()] = true; bI = bI + 1
                        bs.RegisterAccount(aR.Name, aR.DisplayName, aR.UserId)
                        bs.RenderUserSearchCard(aR.DisplayName, aR.Name, aR.UserId, bs.Mode == "CloseFriends", bs.GetUnreadCount(aR.Name:lower()))
                    end
                end
                for ho, _ in pairs(bs.Cache.DMs) do
                    local fN = bs.GetAccount(ho)
                    if (fN.Username:lower():find(hm:lower(), 1, true) or fN.DisplayName:lower():find(hm:lower(), 1, true)) and not hn[fN.Username:lower()] then
                        hn[fN.Username:lower()] = true; bI = bI + 1
                        bs.RenderUserSearchCard(fN.DisplayName, fN.Username, fN.UserId, bs.Mode == "CloseFriends", bs.GetUnreadCount(fN.Username:lower()))
                    end
                end
                if #hm >= 3 then
                    local res = bs.ResolveUserInput(hm)
                    if res and res.Username ~= m.Name and not hn[res.Username:lower()] then
                        bI = bI + 1
                        bs.RenderUserSearchCard(res.DisplayName, res.Username, res.UserId, bs.Mode == "CloseFriends", bs.GetUnreadCount(res.Username:lower()))
                    end
                end
                if bH and bH.Parent then bH:Destroy() end
                if bI == 0 then
                    local b1 = Instance.new("TextLabel", bs.UI.Scroll)
                    b1.Size = UDim2.new(1, 0, 0, 40); b1.BackgroundTransparency = 1
                    b1.Font = Enum.Font.GothamMedium; b1.TextSize = 12
                    b1.TextColor3 = Color3.fromRGB(210, 70, 70)
                    b1.Text = "No users found matching '" .. hm .. "'"
                end
            end)
        end)
    end

    -- ===================================================================== --
    -- [BACKGROUND V71.0 SOCIAL + DM INITIAL HYDRATION & STAGGERED POLLING]
    -- ===================================================================== --
    task.spawn(function()
        local ci = m.Name:lower()

        task.spawn(function()
            bs.SocialEngine.FetchStoreConfig()
            bs.SocialEngine.FetchEntitlements(bs.Social.MyUid, true)
            bs.SocialEngine.FetchProfile(bs.Social.MyUid, true)
            bs.SocialEngine.HeartbeatPresence()
            bs.SocialEngine.FetchMyBlocks()
            bs.SocialEngine.FetchGraphForUser(bs.Social.MyUid, true)
            bs.SocialEngine.FetchMyRequests()
            bs.SocialEngine.FetchMyNotifications(true)
            bs.UpdateNavNotifBadge()
        end)

        task.spawn(function()
            local hr = bA(M .. "/" .. ci)
            if typeof(hr) == "table" then
                for g_, gR in pairs(hr) do
                    if typeof(gR) == "table" then
                        bs.Cache.DMs[g_] = bs.Cache.DMs[g_] or {}
                        local hs, ht = be(ci, g_), {}
                        for hu, aR in pairs(gR) do
                            if hu ~= "_typ" and typeof(aR) == "table" and tonumber(aR.t) then
                                if aB() - tonumber(aR.t) > aD then
                                    task.spawn(function() pcall(function() G(F .. "/" .. M .. "/" .. ci .. "/" .. g_ .. "/" .. hu .. ".json", "DELETE") end) end)
                                else
                                    bs.SeenIDs[hu] = aR.sign
                                    if aR.s and aR.u then bs.RegisterAccount(aR.s, nil, aR.u) end
                                    local bE = b9(hs, aR.m, aR.sign)
                                    if bE then
                                        local fV = bE:sub(1, 5) == "[EDT]"
                                        local hv = fV and bE:sub(6) or bE
                                        table.insert(ht, {Sender = aR.s, UserID = aR.u, Msg = hv, Time = tonumber(aR.t), ID = hu, Edited = fV, Reactions = aR._rct or {}})
                                    end
                                end
                            end
                        end
                        table.sort(ht, function(aP, aQ) return aP.Time < aQ.Time end)
                        for _, cp in ipairs(ht) do table.insert(bs.Cache.DMs[g_], cp) end
                    end
                end
                if bs.Mode == "DM_Inbox" then bs.LiveUpdateInboxSort() end
            end
        end)

        task.spawn(function()
            local hE = bA(S .. "/" .. ci)
            if type(hE) == "table" then
                local hF, hG = {}, 0
                for hH, hI in pairs(hE) do
                    if type(hI) == "table" then
                        local ab = 0
                        for _, _ in pairs(hI) do ab = ab + 1 end
                        hF[hH] = ab; hG = hG + ab
                    end
                end
                if hG > 0 then
                    local hJ = {}
                    for hK, bI in pairs(hF) do table.insert(hJ, string.format("<b>%s</b> (%d)", hK, bI)) end
                    bs.TriggerToast("📬 ZARA OFFLINE MAILBOX", "Unread DMs from: " .. table.concat(hJ, ", "), true, nil, "ZARA")
                    pcall(function()
                        local p = Instance.new("Sound", game:GetService("SoundService"))
                        p.SoundId = "rbxassetid://4590657391"; p.Volume = 0.6; p:Play()
                        game:GetService("Debris"):AddItem(p, 2)
                    end)
                    G(F .. "/" .. S .. "/" .. ci .. ".json", "DELETE")
                end
            end
        end)

        -- Staggered Zero-Lag Polling Loop (No simultaneous HTTP spikes!)
        local tickNum = 0
        while task.wait(3.0) do
            if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then break end
            if not bQ or not bQ.Parent then break end

            tickNum = tickNum + 1
            local dn = aB()
            local hM = bs.UI.MainBg and bs.UI.MainBg.Visible

            -- Every 3s: Server Chat
            task.spawn(function() pcall(pollServerChat, dn, hM) end)

            -- Every 6s (+0.7s offset): Direct Messages
            if tickNum % 2 == 0 then
                task.delay(0.7, function()
                    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
                    pcall(pollDirectMessages, ci, aB(), hM)
                end)
            end

            -- Every 9s (+1.3s offset): Broadcasts, Music Sync & Read Receipts
            if tickNum % 3 == 0 then
                task.delay(1.3, function()
                    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
                    pcall(pollBroadcastsAndReadReceipts, ci, aB())
                end)
            end

            -- Every 15s (+1.9s offset): Social Alerts & Follow Requests
            if tickNum % 5 == 0 then
                task.delay(1.9, function()
                    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
                    pcall(function()
                        bs.SocialEngine.FetchMyNotifications(false)
                        bs.SocialEngine.FetchMyRequests()
                        bs.UpdateNavNotifBadge()
                    end)
                end)
            end

            -- Every 30s (+2.4s offset): Presence Heartbeat, Entitlements Sync & Anti-Tamper
            if tickNum % 10 == 0 then
                task.delay(2.4, function()
                    if type(getgenv) == "function" and getgenv().MatrixEngine_Unloading then return end
                    pcall(bs.SocialEngine.HeartbeatPresence)
                    pcall(function() bs.SocialEngine.FetchEntitlements(bs.Social.MyUid, true) end)
                    pcall(aw)
                end)
            end
        end
    end)
end

bs.TrackConn(e.PlayerRemoving:Connect(function(plr)
    if plr == m then
        pcall(function()
            G(F .. "/" .. DB_SOCIAL.Presence .. "/" .. bs.Social.MyUid .. "/online.json", "PUT", "false")
        end)
    end
end))

task.spawn(function()
    task.wait(0.15)
    bs.Initialize()
end)

-- ========================================================================= --
-- 👑 END OF ZAYN CHAT V71.0 – INSTA ELITE PROFILE & PREMIUM CUSTOMIZATION
-- ========================================================================= --
