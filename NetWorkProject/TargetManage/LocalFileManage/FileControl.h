//
//  FileControl.h
//  JinYinLand
//
//  Created by Zlm on 14-12-29.
//  文件管理
//

#ifndef __JinYinLand__FileControl__
#define __JinYinLand__FileControl__

#include <stdio.h>
#include <string>
//#include "cocos2d.h"
#include <sys/stat.h>//创建文件夹
//USING_NS_CC;
#include <vector>
using namespace std;
class FileControl
{
public:
//    获取指定目录下所有文件
    static std::vector<string> FindAllFile(string folderPath);
//    清除指定目录下所有文件
    static bool removeFilePathWithSubFile(string folderPath);
    //清除指定文件
    static bool removeFilePath(string filePath);
    
    
    static const char * getFileToMemory(string filePath);
    //获得可写入路径
//    static std::string getLocalPath(string name);
    //创建文件夹
//    static bool createDirectory(const char *path);
    //写入文件
    static bool writeFile(string readFile,string writeFile);
public:
    static FileControl* getInstance();
    std::vector<string> FindSubFile(string folderPath,std::vector<string> subFile);
    
    
};

#endif /* defined(__JinYinLand__FileControl__) */
