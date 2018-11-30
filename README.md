# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## Update Schedules
There really is no schedule I just update this whenever I'm bored while in school.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({
  print,
  error,
  ipairs,
  {
    pairs,
    "hey there",
    "pretty accurate",
    "right?"
  }
}))
```
The output should be something like this:
```lua
local TABLE_DATA = {
  print,		 -- userdata: 0x1088698
  error,		 -- function: 0x1081b30
  ipairs,		 -- function: 0x1081400
  {
   pairs,		 -- function: 0x10814a0
   "hey there",
   "pretty accurate",
   "right?"
  }
}
```
