#!/bin/bash
set -ev

echo "Download und extract sourcemod"
wget "http://www.sourcemod.net/latest.php?version=$1&os=linux" -O sourcemod.tar.gz
tar -xzf sourcemod.tar.gz

echo "Give compiler rights for compile"
chmod +x addons/sourcemod/scripting/spcomp

echo "Compile MyJailbreak plugins"
for file in addons/sourcemod/scripting/*.sp
do
echo "Compile $file"
  addons/sourcemod/scripting/spcomp -E -v0 $file
done

echo "Remove plugins folder if exists"
if [ -d "addons/sourcemod/plugins" ]; then
  rm -r addons/sourcemod/plugins
fi

echo "Create clean plugins folder"
mkdir addons/sourcemod/plugins

echo "Remove build folder if exists"
if [ -d "build" ]; then
  rm -r build
fi

echo "Clean root folder"
rm sourcemod.tar.gz
rm translations.zip



echo "Build done"