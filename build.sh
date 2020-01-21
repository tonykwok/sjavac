export JAVA_HOME=$JDK_HOME

echo Compiling
rm -rf /tmp/bin/*
mkdir -p /tmp/bin 
$JAVA_HOME/bin/javac -cp $JAVA_HOME/lib/tools.jar -implicit:none -XDignore.symbol.file=true \
-d /tmp/bin \
src/com/sun/tools/sjavac/*.java \
src/com/sun/tools/sjavac/*/*.java

echo Creating jar
rm -f sjavac.jar
(cd /tmp/bin; find . -type f > ../files; jar cf sjavac.jar @../files; rm ../files)
mv /tmp/bin/sjavac.jar .

