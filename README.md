# Count-Lines-of-Code

Perl Script to Count Lines of Code of Perl, PHP and HTML Files

Place script in directory with files to count

Grant permission:

	$ sudo chmod 755 count_lines_of_code.pl

For example, to count lines in all the Perl files in a directory and each subdirectory	

	$ ./count_lines_of_code.pl --type=Perl
	
Or for example, to count lines in all PHP files in a directory and each subdirectory

	$ ./count_lines_of_code.pl --type=PHP
	
Or for example, to count lines in all HTML files in a directory and each subdirectory.

There is now support for counting .shtml and .htm files along with vanilla .html files.  Use flag --type=HTML 

	$ ./count_lines_of_code.pl --type=HTML
	
To count lines of code of a webpage, run the following command in the same directory as the count_lines_of_code.pl script

	$ wget -cO - http://website.net > filename.html

Then run the script...

	$ ./count_lines_of_code.pl --type=HTML
