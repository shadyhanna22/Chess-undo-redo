note
	description: "Summary description for {COM_SETUP_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COM_START_GAME

inherit
	COMMANDS

create
	make

feature {NONE} -- Initialization

	redo
		do
			model.set_state ("Game In Progress...")
			model.gameST
		end

	undo

		do
			model.not_start_game
		end

	execute

		do
			model.set_state ("Game In Progress...")
			model.gameST
			model.zero_undone
		end
end
