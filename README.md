# vim-file-template
提供文件默认的模板格式

<script type="text/javascript" src="https://asciinema.org/a/16281.js" id="asciicast-16281" async></script>

比如新建一个C的头文件时，会默认生成如下代码：
```cpp
/**
 * @file c.h
 * @brief
 * @author wul (garcia.wul@alibaba-inc.com)
 * @date 2015-02-11 11:51
 *
 */

#ifndef __TEST_C_H__
#define __TEST_C_H__

#endif

// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4 fileencoding=utf-8 ff=unix ft=cpp
```

## 安装
```
Bundle 'magicsky/vim-file-template'
```

### 为项目准备一个.project.yaml文件
默认会读取`.vimrc`中的`g:author`和`g:authorEmail`信息作为`author`和`email`信息。你可以在项目根目录下，准备一个`.project.yaml`文件来自定义:
```yaml
name: test
author: wuliang
authorEmail: garcia.wul@alibaba-inc.com
```

