module "Game", package.seeall
export Account

--- Manages account-wide data: mounts and companions.
--- Loaded asynchronously via ObjectMgr, persists only new entries on save.
class Account
    --- Creates a new Account instance and begins async loading.
    --- @param account_id number The account ID
    --- @param callback function Called with (self) when loading is complete
    new: (account_id, callback) =>
        @account_id = account_id
        @mount = {}
        @companion = {}
        @currencies = {}
        @Load callback

    --- Loads mounts and companions in parallel from the database.
    --- @param callback function Called with (self) when both collections are loaded
    Load: (callback) =>
        object_mgr = Game.ObjectMgr.GetInstance!
        loaded = 0
        onLoaded = ->
            loaded += 1
            callback(@) if loaded == 3 and callback

        object_mgr\LoadAccountMounts @account_id, (mounts) ->
            @mount = mounts
            onLoaded!

        object_mgr\LoadAccountCompanions @account_id, (companions) ->
            @companion = companions
            onLoaded!

        object_mgr\LoadAccountCurrencies @account_id, (currencies) ->
            @currencies = currencies
            onLoaded!

    --- Adds a mount spell to the account if not already known.
    --- @param spell_id number The mount spell ID
    --- @return self
    AddMount: (spell_id) =>
        unless @mount[spell_id]
            @mount[spell_id] = Game.AccountDataState.NEW_DATA
        return @

    --- Removes a mount spell from the account.
    --- @param spell_id number The mount spell ID
    --- @return self
    RemoveMount: (spell_id) =>
        @mount[spell_id] = nil if @mount[spell_id]
        return @

    --- Checks whether the account has a specific mount.
    --- @param spell_id number The mount spell ID
    --- @return boolean
    HasMount: (spell_id) =>
        return @mount[spell_id] != nil

    --- Returns the full mount collection.
    --- @return table<number, number> Spell ID to data flag mapping
    GetMounts: =>
        return @mount

    --- Adds a companion spell to the account if not already known.
    --- @param spell_id number The companion spell ID
    --- @return self
    AddCompanion: (spell_id) =>
        unless @companion[spell_id]
            @companion[spell_id] = Game.AccountDataState.NEW_DATA
        return @

    --- Removes a companion spell from the account.
    --- @param spell_id number The companion spell ID
    --- @return self
    RemoveCompanion: (spell_id) =>
        @companion[spell_id] = nil if @companion[spell_id]
        return @

    --- Checks whether the account has a specific companion.
    --- @param spell_id number The companion spell ID
    --- @return boolean
    HasCompanion: (spell_id) =>
        return @companion[spell_id] != nil

    --- Returns the full companion collection.
    --- @return table<number, number> Spell ID to data flag mapping
    GetCompanions: =>
        return @companion

    --- Sets a currency amount for the account.
    --- @param currency_id number The currency item ID
    --- @param count number The amount of currency
    --- @return self
    SetCurrency: (currency_id, count) =>
        @currencies[currency_id] = count
        return @

    --- Removes a currency from the account.
    --- @param currency_id number The currency item ID
    --- @param count number The amount of currency to remove
    --- @return self
    RemoveCurrency: (currency_id, count) =>
        if @currencies[currency_id]
            @currencies[currency_id] = @currencies[currency_id] - count
            if @currencies[currency_id] <= 0
                @currencies[currency_id] = nil
        return @

    --- Checks whether the account has a specific currency.
    --- @param currency_id number The currency item ID
    --- @return boolean
    HasCurrency: (currency_id) =>
        return @currencies[currency_id] != nil

    --- Returns the full currency collection.
    --- @return table<number, number> Currency ID to count mapping
    GetCurrencies: =>
        return @currencies

    --- Persists all newly added mounts and companions to the database.
    Save: =>
        object_mgr = Game.ObjectMgr.GetInstance!
        for spell_id, flags in pairs(@mount)
            if flags == Game.AccountDataState.NEW_DATA
                object_mgr\SaveAccountMount @account_id, spell_id

        for spell_id, flags in pairs(@companion)
            if flags == Game.AccountDataState.NEW_DATA
                object_mgr\SaveAccountCompanion @account_id, spell_id

        for currency_id, count in pairs(@currencies)
            object_mgr\SaveAccountCurrency @account_id, currency_id, count
        return @