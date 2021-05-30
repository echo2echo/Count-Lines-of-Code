# Count-Lines-of-Code

Perl Script to Count Lines of Code of Perl, PHP and HTML Files

Place script in directory with files to count

Grant permission:

	$ sudo chmod 755 count_lines_of_code.pl

For example, to count lines of all the Perl files in a directory and each subdirectory	

	$ ./count_lines_of_code.pl --type=Perl
	
For example, to count lines of all PHP files in a directory and each subdirectory

	$ ./count_lines_of_code.pl --type=PHP

There is now support for counting .shtml and .htm files along with vanilla .html files.  Use flag --type=HTML 
	
For example, to count lines of all HTML files in a directory and each subdirectory

	$ ./count_lines_of_code.pl --type=HTML
	
To count lines of code of a webpage, run something like the following in the same directory as the count_lines_of_code.pl script
	
	$ wget -cO - http://website.net > filename.html

Then run the script...

	$ ./count_lines_of_code.pl --type=HTML
	
To get count for a single file...
	
	$ ./count_lines_of_code.pl --type=HTML | grep -A 4 "file_to_count.html"
