# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({
  print, 
  error,
  xpcall,
  tostring,
  {
    "Dumping Tables is cool",
    "Especially with",
    "Userdata caching"
  },
  {
    "Lua is also cool"
  }
}))
```
The output should be something like this:
```lua
local TABLE_DATA = {
  print,
  function: 0x17f8b70,
  function: 0x17f9160,
  function: 0x17f9040,
  {
   "Dumping Tables is cool",
   "Especially with",
   "Userdata caching"
  },
  {
   "Lua is also cool"
  }
}
```
