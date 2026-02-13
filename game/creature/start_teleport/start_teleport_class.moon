module "Game", package.seeall
export StartTeleport

Instance = nil

--- Singleton that loads and manages race starting locations.
--- Provides filtered destination lists based on faction and shared spawn rules.
class StartTeleport
    --- Creates a new StartTeleport instance and begins async loading.
    new: =>
        @destinations = {}
        @load!

    --- Loads starting positions from the world database.
    load: =>
        WorldDBQueryAsync(Game.StartTeleportConstant.QUERY.SELECT,
            (result) ->
                while true
                    race = result\GetUInt32 0

                    @destinations[race] = {
                        map: result\GetUInt32 1
                        position_x: result\GetFloat 2
                        position_y: result\GetFloat 3
                        position_z: result\GetFloat 4
                        orientation: result\GetFloat 5
                    }

                    break unless result\NextRow!
        )

    --- Returns available destinations for a race, filtered by faction.
    --- Excludes the player's own race and shared spawn duplicates.
    --- @param race number The race ID
    --- @return table<number, table> Race ID to destination mapping
    GetAvailableDestinations: (race) =>
        faction_races = if Game.StartTeleportConstant.RACE.ALLIANCE[race]
            Game.StartTeleportConstant.RACE.ALLIANCE
        elseif Game.StartTeleportConstant.RACE.HORDE[race]
            Game.StartTeleportConstant.RACE.HORDE
        return {} unless faction_races

        temp = {}
        for id, data in pairs(@destinations)
            if faction_races[id] and id != race and not Game.StartTeleportConstant.SHARED_SPAWNS[id] and id != Game.StartTeleportConstant.SHARED_SPAWNS[race]
                temp[id] = data
        return temp

    --- Returns the destination for a specific race.
    --- @param race number The race ID
    --- @return table|nil { map, position_x, position_y, position_z, orientation }
    GetDestinationByRace: (race) =>
        return @destinations[race]

    --- Returns available destinations using a race ID as input.
    --- @param race number The race ID
    --- @return table<number, table>
    GetAvailableDestinationsByRace: (race) =>
        return @GetAvailableDestinations race

    --- Converts a race bitmask to a race ID, then returns available destinations.
    --- @param race_mask number The race bitmask (e.g. 4 for Dwarf)
    --- @return table<number, table>
    GetAvailableDestinationsByRaceMask: (race_mask) =>
        race = 1
        mask = race_mask
        while bit.band(mask, 1) == 0
            mask = bit.rshift(mask, 1)
            race += 1
        return @GetAvailableDestinations race

    --- Returns the singleton instance, creating it on first call.
    --- @return StartTeleport
    @GetInstance: () ->
        if (not Instance)
            Instance = @!
        return Instance