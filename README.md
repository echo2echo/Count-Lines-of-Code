# Count-Lines-of-Code

Perl Script to Count Lines of Code of Perl and PHP Files

Place script in directory with files to count

Grant permission:

	$ sudo chmod 755 count_lines_of_code.pl

For example, to count lines in all the Perl files in a directory and each subdirectory	

	$ ./count_lines_of_code.pl --type=Perl
	
Or for example, to count lines in all PHP files in a directory and each subdirectory

	$ ./count_lines_of_code.pl --type=PHP
	
Or for example, to count lines in all HTML files in a directory and each subdirectory

	$ ./count_lines_of_code.pl --type=HTML
