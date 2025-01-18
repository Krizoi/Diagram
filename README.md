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
local MyTable = Diagram:Create()
```
## Adding and Checking Age
```lua
-- Requiring the Diagram module.
local Diagram = require([[DIAGRAM_PATH]])

-- Create a new Diagram instance.
local MyTable = Diagram:Create()

-- Add some data to the table
Diagram:Add(MyTable, {Key = 1, Value = "Apple"})

print("Table Data:")
for key, data in pairs(myDiagram.Data) do
	print(key, data.Value, "Age:", data.Age)
end

-- Output: "1 Apple Age: 0"
-- Add more data to the table and see the age increase.
```
