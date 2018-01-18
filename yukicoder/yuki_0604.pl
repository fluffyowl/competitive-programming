#!/usr/bin/perl
use bigint;

$N = <>;
chomp $N;
($A, $B, $C) = split /\s/, $N;
$hi = 10**18;
$lo = 0;

while ($hi - $lo > 1) {
    $mid = ($hi + $lo) / 2;
    if ($mid / $A * $B + ($mid - $mid / $A) >= $C) {
        $hi = $mid;
    } else {
        $lo = $mid;
    }
}

print "$hi\n";
