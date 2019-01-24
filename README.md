# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## Update Schedules
There really is no schedule I just update this whenever I'm bored while in school.

## Features
 - Userdata & Function Caching
 - Table Formatting
 - Smart Dumping
 
## Things I cant Add
 - Original Formatting (Lua Retains no formatting information)
 - Table Order (Lua Retains no information on the order except indexes)
 - Dumping of Original Lua Code (The Closest I can get is to make it check if there is a built-in decompiler to your environment)

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


## Latest Update
 - Added Empty Table Detection.
 - Added support for booleans properly.
 - Fixed Some Code Formatting
 
## Supported Types
 - Strings
 - Numbers
 - Booleans
 - Tables
 - Userdata (Barely has support)
 - Functions (Barely has support)
