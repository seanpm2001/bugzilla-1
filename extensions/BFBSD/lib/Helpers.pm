package Bugzilla::Extension::BFBSD::Helpers;

use strict;
use Bugzilla;
use Bugzilla::User;

use base qw(Exporter);

our @EXPORT = qw(
    no_maintainer get_user ports_product ports_component

    UID_AUTOASSIGN
    PRODUCT_PORTS
    COMPONENT_PORTS
);

use constant {
    UID_AUTOASSIGN => "bugzilla\@FreeBSD.org",
    PRODUCT_PORTS => "Ports & Packages",
    COMPONENT_PORTS => "Individual Port(s)"
};


sub ports_product {
    return PRODUCT_PORTS
}

sub ports_component {
    return COMPONENT_PORTS
}

sub no_maintainer {
    my $maintainer = shift();
    if (lc($maintainer) eq "ports\@freebsd.org") {
        return 1;
    }
    return 0;
}

sub get_user {
    my $name = shift();
    my $uid = login_to_id($name);
    if (!$uid) {
        warn("No user found for $name");
        return;
    }
    my $user = new Bugzilla::User($uid);
    if (!$user->is_enabled) {
        warn("Found user $name is not enabled in Bugzilla");
        return;
    }
    return $user;
}

1;