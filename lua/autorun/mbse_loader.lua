timer.Create("MBS_Loader", 1, 0, function()
    if ACE.Sounds then
        ACE.Sounds = ACE.Sounds or {}

        --Step 1: Build the main sound table here
        --Insert all the tables
        local TableTypes = {
            { Type = "Blasts",          Path = "explosions/ambient",            Category = { "tiny","small","medium","large","huge"},   Distance = { "close", "mid", "far"} },
            { Type = "Penetrations",    Path = "penetratingshots/penetrations", Category = { "large"},                                  Distance = { "close" }              },
            { Type = "Ricochets",       Path = "ricochets/props",               Category = { "small","medium","large"},                 Distance = { "close", "mid" }       },
            { Type = "Cracks",          Path = "fly/cracks",                    Category = { "small","medium","large"},                 Distance = { "close" }              },
            { Type = "Debris",          Path = "explosions/debris",             Category = { "low", "high"},                            Distance = { "close" }              }
        }

        for k, Data in pairs(TableTypes) do

            ACE.Sounds[Data["Type"]] = {}

            local Category  = Data["Category"]
            local Distance  = Data["Distance"]
            local Path      = Data["Path"]

            local Iteration = 0

            --Check for category
            while Iteration < #Category do

                local Iteration2 = 0

                Iteration = Iteration + 1
                if Iteration > 1000 then break end      --if the while becomes dumb
                --print("Iteration: "..Iteration)

                --Check for Distance
                while Iteration2 < #Distance do

                    Iteration2 = Iteration2 + 1
                    if Iteration2 > 1000 then break end         --if the while becomes dumb
                    --print("Iteration2: "..Iteration2)

                    -- Look for sounds in the designated path
                    local TxtToFind = "sound/mbs/acf_other/"..Path.."/"..Category[Iteration].."/"..Distance[Iteration2].."/*.mp3"   --print( "\n"..TxtToFind.."\n" )
                    local ExSounds = file.Find( TxtToFind, "GAME" )

                    --if table.IsEmpty(ExSounds) then print("No se encontro nada!") end

                    ACE.Sounds[Data["Type"]][Category[Iteration]] = ACE.Sounds[Data["Type"]][Category[Iteration]] or {}         

                    ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]] = ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]] or {}


                    for i,Sound in pairs(ExSounds) do

                        local Str = "mbs/acf_other/"..Path.."/"..Category[Iteration].."/"..Distance[Iteration2].."/"..Sound     --print('Loading sound: '..Str)
                
                        table.insert(ACE.Sounds[Data["Type"]][Category[Iteration]][Distance[Iteration2]], Str )

                    end
                end
            end
        end

        --[[
        --Debug tool to see if tables are being populated. Change values in tableToTest to see if there are sounds inside.
        timer.Simple(2, function()

            local tableToTest = ACE.Sounds["Penetrations"]["large"]["close"]
            local MaxCount = #tableToTest --print("Table total entries: "..#tableToTest)

            --print("Test if we have something in this sample table")
            --print(tableToTest[math.random(1, MaxCount)] )

        end)

        ]]--
        timer.Remove("MBS_Loader")
    end
end)