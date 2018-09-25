-- No Protect Autorollback hack Nigel Garnett 2018
-- rolls back the last 24 hours work of any player who
-- leaves the server without any protected areas

local area_count=function(name)
	local admin=minetest.check_player_privs(name, areas.adminPrivs)
	local areacount=0
	for id, area in pairs(areas.areas) do
		if admin or areas:isAreaOwner(id, name) then
			areacount=areacount+1
		end
	end
	return areacount
end


minetest.register_on_leaveplayer(function(player)
    local name=player:get_player_name()
    if not (area_count(name)>0) then
        minetest.chat_send_all(name.." was rolled back.")
        minetest.log(name.." was rolled back.")
        minetest.rollback_revert_actions_by("player:"..name,43200)
    end
end)
