# Rewrote in 1 day cause I was bored.
## How to use
```lua
local dumper = require"dumper"
local tdumper = dumper:new()
local a = {
    
}
a.b = a
a.c = {}
a.c.b = a
print(tdumper:dump(a))
```
you receive the output:
```lua
{
    c = {        
        b = {<recursive>};    
    };        
    b = {<recursive>};        
};
```

## Things I fixed
- Recursive table dumping.
