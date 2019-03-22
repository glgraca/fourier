#!/usr/bin/perl
use strict;
use warnings;
use Math::Complex;

use constant PI => 4 * atan2(1, 1);
use constant E => exp(1);

my @data=();
for my $k (0..127) {
  $data[$k]=sin($k);
}

my @result=fft(@data);

for my $n (@result) {
  my $re=Re($n);
  my $im=Im($n);
  my $d=sqrt($re**2+$im**2);
  print "$d\n";
}

sub fft {
  my @x=@_;
  my $N=scalar(@x);
  
  if($N==1) {
    return $x[0];
  } else {
    my @X=();
    my $even=1;
    my @even=fft(grep { $even^=1 } @x);
    my $odds=0;
    my @odds=fft(grep { $odds^=1 } @x);
    
    push @X, @even;
    push @X, @odds;
    
    for my $k (0..scalar(@X)/2-1) {
      my $t=$X[$k];
      
      $X[$k]=$t+(E**(-i*2*PI*$k/$N))*$X[$k+$N/2];
      $X[$k+$N/2]=$t-(E**(-i*2*PI*$k/$N))*$X[$k+$N/2];
    }
    return @X;
  }
}