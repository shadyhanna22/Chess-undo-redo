note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)
    	do
			if row > 4 or row < 1 or col > 4 or col < 1 then
				model.set_error("Error: ("+row.out+", "+col.out+") not a valid slot")
			elseif model.bored.item (row, col) /~ "."  then
				model.set_error("Error: Slot @ ("+row.out+", "+col.out+") already occupied")
			elseif model.game_started then
				model.set_error("Error: Game already started")
			elseif model.won then
				model.set_error("Error: Game already over")
			else
				model.setup_chess(c,row,col)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
