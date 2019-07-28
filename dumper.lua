local dumper = {};

function dumper:GetTabChar(count)
  local c = ''
  for i = 1, count do
    c = c .. '\t';
  end
  return c;
end

function dumper:CheckGlobal(pGlobal, tab, tString, count)
  if (tab == nil) then tab = _G; end;
  if (count == nil) then count = 0; end;
  if (tString == nil) then tString = ""; end;

  if (count ~= 2) then
    count = count + 1;
    local cache = {};
    for name, val in pairs(tab) do
      if (type(val) == "table") then
        cache[name] = val;
      end
      if (val == pGlobal) then
        tString = tString .. name;
        return tString;
      end
    end

    for name, val in pairs(cache) do
      local r = dumper:CheckGlobal(pGlobal, val, tString, count);
      if (r ~= false) then 
        tString = tString .. name .. "." .. r;
        return tString 
      end
    end
  end
  
  --[[
  function innerCheck(t)
    for name,val in pairs(t) do
      if (val == pGlobal) then
        return name;
      end
      if (type(val) == "table") then
        if (val ~= tab) then
          return innerCheck(val);
        end
      end
    end
  end
  --]]

  return false;
end

function dumper:SerializeName(name)
  if (type(name) == "string") then
    return "[\"" .. name .. "\"]";
  elseif (type(name) == "number") then
    return "[" .. name .. "]";
  end
end

function dumper:SerializeValue(name, value, index)
  if (type(value) == "string") then
    if (index == name) then
      return "\"" .. value .. "\"";
    else
      return dumper:SerializeName(name) .. " = " .. "\"" .. value .. "\"";
    end
  elseif (type(value) == "number") then
    if (index == name) then
      return tostring(value);
    else
      return dumper:SerializeName(name) .. " = " .. tostring(value);
    end
  elseif (type(value) == "boolean") then
    if (index == name) then
      return tostring(value);
    else
      return dumper:SerializeName(name) .. " = " .. tostring(value);
    end
  elseif (type(value) == "table") then
    if (index == name) then
      return tostring(value);
    else
      return dumper:SerializeName(name) .. " = " .. tostring(value);
    end
  elseif (type(value) == "userdata") then
    if (index == name) then
      if (not dumper:CheckGlobal(value)) then
        return "\"" .. tostring(value) .. "\"";
      else
        return dumper:CheckGlobal(value);
      end
    else
      if (not dumper:CheckGlobal(value)) then
        return dumper:SerializeName(name) .. " = " .. "\"" .. tostring(value) .. "\""
      else
        return dumper:SerializeName(name) .. " = " .. dumper:CheckGlobal(value);
      end
    end
  elseif (type(value) == "function") then
    if (index == name) then
      if (not dumper:CheckGlobal(value)) then
        return "\"" .. tostring(value) .. "\"";
      else
        return dumper:CheckGlobal(value);
      end
    else
      if (not dumper:CheckGlobal(value)) then
        return dumper:SerializeName(name) .. " = " .. "\"" .. tostring(value) .. "\"";
      else
        return dumper:SerializeName(name) .. " = " .. dumper:CheckGlobal(value);
      end
    end
  end

  print('unknown_value type: ' .. type(value))
  return "unknown_value";
end

function dumper:DumpTable(gTab, mode, recursive)
  if (gTab == nil) then gTab = {}; end;
  if (recursive == nil) then recursive = true; end;
  local deserialized = "";
  local gTabScanned = false;
  local tIndex = -1;

  if (mode == nil) then mode = 0; end;

  local function innerDump(tab, key)
    if (key == nil) then key = ""; end;
    tIndex = tIndex + 1;
    if (key ~= "") then
      deserialized = deserialized .. dumper:GetTabChar(tIndex) .. "[\"" .. key .. "\"] = {\n";
    else
      deserialized = deserialized .. dumper:GetTabChar(tIndex) .. "{\n";
    end
    local currIndex = 0;
    if (tab == gTab) then
      if (gTabScanned) then
        deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. "{...}\n";
      else
        gTabScanned = true;
      end
    end

    for name,val in pairs(tab) do
      currIndex = currIndex + 1;
      if (type(val) == "table") then
        if (recursive == true) then
          if (val ~= gTab) then
            innerDump(val, name);
          else
            deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. "{...}\n";
          end
        else
          deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. dumper:SerializeValue(name, val, currIndex) .. "\n";
        end
      else
        if (currIndex == #tab) then
          if (mode == 1) then
            deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. dumper:SerializeValue(name, val, currIndex) .. "\t\t-- " .. tostring(val) .. "\n";
          else
            deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. dumper:SerializeValue(name, val, currIndex) .. "\n";
          end
        else
          if (mode == 1) then
            deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. dumper:SerializeValue(name, val, currIndex) .. "\t\t-- " .. tostring(val) .. ",\n";
          else
            deserialized = deserialized .. dumper:GetTabChar(tIndex+1) .. dumper:SerializeValue(name, val, currIndex) .. ",\n";
          end
        end
      end
    end

    deserialized = deserialized .. dumper:GetTabChar(tIndex) .. "}\n"
    tIndex = tIndex - 1;
  end

  innerDump(gTab);

  return deserialized;
end

return dumper;
