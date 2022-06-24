# **README - gRead

    gRead is a bash script that automates the generation of README's

    NAME  
        gRead - generates a README file from the given project directory  
    SYNOPSIS  
        gread [-q n] file ...  
    DESCRIPTION  
        The gRead utility parses the files in the given project directory for   
        relevant file descriptions and dependency information. The utility also  
        has the ability to accept user question and answer input related to the
        project.

        The following options are available:

        -q      Add a specified number of project related question and answer
                entries within the README output. The argument is of the form
                "n" where the letter represents the following:

                    n   The number of questions and answer pairs for entry by the user

    EXAMPLES
        Generate a README with no question and answer pairs for the current
        directory

           $ gread ./

        Generate a README with two question and answer pairs for the current
        directory

            $ gread -q 2 ./

        Generate a README with 4 question and answer pairs for a project directory
        in a different relative location than the present working directory

            $ gread -q 4 ../../homework2

    AUTHOR
        Brian Morenus, brian.morenus@gmail.com
    COPYRIGHT
        For open source use.
