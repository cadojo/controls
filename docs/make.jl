using Documenter
using Literate

for file ∈ ["Chapter 1: Dynamics.jl"]
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
        "Chapter 1: Dynamics" => joinpath("generated", "Chapter 1: Dynamics.md")
    ]
)

deploydocs(
    repo      = "https://github.com/cadojo/ControlTheoryNotes.jl",
    devbranch = "main"
)
