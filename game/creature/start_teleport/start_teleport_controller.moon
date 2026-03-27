--- Handles the starting zone teleport system.
--- Players interact with an NPC to choose their starting location among
--- available faction races, excluding their own and shared spawn duplicates.

Controller = {
    Addon: {
        Prefix: "PlayerChoice"
        Functions: {
            [1]: "PlayerChoice_OnReceiveTeleportChoice"
        }
    }
}

--- Processes a teleport choice received from the client addon.
--- Validates the player hasn't already teleported, the chosen race is valid,
--- and performs the teleport.
--- @param player Player The player making the choice
--- @param args_table table Addon arguments, args_table[1] = chosen race ID
export PlayerChoice_OnReceiveTeleportChoice
PlayerChoice_OnReceiveTeleportChoice = (player, args_table) ->
    return false if player\HasFlag Game.PlayerFlags.TELEPORT_USED
    return false unless args_table and args_table[1]

    player_level = player\GetLevel!
    return false if (player_level > 1)

    chosen_race = args_table[1]

    if player\IsAlliance!
        return false unless Game.StartTeleportConstant.RACE.ALLIANCE[chosen_race]
    else
        return false unless Game.StartTeleportConstant.RACE.HORDE[chosen_race]

    return false if chosen_race == player\GetRace!

    destination = Game.StartTeleport.GetInstance!\GetDestinationByRace chosen_race
    return false unless destination

    player\AddFlag Game.PlayerFlags.TELEPORT_USED
    player\Teleport destination.map, destination.position_x, destination.position_y, destination.position_z, destination.orientation
RegisterClientRequests Controller.Addon

--- Builds and sends the addon message with available teleport locations.
--- @param player Player The player to send the message to
--- @param available_locations table<number, table> Race ID to destination mapping
Controller.BuildAddonMessage = (player, available_locations) ->
    data = { cards: {} }
    button_available = not player\HasFlag Game.PlayerFlags.TELEPORT_USED

    for race_id, _ in pairs(available_locations)
        data.cards[#data.cards + 1] = {
            is_available: button_available
            race: race_id
        }

    player\SendServerResponse Controller.Addon.Prefix, 1, data

--- Handles gossip hello event on the teleport NPC.
--- Fetches available destinations and sends the UI data to the player.
--- @param event number Creature gossip event ID (1 = GOSSIP_EVENT_ON_HELLO)
--- @param player Player The player interacting with the NPC
--- @param object Creature The NPC being interacted with
Controller.OnPlayerGossipHello = (event, player, object) ->
    available_locations = Game.StartTeleport.GetInstance!\GetAvailableDestinationsByRaceMask player\GetRaceMask!
    if next(available_locations) == nil
        player\SendNotification "Erreur interne! Merci de contacter un administrateur."
    else
    
    player_level = player\GetLevel!
    if (player_level > 1)
        player\SendNotification "Vous avez déjà dépassé le niveau 1, vous ne pouvez plus choisir votre lieu de départ."
    else
        Controller.BuildAddonMessage player, available_locations

    player\GossipComplete!
RegisterCreatureGossipEvent Game.StartTeleportConstant.NPC_ENTRY.ALLIANCE, 1, Controller.OnPlayerGossipHello
RegisterCreatureGossipEvent Game.StartTeleportConstant.NPC_ENTRY.HORDE, 1, Controller.OnPlayerGossipHello
