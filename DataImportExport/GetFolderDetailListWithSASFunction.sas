*-----------------------------------------------------------------------------------
| Name:         GetFolderDetailListWithSASFunc.sas                                 |
| Description:  Get a detail list of file and folder infor of specific folder.     |
|               This detail list contains the ITEM_NAME, ITEM_TYPE(file or         |
|               folder), ITEM_SIZE, ITEM_CREATE_DATE, ITEM_LAST_MODIFY_DATE.       |
| Author:       Slash.Xin                                                          |
| Usage:        %GetFolderDetailListWithSASFunc(path=, out_dsn=)                   |
| Example:      %GetFolderDetailListWithSASFunc(path=D:\data, out_dsn=data_list)   |
| Note:         This macro can only run on the Windows platform.                   |
------------------------------------------------------------------------------------;

%macro GetFolderDetailListWithSASFunc(path=, /*The full path of specific folder.*/
                                    out_dsn=/*The name of out data set.*/);
    data &out_dsn;
        rc=filename("list", "&path");
        length item_name $ 100 item_type $ 10 item_size 8 item_create_date 8 item_last_modify_date 8;
        label item_name="Name" item_type="Type" item_size="Size(Bytes)" item_create_date="Create Date"
            item_last_modify_date="Last Modify Date";
        format item_size comma15. item_create_date item_last_modify_date datetime19.;
        did=dopen("list");
        if did gt 0 then do;
            mem_cnt=dnum(did);
            do i=1 to mem_cnt;
                call missing(item_name, item_type, item_size, item_create_date, item_last_modify_date);
                item_name=dread(did, i);
                rc2=filename("file", cats("&path\",item_name));
                fid=fopen("file");
                if fid gt 0 then do;
                    item_type="FILE";
                    infoname=foptname(fid, 4);
                    item_size=input(finfo(fid, infoname), best12.);
                    infoname=foptname(fid, 5);
                    item_last_modify_date=input(finfo(fid, infoname), nldatm.);
                    infoname=foptname(fid, 6);
                    item_create_date=input(finfo(fid, infoname), nldatm.);
                    rc2=fclose(fid);
                end;
                else do;
                    item_type="FOLDER";
                end;
                output;
            end;
            rc=dclose(did);
        end;
        keep item_name item_type item_size item_create_date item_last_modify_date;
    run;
%mend GetFolderDetailListWithSASFunc;

%GetFolderDetailListWithSASFunc(path=D:\Program Files\SASHome\SASFoundation\9.4\, out_dsn=work.detaillist_sasfunc)

