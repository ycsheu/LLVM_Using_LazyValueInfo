; ModuleID = '../../utf8_to_utf7.c'
source_filename = "../../utf8_to_utf7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@B64Chars = external global i8*, align 8

; Function Attrs: noinline nounwind optnone uwtable
define i8* @utf8_to_utf7(i8* %u8, i64 %u8len) #0 {
entry:
  %retval = alloca i8*, align 8
  %u8.addr = alloca i8*, align 8
  %u8len.addr = alloca i64, align 8
  %buf = alloca i8*, align 8
  %p = alloca i8*, align 8
  %ch = alloca i32, align 4
  %n = alloca i32, align 4
  %i = alloca i32, align 4
  %b = alloca i32, align 4
  %k = alloca i32, align 4
  %base64 = alloca i32, align 4
  %c = alloca i8, align 1
  store i8* %u8, i8** %u8.addr, align 8
  store i64 %u8len, i64* %u8len.addr, align 8
  store i32 0, i32* %b, align 4
  store i32 0, i32* %k, align 4
  store i32 0, i32* %base64, align 4
  %0 = load i64, i64* %u8len.addr, align 8
  %mul = mul i64 %0, 2
  %add = add i64 %mul, 1
  %call = call i8* @safe_malloc(i64 %add)
  store i8* %call, i8** %buf, align 8
  store i8* %call, i8** %p, align 8
  br label %while.cond

while.cond:                                       ; preds = %if.end127, %entry
  %1 = load i64, i64* %u8len.addr, align 8
  %tobool = icmp ne i64 %1, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i8*, i8** %u8.addr, align 8
  %3 = load i8, i8* %2, align 1
  store i8 %3, i8* %c, align 1
  %4 = load i8, i8* %c, align 1
  %conv = zext i8 %4 to i32
  %cmp = icmp slt i32 %conv, 128
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %5 = load i8, i8* %c, align 1
  %conv2 = zext i8 %5 to i32
  store i32 %conv2, i32* %ch, align 4
  store i32 0, i32* %n, align 4
  br label %if.end47

if.else:                                          ; preds = %while.body
  %6 = load i8, i8* %c, align 1
  %conv3 = zext i8 %6 to i32
  %cmp4 = icmp slt i32 %conv3, 194
  br i1 %cmp4, label %if.then6, label %if.else7

if.then6:                                         ; preds = %if.else
  br label %bail

if.else7:                                         ; preds = %if.else
  %7 = load i8, i8* %c, align 1
  %conv8 = zext i8 %7 to i32
  %cmp9 = icmp slt i32 %conv8, 224
  br i1 %cmp9, label %if.then11, label %if.else13

if.then11:                                        ; preds = %if.else7
  %8 = load i8, i8* %c, align 1
  %conv12 = zext i8 %8 to i32
  %and = and i32 %conv12, 31
  store i32 %and, i32* %ch, align 4
  store i32 1, i32* %n, align 4
  br label %if.end45

if.else13:                                        ; preds = %if.else7
  %9 = load i8, i8* %c, align 1
  %conv14 = zext i8 %9 to i32
  %cmp15 = icmp slt i32 %conv14, 240
  br i1 %cmp15, label %if.then17, label %if.else20

if.then17:                                        ; preds = %if.else13
  %10 = load i8, i8* %c, align 1
  %conv18 = zext i8 %10 to i32
  %and19 = and i32 %conv18, 15
  store i32 %and19, i32* %ch, align 4
  store i32 2, i32* %n, align 4
  br label %if.end44

if.else20:                                        ; preds = %if.else13
  %11 = load i8, i8* %c, align 1
  %conv21 = zext i8 %11 to i32
  %cmp22 = icmp slt i32 %conv21, 248
  br i1 %cmp22, label %if.then24, label %if.else27

if.then24:                                        ; preds = %if.else20
  %12 = load i8, i8* %c, align 1
  %conv25 = zext i8 %12 to i32
  %and26 = and i32 %conv25, 7
  store i32 %and26, i32* %ch, align 4
  store i32 3, i32* %n, align 4
  br label %if.end43

if.else27:                                        ; preds = %if.else20
  %13 = load i8, i8* %c, align 1
  %conv28 = zext i8 %13 to i32
  %cmp29 = icmp slt i32 %conv28, 252
  br i1 %cmp29, label %if.then31, label %if.else34

if.then31:                                        ; preds = %if.else27
  %14 = load i8, i8* %c, align 1
  %conv32 = zext i8 %14 to i32
  %and33 = and i32 %conv32, 3
  store i32 %and33, i32* %ch, align 4
  store i32 4, i32* %n, align 4
  br label %if.end42

if.else34:                                        ; preds = %if.else27
  %15 = load i8, i8* %c, align 1
  %conv35 = zext i8 %15 to i32
  %cmp36 = icmp slt i32 %conv35, 254
  br i1 %cmp36, label %if.then38, label %if.else41

if.then38:                                        ; preds = %if.else34
  %16 = load i8, i8* %c, align 1
  %conv39 = zext i8 %16 to i32
  %and40 = and i32 %conv39, 1
  store i32 %and40, i32* %ch, align 4
  store i32 5, i32* %n, align 4
  br label %if.end

if.else41:                                        ; preds = %if.else34
  br label %bail

if.end:                                           ; preds = %if.then38
  br label %if.end42

if.end42:                                         ; preds = %if.end, %if.then31
  br label %if.end43

if.end43:                                         ; preds = %if.end42, %if.then24
  br label %if.end44

if.end44:                                         ; preds = %if.end43, %if.then17
  br label %if.end45

if.end45:                                         ; preds = %if.end44, %if.then11
  br label %if.end46

if.end46:                                         ; preds = %if.end45
  br label %if.end47

if.end47:                                         ; preds = %if.end46, %if.then
  %17 = load i8*, i8** %u8.addr, align 8
  %incdec.ptr = getelementptr inbounds i8, i8* %17, i32 1
  store i8* %incdec.ptr, i8** %u8.addr, align 8
  %18 = load i64, i64* %u8len.addr, align 8
  %dec = add i64 %18, -1
  store i64 %dec, i64* %u8len.addr, align 8
  %19 = load i32, i32* %n, align 4
  %conv48 = sext i32 %19 to i64
  %20 = load i64, i64* %u8len.addr, align 8
  %cmp49 = icmp ugt i64 %conv48, %20
  br i1 %cmp49, label %if.then51, label %if.end52

if.then51:                                        ; preds = %if.end47
  br label %bail

if.end52:                                         ; preds = %if.end47
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end52
  %21 = load i32, i32* %i, align 4
  %22 = load i32, i32* %n, align 4
  %cmp53 = icmp slt i32 %21, %22
  br i1 %cmp53, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %23 = load i8*, i8** %u8.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom = sext i32 %24 to i64
  %arrayidx = getelementptr inbounds i8, i8* %23, i64 %idxprom
  %25 = load i8, i8* %arrayidx, align 1
  %conv55 = sext i8 %25 to i32
  %and56 = and i32 %conv55, 192
  %cmp57 = icmp ne i32 %and56, 128
  br i1 %cmp57, label %if.then59, label %if.end60

if.then59:                                        ; preds = %for.body
  br label %bail

if.end60:                                         ; preds = %for.body
  %26 = load i32, i32* %ch, align 4
  %shl = shl i32 %26, 6
  %27 = load i8*, i8** %u8.addr, align 8
  %28 = load i32, i32* %i, align 4
  %idxprom61 = sext i32 %28 to i64
  %arrayidx62 = getelementptr inbounds i8, i8* %27, i64 %idxprom61
  %29 = load i8, i8* %arrayidx62, align 1
  %conv63 = sext i8 %29 to i32
  %and64 = and i32 %conv63, 63
  %or = or i32 %shl, %and64
  store i32 %or, i32* %ch, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.end60
  %30 = load i32, i32* %i, align 4
  %inc = add nsw i32 %30, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %31 = load i32, i32* %n, align 4
  %cmp65 = icmp sgt i32 %31, 1
  br i1 %cmp65, label %land.lhs.true, label %if.end71

land.lhs.true:                                    ; preds = %for.end
  %32 = load i32, i32* %ch, align 4
  %33 = load i32, i32* %n, align 4
  %mul67 = mul nsw i32 %33, 5
  %add68 = add nsw i32 %mul67, 1
  %shr = ashr i32 %32, %add68
  %tobool69 = icmp ne i32 %shr, 0
  br i1 %tobool69, label %if.end71, label %if.then70

if.then70:                                        ; preds = %land.lhs.true
  br label %bail

if.end71:                                         ; preds = %land.lhs.true, %for.end
  %34 = load i32, i32* %n, align 4
  %35 = load i8*, i8** %u8.addr, align 8
  %idx.ext = sext i32 %34 to i64
  %add.ptr = getelementptr inbounds i8, i8* %35, i64 %idx.ext
  store i8* %add.ptr, i8** %u8.addr, align 8
  %36 = load i32, i32* %n, align 4
  %conv72 = sext i32 %36 to i64
  %37 = load i64, i64* %u8len.addr, align 8
  %sub = sub i64 %37, %conv72
  store i64 %sub, i64* %u8len.addr, align 8
  %38 = load i32, i32* %ch, align 4
  %cmp73 = icmp slt i32 %38, 32
  br i1 %cmp73, label %if.then77, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end71
  %39 = load i32, i32* %ch, align 4
  %cmp75 = icmp sge i32 %39, 127
  br i1 %cmp75, label %if.then77, label %if.else108

if.then77:                                        ; preds = %lor.lhs.false, %if.end71
  %40 = load i32, i32* %base64, align 4
  %tobool78 = icmp ne i32 %40, 0
  br i1 %tobool78, label %if.end81, label %if.then79

if.then79:                                        ; preds = %if.then77
  %41 = load i8*, i8** %p, align 8
  %incdec.ptr80 = getelementptr inbounds i8, i8* %41, i32 1
  store i8* %incdec.ptr80, i8** %p, align 8
  store i8 38, i8* %41, align 1
  store i32 1, i32* %base64, align 4
  store i32 0, i32* %b, align 4
  store i32 10, i32* %k, align 4
  br label %if.end81

if.end81:                                         ; preds = %if.then79, %if.then77
  %42 = load i32, i32* %ch, align 4
  %and82 = and i32 %42, -65536
  %tobool83 = icmp ne i32 %and82, 0
  br i1 %tobool83, label %if.then84, label %if.end85

if.then84:                                        ; preds = %if.end81
  store i32 65534, i32* %ch, align 4
  br label %if.end85

if.end85:                                         ; preds = %if.then84, %if.end81
  %43 = load i8*, i8** @B64Chars, align 8
  %44 = load i32, i32* %b, align 4
  %45 = load i32, i32* %ch, align 4
  %46 = load i32, i32* %k, align 4
  %shr86 = ashr i32 %45, %46
  %or87 = or i32 %44, %shr86
  %idxprom88 = sext i32 %or87 to i64
  %arrayidx89 = getelementptr inbounds i8, i8* %43, i64 %idxprom88
  %47 = load i8, i8* %arrayidx89, align 1
  %48 = load i8*, i8** %p, align 8
  %incdec.ptr90 = getelementptr inbounds i8, i8* %48, i32 1
  store i8* %incdec.ptr90, i8** %p, align 8
  store i8 %47, i8* %48, align 1
  %49 = load i32, i32* %k, align 4
  %sub91 = sub nsw i32 %49, 6
  store i32 %sub91, i32* %k, align 4
  br label %for.cond92

for.cond92:                                       ; preds = %for.inc101, %if.end85
  %50 = load i32, i32* %k, align 4
  %cmp93 = icmp sge i32 %50, 0
  br i1 %cmp93, label %for.body95, label %for.end103

for.body95:                                       ; preds = %for.cond92
  %51 = load i8*, i8** @B64Chars, align 8
  %52 = load i32, i32* %ch, align 4
  %53 = load i32, i32* %k, align 4
  %shr96 = ashr i32 %52, %53
  %and97 = and i32 %shr96, 63
  %idxprom98 = sext i32 %and97 to i64
  %arrayidx99 = getelementptr inbounds i8, i8* %51, i64 %idxprom98
  %54 = load i8, i8* %arrayidx99, align 1
  %55 = load i8*, i8** %p, align 8
  %incdec.ptr100 = getelementptr inbounds i8, i8* %55, i32 1
  store i8* %incdec.ptr100, i8** %p, align 8
  store i8 %54, i8* %55, align 1
  br label %for.inc101

for.inc101:                                       ; preds = %for.body95
  %56 = load i32, i32* %k, align 4
  %sub102 = sub nsw i32 %56, 6
  store i32 %sub102, i32* %k, align 4
  br label %for.cond92

for.end103:                                       ; preds = %for.cond92
  %57 = load i32, i32* %ch, align 4
  %58 = load i32, i32* %k, align 4
  %sub104 = sub nsw i32 0, %58
  %shl105 = shl i32 %57, %sub104
  %and106 = and i32 %shl105, 63
  store i32 %and106, i32* %b, align 4
  %59 = load i32, i32* %k, align 4
  %add107 = add nsw i32 %59, 16
  store i32 %add107, i32* %k, align 4
  br label %if.end127

if.else108:                                       ; preds = %lor.lhs.false
  %60 = load i32, i32* %base64, align 4
  %tobool109 = icmp ne i32 %60, 0
  br i1 %tobool109, label %if.then110, label %if.end119

if.then110:                                       ; preds = %if.else108
  %61 = load i32, i32* %k, align 4
  %cmp111 = icmp sgt i32 %61, 10
  br i1 %cmp111, label %if.then113, label %if.end117

if.then113:                                       ; preds = %if.then110
  %62 = load i8*, i8** @B64Chars, align 8
  %63 = load i32, i32* %b, align 4
  %idxprom114 = sext i32 %63 to i64
  %arrayidx115 = getelementptr inbounds i8, i8* %62, i64 %idxprom114
  %64 = load i8, i8* %arrayidx115, align 1
  %65 = load i8*, i8** %p, align 8
  %incdec.ptr116 = getelementptr inbounds i8, i8* %65, i32 1
  store i8* %incdec.ptr116, i8** %p, align 8
  store i8 %64, i8* %65, align 1
  br label %if.end117

if.end117:                                        ; preds = %if.then113, %if.then110
  %66 = load i8*, i8** %p, align 8
  %incdec.ptr118 = getelementptr inbounds i8, i8* %66, i32 1
  store i8* %incdec.ptr118, i8** %p, align 8
  store i8 45, i8* %66, align 1
  store i32 0, i32* %base64, align 4
  br label %if.end119

if.end119:                                        ; preds = %if.end117, %if.else108
  %67 = load i32, i32* %ch, align 4
  %conv120 = trunc i32 %67 to i8
  %68 = load i8*, i8** %p, align 8
  %incdec.ptr121 = getelementptr inbounds i8, i8* %68, i32 1
  store i8* %incdec.ptr121, i8** %p, align 8
  store i8 %conv120, i8* %68, align 1
  %69 = load i32, i32* %ch, align 4
  %cmp122 = icmp eq i32 %69, 38
  br i1 %cmp122, label %if.then124, label %if.end126

if.then124:                                       ; preds = %if.end119
  %70 = load i8*, i8** %p, align 8
  %incdec.ptr125 = getelementptr inbounds i8, i8* %70, i32 1
  store i8* %incdec.ptr125, i8** %p, align 8
  store i8 45, i8* %70, align 1
  br label %if.end126

if.end126:                                        ; preds = %if.then124, %if.end119
  br label %if.end127

if.end127:                                        ; preds = %if.end126, %for.end103
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %71 = load i32, i32* %base64, align 4
  %tobool128 = icmp ne i32 %71, 0
  br i1 %tobool128, label %if.then129, label %if.end138

if.then129:                                       ; preds = %while.end
  %72 = load i32, i32* %k, align 4
  %cmp130 = icmp sgt i32 %72, 10
  br i1 %cmp130, label %if.then132, label %if.end136

if.then132:                                       ; preds = %if.then129
  %73 = load i8*, i8** @B64Chars, align 8
  %74 = load i32, i32* %b, align 4
  %idxprom133 = sext i32 %74 to i64
  %arrayidx134 = getelementptr inbounds i8, i8* %73, i64 %idxprom133
  %75 = load i8, i8* %arrayidx134, align 1
  %76 = load i8*, i8** %p, align 8
  %incdec.ptr135 = getelementptr inbounds i8, i8* %76, i32 1
  store i8* %incdec.ptr135, i8** %p, align 8
  store i8 %75, i8* %76, align 1
  br label %if.end136

if.end136:                                        ; preds = %if.then132, %if.then129
  %77 = load i8*, i8** %p, align 8
  %incdec.ptr137 = getelementptr inbounds i8, i8* %77, i32 1
  store i8* %incdec.ptr137, i8** %p, align 8
  store i8 45, i8* %77, align 1
  br label %if.end138

if.end138:                                        ; preds = %if.end136, %while.end
  %78 = load i8*, i8** %p, align 8
  %incdec.ptr139 = getelementptr inbounds i8, i8* %78, i32 1
  store i8* %incdec.ptr139, i8** %p, align 8
  store i8 0, i8* %78, align 1
  %79 = bitcast i8** %buf to i8*
  %80 = load i8*, i8** %p, align 8
  %81 = load i8*, i8** %buf, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %80 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %81 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %call140 = call i8* @safe_realloc(i8* %79, i64 %sub.ptr.sub)
  %82 = load i8*, i8** %buf, align 8
  store i8* %82, i8** %retval, align 8
  br label %return

bail:                                             ; preds = %if.then70, %if.then59, %if.then51, %if.else41, %if.then6
  %83 = bitcast i8** %buf to i8*
  call void @safe_free(i8* %83)
  store i8* null, i8** %retval, align 8
  br label %return

return:                                           ; preds = %bail, %if.end138
  %84 = load i8*, i8** %retval, align 8
  ret i8* %84
}

declare i8* @safe_malloc(i64) #1

declare i8* @safe_realloc(i8*, i64) #1

declare void @safe_free(i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
