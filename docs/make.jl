using Documenter

makedocs(
    sitename = "🎢 Control Theory",
    format = Documenter.HTML(),
    authors = "Joe Carpinelli",
    pages = [
        "Front Matter" => [
            "Welcome!" => "index.md",
            "Chapter 1: Introduction" => "Chapter 1: Introduction.md"
        ],
        "Topic 1: Dynamics" => [
        "Chapter 2: General Dynamics" => joinpath("Dynamics", "Chapter 2: General Dynamics.md"),
        "Chapter 3: Flight Dynamics" => joinpath("Dynamics", "Chapter 3: Flight Dynamics.md"),
        "Chapter 4: Linear Dynamics" => joinpath("Dynamics", "Chapter 4: Linear Dynamics.md"),
        "Chapter 5: Equilibrium Points" => joinpath("Dynamics", "Chapter 5: Equilibrium Points.md"),
        "Chapter 6: Linearization" => joinpath("Dynamics", "Chapter 6: Linearization.md")
        ],
        "Topic 2: Systems" => [],
        "Topic 3: Controls" => [
            "Draft: Disk Margins" => joinpath("Analysis", "Draft: Disk Margins.md")
        ],
        "Topic 4: Analysis" => []
    ]
)

deploydocs(
    repo      = "https://github.com/cadojo/ControlTheoryNotes.jl",
    devbranch = "main",
    versions = ["stable" => "v^", "manual", "v#.#", "v#.#.#"]
)
