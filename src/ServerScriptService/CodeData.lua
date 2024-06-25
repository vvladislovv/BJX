local module = {}

local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("CodeDataStore_BJ_1X")

--   {"IStats", "Honey", 1000},
--   {"Inventory", "ITEM_NAME", 1},
--   {"Boost", "BOOST_NAME", 1},

function module.Set(key, value)
    DataStore:SetAsync("codeData/"..key, value)
end

function module.Get(key)
    if DataStore:GetAsync("codeData/"..key) then
        return DataStore:GetAsync("codeData/"..key)
    end
end

function module.AddCode(key, uses, items)
    DataStore:SetAsync("codeData/"..key, uses)
    DataStore:SetAsync("codeData/codes/"..key, true)
    DataStore:SetAsync("codeData/codeItems/"..key, items)
    
    local codes = DataStore:GetAsync("codeData/allCodes") or {}
    table.insert(codes, key)
    DataStore:SetAsync("codeData/allCodes", codes)
end

function module.RemoveCode(key)
    DataStore:RemoveAsync("codeData/"..key)
    DataStore:RemoveAsync("codeData/codes/"..key)
    DataStore:RemoveAsync("codeData/codeItems/"..key)
    
    local allCodes = DataStore:GetAsync("codeData/allCodes")
    if(allCodes ~= nil) then
        for index, value in pairs(allCodes) do
            if(value == key) then
                table.remove(allCodes, index)
                DataStore:SetAsync("codeData/allCodes", allCodes)
            end
        end
    end
end

function module.IsValidCode(key)
    if DataStore:GetAsync("codeData/codes/"..key) ~= nil then
        --print("Код "..key.." существует ("..module.Get(key).." юзов осталось)")
        return true
    else
        --warn("Кода "..key.." не существует ("..module.Get(key).." юзов осталось)")
        return false
    end
end

return module