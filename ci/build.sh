#!/bin/bash
set -ev

echo "Download und extract sourcemod"
wget "http://www.sourcemod.net/latest.php?version=$1&os=linux" -O sourcemod.tar.gz
tar -xzf sourcemod.tar.gz

echo "Give compiler rights for compile"
chmod +x addons/sourcemod/scripting/spcomp


addons/sourcemod/scripting/compile.sh plugin.sp

echo "Remove plugins folder if exists"
if [ -d "addons/sourcemod/plugins" ]; then
  rm -r addons/sourcemod/plugins
fi

echo "Create clean plugins folder"
mkdir addons/sourcemod/plugins
mv addons/sourcemod/scripting/compiled/plugin.smx addons/sourcemod/plugins

echo "Delete sourcemod folders"
cd addons/sourcemod/
shopt -s extglob
rm -rf !(plugins)
cd ..
rm -rf metamod
cd ..

echo "Compress the plugin"
zip -9rq plugin.zip addons

echo "Build done"