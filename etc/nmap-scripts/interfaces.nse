local nmap = require "nmap"
local stdnse = require "stdnse"
local target = require "target"

description = [[
   Retrieves the CIDR of the first network interface.
]]

author = "Benjamin Akhras"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery", "safe"}

prerule = function()
  if not nmap.is_privileged() then
    nmap.registry[SCRIPT_NAME] = nmap.registry[SCRIPT_NAME] or {}
    if not nmap.registry[SCRIPT_NAME].rootfail then
      stdnse.verbose1("not running for lack of privileges.")
    end
    nmap.registry[SCRIPT_NAME].rootfail = true
    return nil
  end

  if nmap.address_family() ~= 'inet' then
    stdnse.debug1("is IPv4 compatible only.")
    return false
  end
  
  return true
end


action = function()
  stdnse.print_debug(1, "Starting CIDR detection for the first valid network interface.")

  local interfaces = nmap.list_interfaces()
  if #interfaces < 1 then
    stdnse.print_debug(1, "No interfaces found")
    return "No interfaces found"
  end

  local selected_interface = nil
  for _, interface in ipairs(interfaces) do
    local address = interface.address
    if address and address ~= "127.0.0.1" and address ~= "::1" then
      selected_interface = interface
      break
    end
  end

  if not selected_interface then
    stdnse.print_debug(1, "No valid interface found")
    return "No valid interface found"
  end

  local address = selected_interface.address
  local netmask = selected_interface.netmask

  if not address or not netmask then
    stdnse.print_debug(1, "Could not determine address or netmask")
    return "Could not determine address or netmask"
  end
  
  local cidr    = address .. "/" .. netmask

  stdnse.print_debug(1, "Selected interface address: %s", cidr)

  return "Address: " .. cidr
end
