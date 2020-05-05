# Chess-undo-redo
This is a chess terminal game with the option to undo and redo actions

system chess_solitaire_undotype CHESS = {K, -- KingQ, -- QueenN, -- KnightB, -- BishopR, -- RookP  -- Pawn}

setup_chess(c: CHESS; row: INTEGER; col: INTEGER)
-- Set up by adding a chess at (‘row‘, ‘col‘).

start_game
-- Start the game after setting up chess pieces.

reset_game
-- Start to setup a new game.

move_and_capture(r1: INTEGER; c1: INTEGER; r2: INTEGER; c2: INTEGER)
-- Move the chess at (‘r1‘, ‘c1‘), in a way that is valid,
-- and capture the chess at (‘r2‘, ‘c2‘).

moves(row: INTEGER; col: INTEGER)
-- Show all possible moves of the chess located at (‘row‘, ‘col‘),
-- including those that are not valid.

undo
-- undo the latest action
-- stops working if the game ended

redo
-- redo the latest undo
