module "Game", package.seeall
export AccountDataState

--- Sequential enum for tracking data origin (loaded from DB vs newly added).
AccountDataState = Enum { "OLD_DATA", "NEW_DATA" }
