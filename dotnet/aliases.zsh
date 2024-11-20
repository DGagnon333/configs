# General .NET commands
alias dn='dotnet'
alias dnver='dotnet --version'                       # Check the installed .NET SDK version
alias dninfo='dotnet --info'                         # Display information about the .NET SDK
alias dnnew='dotnet new'                             # Create a new .NET project
alias dnrestore='dotnet restore'                     # Restore project dependencies
alias dnbuild='dotnet build'                         # Build the project
alias dnpub='dotnet publish'                         # Publish the project
alias dnrun='dotnet run'                             # Run the project
alias dntest='dotnet test'                           # Run unit tests
alias dnclean='dotnet clean'                         # Clean the project

# Package management
alias dnaddpkg='dotnet add package'                  # Add a NuGet package
alias dnrempkg='dotnet remove package'               # Remove a NuGet package
alias dnlistpkg='dotnet list package'                # List NuGet packages for the project

# Tool management
alias dninstall='dotnet tool install'                # Install a .NET global/local tool
alias dnupdate='dotnet tool update'                  # Update a .NET tool
alias dnuninstall='dotnet tool uninstall'            # Uninstall a .NET tool
alias dnglobal='dotnet tool install --global'        # Install a global .NET tool

# Solution and project management
alias dnsl='dotnet sln'                              # Manage solution files
alias dnsladd='dotnet sln add'                       # Add a project to the solution
alias dnslrem='dotnet sln remove'                    # Remove a project from the solution
alias dnprojadd='dotnet add reference'               # Add a project reference
alias dnprojrem='dotnet remove reference'            # Remove a project reference

# Debugging and analysis
alias dnwatch='dotnet watch'                         # Watch for file changes and auto-run commands
alias dnprofile='dotnet trace collect'               # Collect a performance trace
alias dnreport='dotnet trace convert'                # Convert performance trace to report

# Help and documentation
alias dnhelp='dotnet help'                           # Show help for dotnet commands
alias dnhelpnew='dotnet new --help'                  # Show help for creating projects/templates

# Custom workflows
alias dnlint='dotnet format'                         # Format code using dotnet-format
alias dnpack='dotnet pack'                           # Create a NuGet package
alias dnserve='dotnet run --project'                 # Run a specific project by name

