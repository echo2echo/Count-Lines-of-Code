# Count-Lines-of-Code

Perl Script to Count Lines of Code of Perl and PHP Files

Place script in directory with files to count

Grant permission:

	$ sudo chmod 755 cloc.pl

For example, to count lines in all the Perl files in a directory and each subdirectory	

	$ ./cloc.pl --type=Perl
	
Or for example, to count lines in all PHP files in a directory and each subdirectory

	$ ./cloc.pl --type=PHP
