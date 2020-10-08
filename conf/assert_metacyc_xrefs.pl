
assert_xrefs :-
        assert_metacyc,
        assert_ec.
        
assert_metacyc :-
        rdf(X,rdf:type,biopax3:'Pathway'),
        re_matchsub('object=(.+)#',X,M,[]),
        Local=M.1,
        concat_atom(['MetaCyc',Local],':',Xref),
        rdf_assert(X,'http://www.geneontology.org/formats/oboInOwl#hasDbXref',Xref^^xsd:string),
        debug(rdf_matcher,'Adding xref ~w => ~w',[X,Xref]),
        fail.
assert_metacyc.


assert_ec :-
        rdf(X,biopax3:eCNumber,EC_S),
        rdf_matcher:literal_atom(EC_S, EC),
        concat_atom(['EC',EC],':',Xref),
        rdf_assert(X,'http://www.geneontology.org/formats/oboInOwl#hasDbXref',Xref^^xsd:string),
        debug(rdf_matcher,'Adding xref ~w => ~w',[X,Xref]),
        fail.
assert_ec.
