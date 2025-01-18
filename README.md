# Diagram
Diagram is a class that creates and handles tables with key-value pairs, allowing for efficient element management, index management, count tracking, and aging keys. It's especially useful when you need to maintain and manipulate structured data within your Roblox project.

The module focuses on index management for handling data, and most of its methods leverage this feature to ensure optimal performance and flexibility.

# Installation
1. Copy the source code for the module.
2. Paste it onto a module into studio.
   - Preferably, into ReplicatedStorage or ServerStorage.
3. Once done, require the module.
```lua
local Diagram = require([[DIAGRAM_PATH]])
```

# Usage
This is a demostration of the module. To either see the properties or functions retrospectively, check the documentation file.
## Creating a Diagram
```lua
-- Requiring the Diagram module.
local Diagram = require([[DIAGRAM_PATH]])

-- Create a new Diagram instance.
local myDiagram = Diagram:Create()
```
## All Functions Demostrated
```lua
-- Load the Diagram module
local Diagram = require([[DIAGRAM_PATH]])

-- Create a new Diagram table
local myDiagram = Diagram:Create()

-- Add some data to the table
Diagram:Add(myDiagram, {Key = 1, Value = "Apple"})
Diagram:Add(myDiagram, {Key = 2, Value = "Banana"})
Diagram:Add(myDiagram, {Key = 3, Value = "Cherry"})

-- Print the current state of the table (should have 3 items now)
print("Table Data:")
for key, data in pairs(myDiagram.Data) do
	print(key, data.Value, "Age:", data.Age)
end
print(myDiagram)
-- Concatenate the values in the table from index 1 to 3, separated by commas
local concatenated = Diagram:Concatenate(myDiagram, ", ", 1, 3)
print("Concatenated Values: " .. concatenated)  -- Output: Apple, Banana, Cherry

-- Remove an element (e.g., "Second" key) from the table and print the removed value
local removedValue = Diagram:Remove(myDiagram, 2)

-- Print the table again to check the changes
print("Table Data After Removal:")
for key, data in pairs(myDiagram.Data) do
	print(key, data.Value, "Age:", data.Age)
end

-- Clone the current state of the table
local clonedDiagram = Diagram:Clone(myDiagram)

-- Print the cloned table's data
print("Cloned Table Data:")
for key, data in pairs(clonedDiagram.Data) do
	print(key, data.Value, "Age:", data.Age)
end

-- Freeze the table so no modifications can be made
Diagram:Freeze(myDiagram)

-- Try to modify the frozen table (this will cause an error)
-- Uncomment the next line to see the freeze in action
-- Diagram:Add(myDiagram, {Key = "Fourth", Value = "Date"})  -- This will throw an error since the table is frozen

-- Check if the table is frozen
print("Is Table Frozen?", Diagram:Frozen(myDiagram))  -- Output: true

-- Find the index of a specific item in the table (e.g., "Cherry")
local foundIndex = Diagram:Find(myDiagram.Data, "Cherry", 1)
print("Found 'Cherry' at index:", foundIndex)  -- Output: index of "Cherry"

-- Pack some arguments into a table and print the result
local packedArgs = Diagram:Pack("Hello", 123, true)
print("Packed Arguments: ")
for key, value in pairs(packedArgs) do
	print(key, value)
end
```
