*---------------------------------------------------------------------------------
| Name:         GetFolderListWithSASFunction.sas                                 |
| Description:  Get a list of file and folder name of specific folder with SAS   |
|               function.                                                        |
| Author:       Slash.Xin                                                        |
| Usage:        %GetFolderListWithSASFunction(path=, out_dsn=)                   |
| Example:      %GetFolderListWithSASFunction(path=D:\data, out_dsn=data_list)   |
---------------------------------------------------------------------------------;

%macro GetFolderListWithSASFunction(path=, /*The full path of specific folder.*/
                                    out_dsn=/*The name of out data set.*/);
    data &out_dsn;
        rc=filename("list", "&path");
        length item_name $ 100;
        did=dopen("list");
        if did gt 0 then do;
            mem_cnt=dnum(did);
            do i=1 to mem_cnt;
                item_name=dread(did, i);
                output;
            end;
            rc=dclose(did);
        end;
        keep item_name;
    run;
%mend GetFolderListWithSASFunction;

%GetFolderListWithSASFunction(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.list_sasfunc)
