ONTDIR = src/ontology

MATCH = rdfmatch -X /tmp/rdfmatch_cache/ -A ~/repos/onto-mirror/void.ttl  -i obo_prefixes

target/obomatch-go-pw.sssom.tsv:
	$(MATCH) $(MATCHARGS) -w conf/weights.pro  --include_unmatched -p PW --match_prefix GO -d rdf_matcher -i conf/term-synonymy.ttl  -i $(ONTDIR)/pw-bridge.ttl -i pw -i go match > $@.tmp && mv $@.tmp $@

target/nomatches-go-pw.tsv:
	grep noMatch target/obomatch-go-pw.sssom.tsv | egrep -v '(DiseasePathway|DrugPathway)' | cut -f1,2,13 | sort -u > $@.tmp && mv $@.tmp $@

downloads/pathways.dat:
	curl -L -s http://bioinformatics.ai.sri.com/ptools/flatfile-samples/pathways.dat > $@.tmp && mv $@.tmp $@
