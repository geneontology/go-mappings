#!/usr/bin/perl

our %relmap = (
    '&gt;'=>'positively_regulates',
    '|'=>'negatively_regulates',
    '-'=>'regulates'
    );

our @links = ();
our %nodeh = ();
while (<>) {
    if (m@alt="(.*)" title=@) {
        my $alt = $1;
        if ($alt =~ m@(.*) \-\-\-(\S*) (.*)@) {
            my $rel = $relmap{$2} || warn("no match for $2");
            push(@links,
                 {subject=>$1,
                  relation=>$rel,
                 object=>$3});

        }
        else {
            # todo: lookup html
            $nodeh{$alt} = {name=>"$alt"};
        }
    }
}
printf STDERR "NODES: %s\n", join(' ', keys %nodeh);
printf STDERR "LINKS: %d\nn", scalar(@links);
foreach my $link (@links) {
    $sid = $link->{subject} || die "no subject $%link";
    $oid = $link->{subject} || die "no object $%link";
    $s = $nodeh{$sid} || die "no subject $s in %$link";
    $o = $nodeh{$oid} || die "no object $o in %$link";
    $rel = $link->{relation};
    print "$s->{name}\t$rel $o->{name}\n";
}
