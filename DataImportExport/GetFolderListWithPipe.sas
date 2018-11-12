*-------------------------------------------------------------------------------------
| Name:         GetFolderListWithPipe.sas                                            |
| Description:  Get a simple list of specific directory.                             |
| Author:       Slash.Xin                                                            |
| Usage:        %GetFolderListWithPipe(path=, out_dsn=)                              |
| Parameters:   PATH=: This parameter can be either the full path of a directory or  |
|                      the full path with wildcards of a directory.                  |
|               OUT_DSN=: This parameter specifies the name of output data set.      |
|                                                                                    |
| Examples:     %GetFolderListWithPipe(path=D:\data, out_dsn=data_list)              |
|               %GetFolderListWithPipe(path=D:\data\*.xls, out_dsn=list)             |
--------------------------------------------------------------------------------------;

%macro GetFolderListWithPipe(path=/*The full path of specific folder.*/,
                             out_dsn=/*The name of out data set.*/);
    filename list pipe "dir ""&path"" /b";
    data &out_dsn;
        infile list truncover dlm='09'x;
        input item_name :$100.;
        label item_name="Name";
    run;
%mend GetFolderListWithPipe;

/*---------------Examples---------------*/
%GetFolderListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.list_pipe1)
%GetFolderListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4\*.exe, out_dsn=work.list_pipe2)
