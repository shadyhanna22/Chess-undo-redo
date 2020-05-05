note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
    	do
			-- perform some update on the model state
			if model.game_started then
				model.set_error("Error: Game already started")
			elseif model.won or model.lost then
				model.set_error("Error: Game already over")
			else
				model.start_game
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
