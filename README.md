# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({
  {
    "test",
    {
      "test 2",
      {
        "another test"
      }
    },
    {
      "test 3"
    }, 
    print
  }
}))
```
The output should be something like this:
```lua
local TABLE_DATA = {
  {
   "test",
   {
    "test 2",
    {
     "another test"
    }
   },
   {
    "test 3"
   },
   userdata: 0x90d6d8
  }
}
```
