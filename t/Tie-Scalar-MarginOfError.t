#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More tests => 24;

use Tie::Scalar::MarginOfError;

{
	tie my $val, 'Tie::Scalar::MarginOfError', { tolerance => 0.1, initial_value => 1 };
	eval { $val = 1.01 };
	ok !$@, "inside margin of error (bigger than original)";
	is $val, 1.01, "Value set correctly";
	eval { $val = 2 };
	like $@, qr/outside/, "opps, outside margin of error";
}

{
	tie my $val, 'Tie::Scalar::MarginOfError', { tolerance => 0.1, initial_value => 1 };
	eval { $val = 0.99 };
	ok !$@, "inside margin of error (less than original)";
	is $val, 0.99, "Value set correctly";
	eval { $val = 0 };
	like $@, qr/outside/, "opps, outside margin of error";
}

{
	tie my $val, 'Tie::Scalar::MarginOfError', { tolerance => 0.1, initial_value => 1 };
	for (my $i = 1; $i < 1.1; $i += 0.025) {
		eval { $val = $i };
		ok ! $@, "$i inside margin of error (value getting bigger)";
		is $val, $i, "value set to $i";
	} 
}

{
	tie my $val, 'Tie::Scalar::MarginOfError', { tolerance => 0.1, initial_value => 1 };
	for (my $i = 1; $i > 0.9; $i -= 0.025) {
		eval { $val = $i };
		ok ! $@, "$i inside margin of error (value getting smaller)";
		is $val, $i, "value set to $i";
	} 
}
