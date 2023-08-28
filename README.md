# ronux
Ronux is a state management libary for roblox.

## Installation
```lua
local Ronux = loadstring(game:HttpGet("https://raw.githubusercontent.com/cantemizyurek/zeo/main/main.lua"))()
```

## Usage
```lua
local Ronux = loadstring(game:HttpGet("https://raw.githubusercontent.com/cantemizyurek/zeo/main/main.lua"))()

local store = Ronux.new()
store.add_state("count", {
    value = 0,
})
store.add_updater_state("near_players", {
    value = {}
    update = function(self)
        self.value = game.Players:GetPlayers()
    end
    update_time = 1
    condition = function(self)
        return #self.value < 10
    end
})
```

## API
### store.add_state(name, options)
Adds a state to the store.
```lua
store.add_state("count", {
    value = 0,
})
```

### store.add_updater_state(name, options)
Adds a state to the store with an updater.
```lua
store.add_updater_state("near_players", {
    value = {}
    update = function(self)
        self.value = game.Players:GetPlayers()
    end
    update_time = 1
    condition = function(self)
        return #self.value < 10
    end
})
```

### store.get_state(name)
Returns the state with the given name.
```lua
store.get_state("count")
```

### store.set_state(name, value)
Sets the state with the given name.
```lua
store.set_state("count", 1)
```

### store.start_updaters()
Starts all updaters.
```lua
store.start_updaters()
```

