<%!
import os
import time
import re
import string

def normalizeWords(words):
	return "".join(map(lambda x: (x in string.printable[:62]) and x or "_", \
		re.sub(r"([A-Z])", r" \1", words)))

def createDefineName(projectName, fileName):
	newFileName = fileName.rstrip(os.path.splitext(fileName)[1])
	return "__" + normalizeWords(projectName).upper() + "_" + \
		normalizeWords(newFileName).upper() + \
		"_H__"
%>
/**
 * @file ${fileName}
 * @brief
 * @author ${author} ${authorEmail is not None and "(" + str(authorEmail) + ")" or ""}
 * @date ${time.strftime("%Y-%m-%d %H:%M", time.localtime())} 
 *
 */

#ifndef ${createDefineName(projectName, fileName)}
#define ${createDefineName(projectName, fileName)}

#endif 



// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix ft=cpp
