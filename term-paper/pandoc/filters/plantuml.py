#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "plantuml" into
plant-generated images.

Needs `plantuml.jar` from http://plantuml.com/.
"""

import os
import sys
from subprocess import call

from pandocfilters import toJSONFilter, Para, Image, get_filename4code, get_caption, get_extension


def plantuml(key, value, format, _):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value

        plantuml_jar = os.environ.get('PLANTUML', 'plantuml.jar')
        
        if "plantuml" in classes:
            caption, typef, keyvals = get_caption(keyvals)

            filename = get_filename4code("plantuml", code)
            filetype = get_extension(format, "png", html="svg", latex="eps")

            src = filename + '.uml'
            dest = filename + '.' + filetype

            if not os.path.isfile(dest):
                if not code.startswith("@start"):
                    code = "@startuml\n" + code + "\n@enduml\n"
                with open(src, "w") as f:
                    f.write(code)

                call(["java", "-jar", plantuml_jar, "-t"+filetype, src])
                sys.stderr.write('Created image ' + dest + '\n')

            return Para([Image([ident, [], keyvals], caption, [dest, typef])])

if __name__ == "__main__":
    toJSONFilter(plantuml)
