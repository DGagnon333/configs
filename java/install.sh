#!/bin/bash

# Source the env.sh to set the environment variables
source ./env.sh

# Function to install Java
install_java() {
  echo "Installing Java version ${JAVA_VERSION}..."

  # Install OpenJDK 11 using Homebrew
  brew install openjdk@${JAVA_VERSION}

  # Link OpenJDK so it is available in the system PATH
  sudo ln -sfn /opt/homebrew/opt/openjdk@${JAVA_VERSION}/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-${JAVA_VERSION}.jdk

  # Set JAVA_HOME environment variable in the shell config
  echo "export JAVA_HOME=${JAVA_HOME}" >> ~/.zshrc
  echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.zshrc

  # Reload shell configuration
  source ~/.zshrc
  echo "Java installation complete!"
}

# Function to install Maven
install_maven() {
  echo "Installing Maven..."

  # Install Maven using Homebrew
  brew install maven

  # Verify Maven installation
  mvn -v

  echo "Maven installation complete!"
}

# Install Java
install_java

# Install Maven
install_maven

# Verify Java and Maven installations
echo "Verifying installations..."
java -version
mvn -v

echo "Java and Maven installation completed successfully!"

