#!/usr/bin/perl

use strict;
use warnings;
use GD;
use Math::Complex;

use constant PI => 4 * atan2(1, 1);
use constant E => exp(1);

my $img=new GD::Image(1024,1100,1);  	

for my $power (0..10) {
  my $N=(2**$power);

  for my $k (0..$N-1) {
    my $factor=E**(($k)*(-i*2*PI)/$N);
    my $re=Re($factor);
    my $im=Im($factor);

    my $cos=abs($re)*255;
    my $sin=abs($im)*255;
    my $blue=0;
    $blue+=127 if $im<0;
    $blue+=127 if $re<0;
    my $atan2=atan2($re, $im);
    $img->filledRectangle($k*(1024/$N), $power*100, ($k+1)*(1024/$N)-2, ($power*100)+100, $img->colorResolve($cos,$sin,$atan2));
  }
}

open(IMAGE, ">fft.png");
binmode IMAGE;
print IMAGE $img->png;
close IMAGE;