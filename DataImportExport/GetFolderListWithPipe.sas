*--------------------------------------------------------------------------
| Name:         GetFolderListWithPipe.sas                                 |
| Description:  Get a list of file and folder name of specific folder.    |
| Author:       Slash.Xin                                                 |
| Usage:        %GetFolderListWithPipe(path=, out_dsn=)                   |
| Example:      %GetFolderListWithPipe(path=D:\data, out_dsn=data_list)   |
|               %GetFolderListWithPipe(path=D:\data\*.xls, out_dsn=list)  |
---------------------------------------------------------------------------;

%macro GetFolderListWithPipe(path=, /*The full path of specific folder.*/
                             out_dsn=/*The name of out data set.*/);
    filename list pipe "dir ""&path"" /b";
    data &out_dsn;
        infile list truncover dlm='09'x;
        input item_name :$100.;
		label item_name="Name";
    run;
%mend GetFolderListWithPipe;

%GetFolderListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.list_pipe1)
%GetFolderListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4\*.exe, out_dsn=work.list_pipe2)
