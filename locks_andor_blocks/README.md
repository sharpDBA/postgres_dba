# PostgreSQL script to find locks on database objects and blocked processes.

Copy this directory change into it. As long as the SQL file is in the same directory as the bash script, run as in the example below. 
This will create a csv file in the current directory.  
###### Example: 
`./locks_andor_blocks.sh 'localhost' 'lab' 'postgres'`

- _Parameter 1:_ **database host**
- _Parameter 2:_ **database name**
- _PostgreSQL port hardcoded in at default [5432]_
- _Parameter 3:_ **database user**
