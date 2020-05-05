note
	description: "Summary description for {COMMANDS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMANDS

feature
	ch1,ch2: STRING
	chess: ARRAY[STRING]

feature {NONE}
	make
		local
		 	model_access: ETF_MODEL_ACCESS
		do
			model := model_access.m
			create ch1.make_empty
			create ch2.make_empty

			chess := <<"K","Q","N","B","R","P">>
		end

feature

	redo
		deferred
		end
	undo
		deferred
		end
	execute
		deferred
		end

feature -- Attributes
	-- may declare your own model state here
	model : ETF_MODEL
end
