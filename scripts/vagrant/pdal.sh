NUMTHREADS=2
if [[ -f /sys/devices/system/cpu/online ]]; then
	# Calculates 1.5 times physical threads
	NUMTHREADS=$(( ( $(cut -f 2 -d '-' /sys/devices/system/cpu/online) + 1 ) * 15 / 10  ))
fi
#NUMTHREADS=1 # disable MP
export NUMTHREADS

git clone https://github.com/PDAL/PDAL.git pdal
cd pdal
git checkout b9b960a56ead0e997e0e715bf903714e2496d4be
cmake   -G "Unix Makefiles" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DWITH_ICONV=ON \
        -DWITH_GEOTIFF=ON \
        -DWITH_LASZIP=ON \
        -DWITH_LIBXML2=ON \
        -DWITH_PYTHON=ON \
        -DWITH_TESTS=OFF

make -j $NUMTHREADS
sudo make install

