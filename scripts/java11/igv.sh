#!/bin/sh

#This script is intended for launch on *nix machines

#-Xmx4g indicates 4 gb of memory, adjust number up or down as needed
#Script must be in the same directory as igv.jar
#Add the flag -Ddevelopment = true to use features still in development
#Add the flag -Dsun.java2d.uiScale=2 for HiDPI displays
prefix=`dirname $(readlink $0 || echo $0)`

# Check whether or not to use the bundled JDK
if [ -d "${prefix}/jdk-11" ]; then
    echo echo "Using bundled JDK."
    JAVA_HOME="${prefix}/jdk-11"
    PATH=$JAVA_HOME/bin:$PATH
else
    echo "Bundled JDK not found.  Using system JDK."
fi

exec java --module-path="${prefix}/lib" -Xmx4g \
    @"${prefix}/igv.args" \
    -Dapple.laf.useScreenMenuBar=true \
    -Djava.net.preferIPv4Stack=true \
    --module=org.igv/org.broad.igv.ui.Main "$@"
