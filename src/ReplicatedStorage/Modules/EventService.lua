local EventService = {}

EventService.ActiveEvent = nil

EventService.Events = {
    GlitchStorm = {
        Id = "GlitchStorm",
        Name = "Citywide Glitch Storm",
        Description = "Increased enemy spawns and fragment drops.",
        Duration = 300,
        FragmentMultiplier = 2,
        SpawnMultiplier = 2,
    },
}

return EventService