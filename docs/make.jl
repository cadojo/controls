using Documenter
using Literate 
using PolynomialGTM
using Plots

for file ∈ ["Chapter 1: Dynamics.jl"]
    Literate.markdown(
        joinpath(@__DIR__, "..", "src", file),
        joinpath(@__DIR__, "src", "generated")
    )
end

makedocs(
    sitename = "Control Theory Notes",
    format = Documenter.HTML(),
    authors = "Joe Carpinelli",
    pages = [
        "Home" => "index.md"
    ]
)

deploydocs(
    repo = "https://github.com/cadojo/ControlTheoryNotes.jl"
)
