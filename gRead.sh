#!/bin/bash
#     _______             ______    ______   ________   ______      
#    /______/\           /_____/\  /_____/\ /_______/\ /_____/\     
#    \::::__\/__  _______\:::_ \ \ \::::_\/_\::: _  \ \\:::_ \ \    
#     \:\ /____/\/______/\\:(_) ) )_\:\/___/\\::(_)  \ \\:\ \ \ \   
#      \:\\_  _\/\__::::\/ \: __ `\ \\::___\/_\:: __  \ \\:\ \ \ \  
#       \:\_\ \ \           \ \ `\ \ \\:\____/\\:.\ \  \ \\:\/.:| | 
#        \_____\/            \_\/ \_\/ \_____\/ \__\/\__\/ \____/_/ 
#                                                               
# ASCII text design from patorjk.com
# Formatting style from Google Shell Style Guide
# GRead automatically generates a README file for the current directory

PROJECT_NAME=${PWD##*/}
TITLE="## **Brian Morenus - $PROJECT_NAME README"
CURRENT_TIME=$(date +"%x %r %Z")
TIMESTAMP="Generated on $CURRENT_TIME, by $USER"
CUR_DIR=${PWD}

#######################################
# Call required functions for README development
# Globals:
#   TITLE
#   TIMESTAMP
# Arguments:
#   None
#######################################
main() {
  touch "./README.md"
  ( echo "$TITLE" ; echo "$TIMESTAMP" ; echo "" ) >> README.md
  
  manage_flags "$@"
  shift $(( OPTIND - 1 ))

  format_dir_path "$1"
  format_file_list "$dir"
  format_file_descriptors "$dir"
  exit 0
}

#######################################
# Complete all tasks associated with provided flags.
# Globals:
#   None
# Arguments:
#   Command-Line Flags and values
#######################################
manage_flags () {
  while getopts "q:" flag; do
    case ${flag} in
      q) 
        write_questions "${OPTARG}" ;; 
      *) 
        echo "Format: $0 [-q] qflag"; exit 1 ;;
    esac
  done
}

#######################################
# Format the directory path based on PWD and command line arg 
# Globals:
#   CUR_DIR
# Arguments:
#   relative path command-line input
#######################################
format_dir_path () {
  input_path="$1"
  if [[ ${input_path: -1} != "/" ]]
  then
    input_path="${input_path}/"
  fi 
  echo "$input_path"
  dir="${CUR_DIR}/$input_path"
}

#######################################
# Accept user question/answer input for README file
# Globals:
#   None
# Arguments:
#   Number of questions required for the README 
#######################################
write_questions () {
  question_num=$1
  question_count=1

  ( echo "### README Questions" ; echo "" ) >> README.md
    
  while [[ ! $question_count > $question_num ]]; do
    read -p "Question $question_count: " question
    read -p "Answer $question_count: " answer
    
    ( echo "$question_count. $question" ; echo "$answer" ; 
      echo "" ) >> README.md
    question_count=$((question_count + 1))
  done
}

#######################################
# Formats and writes the list of files within the project directory 
# Globals:
#   None
# Arguments:
#   dir - the absolute path of the target project directory 
#######################################
format_file_list() {
  ( echo "" ; 
    echo "#### This directory contains the following files:" ) >> README.md

  line_no=1
  for abs_path in "$dir"*; do
    filename=$(basename "$abs_path")
    echo "processing $filename"
    echo "$line_no. $filename" >> README.md
    line_no=$((line_no + 1))
  done
}

#######################################
# Formats and writes the description / dependencies of each project file 
# Globals:
#   None
# Arguments:
#   dir - the absolute path of the target project directory 
#######################################
format_file_descriptors() {

  for abs_path in "$dir"/*; do
    filename=$(basename "$abs_path")

    ( echo "" ; echo "## $filename" ; echo "### Description" ) >> README.md
    read -p "Please enter a description for $filename: " file_description
    ( echo "$file_description" ; echo "" ; 
      echo "### Dependencies" )  >> README.md
    awk -F '[<>"]'  '/#include/ {print $2}' "$abs_path" >> README.md
    ( echo "" ; echo "---------------------------" ) >> README.md
  done
}

main "$@"
