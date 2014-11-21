use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Cafepress::Api',
  ABSTRACT     => 'Cafepress API in Perl',
  AUTHOR       => 'Valcho Nedelchev <weby@cpan.org>',
  VERSION_FROM => 'lib/Cafepress/Api.pm',
  META_MERGE   => {
    resources => {
      homepage   => 'https://github.com/valchonedelchev/cafepress-api',
      bugtracker => 'https://github.com/valchonedelchev/cafepress-api/issues',
      repository => 'https://github.com/valchonedelchev/cafepress-api.git',
    },
  },
  PREREQ_PM => { 'LWP::UserAgent' => 0, 'XML::Hash' => 0, 'Moose' => 0 },
  test      => { TESTS            => 't/*.t' }
);

