*----------------------------------------------------------------------------------------
| Name:         GetFolderDetailListWithPipe.sas                                         |
| Description:  Get a detail list of specific directory. This detail list contains the  |
|               ITEM_NAME, ITEM_TYPE(file or folder), ITEM_SIZE, ITEM_LAST_MODIFY_DATE. |
| Author:       Slash.Xin                                                               |
| Usage:        %GetFolderDetailListWithPipe(path=, out_dsn=)                           |
| Parameters:   PATH=: This parameter can be either the full path of a directory or the |
|                      full path with wildcards of a directory.                         |
|               OUT_DSN=: This parameter specifies the name of output data set.         |
|                                                                                       |
| Examples:     %GetFolderDetailListWithPipe(path=D:\data, out_dsn=data_list)           |
|               %GetFolderDetailListWithPipe(path=D:\data\*.xls, out_dsn=list)          |
-----------------------------------------------------------------------------------------;

%macro GetFolderDetailListWithPipe(path=/*The full path of specific directory.*/,
                                   out_dsn=/*The name of out data set.*/);
    options datestyle=mdy;
    filename list pipe "dir ""&path"" ";
    data &out_dsn;
        infile list truncover firstobs=6;
        input;
        length item_name $ 100 item_type $ 10 item_size 8 item_last_modify_date 8 temp $ 20;
        label item_name="Name" item_type="Type" item_size="Size(Bytes)"
            item_last_modify_date="Last Modify Date";
        format item_size comma15. item_last_modify_date datetime19.;
        if strip(substr(_infile_, 1, 10)) ne "" then do;
            item_name=strip(substr(_infile_, 37));
            temp=strip(substr(_infile_, 20, 16));
            if temp="<DIR>" then do;
                item_type="FOLDER";
                item_size=.;
            end;
            else do;
                item_type="FILE";
                item_size=input(temp, comma15.);
            end;
            item_last_modify_date=input(substr(_infile_,1,17),anydtdtm17.);
            if compress(item_name, ".") ne "" then output;
        end;
        
        drop temp;
    run;
%mend GetFolderDetailListWithPipe;

/*---------------Examples---------------*/
%GetFolderDetailListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.detaillist_pipe1)
%GetFolderDetailListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4\*.exe, out_dsn=work.detaillist_pipe2)
