module "Game", package.seeall
export ObjectMgr

Instance = nil

--- Singleton that centralizes all database operations.
--- Provides typed load/save methods for player flags, account mounts and companions.
class ObjectMgr
    new: =>

    --- Asynchronously loads character flags from the database.
    --- @param guid_low number The character GUID
    --- @param callback function Called with (flags: number)
    LoadPlayerFlags: (guid_low, callback) =>
        CharDBQueryAsync(string.format(Game.ObjectMgrConstant.QUERY.PLAYER_FLAGS.SELECT, guid_low), (results) ->
            flags = 0
            if results
                row = results\GetRow!
                flags = row.flags
            callback(flags) if callback
        )

    --- Persists character flags to the database (insert or update).
    --- @param guid_low number The character GUID
    --- @param flags number The flags bitmask to save
    SavePlayerFlags: (guid_low, flags) =>
        CharDBExecute(string.format(Game.ObjectMgrConstant.QUERY.PLAYER_FLAGS.INSERT, guid_low, flags, flags))

    --- Deletes character flags from the database.
    --- @param guid number The character GUID
    DeletePlayerFlags: (guid) =>
        CharDBExecute(string.format(Game.ObjectMgrConstant.QUERY.PLAYER_FLAGS.DELETE, guid))

    --- Asynchronously loads all mount spells for an account.
    --- @param account_id number The account ID
    --- @param callback function Called with (data: table<number, number>)
    LoadAccountMounts: (account_id, callback) =>
        CharDBQueryAsync(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_MOUNT.SELECT, account_id), (results) ->
            data = {}
            if results
                while true
                    spell_id = results\GetUInt32 0
                    data[spell_id] = Game.AccountDataState.OLD_DATA
                    break unless results\NextRow!
            callback(data) if callback
        )

    --- Inserts a mount spell for an account (ignores duplicates).
    --- @param account_id number The account ID
    --- @param spell_id number The mount spell ID
    SaveAccountMount: (account_id, spell_id) =>
        CharDBExecute(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_MOUNT.INSERT, account_id, spell_id))

    --- Asynchronously loads all companion spells for an account.
    --- @param account_id number The account ID
    --- @param callback function Called with (data: table<number, number>)
    LoadAccountCompanions: (account_id, callback) =>
        CharDBQueryAsync(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_COMPANION.SELECT, account_id), (results) ->
            data = {}
            if results
                while true
                    spell_id = results\GetUInt32 0
                    data[spell_id] = Game.AccountDataState.OLD_DATA
                    break unless results\NextRow!
            callback(data) if callback
        )

    --- Inserts a companion spell for an account (ignores duplicates).
    --- @param account_id number The account ID
    --- @param spell_id number The companion spell ID
    SaveAccountCompanion: (account_id, spell_id) =>
        CharDBExecute(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_COMPANION.INSERT, account_id, spell_id))

    --- Returns the singleton instance, creating it on first call.
    --- @return ObjectMgr
    @GetInstance: () ->
        if (not Instance)
            Instance = @!
        return Instance
