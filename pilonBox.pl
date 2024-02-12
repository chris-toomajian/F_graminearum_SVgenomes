#!/use/bin/perl -w
#
# Author: Sanzhen Liu <liu3zhen@ksu.edu>
# 7/21/2019
#
use strict;
use warnings;
use Getopt::Std;

&master;
exit;

sub master {
	&usage if (@ARGV < 1);
	my $cmd = shift(@ARGV);
	my %modules = (summary => \&summary); # to add more
	die ("Unknown module \"$cmd\".\n") if (!defined ($modules{$cmd}));
	&{$modules{$cmd}};
}

#########################################################################
# summary
#########################################################################
sub summary {
	die(qq/Usage: pilonBox.pl summary <changes>\n/) if (@ARGV==0 && -t STDIN);
	
	my %vartype_stat;
	my %chr_vartype_stat;
	while (<>) {
		if (!/^#/) {
			my @line = split(" ", $_);
			my $chr = $line[0]; # chr
			$chr =~ s/\:.*//g;
			my ($ref, $alt) = @line[2..3]; # ref and alt alleles
			
			# common sequence at the beginning of both ref and alt
			my $ref_alt_common_head = &common_head_str($ref, $alt);
			
			# reformat ref and alt
			# remove common head sequence
			$ref =~ s/^$ref_alt_common_head//g;
			$ref = "." if $ref eq "";

			$alt =~ s/^$ref_alt_common_head//g;
			$alt = "." if $alt eq "";

			# type assessment
			my $ref_len = count_nuc($ref);
			my $alt_len = count_nuc($alt);

			if ($ref eq ".") { # insertion
				$vartype_stat{insertion}++;
				$chr_vartype_stat{$chr}{insertion}++
			} elsif ($alt eq ".") { # deletion
				$vartype_stat{deletion}++;
				$chr_vartype_stat{$chr}{deletion}++
			} elsif ($ref_len == 1 and $alt_len == 1) {
				$vartype_stat{substitution}++;
				$chr_vartype_stat{$chr}{substitution}++
			} elsif ($ref_len == $alt_len) {
				$vartype_stat{replace_equal}++;
				$chr_vartype_stat{$chr}{replace_equal}++
			} elsif ($ref_len < $alt_len) {
				$vartype_stat{replace_plus}++;
				$chr_vartype_stat{$chr}{replace_plus}++
			} elsif ($ref_len > $alt_len) {
				$vartype_stat{replace_minus}++;
				$chr_vartype_stat{$chr}{replace_minus}++
			} else {
				my $other_var = $ref."_to_".$alt;
				push(@{$vartype_stat{others}}, $other_var);
			}
		}
	}
	
	# report
	my @all_vartypes = sort {$vartype_stat{$b} <=> $vartype_stat{$a}} keys %vartype_stat;
	# print header and genomic summary data
	print "chr\t";
	print join("\t", @all_vartypes);
	print "\ttotal\nGenome";
	
	my $total_count = 0;
	foreach my $vartype (@all_vartypes) {
		$total_count += $vartype_stat{$vartype};
		print "\t$vartype_stat{$vartype}";
		print STDERR "$vartype\t$vartype_stat{$vartype}\n";
	}
	print "\t$total_count\n";
	
	# print summary data for each chr
	foreach my $echr (sort {$a cmp $b} keys %chr_vartype_stat) {
		print $echr;
		my $chr_total_count = 0;
		foreach my $vartype (@all_vartypes) {
			if (exists $chr_vartype_stat{$echr}{$vartype}) {
				print "\t$chr_vartype_stat{$echr}{$vartype}";
				$chr_total_count += $chr_vartype_stat{$echr}{$vartype};
			} else {
				print "\t0";
			}
		}
		print "\t$chr_total_count\n";
	}
}

sub count_nuc {
# count number of ATGC or atgc
	my $inseq = shift;
	$inseq =~ s/[^ATGCatgc]//g; # remove non-ATGC
	my $inseq_len = length($inseq);
	return $inseq_len;
}

sub common_head_str {
# determine shared sequences at the beginning of two input sequences
	my $share_head_bases = "";
	my ($inseq1, $inseq2) = @_;
	my @inseq1 = split(//, $inseq1);
	my @inseq2 = split(//, $inseq2);
	my $min_num_bases = ($#inseq1 >= $#inseq2) ? $#inseq2 : $#inseq1;
	for (my $i=0; $i<=$min_num_bases; $i++) {
		if ($inseq1[$i] eq $inseq2[$i]) {
			$share_head_bases .= $inseq1[$i];
		} else {
			last;
		}
	}

	return $share_head_bases;
}

sub usage {
	die(qq/
Usage: pilonBox.pl <module> [arguments]\n
[Modules]
summary     : summarize variant types
\n/);
}

