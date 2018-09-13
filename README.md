# c8tech-releng-maven

This repository contains a set of Maven POMs aimed to help the development and build of multi-modules projects. Those modules can be of different types, including POM aggregator, POM parent, Java libraries, OSGi bundles(Pom-First and Manifest-First), OSGi Integration Tests and others.

The most important artifact is **parent-oss-pom**, a generic parent POM that should be used as parent by other projects. 

It contains many configurable Maven profiles aimed to handle different tasks of the overall building process. Some of them are automatically activated by properties and others by files found in the child project directory.

The projects starting with **fpom** are POM fragments used to concentrate common type of dependencies.
   
## Concepts

The basics concepts used while constructing the *parent-oss-pom* are:

* The project where it will be used is a multi-module one;
* The multi-module project is contained in a single git repository;
* There is one main aggregator POM at the root of each git repository and it is not the parent of other modules;
* There can exist many auxiliary aggregator POMs that are used to build different grouping of modules;
* There is at least one POM parent module for the multi-module project and it is sibling of other modules;
* There can exist auxiliary parent POMs in order to build different kind of projects (ex: tycho based bundles)
* The developer can release each module independently using different versions; 

##### Artifacts Identification Files
Maven profiles activation are limited by one single Property comparing and one existent or missing files. 

So, in order to automatically activate one or more profiles for a specific kind of project we have to introduce certain identification files that will trigger them. Those are:

*   .c8tech.releng.aggregator - a Maven aggregator project;
*   .c8tech.releng.parent - a Maven parent project;
*   .c8tech.releng.bundle - a Pom-First bundle jar;
*   .c8tech.releng.itests.paxexam - a Pax-exam based integration test project;




## How to use the POM artifacts

#####1. Set the local stage directory
This directory will be used by some profiles to share some artifacts (as security keys) and to keep some staged artifacts (as sites and repositories).

At the **user's maven settings.xml file** create a new profile and include the property _c8tech.workspace.dir_. Set it to a value pointing to a directory in the local machine. 

If you are using Eclipse, you can go to *Preferences/Maven/User Settings*. Then click in "Open File" link to open the user's settings.xml file.
If not, this file can be found under the user home directory. at Linux it is located in *~/.m2/* directory.

See this example:

    <profiles>
      <profile>
        <id>c8tech-dev</id>
        <activation>
          <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
          <c8tech.workspace.dir>/User/myuser/c8tech-workspace-dev/</c8tech.workspace.dir>
        </properties>
      </profile>
    </profiles>

####2. Create the multi-module Git repository
Here the developer has two options:

*   Create the repository directly on the repository management site (github.com, gitlab.com, etc) and then clone it to its local directory;
*   Create a local directory and then inside it calls the *git init* command, and push it to a remote repository;



####3. Create the *Parent module*

3.1.  create the parent POM project folder inside the repository's root folder;

3.2.  create the parent pom.xml file inside the parent POM folder;

3.3.  add the parent tag to the created pom:

        <parent>
           <groupId>br.com.c8tech.releng</groupId>
           <artifactId>maven-parent-java</artifactId>
           <version>1.0.0</version>
        </parent>
        <groupId>br.com.c8tech.project</groupId>
        <artifactId>br.com.c8tech.project.parent</artifactId>
    
3.4  set the required properties:



#####4. Create a *Pom-First project module*

        <parent>
           <groupId>br.com.c8tech.project</groupId>
           <artifactId>br.com.c8tech.project.parent</artifactId>
           <version>1.0.0</version>
        </parent>
        <artifactId>br.com.c8tech.project.config</artifactId>




## Contribution Tasks

Before contribute code to the project some steps are needed.






####2. Build and install the releng POMs:
 
    ```cd c8tech-releng-maven```
    
    
    ```mvn clean install```

####3. Set the default formatter profile into the Eclipse IDE.
  This is needed to prevent git to have to much conflicts due to format conflicts.

 * Open the Preferences/Java/Code Style/Formatter dialog and import the file c8tech-eclipse-ide-formatters.xml.
 
 Also you can add templates that uses resources from our plugins and frameworks
 
 * Open the Preferences/Java/Editor/Templates Formatter dialog and import the file c8tech-eclipse-ide-templates.xml.
 
