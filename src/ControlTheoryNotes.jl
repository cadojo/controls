"""
A noteset for undergraduate and first-year 
graduate control theory! This set is 
provided online at jcarpinelli.dev/ControlTheoryNotes.jl,
and can be served locally (offline) by calling
`ControlTheoryNotes.serve()`. Email the author
at _jdcarpinelli@gmail.com_ if you have questions!
"""
module ControlTheoryNotes

using LiveServer
using Literate 
using PolynomialGTM
using Plots

function serve() 
    LiveServer.servedocs()
end

end # module
