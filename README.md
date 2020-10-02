# GO Mappings

EXPERIMENTAL repo. So far just has mappings to PW (pathway ontology)

See: http://obofoundry.org/obo/pw

## Results

 * GO-PW: [Automatic mappings](target/obomatch-go-pw.sssom.tsv) we use SSSOM format
 * GO-PW: [Unmatched](target/nomatches-go-pw.tsv) (excluding drug/disease pathways)

## Method

We use rdf_matcher

For configuration see [conf]

For synonymization rules see [conf/term-synonymy.ttl](conf/term-synonymy.ttl). 
