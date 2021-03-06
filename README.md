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

Example game (view in Raw to see the right layout):

  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....
->setup_chess(N,2,1)
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->setup_chess(R,1,4)
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->setup_chess(P,2,4)
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->setup_chess(B,4,3)
  # of chess pieces on board: 4
  Game being Setup...
  ...R
  N..P
  ....
  ..B.
->undo
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->undo
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->undo
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->undo
  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....
->undo
  # of chess pieces on board: 0
  Error: Nothing to undo
  ....
  ....
  ....
  ....
->redo
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->redo
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->redo
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->redo
  # of chess pieces on board: 4
  Game being Setup...
  ...R
  N..P
  ....
  ..B.
->redo
  # of chess pieces on board: 4
  Error: Nothing to redo
  ...R
  N..P
  ....
  ..B.
->start_game
  # of chess pieces on board: 4
  Game In Progress...
  ...R
  N..P
  ....
  ..B.
->redo
  # of chess pieces on board: 4
  Error: Nothing to redo
  ...R
  N..P
  ....
  ..B.
->moves(4,3)
  # of chess pieces on board: 4
  Game In Progress...
  ....
  +...
  .+.+
  ..B.
->move_and_capture(4,3,2,1)
  # of chess pieces on board: 3
  Game In Progress...
  ...R
  B..P
  ....
  ....
->moves(1,4)
  # of chess pieces on board: 3
  Game In Progress...
  +++R
  ...+
  ...+
  ...+
->move_and_capture(1,4,2,4)
  # of chess pieces on board: 2
  Game In Progress...
  ....
  B..R
  ....
  ....
->moves(2,4)
  # of chess pieces on board: 2
  Game In Progress...
  ...+
  +++R
  ...+
  ...+
->move_and_capture(2,4,2,1)
  # of chess pieces on board: 1
  Game Over: You Win!
  ....
  R...
  ....
  ....
->undo
  # of chess pieces on board: 2
  Game In Progress...
  ....
  B..R
  ....
  ....
->undo
  # of chess pieces on board: 3
  Game In Progress...
  ...R
  B..P
  ....
  ....
->undo
  # of chess pieces on board: 4
  Game In Progress...
  ...R
  N..P
  ....
  ..B.
->undo
  # of chess pieces on board: 4
  Game being Setup...
  ...R
  N..P
  ....
  ..B.
->undo
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->undo
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->undo
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->undo
  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....
->undo
  # of chess pieces on board: 0
  Error: Nothing to undo
  ....
  ....
  ....
  ....
->redo
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->redo
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->redo
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->redo
  # of chess pieces on board: 4
  Game being Setup...
  ...R
  N..P
  ....
  ..B.
->redo
  # of chess pieces on board: 4
  Game In Progress...
  ...R
  N..P
  ....
  ..B.
->redo
  # of chess pieces on board: 3
  Game In Progress...
  ...R
  B..P
  ....
  ....
->redo
  # of chess pieces on board: 2
  Game In Progress...
  ....
  B..R
  ....
  ....
->redo
  # of chess pieces on board: 1
  Game Over: You Win!
  ....
  R...
  ....
  ....
->redo
  # of chess pieces on board: 1
  Error: Nothing to redo
  ....
  R...
  ....
  ....
->moves(2,1)
  # of chess pieces on board: 1
  Error: Game already over
  ....
  R...
  ....
  ....
->move_and_capture(2,1,3,3)
  # of chess pieces on board: 1
  Error: Game already over
  ....
  R...
  ....
  ....
->reset_game
  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....
->undo
  # of chess pieces on board: 0
  Error: Nothing to undo
  ....
  ....
  ....
  ....
->redo
  # of chess pieces on board: 0
  Error: Nothing to redo
  ....
  ....
  ....
  ....
->setup_chess(N,2,1)
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->setup_chess(R,1,4)
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->setup_chess(P,2,4)
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->setup_chess(B,4,3)
  # of chess pieces on board: 4
  Game being Setup...
  ...R
  N..P
  ....
  ..B.
->undo
  # of chess pieces on board: 3
  Game being Setup...
  ...R
  N..P
  ....
  ....
->undo
  # of chess pieces on board: 2
  Game being Setup...
  ...R
  N...
  ....
  ....
->undo
  # of chess pieces on board: 1
  Game being Setup...
  ....
  N...
  ....
  ....
->undo
  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....
->start_game
  # of chess pieces on board: 0
  Game Over: You Lose!
  ....
  ....
  ....
  ....
->redo
  # of chess pieces on board: 0
  Error: Nothing to redo
  ....
  ....
  ....
  ....
->undo
  # of chess pieces on board: 0
  Game being Setup...
  ....
  ....
  ....
  ....

