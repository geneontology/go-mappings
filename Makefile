ONTDIR = src/ontology

MATCH = rdfmatch -X /tmp/rdfmatch_cache/ -A ~/repos/onto-mirror/void.ttl  -i obo_prefixes

all: target/obomatch-go-pw.sssom.tsv target/nomatches-go-pw.tsv target/obomatch-go-yeastpathway.sssom.tsv target/nomatches-go-yeastpathway.tsv 

target/obomatch-go-pw.sssom.tsv:
	$(MATCH) $(MATCHARGS) -w conf/weights.pro  --include_unmatched -p PW --match_prefix GO -d rdf_matcher -i conf/term-synonymy.ttl -i $(ONTDIR)/pw-bridge.ttl -i pw -i go match > $@.tmp && mv $@.tmp $@

target/nomatches-go-pw.tsv: target/obomatch-go-pw.sssom.tsv
	grep noMatch $< | egrep -v '(DiseasePathway|DrugPathway)' | cut -f1,2,13 | sort -u > $@.tmp && mv $@.tmp $@

#YP_PREFIX = http://pathway.yeastgenome.org/YEAST/pathway-biopax?type=3%38object=
YP_PREFIX = http://pathway.yeastgenome.org/YEAST/pathway-biopax?

target/obomatch-go-yeastpathway.sssom.tsv:
	$(MATCH) $(MATCHARGS) -T -w conf/weights.pro -c conf/assert_metacyc_xrefs.pl -g assert_metacyc  --include_unmatched -p yeastpathway -m yeastpathway=$(YP_PREFIX) --match_prefix GO -d rdf_matcher -i src/ontology/biopax-level3.owl -i conf/term-synonymy.ttl -i downloads/yeastpathways.ttl -i go match > $@.tmp && mv $@.tmp $@

target/%.crosstab.tsv: target/%.sssom.tsv
	sssom crosstab -o $@ $<

target/nomatches-go-yeastpathway.tsv: target/obomatch-go-yeastpathway.sssom.tsv
	grep noMatch $< | egrep '\tbiopax3:Pathway' | cut -f1,2,13 | sort -u > $@.tmp && mv $@.tmp $@

downloads/pathways.dat:
	curl -L -s http://bioinformatics.ai.sri.com/ptools/flatfile-samples/pathways.dat > $@.tmp && mv $@.tmp $@
