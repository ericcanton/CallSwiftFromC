#!/bin/bash

LINKED_OUT="linked"

while [[ $# -gt 0 ]]
do
key=$1
case $key in
    --swift)
    SWIFT_FILE=$2
    shift # arg
    shift # value
    ;;
    --cpp)
    CPP_FILE=$2
    shift # arg
    shift #value
    ;;
    -o)
    LINKED_OUT=$2
    shift # arg
    shift #value
    ;;
esac
done

echo "Swift: $SWIFT_FILE"
echo "Cpp: $CPP_FILE"

# Build Swift library for CPP import
case "$(uname -s)" in
    Darwin*)
    LIB_EXTN=".dylib"
    ;;
    Linux*)
    LIB_EXTN=".so"
    ;;
esac

SWIFT_LIB=$(echo $SWIFT_FILE | cut -d '.' -f 1)$LIB_EXTN
swiftc $SWIFT_FILE -emit-library -o $SWIFT_LIB
echo "Swift library at: $SWIFT_LIB"

# Build object file from .cpp
OBJ_FILE=$(echo  $CPP_FILE | cut -d '.' -f 1).o
clang -c $CPP_FILE -o $OBJ_FILE
echo "C++ object file: $OBJ_FILE"
clang $OBJ_FILE $SWIFT_LIB -o $LINKED_OUT 
echo "Linked C++ and Swift in: ./$LINKED_OUT"
