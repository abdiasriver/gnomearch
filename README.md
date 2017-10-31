# gnomearch
instalacion de xorg y gnome

descarga con git

git clone git://github.com/abdiasriver/gnomearch

o con wget

wget https://github.com/abdiasriver/gnomearch/tarball/master -O -| tar xz



da permisos de ejecucion a los archivos con


cd gnomearch

chmod +x *

ejecuta con

1.- seleccionar el mejor mirror

./1-mirror.sh

2.-instalar packer

./2-packer.sh

3.- instalar xorg

./3-xorg.sh

4.- instalar gnome

./4-gnome.sh

5.- instalar core

./5-core.sh


sudo reboot
