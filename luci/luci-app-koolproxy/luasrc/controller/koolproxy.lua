--[[
openwrt-dist-luci: ShadowSocks
]]--

module("luci.controller.koolproxy", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/koolproxy") then
		return
	end

	entry({"admin", "services", "koolproxy"}, cbi("koolproxy/global"), _("Koolproxy"), 1).dependent = true
	entry({"admin", "services", "koolproxy", "status"}, call("act_status")).leaf = true
end

function act_status()
	local result = { }
	result.koolproxy = luci.sys.call("pidof %s >/dev/null" % "koolproxy") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end
