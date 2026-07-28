---@class dh.keymap.lsp
---@function setup(config: keymap_config)
local lsp = {}

---@param config dh.keymap.config.lsp
local function navigation(config)
    if not config.next_error.disabled then
        vim.keymap.set('n', config.next_error.keybind,
            function() vim.diagnostic.jump { count = 1, float = true } end,
            { desc = "Jump to next error" })
    end
    if not config.prev_error.disabled then
        vim.keymap.set('n', config.prev_error.keybind,
            function() vim.diagnostic.jump { count = -1, float = true } end, { desc = "Jump to previous error" })
    end
    if not config.toggle_header.disabled then
        vim.keymap.set('n', config.toggle_header.keybind, function()
            local valid_filetypes = { 'c', "cpp", 'h', "hpp" }
            local found = false
            for _, filetype in ipairs(valid_filetypes) do
                if string.find(vim.bo.filetype, filetype, 1, true) then
                    found = true
                    break
                end
            end
            if not found then
                vim.notify("Cannot swap header-source files outside of C/C++", 4,
                    { title = "Invalid filetype for operation", })
                return
            end
            vim.cmd("LspClangdSwitchSourceHeader")
        end, { desc = "Swap between header and source file" })
    end

    if not config.goto_definition.disabled then
        vim.keymap.set('n', config.goto_definition.keybind, function() vim.lsp.buf.definition() end,
            { desc = "Go to definition" })
    end

    if not config.goto_declaration.disabled then
        vim.keymap.set('n', config.goto_declaration.keybind, function() vim.lsp.buf.declaration() end,
            { desc = "Go to declaration" })
    end

    if not config.goto_type_definition.disabled then
        vim.keymap.set('n', config.goto_type_definition.keybind, function() vim.lsp.buf.type_definition() end,
            { desc = "Go to type definition" })
    end

    if not config.goto_implementation.disabled then
        vim.keymap.set('n', config.goto_implementation.keybind, function() vim.lsp.buf.implementation() end,
            { desc = "Go to implementation" })
    end

    if not config.find_references.disabled then
        vim.keymap.set('n', config.find_references.keybind, function() vim.lsp.buf.references() end,
            { desc = "Find all references" })
    end
end

---@param config dh.keymap.config.lsp
local function actions(config)
    if not config.hover_info.disabled then
        vim.keymap.set('n', config.hover_info.keybind, function() vim.lsp.buf.hover() end,
            { desc = "Open window with information of hovered element" })
    end

    if not config.rename.disabled then
        vim.keymap.set('n', config.rename.keybind, function() vim.lsp.buf.rename() end,
            { desc = "Rename hovered element" })
    end

    if not config.code_action.disabled then
        vim.keymap.set('n', config.code_action.keybind, function() vim.lsp.buf.code_action() end,
            { desc = "Attempt to fix problem under hover" })
    end
end

---@param config dh.keymap.config
function lsp.setup(config)
    navigation(config.lsp)
    actions(config.lsp)
end

return lsp
