TASK_CXX=../tasksys.cpp
TASK_LIB=-lpthread
TASK_OBJ=objs_knl/tasksys.o

CXX=icc -m64 -xMIC-AVX512
CXXFLAGS+=-Iobjs_knl/ -O2 -I../ -I../util  -I./
CC=icc -m64 -xMIC-AVX512
CCFLAGS+= -Iobjs_knl/ -O2 -I../ -I../util -I./

LD=icc -m64 -xMIC-AVX512

LIBS=-lm $(TASK_LIB) -lstdc++
ISPC=ispc
ISPC_FLAGS+=-O2 --arch=x86-64 
ISPC_FLAGS+= --target=$(ISPC_TARGET) --c++-include-file=$(ISPC_INTRINSICS)

ISPC_HEADERS=$(ISPC_SRC:%.ispc=objs_knl/%_ispc.h)
ISPC_OBJ=$(ISPC_SRC:%.ispc=objs_knl/%_ispc.o)
CXX_OBJ=$(CXX_SRC:%.cpp=objs_knl/%.o)
CXX_OBJ+=$(TASK_OBJ)

PROG=$(EXAMPLE)_knl

all: dirs $(PROG)

dirs:
	/bin/mkdir -p objs_knl/

objs_knl/%.cpp objs_knl/%.o objs_knl/%.h: dirs

clean: 
	/bin/rm -rf $(PROG) objs_knl

$(PROG): $(ISPC_OBJ) $(CXX_OBJ) 
	$(LD) -o $@ $^ $(LDFLAGS) $(LIBS)

objs_knl/%.o: %.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<

objs_knl/%.o: ../%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<
objs_knl/%.o: ../../%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<
objs_knl/%.o: ../../util/%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<

objs_knl/%_ispc.o: %.ispc
	$(ISPC) $(ISPC_FLAGS) --emit-c++ -o objs_knl/$*_ispc_knl.cpp -h objs_knl/$*_ispc.h $< 
	$(CXX) $(CXXFLAGS) -o $@ objs_knl/$*_ispc_knl.cpp  -c

