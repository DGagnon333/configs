# env.sh
# Set desired Java version
#export JAVA_VERSION="11.0.26"
export JAVA_VERSION="21"

# Set JAVA_HOME path
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-${JAVA_VERSION}.jdk/Contents/Home"

# Update PATH to include JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH
