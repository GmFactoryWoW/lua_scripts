module "Game", package.seeall
export PlayerFlags

--- Bitflag enum for per-character persistent flags.
PlayerFlags = Enum.Flags { "TELEPORT_USED" }