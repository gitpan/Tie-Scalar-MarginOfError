package Tie::Scalar::MarginOfError;

=head1 NAME

Tie::Scalar::MarginOfError - Scalars that have margins of error

=head1 SYNOPSIS

	use Tie::Scalar::MarginOfError;

	tie my $val, 'Tie::Scalar::MarginOfError', { tolerance => 0.1, initial_value => 1 };


=head1 DESCRIPTION

This allows you to have a scalar which has to stay within a certain
margin of error. Your code will die if the scalar's value goes outside
this range.

You tie a variable, and give it an initial value and a tolerance. Your
code will die if the value gets beyond +/- whatever you have set the
tolerance to be.

In the SYNOPSIS example, $val will cause your code to explode if it gets
above 1.1 or below 0.9.

=cut

use strict;
use warnings;

our $VERSION = "0.01";

use Tie::Scalar;
use base 'Tie::StdScalar';

use Carp;

sub STORE {
	my ($self, $val) = @_;
	my $err = $$self->{tolerance};
	if (($val > $$self->{initial_value} + $$self->{tolerance}) 
		|| ($val < $$self->{initial_value} - $$self->{tolerance})) {
		croak "$val is outside margin of error"; 
	}
	$$self->{value} = $val;
}

sub FETCH {
	my $self = shift;
	return $$self->{value};
}

=head1 CAVEATS

Yes, you could use this to montior the core temperature of your nuclear
reactor. But the variable is tied, so it can be considered slower than
normal. And if you are depending on the reactor not going critical, I
wouldn't be using this code. Or perl, come to think of it.

=head1 SEE ALSO

perldoc perltie

=head1 THANKS

o Dave Cross, whose talk to Belfast.pm made me write this. Blame him.

=head1 BUGS

Let me know if you spot one. Or if your core goes critical and wipes out
the Mid-West of the US. But I guess I would see that on the news.

=head1 AUTHOR

Stray Toaster, E<lt>coder@stray-toaster.co.ukE<gt>

=head1 SHOWING YOUR APPRECIATION

There was a thread on london.pm mailing list about working in a vacumn - 
that it was a bit depressing to keep writing modules but never get any 
feedback. So, if you use and like this module then please send me an 
email and make my day.  

All it takes is a few little bytes.  

(Leon wrote that, not me!)

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2003 by Stray Toaster

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
