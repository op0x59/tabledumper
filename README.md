# TableDumper 2.0
Lua Module for Dumping Tables, back into a lua format.

## Update Schedules
There really is no schedule I just update this whenever I'm bored while in school.
This code is actually disgusting though, better than 1.0 though.

## Features
 - Global Cacher
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
local dumper = require("dumper");

print(dumper:DumpTable({
  debug.sethook,
  print,
  2,
  "Hello World"
}, 1)); 

-- 1 == DEBUG MODE
```

The output should be something like this:
```lua
{
    debug.sethook       -- function: 0x23b1e00,
    print               -- function: 0x23ab470,
    2                   -- 2,
    "Hello World"       -- Hello World
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
