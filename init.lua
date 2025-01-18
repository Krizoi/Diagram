--[[

	DIAGRAM: "Keys in tables age when new keys are added."
	AUTHOR: micymoos (@DragonsDogo)

	DESCRIPTION
	A simple module that manages a table, allowing you to add and retrieve values dynamically.

]]
local Diagram = {}
Diagram.__index = Diagram

-- Creates a new Diagram table with an internal structure.
function Diagram:Create()
	local Table = setmetatable({}, Diagram)  -- Set the metatable to Diagram for the table
	Table.Data = {}  -- Initialize an empty table to store data
	Table.Freezed = false  -- Table is not frozen initially
	Table.Count = 0  -- Set the initial count of keys in the table to 0
	return Table  -- Return the newly created table
end

-- Adds a new key-value pair to the table and increases the age of all existing keys.
function Diagram:Add(Table, Params)
	if Table.Freezed then return error("Table is read-only.") end
	Table.Count += 1  -- Increment the count of keys in the table
	for _, Data in Table.Data do
		Data.Age += 1  -- Increment the age of existing entries by 1
	end
	-- Add the new entry with the specified key and value, and initialize its age to 0
	Table.Data[Params.Key] = {
		Value = Params.Value,
		Age = 0
	}
end

-- Clears all data from the table and resets its state.
function Diagram:Clear(Table)
	if Table.Freezed then return error("Table is read-only.") end
	Table.Count = 0  -- Reset the count to 0
	Table.Freezed = nil  -- Unfreeze the table
	Table.Data = {}  -- Empty the data table
end 

-- Creates a shallow clone of the table.
function Diagram:Clone(Table)
	if Table.Freezed then return error("Table is read-only.") end
	local Clone = {}  -- Create an empty table for the clone
	for Key, Value in Table do
		Clone[Key] = Value  -- Copy each key-value pair into the clone
	end
	return Table  -- Return the original table (this should be the clone, not the original)
end

-- Concatenates the values of the table from Index to Value, using Separator between them.
function Diagram:Concatenate(Table, Separator, Index, Value)
	Separator = Separator or ""  -- Default separator is an empty string if not provided
	Index = Index or 1  -- Default start index is 1 if not provided
	Value = Value or #Table  -- Default end index is the last element of the table if not provided
	if Index > Value then return "" end  -- Return empty string if the start index is greater than the end index
	local Result = ""  -- Initialize the result string
	for Element = Index, Value do
		if Table[Element] and Table[Element].Value then
			if Element > Index then
				Result = Result .. Separator  -- Add separator if it's not the first element
			end
			Result = Result .. tostring(Table[Element].Value)  -- Append the value of the element to the result string
		end
	end
	return Result  -- Return the concatenated result
end

-- Searches for Needle in the Haystack starting from Initial index.
function Diagram:Find(Haystack, Needle, Initial)
	Initial = Initial or 0  -- Default starting index is 0 if not provided
	for Index = Initial, #Haystack do
		if Haystack[Index] == Needle then  -- If the element matches the Needle, return the index
			return Index
		end
	end
	return nil  -- Return nil if the Needle was not found
end

-- Freezes the table to prevent modifications (making it read-only).
function Diagram:Freeze(Table)
	Table.Freezed = true
	setmetatable(Table, {  -- Change the metatable to disallow modifications
		__newindex = function(_, Key, Value)
			error("Attempt to modify a read-only table.")  -- Throw an error if there's an attempt to modify the table
		end
	})	
end

-- Checks if the table is frozen.
function Diagram:Frozen(Table)
	if Table.Freezed == true then return true else return false end
end

-- Returns the maximum numeric key in the table.
function Diagram:Maximum(Table)
	local Maximum = 0  -- Initialize the maximum key value to 0
	for Key, _ in Table do
		Maximum = math.max(Maximum, Key)  -- Update the maximum value with the larger key
	end
	return Maximum  -- Return the maximum key found
end

-- Moves a range of elements from Source table to Destination table.
function Diagram:Move(Source, Indexes, Destination)
	Destination = Destination or Source  -- Default Destination is the Source if not provided
	for Index = Indexes.Start, Indexes.End do
		local Next = Index - Indexes.Start + 1  -- Calculate the next index in the Destination table
		Destination[Next] = Source[Index]  -- Move the element from Source to Destination
	end
	return Destination  -- Return the updated Destination table
end

-- Packs the given arguments into a table and tracks the number of arguments.
function Diagram:Pack(...)
	local Arguments = {}  -- Create an empty table to hold the arguments
	local Number = 0  -- Initialize the counter for the number of arguments
	for Index, Value in {...} do
		Arguments[Index] = Value  -- Store each argument in the Arguments table
		Number = Index  -- Update the number of arguments with the current index
	end
	Arguments.Number = Number  -- Store the total number of arguments
	return Arguments  -- Return the table of packed arguments
end

function Diagram:Remove(Table, Index)
	if Table.Freezed then return error("Table is read-only.") end
	if not Table.Data[Index] then return nil end  -- Check if the element exists in the table
	local Remove = Table.Data[Index]  -- Get the element to be removed
	-- Shift subsequent entries to the left
	for Entries = Index, Table.Count - 1 do
		Table.Data[Entries] = Table.Data[Entries + 1]
	end
	-- Set the last item to nil (optional cleanup)
	Table.Data[Table.Count] = nil
	-- Decrease the count after removal
	Table.Count = Table.Count - 1
end

-- Sorts the table based on the provided Comparison function.
function Diagram:Sort(Table, Comparison)
	if Table.Freezed then return error("Table is read-only.") end
	if not Comparison then
		Comparison = function(A,B)
			return A < B  -- Default comparison function sorts in ascending order
		end
	end	

	for Index = 1, #Table - 1 do
		for Value = Index + 1, #Table do
			-- Ensure the comparison function is valid by checking both directions
			if Comparison(Table[Index], Table[Value]) and Comparison(Table[Value], Table[Index]) then
				error("Invalid order function for sorting")  -- Throw error if comparison function is invalid
			end
		end
	end

	local Number = #Table
	for Index = 1, Number - 1 do
		for Value = 1, Number - Index do
			-- Perform a bubble sort based on the provided comparison function
			if Comparison(Table[Value], Table[Value + 1]) then
				Table[Value], Table[Value + 1] = Table[Value + 1], Table[Value]  -- Swap elements
			end
		end
	end
end

-- Unpacks elements from the List starting from Index and up to Length.
function Diagram:Unpack(List, Index, Length)
	Index = Index or 1  -- Default starting index is 1 if not provided
	Length = Length or #List  -- Default ending index is the length of the list
	if Index < 1 or Length > #List or Index > Length then
		error("Invalid indices.")  -- Throw error if the indices are invalid
	end
	local Values = {}  -- Initialize an empty table to hold the unpacked values
	for Element = Index, Length do
		Values[#Values + 1] = List[Element]  -- Add each element to the Values table
	end
	local Returnable = Values  -- Assign Values to Returnable (it should be returned, not used here)
	for Element = 1, #Values do
		return Values[Index]  -- Return the first element from the Values table (this seems to be incorrect)
	end
end

return Diagram  -- Return the Diagram module
