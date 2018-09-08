# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
DumpTable({hey_there = true, hello_world = 1})
```
The output should be something like this:
```lua
local TABLE_DATA = {
  hey_there = true,
  hello_world = 1
}
```
