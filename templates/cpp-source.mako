<%!
import os
import time
def getHeaderName(fileName, filePath):
	baseName = os.path.splitext(filePath)[0]
	if os.path.exists(baseName + ".h"):
		return os.path.splitext(fileName)[0] + ".h"
	elif os.path.exists(baseName + ".hh"):
		return os.path.splitext(fileName)[0] + ".hh"
	elif os.path.exists(baseName + ".hpp"):
		return os.path.splitext(fileName)[0] + ".hpp"
	return None 
%>
/**
 * @file ${fileName}
 * @brief
 * @author ${author} ${authorEmail is not None and "(" + str(authorEmail) + ")" or ""}
 * @date ${time.strftime("%Y-%m-%d %H:%M", time.localtime())} 
 *
 */

% if getHeaderName(fileName, filePath) is not None:
#include "${getHeaderName(fileName, filePath)}"
% endif


// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix ft=cpp

