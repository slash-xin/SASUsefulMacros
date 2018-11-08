*---------------------------------------------------------------------------------
| Name:         GetFolderListWithSASFunc.sas                                 |
| Description:  Get a list of file and folder name of specific folder with SAS   |
|               function.                                                        |
| Author:       Slash.Xin                                                        |
| Usage:        %GetFolderListWithSASFunc(path=, out_dsn=)                   |
| Example:      %GetFolderListWithSASFunc(path=D:\data, out_dsn=data_list)   |
---------------------------------------------------------------------------------;

%macro GetFolderListWithSASFunc(path=, /*The full path of specific folder.*/
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
%mend GetFolderListWithSASFunc;

%GetFolderListWithSASFunc(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.list_sasfunc)
