#!/bin/sh

if [ -f run.sh ]; then
  rm run.sh
fi

if [ ! -d temp ]; then
  mkdir temp
fi

touch run.sh

pieces=( dind-1.sh dind-2.sh dind-3.sh dind-4.sh dind-5.sh )

for i in "${pieces[@]}"
do
  wget -P temp/ https://bashing.oss-cn-hangzhou.aliyuncs.com/dind/$i
  cat temp/$i >> run.sh
  rm temp/$i
done

bash run.sh
rm run.sh
