using Documenter

sections = ("Dynamics", "Systems", "Controls", "Analysis")
for section in sections
    isdir(joinpath(@__DIR__, "src", section)) || mkdir(joinpath(@__DIR__, "src", section))
end

isdir(joinpath(@__DIR__, "src", "Front Matter")) || mkdir(joinpath(@__DIR__, "src", "Front Matter")) 
front = "Front Matter" => [
    "Welcome" => "index.md",
    "Chapter 1: Introduction" => joinpath("Front Matter", "Chapter 1: Introduction.md")
]

chapters = let topic = 1
    pages = [
        begin 
            section_string = "Topic $topic: $section"
            topic += 1
            section_string 
        end => [
            replace(page, ".md"=>"") => joinpath(section, page)
            for page in readdir(joinpath(@__DIR__, "src", section))
        ]   
        for section in sections
    ]
end

makedocs(
    sitename = "Exploring Control Theory",
    format   = Documenter.HTML(),
    authors  = "Joe Carpinelli",
    pages    = vcat(front, chapters)
)

deploydocs(
    repo      = "https://github.com/cadojo/ControlTheoryNotes.jl",
    devbranch = "main",
    versions = ["stable" => "v^", "manual", "v#.#", "v#.#.#"]
)
