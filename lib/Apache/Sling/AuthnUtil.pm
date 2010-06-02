#!/usr/bin/perl

package Apache::Sling::AuthnUtil;

use 5.008008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Apache::Sling ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

=head1 NAME

AuthnUtil - useful utility functions for general Authn functionality.

=head1 ABSTRACT

Utility library providing useful utility functions for general Authn functionality.

=cut

#{{{sub basic_login_setup

=pod

=head2 basic_login_setup

Returns a textual representation of the request needed to log the user in to
the system via a basic auth based login.

=cut

sub basic_login_setup {
    my ( $baseURL ) = @_;
    die "No base url defined!" unless defined $baseURL;
    return "get $baseURL/system/sling/login?sling:authRequestLogin=1";
}
#}}}

#{{{sub basic_login_eval

=pod

=head2 basic_login_eval

Verify whether the log in attempt for the user to the system was successful.

=cut

sub basic_login_eval {
    my ( $res ) = @_;
    return ( $$res->code =~ /^200$/ );
}
#}}}

#{{{sub form_login_setup

=pod

=head2 form_login_setup

Returns a textual representation of the request needed to log the user in to
the system via a form based login.

=cut

sub form_login_setup {
    my ( $baseURL, $username, $password ) = @_;
    die "No base url defined!" unless defined $baseURL;
    die "No username supplied to attempt logging in with!" unless defined $username;
    die "No password supplied to attempt logging in with for user name: $username!" unless defined $password;
    my $postVariables = "\$postVariables = ['sakaiauth:un','$username','sakaiauth:pw','$password','sakaiauth:login','1']";
    return "post $baseURL/system/sling/formlogin $postVariables";
}
#}}}

#{{{sub form_login_eval

=pod

=head2 form_login_eval

Verify whether the log in attempt for the user to the system was successful.

=cut

sub form_login_eval {
    my ( $res ) = @_;
    return ( $$res->code =~ /^200$/ );
}
#}}}

#{{{sub form_logout_setup

=pod

=head2 form_logout_setup

Returns a textual representation of the request needed to log the user out of
the system via a form based mechanism.

=cut

sub form_logout_setup {
    my ( $baseURL ) = @_;
    die "No base url defined!" unless defined $baseURL;
    my $postVariables = "\$postVariables = ['sakaiauth:logout','1']";
    return "post $baseURL/system/sling/formlogin $postVariables";
}
#}}}

#{{{sub form_logout_eval

=pod

=head2 form_logout_eval

Verify whether the log out attempt for the user from the system was successful.

=cut

sub form_logout_eval {
    my ( $res ) = @_;
    return ( $$res->code =~ /^200$/ );
}
#}}}

1;

