note
	description: "Summary description for {COM_SETUP_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COM_SETUP_CHESS

inherit
	COMMANDS

create
	make

feature

	r,c,m: INTEGER

feature -- constructor

	set_values(z: INTEGER; row: INTEGER; col: INTEGER)

		do
			m := z
			r := row
			c := col
		end

feature {NONE} -- Initialization

	redo

		do
			model.bored.put (chess[m], r, c)
			model.inc
			model.not_start_game
		end

	undo

		do
			model.bored.put (".", r, c)
			model.dec
			model.not_start_game
		end

	execute

		do
			model.bored.put(chess[m], r, c)
			model.inc
			model.zero_undone
		end
end
