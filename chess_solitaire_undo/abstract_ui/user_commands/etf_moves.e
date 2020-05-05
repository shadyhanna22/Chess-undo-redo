note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state
			if not model.game_started then
				model.set_error("Error: Game not yet started")
			elseif model.won or model.lost then
				model.set_error("Error: Game already over")
			elseif not model.is_valid(row) or not model.is_valid(col) then
				model.set_error("Error: ("+row.out+", "+col.out+") not a valid slot")
			elseif model.bored.item (row, col) ~ "." then
				model.set_error("Error: Slot @ ("+row.out+", "+col.out+") not occupied")
			else
				model.moves(row, col)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
