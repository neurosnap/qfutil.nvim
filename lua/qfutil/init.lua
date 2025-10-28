local M = {}

M.config = {}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function cqf_fmt(line)
	local path, rest = line:match("(%S+)%s*(.*)")
	if path then
		if #rest == 0 then
			rest = path
		end
		return string.format("%s:1:1:%s", path, rest)
	end
	return ""
end

---Attempts to convert a command that returns a list of filepaths into a quickfix.
---It assumes the filepaths are in the first column without spaces.
---@param args table { cmd: string, auto_jump: boolean, fmt: function? }
function M.cqf(args)
	local jump = args.auto_jump or false
	local cmd = args.cmd
	if cmd == nil then
		return
	end
	local efm = "%f:%l:%c:%m"
	local fmt = args.fmt or cqf_fmt

	local lines = vim.fn.systemlist(cmd)
	local fz = {}
	for _, line in ipairs(lines) do
		local ln = fmt(line)
		if #ln > 0 then
			table.insert(fz, ln)
		end
	end

	if #fz == 0 then
		vim.notify("no files found: " .. cmd)
		return
	end

	if jump then
		vim.cmd(string.format("edit %s", lines[1]))
	end

	vim.fn.setqflist({}, "r", {
		title = cmd,
		lines = fz,
		efm = efm,
	})
end

function M.toggle_qf()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			vim.cmd("cclose")
			return
		end
	end
	vim.cmd("copen")
end

return M
