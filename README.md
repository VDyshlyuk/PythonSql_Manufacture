## PythonSql_Manufacture

## Task. Working with DBMS

At the FTP address you will find the archive task.rar address:
		ip            ******
		login         ******
    passw         ******

The task.rar archive contains CSV table files.
1. weight.txt
2. deposit.csv
3. quantity.csv
4. data.csv
5. price.csv

- part_number acts as a key for all these tables
- the weight.txt file contains the weights of goods in packaging and without
- the deposit.csv file contains the deposit value of the parts
- the quantity.csv file contains data on the availability of goods by warehouse
- data.csv file contains all basic product data
- price.csv file contains actual prices for goods

# The task is to load the data from the files into your database and create a SQL query that will display the following result for the columns from the files:
1. main_part_number
2. manufacturer
3. category
4. origin
5. price
6. deposit (if it doesn't exist, display zero)
7. calculate the final price with the deposit value
8. quantity (convert all values into a number format, an integer. Remove unnecessary characters. “>10” should be displayed as 10)
9. all data must be filtered by warehouses, use only warehouses with code name: A, H, J, 3, 9
10. positions that have the quantity of zero at should not be displayed
11. positions whose final price is less than 2.00 should not be displayed

The resulting table should be exported from the database as CSV and sent to the complete folder, which is located in the FTP folder.

## Additional task. Automation system.

Implement a system that:
1. will automatically download files from an FTP address
2. will process the data and get a ready CSV table
3. will send this table to the specified FTP address
