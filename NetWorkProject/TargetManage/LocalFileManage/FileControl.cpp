//
//  FileControl.cpp
//  JinYinLand
//
//  Created by Zlm on 14-12-29.
//
//

#include "FileControl.h"
#include <dirent.h>
#include <sys/stat.h>
#include <iostream>
#include <fstream>
FileControl* FileControl::getInstance()
{
    static FileControl* shared = NULL;
    if (shared == NULL)
    {
        shared = new FileControl();
    }
    return shared;
}

//获取指定目录下所有文件名
std::vector<string> FileControl::FindAllFile(string folderPath)
{
    std::vector<string> allSubFile;
    allSubFile.clear();
//    CCLOG("%s",folderPath.c_str());
    return FileControl::getInstance()->FindSubFile(folderPath, allSubFile);
}
bool FileControl::removeFilePathWithSubFile(string folderPath)
{
    std::vector<string> allSubFile = FileControl::FindAllFile(folderPath);
    char buf[1024*2] = {};
    for (int i = 0; i<allSubFile.size(); i++)
    {
        snprintf(buf, 2*1024, "%s/%s",folderPath.c_str(),allSubFile[i].c_str());
        int isOk = remove(buf);
//        CCLOG("%s",buf);
//        CCLOG("removeFile:%d",isOk);
    }
    
    
    return true;
}
bool FileControl::removeFilePath(string filePath)
{
//    CCLOG("%s",filePath.c_str());
    int isOk = remove(filePath.c_str());
    return isOk;
}

std::vector<string> FileControl::FindSubFile(string folderPath,std::vector<string> subFile)
{
    std::vector<string>allSubFile = subFile;
//    CCLOG("%s",folderPath.c_str());
    DIR *dp;
    struct dirent* dirp;
    
    if((dp = opendir(folderPath.c_str())) == NULL)
    {
//        CCLOG("can not match the folder path");
        return allSubFile;
    }
    while ((dirp=readdir(dp))!=NULL)
    {
        struct stat buf;
        stat(folderPath.c_str(), &buf);
        
        // 如果是目录
        if (S_ISDIR(buf.st_mode))
        {
            string path;
            if( (strcmp(dirp->d_name,".") != 0 ) &&(strcmp(dirp->d_name,"..") != 0))
            {
                path =  folderPath + "/" + dirp->d_name;
                allSubFile.push_back(dirp->d_name);
            }
            //如果是目录，递归调用
            FindSubFile(path,allSubFile);
        }
        else
        {
            
            // 如果是文件直接打印
//            CCLOG("%s/%s\n",folderPath.c_str(),dirp->d_name);
            
            allSubFile.push_back(dirp->d_name);
            
        }
    }
//    CCLOG("\n");
    closedir(dp);
    return allSubFile;
}


const char* FileControl::getFileToMemory(string filePath)
{
    filebuf *pbuf;
    ifstream filestr;
    long size;
    char * buffer;
    filestr.open(filePath, ios::binary);
    
    // 获取filestr对应buffer对象的指针
    pbuf=filestr.rdbuf();
    
    // 调用buffer对象方法获取文件大小
    size=pbuf->pubseekoff (0,ios::end,ios::in);
    pbuf->pubseekpos (0,ios::in);
    
    // 分配内存空间
    buffer=new char[size];
    
    // 获取文件内容
    pbuf->sgetn (buffer,size);
    
    filestr.close();
    // 输出到标准输出
    //        cout.write (buffer,size);
    //        CCLOG("%s",buffer);
//    const char* ss = buffer;
//    cout.write (ss,size);
    //    delete []buffer;
    return buffer;
}
//std::string FileControl::getLocalPath(string name)
//{
//    return FileUtils::getInstance()->getWritablePath().c_str();
//}
bool FileControl::writeFile(string readFile,string writeFile)
{
    const char* getMemory = getFileToMemory(readFile);
    FILE *pfile = fopen(readFile.c_str(), "wb+");
    if (pfile != NULL)
    {
        fseek (pfile, 0, SEEK_END);   ///将文件指针移动文件结尾
        long size = ftell (pfile); ///求出当前文件指针距离文件开始的字节数
        printf ("Size of file.cpp: %ld bytes.\n",size);
        FILE *rfile = fopen(writeFile.c_str(), "wb+");
        if (rfile != NULL)
        {
            fwrite(getMemory, size,1,  rfile);
        }
        fclose(rfile);
    }
    fclose (pfile);
    return true;
}
//bool FileControl::createDirectory(const char *path)
//{
//    
//#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
//    
//    int ret = mkdir(path, S_IRWXU | S_IRWXG | S_IRWXO);
//    
//    if (ret != 0 && (errno != EEXIST))
//        
//    {
//        return false;
//    }
//    return true;
//#else
//    
//    bool ret = CreateDirectoryA(path, NULL);
//    
//    if (!ret && ERROR_ALREADY_EXISTS != GetLastError())
//    {
//        return false;
//    }
//    return true;
//    
//#endif
//    
//}


