@echo off
echo Compiling Java files...

set CLASSPATH=.;WEB-INF\lib\javax.servlet-api-4.0.1.jar;WEB-INF\lib\mysql-connector-j-8.0.32.jar;WEB-INF\classes

REM Compile DAO classes
echo Compiling DAO classes...
javac -cp %CLASSPATH% WEB-INF\classes\com\student\dao\*.java

REM Compile Controller classes
echo Compiling Controller classes...
javac -cp %CLASSPATH% WEB-INF\classes\com\student\controller\*.java

echo Compilation complete.
pause 