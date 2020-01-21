export JAVA_HOME=$JDK_HOME

rm -rf /tmp/ban*
mkdir -p /tmp/ban

echo Plain javac

time $JAVA_HOME/bin/javac -cp $JAVA_HOME/lib/tools.jar -implicit:none -XDignore.symbol.file=true \
-d /tmp/ban \
src/com/sun/tools/sjavac/*.java \
src/com/sun/tools/sjavac/*/*.java

rm -rf /tmp/bon*
mkdir -p /tmp/bon

echo With Smart Javac Wrapper

JAR=$(dirname $0)/sjavac.jar
SRC=$(dirname $0)/src

$JAVA_HOME/bin/java -ea -classpath $JAVA_HOME/lib/tools.jar:$JAR com.sun.tools.sjavac.Main \
-src $SRC \
-d /tmp/bon \
--server:portfile=/tmp/bon/sjavac,sjavac=$JAVA_HOME/bin/java%20-ea%20-classpath%20$JAVA_HOME/lib/tools.jar:$JAR%20com.sun.tools.sjavac.Main

diff -rq /tmp/ban /tmp/bon
