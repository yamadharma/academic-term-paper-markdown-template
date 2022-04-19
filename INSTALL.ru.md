# Установка необходимого программного обеспечения

## Установка `pandoc`

### Установка для Windows

Для установки используйте [Chocolatey](https://chocolatey.org/)

- Установите `pandoc`

``` powershell
choco install pandoc
```

- Установите `python` для фильтров

``` powershell
choco install python
```

### Установка для Ubuntu

- Скачайте с сайта <https://github.com/jgm/pandoc/releases> необходимую версию `pandoc` `pandoc-<version>-amd64.deb`.
- Установите `pandoc`

``` bash
sudo dpkg -i pandoc-<version>-amd64.deb
```


## Фильтры для `pandoc`

- `pip3 install -U pandoc-mustache --user`
- `pip3 install -U pantable --user`

### Дополнительные фильтры, которые Вы можете использовать

- `pip3 install -U pandoc-include --user`


<!--
Local Variables:
mode: gfm
coding: utf-8
markdown-enable-math: t
End:
-->
