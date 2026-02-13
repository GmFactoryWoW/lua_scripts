module "Game", package.seeall
export PlayerExtended

--- Extends the native Player with custom persistent data.
--- Aggregates Account and character flags, hydrated into Player via metatable injection.
class PlayerExtended
    --- Creates a new PlayerExtended instance and begins async loading.
    --- @param guid_low number The character's GUID (low part)
    --- @param account_id number The account ID
    --- @param callback function Called with (self) when loading is complete
    new: (guid_low, account_id, callback) =>
        @guid_low = guid_low
        @account_id = account_id
        @flags = 0
        @account = nil
        @Load callback

    --- Loads player flags from the database, then loads the associated Account.
    --- @param callback function Called with (self) when all data is ready
    Load: (callback) =>
        Game.ObjectMgr.GetInstance!\LoadPlayerFlags @guid_low, (flags) ->
            @flags = flags
            Game.Account @account_id, (account) ->
                @account = account
                callback(@) if callback

    --- Persists player flags and account data to the database.
    Save: =>
        Game.ObjectMgr.GetInstance!\SavePlayerFlags @guid_low, @flags
        @account\Save! if @account

    --- Checks whether a specific bitflag is set.
    --- @param byte number The flag bitmask to check
    --- @return boolean
    HasFlag: (byte) =>
        return bit.band(@flags, byte) != 0

    --- Adds a bitflag if not already set.
    --- @param byte number The flag bitmask to add
    --- @return self
    AddFlag: (byte) =>
        @flags += byte unless @HasFlag byte
        return @

    --- Removes a bitflag if currently set.
    --- @param byte number The flag bitmask to remove
    --- @return self
    RemoveFlag: (byte) =>
        @flags -= byte if @HasFlag byte
        return @

    --- Returns the associated Account instance.
    --- @return Account|nil
    GetAccount: =>
        return @account

-- Extend Player class with PlayerExtended methods
INTERNAL = { __init: true, Load: true, Save: true }
for name, method in pairs(Game.PlayerExtended.__base)
    continue if type(method) != "function" or INTERNAL[name]
    Player[name] = (...) =>
        ext = @GetData "PlayerExtended"
        return ext[name](ext, ...) if ext
