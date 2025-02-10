#!/usr/bin/env perl

# File name: count_lines_of_code.pl
# Perl script to count lines of code written in Perl, PHP or HTML
# By Joel Rader  info[at]joelrader[dot]net

=pod

=head1 NAME

	count_lines_of_code.pl - Perl script to count lines of code written in Perl, PHP or HTML
        The script counts lines of code, comments, blank lines and POD ( Plain Old Documentation )	
	The script summarizes the lines of code for all Perl, PHP or HTML files in a directory and all sub directories
	
=head1 SYNOPSIS
	
	$ ./count_lines_of_code.pl --type=(Perl||PHP||HTML)

	# For example, to count all Perl files	
	$ ./count_lines_of_code.pl --type=Perl
	
	# For example, to count all PHP files 
	$ ./count_lines_of_code.pl --type=PHP
		
	# For example, to count all HTML files 
	$ ./count_lines_of_code.pl --type=HTML

	#  Or count a single Perl file...
        $ ./count_lines_of_code.pl --type=Perl | grep -A 5 "filename.pl"

	# For example, to skip counting lines of this perl script
	$ ./count_lines_of_code.pl --type=Perl --omit=count_lines_of_code.pl
 
=head1 AUTHOR

	Joel Rader <https://joelrader.net>

=cut

use warnings;
use strict;
use diagnostics;

my $command;
my $filetype= "";
my $scriptname="";

$filetype = $ARGV[0];

if ($ARGV[1]) { 
	$scriptname = $ARGV[1]; 
	$scriptname =~ s/--omit=//;
}

if (!$filetype) { usage(); }

if (($filetype ne "--type=PHP") && ($filetype ne "--type=Perl") && ($filetype ne "--type=HTML")) { usage(); }

my $sumTotal;
my $sumBlock;
my $sumComments;
my $sumBlank;
my $sumLines;

if ( $filetype =~ m/Perl/ ) { $command = "find . -name \"*.pl\" | sort"; }
if ( $filetype =~ m/PHP/ ) { $command = "find . -name \"*.php\" | sort"; }
if ( $filetype =~ m/HTML/ ) { $command = "find . -name \"*.*htm*\" | sort"; }

my @files = `$command`;

my $exist = $filetype;

$exist =~ s/--type=//;

if (!@files) {print "No files of type $exist in this directory.\n"; exit; }

our $file;

foreach $file ( @files ) { 

	if (!$filetype) {
		$filetype = "";
	}

	if (!$file) {
		$file = "";
	}

	if (($filetype eq "") || ($file eq "")) {
  		usage();
	}

	if (($filetype ne "--type=PHP") && ($filetype ne "--type=Perl") && ($filetype ne "--type=HTML"))  {
  		usage(); 
	} 

	if ($filetype eq "--type=PHP") { 
  		php_count(); 
	}

	if ($filetype eq "--type=Perl") { 
  		perl_count(); 
	}
	
	if ($filetype eq "--type=HTML") { 
  		html_count(); 
	}


}





 

# Subroutine for script usage
sub usage {

        my $myscriptname= $0;
        $myscriptname =~ s/\.\///;

        print "Script Usage: \$ ./$myscriptname --type=(PHP|Perl|HTML) \n";
        print "Example: \$ ./$myscriptname --type=Perl\n";
        print "Example: \$ ./$myscriptname --type=PHP\n";
        print "Example: \$ ./$myscriptname --type=HTML\n";
	# To skip counting lines of this perl script
        print "Example: \$ ./$myscriptname --type=Perl --omit=$myscriptname\n";
        exit;
}






# Subroutine for Perl script line count
sub perl_count {

	if ( $scriptname eq "p" || $scriptname eq "l" || $scriptname eq "pl" || $scriptname eq "\.pl" || $scriptname eq "." ) { print "All files omitted.\n"; exit; }
	
 	open FILE, $file or die "Could not open file! $!";
 	
	my $count = my $slurp_lines = my $block = my $number_of_comment_lines = my $pod_line = my $total = my $blank = 0;
	my @comment_lines;
	my $omit = 0;
 
	while (<FILE>) {

   		if ( $file =~ m/$scriptname/ ) {next;}

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
		$omit = 1;
		$count++;
        }
	
	close(FILE);

        my $lines = $count - $block;
	
	$file =~ s/\.\///;
	if ( $omit == 0 ){ return; }
 
print "Lines of Code for $file";	u
print
"  Total:    $total
  POD:      $block
  Comments: $number_of_comment_lines
  Blank:    $blank
  Code:     $lines\n";

 $sumTotal += $total;
 $sumBlock += $block;
 $sumComments += $number_of_comment_lines;
 $sumBlank += $blank;
 $sumLines += $lines;

}







# Subroutine for PHP script line count
sub php_count {

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
	
	$file =~ s/\.\///;

	print "Lines of Code for $file";

print 
" Total:    $total
 Comments: $number_of_comment_lines
 Blank:    $blank
 Code:     $lines\n";



 $sumTotal += $total;
 $sumComments += $number_of_comment_lines;
 $sumBlank += $blank;
 $sumLines += $lines;



} 










# Subroutine for HTML file line count
sub html_count {

	open FILE, $file or die "Could not open file! $!";

	my $count = my $slurp_lines = my $total = my $blank = my $number_of_comment_lines = my $comment = 0;
	my @comment_lines;
	my $comment_number;

	while (<FILE>) {
		
		$total++;
		$slurp_lines .= $_;	
		
		if ($_ =~ m/^\s*$/){ $blank++; next; }
		$count++;

	}	
	
	while ( $slurp_lines =~ /(<!--(?!-?>).*?--\s*>)/sg ) {

    		$comment = $1;

    		@comment_lines = split /\n/, $comment;

    		$number_of_comment_lines += @comment_lines;
			
	}

	  my $lines = $count - $number_of_comment_lines;

	close(FILE);
	
	$file =~ s/\.\///;

	print "Lines of Code for $file";

print 
" Total:    $total
 Comments: $number_of_comment_lines
 Blank:    $blank
 Code:     $lines\n";



 $sumTotal += $total;
 $sumComments += $number_of_comment_lines;
 $sumBlank += $blank;
 $sumLines += $lines;


} 



if ( $omit == 0 ){ print "No files counted.\n"; exit; }


if ( $filetype eq "--type=PHP") {
	print "~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	print "Summary for all PHP files: \n";
	print "~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	print 
 " Total:    $sumTotal
 Comments: $sumComments
 Blank:    $sumBlank
 Code:     $sumLines\n";

}


if ( $filetype eq "--type=Perl") {
	print "~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	print "Summary for all Perl files: \n";
	print "~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	print 
 " Total:     $sumTotal
 POD:       $sumBlock 
 Comments:  $sumComments
 Blank:     $sumBlank
 Code:      $sumLines\n";

}


if ( $filetype eq "--type=HTML") {

	print "~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	print "Summary for all HTML files: \n";
	print "~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print	
 " Total:    $sumTotal
 Comments: $sumComments
 Blank:    $sumBlank
 Code:     $sumLines\n";

}
