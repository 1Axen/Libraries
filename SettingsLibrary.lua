local Settings = {}
local HttpService = game:GetService("HttpService")

function Settings.new(Name)
    Name = if Name then Name .. ".txt" else "save_file.txt"

    local Items = {}
    local Object = setmetatable({}, {
        __iter = function(self)
            return next, Items
        end,

        __index = function(self, key)
            return Items[key]
        end,

        __newindex = function(self, key, value)
            Items[key] = value 
        end
    })

    function Object.Add(Directory, Values)
        Items[Directory] = Values
    end

    function Object.Save()
        writefile(Name, HttpService:JSONEncode(Items))
    end

    function Object.Load()
        local Success, Content = pcall(function()
            readfile(Name)
        end)

        if Success then
            Items = HttpService:JSONDecode(Content)
        end

        return Success
    end

    return Object
end

return Settings
