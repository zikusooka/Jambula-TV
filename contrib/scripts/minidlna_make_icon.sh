#!/bin/bash
#
# Generate a free icons.c for minidlna from Debian's SVG logo
#
# Copyright (C) 2011 Benoît Knecht <benoit.knecht@fsfe.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the University nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# Usage: ./make_icons.sh ${debian_svg_logo} > icons.c
#
#        where ${debian_svg_logo} is the name of the SVG logo you want to
#        convert. Currently, the Debian SVG logo without the "Debian" text can
#        be obtained with:
#
#        wget http://www.debian.org/logos/openlogo-nd.svg
#
#        You'll need to have inkscape and imagemagick installed for this script
#        to work.

svg="${1}"
png="$(mktemp)"
jpg="$(mktemp)"

cat <<EOF
/* Debian Open Use Logo
 *
 * The Debian logo can be obtained in various formats from
 *
 *     http://www.debian.org/logos/
 *
 * and is licensed under the following terms:
 *
 *   Copyright (c) 1999 Software in the Public Interest
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a
 *   copy of this software and associated documentation files (the "Software"),
 *   to deal in the Software without restriction, including without limitation
 *   the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *   and/or sell copies of the Software, and to permit persons to whom the
 *   Software is furnished to do so, subject to the following conditions:
 *
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *   DEALINGS IN THE SOFTWARE.
 */
EOF

# inkscape -e "${png}" -h 48 "${svg}" > /dev/null
convert "${svg}" -scale 48x48 "${png}"
mogrify -gravity center -extent 48x48 -background none "${png}"
convert "${png}" -background white -flatten jpg:"${jpg}"
echo ''
echo '/* Small Debian PNG logo (without "Debian") */'
echo 'unsigned char'
xxd -p -c 24 "${png}" | sed -e '    s/../\\x&/g' \
                            -e '1   s/^/png_sm\[\] =   "/' \
                            -e '1 ! s/^/             "/' \
                            -e '    s/$/"/' \
                            -e '$   s/$/;/'

#inkscape -e "${png}" -h 120 "${svg}" > /dev/null
convert "${svg}" -scale 120x120 "${png}"
mogrify -gravity center -extent 120x120 -background none "${png}"
echo ''
echo '/* Large Debian PNG logo (without "Debian") */'
echo 'unsigned char'
xxd -p -c 24 "${png}" | sed -e '    s/../\\x&/g' \
                            -e '1   s/^/png_lrg\[\] =  "/' \
                            -e '1 ! s/^/             "/' \
                            -e '    s/$/"/' \
                            -e '$   s/$/;/'

echo ''
echo '/* Small Debian JPEG logo (without "Debian") */'
echo 'unsigned char'
xxd -p -c 24 "${jpg}" | sed -e '    s/../\\x&/g' \
                            -e '1   s/^/jpeg_sm\[\] =  "/' \
                            -e '1 ! s/^/             "/' \
                            -e '    s/$/"/' \
                            -e '$   s/$/;/'

convert "${png}" -background white -flatten jpg:"${jpg}"
echo ''
echo '/* Large Debian JPEG logo (without "Debian") */'
echo 'unsigned char'
xxd -p -c 24 "${jpg}" | sed -e '    s/../\\x&/g' \
                            -e '1   s/^/jpeg_lrg\[\] = "/' \
                            -e '1 ! s/^/             "/' \
                            -e '    s/$/"/' \
                            -e '$   s/$/;/'

rm -f "${png}" "${jpg}"