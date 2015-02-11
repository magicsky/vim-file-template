" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix
" 当前文件本身
let s:selfFilePath = expand('<sfile>:p')
python << EOF
import os
import vim
selfFilePath = os.path.realpath(vim.eval("s:selfFilePath"))
selfDirPath = os.path.dirname(selfFilePath)
templateDefines = [
    os.path.join(selfDirPath, "bash-template.vim"),
    os.path.join(selfDirPath, "cpp-template.vim"),
    os.path.join(selfDirPath, "python-template.vim"),
    os.path.join(selfDirPath, "yaml-template.vim"),
]
for templateDefine in templateDefines:
    vim.command("source " + templateDefine)

EOF


