description = [[
This script runs multiple other Nmap scripts in sequence to gather various information
about the target. It acts as a wrapper to simplify the execution of multiple scripts.
]]

---
-- @usage
-- nmap --script=multi-script-wrapper <target>
--
-- @output
-- Output from the individual scripts will be aggregated and displayed.
--

author = "Benjamin Akhras"

license = "Same as Nmap--See https://nmap.org/book/man-legal.html"

categories = {"discovery", "safe"}

-- Importing required libraries
local nmap = require "nmap"
local stdnse = require "stdnse"
local shortport = require "shortport"

-- Define the list of scripts to be run
local scripts_to_run = {
  "ftp-anon",
  "smtp-open-relay",
  "ldap-rootdse",
  "dns-zone-transfer"
}

prerule = function()
	return true
end

-- Define the action function
action = function(host, port)
  local results = {}
  
  for _, script_name in ipairs(scripts_to_run) do
    stdnse.print_debug(1, "Running script: %s", script_name)
    local status, script_output = nmap.run_script(script_name, host, port)
    if status then
      table.insert(results, script_output)
    else
      table.insert(results, "Script " .. script_name .. " failed to run.")
    end
  end

  return stdnse.format_output(true, table.concat(results, "\n\n"))
end

