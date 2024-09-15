# Delmo UI Library Documentation

Delmo UI Library is a powerful and flexible UI library for Roblox exploits. This documentation will guide you through the process of using the library to create beautiful and functional user interfaces.

## Getting Started

To begin using the Delmo UI Library, you need to load it into your script. Use the following code to do so:

```lua
local Delmo = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotACoderAi/Delmo-UiLibarary/main/Main.lua",true))()
```

## Creating a Window

The first step is to create a window for your UI. Use the `Init` function to do this:

```lua
local Window = Init({
    Title = "Your Window Title",
    Discord = "Your Discord Invite",
    Youtube = "Your YouTube Channel"
})
```

### Parameters:
- `Title`: The title of your window
- `Discord`: Your Discord server invite link
- `Youtube`: Your YouTube channel name or link

## Creating Tabs

Tabs help organize your UI into different sections. Create a tab using the `Window:Tab` function:

```lua
local Tab = Window:Tab({
    Title = "Tab Name"
})
```

### Parameters:
- `Title`: The name of your tab

## Adding Elements

### Button

Create a button using the `Tab:Button` function:

```lua
local Button = Tab:Button({
    Title = "Button Name",
    Callback = function()
        -- Your code here
    end
})
```

### Parameters:
- `Title`: The text displayed on the button
- `Callback`: The function to be executed when the button is clicked

### Toggle

Create a toggle switch using the `Tab:Toggle` function:

```lua
local Toggle = Tab:Toggle({
    Title = "Toggle Name",
    Callback = function(v)
        if v then
            -- Code when toggle is on
        else
            -- Code when toggle is off
        end
    end
})
```

### Parameters:
- `Title`: The text displayed next to the toggle
- `Callback`: The function to be executed when the toggle state changes. The function receives a boolean value (`v`) indicating the new state.

### Slider

Create a slider using the `Tab:Slider` function:

```lua
local Slider = Tab:Slider({
    Title = "Slider Name",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(v)
        -- Your code here
    end
})
```

### Parameters:
- `Title`: The text displayed above the slider
- `Min`: The minimum value of the slider
- `Max`: The maximum value of the slider
- `Default`: The initial value of the slider
- `Callback`: The function to be executed when the slider value changes. The function receives the new value (`v`).

### Dropdown

Create a dropdown menu using the `Tab:Dropdown` function:

```lua
local Dropdown = Tab:Dropdown({
    Title = "Dropdown Name",
    Selectmode = true
})

Dropdown:Add(1, "Option 1", function() end)
Dropdown:Add(2, "Option 2", function() end)
Dropdown:Add(3, "Option 3", function() end)
```

### Parameters:
- `Title`: The text displayed above the dropdown
- `Selectmode`: Set to `true` for multi-select, `false` for single-select

#### Adding Options:
Use the `Dropdown:Add` function to add options to the dropdown:

```lua
Dropdown:Add(id, "Option Name", function()
    -- Code to execute when this option is selected
end)
```

#### Getting Selected Items:
To get the currently selected items from a dropdown, use the `GetSelectedItems` function:

```lua
local selectedItems = Dropdown:GetSelectedItems()
```

## Notifications

The Delmo UI Library provides two types of notifications:

### Standard Notification

```lua
Notify:Notify({
    Title = "Notification Title",
    Desc = "Notification Description"
})
```

### Warning Notification

```lua
Notify:Warning({
    Title = "Warning Title",
    Desc = "Warning Description"
})
```

## Complete Example

Here's a complete example showcasing all the features:

```lua
local Delmo = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotACoderAi/Delmo-UiLibarary/main/Main.lua",true))()

local Window = Init({
    Title = "Tekkit Baseplate",
    Discord = "TEKKITHUB.GG",
    Youtube = "XXPROGAMERXX"
})

local Custom = Window:Tab({
    Title = "Custom"
})

local CButton = Custom:Button({
    Title = "Custom Button",
    Callback = function()
        Notify:Notify({
            Title = "Custom Notification",
            Desc = "This is a Custom Notification"
        })
    end
})

local CToggle = Custom:Toggle({
    Title = "Custom Toggle",
    Callback = function(v)
        if v then
            Notify:Notify({
                Title = "Custom Notification",
                Desc = "Toggle is ON"
            })
        else
            Notify:Warning({
                Title = "Custom Warning",
                Desc = "Toggle is OFF"
            })
        end
    end
})

local CSlider = Custom:Slider({
    Title = "Custom Slider",
    Min = 0,
    Max = 1000,
    Default = 500,
    Callback = function(v)
        print("Slider value:", v)
    end
})

local CDropdown = Custom:Dropdown({
    Title = "Custom Dropdown",
    Selectmode = true
})

CDropdown:Add(1, "Option 1", function() end)
CDropdown:Add(2, "Option 2", function() end)
CDropdown:Add(3, "Option 3", function() end)
CDropdown:Add(4, "Option 4", function() end)

local CButton2 = Custom:Button({
    Title = "Check Selected",
    Callback = function()
        local selected = CDropdown:GetSelectedItems()
        print("Selected Items:", selected)
        Notify:Notify({
            Title = "Selected Items",
            Desc = "Selected items are: " .. selected
        })
    end
})
```

This documentation covers the basic usage of the Delmo UI Library. Experiment with different combinations and settings to create the perfect UI for your needs!
