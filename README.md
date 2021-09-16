# Rewrote in two days because I was bored in school.
## How to use
```lua
local TableDumper = require('td')
print(TableDumper.new({
	math,
	math.pi,
	math.huge,
	print,
	debug.getinfo,
	{
		io,
		4,
		hello = string.find,
		['hello, world'] = string.gsub,
		[{}] = 1
	}
}):toString())
```
you receive the output:
```lua
{
    [1] = math,
    [2] = math.pi,
    [3] = math.huge,
    [4] = print,
    [5] = preload.loaded.debug.getinfo,
    [6] = {
        [1] = io,
        [2] = 4,
        hello = string.find,
        ["hello, world"] = string.gsub,
        [{}] = 1
    }
}
```

## Things I fixed or added
- Improved namespace finder for global values
- Improved recursive output (will eventually add namespace formatting for recursive values)
- Improved formatting for output
- Switched to class viability so you can have multiple table dumpers running at the same time.
