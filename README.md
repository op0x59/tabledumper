# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## Update Schedules
There really is no schedule I just update this whenever I'm bored while in school.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({
  vanilla_funcs = {
    print, error,
    pairs, ipairs
  },
  custom_funcs = {
    add = function(x,y) return x + y end,
    sub = function(x,y) return x - y end,
    mul = function(x,y) return x * y end,
    div = function(x,y) return x / y end
  }
}));
```
The output should be something like this:
```lua
local TABLE_DATA = {
  ["vanilla_funcs"] = {
   print,		 -- userdata: 0x221f698
   error,		 -- function: 0x2218b30
   pairs,		 -- function: 0x22184a0
   ipairs		 -- function: 0x2218400
  },
  ["custom_funcs"] = {
   ["sub"] = "function: 0x2223250",
   ["mul"] = "function: 0x2223280",
   ["div"] = "function: 0x22232b0",
   ["add"] = "function: 0x2223220",
  }
}
```
