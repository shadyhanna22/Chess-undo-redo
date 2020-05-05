note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create gamestate.make_empty
			create error.make_empty
			create bored.make_filled (".",4, 4)
			create bored_move.make_filled (".",4, 4)
			create history.make
			create his.make_empty
			gamestate := "Game being Setup..."
		end

feature -- model attributes
	numOfPic, index, undone: INTEGER
	gameState: STRING
	error: STRING
	game_started, move,won, lost: BOOLEAN
feature -- Implementation
	bored: ARRAY2[STRING]
	bored_move: ARRAY2[STRING]
	history: LINKED_LIST[COMMANDS]
	his: ARRAY[COMMANDS]

feature -- model operations

	set_error (er: STRING) -- sets the error massage
		do
			error := er
		end
	set_state (m: STRING)
		do
			gamestate := m
		end
	gameST
		do
			game_started := True
		end

	inc
		do
			numofpic := numofpic + 1
		end

	dec
		do
			numofpic := numofpic - 1
		end

	gip
		do
			won := False
			lost := False
			gamestate := "Game In Progress..."
		end
	movef
		do
			move := false
		end

	zero_undone
		do
			undone := 0
		end

	is_valid (z: INTEGER) : BOOLEAN
		do
			if z >= 1 and z <= 4 then
				Result := True
			else
				Result := False
			end
		end

	not_blocked(r1: INTEGER ; c1: INTEGER ; r2: INTEGER ; c2: INTEGER) : BOOLEAN
		local
			dr,dc,rm,cm: INTEGER

		do
			Result:=True
			dr := r2-r1 -- -3
			dc := c2-c1 -- -2
			if bored.item (r1, c1) ~ "N" then
				if dr = -2 then
					Result := bored.item (r1-1, c1) ~ "." and bored.item (r1-2, c1) ~ "."
				elseif dr = 2 then
					Result := bored.item (r1+1, c1) ~ "." and bored.item (r1+2, c1) ~ "."
				elseif dc = -2 then
					if dr = 1 then
						Result := bored.item (r1+1, c1) ~ "." and bored.item (r1+1, c1-1) ~ "."
					elseif dr = -1 then
						Result := bored.item (r1-1, c1) ~ "." and bored.item (r1-1, c1-1) ~ "."
					end
				elseif dc = 2 then
					if dr = 1 then
						Result := bored.item (r1+1, c1) ~ "." and bored.item (r1+1, c1+1) ~ "."
					elseif dr = -1 then
						Result := bored.item (r1-1, c1) ~ "." and bored.item (r1-1, c1+1) ~ "."
					end
				end
			elseif (dr < -1 or dr > 1) and (dc < -1 or dc > 1) then
				from
					rm :=r2
					cm :=c2
				until
					rm = r1 and cm = c1
				loop
					if dr > 0 then
						rm := rm - 1
					else
						rm := rm + 1 -- 3
					end
					if dc > 0 then
						cm := cm - 1
					else
						cm := cm + 1 -- 2
					end
					if rm /= r1 and cm /= c1 then
						Result := Result and bored.item (rm, cm) ~ "."
--						check Result end
					end
				end
			end
		end

	cant_move : BOOLEAN

		do
			Result := True
			across 1 |..| 4 is i loop
				across 1 |..| 4 is j loop
					if bored.item (i, j) /~ "." then
						moves(i,j)
						move := False
						across 1 |..| 4 is i_l loop
							across 1 |..| 4 is j_l loop
								if bored.item (i_l, j_l) /~ "." and bored_move.item (i_l, j_l) ~ "+"  then
									Result := Result and False
								else
									Result := Result and True
								end
							end
						end
					end
				end
			end
		end

	moves(row: INTEGER ; col: INTEGER)
			-- Perform update to the model state.
		local
			chess: STRING
			q_x, q_xr,q_r, q_rr: INTEGER

		do
			bored_move.make_filled (".", 4, 4)
			chess := bored.item (row, col)
			move := True

			-- King move set
			if chess ~ "K" then
				bored_move.put ("K", row, col)
				if is_valid(row+1) then
					bored_move.put ("+", row+1, col)
					if is_valid(col+1) then
						bored_move.put ("+", row+1, col+1)
					end
					if is_valid(col-1) then
						bored_move.put ("+", row+1, col-1)
					end
				end

				if is_valid(row-1) then
					bored_move.put ("+", row-1, col)
					if is_valid(col+1) then
						bored_move.put ("+", row-1, col+1)
					end
					if is_valid(col-1) then
						bored_move.put ("+", row-1, col-1)
					end
				end

				if is_valid(col+1) then
					bored_move.put ("+", row, col+1)
				end

				if is_valid(col-1) then
					bored_move.put ("+", row, col-1)
				end

			-- Queen move set
			elseif chess ~ "Q" then
				bored_move.put ("Q", row, col)

				q_r := row+1
				q_rr := row-1
				q_x := col+1
				q_xr := col-1
				across 1 |..| 4 as m
				loop
					if is_valid (q_r) then
						bored_move.put ("+", q_r, col)
						if is_valid (q_x) then
							bored_move.put ("+", q_r, q_x)
						end
						if is_valid (q_xr) then
							bored_move.put ("+", q_r, q_xr)
						end
					end
					if is_valid (q_rr) then
						bored_move.put ("+",q_rr, col)
						if is_valid (q_x) then
							bored_move.put ("+", q_rr, q_x)
						end
						if is_valid (q_xr) then
							bored_move.put ("+", q_rr, q_xr)
						end
					end
					if is_valid (q_x) then
						bored_move.put ("+", row, q_x)
					end
					if is_valid (q_xr) then
						bored_move.put ("+",row, q_xr)
					end
					q_r := q_r + 1
					q_rr := q_rr - 1
					q_x := q_x + 1
					q_xr := q_xr - 1
				end

			elseif chess ~ "N" then
				bored_move.put ("N", row, col)
				-- one virtical move up
				if is_valid (row+1) then
					if is_valid (col+2) then
						bored_move.put ("+", row+1, col+2)
					end
					if is_valid (col-2) then
						bored_move.put ("+", row+1, col-2)
					end
				end
				-- one virtical move up
				if is_valid (row-1) then
					if is_valid (col+2) then
						bored_move.put ("+", row-1, col+2)
					end
					if is_valid (col-2) then
						bored_move.put ("+", row-1, col-2)
					end
				end
				-- two virtical move up
				if is_valid (row+2) then
					if is_valid (col+1) then
						bored_move.put ("+", row+2, col+1)
					end
					if is_valid (col-1) then
						bored_move.put ("+", row+2, col-1)
					end
				end
				-- two virtical move down
				if is_valid (row-2) then
					if is_valid (col+1) then
						bored_move.put ("+", row-2, col+1)
					end
					if is_valid (col-1) then
						bored_move.put ("+", row-2, col-1)
					end
				end
			elseif chess ~ "B" then
				bored_move.put ("B", row, col)
				q_r := row+1
				q_rr := row-1
				q_x := col+1
				q_xr := col-1
				across
					1 |..| 4 as m
				loop
					if is_valid (q_r) then
						if is_valid (q_x) then
							bored_move.put ("+", q_r, q_x)
						end
						if is_valid (q_xr) then
							bored_move.put ("+", q_r, q_xr)
						end
					end
					if is_valid (q_rr) then
						if is_valid (q_x) then
							bored_move.put ("+", q_rr, q_x)
						end
						if is_valid (q_xr) then
							bored_move.put ("+", q_rr, q_xr)
						end
					end
					q_r := q_r + 1
					q_rr := q_rr - 1
					q_x := q_x + 1
					q_xr := q_xr - 1
				end

			elseif chess ~ "R" then
				bored_move.put ("R", row, col)
				q_r := row+1
				q_rr := row-1
				q_x := col+1
				q_xr := col-1
				across
					1 |..| 4 as m
				loop
					if is_valid (q_r) then
							bored_move.put ("+", q_r, col)
					end
					if is_valid (q_rr) then
							bored_move.put ("+", q_rr, col)
					end
					if is_valid (q_x) then
							bored_move.put ("+", row, q_x)
					end
					if is_valid (q_xr) then
							bored_move.put ("+", row, q_xr)
					end
					q_r := q_r + 1
					q_rr := q_rr - 1
					q_x := q_x + 1
					q_xr := q_xr - 1
				end
			elseif chess ~ "P" then
				bored_move.put ("P", row, col)
				if is_valid (row-1) then
					if is_valid (col+1) then
						bored_move.put ("+", row-1, col+1)
					end
					if is_valid (col-1) then
						bored_move.put ("+", row-1, col-1)
					end
				end
			end
		end

	move_and_capture(r1: INTEGER ; c1: INTEGER ; r2: INTEGER ; c2: INTEGER)
			-- Perform update to the model state.
		local
			a: COM_MOVE_AND_CAPTURE
		do
			create a.make
			a.set_values (bored.item (r1, c1), r1, c1,bored.item (r2, c2), r2, c2)
			history.put_right (a)
			history.forth

			history.item.execute

--			moves(r1,c1)
--			move := False
--			if bored_move.item (r2, c2) ~ "+" then
--				if not_blocked (r1, c1, r2, c2) then
--					bored.put (bored.item (r1, c1), r2, c2)
--					bored.put (".", r1, c1)
--					numofpic := numofpic - 1
--				else
--					set_error ("Error: Block exists between "+"("+r1.out+", "+c1.out+") and ("+r2.out+", "+c2.out+")")
--				end
--			else
--				set_error ("Error: Invalid move of B from "+"("+r1.out+", "+c1.out+") to ("+r2.out+", "+c2.out+")")
--			end
			if cant_move then
				lost := True
			end
		end

	setup_chess(c: INTEGER ; row: INTEGER ; col: INTEGER)
			-- Perform update to the model state.
		local
			chess: ARRAY[STRING]
			a: COM_SETUP_CHESS
		do
			chess := <<"K","Q","N","B","R","P">>
			gamestate := "Game being Setup..."

			create a.make
			a.set_values (c, row, col)

			if history.is_empty then
				history.extend (a)
				history.start
			else
				history.put_right (a)
				history.forth
			end

			history.item.execute
		end

	start_game
			-- Perform update to the model state.
		local
			a: COM_START_GAME
		do
			create a.make
			if history.is_empty then
				history.extend (a)
				history.start
			else
				history.put_right (a)
				history.forth
			end
			history.item.execute
			if game_started and numofpic = 0 then
				lost := True
			end
		end

	not_start_game
			-- Perform update to the model state.
		do
			gamestate := "Game being Setup..."
			game_started := False
			won := False
			lost := False
		end

	reset
			-- Reset model state.
		do
			if game_started then
			gamestate := "Game being Setup..."
			bored.make_filled (".", 4, 4)
			numofpic := 0
			bored_move.make_filled (".", 4, 4)
			game_started := False
			won := False
			lost := False
			history.wipe_out
			zero_undone
			else
				error := "Error: Game not yet started"
			end

		end

	redo

		do
			if not history.is_empty and not history.after and history.index < history.count and undone > 0 then
				history.forth
				history.item.redo
				undone := undone - 1
			else
				error := "Error: Nothing to redo"
			end
		end

	undo

		do
			if game_started and numofpic = 0 then
				history.item.undo
				undone := undone + 1
			elseif not history.is_empty and numofpic > 0 then
				history.item.undo
				undone := undone + 1
			else
				error := "Error: Nothing to undo"
			end

			if not history.before then
				history.back
			end
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append("# of chess pieces on board: " + numofpic.out)
			Result.append ("%N")
			if game_started and numofpic = 1 then
				gamestate := "Game Over: You Win!"
				won:= True
			elseif game_started and lost then
				gamestate := "Game Over: You Lose!"
			end
			if error.is_empty then
				Result.append ("  "+gamestate)
			else
				Result.append ("  "+error)
			end

			Result.append ("%N")
			across 1 |..| 4 is l_i loop
				Result.append("  ")
				across 1 |..| 4 is l_j loop
					if move then
						if l_j >= 4 then
							Result.append (bored_move.item (l_i, l_j))
							Result.append("%N")
						else
							Result.append (bored_move.item (l_i, l_j))
						end
					else
						if l_j >= 4 then
							Result.append (bored.item (l_i, l_j))
							Result.append("%N")
						else
							Result.append (bored.item (l_i, l_j))
						end
					end
				end
			end
			error.wipe_out
			move := False
		end
end




