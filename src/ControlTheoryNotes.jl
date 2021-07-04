"""
A noteset for undergraduate and first-year 
graduate control theory! This set is 
provided online at jcarpinelli.dev/ControlTheoryNotes.jl/stable,
and can be served locally (offline) by calling
`ControlTheoryNotes.serve()`. Email the author
at _jdcarpinelli@gmail.com_ if you have questions!
"""
module ControlTheoryNotes

using LiveServer

"""
Serves the note-set locally on your computer. Keyword 
arguments are passed directly to `LiveServer.servedocs`.
"""
function serve(; kwargs...) 
    LiveServer.servedocs(kwargs...)
end

end # module
