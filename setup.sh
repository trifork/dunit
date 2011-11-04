#/bin/sh

DEPS="dlib|git@github.com:trifork/dlib.git"

if [ ! -d deps ]; then
    mkdir deps
fi

cd deps

for DEPANDURL in $DEPS; do

  DEP=`echo $DEPANDURL | awk '-F|' '{print $1}'`
  URL=`echo $DEPANDURL | awk '-F|' '{print $2}'`

  if [ ! -d $DEP ]; then
      git clone $URL $DEP
  else
      (cd $DEP; git pull)
  fi

  if [ -d ../$DEP ]; then
      chmod -R +w  ../$DEP
      rm -Rf ../$DEP
  fi

  if [ -d $DEP/src ]; then
      cp -R $DEP/src ../$DEP
      chmod -R a-w  ../$DEP
  fi

  if [ -f $DEP/setup.sh ]; then
      (cd ..; /bin/sh deps/$DEP/setup.sh)
  fi

done
