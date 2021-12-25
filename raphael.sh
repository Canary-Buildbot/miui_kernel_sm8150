starttime=`date +'%Y-%m-%d %H:%M:%S'`

git submodule update --init --recursive
export PATH=/home/lu/clang/bin:${PATH}
make O=out ARCH=arm64 raphael_defconfig -j$(nproc --all) LLVM=1
make LLVM=1 -j$(nproc --all) O=out \ARCH=arm64 \CC=/home/lu/clang/bin/clang \
	DTC_EXT=dtc \
	CROSS_COMPILE=/home/lu/clang/bin/aarch64-linux-gnu- \
	CROSS_COMPILE_ARM32=/home/lu/clang/bin/arm-linux-gnueabi- \
	CROSS_COMPILE_COMPAT=/home/lu/clang/bin/arm-linux-gnueabi- \
	OBJCOPY=/home/lu/clang/bin/llvm-objcopy \
	OBJDUMP=/home/lu/clang/bin/llvm-objdump \
	STRIP=/home/lu/clang/bin/llvm-strip \
	NM=/home/lu/clang/bin/llvm-nm \
	AR=/home/lu/clang/bin/llvm-ar 2>&1 | tee kernel.log\

endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo 开始时间：$starttime
echo 结束时间：$endtime
echo "本次Kernel编译用时： "$((end_seconds-start_seconds))"s"
