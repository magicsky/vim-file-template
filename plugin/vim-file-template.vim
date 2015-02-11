" vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix
" 当前文件本身
let s:selfFilePath = expand('<sfile>:p')
python << EOF
import os
import vim
selfFilePath = os.path.realpath(vim.eval("s:selfFilePath"))
selfDirPath = os.path.dirname(selfFilePath)
vim.command("source " + os.path.join(selfDirPath, "cpp-template.vim"))
EOF


