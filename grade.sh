# Create your grading script here

# set -e

CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

# Clone student repository
rm -rf student-submission
git clone $1 student-submission

# Check if the file exist
cd student-submission
if [ -e ListExamples.java ] && [ ! -f ListExamples.java ]
then
    echo "ListExamples.java is in the wrong directory"
    exit 1
elif [[ ! -e ListExamples.java ]]
then
    echo "ListExamples.java not found."
    exit 1
fi

# Copy test file to student submission folder
cp ../TestListExamples.java .
cp -r ../lib .

# Compile test and student's code
javac -cp $CPATH *.java
#   detect error
if [[ $? -ne 0 ]]
then 
    echo "Compile failed."
fi

# Run the test
RESULT=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 2 | grep -h "Failures: ")

echo $RESULT




