# TableDumper
Lua Module for Dumping Tables, back into a lua format.

## How to Use
Import the DumpTable function into your lua script.

Call it like this:
```lua
print(DumpTable({hey_there = true, hello_world = 1}))
```
The output should be something like this:
```lua
local TABLE_DATA = {
  hey_there = true,
  hello_world = 1
}
```

## Examples
```lua
local test = {
    Strings = {
        "Hey there, I'm bill",
        "Hello World",
        "1 + 1 = 2"
    }, 
    Booleans = {
        Cool = true,
        GgNoRe = false
    }
}
print(DumpTable(test));
```

```lua
-- Output
local TABLE_DATA = {
  Booleans = {
   GgNoRe = false,
   Cool = true
  },
  Strings = {
   [1] = "Hey there, I'm bill",
   [2] = "Hello World",
   [3] = "1 + 1 = 2"
  }
}
```
