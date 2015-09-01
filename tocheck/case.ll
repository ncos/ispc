; ModuleID = 'case.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stdout = external global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"_________\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"((%d))\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"%u\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"((%u))\00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"((%f))\00", align 1
@.str.10 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.str.11 = private unnamed_addr constant [9 x i8] c"((%lld))\00", align 1
@.str.12 = private unnamed_addr constant [5 x i8] c"%llu\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"((%llu))\00", align 1
@.str.14 = private unnamed_addr constant [3 x i8] c"%p\00", align 1
@.str.15 = private unnamed_addr constant [7 x i8] c"((%p))\00", align 1
@.str.16 = private unnamed_addr constant [14 x i8] c"UNKNOWN TYPE \00", align 1
@__str = internal constant [14 x i8] c"% = aa %% bb\0A\00"
@__str.1 = internal constant [2 x i8] c"I\00"
@__str.2 = internal constant [5 x i8] c"0.0\0A\00"
@__str.3 = internal constant [1 x i8] zeroinitializer
@__str.4 = internal constant [7 x i8] c"A = %\0A\00"
@__str.5 = internal constant [2 x i8] c"I\00"
@__str.6 = internal constant [14 x i8] c"% = aa %% bb\0A\00"
@__str.7 = internal constant [2 x i8] c"I\00"
@__str.8 = internal constant [5 x i8] c"0.0\0A\00"
@__str.9 = internal constant [1 x i8] zeroinitializer
@__str.10 = internal constant [7 x i8] c"A = %\0A\00"
@__str.11 = internal constant [2 x i8] c"I\00"

; Function Attrs: nounwind uwtable
define internal fastcc void @__do_print(i8* nocapture readonly %format, i8* nocapture readonly %types, i64 %mask, i8** nocapture readonly %args) #0 {
entry:
  %printString = alloca [4097 x i8], align 16
  %tmpBuf = alloca [256 x i8], align 16
  %arrayidx = getelementptr inbounds [4097 x i8], [4097 x i8]* %printString, i64 0, i64 0
  %0 = load i8, i8* %format, align 1
  %tobool.41 = icmp eq i8 %0, 0
  %arrayidx1 = getelementptr inbounds [4097 x i8], [4097 x i8]* %printString, i64 0, i64 4096
  br i1 %tobool.41, label %done, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %sub.ptr.rhs.cast645 = ptrtoint [4097 x i8]* %printString to i64
  %arraydecay = getelementptr inbounds [256 x i8], [256 x i8]* %tmpBuf, i64 0, i64 0
  br label %while.body

while.body:                                       ; preds = %if.end.661, %while.body.lr.ph
  %1 = phi i8 [ %0, %while.body.lr.ph ], [ %64, %if.end.661 ]
  %format.addr.045 = phi i8* [ %format, %while.body.lr.ph ], [ %incdec.ptr662, %if.end.661 ]
  %types.addr.044 = phi i8* [ %types, %while.body.lr.ph ], [ %types.addr.1, %if.end.661 ]
  %bufp.043 = phi i8* [ %arrayidx, %while.body.lr.ph ], [ %bufp.11, %if.end.661 ]
  %argCount.042 = phi i32 [ 0, %while.body.lr.ph ], [ %argCount.1, %if.end.661 ]
  %cmp4 = icmp eq i8 %1, 37
  br i1 %cmp4, label %if.else, label %if.then

if.then:                                          ; preds = %while.body
  %incdec.ptr = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 %1, i8* %bufp.043, align 1
  br label %if.end.661

if.else:                                          ; preds = %while.body
  %2 = load i8, i8* %types.addr.044, align 1
  %tobool6 = icmp eq i8 %2, 0
  br i1 %tobool6, label %if.end.661, label %if.then.7

if.then.7:                                        ; preds = %if.else
  %inc = add nsw i32 %argCount.042, 1
  %idxprom = sext i32 %argCount.042 to i64
  %arrayidx8 = getelementptr inbounds i8*, i8** %args, i64 %idxprom
  %3 = load i8*, i8** %arrayidx8, align 8
  %conv9 = sext i8 %2 to i32
  switch i32 %conv9, label %do.body.641 [
    i32 98, label %sw.bb
    i32 66, label %sw.bb.22
    i32 105, label %sw.bb.85
    i32 73, label %sw.bb.108
    i32 117, label %sw.bb.164
    i32 85, label %sw.bb.187
    i32 102, label %sw.bb.243
    i32 70, label %sw.bb.267
    i32 108, label %sw.bb.325
    i32 76, label %sw.bb.348
    i32 118, label %sw.bb.404
    i32 86, label %sw.bb.427
    i32 100, label %sw.bb.483
    i32 68, label %sw.bb.506
    i32 112, label %sw.bb.562
    i32 80, label %sw.bb.585
  ]

sw.bb:                                            ; preds = %if.then.7
  %4 = bitcast i8* %3 to i32*
  %5 = load i32, i32* %4, align 4
  %tobool10 = icmp ne i32 %5, 0
  %cond = select i1 %tobool10, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %leninc33 = select i1 %tobool10, i64 5, i64 6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %arraydecay, i8* %cond, i64 %leninc33, i32 1, i1 false)
  %sub.ptr.lhs.cast = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub35 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast
  %sub = shl i64 %sub.ptr.sub35, 32
  %sext34 = add i64 %sub, 17592186044416
  %conv14 = ashr exact i64 %sext34, 32
  %call15 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv14) #6
  %call17 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr = getelementptr inbounds i8, i8* %bufp.043, i64 %call17
  %cmp19 = icmp ult i8* %add.ptr, %arrayidx1
  br i1 %cmp19, label %sw.epilog, label %done

sw.bb.22:                                         ; preds = %if.then.7
  %incdec.ptr23 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp25 = icmp eq i8* %incdec.ptr23, %arrayidx1
  br i1 %cmp25, label %sw.epilog, label %for.cond.preheader

for.cond.preheader:                               ; preds = %sw.bb.22
  %6 = bitcast i8* %3 to i32*
  br label %for.body

for.body:                                         ; preds = %if.end.77, %for.cond.preheader
  %indvars.iv74 = phi i64 [ 0, %for.cond.preheader ], [ %indvars.iv.next75, %if.end.77 ]
  %bufp.140 = phi i8* [ %incdec.ptr23, %for.cond.preheader ], [ %incdec.ptr83, %if.end.77 ]
  %7 = phi i8* [ %bufp.043, %for.cond.preheader ], [ %13, %if.end.77 ]
  %8 = trunc i64 %indvars.iv74 to i32
  %sh_prom = and i64 %indvars.iv74, 4294967295
  %shl = shl i64 1, %sh_prom
  %and = and i64 %shl, %mask
  %tobool31 = icmp eq i64 %and, 0
  br i1 %tobool31, label %do.body.60, label %if.then.32

if.then.32:                                       ; preds = %for.body
  %9 = getelementptr inbounds i8, i8* %7, i64 1
  %arrayidx35 = getelementptr inbounds i32, i32* %6, i64 %indvars.iv74
  %10 = load i32, i32* %arrayidx35, align 4
  %tobool36 = icmp ne i32 %10, 0
  %cond37 = select i1 %tobool36, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %leninc = select i1 %tobool36, i64 5, i64 6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %arraydecay, i8* %cond37, i64 %leninc, i32 1, i1 false)
  %sub.ptr.lhs.cast42 = ptrtoint i8* %bufp.140 to i64
  store i8 0, i8* %bufp.140, align 1
  %sub.ptr.sub4431 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast42
  %sub47 = shl i64 %sub.ptr.sub4431, 32
  %sext30 = add i64 %sub47, 17592186044416
  %conv48 = ashr exact i64 %sext30, 32
  %call49 = call i8* @strncat(i8* %bufp.140, i8* %arraydecay, i64 %conv48) #6
  %call51 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr52 = getelementptr inbounds i8, i8* %9, i64 %call51
  %cmp54 = icmp ult i8* %add.ptr52, %arrayidx1
  br i1 %cmp54, label %if.end.77, label %done

do.body.60:                                       ; preds = %for.body
  %sub.ptr.lhs.cast63 = ptrtoint i8* %bufp.140 to i64
  store i8 0, i8* %bufp.140, align 1
  %sub.ptr.sub6529 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast63
  %sub67 = shl i64 %sub.ptr.sub6529, 32
  %sext28 = add i64 %sub67, 17592186044416
  %conv68 = ashr exact i64 %sext28, 32
  %call69 = call i8* @strncat(i8* %bufp.140, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 %conv68) #6
  %add.ptr70 = getelementptr inbounds i8, i8* %7, i64 10
  %cmp72 = icmp ult i8* %add.ptr70, %arrayidx1
  br i1 %cmp72, label %if.end.77, label %done

if.end.77:                                        ; preds = %do.body.60, %if.then.32
  %11 = phi i64 [ %call51, %if.then.32 ], [ 9, %do.body.60 ]
  %bufp.2 = phi i8* [ %add.ptr52, %if.then.32 ], [ %add.ptr70, %do.body.60 ]
  %12 = getelementptr inbounds i8, i8* %7, i64 1
  %13 = getelementptr inbounds i8, i8* %12, i64 %11
  %cmp79 = icmp ne i32 %8, 15
  %conv82 = select i1 %cmp79, i8 44, i8 93
  %incdec.ptr83 = getelementptr inbounds i8, i8* %13, i64 1
  store i8 %conv82, i8* %bufp.2, align 1
  %indvars.iv.next75 = add nuw nsw i64 %indvars.iv74, 1
  %cmp29 = icmp slt i64 %indvars.iv.next75, 16
  br i1 %cmp29, label %for.body, label %sw.epilog

sw.bb.85:                                         ; preds = %if.then.7
  %14 = bitcast i8* %3 to i32*
  %15 = load i32, i32* %14, align 4
  %call87 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32 %15) #6
  %sub.ptr.lhs.cast91 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub9327 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast91
  %sub96 = shl i64 %sub.ptr.sub9327, 32
  %sext26 = add i64 %sub96, 17592186044416
  %conv97 = ashr exact i64 %sext26, 32
  %call98 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv97) #6
  %call100 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr101 = getelementptr inbounds i8, i8* %bufp.043, i64 %call100
  %cmp103 = icmp ult i8* %add.ptr101, %arrayidx1
  br i1 %cmp103, label %sw.epilog, label %done

sw.bb.108:                                        ; preds = %if.then.7
  %incdec.ptr109 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp111 = icmp eq i8* %incdec.ptr109, %arrayidx1
  br i1 %cmp111, label %sw.epilog, label %for.cond.116.preheader

for.cond.116.preheader:                           ; preds = %sw.bb.108
  %16 = bitcast i8* %3 to i32*
  br label %for.body.119

for.body.119:                                     ; preds = %do.end.154, %for.cond.116.preheader
  %indvars.iv72 = phi i64 [ 0, %for.cond.116.preheader ], [ %indvars.iv.next73, %do.end.154 ]
  %bufp.338 = phi i8* [ %incdec.ptr109, %for.cond.116.preheader ], [ %incdec.ptr160, %do.end.154 ]
  %17 = phi i8* [ %bufp.043, %for.cond.116.preheader ], [ %add.ptr148, %do.end.154 ]
  %18 = trunc i64 %indvars.iv72 to i32
  %sh_prom120 = and i64 %indvars.iv72, 4294967295
  %shl121 = shl i64 1, %sh_prom120
  %and122 = and i64 %shl121, %mask
  %tobool123 = icmp eq i64 %and122, 0
  %arrayidx127 = getelementptr inbounds i32, i32* %16, i64 %indvars.iv72
  %19 = load i32, i32* %arrayidx127, align 4
  br i1 %tobool123, label %if.else.129, label %if.then.124

if.then.124:                                      ; preds = %for.body.119
  %call128 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32 %19) #6
  br label %do.body.135

if.else.129:                                      ; preds = %for.body.119
  %call133 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i64 0, i64 0), i32 %19) #6
  br label %do.body.135

do.body.135:                                      ; preds = %if.else.129, %if.then.124
  %20 = getelementptr inbounds i8, i8* %17, i64 1
  %sub.ptr.lhs.cast138 = ptrtoint i8* %bufp.338 to i64
  store i8 0, i8* %bufp.338, align 1
  %sub.ptr.sub14025 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast138
  %sub143 = shl i64 %sub.ptr.sub14025, 32
  %sext24 = add i64 %sub143, 17592186044416
  %conv144 = ashr exact i64 %sext24, 32
  %call145 = call i8* @strncat(i8* %bufp.338, i8* %arraydecay, i64 %conv144) #6
  %call147 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr148 = getelementptr inbounds i8, i8* %20, i64 %call147
  %cmp150 = icmp ult i8* %add.ptr148, %arrayidx1
  br i1 %cmp150, label %do.end.154, label %done

do.end.154:                                       ; preds = %do.body.135
  %cmp156 = icmp ne i32 %18, 15
  %conv159 = select i1 %cmp156, i8 44, i8 93
  %incdec.ptr160 = getelementptr inbounds i8, i8* %add.ptr148, i64 1
  store i8 %conv159, i8* %add.ptr148, align 1
  %indvars.iv.next73 = add nuw nsw i64 %indvars.iv72, 1
  %cmp117 = icmp slt i64 %indvars.iv.next73, 16
  br i1 %cmp117, label %for.body.119, label %sw.epilog

sw.bb.164:                                        ; preds = %if.then.7
  %21 = bitcast i8* %3 to i32*
  %22 = load i32, i32* %21, align 4
  %call166 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i64 0, i64 0), i32 %22) #6
  %sub.ptr.lhs.cast170 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub17223 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast170
  %sub175 = shl i64 %sub.ptr.sub17223, 32
  %sext22 = add i64 %sub175, 17592186044416
  %conv176 = ashr exact i64 %sext22, 32
  %call177 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv176) #6
  %call179 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr180 = getelementptr inbounds i8, i8* %bufp.043, i64 %call179
  %cmp182 = icmp ult i8* %add.ptr180, %arrayidx1
  br i1 %cmp182, label %sw.epilog, label %done

sw.bb.187:                                        ; preds = %if.then.7
  %incdec.ptr188 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp190 = icmp eq i8* %incdec.ptr188, %arrayidx1
  br i1 %cmp190, label %sw.epilog, label %for.cond.195.preheader

for.cond.195.preheader:                           ; preds = %sw.bb.187
  %23 = bitcast i8* %3 to i32*
  br label %for.body.198

for.body.198:                                     ; preds = %do.end.233, %for.cond.195.preheader
  %indvars.iv70 = phi i64 [ 0, %for.cond.195.preheader ], [ %indvars.iv.next71, %do.end.233 ]
  %bufp.436 = phi i8* [ %incdec.ptr188, %for.cond.195.preheader ], [ %incdec.ptr239, %do.end.233 ]
  %24 = phi i8* [ %bufp.043, %for.cond.195.preheader ], [ %add.ptr227, %do.end.233 ]
  %25 = trunc i64 %indvars.iv70 to i32
  %sh_prom199 = and i64 %indvars.iv70, 4294967295
  %shl200 = shl i64 1, %sh_prom199
  %and201 = and i64 %shl200, %mask
  %tobool202 = icmp eq i64 %and201, 0
  %arrayidx206 = getelementptr inbounds i32, i32* %23, i64 %indvars.iv70
  %26 = load i32, i32* %arrayidx206, align 4
  br i1 %tobool202, label %if.else.208, label %if.then.203

if.then.203:                                      ; preds = %for.body.198
  %call207 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i64 0, i64 0), i32 %26) #6
  br label %do.body.214

if.else.208:                                      ; preds = %for.body.198
  %call212 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0), i32 %26) #6
  br label %do.body.214

do.body.214:                                      ; preds = %if.else.208, %if.then.203
  %27 = getelementptr inbounds i8, i8* %24, i64 1
  %sub.ptr.lhs.cast217 = ptrtoint i8* %bufp.436 to i64
  store i8 0, i8* %bufp.436, align 1
  %sub.ptr.sub21921 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast217
  %sub222 = shl i64 %sub.ptr.sub21921, 32
  %sext20 = add i64 %sub222, 17592186044416
  %conv223 = ashr exact i64 %sext20, 32
  %call224 = call i8* @strncat(i8* %bufp.436, i8* %arraydecay, i64 %conv223) #6
  %call226 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr227 = getelementptr inbounds i8, i8* %27, i64 %call226
  %cmp229 = icmp ult i8* %add.ptr227, %arrayidx1
  br i1 %cmp229, label %do.end.233, label %done

do.end.233:                                       ; preds = %do.body.214
  %cmp235 = icmp ne i32 %25, 15
  %conv238 = select i1 %cmp235, i8 44, i8 93
  %incdec.ptr239 = getelementptr inbounds i8, i8* %add.ptr227, i64 1
  store i8 %conv238, i8* %add.ptr227, align 1
  %indvars.iv.next71 = add nuw nsw i64 %indvars.iv70, 1
  %cmp196 = icmp slt i64 %indvars.iv.next71, 16
  br i1 %cmp196, label %for.body.198, label %sw.epilog

sw.bb.243:                                        ; preds = %if.then.7
  %28 = bitcast i8* %3 to float*
  %29 = load float, float* %28, align 4
  %conv245 = fpext float %29 to double
  %call246 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.8, i64 0, i64 0), double %conv245) #6
  %sub.ptr.lhs.cast250 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub25219 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast250
  %sub255 = shl i64 %sub.ptr.sub25219, 32
  %sext18 = add i64 %sub255, 17592186044416
  %conv256 = ashr exact i64 %sext18, 32
  %call257 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv256) #6
  %call259 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr260 = getelementptr inbounds i8, i8* %bufp.043, i64 %call259
  %cmp262 = icmp ult i8* %add.ptr260, %arrayidx1
  br i1 %cmp262, label %sw.epilog, label %done

sw.bb.267:                                        ; preds = %if.then.7
  %incdec.ptr268 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp270 = icmp eq i8* %incdec.ptr268, %arrayidx1
  br i1 %cmp270, label %sw.epilog, label %for.cond.275.preheader

for.cond.275.preheader:                           ; preds = %sw.bb.267
  %30 = bitcast i8* %3 to float*
  br label %for.body.278

for.body.278:                                     ; preds = %do.end.315, %for.cond.275.preheader
  %indvars.iv68 = phi i64 [ 0, %for.cond.275.preheader ], [ %indvars.iv.next69, %do.end.315 ]
  %bufp.534 = phi i8* [ %incdec.ptr268, %for.cond.275.preheader ], [ %incdec.ptr321, %do.end.315 ]
  %31 = phi i8* [ %bufp.043, %for.cond.275.preheader ], [ %add.ptr309, %do.end.315 ]
  %32 = trunc i64 %indvars.iv68 to i32
  %sh_prom279 = and i64 %indvars.iv68, 4294967295
  %shl280 = shl i64 1, %sh_prom279
  %and281 = and i64 %shl280, %mask
  %tobool282 = icmp eq i64 %and281, 0
  %arrayidx286 = getelementptr inbounds float, float* %30, i64 %indvars.iv68
  %33 = load float, float* %arrayidx286, align 4
  %conv287 = fpext float %33 to double
  br i1 %tobool282, label %if.else.289, label %if.then.283

if.then.283:                                      ; preds = %for.body.278
  %call288 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.8, i64 0, i64 0), double %conv287) #6
  br label %do.body.296

if.else.289:                                      ; preds = %for.body.278
  %call294 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %conv287) #6
  br label %do.body.296

do.body.296:                                      ; preds = %if.else.289, %if.then.283
  %34 = getelementptr inbounds i8, i8* %31, i64 1
  %sub.ptr.lhs.cast299 = ptrtoint i8* %bufp.534 to i64
  store i8 0, i8* %bufp.534, align 1
  %sub.ptr.sub30117 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast299
  %sub304 = shl i64 %sub.ptr.sub30117, 32
  %sext16 = add i64 %sub304, 17592186044416
  %conv305 = ashr exact i64 %sext16, 32
  %call306 = call i8* @strncat(i8* %bufp.534, i8* %arraydecay, i64 %conv305) #6
  %call308 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr309 = getelementptr inbounds i8, i8* %34, i64 %call308
  %cmp311 = icmp ult i8* %add.ptr309, %arrayidx1
  br i1 %cmp311, label %do.end.315, label %done

do.end.315:                                       ; preds = %do.body.296
  %cmp317 = icmp ne i32 %32, 15
  %conv320 = select i1 %cmp317, i8 44, i8 93
  %incdec.ptr321 = getelementptr inbounds i8, i8* %add.ptr309, i64 1
  store i8 %conv320, i8* %add.ptr309, align 1
  %indvars.iv.next69 = add nuw nsw i64 %indvars.iv68, 1
  %cmp276 = icmp slt i64 %indvars.iv.next69, 16
  br i1 %cmp276, label %for.body.278, label %sw.epilog

sw.bb.325:                                        ; preds = %if.then.7
  %35 = bitcast i8* %3 to i64*
  %36 = load i64, i64* %35, align 8
  %call327 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.10, i64 0, i64 0), i64 %36) #6
  %sub.ptr.lhs.cast331 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub33315 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast331
  %sub336 = shl i64 %sub.ptr.sub33315, 32
  %sext14 = add i64 %sub336, 17592186044416
  %conv337 = ashr exact i64 %sext14, 32
  %call338 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv337) #6
  %call340 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr341 = getelementptr inbounds i8, i8* %bufp.043, i64 %call340
  %cmp343 = icmp ult i8* %add.ptr341, %arrayidx1
  br i1 %cmp343, label %sw.epilog, label %done

sw.bb.348:                                        ; preds = %if.then.7
  %incdec.ptr349 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp351 = icmp eq i8* %incdec.ptr349, %arrayidx1
  br i1 %cmp351, label %sw.epilog, label %for.cond.356.preheader

for.cond.356.preheader:                           ; preds = %sw.bb.348
  %37 = bitcast i8* %3 to i64*
  br label %for.body.359

for.body.359:                                     ; preds = %do.end.394, %for.cond.356.preheader
  %indvars.iv66 = phi i64 [ 0, %for.cond.356.preheader ], [ %indvars.iv.next67, %do.end.394 ]
  %bufp.632 = phi i8* [ %incdec.ptr349, %for.cond.356.preheader ], [ %incdec.ptr400, %do.end.394 ]
  %38 = phi i8* [ %bufp.043, %for.cond.356.preheader ], [ %add.ptr388, %do.end.394 ]
  %39 = trunc i64 %indvars.iv66 to i32
  %sh_prom360 = and i64 %indvars.iv66, 4294967295
  %shl361 = shl i64 1, %sh_prom360
  %and362 = and i64 %shl361, %mask
  %tobool363 = icmp eq i64 %and362, 0
  %arrayidx367 = getelementptr inbounds i64, i64* %37, i64 %indvars.iv66
  %40 = load i64, i64* %arrayidx367, align 8
  br i1 %tobool363, label %if.else.369, label %if.then.364

if.then.364:                                      ; preds = %for.body.359
  %call368 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.10, i64 0, i64 0), i64 %40) #6
  br label %do.body.375

if.else.369:                                      ; preds = %for.body.359
  %call373 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.11, i64 0, i64 0), i64 %40) #6
  br label %do.body.375

do.body.375:                                      ; preds = %if.else.369, %if.then.364
  %41 = getelementptr inbounds i8, i8* %38, i64 1
  %sub.ptr.lhs.cast378 = ptrtoint i8* %bufp.632 to i64
  store i8 0, i8* %bufp.632, align 1
  %sub.ptr.sub38013 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast378
  %sub383 = shl i64 %sub.ptr.sub38013, 32
  %sext12 = add i64 %sub383, 17592186044416
  %conv384 = ashr exact i64 %sext12, 32
  %call385 = call i8* @strncat(i8* %bufp.632, i8* %arraydecay, i64 %conv384) #6
  %call387 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr388 = getelementptr inbounds i8, i8* %41, i64 %call387
  %cmp390 = icmp ult i8* %add.ptr388, %arrayidx1
  br i1 %cmp390, label %do.end.394, label %done

do.end.394:                                       ; preds = %do.body.375
  %cmp396 = icmp ne i32 %39, 15
  %conv399 = select i1 %cmp396, i8 44, i8 93
  %incdec.ptr400 = getelementptr inbounds i8, i8* %add.ptr388, i64 1
  store i8 %conv399, i8* %add.ptr388, align 1
  %indvars.iv.next67 = add nuw nsw i64 %indvars.iv66, 1
  %cmp357 = icmp slt i64 %indvars.iv.next67, 16
  br i1 %cmp357, label %for.body.359, label %sw.epilog

sw.bb.404:                                        ; preds = %if.then.7
  %42 = bitcast i8* %3 to i64*
  %43 = load i64, i64* %42, align 8
  %call406 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.12, i64 0, i64 0), i64 %43) #6
  %sub.ptr.lhs.cast410 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub41211 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast410
  %sub415 = shl i64 %sub.ptr.sub41211, 32
  %sext10 = add i64 %sub415, 17592186044416
  %conv416 = ashr exact i64 %sext10, 32
  %call417 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv416) #6
  %call419 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr420 = getelementptr inbounds i8, i8* %bufp.043, i64 %call419
  %cmp422 = icmp ult i8* %add.ptr420, %arrayidx1
  br i1 %cmp422, label %sw.epilog, label %done

sw.bb.427:                                        ; preds = %if.then.7
  %incdec.ptr428 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp430 = icmp eq i8* %incdec.ptr428, %arrayidx1
  br i1 %cmp430, label %sw.epilog, label %for.cond.435.preheader

for.cond.435.preheader:                           ; preds = %sw.bb.427
  %44 = bitcast i8* %3 to i64*
  br label %for.body.438

for.body.438:                                     ; preds = %do.end.473, %for.cond.435.preheader
  %indvars.iv64 = phi i64 [ 0, %for.cond.435.preheader ], [ %indvars.iv.next65, %do.end.473 ]
  %bufp.729 = phi i8* [ %incdec.ptr428, %for.cond.435.preheader ], [ %incdec.ptr479, %do.end.473 ]
  %45 = phi i8* [ %bufp.043, %for.cond.435.preheader ], [ %add.ptr467, %do.end.473 ]
  %46 = trunc i64 %indvars.iv64 to i32
  %sh_prom439 = and i64 %indvars.iv64, 4294967295
  %shl440 = shl i64 1, %sh_prom439
  %and441 = and i64 %shl440, %mask
  %tobool442 = icmp eq i64 %and441, 0
  %arrayidx446 = getelementptr inbounds i64, i64* %44, i64 %indvars.iv64
  %47 = load i64, i64* %arrayidx446, align 8
  br i1 %tobool442, label %if.else.448, label %if.then.443

if.then.443:                                      ; preds = %for.body.438
  %call447 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.12, i64 0, i64 0), i64 %47) #6
  br label %do.body.454

if.else.448:                                      ; preds = %for.body.438
  %call452 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.13, i64 0, i64 0), i64 %47) #6
  br label %do.body.454

do.body.454:                                      ; preds = %if.else.448, %if.then.443
  %48 = getelementptr inbounds i8, i8* %45, i64 1
  %sub.ptr.lhs.cast457 = ptrtoint i8* %bufp.729 to i64
  store i8 0, i8* %bufp.729, align 1
  %sub.ptr.sub4599 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast457
  %sub462 = shl i64 %sub.ptr.sub4599, 32
  %sext8 = add i64 %sub462, 17592186044416
  %conv463 = ashr exact i64 %sext8, 32
  %call464 = call i8* @strncat(i8* %bufp.729, i8* %arraydecay, i64 %conv463) #6
  %call466 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr467 = getelementptr inbounds i8, i8* %48, i64 %call466
  %cmp469 = icmp ult i8* %add.ptr467, %arrayidx1
  br i1 %cmp469, label %do.end.473, label %done

do.end.473:                                       ; preds = %do.body.454
  %cmp475 = icmp ne i32 %46, 15
  %conv478 = select i1 %cmp475, i8 44, i8 93
  %incdec.ptr479 = getelementptr inbounds i8, i8* %add.ptr467, i64 1
  store i8 %conv478, i8* %add.ptr467, align 1
  %indvars.iv.next65 = add nuw nsw i64 %indvars.iv64, 1
  %cmp436 = icmp slt i64 %indvars.iv.next65, 16
  br i1 %cmp436, label %for.body.438, label %sw.epilog

sw.bb.483:                                        ; preds = %if.then.7
  %49 = bitcast i8* %3 to double*
  %50 = load double, double* %49, align 8
  %call485 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.8, i64 0, i64 0), double %50) #6
  %sub.ptr.lhs.cast489 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub4917 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast489
  %sub494 = shl i64 %sub.ptr.sub4917, 32
  %sext6 = add i64 %sub494, 17592186044416
  %conv495 = ashr exact i64 %sext6, 32
  %call496 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv495) #6
  %call498 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr499 = getelementptr inbounds i8, i8* %bufp.043, i64 %call498
  %cmp501 = icmp ult i8* %add.ptr499, %arrayidx1
  br i1 %cmp501, label %sw.epilog, label %done

sw.bb.506:                                        ; preds = %if.then.7
  %incdec.ptr507 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp509 = icmp eq i8* %incdec.ptr507, %arrayidx1
  br i1 %cmp509, label %sw.epilog, label %for.cond.514.preheader

for.cond.514.preheader:                           ; preds = %sw.bb.506
  %51 = bitcast i8* %3 to double*
  br label %for.body.517

for.body.517:                                     ; preds = %do.end.552, %for.cond.514.preheader
  %indvars.iv62 = phi i64 [ 0, %for.cond.514.preheader ], [ %indvars.iv.next63, %do.end.552 ]
  %bufp.827 = phi i8* [ %incdec.ptr507, %for.cond.514.preheader ], [ %incdec.ptr558, %do.end.552 ]
  %52 = phi i8* [ %bufp.043, %for.cond.514.preheader ], [ %add.ptr546, %do.end.552 ]
  %53 = trunc i64 %indvars.iv62 to i32
  %sh_prom518 = and i64 %indvars.iv62, 4294967295
  %shl519 = shl i64 1, %sh_prom518
  %and520 = and i64 %shl519, %mask
  %tobool521 = icmp eq i64 %and520, 0
  %arrayidx525 = getelementptr inbounds double, double* %51, i64 %indvars.iv62
  %54 = load double, double* %arrayidx525, align 8
  br i1 %tobool521, label %if.else.527, label %if.then.522

if.then.522:                                      ; preds = %for.body.517
  %call526 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.8, i64 0, i64 0), double %54) #6
  br label %do.body.533

if.else.527:                                      ; preds = %for.body.517
  %call531 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %54) #6
  br label %do.body.533

do.body.533:                                      ; preds = %if.else.527, %if.then.522
  %55 = getelementptr inbounds i8, i8* %52, i64 1
  %sub.ptr.lhs.cast536 = ptrtoint i8* %bufp.827 to i64
  store i8 0, i8* %bufp.827, align 1
  %sub.ptr.sub5385 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast536
  %sub541 = shl i64 %sub.ptr.sub5385, 32
  %sext4 = add i64 %sub541, 17592186044416
  %conv542 = ashr exact i64 %sext4, 32
  %call543 = call i8* @strncat(i8* %bufp.827, i8* %arraydecay, i64 %conv542) #6
  %call545 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr546 = getelementptr inbounds i8, i8* %55, i64 %call545
  %cmp548 = icmp ult i8* %add.ptr546, %arrayidx1
  br i1 %cmp548, label %do.end.552, label %done

do.end.552:                                       ; preds = %do.body.533
  %cmp554 = icmp ne i32 %53, 15
  %conv557 = select i1 %cmp554, i8 44, i8 93
  %incdec.ptr558 = getelementptr inbounds i8, i8* %add.ptr546, i64 1
  store i8 %conv557, i8* %add.ptr546, align 1
  %indvars.iv.next63 = add nuw nsw i64 %indvars.iv62, 1
  %cmp515 = icmp slt i64 %indvars.iv.next63, 16
  br i1 %cmp515, label %for.body.517, label %sw.epilog

sw.bb.562:                                        ; preds = %if.then.7
  %56 = bitcast i8* %3 to i8**
  %57 = load i8*, i8** %56, align 8
  %call564 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.14, i64 0, i64 0), i8* %57) #6
  %sub.ptr.lhs.cast568 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub5703 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast568
  %sub573 = shl i64 %sub.ptr.sub5703, 32
  %sext2 = add i64 %sub573, 17592186044416
  %conv574 = ashr exact i64 %sext2, 32
  %call575 = call i8* @strncat(i8* %bufp.043, i8* %arraydecay, i64 %conv574) #6
  %call577 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr578 = getelementptr inbounds i8, i8* %bufp.043, i64 %call577
  %cmp580 = icmp ult i8* %add.ptr578, %arrayidx1
  br i1 %cmp580, label %sw.epilog, label %done

sw.bb.585:                                        ; preds = %if.then.7
  %incdec.ptr586 = getelementptr inbounds i8, i8* %bufp.043, i64 1
  store i8 91, i8* %bufp.043, align 1
  %cmp588 = icmp eq i8* %incdec.ptr586, %arrayidx1
  br i1 %cmp588, label %sw.epilog, label %for.cond.593.preheader

for.cond.593.preheader:                           ; preds = %sw.bb.585
  %58 = bitcast i8* %3 to i8**
  br label %for.body.596

for.body.596:                                     ; preds = %do.end.631, %for.cond.593.preheader
  %indvars.iv = phi i64 [ 0, %for.cond.593.preheader ], [ %indvars.iv.next, %do.end.631 ]
  %bufp.925 = phi i8* [ %incdec.ptr586, %for.cond.593.preheader ], [ %incdec.ptr637, %do.end.631 ]
  %59 = phi i8* [ %bufp.043, %for.cond.593.preheader ], [ %add.ptr625, %do.end.631 ]
  %60 = trunc i64 %indvars.iv to i32
  %sh_prom597 = and i64 %indvars.iv, 4294967295
  %shl598 = shl i64 1, %sh_prom597
  %and599 = and i64 %shl598, %mask
  %tobool600 = icmp eq i64 %and599, 0
  %arrayidx604 = getelementptr inbounds i8*, i8** %58, i64 %indvars.iv
  %61 = load i8*, i8** %arrayidx604, align 8
  br i1 %tobool600, label %if.else.606, label %if.then.601

if.then.601:                                      ; preds = %for.body.596
  %call605 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.14, i64 0, i64 0), i8* %61) #6
  br label %do.body.612

if.else.606:                                      ; preds = %for.body.596
  %call610 = call i32 (i8*, i8*, ...) @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.15, i64 0, i64 0), i8* %61) #6
  br label %do.body.612

do.body.612:                                      ; preds = %if.else.606, %if.then.601
  %62 = getelementptr inbounds i8, i8* %59, i64 1
  %sub.ptr.lhs.cast615 = ptrtoint i8* %bufp.925 to i64
  store i8 0, i8* %bufp.925, align 1
  %sub.ptr.sub6171 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast615
  %sub620 = shl i64 %sub.ptr.sub6171, 32
  %sext = add i64 %sub620, 17592186044416
  %conv621 = ashr exact i64 %sext, 32
  %call622 = call i8* @strncat(i8* %bufp.925, i8* %arraydecay, i64 %conv621) #6
  %call624 = call i64 @strlen(i8* %arraydecay) #7
  %add.ptr625 = getelementptr inbounds i8, i8* %62, i64 %call624
  %cmp627 = icmp ult i8* %add.ptr625, %arrayidx1
  br i1 %cmp627, label %do.end.631, label %done

do.end.631:                                       ; preds = %do.body.612
  %cmp633 = icmp ne i32 %60, 15
  %conv636 = select i1 %cmp633, i8 44, i8 93
  %incdec.ptr637 = getelementptr inbounds i8, i8* %add.ptr625, i64 1
  store i8 %conv636, i8* %add.ptr625, align 1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %cmp594 = icmp slt i64 %indvars.iv.next, 16
  br i1 %cmp594, label %for.body.596, label %sw.epilog

do.body.641:                                      ; preds = %if.then.7
  %sub.ptr.lhs.cast644 = ptrtoint i8* %bufp.043 to i64
  store i8 0, i8* %bufp.043, align 1
  %sub.ptr.sub64637 = sub i64 %sub.ptr.rhs.cast645, %sub.ptr.lhs.cast644
  %sub648 = shl i64 %sub.ptr.sub64637, 32
  %sext36 = add i64 %sub648, 17592186044416
  %conv649 = ashr exact i64 %sext36, 32
  %call650 = call i8* @strncat(i8* %bufp.043, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.16, i64 0, i64 0), i64 %conv649) #6
  %add.ptr651 = getelementptr inbounds i8, i8* %bufp.043, i64 13
  %cmp653 = icmp ult i8* %add.ptr651, %arrayidx1
  br i1 %cmp653, label %do.end.657, label %done

do.end.657:                                       ; preds = %do.body.641
  %63 = load i8, i8* %types.addr.044, align 1
  %incdec.ptr658 = getelementptr inbounds i8, i8* %bufp.043, i64 14
  store i8 %63, i8* %add.ptr651, align 1
  br label %sw.epilog

sw.epilog:                                        ; preds = %do.end.657, %do.end.631, %sw.bb.585, %sw.bb.562, %do.end.552, %sw.bb.506, %sw.bb.483, %do.end.473, %sw.bb.427, %sw.bb.404, %do.end.394, %sw.bb.348, %sw.bb.325, %do.end.315, %sw.bb.267, %sw.bb.243, %do.end.233, %sw.bb.187, %sw.bb.164, %do.end.154, %sw.bb.108, %sw.bb.85, %if.end.77, %sw.bb.22, %sw.bb
  %bufp.10 = phi i8* [ %incdec.ptr658, %do.end.657 ], [ %arrayidx1, %sw.bb.585 ], [ %add.ptr578, %sw.bb.562 ], [ %arrayidx1, %sw.bb.506 ], [ %add.ptr499, %sw.bb.483 ], [ %arrayidx1, %sw.bb.427 ], [ %add.ptr420, %sw.bb.404 ], [ %arrayidx1, %sw.bb.348 ], [ %add.ptr341, %sw.bb.325 ], [ %arrayidx1, %sw.bb.267 ], [ %add.ptr260, %sw.bb.243 ], [ %arrayidx1, %sw.bb.187 ], [ %add.ptr180, %sw.bb.164 ], [ %arrayidx1, %sw.bb.108 ], [ %add.ptr101, %sw.bb.85 ], [ %arrayidx1, %sw.bb.22 ], [ %add.ptr, %sw.bb ], [ %incdec.ptr83, %if.end.77 ], [ %incdec.ptr160, %do.end.154 ], [ %incdec.ptr239, %do.end.233 ], [ %incdec.ptr321, %do.end.315 ], [ %incdec.ptr400, %do.end.394 ], [ %incdec.ptr479, %do.end.473 ], [ %incdec.ptr558, %do.end.552 ], [ %incdec.ptr637, %do.end.631 ]
  %incdec.ptr659 = getelementptr inbounds i8, i8* %types.addr.044, i64 1
  br label %if.end.661

if.end.661:                                       ; preds = %sw.epilog, %if.else, %if.then
  %argCount.1 = phi i32 [ %argCount.042, %if.then ], [ %inc, %sw.epilog ], [ %argCount.042, %if.else ]
  %bufp.11 = phi i8* [ %incdec.ptr, %if.then ], [ %bufp.10, %sw.epilog ], [ %bufp.043, %if.else ]
  %types.addr.1 = phi i8* [ %types.addr.044, %if.then ], [ %incdec.ptr659, %sw.epilog ], [ %types.addr.044, %if.else ]
  %incdec.ptr662 = getelementptr inbounds i8, i8* %format.addr.045, i64 1
  %64 = load i8, i8* %incdec.ptr662, align 1
  %tobool = icmp ne i8 %64, 0
  %cmp = icmp ult i8* %bufp.11, %arrayidx1
  %65 = and i1 %cmp, %tobool
  br i1 %65, label %while.body, label %done

done:                                             ; preds = %if.end.661, %do.body.641, %do.body.612, %sw.bb.562, %do.body.533, %sw.bb.483, %do.body.454, %sw.bb.404, %do.body.375, %sw.bb.325, %do.body.296, %sw.bb.243, %do.body.214, %sw.bb.164, %do.body.135, %sw.bb.85, %do.body.60, %if.then.32, %sw.bb, %entry
  %bufp.12 = phi i8* [ %add.ptr70, %do.body.60 ], [ %add.ptr52, %if.then.32 ], [ %add.ptr148, %do.body.135 ], [ %add.ptr227, %do.body.214 ], [ %add.ptr309, %do.body.296 ], [ %add.ptr388, %do.body.375 ], [ %add.ptr467, %do.body.454 ], [ %add.ptr546, %do.body.533 ], [ %add.ptr625, %do.body.612 ], [ %arrayidx, %entry ], [ %bufp.11, %if.end.661 ], [ %add.ptr578, %sw.bb.562 ], [ %add.ptr499, %sw.bb.483 ], [ %add.ptr420, %sw.bb.404 ], [ %add.ptr341, %sw.bb.325 ], [ %add.ptr260, %sw.bb.243 ], [ %add.ptr180, %sw.bb.164 ], [ %add.ptr101, %sw.bb.85 ], [ %add.ptr, %sw.bb ], [ %add.ptr651, %do.body.641 ]
  store i8 0, i8* %bufp.12, align 1
  %66 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call664 = call i32 @fputs(i8* %arrayidx, %struct._IO_FILE* %66) #6
  %67 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call665 = call i32 @fflush(%struct._IO_FILE* %67) #6
  ret void
}

; Function Attrs: nounwind
declare i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i8* @strncat(i8*, i8* nocapture readonly, i64) #1

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #2

; Function Attrs: nounwind
declare i32 @fputs(i8* nocapture readonly, %struct._IO_FILE* nocapture) #1

; Function Attrs: nounwind
declare i32 @fflush(%struct._IO_FILE* nocapture) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.x86.avx.movmsk.ps.256(<8 x float>) #3

; Function Attrs: nounwind readonly argmemonly
declare <8 x float> @llvm.x86.avx.maskload.ps.256(i8*, <8 x float>) #4

; Function Attrs: nounwind argmemonly
declare void @llvm.x86.avx.maskstore.ps.256(i8*, <8 x float>, <8 x float>) #5

; Function Attrs: nounwind readnone
declare <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float>, <8 x float>, <8 x float>) #3

; Function Attrs: nounwind
define void @ternary___vyivyiREFvyi(<16 x i32> %aa, <16 x i32> %bb, <16 x i32>* noalias nocapture %A, <16 x i32> %__mask) #6 {
allocas:
  %print_arg_ptrs = alloca [1 x i8*], align 32
  %print_arg = alloca <16 x i32>, align 64
  %print_arg_ptrs52 = alloca [1 x i8*], align 32
  %print_arg53 = alloca <16 x i32>, align 64
  %print_arg_ptrs79 = alloca [1 x i8*], align 32
  %print_arg80 = alloca <16 x i32>, align 64
  %print_arg_ptrs133 = alloca [1 x i8*], align 32
  %print_arg134 = alloca <16 x i32>, align 64
  %floatmask.i = bitcast <16 x i32> %__mask to <16 x float>
  %mask0.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v0.i = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask0.i) #3
  %mask1.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %v1.i = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask1.i) #3
  %v1shift.i = shl i32 %v1.i, 8
  %v.i = or i32 %v1shift.i, %v0.i
  %cmp.i = icmp eq i32 %v.i, 65535
  %notequal_bb_load_ = icmp ne <16 x i32> %bb, zeroinitializer
  %notequal_bb_load__to_boolvec = sext <16 x i1> %notequal_bb_load_ to <16 x i32>
  br i1 %cmp.i, label %all_on, label %some_on

all_on:                                           ; preds = %allocas
  %floatmask.i.144 = bitcast <16 x i32> %notequal_bb_load__to_boolvec to <16 x float>
  %mask0.i.145 = shufflevector <16 x float> %floatmask.i.144, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v0.i.146 = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask0.i.145) #3
  %mask1.i.147 = shufflevector <16 x float> %floatmask.i.144, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %v1.i.148 = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask1.i.147) #3
  %v1shift.i.149 = shl i32 %v1.i.148, 8
  %v.i.150 = or i32 %v1shift.i.149, %v0.i.146
  %cmp.i.151 = icmp ne i32 %v.i.150, 0
  br i1 %cmp.i.151, label %safe_if_run_true, label %safe_if_after_true

some_on:                                          ; preds = %allocas
  %0 = bitcast <16 x i32> %__mask to <16 x float>
  %floatmask.i.159 = select <16 x i1> %notequal_bb_load_, <16 x float> %0, <16 x float> zeroinitializer
  %mask0.i.160 = shufflevector <16 x float> %floatmask.i.159, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v0.i.161 = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask0.i.160) #3
  %mask1.i.162 = shufflevector <16 x float> %floatmask.i.159, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %v1.i.163 = tail call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask1.i.162) #3
  %v1shift.i.164 = shl i32 %v1.i.163, 8
  %v.i.165 = or i32 %v1shift.i.164, %v0.i.161
  %cmp.i.166 = icmp ne i32 %v.i.165, 0
  br i1 %cmp.i.166, label %safe_if_run_true68, label %safe_if_after_true67

if_done:                                          ; preds = %safe_if_run_false, %safe_if_after_true
  br i1 %cmp.i.151, label %select_eval_expr, label %select_done

safe_if_after_true:                               ; preds = %safe_if_run_true, %all_on
  %"~test" = xor <16 x i32> %notequal_bb_load__to_boolvec, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %floatmask.i.175 = bitcast <16 x i32> %"~test" to <16 x float>
  %mask0.i.176 = shufflevector <16 x float> %floatmask.i.175, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v0.i.177 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask0.i.176) #3
  %mask1.i.178 = shufflevector <16 x float> %floatmask.i.175, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %v1.i.179 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask1.i.178) #3
  %v1shift.i.180 = shl i32 %v1.i.179, 8
  %v.i.181 = or i32 %v1shift.i.180, %v0.i.177
  %cmp.i.182 = icmp eq i32 %v.i.181, 0
  br i1 %cmp.i.182, label %if_done, label %safe_if_run_false

safe_if_run_true:                                 ; preds = %all_on
  %mod_aa_load_bb_load11 = srem <16 x i32> %aa, %bb
  %ptr.i = bitcast <16 x i32>* %A to i8*
  %val.i = bitcast <16 x i32> %mod_aa_load_bb_load11 to <16 x float>
  %val0.i = shufflevector <16 x float> %val.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %val1.i = shufflevector <16 x float> %val.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr.i, <8 x float> %mask0.i.145, <8 x float> %val0.i) #6
  %ptr1.i = getelementptr i8, i8* %ptr.i, i64 32
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr1.i, <8 x float> %mask1.i.147, <8 x float> %val1.i) #6
  %print_arg_ptrs_bitcast = getelementptr inbounds [1 x i8*], [1 x i8*]* %print_arg_ptrs, i64 0, i64 0
  %A_load14_load = load <16 x i32>, <16 x i32>* %A, align 1
  store <16 x i32> %A_load14_load, <16 x i32>* %print_arg, align 64
  %1 = bitcast [1 x i8*]* %print_arg_ptrs to <16 x i32>**
  store <16 x i32>* %print_arg, <16 x i32>** %1, align 32
  %v64.i.206 = zext i32 %v.i.150 to i64
  call fastcc void @__do_print(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @__str.1, i64 0, i64 0), i64 %v64.i.206, i8** %print_arg_ptrs_bitcast)
  br label %safe_if_after_true

safe_if_run_false:                                ; preds = %safe_if_after_true
  %ptr.i.217 = bitcast <16 x i32>* %A to i8*
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr.i.217, <8 x float> %mask0.i.176, <8 x float> zeroinitializer) #6
  %ptr1.i.221 = getelementptr i8, i8* %ptr.i.217, i64 32
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr1.i.221, <8 x float> %mask1.i.178, <8 x float> zeroinitializer) #6
  %v64.i.214 = zext i32 %v.i.181 to i64
  call fastcc void @__do_print(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @__str.2, i64 0, i64 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @__str.3, i64 0, i64 0), i64 %v64.i.214, i8** null)
  br label %if_done

select_eval_expr:                                 ; preds = %if_done
  %mod_aa_load41_bb_load42 = srem <16 x i32> %aa, %bb
  %phitmp257 = bitcast <16 x i32> %mod_aa_load41_bb_load42 to <16 x float>
  br label %select_done

select_done:                                      ; preds = %select_eval_expr, %if_done
  %.0143 = phi <16 x float> [ %phitmp257, %select_eval_expr ], [ undef, %if_done ]
  %new0.i.237 = shufflevector <16 x float> %.0143, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %new1.i.238 = shufflevector <16 x float> %.0143, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %blend0.i.241 = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new0.i.237, <8 x float> %mask0.i.145) #6
  %blend1.i.242 = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new1.i.238, <8 x float> %mask1.i.147) #6
  %blend.i.243 = shufflevector <8 x float> %blend0.i.241, <8 x float> %blend1.i.242, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %2 = bitcast <16 x i32>* %A to <16 x float>*
  store <16 x float> %blend.i.243, <16 x float>* %2, align 4
  %print_arg_ptrs52_bitcast = getelementptr inbounds [1 x i8*], [1 x i8*]* %print_arg_ptrs52, i64 0, i64 0
  %3 = bitcast <16 x i32>* %print_arg53 to <16 x float>*
  store <16 x float> %blend.i.243, <16 x float>* %3, align 64
  %4 = bitcast [1 x i8*]* %print_arg_ptrs52 to <16 x i32>**
  store <16 x i32>* %print_arg53, <16 x i32>** %4, align 32
  call fastcc void @__do_print(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @__str.4, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @__str.5, i64 0, i64 0), i64 65535, i8** %print_arg_ptrs52_bitcast)
  ret void

if_done66:                                        ; preds = %safe_if_run_false89, %safe_if_after_true67
  br i1 %cmp.i.166, label %select_eval_expr113, label %select_done114

safe_if_after_true67:                             ; preds = %safe_if_run_true68, %some_on
  %5 = bitcast <16 x i32> %__mask to <16 x float>
  %floatmask.i.191 = select <16 x i1> %notequal_bb_load_, <16 x float> zeroinitializer, <16 x float> %5
  %mask0.i.192 = shufflevector <16 x float> %floatmask.i.191, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v0.i.193 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask0.i.192) #3
  %mask1.i.194 = shufflevector <16 x float> %floatmask.i.191, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %v1.i.195 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %mask1.i.194) #3
  %v1shift.i.196 = shl i32 %v1.i.195, 8
  %v.i.197 = or i32 %v1shift.i.196, %v0.i.193
  %cmp.i.198 = icmp eq i32 %v.i.197, 0
  br i1 %cmp.i.198, label %if_done66, label %safe_if_run_false89

safe_if_run_true68:                               ; preds = %some_on
  %mod_aa_load75_bb_load76 = srem <16 x i32> %aa, %bb
  %ptr.i.249 = bitcast <16 x i32>* %A to i8*
  %val.i.250 = bitcast <16 x i32> %mod_aa_load75_bb_load76 to <16 x float>
  %val0.i.252 = shufflevector <16 x float> %val.i.250, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %val1.i.253 = shufflevector <16 x float> %val.i.250, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr.i.249, <8 x float> %mask0.i.160, <8 x float> %val0.i.252) #6
  %ptr1.i.256 = getelementptr i8, i8* %ptr.i.249, i64 32
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr1.i.256, <8 x float> %mask1.i.162, <8 x float> %val1.i.253) #6
  %print_arg_ptrs79_bitcast = getelementptr inbounds [1 x i8*], [1 x i8*]* %print_arg_ptrs79, i64 0, i64 0
  %A_load81_load = load <16 x i32>, <16 x i32>* %A, align 1
  store <16 x i32> %A_load81_load, <16 x i32>* %print_arg80, align 64
  %6 = bitcast [1 x i8*]* %print_arg_ptrs79 to <16 x i32>**
  store <16 x i32>* %print_arg80, <16 x i32>** %6, align 32
  %v64.i.190 = zext i32 %v.i.165 to i64
  call fastcc void @__do_print(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__str.6, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @__str.7, i64 0, i64 0), i64 %v64.i.190, i8** %print_arg_ptrs79_bitcast)
  br label %safe_if_after_true67

safe_if_run_false89:                              ; preds = %safe_if_after_true67
  %ptr.i.244 = bitcast <16 x i32>* %A to i8*
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr.i.244, <8 x float> %mask0.i.192, <8 x float> zeroinitializer) #6
  %ptr1.i.248 = getelementptr i8, i8* %ptr.i.244, i64 32
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr1.i.248, <8 x float> %mask1.i.194, <8 x float> zeroinitializer) #6
  %v64.i.174 = zext i32 %v.i.197 to i64
  call fastcc void @__do_print(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @__str.8, i64 0, i64 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @__str.9, i64 0, i64 0), i64 %v64.i.174, i8** null)
  br label %if_done66

select_eval_expr113:                              ; preds = %if_done66
  %mod_aa_load119_bb_load120 = srem <16 x i32> %aa, %bb
  %phitmp = bitcast <16 x i32> %mod_aa_load119_bb_load120 to <16 x float>
  br label %select_done114

select_done114:                                   ; preds = %select_eval_expr113, %if_done66
  %.0 = phi <16 x float> [ %phitmp, %select_eval_expr113 ], [ undef, %if_done66 ]
  %maskAsFloat.i = bitcast <16 x i32> %notequal_bb_load__to_boolvec to <16 x float>
  %new0.i = shufflevector <16 x float> %.0, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %new1.i = shufflevector <16 x float> %.0, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %mask0.i.230 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mask1.i.231 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %blend0.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new0.i, <8 x float> %mask0.i.230) #6
  %blend1.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new1.i, <8 x float> %mask1.i.231) #6
  %ptr.i.222 = bitcast <16 x i32>* %A to i8*
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr.i.222, <8 x float> %mask0.i, <8 x float> %blend0.i) #6
  %ptr1.i.229 = getelementptr i8, i8* %ptr.i.222, i64 32
  call void @llvm.x86.avx.maskstore.ps.256(i8* %ptr1.i.229, <8 x float> %mask1.i, <8 x float> %blend1.i) #6
  %print_arg_ptrs133_bitcast = getelementptr inbounds [1 x i8*], [1 x i8*]* %print_arg_ptrs133, i64 0, i64 0
  %A_load135_load = load <16 x i32>, <16 x i32>* %A, align 1
  store <16 x i32> %A_load135_load, <16 x i32>* %print_arg134, align 64
  %7 = bitcast [1 x i8*]* %print_arg_ptrs133 to <16 x i32>**
  store <16 x i32>* %print_arg134, <16 x i32>** %7, align 32
  %v64.i = zext i32 %v.i to i64
  call fastcc void @__do_print(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @__str.10, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @__str.11, i64 0, i64 0), i64 %v64.i, i8** %print_arg_ptrs133_bitcast)
  ret void
}

; Function Attrs: nounwind
define i32 @test_ternary___un_3C_uni_3E_un_3C_uni_3E_uni(i32* noalias %a, i32* noalias %b, i32 %size, <16 x i32> %__mask) #6 {
allocas:
  %A = alloca <16 x i32>, align 64
  %A55 = alloca <16 x i32>, align 64
  %nextras = srem i32 %size, 16
  %aligned_end = sub i32 %size, %nextras
  %before_aligned_end16.142 = icmp sgt i32 %aligned_end, 0
  br i1 %before_aligned_end16.142, label %foreach_full_body.lr.ph, label %partial_inner_all_outer

foreach_full_body.lr.ph:                          ; preds = %allocas
  %a_load_ptr2int_2void = bitcast i32* %a to i8*
  %b_load_ptr2int_2void = bitcast i32* %b to i8*
  br label %foreach_full_body

foreach_full_body:                                ; preds = %foreach_full_body, %foreach_full_body.lr.ph
  %counter.1144 = phi i32 [ 0, %foreach_full_body.lr.ph ], [ %new_counter, %foreach_full_body ]
  %result.2143 = phi i32 [ undef, %foreach_full_body.lr.ph ], [ %add_result_load_calltmp_to_int32, %foreach_full_body ]
  %shl_smear_counter21_.elt0 = shl i32 %counter.1144, 2
  %0 = sext i32 %shl_smear_counter21_.elt0 to i64
  %ptr = getelementptr i8, i8* %a_load_ptr2int_2void, i64 %0, !filename !1, !first_line !2, !first_column !3, !last_line !2, !last_column !4
  %ptr_cast_for_load = bitcast i8* %ptr to <16 x i32>*
  %ptr_masked_load.90 = load <16 x i32>, <16 x i32>* %ptr_cast_for_load, align 4, !filename !1, !first_line !2, !first_column !3, !last_line !2, !last_column !4
  %ptr98 = getelementptr i8, i8* %b_load_ptr2int_2void, i64 %0, !filename !1, !first_line !2, !first_column !5, !last_line !2, !last_column !6
  %ptr_cast_for_load99 = bitcast i8* %ptr98 to <16 x i32>*
  %ptr98_masked_load.100 = load <16 x i32>, <16 x i32>* %ptr_cast_for_load99, align 4, !filename !1, !first_line !2, !first_column !5, !last_line !2, !last_column !6
  call void @ternary___vyivyiREFvyi(<16 x i32> %ptr_masked_load.90, <16 x i32> %ptr98_masked_load.100, <16 x i32>* nonnull %A, <16 x i32> <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>)
  %A_load = load <16 x i32>, <16 x i32>* %A, align 64
  %v1.i.i = shufflevector <16 x i32> %A_load, <16 x i32> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.i.i = add <16 x i32> %v1.i.i, %A_load
  %v2.i.i = shufflevector <16 x i32> %s.i.i.i, <16 x i32> undef, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.3.i.i = add <16 x i32> %v2.i.i, %s.i.i.i
  %v3.i.i = shufflevector <16 x i32> %s.i.3.i.i, <16 x i32> undef, <16 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.2.i.i = add <16 x i32> %v3.i.i, %s.i.3.i.i
  %m3a.i.i = extractelement <16 x i32> %s.i.2.i.i, i32 0
  %m3b.i.i = extractelement <16 x i32> %s.i.2.i.i, i32 1
  %s.i.1.i.i = add i32 %m3a.i.i, %result.2143
  %add_result_load_calltmp_to_int32 = add i32 %s.i.1.i.i, %m3b.i.i
  %new_counter = add i32 %counter.1144, 16
  %before_aligned_end16 = icmp slt i32 %new_counter, %aligned_end
  br i1 %before_aligned_end16, label %foreach_full_body, label %partial_inner_all_outer

foreach_reset:                                    ; preds = %partial_inner_only, %partial_inner_all_outer
  %result.1 = phi i32 [ %add_result_load75_calltmp73_to_int32, %partial_inner_only ], [ %result.2.lcssa, %partial_inner_all_outer ]
  ret i32 %result.1

partial_inner_all_outer:                          ; preds = %foreach_full_body, %allocas
  %counter.1.lcssa = phi i32 [ 0, %allocas ], [ %new_counter, %foreach_full_body ]
  %result.2.lcssa = phi i32 [ undef, %allocas ], [ %add_result_load_calltmp_to_int32, %foreach_full_body ]
  %before_full_end = icmp slt i32 %counter.1.lcssa, %size
  br i1 %before_full_end, label %partial_inner_only, label %foreach_reset

partial_inner_only:                               ; preds = %partial_inner_all_outer
  %smear_counter_init45 = insertelement <16 x i32> undef, i32 %counter.1.lcssa, i32 0
  %smear_counter46 = shufflevector <16 x i32> %smear_counter_init45, <16 x i32> undef, <16 x i32> zeroinitializer
  %iter_val.47 = add <16 x i32> %smear_counter46, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %smear_end_init48 = insertelement <16 x i32> undef, i32 %size, i32 0
  %smear_end49 = shufflevector <16 x i32> %smear_end_init48, <16 x i32> undef, <16 x i32> zeroinitializer
  %cmp50 = icmp slt <16 x i32> %iter_val.47, %smear_end49
  %cmp50_to_boolvec = sext <16 x i1> %cmp50 to <16 x i32>
  %mul__i_load56.elt0 = shl i32 %counter.1.lcssa, 2
  %a_load57_ptr2int_2void = bitcast i32* %a to i8*
  %1 = sext i32 %mul__i_load56.elt0 to i64
  %ptr105 = getelementptr i8, i8* %a_load57_ptr2int_2void, i64 %1
  %floatmask.i = bitcast <16 x i32> %cmp50_to_boolvec to <16 x float>
  %mask0.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %val0.i = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr105, <8 x float> %mask0.i) #6
  %mask1.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ptr1.i = getelementptr i8, i8* %ptr105, i64 32
  %val1.i = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr1.i, <8 x float> %mask1.i) #6
  %retval.i = shufflevector <8 x float> %val0.i, <8 x float> %val1.i, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %reti32.i = bitcast <16 x float> %retval.i to <16 x i32>
  %b_load63_ptr2int_2void = bitcast i32* %b to i8*
  %ptr118 = getelementptr i8, i8* %b_load63_ptr2int_2void, i64 %1
  %val0.i.133 = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr118, <8 x float> %mask0.i) #6
  %ptr1.i.135 = getelementptr i8, i8* %ptr118, i64 32
  %val1.i.136 = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr1.i.135, <8 x float> %mask1.i) #6
  %retval.i.137 = shufflevector <8 x float> %val0.i.133, <8 x float> %val1.i.136, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %reti32.i.138 = bitcast <16 x float> %retval.i.137 to <16 x i32>
  call void @ternary___vyivyiREFvyi(<16 x i32> %reti32.i, <16 x i32> %reti32.i.138, <16 x i32>* nonnull %A55, <16 x i32> %cmp50_to_boolvec)
  %2 = bitcast <16 x i32>* %A55 to <16 x float>*
  %A_load70141 = load <16 x float>, <16 x float>* %2, align 64
  %__mask_load_to_bool.i = icmp ne <16 x i32> %cmp50_to_boolvec, zeroinitializer
  %__mask_load_to_bool_to_boolvec.i = sext <16 x i1> %__mask_load_to_bool.i to <16 x i32>
  %maskAsFloat.i = bitcast <16 x i32> %__mask_load_to_bool_to_boolvec.i to <16 x float>
  %new0.i = shufflevector <16 x float> %A_load70141, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %new1.i = shufflevector <16 x float> %A_load70141, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %mask0.i.139 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mask1.i.140 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %blend0.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new0.i, <8 x float> %mask0.i.139) #6
  %blend1.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new1.i, <8 x float> %mask1.i.140) #6
  %blend.i = shufflevector <8 x float> %blend0.i, <8 x float> %blend1.i, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = bitcast <16 x float> %blend.i to <16 x i32>
  %v1.i.i.121 = shufflevector <16 x i32> %3, <16 x i32> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.i.i.122 = add <16 x i32> %v1.i.i.121, %3
  %v2.i.i.123 = shufflevector <16 x i32> %s.i.i.i.122, <16 x i32> undef, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.3.i.i.124 = add <16 x i32> %v2.i.i.123, %s.i.i.i.122
  %v3.i.i.125 = shufflevector <16 x i32> %s.i.3.i.i.124, <16 x i32> undef, <16 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.2.i.i.126 = add <16 x i32> %v3.i.i.125, %s.i.3.i.i.124
  %m3a.i.i.127 = extractelement <16 x i32> %s.i.2.i.i.126, i32 0
  %m3b.i.i.128 = extractelement <16 x i32> %s.i.2.i.i.126, i32 1
  %s.i.1.i.i.129 = add i32 %m3a.i.i.127, %result.2.lcssa
  %add_result_load75_calltmp73_to_int32 = add i32 %s.i.1.i.i.129, %m3b.i.i.128
  br label %foreach_reset
}

; Function Attrs: nounwind
define i32 @test_ternary(i32* noalias %a, i32* noalias %b, i32 %size) #6 {
allocas:
  %A = alloca <16 x i32>, align 64
  %A55 = alloca <16 x i32>, align 64
  %nextras = srem i32 %size, 16
  %aligned_end = sub i32 %size, %nextras
  %before_aligned_end16.142 = icmp sgt i32 %aligned_end, 0
  br i1 %before_aligned_end16.142, label %foreach_full_body.lr.ph, label %partial_inner_all_outer

foreach_full_body.lr.ph:                          ; preds = %allocas
  %a_load_ptr2int_2void = bitcast i32* %a to i8*
  %b_load_ptr2int_2void = bitcast i32* %b to i8*
  br label %foreach_full_body

foreach_full_body:                                ; preds = %foreach_full_body, %foreach_full_body.lr.ph
  %counter.1144 = phi i32 [ 0, %foreach_full_body.lr.ph ], [ %new_counter, %foreach_full_body ]
  %result.2143 = phi i32 [ undef, %foreach_full_body.lr.ph ], [ %add_result_load_calltmp_to_int32, %foreach_full_body ]
  %shl_smear_counter21_.elt0 = shl i32 %counter.1144, 2
  %0 = sext i32 %shl_smear_counter21_.elt0 to i64
  %ptr = getelementptr i8, i8* %a_load_ptr2int_2void, i64 %0, !filename !1, !first_line !2, !first_column !3, !last_line !2, !last_column !4
  %ptr_cast_for_load = bitcast i8* %ptr to <16 x i32>*
  %ptr_masked_load.90 = load <16 x i32>, <16 x i32>* %ptr_cast_for_load, align 4, !filename !1, !first_line !2, !first_column !3, !last_line !2, !last_column !4
  %ptr98 = getelementptr i8, i8* %b_load_ptr2int_2void, i64 %0, !filename !1, !first_line !2, !first_column !5, !last_line !2, !last_column !6
  %ptr_cast_for_load99 = bitcast i8* %ptr98 to <16 x i32>*
  %ptr98_masked_load.100 = load <16 x i32>, <16 x i32>* %ptr_cast_for_load99, align 4, !filename !1, !first_line !2, !first_column !5, !last_line !2, !last_column !6
  call void @ternary___vyivyiREFvyi(<16 x i32> %ptr_masked_load.90, <16 x i32> %ptr98_masked_load.100, <16 x i32>* nonnull %A, <16 x i32> <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>)
  %A_load = load <16 x i32>, <16 x i32>* %A, align 64
  %v1.i.i = shufflevector <16 x i32> %A_load, <16 x i32> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.i.i = add <16 x i32> %v1.i.i, %A_load
  %v2.i.i = shufflevector <16 x i32> %s.i.i.i, <16 x i32> undef, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.3.i.i = add <16 x i32> %v2.i.i, %s.i.i.i
  %v3.i.i = shufflevector <16 x i32> %s.i.3.i.i, <16 x i32> undef, <16 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.2.i.i = add <16 x i32> %v3.i.i, %s.i.3.i.i
  %m3a.i.i = extractelement <16 x i32> %s.i.2.i.i, i32 0
  %m3b.i.i = extractelement <16 x i32> %s.i.2.i.i, i32 1
  %s.i.1.i.i = add i32 %m3a.i.i, %result.2143
  %add_result_load_calltmp_to_int32 = add i32 %s.i.1.i.i, %m3b.i.i
  %new_counter = add i32 %counter.1144, 16
  %before_aligned_end16 = icmp slt i32 %new_counter, %aligned_end
  br i1 %before_aligned_end16, label %foreach_full_body, label %partial_inner_all_outer

foreach_reset:                                    ; preds = %partial_inner_only, %partial_inner_all_outer
  %result.1 = phi i32 [ %add_result_load75_calltmp73_to_int32, %partial_inner_only ], [ %result.2.lcssa, %partial_inner_all_outer ]
  ret i32 %result.1

partial_inner_all_outer:                          ; preds = %foreach_full_body, %allocas
  %counter.1.lcssa = phi i32 [ 0, %allocas ], [ %new_counter, %foreach_full_body ]
  %result.2.lcssa = phi i32 [ undef, %allocas ], [ %add_result_load_calltmp_to_int32, %foreach_full_body ]
  %before_full_end = icmp slt i32 %counter.1.lcssa, %size
  br i1 %before_full_end, label %partial_inner_only, label %foreach_reset

partial_inner_only:                               ; preds = %partial_inner_all_outer
  %smear_counter_init45 = insertelement <16 x i32> undef, i32 %counter.1.lcssa, i32 0
  %smear_counter46 = shufflevector <16 x i32> %smear_counter_init45, <16 x i32> undef, <16 x i32> zeroinitializer
  %iter_val.47 = add <16 x i32> %smear_counter46, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %smear_end_init48 = insertelement <16 x i32> undef, i32 %size, i32 0
  %smear_end49 = shufflevector <16 x i32> %smear_end_init48, <16 x i32> undef, <16 x i32> zeroinitializer
  %cmp50 = icmp slt <16 x i32> %iter_val.47, %smear_end49
  %cmp50_to_boolvec = sext <16 x i1> %cmp50 to <16 x i32>
  %mul__i_load56.elt0 = shl i32 %counter.1.lcssa, 2
  %a_load57_ptr2int_2void = bitcast i32* %a to i8*
  %1 = sext i32 %mul__i_load56.elt0 to i64
  %ptr105 = getelementptr i8, i8* %a_load57_ptr2int_2void, i64 %1
  %floatmask.i = bitcast <16 x i32> %cmp50_to_boolvec to <16 x float>
  %mask0.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %val0.i = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr105, <8 x float> %mask0.i) #6
  %mask1.i = shufflevector <16 x float> %floatmask.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ptr1.i = getelementptr i8, i8* %ptr105, i64 32
  %val1.i = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr1.i, <8 x float> %mask1.i) #6
  %retval.i = shufflevector <8 x float> %val0.i, <8 x float> %val1.i, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %reti32.i = bitcast <16 x float> %retval.i to <16 x i32>
  %b_load63_ptr2int_2void = bitcast i32* %b to i8*
  %ptr118 = getelementptr i8, i8* %b_load63_ptr2int_2void, i64 %1
  %val0.i.133 = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr118, <8 x float> %mask0.i) #6
  %ptr1.i.135 = getelementptr i8, i8* %ptr118, i64 32
  %val1.i.136 = tail call <8 x float> @llvm.x86.avx.maskload.ps.256(i8* %ptr1.i.135, <8 x float> %mask1.i) #6
  %retval.i.137 = shufflevector <8 x float> %val0.i.133, <8 x float> %val1.i.136, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %reti32.i.138 = bitcast <16 x float> %retval.i.137 to <16 x i32>
  call void @ternary___vyivyiREFvyi(<16 x i32> %reti32.i, <16 x i32> %reti32.i.138, <16 x i32>* nonnull %A55, <16 x i32> %cmp50_to_boolvec)
  %2 = bitcast <16 x i32>* %A55 to <16 x float>*
  %A_load70141 = load <16 x float>, <16 x float>* %2, align 64
  %__mask_load_to_bool.i = icmp ne <16 x i32> %cmp50_to_boolvec, zeroinitializer
  %__mask_load_to_bool_to_boolvec.i = sext <16 x i1> %__mask_load_to_bool.i to <16 x i32>
  %maskAsFloat.i = bitcast <16 x i32> %__mask_load_to_bool_to_boolvec.i to <16 x float>
  %new0.i = shufflevector <16 x float> %A_load70141, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %new1.i = shufflevector <16 x float> %A_load70141, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %mask0.i.139 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mask1.i.140 = shufflevector <16 x float> %maskAsFloat.i, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %blend0.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new0.i, <8 x float> %mask0.i.139) #6
  %blend1.i = call <8 x float> @llvm.x86.avx.blendv.ps.256(<8 x float> zeroinitializer, <8 x float> %new1.i, <8 x float> %mask1.i.140) #6
  %blend.i = shufflevector <8 x float> %blend0.i, <8 x float> %blend1.i, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = bitcast <16 x float> %blend.i to <16 x i32>
  %v1.i.i.121 = shufflevector <16 x i32> %3, <16 x i32> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.i.i.122 = add <16 x i32> %v1.i.i.121, %3
  %v2.i.i.123 = shufflevector <16 x i32> %s.i.i.i.122, <16 x i32> undef, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.3.i.i.124 = add <16 x i32> %v2.i.i.123, %s.i.i.i.122
  %v3.i.i.125 = shufflevector <16 x i32> %s.i.3.i.i.124, <16 x i32> undef, <16 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %s.i.2.i.i.126 = add <16 x i32> %v3.i.i.125, %s.i.3.i.i.124
  %m3a.i.i.127 = extractelement <16 x i32> %s.i.2.i.i.126, i32 0
  %m3b.i.i.128 = extractelement <16 x i32> %s.i.2.i.i.126, i32 1
  %s.i.1.i.i.129 = add i32 %m3a.i.i.127, %result.2.lcssa
  %add_result_load75_calltmp73_to_int32 = add i32 %s.i.1.i.i.129, %m3b.i.i.128
  br label %foreach_reset
}

; Function Attrs: nounwind argmemonly
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #5

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind readonly argmemonly }
attributes #5 = { nounwind argmemonly }
attributes #6 = { nounwind }
attributes #7 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (trunk 246488)"}
!1 = !{!"case.ispc"}
!2 = !{i32 37}
!3 = !{i32 18}
!4 = !{i32 22}
!5 = !{i32 24}
!6 = !{i32 28}
