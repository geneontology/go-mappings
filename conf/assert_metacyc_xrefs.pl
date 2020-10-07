

assert_metacyc :-
        rdf(X,rdf:type,biopax3:'Pathway'),
        re_matchsub('object=(.+)#',X,M,[]),
        Local=M.1,
        concat_atom(['MetaCyc',Local],':',Xref),
        rdf_assert(X,'http://www.geneontology.org/formats/oboInOwl#hasDbXref',Xref^^xsd:string),
        debug(rdf_matcher,'Adding xref ~w => ~w',[X,Xref]),
        fail.
assert_metacyc.
