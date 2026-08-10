---@class dh.neoplug.output
---@field src string
---@field version? string

---@class dh.neoplug.entry
---@field src string
---@field version? string
---@field dependencies dh.neoplug.entry[]

---@alias dh.neoplug.input
---| string
---| { [1]: string, [2]?: string, version?: string, dependencies?: dh.neoplug.dependencies }
---| { src: string, [1]?: string, version?: string, dependencies?: dh.neoplug.dependencies }

---@alias dh.neoplug.dependencies
---| dh.neoplug.input
---| dh.neoplug.input[]

---@alias dh.neoplug.graph table<string, string[]>

---@class dh.neoplug
---@field graph dh.neoplug.graph
---@field plugins dh.neoplug.output[]
local neoplug = {
	graph = {},
	plugins = {},
}

---Normalise the input to a format used by neoplug
---@param plugin dh.neoplug.input
---@return dh.neoplug.entry|nil
local function normalise_field(plugin, plugin_list)
	if type(plugin) == "string" then
		plugin_list[plugin] = plugin_list[plugin] or { src = plugin, version = nil }
		return { src = plugin, version = nil, dependencies = {} }
	end
	if type(plugin) ~= "table" then
		error(("Invalid type given to neoplug:add : %s"):format(vim.inspect(plugin)))
	end

	---@type dh.neoplug.entry
	local output = {
		dependencies = {},
	}
	if plugin.src then
		output.src = plugin.src
		output.version = plugin.version or plugin[1]
	else
		output.src = plugin[1]
		output.version = plugin.version or plugin[2]
	end
	if not output.src then
		return nil
	end
	plugin_list[output.src] = plugin_list[output.src] or { src = output.src, version = output.version }
	-- Ensure fields with values overwrite if plugin is defined multiple times
	plugin_list[output.src].version = plugin_list[output.src].version or output.version

	if type(plugin.dependencies) == "string" then
		plugin_list[plugin.dependencies] = plugin_list[plugin.dependencies]
			or { src = plugin.dependencies, version = nil }
		output.dependencies = { { src = plugin.dependencies, dependencies = {} } }
		return output
	end
	for _, dep in ipairs(plugin.dependencies or {}) do
		vim.list_extend(output.dependencies, { normalise_field(dep, plugin_list) })
	end
	return output
end

--- Creates a flat list
--- [] = {
--- plug1 = { plug2, plug3 },
--- plug2 = {},
--- plug3 = { plug4 }
--- plug4 = {}
--- }
---@param list dh.neoplug.graph
---@param nplugin dh.neoplug.entry
local function generate_graph(list, nplugin)
	list[nplugin.src] = list[nplugin.src] or {}
	for _, dep in ipairs(nplugin.dependencies) do
		generate_graph(list, dep)
		vim.list_extend(list[dep.src], { nplugin.src })
	end
end

---Add a plugin to the final plugin list
---@param plugin dh.neoplug.input The path to to plugin to download
function neoplug:add(plugin)
	-- Get normalised plugin for future parsing
	local nplugin = normalise_field(plugin, self.plugins)
	if nplugin == nil then
		error(("Normalisation of plugin %s failed"):format(vim.inspect(plugin)))
	end

	-- Flatten into internal data for sorting algorithm
	generate_graph(self.graph, nplugin)
end

---Sort the set of plugins and dependencies to ensure all dependencies are loaded first
---@param plugin_graph dh.neoplug.graph
---@return table<string> sorted_order
local function topological_sort(plugin_graph)
	local in_degree = {}
	local queue = {}
	local sorted = {}

	-- Compute indegrees
	for plugin, nodes in pairs(plugin_graph) do
		in_degree[plugin] = in_degree[plugin] or 0
		for _, node in pairs(nodes) do
			in_degree[node] = in_degree[node] or 0
			in_degree[node] = in_degree[node] + 1
		end
	end

	-- Add all nodes with indegree 0 into the queue
	for name, degree in pairs(in_degree) do
		if degree == 0 then
			table.insert(queue, name)
		end
	end

	-- Kahn's algorithm (BFS)
	local head = 1
	while head <= #queue do
		local top = queue[head]
		head = head + 1

		table.insert(sorted, top)
		for _, dep in pairs(plugin_graph[top]) do
			in_degree[dep] = in_degree[dep] - 1
			if in_degree[dep] == 0 then
				table.insert(queue, dep)
			end
		end
	end
	if #sorted ~= vim.tbl_count(in_degree) then
		error("Dependency graph contains cycle: Unable to determine plugin order")
	end
	return sorted
end

---Submit the current plugin list to vim.pack, then clean the internal list for new add
function neoplug:submit()
	local sorted = topological_sort(self.graph)

	-- Gather the plugin data from sorted list
	local plugin_list = {}
	for _, plugin in ipairs(sorted) do
		table.insert(plugin_list, self.plugins[plugin])
	end

	vim.pack.add(plugin_list)
	self.graph = nil
	self.plugins = nil
end

return neoplug
