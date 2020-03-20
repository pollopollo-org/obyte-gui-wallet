if [[ -z "${NW_VERSION}" ]]; then
  NW_VERSION="0.33.4"
fi
cd ..
rm -rf node_modules
bower install
npm_config_target=${NW_VERSION} npm_config_arch=x64 npm_config_target_arch=x64 npm_config_runtime=node-webkit npm_config_build_from_source=true npm_config_node_gyp=$(which nw-gyp) npm install
grunt
grunt desktop --nw=${NW_VERSION}
grunt copy:linux
cd appimage
rm -rf ../../obytebuilds/Obyte/linux64/nodes_modules/grunt*
rm -rf ../../obytebuilds/Obyte/linux64/nodes_modules/innosetup-compiler
rm -rf ../../obytebuilds/Obyte/linux64/nodes_modules/@babel
rm -rf obyte
rm pkg2appimage
wget https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage
ARCH=x86_64 NO_GLIBC_VERSION=1 bash -ex ./pkg2appimage obyte.yml
mv ./out/obyte--x86_64.AppImage ../../obytebuilds/obyte-${NW_VERSION}-x86_64.AppImage