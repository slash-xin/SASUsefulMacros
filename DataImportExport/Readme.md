# 1. GetFolderDetailListWithPipe.sas

This macro can retrieve the detail list of files and folders under a directory through the unnamed pipe. The output data set contains 5 column. Here is an example:

%GetFolderDetailListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4, out_dsn=work.detaillist_pipe1)

![Dataset: work.detaillist_pipe1](images/001.png)

%GetFolderDetailListWithPipe(path=D:\Program Files\SASHome\SASFoundation\9.4\*.exe, out_dsn=work.detaillist_pipe2)

![Dataset: work.detaillist_pipe2](images/002.png)



The first argument **PATH** can be:

- full path of a directory
- full path with wildcards of a directory

