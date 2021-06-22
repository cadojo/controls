using Documenter
using Literate

literate_files = [
    "Chapter 1: Dynamics.jl", 
    "Chapter 2: GTM Dynamics.jl"
]

for file ∈ literate_files
    Literate.markdown(
        joinpath(@__DIR__, "..", "src", file),
        joinpath(@__DIR__, "src", "generated")
    )
end

makedocs(
    sitename = "Control Theory Review",
    format = Documenter.HTML(),
    authors = "Joe Carpinelli",
    pages = [
        "Introduction" => "index.md",
        "Chapter 1: Dynamics" => joinpath("generated", "Chapter 1: Dynamics.md"),
        "Chapter 2: GTM Dynamics" => joinpath("generated", "Chapter 2: GTM Dynamics.md")
    ]
)

deploydocs(
    repo      = "https://github.com/cadojo/ControlTheoryNotes.jl",
    devbranch = "main",
    versions = ["stable" => "v^", "manual", "v#.#", "v#.#.#"]
)
