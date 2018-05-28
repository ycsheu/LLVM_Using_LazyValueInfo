clang -shared Demo.cpp -o Demo.so `llvm-config --cppflags` -std=gnu++11 -fno-rtti -fPIC
opt -load ./Demo.so -analyze -Demo utf8_to_utf7.ll
