#!/bin/bash
MODULENAME=jquery-file-download
CWD=`pwd`
PUBLISHDIR=${CWD}/publish
VERSION="1.4.3"
URL="http:\/\/jqueryfiledownload.apphb.com\/"
bower install $MODULENAME#$VERSION 
sed -e s/\(jQuery/\(require\(\"jquery\"\)/g \
  bower_components/$MODULENAME/src/Scripts/jquery.fileDownload.js > $MODULENAME.js
rm -rf bower_components

echo $VERSION
for var in README.md kanso.json
do
  sed -e s/@VERSION@/$VERSION/g \
      -e s/@MODULENAME@/$MODULENAME/g \
      -e s/@URL@/$URL/g \
             $var.in > $var 
done
rm -rf ${PUBLISHDIR}
mkdir ${PUBLISHDIR} 
cp README.md kanso.json $MODULENAME.js ${PUBLISHDIR} 
cd ${PUBLISHDIR}
kanso publish
cd ${CWD} 
rm -rf ${PUBLISHDIR} 

