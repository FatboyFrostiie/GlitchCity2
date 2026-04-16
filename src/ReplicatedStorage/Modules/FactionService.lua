local FactionService = {}

FactionService.Factions = {
    Stabilizers = { Id = "Stabilizers", DisplayName = "The Stabilizers", Description = "They want to fix the city." },
    Syndicate = { Id = "Syndicate", DisplayName = "The Syndicate", Description = "They profit from chaos." },
    Voidborn = { Id = "Voidborn", DisplayName = "The Voidborn", Description = "They embrace the glitch." },
}

function FactionService:GetDefaultFaction()
    return self.Factions.Stabilizers
end

return FactionService