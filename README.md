# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## Update Schedules
There really is no schedule I just update this whenever I'm bored while in school.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({
  TestTable = {};
  CoolFunctions = {
    print,
    ipairs,
    error
  }
})); 
```

The output should be something like this:
```lua
local DUMPED_TABLE = {
  ["TestTable"] = {},
  ["CoolFunctions"] = {
   print,		 -- userdata: 0x15d16b8
   ipairs,		 -- function: 0x15ca420
   error		 -- function: 0x15cab50
  }
}
```

Latest Update:
 - Added Empty Table Detection.
 - Added support for booleans properly.
 - Fixed Some Code Formatting
