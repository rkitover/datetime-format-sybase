package DateTime::Format::Sybase;

use strict;
use warnings;
use DateTime::Format::Strptime;

=head1 NAME

DateTime::Format::Sybase - Parse and format Sybase datetimes

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

  use DateTime::Format::Sybase;
  use DBI;

  my $dbh = DBI->connect('dbi:Sybase:SERVER', 'sa', '');
  $dbh->syb_date_fmt('ISO_Strict'); # output format
  $dbh->do('set dateformat mdy'); # input format

  my $dt = DateTime::Format::Sybase->parse_datetime(
    '2004-08-21T14:36:48.080Z'
  );

  DateTime::Format::Sybase->format_datetime($dt); # '08/21/2004 14:36:48.080'

=head1 DESCRIPTION

Run the DBI calls as specified in L</SYNOPSIS> on connection to use this module
with Sybase.

=cut

my $output_format = DateTime::Format::Strptime->new(
  pattern => '%Y-%m-%dT%H:%M:%S.%3NZ'
);

my $input_format = DateTime::Format::Strptime->new(
  pattern => '%m/%d/%Y %H:%M:%S.%3N'
);

sub parse_datetime   { shift; $output_format->parse_datetime(@_) }
sub parse_timestamp  { shift; $output_format->parse_datetime(@_) }

sub format_datetime  { shift; $input_format->format_datetime(@_) }
sub format_timestamp { shift; $input_format->format_datetime(@_) }

=head1 METHODS

=head2 parse_datetime

Parse a string returned by L<DBD::Sybase> for a C<DATETIME> or C<SMALLDATETIME>
column in the C<ISO_Strict> L<DBD::Sybase/syb_date_fmt> format.

Remember C<SMALLDATETIME> fields have only minute precision.

=head2 parse_timestamp

Same as L</parse_datetime>.

=head1 format_datetime

Format a L<DateTime> object into a string in the Sybase C<mdy> C<DATETIME> input
format, with a time component, for insertion into the database.

=head2 format_timestamp

Same as L</format_datetime>.

=head1 AUTHOR

Rafael Kitover, C<< <rkitover at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-datetime-format-sybase at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DateTime-Format-Sybase>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DateTime-Format-Sybase>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DateTime-Format-Sybase>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DateTime-Format-Sybase>

=item * Search CPAN

L<http://search.cpan.org/dist/DateTime-Format-Sybase/>

=back

=head1 COPYRIGHT & LICENSE

Copyright (c) 2009 Rafael Kitover

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of DateTime::Format::Sybase
