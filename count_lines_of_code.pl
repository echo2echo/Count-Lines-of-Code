#!/usr/bin/env perl

# File name: count_lines_of_code.pl
# Perl script to count lines of code written in Perl or PHP
# Made for Developers
# By Joel Rader  info[at]joelrader[dot]net

=pod

=head1 NAME

	count_lines_of_code.pl - Perl script to count lines of code written in Perl or PHP
        The script counts lines of code, comments, blank lines and POD ( Plain Old Documentation with Perl Scripts )	

=head1 SYNOPSIS
	
	bash$ ./count_lines_of_code.pl --type=(Perl||PHP) <path_to_filename>

	# For example, to count a Perl file	
	bash$ ./count_lines_of_code.pl --type=Perl file_to_count.pl
	
	# For example, to count a PHP file 
	bash$ ./count_lines_of_code.pl --type=PHP index.php
	
=head1 AUTHOR

	Joel Rader <https://joelrader.net>

=cut

use warnings;
use strict;
use diagnostics;

my $filetype = $ARGV[0];
my $file = $ARGV[1];

if (!$filetype) {
	$filetype = "";
}

if (!$file) {
	$file = "";
}

if (($filetype eq "") || ($file eq "")) {
  usage();
}

if (($filetype ne "--type=PHP") && ($filetype ne "--type=Perl")) {
  usage(); 
} 

if ($filetype eq "--type=PHP") { 
  php_count(); 
}

if ($filetype eq "--type=Perl") { 
  perl_count(); 
}

# Subroutine for script usage
sub usage {
	print "Script Usage: ./count_lines_of_code.pl --type=(PHP|Perl) <filename>\n";
        print 'Example... bash:$ ./count_lines_of_code.pl --type=Perl file_to_count.pl'."\n";
	print 'Example... bash:$ ./count_lines_of_code.pl --type=PHP index.php'."\n";
        exit;
}

# Subroutine for Perl script line count
sub perl_count {
	if ($file !~ m/(\.pl)/) {	
		print "Script --type flag was set for counting Perl file lines of code. \nThe file should end in .pl for a Perl script\n";
		exit
	}
	
	open FILE, $file or die "Could not open file! $!";
 	
	my $count = my $slurp_lines = my $block = my $number_of_comment_lines = my $pod_line = my $total = my $blank = 0;
	my @comment_lines;

	while (<FILE>) {
		$total++;	
		$slurp_lines .= $_;

                if ($slurp_lines =~ m/(=\S+[\s\S]*?\=cut\n)/) {
                        @comment_lines = split(/\n/,$1);
			foreach $pod_line (@comment_lines) {
				if ($pod_line =~ m/\S+/){ $block++; }	
			}
			$slurp_lines = "";
		}

		 
		if (($_ =~ m/^\s*$/) || (($_ =~ m/^\s*#/) && ($_ !~ m/\#\!\/usr/))) {
			if ($_ =~ m/^\s*#/){$number_of_comment_lines++;}
			if ($_ =~ /^\s*$/){$blank++;}
			next;
                }
		
		$count++;
        }
	
	close(FILE);

        my $lines = $count - $block;
print
"  Total:    $total
  POD:      $block
  Comments: $number_of_comment_lines
  Blank:    $blank
  Code:     $lines\n";


}

# Subroutine for PHP script line count
sub php_count {
	if ($file !~ m/(\.php)/) {
		print "Script --type flag was set for counting PHP file lines of code.\nThe file should end in .php for a PHP script\n";
		exit;
	}

	open FILE, $file or die "Could not open file! $!";

	my $count = my $slurp_lines = my $block = my $total = my $blank = my $number_of_comment_lines = my $pod_line = 0;
	my @comment_lines;

	while (<FILE>) {
		$total++;
		$slurp_lines .= $_;

		if ($slurp_lines =~ m/(\/\*[\s\S]*?\*\/)/) {
			@comment_lines = split(/\n/,$1);
			
                        foreach $pod_line (@comment_lines) {
			        if ($pod_line =~ m/\S+/){ $block++; }
			}
                        $slurp_lines = "";
		}

		if (($_ =~ m/^\s*$/) || ($_ =~ m/\/\//) || ($_ =~ m/^\s*#/)) {
			if($_ =~ m/^\s*$/){$blank++;}
			if (($_ =~ m/\/\//) || ($_ =~ m/^\s*#/)) {
				$number_of_comment_lines++;	
			} 
			next; 
		} 
	
		$count++;
	}
	
	close(FILE);
	
	$number_of_comment_lines += $block;
	my $lines = $count - $block;

print 
" Total:    $total
 Comments: $number_of_comment_lines
 Blank:    $blank
 Code:     $lines\n";

} 
