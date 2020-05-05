note
	description: "Summary description for {COM_SETUP_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COM_MOVE_AND_CAPTURE

inherit
	COMMANDS

create
	make

feature
	r1,c1,r2,c2: INTEGER


feature -- constructor

	set_values(P1: STRING; row1: INTEGER; col1: INTEGER; P2: STRING; row2: INTEGER; col2: INTEGER)

		do
			ch1 := p1
			ch2 := p2
			r1 := row1
			c1 := col1
			r2 := row2
			c2 := col2
		end

feature {NONE} -- Initialization

	redo

		do
			model.bored.put (".", r1, c1)
			model.bored.put (ch1, r2, c2)
			model.dec
		end

	undo

		do
			model.bored.put (ch1, r1, c1)
			model.bored.put (ch2, r2, c2)
			model.inc
			model.gip
		end

	execute

		do
			model.moves(r1,c1)
			model.movef
			if model.bored_move.item (r2, c2) ~ "+" then
				if model.not_blocked (r1, c1, r2, c2) then
					model.bored.put (model.bored.item (r1, c1), r2, c2)
					model.bored.put (".", r1, c1)
					model.dec
					model.zero_undone
				else
					model.set_error ("Error: Block exists between "+"("+r1.out+", "+c1.out+") and ("+r2.out+", "+c2.out+")")
				end
			else
				model.set_error ("Error: Invalid move of B from "+"("+r1.out+", "+c1.out+") to ("+r2.out+", "+c2.out+")")
			end
		end
end
