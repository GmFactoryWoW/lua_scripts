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

    --- Maps all items with RequiredSkill 762 and organizes them into a single MountList.
    --- @return void
    MapMountItems: (callback) =>
        @MountList = {}

        WorldDBQueryAsync(Game.ObjectMgrConstant.QUERY.ITEM_TEMPLATE_MOUNT.SELECT, (results) ->
            if results
                while true
                    row = results\GetRow!
                    table.insert(@MountList, {
                        RequiredSkill: row.RequiredSkill,
                        RequiredSkillRank: row.RequiredSkillRank,
                        Spell: row.spellid_2
                    })
                    break unless results\NextRow!
            callback(@MountList) if callback
        )

    --- Returns the list of mounts with their required skill ranks.
    --- @return table A list of mounts with RequiredSkillRank and Spell ID.
    GetMountList: => @MountList

    --- Retrieves data sorted by a custom function.
    --- @param data table The data to sort.
    --- @param sorter function The sorting function to apply.
    --- @return table The sorted list.
    GetSorted: (data, sorter) =>
        sorted_list = {}
        for _, item in pairs(data)
            table.insert(sorted_list, item)
        table.sort(sorted_list, sorter)
        return sorted_list

    --- Loads all currencies for a given account.
    --- @param account_id number The account ID.
    --- @param callback function
    LoadAccountCurrencies: (account_id, callback) =>
        CharDBQueryAsync(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_CURRENCY.SELECT, account_id), (results) ->
            data = {}
            if results
                while true
                    row = results\GetRow!
                    currency = row.currency
                    count = row.count
                    data[currency] = count
                    break unless results\NextRow!
            callback(data) if callback
        )

    --- Saves a currency for a given account.
    --- @param account_id number The account ID.
    --- @param currency number The currency ID.
    --- @param count number The amount of the currency.
    SaveAccountCurrency: (account_id, currency, count) =>
        CharDBExecute(string.format(Game.ObjectMgrConstant.QUERY.ACCOUNT_CURRENCY.INSERT, account_id, currency, count, count))

    --- Retrieves all currency items from the database.
    --- @param callback function
    LoadCurrencyItems: (callback) =>
        @CurrencyList = {}
        WorldDBQueryAsync(Game.ObjectMgrConstant.QUERY.ITEM_TEMPLATE_CURRENCY.SELECT, (results) ->
            data = {}
            if results
                while true
                    row = results\GetRow!
                    entry = row.entry
                    @CurrencyList[entry] = true
                    break unless results\NextRow!
            callback(@CurrencyList) if callback
        )

    --- Returns the list of currency items.
    --- @return table A table where keys are currency item entries.
    GetCurrencyList: => @CurrencyList
