# How to use LazyValueInfo

## Using Analysis Pass

Compile and Run
```
clang -shared Demo.cpp -o Demo.so `llvm-config --cppflags` -std=gnu++11 -fno-rtti -fPIC
opt -load ./Demo.so -analyze -Demo utf8_to_utf7.ll

```

Output
```
base64
  %40 = load i32, i32* %base64, align 4   Value range is : full-set
  %60 = load i32, i32* %base64, align 4   Value range is : full-set
  %71 = load i32, i32* %base64, align 4   Value range is : full-set


```