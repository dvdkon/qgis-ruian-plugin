#!/bin/sh -x

TMP=/tmp
DIR=$TMP/qgis-ruian-plugin

# prepare dir for publishing
rm -rf $DIR
mkdir $DIR

# copy content
cp -ra . $DIR

# GDAL_-VFER
rm -rf $DIR/gdal_vfr
# get version
gdal_vfr_version=`grep "gdal_vfr_version = " MainApp.py | cut -d'=' -f2 | sed -E 's/^[ \t]'\''(.*)'\''/\1/g'`
cd $DIR
wget https://github.com/ctu-geoforall-lab/gdal-vfr/archive/v$gdal_vfr_version.zip
unzip v$gdal_vfr_version.zip
mv gdal-vfr-$gdal_vfr_version gdal_vfr
rm v$gdal_vfr_version.zip

# clean-up
rm -rf .git *~ publish.sh __pycache__
find . -name "*.pyc" -exec rm -f {} \;

# packaging
cd ..
rm qgis-ruian-plugin.zip
zip qgis-ruian-plugin.zip qgis-ruian-plugin -r


exit 0
