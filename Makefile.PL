use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {'LWP::Simple' => 0, 'XML::Hash' => 0},
  test      => {TESTS => 't/*.t'}
);
