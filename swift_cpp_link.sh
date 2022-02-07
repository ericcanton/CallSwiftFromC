#!/bin/bash

HELP=$(cat <<EOF
This script automates compiling C(++) that calls Swift.
    --swift <file>.swift    The Swift source exposing the C(++) API.
                            Default: print_num.swift
    --cpp <file>.cpp        The C(++) source that calls your Swift.
                            Default: print_num.cpp
    --output, -o            The name your linked executable will have.
EOF
)

LINKED_OUT="linked"
SWIFT_FILE="print_num.swift"
CPP_FILE="print_num.cpp"

if [[ $# -eq 0 ]]; then
    #printf "$HELP"
    echo "$HELP"
    #echo "No .swift/.cpp source given, default vlaues used."
fi

while [[ $# -gt 0 ]]
do
key=$1
case $key in
    -h|--help)
    echo $HELP
    exit 1
    ;;
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
    -o|--output)
    LINKED_OUT=$2
    shift # arg
    shift #value
    ;;
esac
done

echo "Swift source: $SWIFT_FILE"
echo "Cpp source: $CPP_FILE"

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
