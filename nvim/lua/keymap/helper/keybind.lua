---@class dh.keymap.helper.keybind
local keybind = {}

---Normalises the optional key to the primary key, ensures only the primary key exists
---@param table table The node table
---@param primary_key string|number The primary key, this will exist if either primary or optional is defined
---@param optional_key? string|number The optional key, if this is defined then it will be removed after the operation. If this is not defined, the function does nothing
function keybind.normalise(table, primary_key, optional_key)
    table[primary_key] = table[primary_key] or table[optional_key]
    if optional_key then
        table[optional_key] = nil
    end
end

local function traverse_path(table, path)
    local t = table
    for _, subpath in pairs(path) do
        if not t[subpath] then -- Ensure field can be missing/commented out to disable
            t[subpath] = { disabled = true }
        end
        t = t[subpath]
    end
    return t
end
local function is_field(field)
    if type(field) == "table" then return false end
    if type(field) == "string" or type(field) == "number" then
        return true
    end
    assert("Invalid field type")
end
local function traverse(search_table, parse_table, path)
    path = path or {}
    for field_name, field in pairs(search_table) do
        if is_field(field) then
            local node = traverse_path(parse_table, path)
            keybind.normalise(node, search_table[1], search_table[2])
            break
        else
            local update_path = type(field_name) == "string"
            if update_path then table.insert(path, field_name) end
            traverse(field, parse_table, path)
            if update_path then table.remove(path) end
        end
    end
end
---Parses the table by normalising each node based on the parameters in the validation_table
---@param table table The table to be parsed
---@param validation_table table This should be an exact copy of structure of the table, each node should contain a primary key and an optional key for the final result
---@return table table Returns a reference to the updated table
function keybind.parse(table, validation_table)
    traverse(validation_table, table)
    return table
end

keybind.key = { { "keybind", 1 } }

return keybind
