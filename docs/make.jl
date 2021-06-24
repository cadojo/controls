using Documenter
using Literate

makedocs(
    sitename = "Control Theory Review",
    format = Documenter.HTML(),
    authors = "Joe Carpinelli",
    pages = [
        "Frontmatter" => [
            "Welcome" => "index.md",
            "Chapter 1: Introduction" => "Chapter 1: Introduction.md"
        ],
        "Topic 1: Dynamics" => [
        "Chapter 2: General Dynamics" => "Chapter 2: General Dynamics.md",
        "Chapter 3: Flight Dynamics" => "Chapter 3: Flight Dynamics.md"
        ]
    ]
)

deploydocs(
    repo      = "https://github.com/cadojo/ControlTheoryNotes.jl",
    devbranch = "main",
    versions = ["stable" => "v^", "manual", "v#.#", "v#.#.#"]
)
