" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix
" 当前文件本身
let s:selfFilePath = expand('<sfile>:p')

function! g:LoadCppFileTemplate()
python << EOF
import os
import tempfile
import vim
selfFilePath = os.path.realpath(vim.eval("s:selfFilePath"))
selfDirPath = os.path.dirname(selfFilePath)
selfRootPath = os.path.dirname(selfDirPath)
libPath = os.path.join(selfRootPath, "lib")
sys.path.insert(0, os.path.join(libPath, "pylibs.zip" ))

from mako.template import Template
import yaml

def findProjectSetting(root):
	if os.path.dirname(root) is root:
		return None
	target = os.path.join(root, ".project.yaml")
	if os.path.exists(target):
		return root
	else:
		return findProjectSetting(os.path.dirname(root))

def isHeader(filePath):
	extName = os.path.splitext(filePath)[1]
	return extName.lower() in [".h", ".hh", ".hpp"]

# 当前文件的路径
filePath = os.path.realpath(vim.eval("expand('%:p')"))
fileName = os.path.basename(filePath)
rootPath = findProjectSetting(os.path.dirname(filePath))

# 项目名称
projectName = os.path.basename(os.path.dirname(filePath))
# 作者
author = os.environ["USER"]
# 作者email
authorEmail = None
try:
    authorEmail = vim.eval("g:authorEmail")
except Exception:
    pass

if rootPath is not None and os.path.exists(rootPath):
	config = yaml.load(open(os.path.join(rootPath, ".project.yaml")).read())
	projectName = config.get("name", projectName)
	author = config.get("author", author)
	authorEmail = config.get("authorEmail", authorEmail)

headerTemplateFile = os.path.join(selfRootPath, "templates", "cpp-header.mako")
sourceTemplateFile = os.path.join(selfRootPath, "templates", "cpp-source.mako")
templateFile = isHeader(fileName) and headerTemplateFile or sourceTemplateFile
templateContent = open(templateFile, "r").read()
renderContent = Template(templateContent).render(fileName=fileName, author=author, authorEmail=authorEmail, projectName=projectName, filePath=filePath)
renderContent = renderContent.lstrip("\n")

tempFile = tempfile.NamedTemporaryFile(delete=False)
tempFile.write(renderContent)
tempFile.close()
vim.command("0r " + tempFile.name)
vim.command(str(len(renderContent.split("\n"))))
os.unlink(tempFile.name)

EOF
endfunction

if has("autocmd")
	autocmd BufNewFile *.h call g:LoadCppFileTemplate() 
	autocmd BufNewFile *.hh call g:LoadCppFileTemplate() 
	autocmd BufNewFile *.hpp call g:LoadCppFileTemplate() 
	autocmd BufNewFile *.c call g:LoadCppFileTemplate() 
	autocmd BufNewFile *.cc call g:LoadCppFileTemplate() 
	autocmd BufNewFile *.cpp call g:LoadCppFileTemplate() 
endif
