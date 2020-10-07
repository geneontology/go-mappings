% baseline
weight(2.0, [predicate_id='owl:equivalentClass']).

% OBO
weight(-3, [predicate_id='owl:equivalentClass', any_match_field='oio:hasNarrowSynonym']).
weight(-3, [predicate_id='owl:equivalentClass', any_match_field='oio:hasBroadSynonym']).
weight(-1, [predicate_id='owl:equivalentClass', any_match_field='oio:hasRelatedSynonym']).

weight(-2, [object_category='cellular_component']).
weight(-2, [object_category='molecular_function']).
weight(-2, [subject_category='bl:DiseasePathway']).
weight(-2, [subject_category='bl:DrugPathway']).

weight(3, [subject_category='biopax3:Pathway', object_category='biological_process']).
weight(3, [subject_category='biopax3:BiochemicalReaction', object_category='molecular_function']).
weight(3, [subject_category='biopax3:Catalysis', object_category='molecular_function']).
weight(3, [subject_category='biopax3:Complex', object_category='cellular_component']).
weight(-3, [subject_category='biopax3:Protein', object_category='molecular_function']).


weight(-0.5, [predicate_id='owl:equivalentClass', match_category='one_to_many']).
weight(-0.5, [predicate_id='owl:equivalentClass', match_category='many_to_one']).
weight(-1, [predicate_id='owl:equivalentClass', match_category='many_to_many']).


% pre-supplied mapping
weight(3, [predicate_id='owl:equivalentClass', any_match_field='skos:exactMatch', any_match_field='schema:url']).
weight(1, [predicate_id='owl:equivalentClass', any_match_field='oio:hasDbXref', any_match_field='schema:url']).

% lexical is lower, stemmming even lower
weight(-1.0, [predicate_id='owl:equivalentClass', match_type=['Lexical','Stemming']]).
weight(-0.5, [predicate_id='owl:equivalentClass', match_type=['Lexical']]).

weight(-1, [match_string=S]) :-  atom_length(S,3).
weight(-2, [match_string=S]) :-  atom_length(S,2).
weight(-3, [match_string=S]) :-  atom_length(S,1).
weight(-99, [match_string=S]) :-  atom_length(S,0).

% reward multi-word terms
weight(W, [match_string=S]) :-  concat_atom(L,' ',S),length(L,Len),W is (Len-1) * 0.3.



