local textStream = require"textstream"
local dumper = {}

function dumper:new()
    local iDump = {}
    iDump.stream = textStream:new()
    iDump.tabIndex = 1
    iDump.rowIndex = 1
    iDump.loggedTables = {}
    iDump.stream.accountForText = false

    local function hasWhitespace(v)
        for i = 1, #v do
            local c = v:sub(i, i)
            if c == ' ' then return true end
        end 
        return false
    end

    local function resolveExpression(key, isKey)
        if type(key) == 'string' then
            if isKey then
                if hasWhitespace(key) then
                    return '["' .. key .. '"]'
                else
                    return key
                end
            end
        end
        return tostring(key)
    end

    function iDump:outKeyValue(k, v)
        for i = 1, iDump.tabIndex do
            iDump.stream:addToRow(iDump.rowIndex, i, '')
        end
        if k == nil then 
            iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex+1, resolveExpression(v) .. ';')
        else 
            iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex+1, resolveExpression(k, true) .. ' = ' .. resolveExpression(v) .. ';')
        end

        iDump.rowIndex = iDump.rowIndex + 1
    end

    function iDump:isLoggedTable(t)
        for k,v in pairs(iDump.loggedTables) do
            if v == t then
                return true
            end
        end
        return false
    end

    function iDump:dump(t, open)
        if iDump:isLoggedTable(t) then
            iDump:outKeyValue(nil, '{<recursive>};')
            return iDump.stream:toString()
        else
            iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex, '{')
            iDump.rowIndex = iDump.rowIndex + 1
            table.insert(iDump.loggedTables, t)
        end
        
        for k,v in pairs(t) do
            if type(v) == 'table' then
                if k == nil then 
                    iDump.tabIndex = iDump.tabIndex + 1
                    if not iDump:isLoggedTable(v) then
                        iDump:dump(v)
                    else
                        iDump:outKeyValue(nil, '{<recursive>};')
                    end
                    iDump.tabIndex = iDump.tabIndex - 1
                else
                    iDump.tabIndex = iDump.tabIndex + 1
                    if not iDump:isLoggedTable(v) then
                        iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex, resolveExpression(k, true) .. ' = {')
                        iDump:dump(v, true)
                    else
                        iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex, resolveExpression(k, true) .. ' = {<recursive>};')
                    end
                    iDump.tabIndex = iDump.tabIndex - 1
                end
            else
                iDump:outKeyValue(k, v)
            end
        end
        iDump.rowIndex = iDump.rowIndex + 1
        iDump.stream:addToRow(iDump.rowIndex, iDump.tabIndex, '};')
        iDump.rowIndex = iDump.rowIndex + 1
        return iDump.stream:toString()
    end

    return iDump
end

return dumper
