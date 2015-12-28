" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix
" 当前文件本身
let s:selfFilePath = expand('<sfile>:p')

function! g:LoadProtobufFileTemplate()
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

# 当前文件的路径
filePath = os.path.realpath(vim.eval("expand('%:p')"))
fileName = os.path.basename(filePath)
rootPath = findProjectSetting(os.path.dirname(filePath))

# 项目名称
projectName = os.path.basename(os.path.dirname(filePath))
# 作者
author = os.environ["USER"]
try:
    author = vim.eval("g:author")
except Exception:
    pass
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

templateFile = os.path.join(selfRootPath, "templates", "protobuf.mako")
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
	autocmd BufNewFile *.proto call g:LoadProtobufFileTemplate()
endif
