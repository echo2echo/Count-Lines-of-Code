# Count-Lines-of-Code

Perl Script to Count Lines of Code of Perl, PHP and HTML Files on Linux

Place script in directory with files and subdirectories to count

Grant permission to run script:

	$ chmod 755 count_lines_of_code.pl

For script usage type the following without arguments.

	$ ./count_lines_of_code.pl 

or

    $ perldoc count_lines_of_code.pl
 
For example, to count lines of all the Perl files in a directory and each subdirectory:

	$ ./count_lines_of_code.pl --type=Perl
	
For example, to count lines of all PHP files in a directory and each subdirectory:

	$ ./count_lines_of_code.pl --type=PHP

There is now support for counting .shtml and .htm files along with vanilla .html files.  Use flag --type=HTML for each variation
	
For example, to count lines of all HTML files in a directory and each subdirectory:

	$ ./count_lines_of_code.pl --type=HTML
	
To count lines of code of a webpage, run something like the following in the same directory as the count_lines_of_code.pl script:
	
	$ wget -cO - http://website.net > filename.html

Then run the script...

	$ ./count_lines_of_code.pl --type=HTML
	
To get a count for a single HTML file try a variation of the following...
	
	$ ./count_lines_of_code.pl --type=HTML | grep -A 4 "filename.html"

Or for a single Perl file...

	$ ./count_lines_of_code.pl --type=Perl | grep -A 5 "filename.pl"

Files to be counted require read permission.  If there is a permission error you could try running script with sudo, something like the following...
	
	$ sudo ./count_lines_of_code.pl --type=Perl | grep -A 5 "filename.pl"

To omit/skip counting the lines of code of the script itself in the results when counting perl lines try something like below...

--omit usage

  	$ ./count_lines_of_code.pl --type=Perl --omit=count_lines_of_code.pl


*** --omit flag is still a work in progress.  As a temporary work around, place the count_lines_of_code.pl script in a directory with a least one other perl file to be counted.  ***
 	
Until the --omit flag is fixed you will need at least 2 perl files in the same directory as you are using the script in.  Or create a small .pl file with the script below to run without errors. Yes, a bug.
	
  	$ echo "Fill text for script functionality" > omit.pl
